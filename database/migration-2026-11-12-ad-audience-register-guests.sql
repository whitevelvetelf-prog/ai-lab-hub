-- AI LAB HUB — кампанії з посиланням на реєстрацію показуються лише гостям (ad_campaign_audience = 'guests').
-- Застосовувати ПІСЛЯ migration-2026-11-12-ad-audience.sql. Безпечно й ідемпотентно:
--   * лише вставка/оновлення в ad_campaign_audience; статуси кампаній і креативів НЕ змінюються;
--   * зачіпає лише кампанії, де хоча б один креатив веде на /register.php (відносно чи на наш домен);
--   * повторний запуск нічого не змінює.
-- Перевірка до й після:
--   SELECT c.id, c.name, c.status, a.audience FROM ad_campaigns c LEFT JOIN ad_campaign_audience a ON a.campaign_id = c.id
--   WHERE EXISTS (SELECT 1 FROM ad_creatives cr WHERE cr.campaign_id = c.id AND cr.destination_url LIKE '%register.php%');

INSERT INTO ad_campaign_audience (campaign_id, audience)
SELECT DISTINCT cr.campaign_id, 'guests'
FROM ad_creatives cr
WHERE cr.campaign_id IS NOT NULL AND (cr.destination_url LIKE '/register.php%'
   OR cr.destination_url LIKE 'https://ailabhub-directory.com/register.php%'
   OR cr.destination_url LIKE 'https://www.ailabhub-directory.com/register.php%')
UNION
SELECT DISTINCT a.campaign_id, 'guests'
FROM ads a
WHERE a.campaign_id IS NOT NULL AND (a.target_url LIKE '/register.php%'
   OR a.target_url LIKE 'https://ailabhub-directory.com/register.php%'
   OR a.target_url LIKE 'https://www.ailabhub-directory.com/register.php%')
ON DUPLICATE KEY UPDATE audience = 'guests';
