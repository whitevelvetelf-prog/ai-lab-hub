SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція 2026-10-11: нова категорія «Кібербезпека» / «Cybersecurity» (slug cybersecurity) з підкатегоріями:
--   * Менеджери паролів / Password Managers (slug password-managers)
--   * VPN і приватність / VPN & Privacy (slug vpn-privacy)
--   * Антивіруси та захист пристроїв / Antivirus & Device Protection (slug device-protection)
--   * Захист особистих даних / Identity & Data Protection (slug identity-protection)
--   * Безпека бізнесу / Business Security (slug business-security)
--   * Безпека коду та застосунків / Application Security (slug appsec)
--   Без DROP/CREATE і без фіксованих id. Безпечно повторювати (WHERE NOT EXISTS).
--   Партія batches/2026-10-11-cybersecurity-56.sql містить ці ж рядки, тож окремо застосовувати не обов'язково.
-- =====================================================================

INSERT INTO `categories` (`name`, `name_en`, `slug`) SELECT 'Кібербезпека', 'Cybersecurity', 'cybersecurity' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `categories` WHERE `slug` = 'cybersecurity');
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'cybersecurity' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Менеджери паролів', 'Password Managers', 'password-managers' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'password-managers');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'VPN і приватність', 'VPN & Privacy', 'vpn-privacy' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vpn-privacy');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Антивіруси та захист пристроїв', 'Antivirus & Device Protection', 'device-protection' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'device-protection');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Захист особистих даних', 'Identity & Data Protection', 'identity-protection' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'identity-protection');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Безпека бізнесу', 'Business Security', 'business-security' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'business-security');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Безпека коду та застосунків', 'Application Security', 'appsec' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'appsec');
