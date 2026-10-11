SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-11: нова категорія «Кібербезпека» / «Cybersecurity» (slug cybersecurity)
-- з підкатегоріями:
--   * Менеджери паролів / Password Managers (slug password-managers)
--   * VPN і приватність / VPN & Privacy (slug vpn-privacy)
--   * Антивіруси та захист пристроїв / Antivirus & Device Protection (slug device-protection)
--   * Захист особистих даних / Identity & Data Protection (slug identity-protection)
--   * Безпека бізнесу / Business Security (slug business-security)
--   * Безпека коду та застосунків / Application Security (slug appsec)
-- + 56 нових продуктів + прив'язка наявних.
-- Тексти, функції й тарифи (UA + EN) — лише з офіційних сайтів, звірено 2026-10-11. Невідомі ціни — NULL з поясненням,
-- ціни не в USD — NULL, точна сума в описі плану.
-- Не включено свідомо: продукти компаній з РФ (Kaspersky тощо); Microsoft Defender (офіційна сторінка недоступна для перевірки).
-- Назви-кандидати взято з відкритих списків і каталогів; тексти написано заново з офіційних сайтів, без копіювання чужих описів.
-- Прив'язуються наявні (тексти не змінюються): Snyk
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт» (файл .sql або .sql.zip). Повторний запуск безпечний.
--   1Password — Менеджери паролів
--   Bitwarden — Менеджери паролів
--   Dashlane — Менеджери паролів
--   LastPass — Менеджери паролів
--   Proton Pass — Менеджери паролів
--   Keeper — Менеджери паролів
--   NordPass — Менеджери паролів
--   RoboForm — Менеджери паролів
--   KeePassXC — Менеджери паролів
--   Enpass — Менеджери паролів
--   NordVPN — VPN і приватність
--   Proton VPN — VPN і приватність
--   Surfshark — VPN і приватність
--   ExpressVPN — VPN і приватність
--   Mullvad VPN — VPN і приватність
--   Proton Mail — VPN і приватність
--   Tuta — VPN і приватність
--   Brave — VPN і приватність
--   DuckDuckGo — VPN і приватність
--   Malwarebytes — Антивіруси та захист пристроїв
--   ESET — Антивіруси та захист пристроїв
--   Bitdefender — Антивіруси та захист пристроїв
--   Norton 360 — Антивіруси та захист пристроїв
--   Avast — Антивіруси та захист пристроїв
--   Sophos Home — Антивіруси та захист пристроїв
--   F-Secure Total — Антивіруси та захист пристроїв
--   Avira — Антивіруси та захист пристроїв
--   Have I Been Pwned — Захист особистих даних
--   Aura — Захист особистих даних
--   DeleteMe — Захист особистих даних
--   Incogni — Захист особистих даних
--   Optery — Захист особистих даних
--   Mozilla Monitor — Захист особистих даних
--   CrowdStrike Falcon — Безпека бізнесу
--   SentinelOne Singularity — Безпека бізнесу
--   Darktrace — Безпека бізнесу
--   Microsoft Security Copilot — Безпека бізнесу
--   Cortex XSIAM — Безпека бізнесу
--   Abnormal AI — Безпека бізнесу
--   Wiz Cloud Security — Безпека бізнесу
--   Okta — Безпека бізнесу
--   Cloudflare One — Безпека бізнесу
--   Tailscale — Безпека бізнесу
--   Vanta — Безпека бізнесу
--   Drata — Безпека бізнесу
--   Huntress — Безпека бізнесу
--   Google Security Operations — Безпека бізнесу
--   Semgrep — Безпека коду та застосунків
--   Socket — Безпека коду та застосунків
--   Burp Suite — Безпека коду та застосунків
--   GitHub Advanced Security — Безпека коду та застосунків
--   Checkmarx One — Безпека коду та застосунків
--   Aikido Security — Безпека коду та застосунків
--   GitGuardian — Безпека коду та застосунків
--   ZAP — Безпека коду та застосунків
--   Veracode — Безпека коду та застосунків
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
INSERT INTO `categories` (`name`, `name_en`, `slug`) SELECT 'Кібербезпека', 'Cybersecurity', 'cybersecurity' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `categories` WHERE `slug` = 'cybersecurity');
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'cybersecurity' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Менеджери паролів', 'Password Managers', 'password-managers' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'password-managers');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'VPN і приватність', 'VPN & Privacy', 'vpn-privacy' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vpn-privacy');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Антивіруси та захист пристроїв', 'Antivirus & Device Protection', 'device-protection' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'device-protection');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Захист особистих даних', 'Identity & Data Protection', 'identity-protection' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'identity-protection');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Безпека бізнесу', 'Business Security', 'business-security' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'business-security');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Безпека коду та застосунків', 'Application Security', 'appsec' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'appsec');

-- =================== Менеджери паролів / Password Managers ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'password-managers' LIMIT 1);

