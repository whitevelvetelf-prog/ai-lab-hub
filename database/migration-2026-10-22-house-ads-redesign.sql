SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — новий вигляд власної реклами (спливаюче вікно): кольорова тема картки й нові тексти.
--
--   ad_creatives  + theme VARCHAR(20) NULL ('sky' | 'mint' | 'sun'; NULL — теми чергуються за id).
--                   cta_text уже є (VARCHAR(40), міграція 2026-10-23-house-ads) — не змінюється.
--   Тексти UA/EN (заголовок до ~45, підпис до ~90, кнопка 1–3 слова) для варіантів
--   house-A1, house-A2, house-B1, house-B2 (картки) і відеореклами «Реклама сайту» (YouTube 2pmFlf5_unc).
--   Варіанти шукаються за ref_code / роликом, не за id (на хостингу й локально id різні).
--   house-B1 тепер запрошує переглянути Marketplace (не розмістити оголошення) — адреса без змін.
--
-- Лише умовний ALTER (information_schema + PREPARE), UPDATE і INSERT … ON DUPLICATE KEY UPDATE.
-- Без DROP / DELETE / TRUNCATE. Повторний запуск безпечний.
-- =====================================================================

-- 1) Колонка теми ------------------------------------------------------
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_creatives' AND COLUMN_NAME='theme')=0,
  'ALTER TABLE ad_creatives ADD COLUMN theme VARCHAR(20) NULL AFTER card_layout', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- 2) Картки «Рекламуйтесь у нас» -----------------------------------------
UPDATE ad_creatives SET theme = 'sky',
    title = 'Розкажіть про свій продукт нашим відвідувачам',
    title_en = 'Tell our visitors about your product',
    description = 'Реклама на AI LAB HUB: формат, мову й бюджет ви обираєте самі',
    description_en = 'Advertising on AI LAB HUB: you choose the format, language and budget',
    description_fallback = NULL, description_fallback_en = NULL,
    cta_text = 'Детальніше', cta_text_en = 'Learn more'
 WHERE ref_code = 'house-A1';

UPDATE ad_creatives SET theme = 'sun',
    title = 'Шукаєте нових клієнтів? Покажіть себе тут',
    title_en = 'Looking for new customers? Show up here',
    description = 'Зображення чи коротке відео у вікні на сторінках сайту. Кампанію ви налаштуєте самі',
    description_en = 'An image or a short video in a window on site pages. You set up the campaign yourself',
    description_fallback = NULL, description_fallback_en = NULL,
    cta_text = 'Почати', cta_text_en = 'Get started'
 WHERE ref_code = 'house-A2';

-- 3) Картки Marketplace --------------------------------------------------
UPDATE ad_creatives SET theme = 'mint',
    title = 'Готові AI-рішення в одному місці',
    title_en = 'Ready-made AI solutions in one place',
    description = 'Заходьте в Marketplace: рішення, курси, послуги й цифрові матеріали',
    description_en = 'Visit the Marketplace: solutions, courses, services and digital assets',
    description_fallback = NULL, description_fallback_en = NULL,
    cta_text = 'Відкрити', cta_text_en = 'Open'
 WHERE ref_code = 'house-B1';

UPDATE ad_creatives SET theme = 'sky',
    title = 'Є що запропонувати? Розмістіть оголошення',
    title_en = 'Got something to offer? Post a listing',
    description = 'Оголошення в Marketplace створюється за кілька хвилин і проходить швидку перевірку',
    description_en = 'A Marketplace listing takes a few minutes to create and gets a quick review',
    description_fallback = NULL, description_fallback_en = NULL,
    cta_text = 'Створити', cta_text_en = 'Create'
 WHERE ref_code = 'house-B2';

-- 4) Відеореклама «Реклама сайту» (YouTube): лише тексти під роликом -----
SET @cr := (SELECT cr.id FROM ad_creatives cr JOIN ad_campaigns c ON c.id = cr.campaign_id
            WHERE c.campaign_type = 'internal' AND cr.youtube_id = '2pmFlf5_unc' ORDER BY cr.id LIMIT 1);

UPDATE ad_creatives SET theme = 'sky',
    title = 'Розкажіть про свій бізнес відвідувачам',
    title_en = 'Tell visitors about your business',
    description = 'Зображення чи коротке відео на сторінках сайту, блогу й Marketplace',
    description_en = 'An image or a short video on the pages of the site, blog and Marketplace',
    cta_text = 'Детальніше', cta_text_en = 'Learn more'
 WHERE id = @cr;

-- Ручний переклад відео-варіанта — і в системі перекладу (ad_creative_translations).
INSERT INTO ad_creative_translations (creative_id, field_name, lang, translated_text, source)
SELECT @cr, 'title', 'en', 'Tell visitors about your business', 'manual' FROM DUAL WHERE @cr IS NOT NULL
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
INSERT INTO ad_creative_translations (creative_id, field_name, lang, translated_text, source)
SELECT @cr, 'description', 'en', 'An image or a short video on the pages of the site, blog and Marketplace', 'manual' FROM DUAL WHERE @cr IS NOT NULL
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';

-- 5) Позначка «Реклама» / «Ad» (звичайний регістр) ---------------------
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES ('ad_label', 'en', 'Ad', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
