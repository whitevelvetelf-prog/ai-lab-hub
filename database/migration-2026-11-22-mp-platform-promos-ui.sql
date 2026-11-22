-- =====================================================================
-- AI LAB HUB — міграція 2026-11-22 (Marketplace, № 29): EN-написи кнопки оголошень платформи
-- («Створити акаунт» / «Відкрити кабінет», app/mp-platform-promo.php). Українські тексти — app/translations.php (mpp_*).
-- Готовий переклад одразу в ui_translations (source='manual') — без звернень до API перекладу.
-- Безпечно повторювати: INSERT IGNORE (унікальний ключ (key_name, lang)). Лише INSERT, схема не змінюється.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('mpp_cta_signup', 'en', 'Create an account', 'manual'),
('mpp_cta_cabinet', 'en', 'Open your dashboard', 'manual'),
('mpp_cta_hint_guest', 'en', 'Signing up is free. If you already have an account, sign in.', 'manual'),
('mpp_cta_hint_user', 'en', 'You are signed in: everything you need is in your dashboard.', 'manual');

SELECT 'OK міграція 29: написи кнопки оголошень платформи' AS result;