-- 1Password — Менеджери паролів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '1password.com' OR LOWER(`name`) = '1password')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT '1Password', NULL, 'https://1password.com', NULL, NULL, 'Менеджер паролів і секретів для людей, родин і компаній: сховище, автозаповнення, passkeys і контроль доступу.', 'A password and secrets manager for individuals, families and businesses: vault, autofill, passkeys and access control.', '1Password зберігає паролі, passkeys, дані карток і документи в зашифрованому сховищі й автоматично підставляє їх у браузері та застосунках. Для команд є спільні сховища з правами доступу, журнали дій, захист застосунків поза SSO та інструменти для розробників, зокрема керування секретами. Компанія також пропонує рішення для контролю доступу до SaaS і AI-інструментів. Можна спробувати безкоштовно 14 днів.', '1Password stores passwords, passkeys, card details and documents in an encrypted vault and fills them in your browser and apps. Teams get shared vaults with permissions, activity logs, protection for apps outside SSO and developer tools including secrets management. The company also offers access control for SaaS and AI tools. There is a 14-day free trial.', 'Зашифроване сховище паролів і passkeys
Автозаповнення в браузері й застосунках
Спільні сховища з правами доступу
Керування секретами для розробників', 'Encrypted vault for passwords and passkeys
Autofill in browsers and apps
Shared vaults with permissions
Secrets management for developers', 'Окремим користувачам, родинам, командам і великим компаніям.', 'Individuals, families, teams and large companies.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '1password.com' OR LOWER(`name`) = '1password') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A password and secrets manager for individuals, families and businesses: vault, autofill, passkeys and access control.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', '1Password stores passwords, passkeys, card details and documents in an encrypted vault and fills them in your browser and apps. Teams get shared vaults with permissions, activity logs, protection for apps outside SSO and developer tools including secrets management. The company also offers access control for SaaS and AI tools. There is a 14-day free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Encrypted vault for passwords and passkeys
Autofill in browsers and apps
Shared vaults with permissions
Secrets management for developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individuals, families, teams and large companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '14 днів безкоштовно.', '14-day free trial.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '14-day free trial.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'month', 'Плани для особистого, сімейного й корпоративного використання; ціни на сайті.', 'Personal, family and business plans; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Personal, family and business plans; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bitwarden — Менеджери паролів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bitwarden.com' OR LOWER(`name`) = 'bitwarden')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bitwarden', NULL, 'https://bitwarden.com', NULL, NULL, 'Менеджер паролів із відкритим кодом: безкоштовний план, passkeys, спільний доступ і можливість власного сервера.', 'An open-source password manager: a free plan, passkeys, sharing and an option to self-host.', 'Bitwarden — менеджер паролів із відкритим кодом для людей, команд і компаній. Він зберігає паролі, passkeys і секрети, синхронізує їх між пристроями, дає безпечно ділитися записами й має генератор паролів. Безкоштовний план без обмеження кількості паролів, Premium додає розширені функції, а сімейний план охоплює до 6 користувачів. Сервер Bitwarden можна розгорнути у власній мережі.', 'Bitwarden is an open-source password manager for individuals, teams and enterprises. It stores passwords, passkeys and secrets, syncs them across devices, lets you share items securely and includes a password generator. The free plan has no limit on passwords; Premium adds advanced features and the Families plan covers up to 6 users. The Bitwarden server can be self-hosted on your own network.', 'Відкритий код
Паролі, passkeys і секрети
Безпечний спільний доступ
Розгортання на власному сервері', 'Open source
Passwords, passkeys and secrets
Secure sharing
Self-hosting option', 'Користувачам, які хочуть безкоштовний або відкритий менеджер паролів, і компаніям.', 'Users who want a free or open-source password manager, and businesses.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bitwarden.com' OR LOWER(`name`) = 'bitwarden') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source password manager: a free plan, passkeys, sharing and an option to self-host.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bitwarden is an open-source password manager for individuals, teams and enterprises. It stores passwords, passkeys and secrets, syncs them across devices, lets you share items securely and includes a password generator. The free plan has no limit on passwords; Premium adds advanced features and the Families plan covers up to 6 users. The Bitwarden server can be self-hosted on your own network.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Open source
Passwords, passkeys and secrets
Secure sharing
Self-hosting option', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who want a free or open-source password manager, and businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно, без обмеження кількості паролів.', 'Free with unlimited passwords.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free with unlimited passwords.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', 19.80, 'year', '$1.65 на місяць при оплаті за рік ($19.80).', '$1.65 per month billed annually ($19.80).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$1.65 per month billed annually ($19.80).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Families', 'Families', 47.88, 'year', '$3.99 на місяць при оплаті за рік, до 6 користувачів.', '$3.99 per month billed annually, up to 6 users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Families' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Families', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$3.99 per month billed annually, up to 6 users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dashlane — Менеджери паролів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dashlane.com' OR LOWER(`name`) = 'dashlane')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dashlane', NULL, 'https://www.dashlane.com', NULL, NULL, 'Менеджер паролів і захист облікових даних для компаній: сховище для кожного працівника й виявлення слабких паролів.', 'Password management and credential protection for businesses: a vault for every employee and weak-password detection.', 'Dashlane дає кожному працівникові зашифроване сховище для логінів на будь-якому пристрої та безпечний спільний доступ із гнучкими правами для адміністраторів. Платформа Dashlane Omnix виявляє слабкі й скомпрометовані паролі прямо в браузері та інтегрується з SIEM-системами. Ціни для бізнесу — за користувача на місяць при оплаті за рік, є пробний період.', 'Dashlane gives every employee an encrypted vault for logins on any device and secure sharing with granular admin controls. The Dashlane Omnix platform detects weak and compromised passwords right in the browser and integrates with SIEM systems. Business pricing is per user per month billed annually, and a free trial is available.', 'Зашифроване сховище для працівників
Спільний доступ з правами
Виявлення слабких і скомпрометованих паролів
Інтеграції з SIEM', 'Encrypted vault for employees
Sharing with permissions
Weak and compromised password detection
SIEM integrations', 'Компаніям і ІТ-командам, які керують паролями працівників.', 'Companies and IT teams managing employee passwords.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dashlane.com' OR LOWER(`name`) = 'dashlane') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Password management and credential protection for businesses: a vault for every employee and weak-password detection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dashlane gives every employee an encrypted vault for logins on any device and secure sharing with granular admin controls. The Dashlane Omnix platform detects weak and compromised passwords right in the browser and integrates with SIEM systems. Business pricing is per user per month billed annually, and a free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Encrypted vault for employees
Sharing with permissions
Weak and compromised password detection
SIEM integrations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Companies and IT teams managing employee passwords.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Business', 'Business', NULL, 'month', 'Ціна за користувача на місяць при оплаті за рік; є пробний період. Ціни на сайті.', 'Per user per month billed annually; free trial available. Prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Business' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Business', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per user per month billed annually; free trial available. Prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LastPass — Менеджери паролів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lastpass.com' OR LOWER(`name`) = 'lastpass')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LastPass', NULL, 'https://www.lastpass.com', NULL, NULL, 'Менеджер паролів для людей і бізнесу з моделлю zero-knowledge, розширенням для браузера й контролем SaaS.', 'A password manager for individuals and businesses with a zero-knowledge model, browser extension and SaaS visibility.', 'LastPass створює й зберігає надійні паролі в зашифрованому сховищі та підставляє їх через розширення для браузера. Модель zero-knowledge означає, що сам сервіс не бачить ваших даних. Для компаній є плани Teams, Business і Business Max з видимістю «тіньових» SaaS і AI-інструментів, якими користуються працівники. Premium і Business можна спробувати безкоштовно без картки.', 'LastPass generates and stores strong passwords in an encrypted vault and fills them in through a browser extension. Its zero-knowledge model means the service itself cannot see your data. Businesses get Teams, Business and Business Max plans with visibility into the shadow SaaS and AI tools employees use. Premium and Business can be tried for free without a credit card.', 'Генератор і сховище паролів
Розширення для браузера
Модель zero-knowledge
Видимість тіньових SaaS і AI для бізнесу', 'Password generator and vault
Browser extension
Zero-knowledge model
Shadow SaaS and AI visibility for business', 'Окремим користувачам, родинам, командам і компаніям.', 'Individuals, families, teams and companies.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lastpass.com' OR LOWER(`name`) = 'lastpass') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A password manager for individuals and businesses with a zero-knowledge model, browser extension and SaaS visibility.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LastPass generates and stores strong passwords in an encrypted vault and fills them in through a browser extension. Its zero-knowledge model means the service itself cannot see your data. Businesses get Teams, Business and Business Max plans with visibility into the shadow SaaS and AI tools employees use. Premium and Business can be tried for free without a credit card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Password generator and vault
Browser extension
Zero-knowledge model
Shadow SaaS and AI visibility for business', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individuals, families, teams and companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', 'Безкоштовний пробний період Premium без картки.', 'Free Premium trial, no credit card required.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free Premium trial, no credit card required.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'month', 'Personal, Families, Teams, Business; ціни на сайті.', 'Personal, Families, Teams, Business; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Personal, Families, Teams, Business; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Proton Pass — Менеджери паролів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'proton.me/pass' OR LOWER(`name`) = 'proton pass')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Proton Pass', NULL, 'https://proton.me/pass', NULL, NULL, 'Менеджер паролів зі скрізним шифруванням від Proton: необмежені логіни, псевдоніми email і вбудований 2FA.', 'An end-to-end encrypted password manager from Proton: unlimited logins, email aliases and a built-in 2FA authenticator.', 'Proton Pass зберігає логіни, картки й нотатки зі скрізним шифруванням і працює в браузері та на всіх пристроях. Він створює псевдоніми email (hide-my-email), щоб не світити справжню адресу, має вбудований генератор 2FA-кодів, моніторинг даркнету й безпечний обмін записами. Безкоштовний план містить необмежені логіни, платні додають більше сховищ, псевдонімів і функцій.', 'Proton Pass stores logins, cards and notes with end-to-end encryption and works in the browser and on all devices. It creates hide-my-email aliases so you do not expose your real address, has a built-in 2FA code generator, dark web monitoring and secure sharing. The free plan includes unlimited logins; paid plans add more vaults, aliases and features.', 'Скрізне шифрування
Псевдоніми email
Вбудований 2FA-автентифікатор
Моніторинг даркнету', 'End-to-end encryption
Email aliases
Built-in 2FA authenticator
Dark web monitoring', 'Користувачам, яким важлива приватність, і користувачам екосистеми Proton.', 'Privacy-minded users and users of the Proton ecosystem.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'proton.me/pass' OR LOWER(`name`) = 'proton pass') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An end-to-end encrypted password manager from Proton: unlimited logins, email aliases and a built-in 2FA authenticator.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Proton Pass stores logins, cards and notes with end-to-end encryption and works in the browser and on all devices. It creates hide-my-email aliases so you do not expose your real address, has a built-in 2FA code generator, dark web monitoring and secure sharing. The free plan includes unlimited logins; paid plans add more vaults, aliases and features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'End-to-end encryption
Email aliases
Built-in 2FA authenticator
Dark web monitoring', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Privacy-minded users and users of the Proton ecosystem.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Proton Free', 'Proton Free', 0.00, 'free', 'Безкоштовно, необмежені логіни.', 'Free, unlimited logins.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Proton Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Proton Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, unlimited logins.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pass Plus', 'Pass Plus', 35.88, 'year', '$2.99 на місяць при оплаті за 12 місяців ($35.88).', '$2.99 per month billed at $35.88 every 12 months.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pass Plus' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pass Plus', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$2.99 per month billed at $35.88 every 12 months.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Proton Unlimited', 'Proton Unlimited', 119.88, 'year', '$9.99 на місяць при оплаті за рік: усі сервіси Proton.', '$9.99 per month billed annually: all Proton services.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Proton Unlimited' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Proton Unlimited', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$9.99 per month billed annually: all Proton services.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Keeper — Менеджери паролів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'keepersecurity.com' OR LOWER(`name`) = 'keeper')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Keeper', NULL, 'https://www.keepersecurity.com', NULL, NULL, 'Менеджер паролів і платформа захисту доступу: особисті й сімейні сховища, привілейований доступ для компаній.', 'A password manager and identity security platform: personal and family vaults, privileged access for businesses.', 'Keeper поєднує менеджер паролів для людей і родин із корпоративною платформою захисту доступу. Особистий план Keeper Unlimited і сімейний план із п''ятьма сховищами зберігають паролі й файли (10 ГБ сховища для файлів). Для компаній Keeper пропонує керування привілейованим доступом, секретами, віддаленими підключеннями й базами даних за моделлю zero-trust. Є 30-денний безкоштовний пробний період.', 'Keeper combines a password manager for individuals and families with an enterprise identity security platform. The personal Keeper Unlimited plan and the family plan with five vaults store passwords and files (10 GB of file storage). For companies, Keeper offers zero-trust management of privileged access, secrets, remote connections and databases. There is a 30-day free trial.', 'Особисті й сімейні сховища
Захищене сховище файлів
Керування привілейованим доступом
Керування секретами', 'Personal and family vaults
Secure file storage
Privileged access management
Secrets management', 'Людям, родинам і компаніям, зокрема з високими вимогами до безпеки.', 'Individuals, families and companies, including those with strict security requirements.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'keepersecurity.com' OR LOWER(`name`) = 'keeper') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A password manager and identity security platform: personal and family vaults, privileged access for businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Keeper combines a password manager for individuals and families with an enterprise identity security platform. The personal Keeper Unlimited plan and the family plan with five vaults store passwords and files (10 GB of file storage). For companies, Keeper offers zero-trust management of privileged access, secrets, remote connections and databases. There is a 30-day free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personal and family vaults
Secure file storage
Privileged access management
Secrets management', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individuals, families and companies, including those with strict security requirements.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '30 днів безкоштовно.', '30-day free trial.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '30-day free trial.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Keeper Unlimited', 'Keeper Unlimited', NULL, 'year', 'Особистий і сімейний плани оплачуються за рік; ціни на сайті.', 'Personal and family plans are billed annually; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Keeper Unlimited' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Keeper Unlimited', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Personal and family plans are billed annually; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NordPass — Менеджери паролів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nordpass.com' OR LOWER(`name`) = 'nordpass')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NordPass', NULL, 'https://nordpass.com', NULL, NULL, 'Менеджер паролів від Nord Security: автозаповнення, офлайн-доступ, моніторинг витоків і плани для бізнесу.', 'A password manager from Nord Security: autofill, offline access, breach monitoring and business plans.', 'NordPass запам''ятовує складні паролі, автоматично заповнює логіни й онлайн-форми та дає доступ до сховища з будь-якого пристрою навіть офлайн. Для компаній є зашифровані сховища працівників, автозаповнення й моніторинг витоків. Безкоштовний план включає 30-денний пробний період Premium, бізнес-план — 14 днів без картки, діє 30-денна гарантія повернення коштів.', 'NordPass remembers complex passwords, autofills logins and online forms and lets you reach your vault from any device, even offline. Businesses get encrypted employee vaults, autofill and breach monitoring. The free plan includes a 30-day Premium trial, the business trial lasts 14 days with no card, and there is a 30-day money-back guarantee.', 'Автозаповнення логінів і форм
Офлайн-доступ до сховища
Моніторинг витоків
Плани для команд і компаній', 'Autofill for logins and forms
Offline vault access
Breach monitoring
Plans for teams and companies', 'Окремим користувачам, родинам і компаніям.', 'Individuals, families and companies.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nordpass.com' OR LOWER(`name`) = 'nordpass') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A password manager from Nord Security: autofill, offline access, breach monitoring and business plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NordPass remembers complex passwords, autofills logins and online forms and lets you reach your vault from any device, even offline. Businesses get encrypted employee vaults, autofill and breach monitoring. The free plan includes a 30-day Premium trial, the business trial lasts 14 days with no card, and there is a 30-day money-back guarantee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Autofill for logins and forms
Offline vault access
Breach monitoring
Plans for teams and companies', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individuals, families and companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний план із 30-денним пробним Premium.', 'Free plan with a 30-day Premium trial.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free plan with a 30-day Premium trial.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium / Business', 'Premium / Business', NULL, 'month', 'Ціни на сайті; 30 днів гарантії повернення коштів.', 'Prices on the site; 30-day money-back guarantee.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium / Business' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium / Business', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the site; 30-day money-back guarantee.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- RoboForm — Менеджери паролів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roboform.com' OR LOWER(`name`) = 'roboform')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RoboForm', NULL, 'https://www.roboform.com', NULL, NULL, 'Менеджер паролів і автозаповнювач форм: безкоштовна версія, Premium для всіх пристроїв і сімейний план.', 'A password manager and form filler: a free version, Premium for all devices and a family plan.', 'RoboForm зберігає паролі й заповнює довгі онлайн-форми одним кліком. Безкоштовна версія закриває базові потреби, Premium додає синхронізацію на необмеженій кількості пристроїв і преміум-функції, а Family дає 5 акаунтів Premium для родини. Діє 30-денна гарантія повернення коштів.', 'RoboForm stores passwords and fills long online forms in one click. The free version covers the basics, Premium adds sync across unlimited devices and premium features, and Family gives 5 Premium accounts for a household. There is a 30-day money-back guarantee.', 'Автозаповнення форм
Синхронізація на всіх пристроях
Сімейний план на 5 акаунтів
Безкоштовна версія', 'Form filling
Sync across all devices
Family plan for 5 accounts
Free version', 'Користувачам, які часто заповнюють онлайн-форми, і родинам.', 'Users who often fill in online forms, and families.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roboform.com' OR LOWER(`name`) = 'roboform') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A password manager and form filler: a free version, Premium for all devices and a family plan.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'RoboForm stores passwords and fills long online forms in one click. The free version covers the basics, Premium adds sync across unlimited devices and premium features, and Family gives 5 Premium accounts for a household. There is a 30-day money-back guarantee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Form filling
Sync across all devices
Family plan for 5 accounts
Free version', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who often fill in online forms, and families.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовна версія.', 'Free version.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free version.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', 29.88, 'year', '$2.49 на місяць при оплаті за рік; для нових користувачів діє знижка на перший рік.', '$2.49 per month billed annually; new users get a first-year discount.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$2.49 per month billed annually; new users get a first-year discount.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Family', 'Family', 47.75, 'year', '5 акаунтів Premium; $47.75 на рік після першого року.', '5 Premium accounts; $47.75 per year after the first year.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Family' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Family', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '5 Premium accounts; $47.75 per year after the first year.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- KeePassXC — Менеджери паролів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'keepassxc.org' OR LOWER(`name`) = 'keepassxc')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'KeePassXC', NULL, 'https://keepassxc.org', NULL, NULL, 'Безкоштовний офлайн-менеджер паролів із відкритим кодом для Windows, macOS і Linux — без хмари й підписок.', 'A free, open-source offline password manager for Windows, macOS and Linux — no cloud and no subscriptions.', 'KeePassXC зберігає паролі, логіни, адреси, вкладення й нотатки в зашифрованій базі на вашому пристрої та автоматично підставляє їх у застосунки. Дані не зберігаються на сторонніх серверах: без хмари, реклами, трекерів і підписок. Код відкритий під ліцензією GPLv3, програма працює на Windows, macOS і Linux; її безпеку перевіряло французьке агентство кібербезпеки ANSSI.', 'KeePassXC stores passwords, usernames, URLs, attachments and notes in an encrypted database on your device and auto-fills them into apps. Nothing is stored on remote servers: no cloud, ads, trackers or subscriptions. The code is open source under GPLv3, it runs on Windows, macOS and Linux, and its security has been assessed by the French cybersecurity agency ANSSI.', 'Локальна зашифрована база
Автозаповнення в застосунках
Відкритий код (GPLv3)
Windows, macOS і Linux', 'Local encrypted database
Auto-type into apps
Open source (GPLv3)
Windows, macOS and Linux', 'Користувачам, які хочуть повний контроль над паролями без хмари.', 'Users who want full control over their passwords without the cloud.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'keepassxc.org' OR LOWER(`name`) = 'keepassxc') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free, open-source offline password manager for Windows, macOS and Linux — no cloud and no subscriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'KeePassXC stores passwords, usernames, URLs, attachments and notes in an encrypted database on your device and auto-fills them into apps. Nothing is stored on remote servers: no cloud, ads, trackers or subscriptions. The code is open source under GPLv3, it runs on Windows, macOS and Linux, and its security has been assessed by the French cybersecurity agency ANSSI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local encrypted database
Auto-type into apps
Open source (GPLv3)
Windows, macOS and Linux', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who want full control over their passwords without the cloud.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Повністю безкоштовно, відкритий код.', 'Completely free and open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Completely free and open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Enpass — Менеджери паролів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'enpass.io' OR LOWER(`name`) = 'enpass')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Enpass', NULL, 'https://www.enpass.io', NULL, NULL, 'Менеджер паролів і passkeys, що зберігає сховище у вашій власній хмарі (iCloud, Google Drive, OneDrive) або офлайн.', 'A password and passkey manager that keeps your vault in your own cloud (iCloud, Google Drive, OneDrive) or offline.', 'Enpass не зберігає ваші паролі на своїх серверах: сховище синхронізується через вашу хмару (iCloud, Google Drive, OneDrive, Dropbox, Box) або залишається офлайн. Підтримуються паролі й passkeys. Безкоштовний план — до 25 записів, Premium і сімейний план (до 6 людей) знімають обмеження, а бізнес-план зберігає дані в Microsoft 365 чи Google Workspace компанії.', 'Enpass does not keep your passwords on its servers: the vault syncs through your own cloud (iCloud, Google Drive, OneDrive, Dropbox, Box) or stays offline. Passwords and passkeys are supported. The free plan allows up to 25 items; Premium and the Family plan (up to 6 people) remove limits, and the Business plan keeps data in the company''s Microsoft 365 or Google Workspace.', 'Сховище у вашій хмарі або офлайн
Паролі й passkeys
Сімейний план до 6 людей
Бізнес-план із Microsoft 365 / Google Workspace', 'Vault in your own cloud or offline
Passwords and passkeys
Family plan for up to 6 people
Business plan with Microsoft 365 / Google Workspace', 'Користувачам, які не хочуть зберігати паролі на чужих серверах, і компаніям.', 'Users who do not want passwords on third-party servers, and businesses.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'enpass.io' OR LOWER(`name`) = 'enpass') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A password and passkey manager that keeps your vault in your own cloud (iCloud, Google Drive, OneDrive) or offline.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Enpass does not keep your passwords on its servers: the vault syncs through your own cloud (iCloud, Google Drive, OneDrive, Dropbox, Box) or stays offline. Passwords and passkeys are supported. The free plan allows up to 25 items; Premium and the Family plan (up to 6 people) remove limits, and the Business plan keeps data in the company''s Microsoft 365 or Google Workspace.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vault in your own cloud or offline
Passwords and passkeys
Family plan for up to 6 people
Business plan with Microsoft 365 / Google Workspace', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who do not want passwords on third-party servers, and businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'До 25 записів.', 'Up to 25 items.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Up to 25 items.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', 1.99, 'month', '$1.99 на місяць при оплаті за рік.', '$1.99 per month billed annually.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$1.99 per month billed annually.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Family', 'Family', 3.99, 'month', 'Усе з Premium до 6 людей.', 'Everything in Premium for up to 6 people.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Family' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Family', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Everything in Premium for up to 6 people.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Business', 'Business', 1.99, 'month', '$1.99 за користувача на місяць при оплаті за рік.', '$1.99 per user per month billed annually.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Business' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Business', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$1.99 per user per month billed annually.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;


-- =================== VPN і приватність / VPN & Privacy ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vpn-privacy' LIMIT 1);

