-- =====================================================================
-- AI LAB HUB — міграція 2026-10-30: власна реклама «З 1 грудня — лише з реєстрацією».
--
--   Кампанія house_R (internal, active) у спливаючому вікні ('popup'), лише гостям (house_rules.guests_only),
--   не на advertise.php і в кабінеті; end_date 2026-11-30 — після неї cron (promo_maintenance) завершує кампанію.
--   Два варіанти-картки (house-R1, house-R2), кожен з текстами UA/EN, перехід на register.php з ref.
--   Перелік переваг — те, що справді доступне лише після входу: «Обране», завантаження матеріалів,
--   оголошення в маркетплейсі, повідомлення продавцям, рекламний кабінет, вхід через Google.
--
-- Лише INSERT … WHERE NOT EXISTS. Повторний запуск безпечний (за house_key / ref_code).
-- Потрібні міграції реклами 2026-10-21 (popup) і 2026-10-23 (house ads).
-- =====================================================================

SET NAMES utf8mb4;

INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, status, start_date, end_date, currency, house_key, house_rules, notes)
SELECT 'internal', 'video', NULL, 'З 1 грудня — лише з реєстрацією', 'AI LAB HUB', 'active', CURDATE(), '2026-11-30', 'USD', 'house_R',
       '{"guests_only":1,"exclude_pages":["advertise","cabinet"]}',
       'Власна реклама (2026-10-30): попередження гостям, що з 1 грудня без реєстрації платформа недоступна.'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM ad_campaigns WHERE house_key = 'house_R');
SET @cr := (SELECT id FROM ad_campaigns WHERE house_key = 'house_R' ORDER BY id LIMIT 1);

INSERT INTO ad_creatives (campaign_id, creative_type, card_layout, title, title_en, description, description_en, cta_key, cta_text, cta_text_en, ref_code, destination_url, status)
SELECT @cr, 'card', 'wide', 'З 1 грудня — лише після реєстрації', 'From December 1, sign-up required',
       'Без акаунта платформа буде недоступна. Зареєстровані мають «Обране», завантаження, оголошення, зв’язок із продавцями й вхід через Google.',
       'Without an account the platform will be closed. Members get favorites, downloads, listings, contacting sellers and Google sign-in.',
       'learn_more', 'Зареєструватися', 'Sign up free', 'house-R1', '/register.php?ref=house-R1', 'approved'
FROM DUAL WHERE @cr IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_creatives WHERE ref_code = 'house-R1');

INSERT INTO ad_creatives (campaign_id, creative_type, card_layout, title, title_en, description, description_en, cta_key, cta_text, cta_text_en, ref_code, destination_url, status)
SELECT @cr, 'card', 'wide', 'Створіть акаунт до 1 грудня', 'Create your account before December 1',
       'Потім вхід лише для зареєстрованих. Безкоштовно: зберігайте АІ-інструменти, завантажуйте матеріали, публікуйте оголошення й рекламу.',
       'After that, members only. It is free: save AI tools, download materials, post listings and run ads from your own cabinet.',
       'learn_more', 'Створити акаунт', 'Create account', 'house-R2', '/register.php?ref=house-R2', 'approved'
FROM DUAL WHERE @cr IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_creatives WHERE ref_code = 'house-R2');

INSERT INTO ad_targets (campaign_id, placement, category_id, subcategory_id, mp_section, language, device, unit_price)
SELECT @cr, 'popup', NULL, NULL, NULL, NULL, NULL, NULL
FROM DUAL WHERE @cr IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_targets t WHERE t.campaign_id = @cr);
