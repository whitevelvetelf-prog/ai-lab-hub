SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — власна відеореклама «Реклама сайту» (на хостингу кампанія #3, YouTube 2pmFlf5_unc):
-- новий текст без підкреслення тематики сайту, кнопка веде на «Реклама на сайті», показ у
-- спливаючому вікні. Кампанія шукається за роликом (id на хостингу й локально різні).
-- Безпечно повторювати; жодних DROP / DELETE.
-- =====================================================================

SET @cr := (SELECT cr.id FROM ad_creatives cr JOIN ad_campaigns c ON c.id = cr.campaign_id
            WHERE c.campaign_type = 'internal' AND cr.youtube_id = '2pmFlf5_unc' ORDER BY cr.id LIMIT 1);
SET @cid := (SELECT campaign_id FROM ad_creatives WHERE id = @cr);

UPDATE ad_creatives SET
    title = 'Розкажіть про свій бізнес відвідувачам',
    title_en = 'Tell visitors about your business',
    description = 'Зображення чи коротке відео у вікні на сторінках сайту, блогу й Marketplace. Без абонплати: бюджет, мову й дати обираєте самі.',
    description_en = 'An image or a short video in a window on the pages of the site, blog and Marketplace. No subscription: you choose budget, language and dates.',
    cta_text = 'Розмістити рекламу',
    cta_text_en = 'Place an ad',
    ref_code = 'house-C1',
    destination_url = '/advertise.php?ref=house-C1'
 WHERE id = @cr;

-- Старі автопереклади на EN замінюємо новим текстом (ручні — пріоритетні й так).
INSERT INTO ad_creative_translations (creative_id, field_name, lang, translated_text, source)
SELECT @cr, 'title', 'en', 'Tell visitors about your business', 'manual' FROM DUAL WHERE @cr IS NOT NULL
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
INSERT INTO ad_creative_translations (creative_id, field_name, lang, translated_text, source)
SELECT @cr, 'description', 'en', 'An image or a short video in a window on the pages of the site, blog and Marketplace. No subscription: you choose budget, language and dates.', 'manual' FROM DUAL WHERE @cr IS NOT NULL
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';

-- Як кампанія A: не показувати тим, хто вже має кампанію, і на сторінках реклами/кабінету.
UPDATE ad_campaigns SET house_rules = '{"hide_if_campaign":1,"exclude_pages":["advertise","cabinet"]}'
 WHERE id = @cid AND (house_rules IS NULL OR house_rules = '');

-- Показ у спливаючому вікні (усі категорії, мови й пристрої).
INSERT INTO ad_targets (campaign_id, placement)
SELECT @cid, 'popup' FROM DUAL
 WHERE @cid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_targets WHERE campaign_id = @cid AND placement = 'popup');