-- NordVPN — VPN і приватність
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nordvpn.com' OR LOWER(`name`) = 'nordvpn')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NordVPN', NULL, 'https://nordvpn.com', NULL, NULL, 'VPN-сервіс для захищеного й приватного з''єднання з планами Basic, Complete і Complete Max.', 'A VPN service for a secure, private connection, with Basic, Complete and Complete Max plans.', 'NordVPN шифрує інтернет-з''єднання й приховує вашу IP-адресу, що захищає дані в публічних Wi-Fi та під час перегляду сайтів. План Basic містить VPN, Complete додає інструменти захисту (менеджер паролів і хмарне сховище від Nord Security), а Complete Max — розширений набір. Ціни на сайті вказані для довгих підписок, після першого періоду підписка продовжується за звичайною ціною.', 'NordVPN encrypts your internet connection and hides your IP address, protecting your data on public Wi-Fi and while browsing. The Basic plan includes the VPN, Complete adds more protection tools (a password manager and cloud storage from Nord Security), and Complete Max offers the full set. Prices on the site are for long subscriptions; after the first term the subscription renews at the regular price.', 'Шифрування з''єднання
Приховування IP-адреси
Захист у публічних Wi-Fi
Пакети з додатковими інструментами захисту', 'Connection encryption
IP address masking
Protection on public Wi-Fi
Bundles with extra security tools', 'Усім, хто користується публічними мережами або дбає про приватність онлайн.', 'Anyone who uses public networks or cares about online privacy.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nordvpn.com' OR LOWER(`name`) = 'nordvpn') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A VPN service for a secure, private connection, with Basic, Complete and Complete Max plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NordVPN encrypts your internet connection and hides your IP address, protecting your data on public Wi-Fi and while browsing. The Basic plan includes the VPN, Complete adds more protection tools (a password manager and cloud storage from Nord Security), and Complete Max offers the full set. Prices on the site are for long subscriptions; after the first term the subscription renews at the regular price.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Connection encryption
IP address masking
Protection on public Wi-Fi
Bundles with extra security tools', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who uses public networks or cares about online privacy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Basic', 'Basic', 3.49, 'month', '$3.49 на місяць при оплаті за 27 місяців ($94.23), далі $139.08 на рік.', '$3.49 per month on the 27-month plan ($94.23), then $139.08 per year.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Basic' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Basic', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$3.49 per month on the 27-month plan ($94.23), then $139.08 per year.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Complete', 'Complete', 4.49, 'month', '$4.49 на місяць при оплаті за 27 місяців ($121.23), далі $219.48 на рік.', '$4.49 per month on the 27-month plan ($121.23), then $219.48 per year.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Complete' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Complete', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$4.49 per month on the 27-month plan ($121.23), then $219.48 per year.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Complete Max', 'Complete Max', 6.49, 'month', '$6.49 на місяць при оплаті за 27 місяців ($175.23), далі $301.08 на рік.', '$6.49 per month on the 27-month plan ($175.23), then $301.08 per year.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Complete Max' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Complete Max', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$6.49 per month on the 27-month plan ($175.23), then $301.08 per year.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Proton VPN — VPN і приватність
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'protonvpn.com' OR LOWER(`name`) = 'proton vpn')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Proton VPN', NULL, 'https://protonvpn.com', NULL, NULL, 'Швейцарський VPN із безкоштовним планом без ліміту трафіку, відкритим кодом і політикою без журналів.', 'A Swiss VPN with a free plan without data limits, open-source apps and a no-logs policy.', 'Proton VPN від творців Proton Mail не веде журналів активності, має відкритий код застосунків і швейцарську юрисдикцію. Є kill switch, Secure Core (маршрутизація через захищені сервери), блокувальник реклами й шкідливих сайтів NetShield та прискорення VPN Accelerator. Безкоштовний план не обмежує трафік і швидкість, платні плани додають більше серверів і функцій. Діє 30-денна гарантія повернення коштів.', 'Proton VPN from the makers of Proton Mail keeps no activity logs, has open-source apps and Swiss jurisdiction. It includes a kill switch, Secure Core routing through hardened servers, the NetShield ad and malware blocker and VPN Accelerator. The free plan has no data or speed limits; paid plans add more servers and features. There is a 30-day money-back guarantee.', 'Безкоштовний план без ліміту трафіку
Політика без журналів
Secure Core і kill switch
Блокувальник NetShield', 'Free plan without data limits
No-logs policy
Secure Core and kill switch
NetShield blocker', 'Користувачам, яким потрібен надійний безкоштовний або платний VPN.', 'Users who need a trustworthy free or paid VPN.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'protonvpn.com' OR LOWER(`name`) = 'proton vpn') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Swiss VPN with a free plan without data limits, open-source apps and a no-logs policy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Proton VPN from the makers of Proton Mail keeps no activity logs, has open-source apps and Swiss jurisdiction. It includes a kill switch, Secure Core routing through hardened servers, the NetShield ad and malware blocker and VPN Accelerator. The free plan has no data or speed limits; paid plans add more servers and features. There is a 30-day money-back guarantee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free plan without data limits
No-logs policy
Secure Core and kill switch
NetShield blocker', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who need a trustworthy free or paid VPN.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Proton Free', 'Proton Free', 0.00, 'free', 'Безкоштовно, без ліміту трафіку.', 'Free, no data limits.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Proton Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Proton Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, no data limits.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'VPN Plus', 'VPN Plus', 3.49, 'month', '$3.49 на місяць при оплаті за 24 місяці ($83.76), далі $83.88 на рік.', '$3.49 per month billed $83.76 for 24 months, then $83.88 per year.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'VPN Plus' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'VPN Plus', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$3.49 per month billed $83.76 for 24 months, then $83.88 per year.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Proton Unlimited', 'Proton Unlimited', 7.99, 'month', '$7.99 на місяць при оплаті за 24 місяці: усі сервіси Proton.', '$7.99 per month on the 24-month plan: all Proton services.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Proton Unlimited' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Proton Unlimited', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$7.99 per month on the 24-month plan: all Proton services.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Surfshark — VPN і приватність
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'surfshark.com' OR LOWER(`name`) = 'surfshark')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Surfshark', NULL, 'https://surfshark.com', NULL, NULL, 'VPN і набір онлайн-захисту: необмежена кількість пристроїв, захист від шахрайства, антивірус і захист особистих даних.', 'A VPN and online protection suite: unlimited devices, scam protection, antivirus and identity protection.', 'Surfshark — VPN, що працює одночасно на необмеженій кількості пристроїв і використовує сервери лише з оперативною пам''яттю. Старші пакети додають захист від шахрайства й фішингу, антивірус, альтернативну ідентичність і звіти про витоки особистих даних (страхування від крадіжки особистості — лише для жителів США). Діє 30-денна гарантія повернення коштів.', 'Surfshark is a VPN that works on an unlimited number of devices at once and uses RAM-only servers. Higher bundles add scam and phishing protection, antivirus, an alternative identity and personal data breach reports (identity theft insurance is for US residents only). There is a 30-day money-back guarantee.', 'VPN на необмеженій кількості пристроїв
Сервери лише з оперативною пам''яттю
Захист від шахрайства й фішингу
Антивірус у старших пакетах', 'VPN on unlimited devices
RAM-only servers
Scam and phishing protection
Antivirus in higher bundles', 'Родинам і користувачам із багатьма пристроями.', 'Families and users with many devices.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'surfshark.com' OR LOWER(`name`) = 'surfshark') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A VPN and online protection suite: unlimited devices, scam protection, antivirus and identity protection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Surfshark is a VPN that works on an unlimited number of devices at once and uses RAM-only servers. Higher bundles add scam and phishing protection, antivirus, an alternative identity and personal data breach reports (identity theft insurance is for US residents only). There is a 30-day money-back guarantee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'VPN on unlimited devices
RAM-only servers
Scam and phishing protection
Antivirus in higher bundles', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families and users with many devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', NULL, 'month', 'Для України від 89 грн на місяць за 24-місячний план; ціна залежить від регіону.', 'In Ukraine from UAH 89 per month on the 24-month plan; price depends on region.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'In Ukraine from UAH 89 per month on the 24-month plan; price depends on region.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'One / One+', 'One / One+', NULL, 'month', 'Пакети з антивірусом і захистом особистих даних; ціни на сайті.', 'Bundles with antivirus and identity protection; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'One / One+' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'One / One+', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Bundles with antivirus and identity protection; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ExpressVPN — VPN і приватність
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'expressvpn.com' OR LOWER(`name`) = 'expressvpn')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ExpressVPN', NULL, 'https://www.expressvpn.com', NULL, NULL, 'VPN із серверами в 113 країнах, цілодобовою підтримкою й тарифами з блокуванням реклами та менеджером паролів.', 'A VPN with servers in 113 countries, 24/7 support and plans with ad blocking and a password manager.', 'ExpressVPN захищає з''єднання й приватність на всіх пристроях і має сервери в 113 країнах та цілодобову підтримку. План Basic містить швидкий VPN, Advanced додає блокування реклами, трекерів і шкідливих сайтів, менеджер паролів ExpressKeys і email-псевдоніми, а Pro — розширений набір. Для нових користувачів діє 30-денна гарантія повернення коштів.', 'ExpressVPN protects your connection and privacy on all devices, with servers in 113 countries and 24/7 support. Basic includes a fast VPN, Advanced adds blocking of ads, trackers and malicious sites, the ExpressKeys password manager and email aliases, and Pro offers the full set. New users get a 30-day money-back guarantee.', 'Сервери в 113 країнах
Блокування реклами й трекерів
Менеджер паролів ExpressKeys
Цілодобова підтримка', 'Servers in 113 countries
Ad and tracker blocking
ExpressKeys password manager
24/7 support', 'Користувачам, яким потрібен VPN для подорожей, стрімінгу й приватності.', 'Users who need a VPN for travel, streaming and privacy.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'expressvpn.com' OR LOWER(`name`) = 'expressvpn') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A VPN with servers in 113 countries, 24/7 support and plans with ad blocking and a password manager.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ExpressVPN protects your connection and privacy on all devices, with servers in 113 countries and 24/7 support. Basic includes a fast VPN, Advanced adds blocking of ads, trackers and malicious sites, the ExpressKeys password manager and email aliases, and Pro offers the full set. New users get a 30-day money-back guarantee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Servers in 113 countries
Ad and tracker blocking
ExpressKeys password manager
24/7 support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who need a VPN for travel, streaming and privacy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Basic', 'Basic', NULL, 'one_time', '$83.72 за перші 28 місяців, далі $99.95 на рік.', '$83.72 for the first 28 months, then $99.95 per year.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Basic' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Basic', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$83.72 for the first 28 months, then $99.95 per year.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Advanced', 'Advanced', 4.49, 'month', '$125.72 за перші 28 місяців, далі $119.95 на рік.', '$125.72 for the first 28 months, then $119.95 per year.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Advanced' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Advanced', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$125.72 for the first 28 months, then $119.95 per year.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 7.49, 'month', '$209.72 за перші 28 місяців, далі $199.95 на рік.', '$209.72 for the first 28 months, then $199.95 per year.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$209.72 for the first 28 months, then $199.95 per year.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mullvad VPN — VPN і приватність
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mullvad.net' OR LOWER(`name`) = 'mullvad vpn')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mullvad VPN', NULL, 'https://mullvad.net', NULL, NULL, 'VPN для приватності з однією ціною €5 на місяць, анонімним номером акаунта й власним приватним браузером.', 'A privacy VPN with a single €5 monthly price, an anonymous account number and its own private browser.', 'Mullvad VPN створює акаунт без email — лише випадковий номер, тож сервіс не знає, хто ви. Ціна однакова завжди: €5 на місяць незалежно від терміну, без знижок і «довічних» підписок. Компанія також випускає Mullvad Browser, розроблений разом із Tor Project для захисту від стеження. Безкоштовного плану немає.', 'Mullvad VPN creates an account without an email — just a random number, so the service does not know who you are. The price never changes: €5 per month whatever the term, with no discounts or lifetime deals. The company also makes Mullvad Browser, built with the Tor Project to resist tracking. There is no free plan.', 'Акаунт без email
Фіксована ціна без акцій
Mullvad Browser проти стеження
Захист від масового стеження', 'Account without email
Flat price, no promotions
Mullvad Browser against tracking
Protection from mass surveillance', 'Користувачам, для яких приватність важливіша за знижки.', 'Users who value privacy over discounts.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mullvad.net' OR LOWER(`name`) = 'mullvad vpn') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A privacy VPN with a single €5 monthly price, an anonymous account number and its own private browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mullvad VPN creates an account without an email — just a random number, so the service does not know who you are. The price never changes: €5 per month whatever the term, with no discounts or lifetime deals. The company also makes Mullvad Browser, built with the Tor Project to resist tracking. There is no free plan.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Account without email
Flat price, no promotions
Mullvad Browser against tracking
Protection from mass surveillance', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who value privacy over discounts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Місяць', 'Monthly', NULL, 'month', '€5 на місяць (з ПДВ), однаково для будь-якого терміну.', '€5 per month (VAT included), the same for any term.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Місяць' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Monthly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '€5 per month (VAT included), the same for any term.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Proton Mail — VPN і приватність
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'proton.me/mail' OR LOWER(`name`) = 'proton mail')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Proton Mail', NULL, 'https://proton.me/mail', NULL, NULL, 'Зашифрована пошта зі Швейцарії: безкоштовна скринька, календар, планування листів і плани Mail Plus та Unlimited.', 'Encrypted email from Switzerland: a free mailbox, calendar, scheduled send and Mail Plus and Unlimited plans.', 'Proton Mail шифрує листи так, що їх не може прочитати навіть сам сервіс, і працює за швейцарськими законами про приватність. Безкоштовна скринька доступна завжди; Mail Plus додає необмежені фільтри, планування й відкладання листів, автоочищення спаму та власні домени. До пошти входить Proton Calendar, а AI-помічник Proton Scribe доступний як доповнення. Діє 30-денна гарантія повернення коштів.', 'Proton Mail encrypts your email so that even the service cannot read it, under Swiss privacy law. A free mailbox is always available; Mail Plus adds unlimited filters, scheduled and snoozed email, automatic spam cleanup and custom domains. Proton Calendar is included, and the Proton Scribe AI writing assistant is available as an add-on. There is a 30-day money-back guarantee.', 'Скрізне шифрування листів
Безкоштовна скринька
Proton Calendar
AI-помічник Proton Scribe (доповнення)', 'End-to-end encrypted email
Free mailbox
Proton Calendar
Proton Scribe AI assistant (add-on)', 'Людям і компаніям, яким потрібна приватна пошта.', 'People and companies who need private email.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'proton.me/mail' OR LOWER(`name`) = 'proton mail') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Encrypted email from Switzerland: a free mailbox, calendar, scheduled send and Mail Plus and Unlimited plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Proton Mail encrypts your email so that even the service cannot read it, under Swiss privacy law. A free mailbox is always available; Mail Plus adds unlimited filters, scheduled and snoozed email, automatic spam cleanup and custom domains. Proton Calendar is included, and the Proton Scribe AI writing assistant is available as an add-on. There is a 30-day money-back guarantee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'End-to-end encrypted email
Free mailbox
Proton Calendar
Proton Scribe AI assistant (add-on)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People and companies who need private email.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Proton Free', 'Proton Free', 0.00, 'free', 'Безкоштовна скринька.', 'Free mailbox.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Proton Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Proton Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free mailbox.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Mail Plus', 'Mail Plus', 47.88, 'year', '$3.99 на місяць при оплаті за 12 місяців.', '$3.99 per month billed at $47.88 every 12 months.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Mail Plus' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Mail Plus', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$3.99 per month billed at $47.88 every 12 months.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Proton Unlimited', 'Proton Unlimited', 119.88, 'year', '$9.99 на місяць при оплаті за рік: усі сервіси Proton.', '$9.99 per month billed annually: all Proton services.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Proton Unlimited' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Proton Unlimited', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$9.99 per month billed annually: all Proton services.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tuta — VPN і приватність
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tuta.com' OR LOWER(`name`) = 'tuta')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tuta', NULL, 'https://tuta.com', NULL, NULL, 'Зашифрована пошта, календар і контакти з квантово-стійким шифруванням, без реклами; є безкоштовний план на 1 ГБ.', 'Encrypted email, calendar and contacts with quantum-safe encryption and no ads; a free 1 GB plan is available.', 'Tuta (раніше Tutanota) — німецький сервіс зашифрованої пошти, календаря й контактів. Дані захищені квантово-стійким шифруванням, сервіс не показує реклами й не стежить за користувачами. Безкоштовний план дає 1 ГБ сховища, платні додають власні домени, додаткові адреси й сімейний доступ. Є застосунки для Android, iPhone і комп''ютера.', 'Tuta (formerly Tutanota) is a German service for encrypted email, calendar and contacts. Data is protected with quantum-safe encryption, and the service shows no ads and does not track users. The free plan offers 1 GB of storage; paid plans add custom domains, extra addresses and family access. There are apps for Android, iPhone and desktop.', 'Квантово-стійке шифрування
Зашифрований календар
Без реклами й стеження
Власні домени в платних планах', 'Quantum-safe encryption
Encrypted calendar
No ads or tracking
Custom domains on paid plans', 'Користувачам, які шукають приватну альтернативу Gmail.', 'Users looking for a private alternative to Gmail.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tuta.com' OR LOWER(`name`) = 'tuta') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Encrypted email, calendar and contacts with quantum-safe encryption and no ads; a free 1 GB plan is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tuta (formerly Tutanota) is a German service for encrypted email, calendar and contacts. Data is protected with quantum-safe encryption, and the service shows no ads and does not track users. The free plan offers 1 GB of storage; paid plans add custom domains, extra addresses and family access. There are apps for Android, iPhone and desktop.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Quantum-safe encryption
Encrypted calendar
No ads or tracking
Custom domains on paid plans', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users looking for a private alternative to Gmail.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '1 ГБ сховища, без реклами.', '1 GB of storage, no ads.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '1 GB of storage, no ads.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Ціни в євро на сайті.', 'Prices in euros on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices in euros on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Brave — VPN і приватність
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brave.com' OR LOWER(`name`) = 'brave')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Brave', NULL, 'https://brave.com', NULL, NULL, 'Безкоштовний браузер, що блокує рекламу, трекери й банери cookie, з приватним пошуком і AI-відповідями.', 'A free browser that blocks ads, trackers and cookie banners, with private search and AI answers.', 'Brave за замовчуванням блокує сторонню рекламу, трекери й набридливі банери згоди на cookie, тож сторінки завантажуються швидше й економлять трафік та батарею. Вбудований Brave Search дає результати й AI-відповіді без профілювання користувача. Браузер доступний для комп''ютерів і телефонів; є платна спрощена версія Brave Origin.', 'Brave blocks third-party ads, trackers and annoying cookie consent banners by default, so pages load faster and save data and battery. The built-in Brave Search gives results and AI answers without profiling users. The browser is available on desktop and mobile; there is also a paid stripped-down version, Brave Origin.', 'Блокування реклами й трекерів
Блокування банерів cookie
Brave Search з AI-відповідями
Для комп''ютерів і телефонів', 'Ad and tracker blocking
Cookie banner blocking
Brave Search with AI answers
Desktop and mobile', 'Усім, хто хоче швидший і приватніший браузер.', 'Anyone who wants a faster, more private browser.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brave.com' OR LOWER(`name`) = 'brave') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free browser that blocks ads, trackers and cookie banners, with private search and AI answers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Brave blocks third-party ads, trackers and annoying cookie consent banners by default, so pages load faster and save data and battery. The built-in Brave Search gives results and AI answers without profiling users. The browser is available on desktop and mobile; there is also a paid stripped-down version, Brave Origin.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ad and tracker blocking
Cookie banner blocking
Brave Search with AI answers
Desktop and mobile', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who wants a faster, more private browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Браузер безкоштовний.', 'The browser is free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The browser is free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DuckDuckGo — VPN і приватність
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'duckduckgo.com/app' OR LOWER(`name`) = 'duckduckgo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DuckDuckGo', NULL, 'https://duckduckgo.com/app', NULL, NULL, 'Приватний браузер і пошук: блокування трекерів, приватний чат з AI-ботами й видалення даних із сайтів брокерів.', 'A private browser and search: tracker blocking, private chats with AI chatbots and removal of data from broker sites.', 'Браузер DuckDuckGo для Windows, Mac, iOS і Android за замовчуванням блокує сторонні трекери Google, Facebook та інших. Він дає змогу приватно спілкуватися з популярними AI-чатботами (за бажанням) і пропонує сервіс видалення особистих даних із сайтів, що їх продають. Пошук не створює профілю користувача.', 'The DuckDuckGo browser for Windows, Mac, iOS and Android blocks third-party trackers from Google, Facebook and others by default. It lets you chat privately with popular AI chatbots (optional) and offers removal of personal details from sites that sell them. Search does not build a user profile.', 'Блокування сторонніх трекерів
Приватний чат з AI-ботами
Видалення даних із сайтів брокерів
Пошук без профілювання', 'Third-party tracker blocking
Private chats with AI chatbots
Removal of data from broker sites
Search without profiling', 'Користувачам, які хочуть приватний пошук і браузер.', 'Users who want private search and browsing.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'duckduckgo.com/app' OR LOWER(`name`) = 'duckduckgo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A private browser and search: tracker blocking, private chats with AI chatbots and removal of data from broker sites.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The DuckDuckGo browser for Windows, Mac, iOS and Android blocks third-party trackers from Google, Facebook and others by default. It lets you chat privately with popular AI chatbots (optional) and offers removal of personal details from sites that sell them. Search does not build a user profile.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Third-party tracker blocking
Private chats with AI chatbots
Removal of data from broker sites
Search without profiling', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who want private search and browsing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Браузер і пошук безкоштовні; додаткові сервіси захисту — за підпискою.', 'Browser and search are free; extra protection services require a subscription.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Browser and search are free; extra protection services require a subscription.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;


