SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — РАЗОВЕ виправлення на хостингу: гривневий баланс користувача #18 → USD.
-- Запускати ВРУЧНУ в phpMyAdmin після резервної копії і ПІСЛЯ міграції
-- migration-2026-10-22-promo-fx-topups.sql (потрібні колонки original_amount … credited_usd).
-- Не входить в increment_latest.sql.
--
-- Що було: тестові поповнення №1 і №2 (11.10.2026, до переходу реклами на долари) записані правильно —
-- по 1000 копійок UAH (10,00 ₴), баланс #18 = 2000 копійок UAH (20,00 ₴). Конвертації не було.
-- Що робимо (баланси — лише в USD; суму не обнуляємо):
--   * №1 і №2: заповнюємо fx-поля — сплачено 1000 коп UAH, курс НБУ 44,8526 на 11.10.2026,
--     зараховано floor(1000 / 44,8526 × 100) = 22 центи кожне. amount / currency рядків не змінюються
--     (історія лишається в гривнях, журнал показує «0,22 $ · сплачено 10,00 ₴, курс НБУ 44,8526 на 11.10.2026»).
--   * баланс #18: 2000 коп UAH → 44 центи USD (= сума credited_usd обох поповнень, $0,44;
--     20 / 44,8526 = $0,4459 — округлення вниз). Інших транзакцій у #18 немає, списань не було.
-- Кожен UPDATE — з умовами на поточні значення: якщо дані вже змінились, нічого не зміниться.
-- Без DELETE / DROP. Повторний запуск нічого не змінює.
-- =====================================================================

-- 1) ПЕРЕВІРКА ДО: має бути рівно 2 рядки транзакцій і 1 рядок балансу з такими значеннями.
SELECT id, user_id, type, amount, currency, status, original_amount, original_currency, fx_rate, credited_usd
  FROM ad_transactions WHERE user_id = 18 ORDER BY id;
-- очікується: 1 | 18 | topup | 1000 | UAH | confirmed | NULL … ; 2 | 18 | topup | 1000 | UAH | confirmed | NULL …
SELECT user_id, balance, currency FROM ad_balances WHERE user_id = 18;
-- очікується: 18 | 2000 | UAH

-- 2) ВИПРАВЛЕННЯ
UPDATE ad_transactions
   SET original_amount = 1000, original_currency = 'UAH', fx_rate = 44.852600, fx_rate_source = 'NBU',
       fx_rate_at = '2026-10-11', credited_usd = 22
 WHERE id IN (1, 2) AND user_id = 18 AND type = 'topup' AND status = 'confirmed'
   AND amount = 1000 AND currency = 'UAH' AND credited_usd IS NULL;
-- очікується: змінено 2 рядки

UPDATE ad_balances
   SET balance = 44, currency = 'USD'
 WHERE user_id = 18 AND balance = 2000 AND currency = 'UAH';
-- очікується: змінено 1 рядок

-- 3) ПЕРЕВІРКА ПІСЛЯ
SELECT id, amount, currency, original_amount, original_currency, fx_rate, fx_rate_source, fx_rate_at, credited_usd
  FROM ad_transactions WHERE user_id = 18 ORDER BY id;
SELECT user_id, balance, currency FROM ad_balances WHERE user_id = 18;
-- очікується: 18 | 44 | USD
-- Баланс = сума credited_usd підтверджених поповнень: SELECT SUM(credited_usd) FROM ad_transactions WHERE user_id = 18 AND status = 'confirmed';  → 44
