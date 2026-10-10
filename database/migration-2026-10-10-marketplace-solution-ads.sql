-- =====================================================================
-- AI LAB HUB — міграція: внутрішня реклама Готових AI-рішень Marketplace (2026-10-10).
--
-- 1) ad_campaigns: одна internal-кампанія «Готові AI-рішення Marketplace» (AI LAB HUB).
-- 2) ads: по банеру на кожне з 7 рішень у зонах 1 («Сторінка категорії - верх») і 2 («Сторінка
--    підкатегорії - верх»), без прив'язки до категорії — тобто як заповнювачі вільних слотів.
--    Платні кампанії й далі мають пріоритет (app/ads.php → getAdForZone: спершу paid, потім internal).
--    Рішення шукаються за українською назвою серед опублікованих (id на проді й локально різні); якщо його немає —
--    його банер просто не створюється. Фон банера — public/assets/images/ads/solution-*.svg, текст — HTML.
-- 3) ad_translations: EN-заголовок і підпис кожного банера (manual).
-- 4) campaigns (старий слот homepage_banner на головній): кампанія-анонс «Незабаром: готові AI-рішення»
--    з посиланням '#' тепер веде на Готові AI-рішення в Marketplace (UPDATE лише цього рядка).
--
-- Нічого не видаляє. Безпечно повторювати: повторний запуск нових рядків не створює.
-- =====================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- 1) Кампанія
-- ---------------------------------------------------------------------
INSERT INTO ad_campaigns (campaign_type, advertiser_name, status, start_date, end_date, notes)
SELECT 'internal', 'AI LAB HUB', 'active', CURDATE(), NULL, 'Внутрішнє промо: Готові AI-рішення Marketplace'
WHERE NOT EXISTS (
    SELECT 1 FROM ad_campaigns WHERE campaign_type = 'internal' AND notes = 'Внутрішнє промо: Готові AI-рішення Marketplace'
);

SET @camp = (SELECT id FROM ad_campaigns
             WHERE campaign_type = 'internal' AND notes = 'Внутрішнє промо: Готові AI-рішення Marketplace'
             ORDER BY id LIMIT 1);

-- ---------------------------------------------------------------------
-- 2–3) Банери. Шаблон блоку: @title (назва рішення uk) → @lid → @url → ads (зони 1, 2) → ad_translations (en)
-- ---------------------------------------------------------------------

-- 2.1 Промпти для маркетингу
SET @lid = (SELECT l.id FROM mp_listings l JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = 'uk'
            WHERE l.section = 'solution' AND l.status = 'published' AND t.title = '12 промптів для маркетингу малого бізнесу' ORDER BY l.id LIMIT 1);
SET @url = CONCAT('/marketplace-offer.php?id=', @lid);
INSERT INTO ads (campaign_id, zone_id, image_url, target_url, category_id, subcategory_id, status, headline, subtext)
SELECT @camp, z.id, '/assets/images/ads/solution-prompts.svg', @url, NULL, NULL, 'active',
       'Безкоштовно: 12 промптів для маркетингу',
       'Контент-план, пости, розсилки, реклама й відповіді на відгуки для малого бізнесу'
FROM ad_zones z
WHERE z.id IN (1, 2) AND @camp IS NOT NULL AND @lid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM ads a WHERE a.campaign_id = @camp AND a.zone_id = z.id AND BINARY a.target_url = BINARY @url);
INSERT IGNORE INTO ad_translations (ad_id, field_name, lang, translated_text, source)
SELECT a.id, f.field_name, 'en', f.txt, 'manual'
FROM ads a
JOIN (SELECT 'headline' AS field_name, 'Free: 12 marketing prompts' AS txt
      UNION ALL SELECT 'subtext', 'Content plan, posts, newsletters, ads and review replies for small businesses') f
WHERE a.campaign_id = @camp AND BINARY a.target_url = BINARY @url;

-- 2.2 Автоматизація заявок
SET @lid = (SELECT l.id FROM mp_listings l JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = 'uk'
            WHERE l.section = 'solution' AND l.status = 'published' AND t.title = 'Автоматизація: заявка з форми → таблиця → Telegram' ORDER BY l.id LIMIT 1);
SET @url = CONCAT('/marketplace-offer.php?id=', @lid);
INSERT INTO ads (campaign_id, zone_id, image_url, target_url, category_id, subcategory_id, status, headline, subtext)
SELECT @camp, z.id, '/assets/images/ads/solution-workflows.svg', @url, NULL, NULL, 'active',
       'Безкоштовно: заявки з форми одразу в Telegram',
       'Готова схема для n8n, Make чи Zapier: таблиця, захист від дублів і спаму'