-- =================== Антивіруси та захист пристроїв / Antivirus & Device Protection ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'device-protection' LIMIT 1);

-- Malwarebytes — Антивіруси та захист пристроїв
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'malwarebytes.com' OR LOWER(`name`) = 'malwarebytes')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Malwarebytes', NULL, 'https://www.malwarebytes.com', NULL, NULL, 'Антивірус, VPN і захист від шахрайства для всіх пристроїв, з пакетами захисту особистих даних.', 'Antivirus, VPN and scam protection for all your devices, with identity protection bundles.', 'Malwarebytes захищає комп''ютери й телефони від шкідливих програм, допомагає розпізнавати шахрайство й має власний VPN. План Standard — захист пристроїв, Plus додає VPN, а пакети з захистом особистих даних включають моніторинг, видалення даних із сайтів брокерів і страхування від крадіжки особистості. Ціни вказані за рік; перший рік дешевший за наступні.', 'Malwarebytes protects computers and phones from malware, helps you spot scams and has its own VPN. The Standard plan covers device security, Plus adds the VPN, and identity bundles include monitoring, removal of data from broker sites and identity theft insurance. Prices are per year; the first year costs less than renewal.', 'Захист від шкідливих програм
Розпізнавання шахрайства
Власний VPN
Пакети захисту особистих даних', 'Malware protection
Scam detection
Built-in VPN
Identity protection bundles', 'Людям і родинам, які хочуть захистити всі свої пристрої.', 'Individuals and families who want to protect all their devices.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'malwarebytes.com' OR LOWER(`name`) = 'malwarebytes') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Antivirus, VPN and scam protection for all your devices, with identity protection bundles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Malwarebytes protects computers and phones from malware, helps you spot scams and has its own VPN. The Standard plan covers device security, Plus adds the VPN, and identity bundles include monitoring, removal of data from broker sites and identity theft insurance. Prices are per year; the first year costs less than renewal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Malware protection
Scam detection
Built-in VPN
Identity protection bundles', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individuals and families who want to protect all their devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Standard', 'Standard', 35.99, 'year', '$35.99 за перший рік (звичайна ціна $59.99).', '$35.99 for the first year (regular price $59.99).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Standard' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Standard', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$35.99 for the first year (regular price $59.99).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Plus', 'Plus', 47.99, 'year', 'Захист пристроїв і VPN; $47.99 за перший рік (звичайна $79.99).', 'Device security and VPN; $47.99 for the first year (regular $79.99).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Plus' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Plus', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Device security and VPN; $47.99 for the first year (regular $79.99).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пакети з Identity', 'Identity bundles', NULL, 'year', 'Захист особистих даних і страхування; ціни на сайті.', 'Identity protection and insurance; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пакети з Identity' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Identity bundles', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Identity protection and insurance; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ESET — Антивіруси та захист пристроїв
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eset.com' OR LOWER(`name`) = 'eset')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ESET', NULL, 'https://www.eset.com', NULL, NULL, 'Антивірус і комплексний захист для дому та малого бізнесу на Windows, macOS, Android і Linux.', 'Antivirus and security suites for home and small business on Windows, macOS, Android and Linux.', 'ESET понад 30 років розробляє захист від шкідливих програм. Для дому є антивірус і комплексні пакети з захистом банкінгу, батьківським контролем і допомогою при втраті гаманця; для малого бізнесу — керування безпекою всіх пристроїв з однієї панелі. Можна спробувати безкоштовно 30 днів.', 'ESET has been developing malware protection for over 30 years. Home users get antivirus and security suites with banking protection, parental control and lost wallet assistance; small businesses can manage the security of all devices from one console. There is a 30-day free trial.', 'Антивірус для всіх платформ
Захист онлайн-банкінгу
Батьківський контроль
Керування захистом для малого бізнесу', 'Antivirus for all platforms
Online banking protection
Parental control
Security management for small business', 'Домашнім користувачам і малому бізнесу.', 'Home users and small businesses.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eset.com' OR LOWER(`name`) = 'eset') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Antivirus and security suites for home and small business on Windows, macOS, Android and Linux.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ESET has been developing malware protection for over 30 years. Home users get antivirus and security suites with banking protection, parental control and lost wallet assistance; small businesses can manage the security of all devices from one console. There is a 30-day free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Antivirus for all platforms
Online banking protection
Parental control
Security management for small business', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home users and small businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '30 днів безкоштовно.', '30-day free trial.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '30-day free trial.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'year', 'Ціни залежать від продукту й кількості пристроїв; на сайті.', 'Prices depend on product and number of devices; on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices depend on product and number of devices; on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bitdefender — Антивіруси та захист пристроїв
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bitdefender.com' OR LOWER(`name`) = 'bitdefender')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bitdefender', NULL, 'https://www.bitdefender.com', NULL, NULL, 'Антивірус і комплексний захист для дому (Total Security) та платформа GravityZone для бізнесу.', 'Antivirus and complete protection for home (Total Security) and the GravityZone platform for business.', 'Bitdefender пропонує домашнім користувачам Total Security — захист від шкідливих програм на всіх пристроях без помітного уповільнення. Для бізнесу є платформа GravityZone і керований сервіс безпеки, зокрема технологія PHASR, що персоналізовано зменшує поверхню атаки. Є безкоштовні пробні версії.', 'Bitdefender offers home users Total Security — malware protection across all devices without noticeable slowdown. Businesses get the GravityZone platform and a managed security service, including PHASR technology that reduces the attack surface in a personalized way. Free trials are available.', 'Захист від шкідливих програм
Захист усіх пристроїв родини
Платформа GravityZone для бізнесу
Керований сервіс безпеки', 'Malware protection
Protection for all family devices
GravityZone platform for business
Managed security service', 'Родинам, малому бізнесу й компаніям.', 'Families, small businesses and enterprises.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bitdefender.com' OR LOWER(`name`) = 'bitdefender') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Antivirus and complete protection for home (Total Security) and the GravityZone platform for business.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bitdefender offers home users Total Security — malware protection across all devices without noticeable slowdown. Businesses get the GravityZone platform and a managed security service, including PHASR technology that reduces the attack surface in a personalized way. Free trials are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Malware protection
Protection for all family devices
GravityZone platform for business
Managed security service', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families, small businesses and enterprises.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробна версія', 'Free trial', 0.00, 'free', 'Безкоштовні пробні версії.', 'Free trials available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробна версія' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free trials available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Total Security', 'Total Security', NULL, 'year', 'Ціни на сайті, залежать від регіону.', 'Prices on the site; depend on region.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Total Security' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Total Security', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the site; depend on region.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Norton 360 — Антивіруси та захист пристроїв
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'us.norton.com/products/norton-360' OR LOWER(`name`) = 'norton 360')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Norton 360', NULL, 'https://us.norton.com/products/norton-360', NULL, NULL, 'Захист від шкідливих програм, VPN, батьківський контроль і хмарне резервне копіювання; версії з LifeLock.', 'Malware protection, VPN, parental control and cloud backup; versions with LifeLock identity protection.', 'Norton 360 захищає від вірусів і шкідливих програм від 1 до 10 пристроїв (ПК, Mac, планшети й телефони). Залежно від плану є VPN без журналів, батьківський контроль, хмарне резервне копіювання ПК і менеджер паролів, а пакети Norton 360 with LifeLock додають захист від крадіжки особистості (для США). Діє 60-денна гарантія повернення коштів.', 'Norton 360 protects 1 to 10 devices (PCs, Macs, tablets and phones) from viruses and malware. Depending on the plan, it includes a no-log VPN, parental control, PC cloud backup and a password manager, while Norton 360 with LifeLock adds identity theft protection (US). There is a 60-day money-back guarantee.', 'Антивірус для 1–10 пристроїв
VPN без журналів
Батьківський контроль
Хмарне резервне копіювання ПК', 'Antivirus for 1–10 devices
No-log VPN
Parental control
PC cloud backup', 'Родинам і користувачам із кількома пристроями.', 'Families and users with several devices.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'us.norton.com/products/norton-360' OR LOWER(`name`) = 'norton 360') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Malware protection, VPN, parental control and cloud backup; versions with LifeLock identity protection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Norton 360 protects 1 to 10 devices (PCs, Macs, tablets and phones) from viruses and malware. Depending on the plan, it includes a no-log VPN, parental control, PC cloud backup and a password manager, while Norton 360 with LifeLock adds identity theft protection (US). There is a 60-day money-back guarantee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Antivirus for 1–10 devices
No-log VPN
Parental control
PC cloud backup', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families and users with several devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'year', 'Standard, Deluxe, Select та інші; ціни за рік на сайті, 60 днів гарантії повернення.', 'Standard, Deluxe, Select and more; yearly prices on the site, 60-day money-back guarantee.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Standard, Deluxe, Select and more; yearly prices on the site, 60-day money-back guarantee.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Avast — Антивіруси та захист пристроїв
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'avast.com' OR LOWER(`name`) = 'avast')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Avast', NULL, 'https://www.avast.com', NULL, NULL, 'Безкоштовний антивірус для ПК, Mac і Android, а також Avast One з VPN і функціями приватності.', 'A free antivirus for PC, Mac and Android, plus Avast One with a VPN and privacy features.', 'Avast Free Antivirus захищає комп''ютери й телефони від шкідливих програм безкоштовно. Платний Avast One поєднує захист, приватність і продуктивність: шифрування з''єднання (VPN) у публічних мережах, маскування цифрового відбитка від персоналізованої реклами та безпечний браузер. Сайт доступний українською.', 'Avast Free Antivirus protects computers and phones from malware for free. The paid Avast One combines security, privacy and performance: connection encryption (VPN) on public networks, fingerprint masking against targeted ads and a secure browser. The site is available in Ukrainian.', 'Безкоштовний антивірус
VPN для публічних мереж
Маскування цифрового відбитка
Безпечний браузер', 'Free antivirus
VPN for public networks
Fingerprint masking
Secure browser', 'Домашнім користувачам, зокрема тим, хто шукає безкоштовний антивірус.', 'Home users, including those looking for a free antivirus.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'avast.com' OR LOWER(`name`) = 'avast') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free antivirus for PC, Mac and Android, plus Avast One with a VPN and privacy features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Avast Free Antivirus protects computers and phones from malware for free. The paid Avast One combines security, privacy and performance: connection encryption (VPN) on public networks, fingerprint masking against targeted ads and a secure browser. The site is available in Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free antivirus
VPN for public networks
Fingerprint masking
Secure browser', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home users, including those looking for a free antivirus.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free Antivirus', 'Free Antivirus', 0.00, 'free', 'Безкоштовний антивірус.', 'Free antivirus.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free Antivirus' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free Antivirus', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free antivirus.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Avast One', 'Avast One', NULL, 'year', 'Платні пакети; ціни на сайті.', 'Paid bundles; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Avast One' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Avast One', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Paid bundles; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sophos Home — Антивіруси та захист пристроїв
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'home.sophos.com' OR LOWER(`name`) = 'sophos home')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sophos Home', NULL, 'https://home.sophos.com', NULL, NULL, 'Захист домашніх комп''ютерів Windows і macOS з AI-виявленням загроз, захистом від вимагачів і віддаленим керуванням.', 'Home protection for Windows and macOS with AI threat detection, ransomware security and remote management.', 'Sophos Home переносить у дім технології корпоративної безпеки Sophos. Він сканує й очищує шкідливі програми, використовує AI для виявлення загроз, захищає від програм-вимагачів, онлайн-покупки й банкінг від фішингу, має веб-фільтр для батьківського контролю. Захистом усіх комп''ютерів родини можна керувати віддалено з однієї панелі. Є безкоштовна пробна версія.', 'Sophos Home brings Sophos enterprise security technology to the home. It scans for and cleans malware, uses AI threat detection, protects against ransomware, guards online shopping and banking from phishing and offers web filtering for parental control. The whole family''s computers can be managed remotely from one dashboard. A free trial is available.', 'AI-виявлення загроз
Захист від програм-вимагачів
Батьківський веб-фільтр
Віддалене керування всіма ПК родини', 'AI threat detection
Ransomware protection
Parental web filtering
Remote management of all family PCs', 'Родинам із кількома комп''ютерами Windows і Mac.', 'Families with several Windows and Mac computers.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'home.sophos.com' OR LOWER(`name`) = 'sophos home') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Home protection for Windows and macOS with AI threat detection, ransomware security and remote management.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sophos Home brings Sophos enterprise security technology to the home. It scans for and cleans malware, uses AI threat detection, protects against ransomware, guards online shopping and banking from phishing and offers web filtering for parental control. The whole family''s computers can be managed remotely from one dashboard. A free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI threat detection
Ransomware protection
Parental web filtering
Remote management of all family PCs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families with several Windows and Mac computers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробна версія', 'Free trial', 0.00, 'free', 'Безкоштовна пробна версія.', 'Free trial.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробна версія' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free trial.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', NULL, 'year', 'Ціни на сайті.', 'Prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- F-Secure Total — Антивіруси та захист пристроїв
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'f-secure.com/en/total' OR LOWER(`name`) = 'f-secure total')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'F-Secure Total', NULL, 'https://www.f-secure.com/en/total', NULL, NULL, 'Антивірус, необмежений VPN, менеджер паролів і захист особистих даних в одній підписці F-Secure.', 'Antivirus, unlimited VPN, a password manager and identity protection in one F-Secure subscription.', 'F-Secure Total об''єднує в одному застосунку антивірус, VPN без обмежень трафіку, менеджер паролів і захист особистих даних для Windows, Mac, iOS та Android. Повну версію можна спробувати безкоштовно 30 днів, діє 30-денна гарантія повернення коштів і безкоштовна підтримка. Простіший варіант — F-Secure Internet Security.', 'F-Secure Total brings antivirus, a VPN with unlimited data, a password manager and identity protection into one app for Windows, Mac, iOS and Android. The full version can be tried free for 30 days, with a 30-day money-back guarantee and free support. A simpler option is F-Secure Internet Security.', 'Антивірус
VPN без обмежень трафіку
Менеджер паролів
Захист особистих даних', 'Antivirus
Unlimited VPN
Password manager
Identity protection', 'Людям і родинам, які хочуть усе в одній підписці.', 'Individuals and families who want everything in one subscription.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'f-secure.com/en/total' OR LOWER(`name`) = 'f-secure total') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Antivirus, unlimited VPN, a password manager and identity protection in one F-Secure subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'F-Secure Total brings antivirus, a VPN with unlimited data, a password manager and identity protection into one app for Windows, Mac, iOS and Android. The full version can be tried free for 30 days, with a 30-day money-back guarantee and free support. A simpler option is F-Secure Internet Security.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Antivirus
Unlimited VPN
Password manager
Identity protection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individuals and families who want everything in one subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '30 днів безкоштовно.', '30-day free trial.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '30-day free trial.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Total', 'Total', NULL, 'year', 'Від 69.99 на рік за 1 пристрій (валюта залежить від регіону).', 'From 69.99 per year for 1 device (currency depends on region).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Total' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Total', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From 69.99 per year for 1 device (currency depends on region).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Avira — Антивіруси та захист пристроїв
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'avira.com' OR LOWER(`name`) = 'avira')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Avira', NULL, 'https://www.avira.com', NULL, NULL, 'Безкоштовний антивірус і пакети захисту, приватності й прискорення для Windows, Mac, Android та iOS.', 'A free antivirus plus security, privacy and performance suites for Windows, Mac, Android and iOS.', 'Avira пропонує безкоштовне рішення з основними інструментами захисту та платні пакети: Prime з усіма преміум-застосунками, VPN без обмежень трафіку й інструментами прискорення системи. Програми доступні для Windows, Mac, Android та iOS. Для завантаження на Windows потрібна Windows 10 або 11.', 'Avira offers a free solution with the essential security tools and paid suites: Prime with all premium apps, a VPN with unlimited data and system speedup tools. Apps are available for Windows, Mac, Android and iOS. Windows downloads require Windows 10 or 11.', 'Безкоштовний антивірус
VPN без обмежень у платних планах
Прискорення системи
Для всіх платформ', 'Free antivirus
Unlimited VPN on paid plans
System speedup
All platforms', 'Домашнім користувачам, які шукають безкоштовний захист.', 'Home users looking for free protection.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'avira.com' OR LOWER(`name`) = 'avira') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free antivirus plus security, privacy and performance suites for Windows, Mac, Android and iOS.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Avira offers a free solution with the essential security tools and paid suites: Prime with all premium apps, a VPN with unlimited data and system speedup tools. Apps are available for Windows, Mac, Android and iOS. Windows downloads require Windows 10 or 11.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free antivirus
Unlimited VPN on paid plans
System speedup
All platforms', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home users looking for free protection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовне рішення з основними інструментами.', 'Free solution with essential tools.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free solution with essential tools.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Prime', 'Prime', NULL, 'year', 'Ціни на сайті.', 'Prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Prime' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Prime', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;


