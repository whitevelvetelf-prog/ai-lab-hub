-- =====================================================================
-- AI LAB HUB — міграція 2026-11-17: замість «З 1 грудня — лише з реєстрацією» — заохочення до реєстрації.
--
--   1) Кампанію house_R (попередження про обов'язкову реєстрацію з 1 грудня) завершено: status = 'completed'.
--      Рядки не видаляються — статистика показів і реєстрацій (ad_house_signups) лишається.
--   2) Нова власна кампанія house_J «Переваги реєстрації»: спливаюче вікно ('popup'), лише гостям
--      (house_rules.guests_only + ad_campaign_audience), не на advertise.php і в кабінеті, без кінцевої дати.
--      Чотири варіанти-картки house-J1…J4 (UA/EN), кожен про одну перевагу, перехід на /register.php?ref=house-J*.
--
-- Лише UPDATE статусу кампанії house_R та INSERT … WHERE NOT EXISTS. Повторний запуск безпечний.
-- =====================================================================

SET NAMES utf8mb4;

-- 1) Скасувати оголошення про обов'язкову реєстрацію
UPDATE ad_campaigns SET status = 'completed', end_date = LEAST(COALESCE(end_date, CURDATE()), CURDATE())
WHERE house_key = 'house_R' AND status <> 'completed';

-- 2) Нова кампанія
INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, status, start_date, end_date, currency, house_key, house_rules, notes)
SELECT 'internal', 'video', NULL, 'Переваги реєстрації', 'AI LAB HUB', 'active', CURDATE(), NULL, 'USD', 'house_J',
       '{"guests_only":1,"exclude_pages":["advertise","cabinet"]}',
       'Власна реклама (2026-11-17): заохочення гостей до безкоштовної реєстрації; замінює house_R.'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM ad_campaigns WHERE house_key = 'house_J');
SET @cj := (SELECT id FROM ad_campaigns WHERE house_key = 'house_J' ORDER BY id LIMIT 1);

INSERT INTO ad_campaign_audience (campaign_id, audience)
SELECT @cj, 'guests' FROM DUAL WHERE @cj IS NOT NULL
ON DUPLICATE KEY UPDATE audience = 'guests';

INSERT INTO ad_creatives (campaign_id, creative_type, card_layout, title, title_en, description, description_en, cta_key, cta_text, cta_text_en, ref_code, destination_url, status)
SELECT @cj, 'card', 'wide', 'Збережіть свої АІ-інструменти', 'Keep your AI tools in one place',
       'Додавайте сервіси в «Обране» й повертайтеся до них з будь-якого пристрою. Реєстрація безкоштовна й займає хвилину.',
       'Add services to Favorites and get back to them from any device. Signing up is free and takes a minute.',
       'learn_more', 'Зареєструватися', 'Sign up free', 'house-J1', '/register.php?ref=house-J1', 'approved'
FROM DUAL WHERE @cj IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_creatives WHERE ref_code = 'house-J1');

INSERT INTO ad_creatives (campaign_id, creative_type, card_layout, title, title_en, description, description_en, cta_key, cta_text, cta_text_en, ref_code, destination_url, status)
SELECT @cj, 'card', 'wide', 'Безкоштовні матеріали для роботи з АІ', 'Free AI materials for members',
       'Готові рішення з Marketplace — шаблони й інструкції — завантажуйте безкоштовно одразу після реєстрації.',
       'Ready-made Marketplace solutions — templates and guides — are free to download right after you sign up.',
       'learn_more', 'Створити акаунт', 'Create account', 'house-J2', '/register.php?ref=house-J2', 'approved'
FROM DUAL WHERE @cj IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_creatives WHERE ref_code = 'house-J2');

INSERT INTO ad_creatives (campaign_id, creative_type, card_layout, title, title_en, description, description_en, cta_key, cta_text, cta_text_en, ref_code, destination_url, status)
SELECT @cj, 'card', 'wide', 'Розкажіть про свої послуги й курси', 'Tell people about your services',
       'Після реєстрації ви публікуєте оголошення в Marketplace — вакансії, курси, послуги — і бачите контакти продавців.',
       'Once signed up, you can post Marketplace listings — jobs, courses, services — and see sellers’ contacts.',
       'learn_more', 'Почати', 'Get started', 'house-J3', '/register.php?ref=house-J3', 'approved'
FROM DUAL WHERE @cj IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_creatives WHERE ref_code = 'house-J3');

INSERT INTO ad_creatives (campaign_id, creative_type, card_layout, title, title_en, description, description_en, cta_key, cta_text, cta_text_en, ref_code, destination_url, status)
SELECT @cj, 'card', 'wide', 'Один акаунт — усі можливості', 'One free account, every feature',
       'Безкоштовно: «Обране», завантаження матеріалів, оголошення й власний рекламний кабінет. Можна увійти через Google.',
       'Free: Favorites, material downloads, listings and your own ad cabinet. You can sign in with Google.',
       'learn_more', 'Зареєструватися', 'Join for free', 'house-J4', '/register.php?ref=house-J4', 'approved'
FROM DUAL WHERE @cj IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_creatives WHERE ref_code = 'house-J4');

INSERT INTO ad_targets (campaign_id, placement, category_id, subcategory_id, mp_section, language, device, unit_price)
SELECT @cj, 'popup', NULL, NULL, NULL, NULL, NULL, NULL
FROM DUAL WHERE @cj IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_targets t WHERE t.campaign_id = @cj);

-- Перевірка:
--   SELECT id, house_key, name, status, end_date FROM ad_campaigns WHERE house_key IN ('house_R', 'house_J');
--   SELECT ref_code, status, title FROM ad_creatives WHERE ref_code LIKE 'house-J%';
