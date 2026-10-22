SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — поповнення рекламного балансу в гривнях з конвертацією в USD.
-- Баланс, списання й ціни — лише в USD (PROMO_CURRENCY). Рекламодавець вводить суму в гривнях
-- (стільки переказує на банку), сервер фіксує курс НБУ на момент заявки й суму в центах (вниз).
--
--   ad_transactions + original_amount   BIGINT        сплачено, мінімальні одиниці (копійки)
--                   + original_currency CHAR(3)       валюта оплати (UAH)
--                   + fx_rate           DECIMAL(12,6) одиниць валюти за 1 USD
--                   + fx_rate_source    VARCHAR(20)   NBU
--                   + fx_rate_at        DATE          дата курсу
--                   + credited_usd      BIGINT        зараховано, центи USD
--                   amount / currency поповнення = credited_usd / USD (як і раніше — сума на баланс).
--   fx_rates        кеш курсів (валюта, курс, дата курсу, джерело, коли отримано).
--
-- Старі записи не змінюються (нові колонки NULL). Лише умовний ALTER (information_schema + PREPARE)
-- і CREATE TABLE IF NOT EXISTS. Без DROP / DELETE / UPDATE. Повторний запуск безпечний.
-- =====================================================================

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_transactions' AND COLUMN_NAME='original_amount')=0,
  'ALTER TABLE ad_transactions
     ADD COLUMN original_amount BIGINT NULL AFTER currency,
     ADD COLUMN original_currency CHAR(3) NULL AFTER original_amount,
     ADD COLUMN fx_rate DECIMAL(12,6) NULL AFTER original_currency,
     ADD COLUMN fx_rate_source VARCHAR(20) NULL AFTER fx_rate,
     ADD COLUMN fx_rate_at DATE NULL AFTER fx_rate_source,
     ADD COLUMN credited_usd BIGINT NULL AFTER fx_rate_at', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

CREATE TABLE IF NOT EXISTS fx_rates (
    currency   CHAR(3)       NOT NULL,
    rate       DECIMAL(12,6) NOT NULL,
    rate_date  DATE          NOT NULL,
    source     VARCHAR(20)   NOT NULL,
    fetched_at DATETIME      NOT NULL,
    PRIMARY KEY (currency)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