FROM ad_zones z
WHERE z.id IN (1, 2) AND @camp IS NOT NULL AND @lid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM ads a WHERE a.campaign_id = @camp AND a.zone_id = z.id AND BINARY a.target_url = BINARY @url);
INSERT IGNORE INTO ad_translations (ad_id, field_name, lang, translated_text, source)
SELECT a.id, f.field_name, 'en', f.txt, 'manual'
FROM ads a
JOIN (SELECT 'headline' AS field_name, 'Free: form leads straight to Telegram' AS txt
      UNION ALL SELECT 'subtext', 'Ready-made flow for n8n, Make or Zapier: spreadsheet, duplicate and spam protection') f
WHERE a.campaign_id = @camp AND BINARY a.target_url = BINARY @url;

-- 2.3 Асистент підтримки
SET @lid = (SELECT l.id FROM mp_listings l JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = 'uk'
            WHERE l.section = 'solution' AND l.status = 'published' AND t.title = 'Шаблон системної інструкції для асистента підтримки клієнтів' ORDER BY l.id LIMIT 1);
SET @url = CONCAT('/marketplace-offer.php?id=', @lid);
INSERT INTO ads (campaign_id, zone_id, image_url, target_url, category_id, subcategory_id, status, headline, subtext)
SELECT @camp, z.id, '/assets/images/ads/solution-assistants.svg', @url, NULL, NULL, 'active',
       'Безкоштовно: інструкція для AI-асистента підтримки',
       'Роль, тон, правила безпеки, передача людині й 10 тестових запитів'
FROM ad_zones z
WHERE z.id IN (1, 2) AND @camp IS NOT NULL AND @lid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM ads a WHERE a.campaign_id = @camp AND a.zone_id = z.id AND BINARY a.target_url = BINARY @url);
INSERT IGNORE INTO ad_translations (ad_id, field_name, lang, translated_text, source)
SELECT a.id, f.field_name, 'en', f.txt, 'manual'
FROM ads a
JOIN (SELECT 'headline' AS field_name, 'Free: system prompt for a support assistant' AS txt
      UNION ALL SELECT 'subtext', 'Role, tone, safety rules, human handoff and 10 test requests') f
WHERE a.campaign_id = @camp AND BINARY a.target_url = BINARY @url;

-- 2.4 Скрипт Python
SET @lid = (SELECT l.id FROM mp_listings l JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = 'uk'
            WHERE l.section = 'solution' AND l.status = 'published' AND t.title = 'Скрипт Python: пакетний прогін промптів із CSV' ORDER BY l.id LIMIT 1);
SET @url = CONCAT('/marketplace-offer.php?id=', @lid);
INSERT INTO ads (campaign_id, zone_id, image_url, target_url, category_id, subcategory_id, status, headline, subtext)
SELECT @camp, z.id, '/assets/images/ads/solution-scripts.svg', @url, NULL, NULL, 'active',
       'Безкоштовно: Python-скрипт для пакетних промптів',
       'Читає промпти з CSV, зберігає відповіді, продовжує після збою'
FROM ad_zones z
WHERE z.id IN (1, 2) AND @camp IS NOT NULL AND @lid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM ads a WHERE a.campaign_id = @camp AND a.zone_id = z.id AND BINARY a.target_url = BINARY @url);
INSERT IGNORE INTO ad_translations (ad_id, field_name, lang, translated_text, source)
SELECT a.id, f.field_name, 'en', f.txt, 'manual'
FROM ads a
JOIN (SELECT 'headline' AS field_name, 'Free: Python script for batch prompts' AS txt
      UNION ALL SELECT 'subtext', 'Reads prompts from CSV, saves the answers, resumes after a failure') f
WHERE a.campaign_id = @camp AND BINARY a.target_url = BINARY @url;

-- 2.5 Чекліст перевірки відповідей AI
SET @lid = (SELECT l.id FROM mp_listings l JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = 'uk'
            WHERE l.section = 'solution' AND l.status = 'published' AND t.title = 'Чекліст: як перевіряти відповіді AI перед публікацією' ORDER BY l.id LIMIT 1);
SET @url = CONCAT('/marketplace-offer.php?id=', @lid);
INSERT INTO ads (campaign_id, zone_id, image_url, target_url, category_id, subcategory_id, status, headline, subtext)
SELECT @camp, z.id, '/assets/images/ads/solution-guides.svg', @url, NULL, NULL, 'active',
       'Безкоштовно: чекліст перевірки відповідей AI',
       'Факти, посилання, цифри, приватність і авторські права — перед публікацією'