-- =================== Захист особистих даних / Identity & Data Protection ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'identity-protection' LIMIT 1);

-- Have I Been Pwned — Захист особистих даних
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'haveibeenpwned.com' OR LOWER(`name`) = 'have i been pwned')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Have I Been Pwned', NULL, 'https://haveibeenpwned.com', NULL, NULL, 'Безкоштовна перевірка, чи потрапляла ваша email-адреса у витоки даних, і сповіщення про нові витоки.', 'A free check whether your email address appeared in data breaches, with alerts about new ones.', 'Have I Been Pwned (HIBP) шукає вашу email-адресу серед десятків мільярдів записів із відомих витоків і показує хронологію, де саме дані було розкрито. Можна підписатися на сповіщення про нові витоки. Для команд безпеки, розробників і MSP є моніторинг корпоративних доменів, API, логи викрадачів даних і платні підписки.', 'Have I Been Pwned (HIBP) searches tens of billions of records from known breaches for your email address and shows a timeline of where your data was exposed. You can subscribe to alerts about new breaches. Security teams, developers and MSPs get corporate domain monitoring, an API, stealer logs and paid subscriptions.', 'Перевірка email у витоках
Сповіщення про нові витоки
Моніторинг доменів
API для розробників', 'Email breach check
Alerts about new breaches
Domain monitoring
API for developers', 'Усім користувачам інтернету, командам безпеки й розробникам.', 'All internet users, security teams and developers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'haveibeenpwned.com' OR LOWER(`name`) = 'have i been pwned') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free check whether your email address appeared in data breaches, with alerts about new ones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Have I Been Pwned (HIBP) searches tens of billions of records from known breaches for your email address and shows a timeline of where your data was exposed. You can subscribe to alerts about new breaches. Security teams, developers and MSPs get corporate domain monitoring, an API, stealer logs and paid subscriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Email breach check
Alerts about new breaches
Domain monitoring
API for developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'All internet users, security teams and developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Перевірка й сповіщення для особистих адрес безкоштовні.', 'Checks and alerts for personal addresses are free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Checks and alerts for personal addresses are free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписки', 'Subscriptions', NULL, 'month', 'API та розширені можливості — платні; ціни на сайті.', 'API and advanced features are paid; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписки' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscriptions', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'API and advanced features are paid; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aura — Захист особистих даних
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aura.com' OR LOWER(`name`) = 'aura')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aura', NULL, 'https://www.aura.com', NULL, NULL, 'Захист особистих даних, кредиту й фінансів: моніторинг, захист від шахрайства й страхування $1 млн (США).', 'Protection for your identity, credit and finances: monitoring, scam protection and $1M insurance (US).', 'Aura об''єднує моніторинг крадіжки особистості й кредиту, захист від шахрайських дзвінків і листів, батьківський контроль і моніторинг AI-застосунків. Кожен дорослий учасник отримує страхування $1 млн від збитків через крадіжку особистості, працює цілодобова підтримка фахівців із шахрайства в США. Будь-який план можна спробувати 14 днів безкоштовно; сервіс орієнтований на жителів США.', 'Aura combines identity theft and credit monitoring, protection from scam calls and emails, parental controls and AI app monitoring. Every adult member gets $1 million in identity theft insurance, backed by 24/7 US-based fraud specialists. Any plan can be tried free for 14 days; the service is aimed at US residents.', 'Моніторинг крадіжки особистості й кредиту
Захист від шахрайських дзвінків і листів
Страхування $1 млн
Цілодобова підтримка', 'Identity theft and credit monitoring
Scam call and email protection
$1M insurance
24/7 support', 'Жителям США й родинам, які хочуть комплексний захист особистих даних.', 'US residents and families who want complete identity protection.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aura.com' OR LOWER(`name`) = 'aura') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Protection for your identity, credit and finances: monitoring, scam protection and $1M insurance (US).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Aura combines identity theft and credit monitoring, protection from scam calls and emails, parental controls and AI app monitoring. Every adult member gets $1 million in identity theft insurance, backed by 24/7 US-based fraud specialists. Any plan can be tried free for 14 days; the service is aimed at US residents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Identity theft and credit monitoring
Scam call and email protection
$1M insurance
24/7 support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US residents and families who want complete identity protection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Individual', 'Individual', 10.00, 'month', 'Плани від $10 на місяць; 14 днів безкоштовно.', 'Plans start at $10 per month; 14-day free trial.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Individual' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Individual', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Plans start at $10 per month; 14-day free trial.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Family', 'Family', 32.00, 'month', '5 дорослих, необмежено дітей і пристроїв; $32 на місяць при оплаті за рік або $50 щомісяця.', '5 adults, unlimited kids and devices; $32 per month billed annually or $50 monthly.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Family' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Family', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '5 adults, unlimited kids and devices; $32 per month billed annually or $50 monthly.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DeleteMe — Захист особистих даних
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'joindeleteme.com' OR LOWER(`name`) = 'deleteme')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DeleteMe', NULL, 'https://joindeleteme.com', NULL, NULL, 'Сервіс, що знаходить і видаляє ваші особисті дані з сайтів брокерів даних і пошуку людей.', 'A service that finds and removes your personal data from data broker and people-search sites.', 'DeleteMe з 2011 року видаляє особисті дані з інтернету. Команда й власна технологія шукають вашу адресу, телефон та інші дані на сотнях сайтів брокерів і пошуку людей, надсилають запити на видалення й регулярно перевіряють, чи не з''явилися дані знову. Є плани на одну людину й сімейні.', 'DeleteMe has been removing personal data from the internet since 2011. Its team and technology find your address, phone number and other details on hundreds of data broker and people-search sites, submit removal requests and regularly check whether the data reappears. There are individual and family plans.', 'Пошук даних на сайтах брокерів
Запити на видалення
Регулярний повторний моніторинг
Сімейні плани', 'Search across data broker sites
Removal requests
Regular re-monitoring
Family plans', 'Людям, які хочуть прибрати свої дані з пошуку людей (переважно США).', 'People who want their data removed from people-search sites (mainly US).', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'joindeleteme.com' OR LOWER(`name`) = 'deleteme') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A service that finds and removes your personal data from data broker and people-search sites.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DeleteMe has been removing personal data from the internet since 2011. Its team and technology find your address, phone number and other details on hundreds of data broker and people-search sites, submit removal requests and regularly check whether the data reappears. There are individual and family plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Search across data broker sites
Removal requests
Regular re-monitoring
Family plans', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want their data removed from people-search sites (mainly US).', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'year', 'Плани на 1 рік для однієї людини чи родини; ціни на сайті.', 'One-year plans for an individual or family; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'One-year plans for an individual or family; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Incogni — Захист особистих даних
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'incogni.com' OR LOWER(`name`) = 'incogni')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Incogni', NULL, 'https://incogni.com', NULL, NULL, 'Автоматичне видалення ваших даних у брокерів даних: повторні запити, сімейний план і необмежені видалення.', 'Automatic removal of your data from data brokers: recurring requests, a family plan and unlimited removals.', 'Incogni від Surfshark надсилає брокерам даних запити на видалення ваших адреси, телефону й інших відомостей і повторює їх автоматично, щоб дані не з''являлися знову. Є плани Standard, Family (до 5 учасників) і Unlimited. Скасувати можна будь-коли, діє гарантія повернення коштів.', 'Incogni by Surfshark sends data brokers requests to remove your address, phone number and other details and repeats them automatically so the data does not reappear. There are Standard, Family (up to 5 members) and Unlimited plans. You can cancel anytime, and a money-back guarantee applies.', 'Автоматичні запити на видалення
Повторні видалення
Сімейний план до 5 учасників
Скасування будь-коли', 'Automatic removal requests
Recurring removals
Family plan for up to 5 members
Cancel anytime', 'Людям, які хочуть менше спаму, дзвінків і ризику шахрайства.', 'People who want less spam, fewer calls and lower fraud risk.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'incogni.com' OR LOWER(`name`) = 'incogni') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Automatic removal of your data from data brokers: recurring requests, a family plan and unlimited removals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Incogni by Surfshark sends data brokers requests to remove your address, phone number and other details and repeats them automatically so the data does not reappear. There are Standard, Family (up to 5 members) and Unlimited plans. You can cancel anytime, and a money-back guarantee applies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic removal requests
Recurring removals
Family plan for up to 5 members
Cancel anytime', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want less spam, fewer calls and lower fraud risk.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Standard', 'Standard', 7.19, 'month', '$86.29 за перший рік, далі $95.88 на рік.', '$86.29 for the first year, then $95.88 per year.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Standard' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Standard', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$86.29 for the first year, then $95.88 per year.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Family', 'Family', 14.39, 'month', 'До 5 учасників; $172.69 за перший рік, далі $191.88.', 'Up to 5 members; $172.69 for the first year, then $191.88.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Family' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Family', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Up to 5 members; $172.69 for the first year, then $191.88.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Unlimited', 'Unlimited', 13.49, 'month', 'Необмежені видалення; оплата за рік.', 'Unlimited removals; billed annually.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Unlimited' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Unlimited', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Unlimited removals; billed annually.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Optery — Захист особистих даних
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'optery.com' OR LOWER(`name`) = 'optery')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Optery', NULL, 'https://www.optery.com', NULL, NULL, 'Видалення особистих даних із Google і понад 700 сайтів брокерів: безкоштовне сканування й плани за рік.', 'Removal of personal data from Google and 700+ data broker sites: a free scan and yearly plans.', 'Optery сканує сайти брокерів даних і пошуку людей, показує, де опубліковано ваші дані, і автоматично надсилає запити на видалення. Плани відрізняються охопленням — від 380+ сайтів у Core до понад 945 у старших планах із необмеженими власними запитами. Є безкоштовне сканування, рішення для бізнесу й 30-денна гарантія повернення коштів для особистих акаунтів.', 'Optery scans data broker and people-search sites, shows where your data is published and automatically sends removal requests. Plans differ in coverage — from 380+ sites on Core to 945+ on higher tiers with unlimited custom removal requests. There is a free scan, a business offering and a 30-day money-back guarantee for individual accounts.', 'Безкоштовне сканування
Автоматичні запити на видалення
Щомісячні повторні сканування
Рішення для бізнесу', 'Free scan
Automatic removal requests
Monthly re-scans
Business solution', 'Людям і компаніям, які хочуть прибрати дані з пошуку людей.', 'Individuals and companies that want data removed from people-search sites.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'optery.com' OR LOWER(`name`) = 'optery') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Removal of personal data from Google and 700+ data broker sites: a free scan and yearly plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Optery scans data broker and people-search sites, shows where your data is published and automatically sends removal requests. Plans differ in coverage — from 380+ sites on Core to 945+ on higher tiers with unlimited custom removal requests. There is a free scan, a business offering and a 30-day money-back guarantee for individual accounts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free scan
Automatic removal requests
Monthly re-scans
Business solution', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individuals and companies that want data removed from people-search sites.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовне сканування.', 'Free scan.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free scan.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Core', 'Core', 39.00, 'year', 'Видалення з 380+ сайтів.', 'Removal from 380+ sites.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Core' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Core', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Removal from 380+ sites.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Extended', 'Extended', 149.00, 'year', 'Видалення з 555+ сайтів.', 'Removal from 555+ sites.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Extended' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Extended', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Removal from 555+ sites.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ultimate', 'Ultimate', 249.00, 'year', 'Видалення з 945+ сайтів і необмежені власні запити.', 'Removal from 945+ sites and unlimited custom requests.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ultimate' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Ultimate', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Removal from 945+ sites and unlimited custom requests.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mozilla Monitor — Захист особистих даних
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'monitor.mozilla.org' OR LOWER(`name`) = 'mozilla monitor')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mozilla Monitor', NULL, 'https://monitor.mozilla.org', NULL, NULL, 'Безкоштовна перевірка від Mozilla, чи потрапили ваші дані у витоки, з порадами, що робити далі.', 'A free check from Mozilla of whether your data was leaked in breaches, with advice on what to do next.', 'Mozilla Monitor перевіряє вашу email-адресу в усіх відомих витоках даних, пояснює, які відомості розкрито, і дає покрокові поради, як захиститися. Сервіс постійно стежить за новими витоками й надсилає сповіщення. Моніторинг витоків завжди безкоштовний.', 'Mozilla Monitor checks your email address against all known data breaches, explains what information was exposed and gives step-by-step advice on how to protect yourself. It keeps watching for new breaches and sends alerts. Breach monitoring is always free.', 'Перевірка у відомих витоках
Покрокові поради
Сповіщення про нові витоки
Безкоштовно', 'Check against known breaches
Step-by-step advice
Alerts about new breaches
Free', 'Усім користувачам, які хочуть знати про витоки своїх даних.', 'All users who want to know about leaks of their data.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'monitor.mozilla.org' OR LOWER(`name`) = 'mozilla monitor') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free check from Mozilla of whether your data was leaked in breaches, with advice on what to do next.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mozilla Monitor checks your email address against all known data breaches, explains what information was exposed and gives step-by-step advice on how to protect yourself. It keeps watching for new breaches and sends alerts. Breach monitoring is always free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Check against known breaches
Step-by-step advice
Alerts about new breaches
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'All users who want to know about leaks of their data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Моніторинг витоків безкоштовний.', 'Breach monitoring is free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Breach monitoring is free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;


-- =================== Безпека бізнесу / Business Security ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'business-security' LIMIT 1);

