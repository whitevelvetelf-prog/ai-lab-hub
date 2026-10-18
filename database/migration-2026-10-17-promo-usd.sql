-- =====================================================================
-- Реклама: перехід прайсу, балансів і списань з гривень на долари США.
-- Код: PROMO_CURRENCY = 'USD' (app/promo.php). Суми — центи.
-- Ідемпотентна: можна запускати повторно.
--
-- Прайс: CPM $2.00 (200 центів) за 1000 показів і CPC $0.20 (20 центів)
-- за клік для всіх трьох розміщень. Старі UAH-рядки прайсу лишаються
-- неактивними (історія).
-- Баланси: валюта змінюється лише для НУЛЬОВИХ балансів — ненульовий
-- гривневий баланс автоматично не конвертується (перевірити вручну).
-- Історія транзакцій лишається в гривнях і так і показується.
-- =====================================================================

ALTER TABLE ad_campaigns    ALTER COLUMN currency SET DEFAULT 'USD';
ALTER TABLE ad_balances     ALTER COLUMN currency SET DEFAULT 'USD';
ALTER TABLE ad_transactions ALTER COLUMN currency SET DEFAULT 'USD';
ALTER TABLE ad_rate_card    ALTER COLUMN currency SET DEFAULT 'USD';

UPDATE ad_rate_card SET active = 0 WHERE currency = 'UAH';

INSERT INTO ad_rate_card (placement, pricing_model, price, currency, active) VALUES
    ('catalog_card', 'cpm', 200, 'USD', 1),
    ('product_page', 'cpm', 200, 'USD', 1),
    ('blog_inline',  'cpm', 200, 'USD', 1),
    ('catalog_card', 'cpc', 20,  'USD', 1),
    ('product_page', 'cpc', 20,  'USD', 1),
    ('blog_inline',  'cpc', 20,  'USD', 1)
ON DUPLICATE KEY UPDATE price = VALUES(price), active = 1;

UPDATE ad_balances SET currency = 'USD' WHERE currency = 'UAH' AND balance = 0;

-- Чернетки ще не мають зафіксованої ціни — переводимо їх у долари.
UPDATE ad_campaigns SET currency = 'USD'
 WHERE format = 'video' AND currency = 'UAH' AND status = 'draft' AND spent = 0;

-- Платні кампанії з гривневою ціною не можуть списувати з доларового балансу:
-- зупиняємо незавершені (рекламодавець дублює/редагує — ціна стане в доларах).
-- Кампанії з ненульовим гривневим балансом не чіпаємо: валюти збігаються.
UPDATE ad_campaigns c
  LEFT JOIN ad_balances b ON b.user_id = c.user_id
   SET c.status = 'paused', c.stop_reason = 'admin'
 WHERE c.format = 'video' AND c.campaign_type = 'paid' AND c.currency = 'UAH'
   AND c.status IN ('active', 'pending_review', 'paused')
   AND (b.currency IS NULL OR b.currency <> 'UAH');

-- Мінімальне поповнення було в гривнях — скидаємо, адмін задасть у доларах.
UPDATE ad_settings SET setting_value = '' WHERE setting_key = 'min_topup';