FROM ad_zones z
WHERE z.id IN (1, 2) AND @camp IS NOT NULL AND @lid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM ads a WHERE a.campaign_id = @camp AND a.zone_id = z.id AND BINARY a.target_url = BINARY @url);
INSERT IGNORE INTO ad_translations (ad_id, field_name, lang, translated_text, source)
SELECT a.id, f.field_name, 'en', f.txt, 'manual'
FROM ads a
JOIN (SELECT 'headline' AS field_name, 'Free: checklist for reviewing AI answers' AS txt
      UNION ALL SELECT 'subtext', 'Facts, links, numbers, privacy and copyright — before you publish') f
WHERE a.campaign_id = @camp AND BINARY a.target_url = BINARY @url;

-- 2.6 Бриф для генерації зображень
SET @lid = (SELECT l.id FROM mp_listings l JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = 'uk'
            WHERE l.section = 'solution' AND l.status = 'published' AND t.title = 'Гайд: як складати бриф для генерації зображень' ORDER BY l.id LIMIT 1);
SET @url = CONCAT('/marketplace-offer.php?id=', @lid);
INSERT INTO ads (campaign_id, zone_id, image_url, target_url, category_id, subcategory_id, status, headline, subtext)
SELECT @camp, z.id, '/assets/images/ads/solution-design.svg', @url, NULL, NULL, 'active',
       'Безкоштовно: гайд з брифів для генерації зображень',
       'Формула з 10 елементів, словник стилів і 6 прикладів промптів'
FROM ad_zones z
WHERE z.id IN (1, 2) AND @camp IS NOT NULL AND @lid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM ads a WHERE a.campaign_id = @camp AND a.zone_id = z.id AND BINARY a.target_url = BINARY @url);
INSERT IGNORE INTO ad_translations (ad_id, field_name, lang, translated_text, source)
SELECT a.id, f.field_name, 'en', f.txt, 'manual'
FROM ads a
JOIN (SELECT 'headline' AS field_name, 'Free: guide to image-generation briefs' AS txt
      UNION ALL SELECT 'subtext', 'A 10-element formula, a style glossary and 6 example prompts') f
WHERE a.campaign_id = @camp AND BINARY a.target_url = BINARY @url;

-- 2.7 Таблиця оцінювання AI-інструментів
SET @lid = (SELECT l.id FROM mp_listings l JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = 'uk'
            WHERE l.section = 'solution' AND l.status = 'published' AND t.title = 'Таблиця оцінювання AI-інструментів (CSV + методика)' ORDER BY l.id LIMIT 1);
SET @url = CONCAT('/marketplace-offer.php?id=', @lid);
INSERT INTO ads (campaign_id, zone_id, image_url, target_url, category_id, subcategory_id, status, headline, subtext)
SELECT @camp, z.id, '/assets/images/ads/solution-datasets.svg', @url, NULL, NULL, 'active',
       'Безкоштовно: таблиця для порівняння AI-інструментів',
       'Зважені критерії й формула підсумкового балу для Excel і Google Sheets'
FROM ad_zones z
WHERE z.id IN (1, 2) AND @camp IS NOT NULL AND @lid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM ads a WHERE a.campaign_id = @camp AND a.zone_id = z.id AND BINARY a.target_url = BINARY @url);
INSERT IGNORE INTO ad_translations (ad_id, field_name, lang, translated_text, source)
SELECT a.id, f.field_name, 'en', f.txt, 'manual'
FROM ads a
JOIN (SELECT 'headline' AS field_name, 'Free: spreadsheet for comparing AI tools' AS txt
      UNION ALL SELECT 'subtext', 'Weighted criteria and a total-score formula for Excel and Google Sheets') f
WHERE a.campaign_id = @camp AND BINARY a.target_url = BINARY @url;

-- ---------------------------------------------------------------------
-- 4) Старий слот homepage_banner: анонс «Незабаром…» з посиланням '#' → Готові AI-рішення
-- ---------------------------------------------------------------------
UPDATE campaigns
SET title       = 'Безкоштовні готові AI-рішення',
    description = 'Промпти, шаблони автоматизацій, гайди й скрипти від AI LAB HUB — у Marketplace.',
    target_url  = '/marketplace.php?category=solutions&price_type=free'
WHERE campaign_type = 'internal' AND target_url = '#' AND title LIKE 'Незабаром: готові AI-рішення%';

-- Перевірка (має бути 14 банерів = 7 рішень × 2 зони, і 28 EN-перекладів):
SELECT COUNT(*) AS solution_ads FROM ads WHERE campaign_id = @camp;
SELECT COUNT(*) AS solution_ad_translations FROM ad_translations t JOIN ads a ON a.id = t.ad_id WHERE a.campaign_id = @camp;