-- CrowdStrike Falcon — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'crowdstrike.com' OR LOWER(`name`) = 'crowdstrike falcon')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CrowdStrike Falcon', NULL, 'https://www.crowdstrike.com', NULL, NULL, 'Хмарна AI-платформа захисту кінцевих пристроїв, хмарних навантажень і облікових записів від зламів.', 'A cloud-native AI platform protecting endpoints, cloud workloads and identities from breaches.', 'CrowdStrike Falcon захищає комп''ютери, сервери, хмарні навантаження, облікові записи й дані з єдиної хмарної платформи. Вона безперервно бачить активність на пристроях, автоматично виявляє й пріоритизує шкідливу поведінку та допомагає зупинити злам. Для малого й середнього бізнесу є пакети з оплатою за пристрій і 15-денний безкоштовний пробний період.', 'CrowdStrike Falcon protects computers, servers, cloud workloads, identities and data from a single cloud-native platform. It continuously monitors device activity, automatically detects and prioritizes malicious behaviour and helps stop breaches. Small and mid-sized businesses can buy per-device packages, with a 15-day free trial.', 'Захист кінцевих пристроїв (EDR)
Захист хмари й облікових записів
Автоматична пріоритизація загроз
Керування брандмауером хостів', 'Endpoint protection (EDR)
Cloud and identity protection
Automatic threat prioritization
Host firewall management', 'Компаніям від малого бізнесу до корпорацій.', 'Organizations from small businesses to enterprises.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'crowdstrike.com' OR LOWER(`name`) = 'crowdstrike falcon') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A cloud-native AI platform protecting endpoints, cloud workloads and identities from breaches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CrowdStrike Falcon protects computers, servers, cloud workloads, identities and data from a single cloud-native platform. It continuously monitors device activity, automatically detects and prioritizes malicious behaviour and helps stop breaches. Small and mid-sized businesses can buy per-device packages, with a 15-day free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Endpoint protection (EDR)
Cloud and identity protection
Automatic threat prioritization
Host firewall management', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Organizations from small businesses to enterprises.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '15 днів безкоштовно.', '15-day free trial.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '15-day free trial.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Security Essentials', 'Security Essentials', 7.99, 'month', 'За пристрій на місяць.', 'Per device per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Security Essentials' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Security Essentials', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per device per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 14.99, 'month', 'За пристрій на місяць; додає керування брандмауером.', 'Per device per month; adds firewall management.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per device per month; adds firewall management.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', 19.99, 'month', 'За пристрій на місяць; повна видимість і виявлення загроз.', 'Per device per month; full visibility and threat detection.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per device per month; full visibility and threat detection.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SentinelOne Singularity — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sentinelone.com' OR LOWER(`name`) = 'sentinelone singularity')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SentinelOne Singularity', NULL, 'https://www.sentinelone.com', NULL, NULL, 'AI-платформа корпоративної безпеки: захист кінцевих пристроїв, хмари, облікових записів і даних в одному рішенні.', 'An AI-powered enterprise security platform: endpoint, cloud, identity and data protection in one solution.', 'SentinelOne Singularity об''єднує захист, виявлення й реагування для кінцевих пристроїв, хмари, облікових записів і даних з озером даних безпеки Security Data Lake. Платформа автономно реагує на загрози з машинною швидкістю, має інтеграції в один клік і рішення для охорони здоров''я, фінансів, держсектору (FedRAMP High) та промислових систем.', 'SentinelOne Singularity unifies protection, detection and response for endpoints, cloud, identities and data with its Security Data Lake. The platform responds to threats autonomously at machine speed, offers one-click integrations and has solutions for healthcare, finance, government (FedRAMP High) and industrial systems.', 'Захист кінцевих пристроїв і хмари
Захист облікових записів
Security Data Lake
Автономне реагування', 'Endpoint and cloud protection
Identity protection
Security Data Lake
Autonomous response', 'Середнім і великим компаніям та держустановам.', 'Mid-sized and large companies and government agencies.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sentinelone.com' OR LOWER(`name`) = 'sentinelone singularity') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI-powered enterprise security platform: endpoint, cloud, identity and data protection in one solution.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SentinelOne Singularity unifies protection, detection and response for endpoints, cloud, identities and data with its Security Data Lake. The platform responds to threats autonomously at machine speed, offers one-click integrations and has solutions for healthcare, finance, government (FedRAMP High) and industrial systems.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Endpoint and cloud protection
Identity protection
Security Data Lake
Autonomous response', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mid-sized and large companies and government agencies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Ціна за запитом.', 'Pricing on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Darktrace — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'darktrace.com' OR LOWER(`name`) = 'darktrace')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Darktrace', NULL, 'https://www.darktrace.com', NULL, NULL, 'AI-платформа кібербезпеки, що вивчає «норму» вашої мережі й зупиняє аномальні атаки.', 'An AI cybersecurity platform that learns your network''s normal behaviour and stops anomalous attacks.', 'Darktrace використовує поведінковий AI, щоб зрозуміти звичну активність людей і пристроїв в організації та помічати відхилення, що вказують на атаку. Платформа захищає мережу, пошту, хмару й інші вектори атак і може автономно стримувати загрози. Компанію використовують понад 10 000 клієнтів, доступний безкоштовний пробний період.', 'Darktrace uses behavioural AI to learn the normal activity of people and devices in an organization and spot deviations that signal an attack. The platform protects the network, email, cloud and other attack vectors and can contain threats autonomously. It serves over 10,000 customers, and a free trial is available.', 'Поведінковий AI
Захист мережі (NDR)
Захист пошти й хмари
Автономне стримування атак', 'Behavioural AI
Network detection and response (NDR)
Email and cloud protection
Autonomous attack containment', 'Компаніям із власною ІТ-інфраструктурою й командою безпеки.', 'Companies with their own IT infrastructure and security team.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'darktrace.com' OR LOWER(`name`) = 'darktrace') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI cybersecurity platform that learns your network''s normal behaviour and stops anomalous attacks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Darktrace uses behavioural AI to learn the normal activity of people and devices in an organization and spot deviations that signal an attack. The platform protects the network, email, cloud and other attack vectors and can contain threats autonomously. It serves over 10,000 customers, and a free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Behavioural AI
Network detection and response (NDR)
Email and cloud protection
Autonomous attack containment', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Companies with their own IT infrastructure and security team.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', 'Є безкоштовний пробний період.', 'Free trial available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free trial available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Ціна за запитом.', 'Pricing on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Microsoft Security Copilot — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'microsoft.com/en-us/security/business/ai-machine-learning/microsoft-security-copilot' OR LOWER(`name`) = 'microsoft security copilot')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Microsoft Security Copilot', NULL, 'https://www.microsoft.com/en-us/security/business/ai-machine-learning/microsoft-security-copilot', NULL, NULL, 'Генеративний AI і агенти для команд безпеки в Microsoft Defender, Entra, Intune і Purview.', 'Generative AI and agents for security teams across Microsoft Defender, Entra, Intune and Purview.', 'Microsoft Security Copilot допомагає командам безпеки виявляти, розслідувати й реагувати на інциденти швидше. Він стискає великі обсяги сигналів до ключових висновків, дає покрокові підказки й аналіз щодо облікових записів, пристроїв, даних, хмари й застосунків, а AI-агенти автоматизують рутинні процеси. Працює всередині Microsoft Defender, Entra, Intune і Purview, має готові сценарії (promptbooks).', 'Microsoft Security Copilot helps security teams detect, investigate and respond to incidents faster. It condenses large volumes of signals into key insights, gives step-by-step guidance and analysis across identities, devices, data, clouds and apps, and AI agents automate routine processes. It works inside Microsoft Defender, Entra, Intune and Purview and includes ready-made promptbooks.', 'AI-підсумки інцидентів
AI-агенти для автоматизації
Інтеграція з Defender, Entra, Intune, Purview
Готові сценарії promptbooks', 'AI incident summaries
AI agents for automation
Integration with Defender, Entra, Intune, Purview
Ready-made promptbooks', 'Командам безпеки й ІТ в організаціях на стеку Microsoft.', 'Security and IT teams in organizations on the Microsoft stack.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'microsoft.com/en-us/security/business/ai-machine-learning/microsoft-security-copilot' OR LOWER(`name`) = 'microsoft security copilot') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Generative AI and agents for security teams across Microsoft Defender, Entra, Intune and Purview.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Microsoft Security Copilot helps security teams detect, investigate and respond to incidents faster. It condenses large volumes of signals into key insights, gives step-by-step guidance and analysis across identities, devices, data, clouds and apps, and AI agents automate routine processes. It works inside Microsoft Defender, Entra, Intune and Purview and includes ready-made promptbooks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI incident summaries
AI agents for automation
Integration with Defender, Entra, Intune, Purview
Ready-made promptbooks', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Security and IT teams in organizations on the Microsoft stack.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', 'Є безкоштовний пробний період.', 'Free trial available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free trial available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Оплата за використання', 'Usage-based', NULL, 'month', 'Оплата за спожиті обчислювальні одиниці; ціни на сайті Microsoft.', 'Pay for consumed compute units; prices on the Microsoft site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Оплата за використання' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Usage-based', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pay for consumed compute units; prices on the Microsoft site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Cortex XSIAM — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'paloaltonetworks.com/cortex/cortex-xsiam' OR LOWER(`name`) = 'cortex xsiam')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cortex XSIAM', NULL, 'https://www.paloaltonetworks.com/cortex/cortex-xsiam', NULL, NULL, 'AI-платформа центру безпеки (SOC) від Palo Alto Networks: єдині дані, автоматичне розслідування й реагування.', 'An AI-driven SOC platform from Palo Alto Networks: unified data, automated triage and response.', 'Cortex XSIAM замінює розрізнені інструменти центру безпеки однією платформою з єдиними даними, автоматизацією й AI. Вона відсіює шум, показує реальні загрози, автоматично сортує інциденти й підказує дії, щоб реагувати за хвилини. Містить понад 10 000 правил виявлення та 2600 аналітичних моделей.', 'Cortex XSIAM replaces siloed SOC tools with one platform built on unified data, automation and AI. It cuts through noise, surfaces real threats, triages incidents automatically and guides actions so teams can respond in minutes. It includes 10,000+ detections and 2,600+ analytics models.', 'Єдина платформа SOC
Автоматичне сортування інцидентів
10 000+ правил виявлення
Автоматизація реагування', 'Unified SOC platform
Automated incident triage
10,000+ detections
Response automation', 'Великим компаніям із власним центром безпеки.', 'Large companies with their own security operations center.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'paloaltonetworks.com/cortex/cortex-xsiam' OR LOWER(`name`) = 'cortex xsiam') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI-driven SOC platform from Palo Alto Networks: unified data, automated triage and response.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Cortex XSIAM replaces siloed SOC tools with one platform built on unified data, automation and AI. It cuts through noise, surfaces real threats, triages incidents automatically and guides actions so teams can respond in minutes. It includes 10,000+ detections and 2,600+ analytics models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Unified SOC platform
Automated incident triage
10,000+ detections
Response automation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Large companies with their own security operations center.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Ціна за запитом.', 'Pricing on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Abnormal AI — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'abnormal.ai' OR LOWER(`name`) = 'abnormal ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Abnormal AI', NULL, 'https://abnormal.ai', NULL, NULL, 'Поведінковий AI для захисту пошти, облікових записів і AI-інструментів від фішингу та внутрішніх загроз.', 'Behavioural AI that protects email, identities and AI tools from phishing and insider threats.', 'Abnormal AI вивчає звичну поведінку людей і постачальників у компанії, щоб зупиняти фішинг, компрометацію ділової пошти й захоплення облікових записів, які пропускають класичні фільтри. Платформа також захищає облікові записи, використання AI-інструментів і виявляє внутрішні загрози. Нею користуються понад 5000 організацій.', 'Abnormal AI learns the normal behaviour of people and vendors in a company to stop phishing, business email compromise and account takeover that traditional filters miss. The platform also protects identities and the use of AI tools and detects insider threats. More than 5,000 organizations use it.', 'Захист пошти від фішингу
Виявлення компрометації ділової пошти
Захист облікових записів
Безпека використання AI', 'Email phishing protection
Business email compromise detection
Identity protection
AI usage security', 'Компаніям на Microsoft 365 і Google Workspace.', 'Companies on Microsoft 365 and Google Workspace.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'abnormal.ai' OR LOWER(`name`) = 'abnormal ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Behavioural AI that protects email, identities and AI tools from phishing and insider threats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Abnormal AI learns the normal behaviour of people and vendors in a company to stop phishing, business email compromise and account takeover that traditional filters miss. The platform also protects identities and the use of AI tools and detects insider threats. More than 5,000 organizations use it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Email phishing protection
Business email compromise detection
Identity protection
AI usage security', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Companies on Microsoft 365 and Google Workspace.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Ціна за запитом.', 'Pricing on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Wiz Cloud Security — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wiz.io' OR LOWER(`name`) = 'wiz cloud security')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wiz Cloud Security', NULL, 'https://www.wiz.io', NULL, NULL, 'Платформа хмарної безпеки, що поєднує код, хмару й рантайм в одному графі контексту з AI.', 'A cloud security platform that connects code, cloud and runtime in one AI-powered context graph.', 'Wiz сканує хмарні середовища (AWS, Azure, Google Cloud та інші) і AI-застосунки, зводячи код, конфігурації й роботу в рантаймі в єдиний граф контексту. Це дає змогу знаходити ризики, які реально можна експлуатувати, виправляти їх у джерелі, зупиняти атаки в реальному часі й ловити проблеми ще в IDE. Платформою користуються понад 65% компаній Fortune 100.', 'Wiz scans cloud environments (AWS, Azure, Google Cloud and more) and AI applications, bringing code, configuration and runtime into a single context graph. This lets teams find exploitable risks, fix them at the source, stop attacks in real time and catch issues as early as the IDE. More than 65% of Fortune 100 companies use it.', 'Безагентне сканування хмари
Граф контексту ризиків
Захист AI-застосунків
Виявлення загроз у рантаймі', 'Agentless cloud scanning
Risk context graph
AI application security
Runtime threat detection', 'Командам безпеки й DevOps у компаніях із хмарною інфраструктурою.', 'Security and DevOps teams at companies with cloud infrastructure.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wiz.io' OR LOWER(`name`) = 'wiz cloud security') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A cloud security platform that connects code, cloud and runtime in one AI-powered context graph.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Wiz scans cloud environments (AWS, Azure, Google Cloud and more) and AI applications, bringing code, configuration and runtime into a single context graph. This lets teams find exploitable risks, fix them at the source, stop attacks in real time and catch issues as early as the IDE. More than 65% of Fortune 100 companies use it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Agentless cloud scanning
Risk context graph
AI application security
Runtime threat detection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Security and DevOps teams at companies with cloud infrastructure.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Ціна за запитом.', 'Pricing on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Okta — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'okta.com' OR LOWER(`name`) = 'okta')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Okta', NULL, 'https://www.okta.com', NULL, NULL, 'Платформа керування доступом і обліковими записами: єдиний вхід (SSO), MFA, автоматизація й захист AI-агентів.', 'An identity and access platform: single sign-on (SSO), MFA, automation and protection for AI agents.', 'Okta дає працівникам, клієнтам і партнерам безпечний вхід у всі застосунки: єдиний вхід (SSO), багатофакторну автентифікацію, керування життєвим циклом облікових записів і no-code Workflows з готовими конекторами. Платформи Okta й Auth0 також захищають ідентичності AI-агентів. Пакети продаються за користувача на місяць при оплаті за рік.', 'Okta gives employees, customers and partners secure access to all their apps: single sign-on (SSO), multi-factor authentication, account lifecycle management and no-code Workflows with prebuilt connectors. The Okta and Auth0 platforms also secure AI agent identities. Suites are sold per user per month, billed annually.', 'Єдиний вхід (SSO)
Багатофакторна автентифікація
No-code Workflows
Захист ідентичностей AI-агентів', 'Single sign-on (SSO)
Multi-factor authentication
No-code Workflows
AI agent identity security', 'ІТ-командам компаній будь-якого розміру.', 'IT teams at companies of any size.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'okta.com' OR LOWER(`name`) = 'okta') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An identity and access platform: single sign-on (SSO), MFA, automation and protection for AI agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Okta gives employees, customers and partners secure access to all their apps: single sign-on (SSO), multi-factor authentication, account lifecycle management and no-code Workflows with prebuilt connectors. The Okta and Auth0 platforms also secure AI agent identities. Suites are sold per user per month, billed annually.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Single sign-on (SSO)
Multi-factor authentication
No-code Workflows
AI agent identity security', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'IT teams at companies of any size.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', 6.00, 'month', 'За користувача на місяць, оплата за рік.', 'Per user per month, billed annually.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per user per month, billed annually.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Core Essentials', 'Core Essentials', 14.00, 'month', 'За користувача на місяць, оплата за рік.', 'Per user per month, billed annually.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Core Essentials' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Core Essentials', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per user per month, billed annually.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Essentials', 'Essentials', 17.00, 'month', 'За користувача на місяць, оплата за рік.', 'Per user per month, billed annually.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Essentials' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Essentials', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per user per month, billed annually.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Cloudflare One — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cloudflare.com/zero-trust' OR LOWER(`name`) = 'cloudflare one')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cloudflare One', NULL, 'https://www.cloudflare.com/zero-trust/', NULL, NULL, 'SASE-платформа Cloudflare: доступ zero trust без VPN, захист SaaS і безпечне підключення AI-агентів.', 'Cloudflare''s SASE platform: zero trust access without a VPN, SaaS protection and secure connections for AI agents.', 'Cloudflare One дає працівникам, підрядникам і AI-агентам доступ до застосунків за принципом zero trust без класичного VPN. Платформа поєднує ZTNA і CASB для захисту SaaS і внутрішніх застосунків, ізоляцію ризикових посилань, підключення офісів і дата-центрів через Magic WAN та захист підключень до MCP-серверів. Є безкоштовний план для пілотного запуску.', 'Cloudflare One gives employees, contractors and AI agents zero trust access to applications without a traditional VPN. The platform combines ZTNA and CASB to protect SaaS and internal apps, isolates risky links, connects offices and data centers via Magic WAN and secures connections to MCP servers. A free plan is available for a proof of concept.', 'Доступ zero trust без VPN
ZTNA і CASB
Ізоляція ризикових посилань
Захист підключень до MCP-серверів', 'Zero trust access without VPN
ZTNA and CASB
Risky link isolation
Secure MCP server connections', 'Компаніям, що переходять від VPN до zero trust.', 'Companies moving from VPN to zero trust.', 'web,desktop,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cloudflare.com/zero-trust' OR LOWER(`name`) = 'cloudflare one') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Cloudflare''s SASE platform: zero trust access without a VPN, SaaS protection and secure connections for AI agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Cloudflare One gives employees, contractors and AI agents zero trust access to applications without a traditional VPN. The platform combines ZTNA and CASB to protect SaaS and internal apps, isolates risky links, connects offices and data centers via Magic WAN and secures connections to MCP servers. A free plan is available for a proof of concept.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Zero trust access without VPN
ZTNA and CASB
Risky link isolation
Secure MCP server connections', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Companies moving from VPN to zero trust.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний план для старту.', 'Free plan to get started.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free plan to get started.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Ціна за запитом.', 'Pricing on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tailscale — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tailscale.com' OR LOWER(`name`) = 'tailscale')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tailscale', NULL, 'https://tailscale.com', NULL, NULL, 'Захищена мережа між пристроями, серверами й хмарами на основі WireGuard з доступом zero trust за ідентичністю.', 'A secure network between devices, servers and clouds built on WireGuard, with identity-based zero trust access.', 'Tailscale об''єднує ноутбуки, сервери, хмарні ресурси, IoT і AI-навантаження в приватну мережу з прямими зашифрованими з''єднаннями. Доступ задається політиками за ідентичністю користувача, розгортання займає хвилини. Особистий план безкоштовний до 6 користувачів; Standard і Premium додають більше груп доступу, SSH, Kubernetes, JIT-доступ і вимоги комплаєнсу.', 'Tailscale joins laptops, servers, cloud resources, IoT and AI workloads into a private network with direct encrypted connections. Access is controlled by identity-based policies, and deployment takes minutes. The Personal plan is free for up to 6 users; Standard and Premium add more access groups, SSH, Kubernetes, just-in-time access and compliance features.', 'Пряма зашифрована мережа (WireGuard)
Політики доступу за ідентичністю
SSH і Kubernetes
Інтеграція з Mullvad для приватного інтернету', 'Direct encrypted mesh (WireGuard)
Identity-based access policies
SSH and Kubernetes
Mullvad integration for private browsing', 'Розробникам, ІТ-командам і компаніям, що замінюють VPN.', 'Developers, IT teams and companies replacing a VPN.', 'web,desktop,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tailscale.com' OR LOWER(`name`) = 'tailscale') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A secure network between devices, servers and clouds built on WireGuard, with identity-based zero trust access.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tailscale joins laptops, servers, cloud resources, IoT and AI workloads into a private network with direct encrypted connections. Access is controlled by identity-based policies, and deployment takes minutes. The Personal plan is free for up to 6 users; Standard and Premium add more access groups, SSH, Kubernetes, just-in-time access and compliance features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Direct encrypted mesh (WireGuard)
Identity-based access policies
SSH and Kubernetes
Mullvad integration for private browsing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers, IT teams and companies replacing a VPN.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Personal', 'Personal', 0.00, 'free', 'Безкоштовно до 6 користувачів.', 'Free for up to 6 users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Personal' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Personal', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for up to 6 users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Standard', 'Standard', 8.00, 'month', 'За користувача на місяць.', 'Per user per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Standard' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Standard', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per user per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', 18.00, 'month', 'За користувача на місяць; комплаєнс і JIT-доступ.', 'Per user per month; compliance and just-in-time access.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per user per month; compliance and just-in-time access.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Vanta — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vanta.com' OR LOWER(`name`) = 'vanta')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vanta', NULL, 'https://www.vanta.com', NULL, NULL, 'Автоматизація відповідності SOC 2, ISO 27001, HIPAA, PCI і GDPR: збір доказів, ризики й анкети безпеки з AI.', 'Compliance automation for SOC 2, ISO 27001, HIPAA, PCI and GDPR: evidence collection, risk and AI security questionnaires.', 'Vanta автоматизує підготовку до аудитів безпеки й підтримку відповідності стандартам SOC 2, ISO 27001, HIPAA, PCI та GDPR. Платформа збирає докази, контролює доступи, допомагає керувати ризиками й перевіркою постачальників, автоматично заповнює анкети безпеки з AI та показує клієнтам ваш статус відповідності в Trust Center.', 'Vanta automates audit preparation and ongoing compliance with SOC 2, ISO 27001, HIPAA, PCI and GDPR. The platform collects evidence, monitors access, helps manage risk and vendor reviews, fills in security questionnaires with AI and shows customers your compliance status in a Trust Center.', 'Автоматичний збір доказів для аудиту
Керування ризиками й постачальниками
AI-відповіді на анкети безпеки
Trust Center для клієнтів', 'Automated audit evidence collection
Risk and vendor management
AI answers to security questionnaires
Trust Center for customers', 'Стартапам і компаніям, яким потрібні сертифікати безпеки.', 'Startups and companies that need security certifications.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vanta.com' OR LOWER(`name`) = 'vanta') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Compliance automation for SOC 2, ISO 27001, HIPAA, PCI and GDPR: evidence collection, risk and AI security questionnaires.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vanta automates audit preparation and ongoing compliance with SOC 2, ISO 27001, HIPAA, PCI and GDPR. The platform collects evidence, monitors access, helps manage risk and vendor reviews, fills in security questionnaires with AI and shows customers your compliance status in a Trust Center.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automated audit evidence collection
Risk and vendor management
AI answers to security questionnaires
Trust Center for customers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Startups and companies that need security certifications.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Ціна за запитом.', 'Pricing on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Drata — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'drata.com' OR LOWER(`name`) = 'drata')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Drata', NULL, 'https://drata.com', NULL, NULL, 'Платформа керування довірою й відповідністю з AI-агентами: автоматичний комплаєнс і ризики третіх сторін.', 'A trust and compliance platform with AI agents: automated compliance and third-party risk management.', 'Drata використовує автономних AI-агентів, щоб автоматизувати відповідність стандартам безпеки, керувати внутрішніми ризиками й ризиками постачальників і безперервно підтверджувати рівень захисту компанії. До платформи входить SafeBase — Trust Center для обміну документами безпеки з клієнтами.', 'Drata uses autonomous AI agents to automate compliance with security frameworks, manage internal and third-party risk and continuously prove a company''s security posture. The platform includes SafeBase, a Trust Center for sharing security documentation with customers.', 'Автоматизація комплаєнсу
Керування ризиками постачальників
AI-агенти
Trust Center SafeBase', 'Compliance automation
Third-party risk management
AI agents
SafeBase Trust Center', 'Компаніям, що проходять аудити SOC 2, ISO 27001 тощо.', 'Companies going through SOC 2, ISO 27001 and similar audits.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'drata.com' OR LOWER(`name`) = 'drata') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A trust and compliance platform with AI agents: automated compliance and third-party risk management.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Drata uses autonomous AI agents to automate compliance with security frameworks, manage internal and third-party risk and continuously prove a company''s security posture. The platform includes SafeBase, a Trust Center for sharing security documentation with customers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Compliance automation
Third-party risk management
AI agents
SafeBase Trust Center', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Companies going through SOC 2, ISO 27001 and similar audits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Ціна за запитом.', 'Pricing on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Huntress — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'huntress.com' OR LOWER(`name`) = 'huntress')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Huntress', NULL, 'https://www.huntress.com', NULL, NULL, 'Керована платформа безпеки з цілодобовим SOC: EDR, захист облікових записів, SIEM і навчання працівників.', 'A managed security platform with a 24/7 SOC: EDR, identity protection, SIEM and security awareness training.', 'Huntress поєднує керований захист кінцевих пристроїв (EDR), захист облікових записів і пошти Microsoft 365 та Google Workspace (ITDR), SIEM і навчання працівників безпеці. Кожне сповіщення розслідує AI-агент разом з аналітиками цілодобового SOC. Ціна залежить від кількості пристроїв, облікових записів, учнів і джерел даних.', 'Huntress combines managed endpoint detection and response (EDR), identity and email protection for Microsoft 365 and Google Workspace (ITDR), SIEM and security awareness training. Every alert is investigated by an AI agent together with 24/7 SOC analysts. Pricing depends on endpoints, identities, learners and data sources.', 'Керований EDR
Захист Microsoft 365 і Google Workspace
SIEM
Навчання працівників безпеці', 'Managed EDR
Microsoft 365 and Google Workspace protection
SIEM
Security awareness training', 'Малому й середньому бізнесу та MSP.', 'Small and mid-sized businesses and MSPs.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'huntress.com' OR LOWER(`name`) = 'huntress') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A managed security platform with a 24/7 SOC: EDR, identity protection, SIEM and security awareness training.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Huntress combines managed endpoint detection and response (EDR), identity and email protection for Microsoft 365 and Google Workspace (ITDR), SIEM and security awareness training. Every alert is investigated by an AI agent together with 24/7 SOC analysts. Pricing depends on endpoints, identities, learners and data sources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Managed EDR
Microsoft 365 and Google Workspace protection
SIEM
Security awareness training', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Small and mid-sized businesses and MSPs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Managed', 'Managed', NULL, 'month', 'Ціна за пристрої, облікові записи й джерела даних; за запитом.', 'Priced by endpoints, identities and data sources; on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Managed' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Managed', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Priced by endpoints, identities and data sources; on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Google Security Operations — Безпека бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cloud.google.com/security/products/security-operations' OR LOWER(`name`) = 'google security operations')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Google Security Operations', NULL, 'https://cloud.google.com/security/products/security-operations', NULL, NULL, 'Хмарна платформа SecOps від Google (раніше Chronicle): SIEM, розвідка загроз і генеративний AI для аналітиків.', 'Google''s cloud-native SecOps platform (formerly Chronicle): SIEM, threat intelligence and generative AI for analysts.', 'Google Security Operations допомагає командам безпеки виявляти, розслідувати й реагувати на загрози з масштабом Google. Платформа приймає й аналізує великі обсяги даних, застосовує розвідку загроз Google, має готові правила виявлення й дозволяє писати власні, а генеративний AI дає змогу шукати й розслідувати природною мовою.', 'Google Security Operations helps security teams detect, investigate and respond to threats at Google scale. The platform ingests and analyzes large volumes of data, applies Google threat intelligence, ships curated detections and supports custom rules, while generative AI lets analysts search and investigate in natural language.', 'Хмарний SIEM
Розвідка загроз Google
Готові й власні правила виявлення
Пошук природною мовою', 'Cloud-native SIEM
Google threat intelligence
Curated and custom detections
Natural language search', 'Великим компаніям і центрам безпеки (SOC).', 'Large companies and security operations centers (SOC).', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cloud.google.com/security/products/security-operations' OR LOWER(`name`) = 'google security operations') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Google''s cloud-native SecOps platform (formerly Chronicle): SIEM, threat intelligence and generative AI for analysts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Google Security Operations helps security teams detect, investigate and respond to threats at Google scale. The platform ingests and analyzes large volumes of data, applies Google threat intelligence, ships curated detections and supports custom rules, while generative AI lets analysts search and investigate in natural language.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cloud-native SIEM
Google threat intelligence
Curated and custom detections
Natural language search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Large companies and security operations centers (SOC).', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Ціна за запитом.', 'Pricing on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;


-- =================== Безпека коду та застосунків / Application Security ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'appsec' LIMIT 1);

-- Semgrep — Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'semgrep.dev' OR LOWER(`name`) = 'semgrep')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Semgrep', NULL, 'https://semgrep.dev', NULL, NULL, 'Платформа безпеки коду з AI: статичний аналіз (SAST), перевірка залежностей (SCA) і пошук секретів.', 'An AI-assisted code security platform: static analysis (SAST), dependency scanning (SCA) and secrets detection.', 'Semgrep сканує вихідний код і знаходить реальні вразливості з мінімумом хибних спрацювань. Модулі Code (SAST), Supply Chain (SCA) і Secrets можна підключати окремо; вбудований AI допомагає з виявленням, сортуванням і виправленням. Підключення через GitHub/GitLab і розгортання в CI/CD в один клік. До 10 учасників — безкоштовно.', 'Semgrep scans source code and surfaces real vulnerabilities with minimal noise. Code (SAST), Supply Chain (SCA) and Secrets modules can be chosen separately; built-in AI helps with detection, triage and remediation. It connects via GitHub/GitLab and deploys to CI/CD in one click. Free for up to 10 contributors.', 'Статичний аналіз коду (SAST)
Перевірка залежностей (SCA)
Пошук секретів
AI-сортування й виправлення', 'Static analysis (SAST)
Dependency scanning (SCA)
Secrets detection
AI triage and remediation', 'Розробникам і командам безпеки застосунків.', 'Developers and application security teams.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'semgrep.dev' OR LOWER(`name`) = 'semgrep') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI-assisted code security platform: static analysis (SAST), dependency scanning (SCA) and secrets detection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Semgrep scans source code and surfaces real vulnerabilities with minimal noise. Code (SAST), Supply Chain (SCA) and Secrets modules can be chosen separately; built-in AI helps with detection, triage and remediation. It connects via GitHub/GitLab and deploys to CI/CD in one click. Free for up to 10 contributors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Static analysis (SAST)
Dependency scanning (SCA)
Secrets detection
AI triage and remediation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and application security teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно до 10 учасників.', 'Free for up to 10 contributors.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for up to 10 contributors.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Teams', 'Teams', 30.00, 'month', 'Від $30 за учасника на місяць за модуль Code або Supply Chain; Secrets — $15.', 'From $30 per contributor per month for Code or Supply Chain; Secrets is $15.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Teams' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Teams', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From $30 per contributor per month for Code or Supply Chain; Secrets is $15.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Індивідуальні ціни.', 'Custom pricing.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Custom pricing.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Socket — Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'socket.dev' OR LOWER(`name`) = 'socket')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Socket', NULL, 'https://socket.dev', NULL, NULL, 'Захист від атак через залежності: виявляє шкідливі й ризикові пакети JavaScript, Python, Go та інших мов.', 'Protection from supply chain attacks: detects malicious and risky JavaScript, Python, Go and other packages.', 'Socket аналізує залежності проєкту й блокує атаки через ланцюг постачання ще до того, як шкідливий пакет потрапить у код. AI-аналіз виявляє приховану поведінку залежностей, аналіз досяжності зменшує шум, є сповіщення в Slack про нове шкідливе ПЗ і вразливості. Безкоштовний план — необмежено розробників і репозиторіїв, 1000 сканувань на місяць.', 'Socket analyzes project dependencies and blocks supply chain attacks before a malicious package reaches your code. AI analysis flags hidden dependency behaviour, reachability analysis cuts noise, and Slack alerts report new malware and vulnerabilities. The free plan covers unlimited developers and repos with 1,000 scans per month.', 'Виявлення шкідливих пакетів
AI-аналіз поведінки залежностей
Аналіз досяжності
Сповіщення в Slack', 'Malicious package detection
AI analysis of dependency behaviour
Reachability analysis
Slack alerts', 'Розробникам і командам, які використовують open-source пакети.', 'Developers and teams that rely on open-source packages.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'socket.dev' OR LOWER(`name`) = 'socket') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Protection from supply chain attacks: detects malicious and risky JavaScript, Python, Go and other packages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Socket analyzes project dependencies and blocks supply chain attacks before a malicious package reaches your code. AI analysis flags hidden dependency behaviour, reachability analysis cuts noise, and Slack alerts report new malware and vulnerabilities. The free plan covers unlimited developers and repos with 1,000 scans per month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Malicious package detection
AI analysis of dependency behaviour
Reachability analysis
Slack alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and teams that rely on open-source packages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Необмежено розробників і репозиторіїв, 1000 сканувань на місяць.', 'Unlimited developers and repos, 1,000 scans per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Unlimited developers and repos, 1,000 scans per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Team', 'Team', 25.00, 'month', 'За розробника на місяць, від 5 розробників.', 'Per developer per month, minimum 5 developers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Team' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Team', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per developer per month, minimum 5 developers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Business', 'Business', 50.00, 'month', 'За розробника на місяць, від 20 розробників.', 'Per developer per month, minimum 20 developers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Business' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Business', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per developer per month, minimum 20 developers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Burp Suite — Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'portswigger.net/burp' OR LOWER(`name`) = 'burp suite')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Burp Suite', NULL, 'https://portswigger.net/burp', NULL, NULL, 'Інструменти PortSwigger для тестування безпеки веб-застосунків: ручний пентест і автоматичне сканування.', 'PortSwigger tools for web application security testing: manual pentesting and automated scanning.', 'Burp Suite — набір інструментів для тестування безпеки веб-застосунків від PortSwigger. Безкоштовна Community Edition підходить для навчання й ручного тестування, Professional — для професійних пентестерів, а DAST (раніше Enterprise) автоматично сканує застосунки в масштабі компанії. PortSwigger також веде безкоштовну Web Security Academy.', 'Burp Suite is PortSwigger''s toolkit for web application security testing. The free Community Edition suits learning and manual testing, Professional is for professional pentesters, and DAST (formerly Enterprise) scans applications automatically at company scale. PortSwigger also runs the free Web Security Academy.', 'Перехоплення й аналіз HTTP-трафіку
Автоматичний сканер вразливостей
Інструменти ручного пентесту
Безкоштовна Community Edition', 'HTTP traffic interception and analysis
Automated vulnerability scanner
Manual pentesting tools
Free Community Edition', 'Пентестерам, баг-баунті дослідникам і командам безпеки.', 'Pentesters, bug bounty hunters and security teams.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'portswigger.net/burp' OR LOWER(`name`) = 'burp suite') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PortSwigger tools for web application security testing: manual pentesting and automated scanning.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Burp Suite is PortSwigger''s toolkit for web application security testing. The free Community Edition suits learning and manual testing, Professional is for professional pentesters, and DAST (formerly Enterprise) scans applications automatically at company scale. PortSwigger also runs the free Web Security Academy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'HTTP traffic interception and analysis
Automated vulnerability scanner
Manual pentesting tools
Free Community Edition', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pentesters, bug bounty hunters and security teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Community', 'Community', 0.00, 'free', 'Безкоштовна версія.', 'Free edition.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Community' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Community', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free edition.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Professional / DAST', 'Professional / DAST', NULL, 'year', 'Ціни на сайті PortSwigger.', 'Prices on the PortSwigger site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Professional / DAST' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Professional / DAST', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the PortSwigger site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GitHub Advanced Security — Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/security/advanced-security' OR LOWER(`name`) = 'github advanced security')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GitHub Advanced Security', NULL, 'https://github.com/security/advanced-security', NULL, NULL, 'Вбудований у GitHub захист коду: сканування коду й секретів, Dependabot і AI-виправлення вразливостей.', 'Built-in GitHub security: code and secret scanning, Dependabot and AI-powered vulnerability fixes.', 'GitHub Advanced Security додає захист прямо в репозиторії: сканування коду, пошук і блокування витоку секретів, огляд залежностей і Dependabot, що автоматично відкриває pull request з оновленням вразливих пакетів. AI-функції допомагають швидко виправляти знайдені проблеми. Частина функцій безкоштовна для публічних репозиторіїв, для приватних — оплата за активного учасника.', 'GitHub Advanced Security adds protection right in the repository: code scanning, secret scanning and push protection, dependency review and Dependabot, which opens pull requests to update vulnerable packages. AI features help fix findings quickly. Some features are free for public repositories; private repositories are billed per active committer.', 'Сканування коду
Пошук і блокування секретів
Dependabot
AI-виправлення вразливостей', 'Code scanning
Secret scanning and push protection
Dependabot
AI vulnerability fixes', 'Командам розробки, які працюють у GitHub.', 'Development teams working on GitHub.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/security/advanced-security' OR LOWER(`name`) = 'github advanced security') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Built-in GitHub security: code and secret scanning, Dependabot and AI-powered vulnerability fixes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GitHub Advanced Security adds protection right in the repository: code scanning, secret scanning and push protection, dependency review and Dependabot, which opens pull requests to update vulnerable packages. AI features help fix findings quickly. Some features are free for public repositories; private repositories are billed per active committer.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Code scanning
Secret scanning and push protection
Dependabot
AI vulnerability fixes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Development teams working on GitHub.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Публічні репозиторії', 'Public repositories', 0.00, 'free', 'Частина функцій безкоштовна для публічних репозиторіїв.', 'Some features are free for public repositories.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Публічні репозиторії' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Public repositories', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Some features are free for public repositories.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Secret / Code Protection', 'Secret / Code Protection', NULL, 'month', 'Оплата за активного учасника на місяць; ціни на сайті GitHub.', 'Billed per active committer per month; prices on the GitHub site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Secret / Code Protection' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Secret / Code Protection', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Billed per active committer per month; prices on the GitHub site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Checkmarx One — Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'checkmarx.com' OR LOWER(`name`) = 'checkmarx one')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Checkmarx One', NULL, 'https://checkmarx.com', NULL, NULL, 'AI-платформа безпеки застосунків: гібридне сканування, AI-агенти Checkmarx Assist і керування ризиками (ASPM).', 'An AI-powered application security platform: hybrid scanning, Checkmarx Assist AI agents and risk management (ASPM).', 'Checkmarx One об''єднує тестування безпеки коду, залежностей, контейнерів, API та ланцюга постачання з єдиним поглядом на ризики (ASPM). Гібридний рушій Checkmarx Fusion поєднує правила з AI, а агенти Checkmarx Assist допомагають розробникам знаходити й виправляти вразливості прямо в робочому процесі.', 'Checkmarx One unifies security testing of code, dependencies, containers, APIs and the software supply chain with a single risk view (ASPM). The Checkmarx Fusion hybrid engine combines rules with AI, and Checkmarx Assist agents help developers find and fix vulnerabilities right in their workflow.', 'SAST, SCA, API та контейнери
Гібридний рушій Checkmarx Fusion
AI-агенти Checkmarx Assist
Керування ризиками (ASPM)', 'SAST, SCA, API and containers
Checkmarx Fusion hybrid engine
Checkmarx Assist AI agents
Risk management (ASPM)', 'Середнім і великим компаніям із власною розробкою.', 'Mid-sized and large companies with in-house development.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'checkmarx.com' OR LOWER(`name`) = 'checkmarx one') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI-powered application security platform: hybrid scanning, Checkmarx Assist AI agents and risk management (ASPM).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Checkmarx One unifies security testing of code, dependencies, containers, APIs and the software supply chain with a single risk view (ASPM). The Checkmarx Fusion hybrid engine combines rules with AI, and Checkmarx Assist agents help developers find and fix vulnerabilities right in their workflow.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'SAST, SCA, API and containers
Checkmarx Fusion hybrid engine
Checkmarx Assist AI agents
Risk management (ASPM)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mid-sized and large companies with in-house development.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Ціна за запитом.', 'Pricing on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aikido Security — Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aikido.dev' OR LOWER(`name`) = 'aikido security')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aikido Security', NULL, 'https://www.aikido.dev', NULL, NULL, 'Безпека коду, хмари й рантайму в одній платформі для розробників, з AI-автовиправленнями й пентестами.', 'Code, cloud and runtime security in one developer platform, with AI autofixes and pentests.', 'Aikido Security збирає в одному місці сканування коду й залежностей, хмарну безпеку, захист застосунку в рантаймі та виявлення загроз, щоб розробники не тонули в хибних спрацюваннях. AI-автовиправлення пропонує готові патчі, окремо можна замовити пентест (без оплати, якщо не знайдено високих чи критичних проблем). Безкоштовний план — для 2 користувачів.', 'Aikido Security brings code and dependency scanning, cloud security, in-app runtime protection and threat detection into one place so developers are not buried in false positives. AI AutoFix proposes ready patches, and pentests can be ordered separately (no charge if no high or critical findings). The free plan covers 2 users.', 'Сканування коду й залежностей
Хмарна безпека
Захист у рантаймі
AI-автовиправлення', 'Code and dependency scanning
Cloud security
Runtime protection
AI AutoFix', 'Стартапам і командам розробки без великого відділу безпеки.', 'Startups and development teams without a large security department.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aikido.dev' OR LOWER(`name`) = 'aikido security') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Code, cloud and runtime security in one developer platform, with AI autofixes and pentests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Aikido Security brings code and dependency scanning, cloud security, in-app runtime protection and threat detection into one place so developers are not buried in false positives. AI AutoFix proposes ready patches, and pentests can be ordered separately (no charge if no high or critical findings). The free plan covers 2 users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Code and dependency scanning
Cloud security
Runtime protection
AI AutoFix', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Startups and development teams without a large security department.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно назавжди, 2 користувачі, 10 AI-виправлень на місяць.', 'Free forever, 2 users, 10 AI AutoFixes per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free forever, 2 users, 10 AI AutoFixes per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Basic, Advanced та інші; ціни на сайті (без податків).', 'Basic, Advanced and more; prices on the site (excluding taxes).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic, Advanced and more; prices on the site (excluding taxes).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GitGuardian — Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gitguardian.com' OR LOWER(`name`) = 'gitguardian')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GitGuardian', NULL, 'https://www.gitguardian.com', NULL, NULL, 'Пошук і захист секретів у коді, CI/CD і на ноутбуках розробників, моніторинг витоків на публічному GitHub.', 'Detection and protection of secrets in code, CI/CD and developer laptops, plus monitoring for leaks on public GitHub.', 'GitGuardian знаходить API-ключі, паролі та інші секрети у вихідному коді, CI/CD, на машинах розробників і на публічному GitHub, а також керує машинними ідентичностями. Сервіс сканує понад 2 млрд комітів на рік. Безкоштовний план — для команд до 25 розробників, перший репозиторій можна просканувати за 5 хвилин без картки.', 'GitGuardian finds API keys, passwords and other secrets in source code, CI/CD, developer machines and public GitHub, and helps manage non-human identities. It scans more than 2 billion commits a year. The free plan covers teams of up to 25 developers, and you can scan your first repo in 5 minutes without a credit card.', 'Пошук секретів у коді й CI/CD
Моніторинг публічного GitHub
Захист машин розробників
Керування машинними ідентичностями', 'Secrets detection in code and CI/CD
Public GitHub monitoring
Developer endpoint protection
Non-human identity management', 'Командам розробки й безпеки.', 'Development and security teams.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gitguardian.com' OR LOWER(`name`) = 'gitguardian') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Detection and protection of secrets in code, CI/CD and developer laptops, plus monitoring for leaks on public GitHub.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GitGuardian finds API keys, passwords and other secrets in source code, CI/CD, developer machines and public GitHub, and helps manage non-human identities. It scans more than 2 billion commits a year. The free plan covers teams of up to 25 developers, and you can scan your first repo in 5 minutes without a credit card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Secrets detection in code and CI/CD
Public GitHub monitoring
Developer endpoint protection
Non-human identity management', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Development and security teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'До 25 розробників.', 'Up to 25 developers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Up to 25 developers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Business', 'Business', NULL, 'month', 'Ціна за запитом; є пробний період.', 'Pricing on request; free trial available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Business' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Business', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request; free trial available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ZAP — Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zaproxy.org' OR LOWER(`name`) = 'zap')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ZAP', NULL, 'https://www.zaproxy.org', NULL, NULL, 'Безкоштовний сканер безпеки веб-застосунків із відкритим кодом (раніше OWASP ZAP) з автоматизацією й доповненнями.', 'A free, open-source web application security scanner (formerly OWASP ZAP) with automation and add-ons.', 'ZAP — популярний сканер безпеки веб-застосунків, незалежний проєкт із відкритим кодом. Він підходить і новачкам у тестуванні безпеки (є Quick Start), і для автоматизації в CI/CD. Маркетплейс доповнень від спільноти розширює можливості.', 'ZAP is a widely used web application security scanner and an independent open-source project. It suits newcomers to security testing (there is a Quick Start guide) as well as automation in CI/CD. A community marketplace of add-ons extends its capabilities.', 'Сканування веб-застосунків
Автоматизація в CI/CD
Маркетплейс доповнень
Відкритий код', 'Web application scanning
CI/CD automation
Add-on marketplace
Open source', 'Розробникам, тестувальникам і початківцям у безпеці.', 'Developers, testers and security beginners.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zaproxy.org' OR LOWER(`name`) = 'zap') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free, open-source web application security scanner (formerly OWASP ZAP) with automation and add-ons.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ZAP is a widely used web application security scanner and an independent open-source project. It suits newcomers to security testing (there is a Quick Start guide) as well as automation in CI/CD. A community marketplace of add-ons extends its capabilities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Web application scanning
CI/CD automation
Add-on marketplace
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers, testers and security beginners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Повністю безкоштовно.', 'Completely free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Completely free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Veracode — Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'veracode.com' OR LOWER(`name`) = 'veracode')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Veracode', NULL, 'https://www.veracode.com', NULL, NULL, 'Платформа керування ризиками застосунків: SAST, DAST, контейнери, AI-пріоритизація й автоматичні виправлення.', 'An application risk management platform: SAST, DAST, containers, AI prioritization and automated fixes.', 'Veracode дає єдину видимість ризиків застосунків і допомагає їх виправляти. Платформа знаходить вразливості веб-застосунків у рантаймі, захищає конвеєри розробки й контейнери, автоматизує виправлення з AI. Окремо є курси безпечного кодування, практичні лабораторії й послуги пентестерів.', 'Veracode provides unified visibility into application risk and helps remediate it. The platform finds runtime web app vulnerabilities, secures development pipelines and containers and automates fixes with AI. There are also secure coding courses, hands-on labs and penetration testing services.', 'Статичний і динамічний аналіз
Захист контейнерів
AI-виправлення
Навчання безпечному кодуванню', 'Static and dynamic analysis
Container security
AI remediation
Secure coding training', 'Компаніям із великими портфелями застосунків.', 'Companies with large application portfolios.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'veracode.com' OR LOWER(`name`) = 'veracode') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An application risk management platform: SAST, DAST, containers, AI prioritization and automated fixes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Veracode provides unified visibility into application risk and helps remediate it. The platform finds runtime web app vulnerabilities, secures development pipelines and containers and automates fixes with AI. There are also secure coding courses, hands-on labs and penetration testing services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Static and dynamic analysis
Container security
AI remediation
Secure coding training', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Companies with large application portfolios.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Ціна за запитом.', 'Pricing on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Snyk — додатково в «Безпека коду та застосунків»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Snyk') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

