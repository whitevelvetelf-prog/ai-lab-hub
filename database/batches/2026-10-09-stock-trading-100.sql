SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-09: нова підкатегорія «Торгівля на біржі» / «Stock Exchange Trading» (slug stock-trading)
-- у категорії «Фінанси та юридичні» (slug finance-legal) + 100 нових продуктів + прив'язка наявних.
-- AI-аналітика, скринери й дані, торгові платформи й алготрейдинг, брокери, криптобіржі, трекери портфеля, журнали угод.
-- Тексти, функції й тарифи (UA + EN) — лише з офіційних сайтів, звірено 2026-10-09. Невідомі ціни — NULL з поясненням.
-- Прив'язуються наявні (тексти не змінюються): Trade Ideas, TrendSpider, Stock Rover, Tickeron, PortfolioPilot, AlphaSense, Kavout, Magnifi, Robinhood
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт» (файл .sql або .sql.zip). Повторний запуск безпечний.
--   Prospero.ai — Торгівля на біржі
--   Composer — Торгівля на біржі
--   Intellectia.ai — Торгівля на біржі
--   Reflexivity — Торгівля на біржі
--   FinBrain — Торгівля на біржі
--   StockInsights.ai — Торгівля на біржі
--   Tradytics — Торгівля на біржі
--   Quiver Quantitative — Торгівля на біржі
--   Unusual Whales — Торгівля на біржі
--   Alfa (Boosted.ai) — Торгівля на біржі
--   Incite AI — Торгівля на біржі
--   LevelFields — Торгівля на біржі
--   TradingView — Торгівля на біржі
--   Finviz — Торгівля на біржі
--   Koyfin — Торгівля на біржі
--   Seeking Alpha — Торгівля на біржі
--   Zacks — Торгівля на біржі
--   Simply Wall St — Торгівля на біржі
--   Barchart — Торгівля на біржі
--   StockCharts — Торгівля на біржі
--   Investing.com — Торгівля на біржі
--   Yahoo Finance — Торгівля на біржі
--   Morningstar Investor — Торгівля на біржі
--   WallStreetZen — Торгівля на біржі
--   Stockopedia — Торгівля на біржі
--   MarketBeat — Торгівля на біржі
--   Benzinga Pro — Торгівля на біржі
--   OptionStrat — Торгівля на біржі
--   Option Alpha — Торгівля на біржі
--   Ziggma — Торгівля на біржі
--   GuruFocus — Торгівля на біржі
--   Stock Analysis — Торгівля на біржі
--   YCharts — Торгівля на біржі
--   Bloomberg Terminal — Торгівля на біржі
--   LSEG Workspace — Торгівля на біржі
--   Earnings Whispers — Торгівля на біржі
--   TIKR — Торгівля на біржі
--   NinjaTrader — Торгівля на біржі
--   TradeStation — Торгівля на біржі
--   thinkorswim — Торгівля на біржі
--   MetaTrader 5 — Торгівля на біржі
--   cTrader — Торгівля на біржі
--   AmiBroker — Торгівля на біржі
--   Sierra Chart — Торгівля на біржі
--   Quantower — Торгівля на біржі
--   ATAS — Торгівля на біржі
--   Bookmap — Торгівля на біржі
--   MotiveWave — Торгівля на біржі
--   WealthLab — Торгівля на біржі
--   QuantConnect — Торгівля на біржі
--   Alpaca — Торгівля на біржі
--   Massive (Polygon.io) — Торгівля на біржі
--   Streak — Торгівля на біржі
--   TradersPost — Торгівля на біржі
--   NautilusTrader — Торгівля на біржі
--   Freqtrade — Торгівля на біржі
--   Interactive Brokers — Торгівля на біржі
--   Charles Schwab — Торгівля на біржі
--   Fidelity — Торгівля на біржі
--   Webull — Торгівля на біржі
--   eToro — Торгівля на біржі
--   Trading 212 — Торгівля на біржі
--   Freedom24 — Торгівля на біржі
--   Saxo — Торгівля на біржі
--   Public.com — Торгівля на біржі
--   moomoo — Торгівля на біржі
--   tastytrade — Торгівля на біржі
--   Firstrade — Торгівля на біржі
--   E*TRADE — Торгівля на біржі
--   Lightyear — Торгівля на біржі
--   Scalable Capital — Торгівля на біржі
--   Trade Republic — Торгівля на біржі
--   XTB — Торгівля на біржі
--   EXANTE — Торгівля на біржі
--   Tiger Brokers — Торгівля на біржі
--   SoFi Invest — Торгівля на біржі
--   IG — Торгівля на біржі
--   Binance — Торгівля на біржі
--   Coinbase — Торгівля на біржі
--   Kraken — Торгівля на біржі
--   WhiteBIT — Торгівля на біржі
--   Bybit — Торгівля на біржі
--   OKX — Торгівля на біржі
--   Bitstamp — Торгівля на біржі
--   3Commas — Торгівля на біржі
--   Cryptohopper — Торгівля на біржі
--   CoinGecko — Торгівля на біржі
--   CoinMarketCap — Торгівля на біржі
--   Coinigy — Торгівля на біржі
--   Sharesight — Торгівля на біржі
--   Snowball Analytics — Торгівля на біржі
--   Delta — Торгівля на біржі
--   getquin — Торгівля на біржі
--   Kubera — Торгівля на біржі
--   Parqet — Торгівля на біржі
--   Portfolio Visualizer — Торгівля на біржі
--   Tradervue — Торгівля на біржі
--   Edgewonk — Торгівля на біржі
--   TradeZella — Торгівля на біржі
--   Kinfo — Торгівля на біржі
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'finance-legal' LIMIT 1);

INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`)
SELECT @cat, 'Торгівля на біржі', 'Stock Exchange Trading', 'stock-trading' FROM DUAL
WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'stock-trading');
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'stock-trading' LIMIT 1);

-- Prospero.ai — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prospero.ai' OR LOWER(`name`) = 'prospero.ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Prospero.ai', NULL, 'https://www.prospero.ai', NULL, NULL, 'Безкоштовний застосунок з AI-сигналами, що зводить мільйони даних про акції в зрозумілі показники.', 'A free app with AI signals that condense millions of data points about stocks into clear indicators.', 'Prospero.ai поєднує мільйони точок даних у ключові сигнали, які спрощують аналіз акцій і допомагають перевірити власні ідеї. Команда публікує добірки акцій і торгові ідеї різної складності — від секторних і макроекономічних до подієвих опціонних. Терміни пояснюються простою мовою, а графіки й списки розраховані на інвесторів без фахової підготовки. Результати минулих добірок не гарантують майбутніх. Інвестиції та торгівля пов''язані з ризиком втрати коштів.', 'Prospero.ai combines millions of data points into key signals that simplify stock research and help validate your own ideas. The team publishes stock picks and trade ideas of varying complexity, from sector and macro plays to event-driven options trades. Terms are explained in plain language, and charts and lists are designed for non-professional investors. Past picks do not guarantee future results. Investing and trading involve the risk of losing money.', 'AI-сигнали для акцій
Щоденні оновлення добірок
Торгові ідеї від секторних до опціонних
Пояснення термінів простою мовою', 'AI signals for stocks
Daily pick updates
Trade ideas from sector plays to options
Plain-language explanations', 'Приватні інвестори, які хочуть швидше аналізувати акції.', 'Retail investors who want to research stocks faster.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prospero.ai' OR LOWER(`name`) = 'prospero.ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free app with AI signals that condense millions of data points about stocks into clear indicators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Prospero.ai combines millions of data points into key signals that simplify stock research and help validate your own ideas. The team publishes stock picks and trade ideas of varying complexity, from sector and macro plays to event-driven options trades. Terms are explained in plain language, and charts and lists are designed for non-professional investors. Past picks do not guarantee future results. Investing and trading involve the risk of losing money.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI signals for stocks
Daily pick updates
Trade ideas from sector plays to options
Plain-language explanations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Retail investors who want to research stocks faster.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Застосунок безкоштовний.', 'The app is free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app is free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Composer — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'composer.trade' OR LOWER(`name`) = 'composer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Composer', NULL, 'https://www.composer.trade', NULL, NULL, 'Платформа від SoFi для створення торгових алгоритмів з AI без коду, бектесту й автоматичного виконання.', 'A SoFi platform for building trading algorithms with AI without code, backtesting and automated execution.', 'Composer дозволяє описати цілі, стратегію й допустимий ризик звичайною мовою, а AI-редактор складе з цього торгову стратегію. Її можна протестувати на історичних даних і запустити на виконання в одній платформі, не пишучи коду. Сервіс входить до SoFi. AI-згенеровані стратегії варто перевіряти самостійно: бектест не гарантує прибутку. Інвестиції та торгівля пов''язані з ризиком втрати коштів.', 'Composer lets you describe your goals, strategy and risk tolerance in plain language, and its AI editor turns that into a trading strategy. You can backtest it on historical data and run it on one platform without writing code. The service is part of SoFi. AI-generated strategies should be checked yourself: a backtest does not guarantee profit. Investing and trading involve the risk of losing money.', 'AI-редактор стратегій природною мовою
Бектест на історичних даних
Автоматичне виконання стратегій
Без програмування', 'AI strategy editor in natural language
Backtesting on historical data
Automated strategy execution
No coding', 'Інвестори, які хочуть автоматизувати стратегії без програмування.', 'Investors who want to automate strategies without coding.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'composer.trade' OR LOWER(`name`) = 'composer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A SoFi platform for building trading algorithms with AI without code, backtesting and automated execution.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Composer lets you describe your goals, strategy and risk tolerance in plain language, and its AI editor turns that into a trading strategy. You can backtest it on historical data and run it on one platform without writing code. The service is part of SoFi. AI-generated strategies should be checked yourself: a backtest does not guarantee profit. Investing and trading involve the risk of losing money.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI strategy editor in natural language
Backtesting on historical data
Automated strategy execution
No coding', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors who want to automate strategies without coding.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Composer доступний за $0 на місяць; розширені плани — на сайті.', 'Composer is available for $0 per month; advanced plans are on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Composer is available for $0 per month; advanced plans are on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Intellectia.ai — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'intellectia.ai' OR LOWER(`name`) = 'intellectia.ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Intellectia.ai', NULL, 'https://intellectia.ai', NULL, NULL, 'AI-платформа з тижневим AI-відбором акцій, сигналами, скринером і асистентом Alphio.', 'An AI platform with a weekly AI stock picker, signals, a screener and the Alphio assistant.', 'Intellectia.ai щопонеділка перед відкриттям ринку оновлює AI-добірку з 10 акцій, показує сигнали SwingMax, має AI-скринер, трекер публічних звітів і огляд стратегій. AI-асистент Alphio стежить за даними й надсилає налаштовані вами сповіщення. Можна підключити брокера (зокрема Webull чи Alpaca) і розміщувати ринкові або лімітні ордери, не виходячи з аналітики, — кожен ордер підтверджуєте ви. Сайт прямо зазначає, що бектести історичні, а сигнали не прибирають ризику. Інвестиції та торгівля пов''язані з ризиком втрати коштів.', 'Intellectia.ai updates an AI list of 10 stocks every Monday before the market opens, shows SwingMax signals and offers an AI screener, a public filing tracker and strategy reviews. The Alphio AI assistant monitors data and sends alerts you set. You can connect a broker (including Webull or Alpaca) and place market or limit orders without leaving your analysis; you confirm every order. The site states that backtests are historical and signals do not remove risk. Investing and trading involve the risk of losing money.', 'Тижнева AI-добірка з 10 акцій
Сигнали SwingMax
AI-скринер і трекер звітів
AI-асистент Alphio
Ордери через підключеного брокера', 'Weekly AI list of 10 stocks
SwingMax signals
AI screener and filing tracker
Alphio AI assistant
Orders via a connected broker', 'Приватні інвестори й свінг-трейдери.', 'Retail investors and swing traders.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'intellectia.ai' OR LOWER(`name`) = 'intellectia.ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI platform with a weekly AI stock picker, signals, a screener and the Alphio assistant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Intellectia.ai updates an AI list of 10 stocks every Monday before the market opens, shows SwingMax signals and offers an AI screener, a public filing tracker and strategy reviews. The Alphio AI assistant monitors data and sends alerts you set. You can connect a broker (including Webull or Alpaca) and place market or limit orders without leaving your analysis; you confirm every order. The site states that backtests are historical and signals do not remove risk. Investing and trading involve the risk of losing money.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Weekly AI list of 10 stocks
SwingMax signals
AI screener and filing tracker
Alphio AI assistant
Orders via a connected broker', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Retail investors and swing traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '$0 назавжди, без картки.', '$0 forever, no card needed.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$0 forever, no card needed.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Reflexivity — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reflexivity.com' OR LOWER(`name`) = 'reflexivity')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Reflexivity', NULL, 'https://www.reflexivity.com', NULL, NULL, 'AI-платформа для інституційних інвесторів: аналіз, скринінг і стрес-тести портфеля на даних S&P Global, LSEG, Cboe, Nasdaq.', 'An AI platform for institutional investors: analysis, screening and portfolio stress tests on data from S&P Global, LSEG, Cboe and Nasdaq.', 'Reflexivity поєднує дані S&P Global, LSEG Datastream, Cboe, Nasdaq та інших постачальників з пояснюваним AI. AI-агент пише й виконує код, щоб відповісти на складні фінансові питання, а платформа показує ризики й експозицію портфеля, моделює сценарії та проводить скринінг за графом знань і настроями ринку. Окремі договори на дані не потрібні. Доступ — через веб-платформу або API, демо за запитом.', 'Reflexivity combines data from S&P Global, LSEG Datastream, Cboe, Nasdaq and others with explainable AI. An AI agent writes and runs code to answer complex financial questions, and the platform shows portfolio risk and exposure, models scenarios and screens using a knowledge graph and market sentiment. No separate data contracts are required. Access is via the web platform or API, with demos on request.', 'AI-агент для інвестиційного аналізу
Аналітика ризиків портфеля
Моделювання сценаріїв і стрес-тести
Скринінг за графом знань', 'AI agent for investment analysis
Portfolio risk analytics
Scenario modelling and stress tests
Knowledge-graph screening', 'Інституційні інвестори, фонди та аналітики.', 'Institutional investors, funds and analysts.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reflexivity.com' OR LOWER(`name`) = 'reflexivity') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI platform for institutional investors: analysis, screening and portfolio stress tests on data from S&P Global, LSEG, Cboe and Nasdaq.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Reflexivity combines data from S&P Global, LSEG Datastream, Cboe, Nasdaq and others with explainable AI. An AI agent writes and runs code to answer complex financial questions, and the platform shows portfolio risk and exposure, models scenarios and screens using a knowledge graph and market sentiment. No separate data contracts are required. Access is via the web platform or API, with demos on request.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI agent for investment analysis
Portfolio risk analytics
Scenario modelling and stress tests
Knowledge-graph screening', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Institutional investors, funds and analysts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'year', 'Корпоративний доступ для фінансових компаній; ціна за запитом.', 'Enterprise access for financial firms; price on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Enterprise access for financial firms; price on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- FinBrain — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'finbrain.tech' OR LOWER(`name`) = 'finbrain')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'FinBrain', NULL, 'https://finbrain.tech', NULL, NULL, 'Альтернативні дані для трейдерів через один API: прогнози цін, інсайдерські угоди, угоди конгресменів, настрої новин.', 'Alternative data for traders through one API: price forecasts, insider trades, congressional trades, news sentiment.', 'FinBrain з 2018 року постачає альтернативні дані для трейдерів і дослідників. Через один API доступні 12 наборів даних: прогнози цін, інсайдерська торгівля, угоди членів Конгресу США, лобіювання, державні контракти, AI-оцінки настроїв новин, згадки на Reddit, дані мобільних застосунків і настрої опціонного ринку. Дані охоплюють понад 12 000 акцій і ETF США з повною історією для бектестів. Їх можна підключити до власних LLM або переглядати в терміналі.', 'FinBrain has supplied alternative data to traders and researchers since 2018. One API gives access to 12 datasets: price forecasts, insider trading, US congressional trades, lobbying, government contracts, AI news sentiment scores, Reddit mentions, mobile app data and options market sentiment. The data covers more than 12,000 US stocks and ETFs with full history for backtesting. You can plug it into your own LLMs or explore it in the terminal.', '12 наборів альтернативних даних
AI-оцінки настроїв новин
Понад 12 000 акцій і ETF США
API і термінал', '12 alternative datasets
AI news sentiment scores
Over 12,000 US stocks and ETFs
API and terminal', 'Кількісні трейдери, дослідники й розробники торгових моделей.', 'Quant traders, researchers and trading model developers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'finbrain.tech' OR LOWER(`name`) = 'finbrain') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Alternative data for traders through one API: price forecasts, insider trades, congressional trades, news sentiment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'FinBrain has supplied alternative data to traders and researchers since 2018. One API gives access to 12 datasets: price forecasts, insider trading, US congressional trades, lobbying, government contracts, AI news sentiment scores, Reddit mentions, mobile app data and options market sentiment. The data covers more than 12,000 US stocks and ETFs with full history for backtesting. You can plug it into your own LLMs or explore it in the terminal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '12 alternative datasets
AI news sentiment scores
Over 12,000 US stocks and ETFs
API and terminal', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Quant traders, researchers and trading model developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'API', 'API', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'API' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'API', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- StockInsights.ai — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stockinsights.ai' OR LOWER(`name`) = 'stockinsights.ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'StockInsights.ai', NULL, 'https://www.stockinsights.ai', NULL, NULL, 'AI-асистент для аналізу акцій: питання до звітів компаній, підсумки конференц-дзвінків, категоризація 8-K.', 'An AI equity research assistant: questions on company filings, earnings call summaries, 8-K categorisation.', 'StockInsights.ai допомагає аналізувати публічні компанії за допомогою генеративного AI. Можна ставити запитання до звітності й стенограм конференц-дзвінків, отримувати AI-підсумки звітів і категоризовані повідомлення 8-K. Платформа розрахована на вартісних інвесторів і покриває ринки США та Індії. Є API для інтеграції даних і AI-аналітики у власні процеси.', 'StockInsights.ai helps analyse public companies with generative AI. You can ask questions about filings and earnings call transcripts, get AI summaries of reports and categorised 8-K filings. The platform is designed for value investors and covers US and Indian markets. An API lets you integrate the data and AI insights into your own workflows.', 'Запитання до звітності й стенограм
AI-підсумки конференц-дзвінків
Категоризація повідомлень 8-K
Ринки США та Індії
API', 'Questions on filings and transcripts
AI earnings call summaries
8-K filing categorisation
US and Indian markets
API', 'Вартісні інвестори й аналітики.', 'Value investors and analysts.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stockinsights.ai' OR LOWER(`name`) = 'stockinsights.ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI equity research assistant: questions on company filings, earnings call summaries, 8-K categorisation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'StockInsights.ai helps analyse public companies with generative AI. You can ask questions about filings and earnings call transcripts, get AI summaries of reports and categorised 8-K filings. The platform is designed for value investors and covers US and Indian markets. An API lets you integrate the data and AI insights into your own workflows.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Questions on filings and transcripts
AI earnings call summaries
8-K filing categorisation
US and Indian markets
API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Value investors and analysts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Обмежений щомісячний доступ до основних функцій.', 'Limited monthly access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Limited monthly access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 17.00, 'month', '$17 на місяць при річній оплаті ($200 на рік).', '$17 per month billed yearly ($200 per year).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$17 per month billed yearly ($200 per year).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tradytics — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tradytics.com' OR LOWER(`name`) = 'tradytics')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tradytics', NULL, 'https://tradytics.com', NULL, NULL, 'AI-інструменти для аналізу опціонного потоку, угод у dark pool і торгових ідей.', 'AI tools for analysing options flow, dark pool trades and trade ideas.', 'Tradytics аналізує дані опціонного потоку й великих угод та за допомогою AI перетворює їх на огляди й торгові ідеї. AI також стисло підсумовує новини, щоб тримати вас у курсі подій. Є вебплатформа, полегшені мобільні застосунки й окремий бот для Discord-спільнот. Сервіс розрахований на трейдерів, які вже торгують акціями й опціонами. Інвестиції та торгівля пов''язані з ризиком втрати коштів.', 'Tradytics analyses options flow and large trade data and uses AI to turn it into overviews and trade ideas. AI also summarises news to keep you up to date. There is a web platform, lightweight mobile apps and a separate bot for Discord communities. The service is aimed at traders who already trade stocks and options. Investing and trading involve the risk of losing money.', 'Аналіз опціонного потоку
AI-підсумки новин
Торгові ідеї на основі даних
Бот для Discord', 'Options flow analysis
AI news summaries
Data-driven trade ideas
Discord bot', 'Трейдери акціями й опціонами.', 'Stock and options traders.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tradytics.com' OR LOWER(`name`) = 'tradytics') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI tools for analysing options flow, dark pool trades and trade ideas.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tradytics analyses options flow and large trade data and uses AI to turn it into overviews and trade ideas. AI also summarises news to keep you up to date. There is a web platform, lightweight mobile apps and a separate bot for Discord communities. The service is aimed at traders who already trade stocks and options. Investing and trading involve the risk of losing money.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Options flow analysis
AI news summaries
Data-driven trade ideas
Discord bot', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Stock and options traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Trial', 15.00, 'one_time', 'Пробні 15 днів за $15.', 'A 15-day trial for $15.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A 15-day trial for $15.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Quiver Quantitative — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'quiverquant.com' OR LOWER(`name`) = 'quiver quantitative')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Quiver Quantitative', NULL, 'https://www.quiverquant.com', NULL, NULL, 'Альтернативні дані для інвесторів: угоди політиків, інсайдери, інституційні портфелі, бектест стратегій.', 'Alternative data for investors: politicians'' trades, insiders, institutional holdings, strategy backtests.', 'Quiver Quantitative збирає альтернативні дані, які впливають на ринок: угоди політиків, інсайдерські угоди, зміни в портфелях фондів, лобіювання та інше. На цих даних побудовано стратегії з бектестом, скринер акцій за унікальними фільтрами й живі сповіщення. Є API і MCP-сервер для підключення даних до власних досліджень. Частина функцій безкоштовна.', 'Quiver Quantitative collects alternative data that moves markets: politicians'' trades, insider trades, fund holdings changes, lobbying and more. Built on this data are backtested strategies, a stock screener with unique filters and live alerts. An API and MCP server let you plug the data into your own research. Some features are free.', 'Угоди політиків та інсайдерів
Стратегії з бектестом
Скринер за альтернативними даними
Живі сповіщення
API і MCP-сервер', 'Politician and insider trades
Backtested strategies
Alternative-data screener
Live alerts
API and MCP server', 'Інвестори й дослідники, яких цікавлять альтернативні дані.', 'Investors and researchers interested in alternative data.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'quiverquant.com' OR LOWER(`name`) = 'quiver quantitative') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Alternative data for investors: politicians'' trades, insiders, institutional holdings, strategy backtests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Quiver Quantitative collects alternative data that moves markets: politicians'' trades, insider trades, fund holdings changes, lobbying and more. Built on this data are backtested strategies, a stock screener with unique filters and live alerts. An API and MCP server let you plug the data into your own research. Some features are free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Politician and insider trades
Backtested strategies
Alternative-data screener
Live alerts
API and MCP server', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors and researchers interested in alternative data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовні функції для відвідувачів.', 'Free features for visitors.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free features for visitors.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', NULL, 'month', '7 днів безкоштовно для місячного плану, 30 днів — для річного; ціни на сайті.', '7-day free trial on monthly plans, 30 days on annual; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '7-day free trial on monthly plans, 30 days on annual; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Unusual Whales — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'unusualwhales.com' OR LOWER(`name`) = 'unusual whales')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Unusual Whales', NULL, 'https://unusualwhales.com', NULL, NULL, 'Опціонний потік, угоди dark pool, гамма-експозиція й AI-компаньйон для аналізу ринку.', 'Options flow, dark pool prints, gamma exposure and an AI companion for market analysis.', 'Unusual Whales показує незвичну опціонну активність у реальному часі, угоди dark pool, гамма-експозицію, угоди членів Конгресу, інсайдерів і звіти 13F. AI-компаньйон Mr. Whale відповідає на запитання про акції, ставить сповіщення з чату й надсилає щоденний огляд ринку. Дані можна підключити до Claude, ChatGPT чи власного агента через API та MCP. За даними сайту, спільнота налічує 100 000 трейдерів.', 'Unusual Whales shows unusual options activity in real time, dark pool prints, gamma exposure, congressional and insider trades and 13F filings. The Mr. Whale AI companion answers questions about stocks, sets alerts from chat and sends a daily market brief. Data can be connected to Claude, ChatGPT or your own agent via API and MCP. According to the site, its community has 100,000 traders.', 'Опціонний потік у реальному часі
Dark pool і гамма-експозиція
AI-компаньйон Mr. Whale
Угоди Конгресу й інсайдерів
API і MCP', 'Real-time options flow
Dark pool and gamma exposure
Mr. Whale AI companion
Congressional and insider trades
API and MCP', 'Активні трейдери акціями й опціонами.', 'Active stock and options traders.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'unusualwhales.com' OR LOWER(`name`) = 'unusual whales') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Options flow, dark pool prints, gamma exposure and an AI companion for market analysis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Unusual Whales shows unusual options activity in real time, dark pool prints, gamma exposure, congressional and insider trades and 13F filings. The Mr. Whale AI companion answers questions about stocks, sets alerts from chat and sends a daily market brief. Data can be connected to Claude, ChatGPT or your own agent via API and MCP. According to the site, its community has 100,000 traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time options flow
Dark pool and gamma exposure
Mr. Whale AI companion
Congressional and insider trades
API and MCP', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Active stock and options traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Alfa (Boosted.ai) — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'boosted.ai' OR LOWER(`name`) = 'alfa (boosted.ai)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Alfa (Boosted.ai)', NULL, 'https://www.boosted.ai', NULL, NULL, 'AI-платформа для інвестиційних досліджень, що стежить за компаніями й ринками та надсилає брифи з джерелами.', 'An AI investment research platform that monitors companies and markets and sends source-linked briefs.', 'Alfa від Boosted.ai постійно стежить за компаніями, ринками й вашими позиціями, розслідує суттєві події та надсилає структуровані брифи з посиланнями на джерела, коли виходять звіти, подання до регулятора чи новини. До кожного сповіщення додано пояснення, чому воно важливе. Є версії для приватних інвесторів, професіоналів і команд, інституцій, брокерів і розробників.', 'Alfa by Boosted.ai continuously monitors companies, markets and your holdings, investigates material events and sends structured, source-linked briefs when earnings, filings or news come out. Each alert explains why it matters. There are versions for individual investors, professionals and teams, institutions, brokerages and developers.', 'Моніторинг компаній і позицій
Брифи з посиланнями на джерела
Пояснення суттєвих подій
Версії від приватних до інституційних', 'Monitoring of companies and holdings
Source-linked briefs
Explanations of material events
Versions from individual to institutional', 'Приватні інвестори, аналітики й інвестиційні команди.', 'Individual investors, analysts and investment teams.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'boosted.ai' OR LOWER(`name`) = 'alfa (boosted.ai)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI investment research platform that monitors companies and markets and sends source-linked briefs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Alfa by Boosted.ai continuously monitors companies, markets and your holdings, investigates material events and sends structured, source-linked briefs when earnings, filings or news come out. Each alert explains why it matters. There are versions for individual investors, professionals and teams, institutions, brokerages and developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Monitoring of companies and holdings
Source-linked briefs
Explanations of material events
Versions from individual to institutional', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individual investors, analysts and investment teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Incite AI — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'inciteai.com' OR LOWER(`name`) = 'incite ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Incite AI', NULL, 'https://www.inciteai.com', NULL, NULL, 'Робочий простір для ринкових рішень: чат з AI, графіки й список спостереження в одному вікні.', 'A market decision workspace: AI chat, charts and a watchlist in one window.', 'Incite AI об''єднує список спостереження, чат з AI і графіки. Ставите запитання про акцію чи криптовалюту — і робочий простір перебудовується навколо відповіді: показує ключові рівні, обсяги, порівняння з іншими тикерами й умови, від яких залежить план. Є настільна вебверсія і застосунки для iOS та Android. Інвестиції та торгівля пов''язані з ризиком втрати коштів.', 'Incite AI brings together a watchlist, AI chat and charts. Ask a question about a stock or crypto and the workspace rearranges around the answer, showing key levels, volume, comparisons with other tickers and the conditions your plan depends on. There is a desktop web version and iOS and Android apps. Investing and trading involve the risk of losing money.', 'Чат з AI про ринок
Графіки й список спостереження
Порівняння тикерів
Застосунки iOS та Android', 'AI chat about markets
Charts and watchlist
Ticker comparisons
iOS and Android apps', 'Приватні трейдери й інвестори.', 'Retail traders and investors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'inciteai.com' OR LOWER(`name`) = 'incite ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A market decision workspace: AI chat, charts and a watchlist in one window.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Incite AI brings together a watchlist, AI chat and charts. Ask a question about a stock or crypto and the workspace rearranges around the answer, showing key levels, volume, comparisons with other tickers and the conditions your plan depends on. There is a desktop web version and iOS and Android apps. Investing and trading involve the risk of losing money.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI chat about markets
Charts and watchlist
Ticker comparisons
iOS and Android apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Retail traders and investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LevelFields — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'levelfields.ai' OR LOWER(`name`) = 'levelfields')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LevelFields', NULL, 'https://www.levelfields.ai', NULL, NULL, 'AI-сповіщення про події, що впливають на ціни акцій: моніторинг 6300 компаній за 24 сценаріями.', 'AI alerts on events that move stock prices: monitoring 6,300 companies across 24 scenarios.', 'LevelFields цілодобово відстежує новини 6300 компаній і шукає події, які історично впливали на ціну акцій, — 24 сценарії-каталізатори з перевіреними за 5 років закономірностями. Сповіщення про такі події надходять на пошту, тож не треба переглядати весь потік новин. Платформа розрахована на опціонних і свінг-трейдерів, аналітиків, радників і IR-команди. Історичні закономірності не гарантують повторення. Інвестиції та торгівля пов''язані з ризиком втрати коштів.', 'LevelFields monitors news on 6,300 companies around the clock and looks for events that have historically moved stock prices: 24 catalyst scenarios with patterns verified over 5 years. Alerts on such events go to your inbox, so you do not have to read the whole news stream. The platform is aimed at options and swing traders, analysts, advisers and IR teams. Historical patterns are not guaranteed to repeat. Investing and trading involve the risk of losing money.', 'Моніторинг новин 6300 компаній
24 сценарії-каталізатори
Сповіщення на пошту
Історичні закономірності реакції цін', 'News monitoring for 6,300 companies
24 catalyst scenarios
Email alerts
Historical price reaction patterns', 'Опціонні й свінг-трейдери, аналітики.', 'Options and swing traders, analysts.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'levelfields.ai' OR LOWER(`name`) = 'levelfields') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI alerts on events that move stock prices: monitoring 6,300 companies across 24 scenarios.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LevelFields monitors news on 6,300 companies around the clock and looks for events that have historically moved stock prices: 24 catalyst scenarios with patterns verified over 5 years. Alerts on such events go to your inbox, so you do not have to read the whole news stream. The platform is aimed at options and swing traders, analysts, advisers and IR teams. Historical patterns are not guaranteed to repeat. Investing and trading involve the risk of losing money.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'News monitoring for 6,300 companies
24 catalyst scenarios
Email alerts
Historical price reaction patterns', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Options and swing traders, analysts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TradingView — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tradingview.com' OR LOWER(`name`) = 'tradingview')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TradingView', NULL, 'https://www.tradingview.com', NULL, NULL, 'Платформа графіків і соціальна мережа трейдерів: усі ринки, індикатори, ідеї спільноти.', 'A charting platform and social network for traders: all markets, indicators and community ideas.', 'TradingView — платформа для технічного аналізу з графіками акцій, індексів, валют, ф''ючерсів і криптовалют. Тут можна будувати графіки з індикаторами й малювальними інструментами, створювати власні індикатори мовою Pine Script, ставити сповіщення, користуватися скринерами й економічним календарем. Спільнота публікує торгові ідеї та аналітику. Реєстрація безкоштовна, без картки; платні плани відкривають більше графіків на екрані, індикаторів і сповіщень.', 'TradingView is a technical analysis platform with charts for stocks, indices, currencies, futures and crypto. You can build charts with indicators and drawing tools, write custom indicators in Pine Script, set alerts and use screeners and an economic calendar. The community publishes trade ideas and analysis. Sign-up is free with no card; paid plans unlock more charts per layout, indicators and alerts.', 'Графіки для всіх ринків
Індикатори й Pine Script
Сповіщення та скринери
Ідеї спільноти трейдерів
Веб, десктоп і мобільні застосунки', 'Charts for all markets
Indicators and Pine Script
Alerts and screeners
Trader community ideas
Web, desktop and mobile apps', 'Трейдери й інвестори будь-якого рівня.', 'Traders and investors of any level.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tradingview.com' OR LOWER(`name`) = 'tradingview') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A charting platform and social network for traders: all markets, indicators and community ideas.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TradingView is a technical analysis platform with charts for stocks, indices, currencies, futures and crypto. You can build charts with indicators and drawing tools, write custom indicators in Pine Script, set alerts and use screeners and an economic calendar. The community publishes trade ideas and analysis. Sign-up is free with no card; paid plans unlock more charts per layout, indicators and alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Charts for all markets
Indicators and Pine Script
Alerts and screeners
Trader community ideas
Web, desktop and mobile apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders and investors of any level.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '$0 назавжди, без картки.', '$0 forever, no card needed.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$0 forever, no card needed.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Finviz — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'finviz.com' OR LOWER(`name`) = 'finviz')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Finviz', NULL, 'https://finviz.com', NULL, NULL, 'Скринер акцій і фінансові візуалізації: теплові карти ринку, фільтри, новини, сигнали.', 'A stock screener and financial visualisations: market heat maps, filters, news, signals.', 'Finviz відомий скринером акцій із сотнями фундаментальних і технічних фільтрів, тепловою картою ринку та добірками на кшталт лідерів зростання, незвичних обсягів чи нових максимумів. На головній зібрано свіжі новини й сигнали. Безкоштовні котирування затримані; підписка Elite додає дані в реальному часі, технічні графіки, сповіщення, розширені фільтри, експорт, API і прибирає рекламу.', 'Finviz is known for its stock screener with hundreds of fundamental and technical filters, a market heat map and lists like top gainers, unusual volume and new highs. The home page gathers fresh news and signals. Free quotes are delayed; the Elite subscription adds real-time data, technical charts, alerts, advanced filters, exports, an API and no ads.', 'Скринер акцій з сотнями фільтрів
Теплова карта ринку
Новини й торгові сигнали
Elite: дані в реальному часі й сповіщення', 'Stock screener with hundreds of filters
Market heat map
News and trading signals
Elite: real-time data and alerts', 'Трейдери й інвестори, що шукають акції за критеріями.', 'Traders and investors screening for stocks.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'finviz.com' OR LOWER(`name`) = 'finviz') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A stock screener and financial visualisations: market heat maps, filters, news, signals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Finviz is known for its stock screener with hundreds of fundamental and technical filters, a market heat map and lists like top gainers, unusual volume and new highs. The home page gathers fresh news and signals. Free quotes are delayed; the Elite subscription adds real-time data, technical charts, alerts, advanced filters, exports, an API and no ads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stock screener with hundreds of filters
Market heat map
News and trading signals
Elite: real-time data and alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders and investors screening for stocks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Скринер і карта з затриманими даними.', 'Screener and map with delayed data.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Screener and map with delayed data.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Elite', 'Elite', 24.96, 'month', 'Від $24.96 на місяць: дані в реальному часі, графіки, сповіщення, без реклами.', 'From $24.96 per month: real-time data, charts, alerts, no ads.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Elite' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Elite', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From $24.96 per month: real-time data, charts, alerts, no ads.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Koyfin — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'koyfin.com' OR LOWER(`name`) = 'koyfin')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Koyfin', NULL, 'https://www.koyfin.com', NULL, NULL, 'Дослідження ринків, аналіз портфелів і звіти для клієнтів: акції, ETF, фонди, облігації, валюти.', 'Market research, portfolio analysis and client reports: stocks, ETFs, funds, bonds, currencies.', 'Koyfin збирає в одному місці дані для дослідження ринків: акції, ETF, взаємні фонди, валюти, облігації. Можна налаштовувати власні дашборди, графіки й скринери, аналізувати портфелі за складовими, секторами й галузями та готувати звіти для клієнтів. Платформа розрахована і на приватних інвесторів, і на фінансових радників; є безкоштовний план.', 'Koyfin brings market research data into one place: stocks, ETFs, mutual funds, currencies and bonds. You can build custom dashboards, charts and screeners, analyse portfolios by holdings, sectors and industries and prepare client-ready reports. The platform serves both individual investors and financial advisers; there is a free plan.', 'Власні дашборди й графіки
Скринери акцій і фондів
Аналіз портфеля
Звіти для клієнтів', 'Custom dashboards and charts
Stock and fund screeners
Portfolio analysis
Client-ready reports', 'Приватні інвестори й фінансові радники.', 'Individual investors and financial advisers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'koyfin.com' OR LOWER(`name`) = 'koyfin') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Market research, portfolio analysis and client reports: stocks, ETFs, funds, bonds, currencies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Koyfin brings market research data into one place: stocks, ETFs, mutual funds, currencies and bonds. You can build custom dashboards, charts and screeners, analyse portfolios by holdings, sectors and industries and prepare client-ready reports. The platform serves both individual investors and financial advisers; there is a free plan.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Custom dashboards and charts
Stock and fund screeners
Portfolio analysis
Client-ready reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individual investors and financial advisers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Seeking Alpha — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seekingalpha.com' OR LOWER(`name`) = 'seeking alpha')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Seeking Alpha', NULL, 'https://seekingalpha.com', NULL, NULL, 'Інвестиційна спільнота з аналітикою акцій, новинами, стенограмами звітів і квантовими рейтингами.', 'An investing community with stock analysis, news, earnings call transcripts and quant ratings.', 'Seeking Alpha публікує аналітичні статті незалежних авторів, новини ринку, стенограми конференц-дзвінків, дивідендну інформацію та інструменти для аналізу портфеля. Підписка Premium відкриває квантові рейтинги, оцінки факторів і необмежений доступ до аналітики. Статті висловлюють думку авторів і не є персональною порадою.', 'Seeking Alpha publishes analysis from independent contributors, market news, earnings call transcripts, dividend data and portfolio analysis tools. A Premium subscription unlocks quant ratings, factor grades and unlimited access to analysis. Articles reflect their authors'' views and are not personal advice.', 'Аналітика незалежних авторів
Новини й стенограми звітів
Квантові рейтинги (Premium)
Аналіз портфеля', 'Analysis from independent contributors
News and earnings transcripts
Quant ratings (Premium)
Portfolio analysis', 'Довгострокові інвестори й дивідендні інвестори.', 'Long-term and dividend investors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seekingalpha.com' OR LOWER(`name`) = 'seeking alpha') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An investing community with stock analysis, news, earnings call transcripts and quant ratings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Seeking Alpha publishes analysis from independent contributors, market news, earnings call transcripts, dividend data and portfolio analysis tools. A Premium subscription unlocks quant ratings, factor grades and unlimited access to analysis. Articles reflect their authors'' views and are not personal advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Analysis from independent contributors
News and earnings transcripts
Quant ratings (Premium)
Portfolio analysis', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Long-term and dividend investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Новини й частина аналітики.', 'News and some analysis.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'News and some analysis.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', NULL, 'year', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Zacks — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zacks.com' OR LOWER(`name`) = 'zacks')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Zacks', NULL, 'https://www.zacks.com', NULL, NULL, 'Дослідження акцій і фондів з рейтингом Zacks Rank, скринерами та аналітикою прибутків.', 'Stock and fund research with the Zacks Rank, screeners and earnings analysis.', 'Zacks Investment Research відомий рейтингом Zacks Rank, що оцінює акції на основі змін прогнозів прибутку аналітиків. На сайті є скринери акцій і взаємних фондів, огляди галузей, календар звітів і добірки акцій. Частина рейтингів і досліджень доступна безкоштовно, розширені сервіси — за підпискою.', 'Zacks Investment Research is known for the Zacks Rank, which rates stocks based on changes in analysts'' earnings estimates. The site has stock and mutual fund screeners, industry reviews, an earnings calendar and stock lists. Some ratings and research are free, with advanced services by subscription.', 'Рейтинг Zacks Rank
Скринери акцій і фондів
Календар звітів
Огляди галузей', 'Zacks Rank
Stock and fund screeners
Earnings calendar
Industry reviews', 'Інвестори, що шукають акції за змінами прогнозів прибутку.', 'Investors looking for stocks based on earnings estimate revisions.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zacks.com' OR LOWER(`name`) = 'zacks') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Stock and fund research with the Zacks Rank, screeners and earnings analysis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Zacks Investment Research is known for the Zacks Rank, which rates stocks based on changes in analysts'' earnings estimates. The site has stock and mutual fund screeners, industry reviews, an earnings calendar and stock lists. Some ratings and research are free, with advanced services by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Zacks Rank
Stock and fund screeners
Earnings calendar
Industry reviews', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors looking for stocks based on earnings estimate revisions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', NULL, 'year', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Simply Wall St — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simplywall.st' OR LOWER(`name`) = 'simply wall st')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Simply Wall St', NULL, 'https://simplywall.st', NULL, NULL, 'Візуальні звіти про 120 000 акцій світу, трекер портфеля, скринер і AI-асистент Charlie.', 'Visual reports on 120,000 global stocks, a portfolio tracker, a screener and the Charlie AI assistant.', 'Simply Wall St зводить тисячі показників компанії в один наочний звіт: оцінка, зростання, фінансове здоров''я, дивіденди. Можна фільтрувати 120 000 акцій світу, вести трекер портфеля й дивідендів, отримувати щоденні сповіщення про звітність, зміну оцінки та інсайдерські угоди. Є спільнота з інвестиційними «наративами» й AI-асистент Charlie. Дослідити будь-яку акцію можна безкоштовно.', 'Simply Wall St condenses thousands of company data points into one visual report: valuation, growth, financial health and dividends. You can filter 120,000 global stocks, track your portfolio and dividends and get daily alerts on earnings, valuation changes and insider trading. There is a community with investment "narratives" and the Charlie AI assistant. You can research any stock for free.', 'Візуальні звіти про компанії
Скринер 120 000 акцій
Трекер портфеля й дивідендів
Щоденні сповіщення
AI-асистент Charlie', 'Visual company reports
Screener for 120,000 stocks
Portfolio and dividend tracker
Daily alerts
Charlie AI assistant', 'Довгострокові приватні інвестори.', 'Long-term individual investors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simplywall.st' OR LOWER(`name`) = 'simply wall st') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Visual reports on 120,000 global stocks, a portfolio tracker, a screener and the Charlie AI assistant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Simply Wall St condenses thousands of company data points into one visual report: valuation, growth, financial health and dividends. You can filter 120,000 global stocks, track your portfolio and dividends and get daily alerts on earnings, valuation changes and insider trading. There is a community with investment "narratives" and the Charlie AI assistant. You can research any stock for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Visual company reports
Screener for 120,000 stocks
Portfolio and dividend tracker
Daily alerts
Charlie AI assistant', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Long-term individual investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Barchart — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'barchart.com' OR LOWER(`name`) = 'barchart')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Barchart', NULL, 'https://www.barchart.com', NULL, NULL, 'Ринкові дані, новини й інструменти для акцій, опціонів, ф''ючерсів, ETF і валют.', 'Market data, news and tools for stocks, options, futures, ETFs and currencies.', 'Barchart надає котирування, графіки й новини для акцій, опціонів, ф''ючерсів, ETF і валют. Є добірки лідерів зростання й падіння, нових максимумів і мінімумів, лідерів за обсягом, незвичної опціонної активності, а також скринери й списки спостереження. Безкоштовний доступ доповнюють платні плани з розширеними даними.', 'Barchart provides quotes, charts and news for stocks, options, futures, ETFs and currencies. There are lists of top gainers and losers, new highs and lows, volume leaders and unusual options activity, plus screeners and watchlists. Free access is complemented by paid plans with extended data.', 'Дані для акцій, опціонів і ф''ючерсів
Незвична опціонна активність
Скринери й списки спостереження
Новини ринку', 'Data for stocks, options and futures
Unusual options activity
Screeners and watchlists
Market news', 'Трейдери акціями, опціонами й ф''ючерсами.', 'Stock, options and futures traders.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'barchart.com' OR LOWER(`name`) = 'barchart') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Market data, news and tools for stocks, options, futures, ETFs and currencies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Barchart provides quotes, charts and news for stocks, options, futures, ETFs and currencies. There are lists of top gainers and losers, new highs and lows, volume leaders and unusual options activity, plus screeners and watchlists. Free access is complemented by paid plans with extended data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Data for stocks, options and futures
Unusual options activity
Screeners and watchlists
Market news', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Stock, options and futures traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- StockCharts — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stockcharts.com' OR LOWER(`name`) = 'stockcharts')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'StockCharts', NULL, 'https://stockcharts.com', NULL, NULL, 'Графіки, скринінг і технічний аналіз з 1999 року: індикатори, сповіщення, управління портфелем.', 'Charting, screening and technical analysis since 1999: indicators, alerts, portfolio management.', 'StockCharts з 1999 року пропонує інструменти технічного аналізу: від простих свічкових до складних візуалізацій, десятки індикаторів і порівняння інструментів на різних таймфреймах. Є власні скринери, автоматичні сповіщення в реальному часі та інструменти для управління портфелем. Преміум-акаунт відкриває розширені графіки, швидкий скринінг і сповіщення.', 'StockCharts has offered technical analysis tools since 1999: from simple candlesticks to advanced visualisations, dozens of indicators and comparisons across timeframes. There are custom screeners, automatic real-time alerts and portfolio management tools. A premium account unlocks advanced charting, fast screening and alerts.', 'Розширені графіки й десятки індикаторів
Власні скринери
Сповіщення в реальному часі
Управління портфелем', 'Advanced charts and dozens of indicators
Custom screeners
Real-time alerts
Portfolio management', 'Трейдери, що використовують технічний аналіз.', 'Traders who use technical analysis.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stockcharts.com' OR LOWER(`name`) = 'stockcharts') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Charting, screening and technical analysis since 1999: indicators, alerts, portfolio management.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'StockCharts has offered technical analysis tools since 1999: from simple candlesticks to advanced visualisations, dozens of indicators and comparisons across timeframes. There are custom screeners, automatic real-time alerts and portfolio management tools. A premium account unlocks advanced charting, fast screening and alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Advanced charts and dozens of indicators
Custom screeners
Real-time alerts
Portfolio management', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders who use technical analysis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Investing.com — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'investing.com' OR LOWER(`name`) = 'investing.com')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Investing.com', NULL, 'https://www.investing.com', NULL, NULL, 'Котирування, новини, економічний календар і AI-інструменти InvestingPro: ProPicks AI та WarrenAI.', 'Quotes, news, an economic calendar and InvestingPro AI tools: ProPicks AI and WarrenAI.', 'Investing.com надає котирування в реальному часі, графіки, новини, економічний календар і скринер акцій для світових ринків. Підписка InvestingPro додає AI-добірки ProPicks AI, асистента WarrenAI для запитань про ринок, оцінки справедливої вартості й розширені дані. Базові функції безкоштовні.', 'Investing.com offers real-time quotes, charts, news, an economic calendar and a stock screener for global markets. The InvestingPro subscription adds ProPicks AI stock lists, the WarrenAI assistant for market questions, fair value estimates and extended data. Core features are free.', 'Котирування світових ринків
Економічний календар
Скринер акцій
ProPicks AI і WarrenAI (InvestingPro)', 'Global market quotes
Economic calendar
Stock screener
ProPicks AI and WarrenAI (InvestingPro)', 'Трейдери й інвестори на будь-яких ринках.', 'Traders and investors in any market.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'investing.com' OR LOWER(`name`) = 'investing.com') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Quotes, news, an economic calendar and InvestingPro AI tools: ProPicks AI and WarrenAI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Investing.com offers real-time quotes, charts, news, an economic calendar and a stock screener for global markets. The InvestingPro subscription adds ProPicks AI stock lists, the WarrenAI assistant for market questions, fair value estimates and extended data. Core features are free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Global market quotes
Economic calendar
Stock screener
ProPicks AI and WarrenAI (InvestingPro)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders and investors in any market.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'InvestingPro', 'InvestingPro', NULL, 'year', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'InvestingPro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'InvestingPro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Yahoo Finance — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'finance.yahoo.com' OR LOWER(`name`) = 'yahoo finance')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Yahoo Finance', NULL, 'https://finance.yahoo.com', NULL, NULL, 'Безкоштовні котирування, новини, графіки й інструменти для відстеження портфеля.', 'Free quotes, news, charts and portfolio tracking tools.', 'Yahoo Finance — безкоштовне джерело котирувань, фінансових новин, графіків і даних про світові ринки. Можна створювати портфелі й списки спостереження, переглядати фінансові звіти компаній, аналітичні оцінки та календар подій. Платна підписка додає розширені дослідження й інструменти.', 'Yahoo Finance is a free source of quotes, financial news, charts and global market data. You can create portfolios and watchlists and view company financials, analyst estimates and an events calendar. A paid subscription adds advanced research and tools.', 'Котирування й графіки
Фінансові новини
Портфелі й списки спостереження
Звіти компаній', 'Quotes and charts
Financial news
Portfolios and watchlists
Company financials', 'Усі, хто стежить за ринком.', 'Anyone who follows the markets.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'finance.yahoo.com' OR LOWER(`name`) = 'yahoo finance') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free quotes, news, charts and portfolio tracking tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Yahoo Finance is a free source of quotes, financial news, charts and global market data. You can create portfolios and watchlists and view company financials, analyst estimates and an events calendar. A paid subscription adds advanced research and tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Quotes and charts
Financial news
Portfolios and watchlists
Company financials', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who follows the markets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Morningstar Investor — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'morningstar.com' OR LOWER(`name`) = 'morningstar investor')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Morningstar Investor', NULL, 'https://www.morningstar.com', NULL, NULL, 'Аналіз і рейтинги фондів, ETF та акцій від Morningstar, інструменти для портфеля.', 'Fund, ETF and stock analysis and ratings from Morningstar, plus portfolio tools.', 'Morningstar — дослідницька компанія, відома рейтингами взаємних фондів і ETF, а також аналізом акцій з оцінкою справедливої вартості. На сайті публікуються статті про інвестування, пенсійне планування й ринки. Підписка Morningstar Investor відкриває повні дослідження, скринери й інструменти аналізу портфеля.', 'Morningstar is a research company known for its mutual fund and ETF ratings and stock analysis with fair value estimates. The site publishes articles on investing, retirement planning and markets. A Morningstar Investor subscription unlocks full research, screeners and portfolio analysis tools.', 'Рейтинги фондів і ETF
Аналіз акцій і справедлива вартість
Скринери
Аналіз портфеля', 'Fund and ETF ratings
Stock analysis and fair value
Screeners
Portfolio analysis', 'Довгострокові інвестори у фонди й акції.', 'Long-term fund and stock investors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'morningstar.com' OR LOWER(`name`) = 'morningstar investor') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fund, ETF and stock analysis and ratings from Morningstar, plus portfolio tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Morningstar is a research company known for its mutual fund and ETF ratings and stock analysis with fair value estimates. The site publishes articles on investing, retirement planning and markets. A Morningstar Investor subscription unlocks full research, screeners and portfolio analysis tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fund and ETF ratings
Stock analysis and fair value
Screeners
Portfolio analysis', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Long-term fund and stock investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Статті й частина даних.', 'Articles and some data.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Articles and some data.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Morningstar Investor', 'Morningstar Investor', NULL, 'year', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Morningstar Investor' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Morningstar Investor', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- WallStreetZen — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wallstreetzen.com' OR LOWER(`name`) = 'wallstreetzen')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'WallStreetZen', NULL, 'https://www.wallstreetzen.com', NULL, NULL, 'Аналіз акцій для інвесторів з неповною зайнятістю: квантовий рейтинг Zen Ratings за 115 факторами.', 'Stock analysis for part-time investors: the Zen Ratings quant model using 115 factors.', 'WallStreetZen допомагає приватним інвесторам аналізувати акції. Квантова модель Zen Ratings оцінює акції за 115 факторами й присвоює оцінки від A до F. Є щоденні добірки з поясненнями, дані про угоди інсайдерів, прогнози аналітиків і скринер. Сайт наводить історичну дохідність рейтингів, але вона не гарантує майбутніх результатів.', 'WallStreetZen helps individual investors analyse stocks. The Zen Ratings quant model scores stocks on 115 factors and assigns grades from A to F. There are daily lists with explanations, insider trading data, analyst forecasts and a screener. The site cites historical returns of its ratings, but they do not guarantee future results.', 'Zen Ratings за 115 факторами
Щоденні добірки акцій
Угоди інсайдерів
Прогнози аналітиків і скринер', 'Zen Ratings on 115 factors
Daily stock lists
Insider trades
Analyst forecasts and screener', 'Приватні інвестори з обмеженим часом на аналіз.', 'Individual investors with limited time for research.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wallstreetzen.com' OR LOWER(`name`) = 'wallstreetzen') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Stock analysis for part-time investors: the Zen Ratings quant model using 115 factors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'WallStreetZen helps individual investors analyse stocks. The Zen Ratings quant model scores stocks on 115 factors and assigns grades from A to F. There are daily lists with explanations, insider trading data, analyst forecasts and a screener. The site cites historical returns of its ratings, but they do not guarantee future results.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Zen Ratings on 115 factors
Daily stock lists
Insider trades
Analyst forecasts and screener', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individual investors with limited time for research.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', NULL, 'month', 'Пробний доступ за $1; повна ціна — на сайті.', 'Trial access for $1; full price on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Trial access for $1; full price on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Stockopedia — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stockopedia.com' OR LOWER(`name`) = 'stockopedia')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Stockopedia', NULL, 'https://www.stockopedia.com', NULL, NULL, 'Дослідження акцій на основі даних: рейтинги StockRanks 0–100, скринери й аналітика.', 'Data-driven stock research: StockRanks from 0 to 100, screeners and analysis.', 'Stockopedia пропонує системний підхід до вибору акцій. Власні рейтинги StockRanks оцінюють кожну компанію від 0 до 100 за якістю, вартістю й імпульсом. Є скринери за класичними інвестиційними стратегіями, аналітика й інструменти для портфеля. Сервіс популярний у Великій Британії й охоплює й інші ринки.', 'Stockopedia offers a systematic approach to picking stocks. Its StockRanks score every company from 0 to 100 on quality, value and momentum. There are screeners based on classic investment strategies, research and portfolio tools. The service is popular in the UK and covers other markets too.', 'Рейтинги StockRanks 0–100
Скринери за стратегіями
Аналітика компаній
Інструменти для портфеля', 'StockRanks from 0 to 100
Strategy screeners
Company research
Portfolio tools', 'Активні приватні інвестори.', 'Active individual investors.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stockopedia.com' OR LOWER(`name`) = 'stockopedia') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Data-driven stock research: StockRanks from 0 to 100, screeners and analysis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Stockopedia offers a systematic approach to picking stocks. Its StockRanks score every company from 0 to 100 on quality, value and momentum. There are screeners based on classic investment strategies, research and portfolio tools. The service is popular in the UK and covers other markets too.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'StockRanks from 0 to 100
Strategy screeners
Company research
Portfolio tools', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Active individual investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'month', '14 днів безкоштовно; ціни на сайті.', '14 days free; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '14 days free; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MarketBeat — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'marketbeat.com' OR LOWER(`name`) = 'marketbeat')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MarketBeat', NULL, 'https://www.marketbeat.com', NULL, NULL, 'Новини фондового ринку, рейтинги аналітиків, дивіденди, звіти, інсайдерські угоди й опціони.', 'Stock market news, analyst ratings, dividends, earnings, insider trades and options data.', 'MarketBeat публікує новини ринку й дані про будь-яку акцію: зміни рейтингів аналітиків, дивідендну інформацію, результати звітів, фінанси, інсайдерські угоди й опціонні дані. Є тематичні добірки акцій, миттєві сповіщення про новини та торгові ідеї. Добірки — це огляди, а не персональні рекомендації.', 'MarketBeat publishes market news and data on any stock: analyst rating changes, dividend information, earnings results, financials, insider trades and options data. There are themed stock lists, instant news alerts and trade ideas. The lists are overviews, not personal recommendations.', 'Рейтинги аналітиків у реальному часі
Дивіденди й звіти
Інсайдерські угоди
Сповіщення про новини', 'Real-time analyst ratings
Dividends and earnings
Insider trades
News alerts', 'Приватні інвестори.', 'Individual investors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'marketbeat.com' OR LOWER(`name`) = 'marketbeat') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Stock market news, analyst ratings, dividends, earnings, insider trades and options data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MarketBeat publishes market news and data on any stock: analyst rating changes, dividend information, earnings results, financials, insider trades and options data. There are themed stock lists, instant news alerts and trade ideas. The lists are overviews, not personal recommendations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time analyst ratings
Dividends and earnings
Insider trades
News alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individual investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Benzinga Pro — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pro.benzinga.com' OR LOWER(`name`) = 'benzinga pro')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Benzinga Pro', NULL, 'https://pro.benzinga.com', NULL, NULL, 'Швидка стрічка ринкових новин, аудіо-сквок і сповіщення для денних трейдерів.', 'A fast market newsfeed, audio squawk and alerts for day traders.', 'Benzinga Pro — платформа фінансових новин і досліджень з Детройта. Редакція в реальному часі відбирає новини, які рухають акції, а щоденний аудіо-сквок озвучує ключові заголовки й оновлення ринку. Налаштовувані сповіщення допомагають стежити за акціями, що виходять з діапазону. Сервіс розрахований на активних трейдерів.', 'Benzinga Pro is a financial news and research platform from Detroit. The newsdesk picks stories that move stocks in real time, and a daily audio squawk reads out key headlines and market updates. Customisable alerts help you track breakout stocks. The service is aimed at active traders.', 'Новинна стрічка в реальному часі
Аудіо-сквок
Налаштовувані сповіщення
Інструменти дослідження', 'Real-time newsfeed
Audio squawk
Customisable alerts
Research tools', 'Денні трейдери й активні інвестори.', 'Day traders and active investors.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pro.benzinga.com' OR LOWER(`name`) = 'benzinga pro') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A fast market newsfeed, audio squawk and alerts for day traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Benzinga Pro is a financial news and research platform from Detroit. The newsdesk picks stories that move stocks in real time, and a daily audio squawk reads out key headlines and market updates. Customisable alerts help you track breakout stocks. The service is aimed at active traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time newsfeed
Audio squawk
Customisable alerts
Research tools', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Day traders and active investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OptionStrat — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'optionstrat.com' OR LOWER(`name`) = 'optionstrat')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OptionStrat', NULL, 'https://optionstrat.com', NULL, NULL, 'Візуалізація опціонних стратегій, оптимізатор угод і потік незвичних опціонних угод.', 'Options strategy visualisation, a trade optimiser and unusual options flow.', 'OptionStrat — калькулятор прибутку для опціонів і аналізатор опціонного потоку. Можна побудувати стратегію й побачити, як змінюються прибуток і збиток залежно від ціни, часу та волатильності. Оптимізатор підбирає угоди під цільову ціну й дату, а потік показує великі й незвичні угоди. Опціони — складний інструмент з високим ризиком.', 'OptionStrat is an options profit calculator and options flow analyser. You can build a strategy and see how profit and loss change with price, time and volatility. The optimiser finds trades for a target price and date, and the flow shows large and unusual trades. Options are complex, high-risk instruments.', 'Конструктор і візуалізація стратегій
Оптимізатор угод
Потік незвичних угод
Аналіз впливу часу й волатильності', 'Strategy builder and visualisation
Trade optimiser
Unusual flow
Time and volatility analysis', 'Опціонні трейдери.', 'Options traders.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'optionstrat.com' OR LOWER(`name`) = 'optionstrat') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Options strategy visualisation, a trade optimiser and unusual options flow.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OptionStrat is an options profit calculator and options flow analyser. You can build a strategy and see how profit and loss change with price, time and volatility. The optimiser finds trades for a target price and date, and the flow shows large and unusual trades. Options are complex, high-risk instruments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Strategy builder and visualisation
Trade optimiser
Unusual flow
Time and volatility analysis', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Options traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Option Alpha — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'optionalpha.com' OR LOWER(`name`) = 'option alpha')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Option Alpha', NULL, 'https://optionalpha.com', NULL, NULL, 'Пошук, бектест і автоматизація опціонних стратегій за допомогою ботів без коду.', 'Discover, backtest and automate options strategies with no-code bots.', 'Option Alpha допомагає торгувати опціонами за планом: шукати можливості, тестувати варіанти стратегії на історії й автоматизувати їх ботами, які завжди дотримуються ваших правил. Можна взяти за основу тисячі бектестованих планів інших трейдерів. Є курси, довідник стратегій і подкаст. Платформа працює з TradeStation, tastytrade і Tradier; при підключенні цих рахунків доступ безкоштовний.', 'Option Alpha helps you trade options with a plan: find opportunities, backtest strategy variations and automate them with bots that always follow your rules. You can start from thousands of backtested plans by other traders. There are courses, a strategy handbook and a podcast. The platform works with TradeStation, tastytrade and Tradier; connecting these accounts makes it free.', 'Бектест опціонних стратегій
Боти без коду
Тисячі готових планів
Курси й довідник стратегій', 'Options strategy backtesting
No-code bots
Thousands of ready plans
Courses and strategy handbook', 'Опціонні трейдери, що хочуть автоматизації.', 'Options traders who want automation.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'optionalpha.com' OR LOWER(`name`) = 'option alpha') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Discover, backtest and automate options strategies with no-code bots.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Option Alpha helps you trade options with a plan: find opportunities, backtest strategy variations and automate them with bots that always follow your rules. You can start from thousands of backtested plans by other traders. There are courses, a strategy handbook and a podcast. The platform works with TradeStation, tastytrade and Tradier; connecting these accounts makes it free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Options strategy backtesting
No-code bots
Thousands of ready plans
Courses and strategy handbook', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Options traders who want automation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно при підключенні рахунку TradeStation, tastytrade або Tradier.', 'Free when you connect a TradeStation, tastytrade or Tradier account.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free when you connect a TradeStation, tastytrade or Tradier account.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'month', '30 днів безкоштовно без картки; ціни на сайті.', '30-day free trial, no card; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '30-day free trial, no card; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ziggma — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ziggma.com' OR LOWER(`name`) = 'ziggma')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ziggma', NULL, 'https://ziggma.com', NULL, NULL, 'Трекер портфеля, скринер і оптимізатор з урахуванням впливу інвестицій на клімат і суспільство.', 'A portfolio tracker, screener and optimiser that accounts for investments'' climate and social impact.', 'Ziggma допомагає відстежувати портфель, перевіряти його стан і оптимізувати дохідність. Скринер пропонує добірки акцій і фондів, від компаній зі зростаючою виручкою до чистої енергетики. Є власна оцінка акцій Ziggma Stock Score, модельні портфелі й налаштовувані сповіщення. Окремо показано, які галузі підтримують ваші гроші, тож можна виключити небажані, наприклад викопне паливо.', 'Ziggma helps you track your portfolio, check its health and optimise returns. The screener offers lists of stocks and funds, from accelerating growth to clean energy. There is the Ziggma Stock Score, model portfolios and custom alerts. It also shows which industries your money supports, so you can exclude unwanted ones such as fossil fuels.', 'Трекер і перевірка портфеля
Оптимізатор портфеля
Ziggma Stock Score
Аналіз впливу інвестицій', 'Portfolio tracker and checkup
Portfolio optimiser
Ziggma Stock Score
Investment impact analysis', 'Приватні інвестори, яким важливий вплив інвестицій.', 'Individual investors who care about investment impact.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ziggma.com' OR LOWER(`name`) = 'ziggma') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A portfolio tracker, screener and optimiser that accounts for investments'' climate and social impact.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ziggma helps you track your portfolio, check its health and optimise returns. The screener offers lists of stocks and funds, from accelerating growth to clean energy. There is the Ziggma Stock Score, model portfolios and custom alerts. It also shows which industries your money supports, so you can exclude unwanted ones such as fossil fuels.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Portfolio tracker and checkup
Portfolio optimiser
Ziggma Stock Score
Investment impact analysis', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individual investors who care about investment impact.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний старт.', 'Free to start.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to start.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GuruFocus — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gurufocus.com' OR LOWER(`name`) = 'gurufocus')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GuruFocus', NULL, 'https://www.gurufocus.com', NULL, NULL, 'Інструменти для вартісного інвестування: скринери, угоди відомих інвесторів, інсайдери, графіки.', 'Value investing tools: screeners, famous investors'' trades, insider trades, charts.', 'GuruFocus надає дані й інструменти для вартісного інвестування: розширені скринери, портфелі й угоди відомих інвесторів («гуру»), інсайдерські угоди, оцінки справедливої вартості й фінансові показники за багато років. Користувачі можуть створювати й ділитися власними стратегіями скринінгу. Є безкоштовний пробний період.', 'GuruFocus provides data and tools for value investing: advanced screeners, portfolios and trades of well-known investors ("gurus"), insider trades, fair value estimates and many years of financials. Users can create and share their own screening strategies. A free trial is available.', 'Портфелі й угоди «гуру»
Розширені скринери
Інсайдерські угоди
Оцінки справедливої вартості', 'Guru portfolios and trades
Advanced screeners
Insider trades
Fair value estimates', 'Вартісні інвестори.', 'Value investors.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gurufocus.com' OR LOWER(`name`) = 'gurufocus') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Value investing tools: screeners, famous investors'' trades, insider trades, charts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GuruFocus provides data and tools for value investing: advanced screeners, portfolios and trades of well-known investors ("gurus"), insider trades, fair value estimates and many years of financials. Users can create and share their own screening strategies. A free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Guru portfolios and trades
Advanced screeners
Insider trades
Fair value estimates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Value investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', NULL, 'year', '7 днів безкоштовно; ціни на сайті.', '7-day free trial; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '7-day free trial; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Stock Analysis — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stockanalysis.com' OR LOWER(`name`) = 'stock analysis')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Stock Analysis', NULL, 'https://stockanalysis.com', NULL, NULL, 'Дані про 130 000+ акцій і фондів світу: фінанси за десятиліття, скринер, прогнози, графіки.', 'Data on 130,000+ global stocks and funds: decades of financials, a screener, forecasts, charts.', 'StockAnalysis.com — платформа з даними про понад 130 000 акцій, ETF і фондів світу. Тут є ціни, новини, фінансова звітність за десятиліття, статистика, прогнози аналітиків та інтерактивні графіки. Скринер має сотні фільтрів, а списки спостереження, портфелі й цінові сповіщення допомагають стежити за ринком. Базові дані безкоштовні.', 'StockAnalysis.com is a platform with data on more than 130,000 global stocks, ETFs and funds. It has prices, news, decades of financial statements, statistics, analyst forecasts and interactive charts. The screener has hundreds of filters, and watchlists, portfolios and price alerts help you follow the market. Core data is free.', 'Понад 130 000 акцій і фондів
Фінансова звітність за десятиліття
Скринер із сотнями фільтрів
Списки спостереження й сповіщення', 'Over 130,000 stocks and funds
Decades of financials
Screener with hundreds of filters
Watchlists and alerts', 'Приватні інвестори.', 'Individual investors.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stockanalysis.com' OR LOWER(`name`) = 'stock analysis') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Data on 130,000+ global stocks and funds: decades of financials, a screener, forecasts, charts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'StockAnalysis.com is a platform with data on more than 130,000 global stocks, ETFs and funds. It has prices, news, decades of financial statements, statistics, analyst forecasts and interactive charts. The screener has hundreds of filters, and watchlists, portfolios and price alerts help you follow the market. Core data is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Over 130,000 stocks and funds
Decades of financials
Screener with hundreds of filters
Watchlists and alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individual investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- YCharts — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ycharts.com' OR LOWER(`name`) = 'ycharts')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'YCharts', NULL, 'https://ycharts.com', NULL, NULL, 'Платформа досліджень і пропозицій для фінансових радників з AI-агентом Y.', 'A research and proposal platform for financial advisers with the Y AI agent.', 'YCharts — вебплатформа фінансових досліджень для управителів активами й радників. Вона дозволяє будувати модельні портфелі, аналізувати ризики, готувати пропозиції й матеріали для клієнтів. AI-агент Y знає всі функції платформи: йому можна доручити окремі завдання або цілі проєкти з виконанням за розкладом.', 'YCharts is a web-based financial research platform for asset managers and advisers. It lets you build model portfolios, analyse risk and prepare proposals and client communications. The Y AI agent knows every corner of the platform: you can hand it individual tasks or whole projects, run immediately or on a schedule.', 'Модельні портфелі
Аналіз ризиків
Пропозиції для клієнтів
AI-агент Y', 'Model portfolios
Risk analysis
Client proposals
Y AI agent', 'Фінансові радники й управителі активами.', 'Financial advisers and asset managers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ycharts.com' OR LOWER(`name`) = 'ycharts') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A research and proposal platform for financial advisers with the Y AI agent.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'YCharts is a web-based financial research platform for asset managers and advisers. It lets you build model portfolios, analyse risk and prepare proposals and client communications. The Y AI agent knows every corner of the platform: you can hand it individual tasks or whole projects, run immediately or on a schedule.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Model portfolios
Risk analysis
Client proposals
Y AI agent', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Financial advisers and asset managers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'year', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bloomberg Terminal — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bloomberg.com/professional/products/bloomberg-terminal' OR LOWER(`name`) = 'bloomberg terminal')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bloomberg Terminal', NULL, 'https://www.bloomberg.com/professional/products/bloomberg-terminal/', NULL, NULL, 'Професійний термінал з даними, новинами й аналітикою за всіма класами активів і AI-інтерфейсом ASKB.', 'A professional terminal with data, news and analytics across all asset classes and the ASKB AI interface.', 'Bloomberg Terminal понад чотири десятиліття дає фінансовим професіоналам швидкий доступ до даних у реальному часі, новин, аналітики й торгових інструментів. Він охоплює ринки, галузі, компанії й цінні папери всіх класів активів. Розмовний AI-інтерфейс ASKB допомагає швидше знаходити інформацію в терміналі. Розрахований на професіоналів; ціна — за запитом.', 'For more than four decades the Bloomberg Terminal has given financial professionals fast access to real-time data, news, analytics and trading tools. It covers markets, industries, companies and securities across all asset classes. The ASKB conversational AI interface helps you find information in the terminal faster. It is designed for professionals; price on request.', 'Дані в реальному часі за всіма активами
Новини й аналітика
Торгові інструменти
AI-інтерфейс ASKB', 'Real-time data across all assets
News and analytics
Trading tools
ASKB AI interface', 'Фінансові професіонали та установи.', 'Financial professionals and institutions.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bloomberg.com/professional/products/bloomberg-terminal' OR LOWER(`name`) = 'bloomberg terminal') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A professional terminal with data, news and analytics across all asset classes and the ASKB AI interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'For more than four decades the Bloomberg Terminal has given financial professionals fast access to real-time data, news, analytics and trading tools. It covers markets, industries, companies and securities across all asset classes. The ASKB conversational AI interface helps you find information in the terminal faster. It is designed for professionals; price on request.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time data across all assets
News and analytics
Trading tools
ASKB AI interface', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Financial professionals and institutions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'year', 'Підписка для професіоналів; ціна за запитом.', 'Subscription for professionals; price on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Subscription for professionals; price on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LSEG Workspace — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lseg.com/en/data-analytics/products/workspace' OR LOWER(`name`) = 'lseg workspace')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LSEG Workspace', NULL, 'https://www.lseg.com/en/data-analytics/products/workspace', NULL, NULL, 'Робоче місце фінансового професіонала від LSEG: дані, новини, аналітика й AI з посиланнями на джерела.', 'LSEG''s workspace for financial professionals: data, news, analytics and AI with source citations.', 'LSEG Workspace об''єднує перевірені дані, новини, що рухають ринок, аналітику й AI-можливості в одному середовищі. AI-відповіді спираються на керовані дані LSEG і містять посилання на джерела, тож їх можна перевірити й повторити. Платформа допомагає знаходити можливості, ухвалювати рішення та співпрацювати з колегами.', 'LSEG Workspace brings together trusted data, market-moving news, analytics and AI capabilities in one environment. AI answers are grounded in LSEG''s governed data and include source citations, so they can be checked and repeated. The platform helps you find opportunities, make decisions and collaborate with colleagues.', 'Перевірені ринкові дані
Новини, що рухають ринок
Аналітичні інструменти
AI з посиланнями на джерела', 'Trusted market data
Market-moving news
Analytics tools
AI with source citations', 'Фінансові професіонали.', 'Financial professionals.', 'desktop,web', 'course', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lseg.com/en/data-analytics/products/workspace' OR LOWER(`name`) = 'lseg workspace') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LSEG''s workspace for financial professionals: data, news, analytics and AI with source citations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LSEG Workspace brings together trusted data, market-moving news, analytics and AI capabilities in one environment. AI answers are grounded in LSEG''s governed data and include source citations, so they can be checked and repeated. The platform helps you find opportunities, make decisions and collaborate with colleagues.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Trusted market data
Market-moving news
Analytics tools
AI with source citations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Financial professionals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'year', 'Ціна за запитом.', 'Price on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Price on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Earnings Whispers — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'earningswhispers.com' OR LOWER(`name`) = 'earnings whispers')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Earnings Whispers', NULL, 'https://www.earningswhispers.com', NULL, NULL, 'Календар звітів, «шепітні» очікування прибутку, настрої інвесторів і AI-аналіз конференц-дзвінків.', 'An earnings calendar, whisper numbers, investor sentiment and AI analysis of conference calls.', 'Earnings Whispers публікує власні «шепітні» прогнози прибутку (Earnings Whisper numbers), що відображають реальні очікування ринку, підтверджені дати звітів, настрої інвесторів і новини. Є оцінки акцій перед звітом, AI-аналіз конференц-дзвінків, незвичайна опціонна активність навколо звітів і дослідження ефекту дрейфу після звіту.', 'Earnings Whispers publishes its own Earnings Whisper numbers that reflect the market''s real expectations, confirmed earnings dates, investor sentiment and news. There are pre-earnings grades, AI analysis of conference calls, unusual options activity around earnings and research on post-earnings drift.', 'Календар і підтверджені дати звітів
Earnings Whisper numbers
AI-аналіз конференц-дзвінків
Опціонна активність навколо звітів', 'Calendar and confirmed earnings dates
Earnings Whisper numbers
AI conference call analysis
Options activity around earnings', 'Трейдери, що торгують на звітах.', 'Traders who trade around earnings.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'earningswhispers.com' OR LOWER(`name`) = 'earnings whispers') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An earnings calendar, whisper numbers, investor sentiment and AI analysis of conference calls.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Earnings Whispers publishes its own Earnings Whisper numbers that reflect the market''s real expectations, confirmed earnings dates, investor sentiment and news. There are pre-earnings grades, AI analysis of conference calls, unusual options activity around earnings and research on post-earnings drift.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Calendar and confirmed earnings dates
Earnings Whisper numbers
AI conference call analysis
Options activity around earnings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders who trade around earnings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TIKR — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tikr.com' OR LOWER(`name`) = 'tikr')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TIKR', NULL, 'https://www.tikr.com', NULL, NULL, 'Дані про 100 000+ акцій світу: скринер, фінанси за 30 років, стенограми, оцінка, портфелі відомих інвесторів.', 'Data on 100,000+ global stocks: a screener, 30 years of financials, transcripts, valuation and famous investors'' portfolios.', 'TIKR допомагає аналізувати бізнеси по всьому світу. Скринер охоплює понад 100 000 акцій, фінансова звітність доступна до 30 років назад, є стенограми звітів і інструмент для побудови моделі оцінки. Можна стежити за портфелями відомих інвесторів — не лише за звітами 13F у США, а й за розкриттями в Європі, Азії, Австралії. Старт безкоштовний, без картки.', 'TIKR helps you analyse businesses worldwide. Its screener covers more than 100,000 stocks, financials go back up to 30 years, and there are earnings transcripts and a valuation model builder. You can follow well-known investors'' portfolios, not just US 13F filings but disclosures in Europe, Asia and Australia. Getting started is free, no card needed.', 'Скринер 100 000+ акцій
Фінанси до 30 років
Стенограми звітів
Модель оцінки
Портфелі відомих інвесторів', 'Screener for 100,000+ stocks
Up to 30 years of financials
Earnings transcripts
Valuation model
Famous investors'' portfolios', 'Довгострокові інвестори в акції світу.', 'Long-term investors in global stocks.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tikr.com' OR LOWER(`name`) = 'tikr') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Data on 100,000+ global stocks: a screener, 30 years of financials, transcripts, valuation and famous investors'' portfolios.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TIKR helps you analyse businesses worldwide. Its screener covers more than 100,000 stocks, financials go back up to 30 years, and there are earnings transcripts and a valuation model builder. You can follow well-known investors'' portfolios, not just US 13F filings but disclosures in Europe, Asia and Australia. Getting started is free, no card needed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Screener for 100,000+ stocks
Up to 30 years of financials
Earnings transcripts
Valuation model
Famous investors'' portfolios', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Long-term investors in global stocks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний старт без картки.', 'Free start, no card.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free start, no card.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NinjaTrader — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ninjatrader.com' OR LOWER(`name`) = 'ninjatrader')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NinjaTrader', NULL, 'https://ninjatrader.com', NULL, NULL, 'Ф''ючерсний брокер і торгова платформа з необмеженою симуляцією, графіками й AI-помічником.', 'A futures broker and trading platform with unlimited simulation, charts and an AI helper.', 'NinjaTrader — брокер і платформа для торгівлі ф''ючерсами: індекси, золото, нафта, а також ф''ючерси на окремі акції. Є настільна, веб- і мобільна платформи з графіками, аналізом власної торгівлі та тестуванням стратегій, а безкоштовна необмежена симуляція дозволяє потренуватися без реальних грошей. За даними сайту, внутрішньоденна маржа — від $50, комісія — від $0.09 за контракт. Ф''ючерси — високоризиковий інструмент з кредитним плечем.', 'NinjaTrader is a broker and platform for trading futures: indices, gold, crude oil and single stock futures. There are desktop, web and mobile platforms with charts, trade analysis and strategy testing, and free unlimited simulated trading lets you practise without real money. According to the site, intraday margins start at $50 and commissions at $0.09 per contract. Futures are high-risk leveraged instruments.', 'Торгівля ф''ючерсами
Безкоштовна необмежена симуляція
Тестування стратегій
Десктоп, веб і мобільна платформи', 'Futures trading
Free unlimited simulated trading
Strategy testing
Desktop, web and mobile platforms', 'Ф''ючерсні трейдери, зокрема початківці на симуляторі.', 'Futures traders, including beginners on the simulator.', 'desktop,web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ninjatrader.com' OR LOWER(`name`) = 'ninjatrader') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A futures broker and trading platform with unlimited simulation, charts and an AI helper.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NinjaTrader is a broker and platform for trading futures: indices, gold, crude oil and single stock futures. There are desktop, web and mobile platforms with charts, trade analysis and strategy testing, and free unlimited simulated trading lets you practise without real money. According to the site, intraday margins start at $50 and commissions at $0.09 per contract. Futures are high-risk leveraged instruments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Futures trading
Free unlimited simulated trading
Strategy testing
Desktop, web and mobile platforms', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Futures traders, including beginners on the simulator.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовна необмежена симуляція торгівлі.', 'Free unlimited simulated trading.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free unlimited simulated trading.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Комісія', 'Commission', 0.09, 'one_time', 'Від $0.09 за контракт; внутрішньоденна маржа від $50.', 'From $0.09 per contract; intraday margins from $50.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Комісія' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Commission', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From $0.09 per contract; intraday margins from $50.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TradeStation — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tradestation.com' OR LOWER(`name`) = 'tradestation')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TradeStation', NULL, 'https://www.tradestation.com', NULL, NULL, 'Брокер і платформа для акцій, опціонів і ф''ючерсів з настільною, веб- і мобільною версіями та API.', 'A broker and platform for stocks, options and futures with desktop, web and mobile versions and an API.', 'TradeStation дає доступ до акцій, опціонів, ф''ючерсів, опціонів на ф''ючерси, ETF і взаємних фондів. Платформи: настільна, веб, мобільна й TITAN X, а також симульована торгівля, API для автоматизації, MCP і підключення сторонніх інструментів. Окремо розписано комісії, маржинальні ставки й сервісні збори. Інвестиції та торгівля пов''язані з ризиком втрати коштів.', 'TradeStation offers stocks, options, futures, futures options, ETFs and mutual funds. Platforms include desktop, web, mobile and TITAN X, plus simulated trading, an API for automation, MCP and third-party tool connections. Commissions, margin rates and service fees are listed separately. Investing and trading involve the risk of losing money.', 'Акції, опціони, ф''ючерси
Настільна, веб і мобільна платформи
Симульована торгівля
API та MCP', 'Stocks, options, futures
Desktop, web and mobile platforms
Simulated trading
API and MCP', 'Активні трейдери й алготрейдери.', 'Active traders and algo traders.', 'desktop,web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tradestation.com' OR LOWER(`name`) = 'tradestation') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A broker and platform for stocks, options and futures with desktop, web and mobile versions and an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TradeStation offers stocks, options, futures, futures options, ETFs and mutual funds. Platforms include desktop, web, mobile and TITAN X, plus simulated trading, an API for automation, MCP and third-party tool connections. Commissions, margin rates and service fees are listed separately. Investing and trading involve the risk of losing money.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stocks, options, futures
Desktop, web and mobile platforms
Simulated trading
API and MCP', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Active traders and algo traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- thinkorswim — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'schwab.com/trading/thinkorswim' OR LOWER(`name`) = 'thinkorswim')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'thinkorswim', NULL, 'https://www.schwab.com/trading/thinkorswim', NULL, NULL, 'Торгова платформа Charles Schwab з розширеними графіками й аналітикою для акцій, опціонів і ф''ючерсів.', 'Charles Schwab''s trading platform with advanced charts and analytics for stocks, options and futures.', 'thinkorswim — набір торгових платформ Charles Schwab: настільна, веб і мобільний застосунок, що переносить багато можливостей десктопу в телефон. Платформа має розширені графіки й аналітику та дозволяє реалізувати майже будь-яку торгову ідею. Доступна клієнтам Schwab; онлайн-угоди з акціями — без комісії. Інвестиції та торгівля пов''язані з ризиком втрати коштів.', 'thinkorswim is Charles Schwab''s suite of trading platforms: desktop, web and a mobile app that brings many desktop features to your phone. It has robust charting and analysis and lets you act on nearly any trade idea. Available to Schwab clients; online equity trades are commission-free. Investing and trading involve the risk of losing money.', 'Розширені графіки й аналітика
Акції, опціони, ф''ючерси
Десктоп, веб і мобільний застосунок
Без комісії за онлайн-угоди з акціями', 'Advanced charts and analytics
Stocks, options, futures
Desktop, web and mobile app
$0 online equity commissions', 'Активні трейдери — клієнти Schwab.', 'Active traders who are Schwab clients.', 'desktop,web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'schwab.com/trading/thinkorswim' OR LOWER(`name`) = 'thinkorswim') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Charles Schwab''s trading platform with advanced charts and analytics for stocks, options and futures.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'thinkorswim is Charles Schwab''s suite of trading platforms: desktop, web and a mobile app that brings many desktop features to your phone. It has robust charting and analysis and lets you act on nearly any trade idea. Available to Schwab clients; online equity trades are commission-free. Investing and trading involve the risk of losing money.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Advanced charts and analytics
Stocks, options, futures
Desktop, web and mobile app
$0 online equity commissions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Active traders who are Schwab clients.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Платформа безкоштовна для клієнтів Schwab; онлайн-угоди з акціями $0.', 'The platform is free for Schwab clients; $0 online equity trades.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The platform is free for Schwab clients; $0 online equity trades.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MetaTrader 5 — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'metatrader5.com' OR LOWER(`name`) = 'metatrader 5')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MetaTrader 5', NULL, 'https://www.metatrader5.com', NULL, NULL, 'Безкоштовна платформа для технічного аналізу й торгівлі на Форекс та біржових ринках з торговими роботами.', 'A free platform for technical analysis and trading in forex and exchange markets, with trading robots.', 'MetaTrader 5 від MetaQuotes — безкоштовна платформа для технічного аналізу й торгових операцій на Форекс та біржових ринках. Вона підтримує торгових роботів і індикатори, сигнали й копіювання угод, а в маркеті можна замовити роботів або застосунки в розробників. Платформу надають брокери, тож умови торгівлі залежать від обраного брокера. Інвестиції та торгівля пов''язані з ризиком втрати коштів.', 'MetaTrader 5 by MetaQuotes is a free platform for technical analysis and trading in forex and exchange markets. It supports trading robots and indicators, signals and copy trading, and its market lets you order robots or apps from developers. The platform is provided by brokers, so trading conditions depend on the broker you choose. Investing and trading involve the risk of losing money.', 'Технічний аналіз і графіки
Торгові роботи й індикатори
Сигнали й копіювання угод
Маркет роботів і застосунків', 'Technical analysis and charts
Trading robots and indicators
Signals and copy trading
Market for robots and apps', 'Трейдери Форекс і біржових ринків.', 'Forex and exchange market traders.', 'desktop,web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'metatrader5.com' OR LOWER(`name`) = 'metatrader 5') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free platform for technical analysis and trading in forex and exchange markets, with trading robots.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MetaTrader 5 by MetaQuotes is a free platform for technical analysis and trading in forex and exchange markets. It supports trading robots and indicators, signals and copy trading, and its market lets you order robots or apps from developers. The platform is provided by brokers, so trading conditions depend on the broker you choose. Investing and trading involve the risk of losing money.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Technical analysis and charts
Trading robots and indicators
Signals and copy trading
Market for robots and apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Forex and exchange market traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Платформа безкоштовна; умови торгівлі встановлює брокер.', 'The platform is free; trading conditions are set by the broker.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The platform is free; trading conditions are set by the broker.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- cTrader — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ctrader.com' OR LOWER(`name`) = 'ctrader')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'cTrader', NULL, 'https://ctrader.com', NULL, NULL, 'Торгова платформа для Форекс і CFD з магазином алгоритмів cTrader Store.', 'A forex and CFD trading platform with the cTrader Store for algorithms.', 'cTrader — платформа для торгівлі на Форекс і CFD, яку пропонують брокери. У cTrader Store можна купувати й продавати торгових роботів (cBots), індикатори та інструменти для ручної торгівлі на десктопі й мобільних. Результати роботів на бектесті не гарантують майбутніх результатів, а CFD — складний інструмент з високим ризиком втрат через кредитне плече.', 'cTrader is a platform for forex and CFD trading offered by brokers. In the cTrader Store you can buy and sell trading robots (cBots), indicators and tools for manual trading on desktop and mobile. Robots'' backtest results do not guarantee future results, and CFDs are complex instruments with a high risk of loss due to leverage.', 'Торгівля Форекс і CFD
Магазин алгоритмів cTrader Store
Торгові роботи cBots
Десктоп і мобільні', 'Forex and CFD trading
cTrader Store for algorithms
cBots trading robots
Desktop and mobile', 'Трейдери Форекс, алготрейдери.', 'Forex traders and algo traders.', 'desktop,web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ctrader.com' OR LOWER(`name`) = 'ctrader') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A forex and CFD trading platform with the cTrader Store for algorithms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'cTrader is a platform for forex and CFD trading offered by brokers. In the cTrader Store you can buy and sell trading robots (cBots), indicators and tools for manual trading on desktop and mobile. Robots'' backtest results do not guarantee future results, and CFDs are complex instruments with a high risk of loss due to leverage.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Forex and CFD trading
cTrader Store for algorithms
cBots trading robots
Desktop and mobile', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Forex traders and algo traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Платформа безкоштовна через брокера; алгоритми в Store — за ціною продавця.', 'The platform is free via brokers; Store algorithms are priced by sellers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The platform is free via brokers; Store algorithms are priced by sellers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AmiBroker — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'amibroker.com' OR LOWER(`name`) = 'amibroker')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AmiBroker', NULL, 'https://www.amibroker.com', NULL, NULL, 'Програма для технічного аналізу й портфельного бектесту з оптимізацією, Монте-Карло й walk-forward.', 'Technical analysis and portfolio backtesting software with optimisation, Monte Carlo and walk-forward.', 'AmiBroker допомагає задати об''єктивні правила входу й виходу та прибрати емоції з торгівлі. Програма робить бектест і оптимізацію на рівні портфеля, перевіряє стійкість стратегій методами walk-forward і Монте-Карло, має швидкі графіки, власні метрики й підтримку кількох валют. Торгувати можна з графіків, зі списку ордерів або напряму з коду через інтерфейс автоторгівлі.', 'AmiBroker helps you define objective entry and exit rules and take emotion out of trading. It runs portfolio-level backtests and optimisation, validates robustness with walk-forward and Monte Carlo, and offers fast charts, custom metrics and multi-currency support. You can trade from charts, from an order list or directly from code via the auto-trading interface.', 'Портфельний бектест і оптимізація
Walk-forward і Монте-Карло
Швидкі графіки
Автоторгівля з коду', 'Portfolio backtesting and optimisation
Walk-forward and Monte Carlo
Fast charts
Auto-trading from code', 'Системні трейдери, що пишуть власні стратегії.', 'Systematic traders who write their own strategies.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'amibroker.com' OR LOWER(`name`) = 'amibroker') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Technical analysis and portfolio backtesting software with optimisation, Monte Carlo and walk-forward.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AmiBroker helps you define objective entry and exit rules and take emotion out of trading. It runs portfolio-level backtests and optimisation, validates robustness with walk-forward and Monte Carlo, and offers fast charts, custom metrics and multi-currency support. You can trade from charts, from an order list or directly from code via the auto-trading interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Portfolio backtesting and optimisation
Walk-forward and Monte Carlo
Fast charts
Auto-trading from code', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Systematic traders who write their own strategies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ліцензія', 'License', NULL, 'one_time', 'Разова ліцензія; ціни редакцій — на сайті.', 'One-time license; edition prices are on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ліцензія' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'License', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'One-time license; edition prices are on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sierra Chart — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sierrachart.com' OR LOWER(`name`) = 'sierra chart')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sierra Chart', NULL, 'https://www.sierrachart.com', NULL, NULL, 'Професійна настільна платформа для графіків і торгівлі: ручна, автоматична й симульована торгівля.', 'A professional desktop charting and trading platform: manual, automated and simulated trading.', 'Sierra Chart — професійна настільна платформа для графіків і торгівлі на фінансових ринках. Вона підтримує живу й симульовану торгівлю, ручну й автоматизовану, має потужний технічний аналіз з даними в реальному часі та історією й підключається до різних бірж і торгових сервісів. Є безкоштовний пробний період і документація для розробників.', 'Sierra Chart is a professional desktop charting and trading platform for financial markets. It supports live and simulated trading, manual and automated, offers powerful technical analysis with real-time and historical data and connects to various exchanges and trading services. There is a free trial and developer documentation.', 'Жива й симульована торгівля
Автоматизована торгівля
Технічний аналіз у реальному часі
Підключення до бірж', 'Live and simulated trading
Automated trading
Real-time technical analysis
Exchange connectivity', 'Професійні трейдери ф''ючерсами.', 'Professional futures traders.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sierrachart.com' OR LOWER(`name`) = 'sierra chart') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A professional desktop charting and trading platform: manual, automated and simulated trading.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sierra Chart is a professional desktop charting and trading platform for financial markets. It supports live and simulated trading, manual and automated, offers powerful technical analysis with real-time and historical data and connects to various exchanges and trading services. There is a free trial and developer documentation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live and simulated trading
Automated trading
Real-time technical analysis
Exchange connectivity', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professional futures traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'month', 'Є безкоштовний пробний період; ціни пакетів — на сайті.', 'Free trial available; package prices are on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free trial available; package prices are on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Quantower — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'quantower.com' OR LOWER(`name`) = 'quantower')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Quantower', NULL, 'https://www.quantower.com', NULL, NULL, 'Мультиактивна платформа з понад 40 панелями для ф''ючерсів, акцій, опціонів, CFD і криптобірж.', 'A multi-asset platform with 40+ panels for futures, stocks, options, CFDs and crypto exchanges.', 'Quantower — торгова платформа, що підключається до багатьох брокерів і бірж одночасно. Понад 40 торгових і аналітичних панелей можна розмістити на будь-якому екрані: графіки, об''ємний аналіз, стакани, опціонна аналітика. Підтримує ф''ючерси, акції, опціони, CFD і криптобіржі. Почати можна безкоштовно.', 'Quantower is a trading platform that connects to many brokers and exchanges at once. More than 40 trading and analytical panels can be placed on any screen: charts, volume analysis, DOM and options analytics. It supports futures, stocks, options, CFDs and crypto exchanges. You can start for free.', 'Понад 40 панелей
Підключення до багатьох брокерів
Об''ємний аналіз
Ф''ючерси, акції, опціони, крипто', '40+ panels
Connections to many brokers
Volume analysis
Futures, stocks, options, crypto', 'Активні трейдери на різних ринках.', 'Active traders across markets.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'quantower.com' OR LOWER(`name`) = 'quantower') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A multi-asset platform with 40+ panels for futures, stocks, options, CFDs and crypto exchanges.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Quantower is a trading platform that connects to many brokers and exchanges at once. More than 40 trading and analytical panels can be placed on any screen: charts, volume analysis, DOM and options analytics. It supports futures, stocks, options, CFDs and crypto exchanges. You can start for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '40+ panels
Connections to many brokers
Volume analysis
Futures, stocks, options, crypto', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Active traders across markets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний старт.', 'Free to start.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to start.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ATAS — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'atas.net' OR LOWER(`name`) = 'atas')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ATAS', NULL, 'https://atas.net', NULL, NULL, 'Аналіз ордер-флоу й об''ємів: кластерні графіки footprint для ф''ючерсів, акцій і крипто.', 'Order flow and volume analysis: footprint cluster charts for futures, stocks and crypto.', 'ATAS — програма для професійного об''ємного аналізу. Кластерні графіки (footprint) показують, що відбувається всередині кожної свічки: дисбаланси, агресивних покупців і продавців, рівні з найбільшою активністю. Платформа підключається до бірж акцій, ф''ючерсів і криптовалют і дозволяє надсилати ордери. Є безкоштовний 14-денний пробний період.', 'ATAS is software for professional volume analysis. Footprint cluster charts show what happens inside each bar: imbalances, aggressive buyers and sellers and levels with the most activity. The platform connects to stock, futures and crypto exchanges and lets you send orders. A free 14-day trial is available.', 'Кластерні графіки footprint
Аналіз ордер-флоу
Акції, ф''ючерси, крипто
14 днів безкоштовно', 'Footprint cluster charts
Order flow analysis
Stocks, futures, crypto
14-day free trial', 'Трейдери, що аналізують об''єми.', 'Traders who analyse volume.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'atas.net' OR LOWER(`name`) = 'atas') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Order flow and volume analysis: footprint cluster charts for futures, stocks and crypto.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ATAS is software for professional volume analysis. Footprint cluster charts show what happens inside each bar: imbalances, aggressive buyers and sellers and levels with the most activity. The platform connects to stock, futures and crypto exchanges and lets you send orders. A free 14-day trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Footprint cluster charts
Order flow analysis
Stocks, futures, crypto
14-day free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders who analyse volume.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'month', '14 днів безкоштовно; ціни на сайті.', '14-day free trial; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '14-day free trial; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bookmap — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bookmap.com' OR LOWER(`name`) = 'bookmap')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bookmap', NULL, 'https://bookmap.com', NULL, NULL, 'Візуалізація ліквідності й книги ордерів у реальному часі у вигляді теплової карти.', 'Real-time visualisation of liquidity and the order book as a heat map.', 'Bookmap показує книгу ордерів і ліквідність як теплову карту, щоб було видно, яким ціновим рівням довіряє ринок і як змінюється настрій. Це допомагає побачити те, що приховують звичайні свічки, і швидше реагувати на зміни. Платформа підходить для ф''ючерсів, акцій і криптовалют; почати можна безкоштовно.', 'Bookmap shows the order book and liquidity as a heat map, revealing which price levels the market trusts and how sentiment shifts. It helps you see what candlesticks hide and react faster to changes. The platform suits futures, stocks and crypto; you can start for free.', 'Теплова карта ліквідності
Книга ордерів у реальному часі
Аналіз ринкових настроїв
Ф''ючерси, акції, крипто', 'Liquidity heat map
Real-time order book
Market sentiment analysis
Futures, stocks, crypto', 'Скальпери й денні трейдери.', 'Scalpers and day traders.', 'desktop,web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bookmap.com' OR LOWER(`name`) = 'bookmap') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Real-time visualisation of liquidity and the order book as a heat map.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bookmap shows the order book and liquidity as a heat map, revealing which price levels the market trusts and how sentiment shifts. It helps you see what candlesticks hide and react faster to changes. The platform suits futures, stocks and crypto; you can start for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Liquidity heat map
Real-time order book
Market sentiment analysis
Futures, stocks, crypto', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Scalpers and day traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний старт.', 'Free to start.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to start.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MotiveWave — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'motivewave.com' OR LOWER(`name`) = 'motivewave')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MotiveWave', NULL, 'https://www.motivewave.com', NULL, NULL, 'Торгова платформа з профілем обсягу, TPO-графіками й автоматичною розміткою хвиль Еліотта.', 'A trading platform with volume profile, TPO charts and automatic Elliott Wave counts.', 'MotiveWave — платформа для графіків, аналізу й торгівлі з повністю налаштовуваними макетами. Вона має профіль обсягу, TPO-графіки для зон вартості, інструменти для ручної розмітки хвиль Еліотта та автоматичний підрахунок хвиль. Є 14-денний безкоштовний пробний період без картки.', 'MotiveWave is a charting, analysis and trading platform with fully customisable layouts. It offers volume profile, TPO charts for value areas, tools for manual Elliott Wave plotting and automatic wave counts. A 14-day free trial is available with no card required.', 'Профіль обсягу й TPO
Хвилі Еліотта: ручна й автоматична розмітка
Налаштовувані макети
14 днів безкоштовно', 'Volume profile and TPO
Elliott Wave: manual and automatic
Customisable layouts
14-day free trial', 'Трейдери, що використовують хвильовий і об''ємний аналіз.', 'Traders who use wave and volume analysis.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'motivewave.com' OR LOWER(`name`) = 'motivewave') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A trading platform with volume profile, TPO charts and automatic Elliott Wave counts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MotiveWave is a charting, analysis and trading platform with fully customisable layouts. It offers volume profile, TPO charts for value areas, tools for manual Elliott Wave plotting and automatic wave counts. A 14-day free trial is available with no card required.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Volume profile and TPO
Elliott Wave: manual and automatic
Customisable layouts
14-day free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders who use wave and volume analysis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ліцензія', 'License', NULL, 'one_time', '14 днів безкоштовно; ціни редакцій — на сайті.', '14-day free trial; edition prices are on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ліцензія' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'License', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '14-day free trial; edition prices are on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- WealthLab — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wealth-lab.com' OR LOWER(`name`) = 'wealthlab')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'WealthLab', NULL, 'https://www.wealth-lab.com', NULL, NULL, 'Портфельний бектест з реальною зміною складу індексів, walk-forward і генерацією стратегій з AI.', 'Portfolio backtesting with real index constituent changes, walk-forward and AI strategy generation.', 'WealthLab — платформа для портфельного бектесту, яка враховує реальні зміни складу індексів і усуває помилку виживання, а також перевіряє стратегії методом walk-forward. У WealthLab 9 можна описати ідею звичайною мовою, протестувати її й доопрацювати разом з Claude. Обмежень на обсяг історії немає — тестувати можна на всіх доступних даних.', 'WealthLab is a portfolio backtesting platform that uses real index constituent changes, eliminates survivorship bias and validates strategies with walk-forward testing. In WealthLab 9 you can describe an idea in plain English, backtest it and refine it with Claude. There is no data cap: you can test as far back as the data allows.', 'Портфельний бектест
Реальна зміна складу індексів
Walk-forward
Генерація стратегій з AI', 'Portfolio backtesting
Real index constituent changes
Walk-forward
AI strategy generation', 'Системні трейдери.', 'Systematic traders.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wealth-lab.com' OR LOWER(`name`) = 'wealthlab') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Portfolio backtesting with real index constituent changes, walk-forward and AI strategy generation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'WealthLab is a portfolio backtesting platform that uses real index constituent changes, eliminates survivorship bias and validates strategies with walk-forward testing. In WealthLab 9 you can describe an idea in plain English, backtest it and refine it with Claude. There is no data cap: you can test as far back as the data allows.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Portfolio backtesting
Real index constituent changes
Walk-forward
AI strategy generation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Systematic traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- QuantConnect — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'quantconnect.com' OR LOWER(`name`) = 'quantconnect')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'QuantConnect', NULL, 'https://www.quantconnect.com', NULL, NULL, 'Відкрита платформа для алготрейдингу: дослідження, бектест і жива торгівля мультиактивними стратегіями з AI-агентами.', 'An open-source algorithmic trading platform: research, backtest and live-trade multi-asset strategies with AI agents.', 'QuantConnect дозволяє досліджувати, тестувати, оптимізувати й запускати в живу торгівлю кількісні стратегії на акціях, опціонах, ф''ючерсах, валютах і крипто. Усе проходить одним конвеєром: від ідеї й дослідження до бектесту, паперової й живої торгівлі, а на кожному етапі допомагає спеціалізований AI-асистент. Платформа побудована на відкритому рушії LEAN; за даними сайту, нею користуються понад 550 000 квантів.', 'QuantConnect lets you research, backtest, optimise and live-trade quantitative strategies on stocks, options, futures, forex and crypto. Everything moves through one pipeline, from idea and research to backtesting, paper and live trading, with a specialist AI assistant at each stage. The platform is built on the open-source LEAN engine; according to the site, more than 550,000 quants use it.', 'Бектест мультиактивних стратегій
Паперова й жива торгівля
AI-асистенти на кожному етапі
Відкритий рушій LEAN', 'Multi-asset backtesting
Paper and live trading
AI assistants at each stage
Open-source LEAN engine', 'Кванти й розробники торгових алгоритмів.', 'Quants and trading algorithm developers.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'quantconnect.com' OR LOWER(`name`) = 'quantconnect') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source algorithmic trading platform: research, backtest and live-trade multi-asset strategies with AI agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'QuantConnect lets you research, backtest, optimise and live-trade quantitative strategies on stocks, options, futures, forex and crypto. Everything moves through one pipeline, from idea and research to backtesting, paper and live trading, with a specialist AI assistant at each stage. The platform is built on the open-source LEAN engine; according to the site, more than 550,000 quants use it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Multi-asset backtesting
Paper and live trading
AI assistants at each stage
Open-source LEAN engine', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Quants and trading algorithm developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Alpaca — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'alpaca.markets' OR LOWER(`name`) = 'alpaca')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Alpaca', NULL, 'https://alpaca.markets', NULL, NULL, 'API для торгівлі акціями, опціонами й криптовалютами, ринкові дані та MCP-сервер для торгівлі через AI.', 'An API for trading stocks, options and crypto, market data and an MCP server for trading via AI.', 'Alpaca — брокерський API для розробників і бізнесу: торгові алгоритми, власні застосунки й вбудовування інвестицій у свої сервіси. Є ринкові дані в реальному часі для акцій і криптовалют, платформа з графіками й торгівлею та MCP-сервер, що дозволяє торгувати природною мовою через AI-асистента. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Alpaca is a brokerage API for developers and businesses: trading algorithms, custom apps and embedding investing into your own services. It offers real-time stock and crypto market data, a charting and trading platform and an MCP server that lets you trade in natural language through an AI assistant. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'API для акцій, опціонів і крипто
Ринкові дані в реальному часі
MCP-сервер для торгівлі через AI
Вбудовування інвестицій у застосунки', 'API for stocks, options and crypto
Real-time market data
MCP server for AI trading
Embedded investing for apps', 'Розробники, алготрейдери й фінтех-компанії.', 'Developers, algo traders and fintech companies.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'alpaca.markets' OR LOWER(`name`) = 'alpaca') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An API for trading stocks, options and crypto, market data and an MCP server for trading via AI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Alpaca is a brokerage API for developers and businesses: trading algorithms, custom apps and embedding investing into your own services. It offers real-time stock and crypto market data, a charting and trading platform and an MCP server that lets you trade in natural language through an AI assistant. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'API for stocks, options and crypto
Real-time market data
MCP server for AI trading
Embedded investing for apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers, algo traders and fintech companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Доступ до API безкоштовний; тарифи на дані — на сайті.', 'API access is free; data plans are on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'API access is free; data plans are on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Massive (Polygon.io) — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'massive.com' OR LOWER(`name`) = 'massive (polygon.io)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Massive (Polygon.io)', NULL, 'https://massive.com', NULL, NULL, 'API ринкових даних (раніше Polygon.io): ціни в реальному часі й тикова історія через REST і WebSocket.', 'A market data API (formerly Polygon.io): real-time prices and tick history via REST and WebSocket.', 'Massive, раніше відомий як Polygon.io, надає API з даними фондового ринку в реальному часі й історичними тиковими даними. Доступ через REST або WebSocket, формати JSON і CSV, клієнтські бібліотеки, туторіали й приклади. Є безкоштовний рівень із миттєвим доступом після створення ключа.', 'Massive, formerly known as Polygon.io, provides an API with real-time and historical tick-level stock market data. Access is via REST or WebSockets in JSON and CSV formats, with client libraries, tutorials and examples. There is a free tier with instant access after creating a key.', 'Дані в реальному часі й історія
REST і WebSocket
JSON і CSV
Клієнтські бібліотеки', 'Real-time and historical data
REST and WebSockets
JSON and CSV
Client libraries', 'Розробники торгових застосунків і алготрейдери.', 'Trading app developers and algo traders.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'massive.com' OR LOWER(`name`) = 'massive (polygon.io)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A market data API (formerly Polygon.io): real-time prices and tick history via REST and WebSocket.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Massive, formerly known as Polygon.io, provides an API with real-time and historical tick-level stock market data. Access is via REST or WebSockets in JSON and CSV formats, with client libraries, tutorials and examples. There is a free tier with instant access after creating a key.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time and historical data
REST and WebSockets
JSON and CSV
Client libraries', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Trading app developers and algo traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень API.', 'Free API tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free API tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Streak — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streak.tech' OR LOWER(`name`) = 'streak')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Streak', NULL, 'https://www.streak.tech', NULL, NULL, 'Платформа системної торгівлі: сканери ринку в реальному часі, стратегії для акцій і опціонів без коду.', 'A systematic trading platform: real-time market scanners and stock and options strategies without code.', 'Streak допомагає торгувати системно. Сканери ринку в реальному часі надсилають сповіщення й показують тенденції в секторах, а стратегії для акцій і опціонів можна створювати з готової логіки, допоміжних умов або повністю власних правил і запускати на бектест та в торгівлю. Платформа працює переважно з індійськими брокерами.', 'Streak helps you trade systematically. Real-time market scanners trigger alerts and highlight trends across sectors, and stock and options strategies can be built from pre-built logic, assisted conditions or fully custom rules, then backtested and deployed. The platform works mainly with Indian brokers.', 'Сканери ринку в реальному часі
Стратегії для акцій і опціонів
Без програмування
Бектест', 'Real-time market scanners
Stock and options strategies
No coding
Backtesting', 'Трейдери на ринку Індії.', 'Traders in the Indian market.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streak.tech' OR LOWER(`name`) = 'streak') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A systematic trading platform: real-time market scanners and stock and options strategies without code.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Streak helps you trade systematically. Real-time market scanners trigger alerts and highlight trends across sectors, and stock and options strategies can be built from pre-built logic, assisted conditions or fully custom rules, then backtested and deployed. The platform works mainly with Indian brokers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time market scanners
Stock and options strategies
No coding
Backtesting', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders in the Indian market.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовна платформа системної торгівлі.', 'A free systematic trading platform.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free systematic trading platform.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TradersPost — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'traderspost.io' OR LOWER(`name`) = 'traderspost')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TradersPost', NULL, 'https://traderspost.io', NULL, NULL, 'Автоматизація торгівлі: сповіщення з TradingView чи інших джерел перетворюються на ордери у вашого брокера.', 'Trading automation: alerts from TradingView or other sources become orders at your broker.', 'TradersPost передає сигнали індикаторів, стратегій і ботів прямо брокеру. Сповіщення з TradingView, тисяч застосунків через no-code інтеграції чи IFTTT можна перетворити на ордери для акцій, опціонів, ф''ючерсів і криптовалют на рахунках, якими ви керуєте. Підходить для системної, дискреційної, свінг-торгівлі чи ребалансування кошика. Автоматизація не прибирає ризику втрат.', 'TradersPost sends signals from indicators, strategies and bots straight to your broker. Alerts from TradingView, thousands of apps via no-code integrations or IFTTT can become orders for stocks, options, futures and crypto in accounts you control. It suits systematic, discretionary, swing or basket rebalancing approaches. Automation does not remove the risk of loss.', 'Сповіщення → ордери у брокера
Інтеграція з TradingView
Акції, опціони, ф''ючерси, крипто
No-code та IFTTT', 'Alerts to broker orders
TradingView integration
Stocks, options, futures, crypto
No-code and IFTTT', 'Трейдери, що автоматизують свої сигнали.', 'Traders automating their signals.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'traderspost.io' OR LOWER(`name`) = 'traderspost') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Trading automation: alerts from TradingView or other sources become orders at your broker.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TradersPost sends signals from indicators, strategies and bots straight to your broker. Alerts from TradingView, thousands of apps via no-code integrations or IFTTT can become orders for stocks, options, futures and crypto in accounts you control. It suits systematic, discretionary, swing or basket rebalancing approaches. Automation does not remove the risk of loss.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Alerts to broker orders
TradingView integration
Stocks, options, futures, crypto
No-code and IFTTT', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders automating their signals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NautilusTrader — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nautilustrader.io' OR LOWER(`name`) = 'nautilustrader')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NautilusTrader', NULL, 'https://nautilustrader.io', NULL, NULL, 'Відкрита платформа алготрейдингу з ядром на Rust, API стратегій на Python і детермінованим бектестом.', 'An open-source algorithmic trading platform with a Rust core, a Python strategy API and deterministic backtesting.', 'NautilusTrader — відкрита платформа для алготрейдингу. Ядро написане на Rust, стратегії — на Python. Подієві симуляції з наносекундною точністю мають налаштовувані моделі виконання, комісій, затримок і книги ордерів, а однакова логіка стратегії працює і в бектесті, і в живій торгівлі. Можна завантажувати власні дані в каталог Parquet і запускати великі серії тестів.', 'NautilusTrader is an open-source algorithmic trading platform. Its core is written in Rust and strategies in Python. Event-driven simulations with nanosecond resolution have configurable fill, fee, latency and order book models, and the same strategy logic runs in backtests and live trading. You can load your own data into a Parquet catalog and run large test sweeps.', 'Ядро на Rust, стратегії на Python
Детермінований бектест
Однакова логіка в бектесті й живій торгівлі
Відкритий код', 'Rust core, Python strategies
Deterministic backtesting
Same logic in backtest and live
Open source', 'Розробники й кванти.', 'Developers and quants.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nautilustrader.io' OR LOWER(`name`) = 'nautilustrader') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source algorithmic trading platform with a Rust core, a Python strategy API and deterministic backtesting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NautilusTrader is an open-source algorithmic trading platform. Its core is written in Rust and strategies in Python. Event-driven simulations with nanosecond resolution have configurable fill, fee, latency and order book models, and the same strategy logic runs in backtests and live trading. You can load your own data into a Parquet catalog and run large test sweeps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rust core, Python strategies
Deterministic backtesting
Same logic in backtest and live
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and quants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Відкритий код, безкоштовно.', 'Open source, free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source, free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Freqtrade — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freqtrade.io' OR LOWER(`name`) = 'freqtrade')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Freqtrade', NULL, 'https://www.freqtrade.io', NULL, NULL, 'Безкоштовний бот з відкритим кодом на Python для торгівлі криптовалютами з бектестом і оптимізацією.', 'A free open-source Python crypto trading bot with backtesting and optimisation.', 'Freqtrade — безкоштовний бот з відкритим кодом для торгівлі криптовалютами, написаний на Python. Він підтримує основні біржі, керується через Telegram або веб-інтерфейс, завантажує історичні дані, робить бектест, будує графіки, керує капіталом і оптимізує стратегії за допомогою машинного навчання. Потребує технічних навичок для налаштування. Торгівля криптовалютами дуже ризикована.', 'Freqtrade is a free open-source crypto trading bot written in Python. It supports major exchanges, is controlled via Telegram or a web UI, downloads historical data, backtests, plots, manages money and optimises strategies with machine learning. It requires technical skills to set up. Crypto trading is very risky.', 'Відкритий код на Python
Бектест і оптимізація
Керування через Telegram або веб
Підтримка основних бірж', 'Open-source Python
Backtesting and optimisation
Control via Telegram or web
Major exchange support', 'Розробники й технічні криптотрейдери.', 'Developers and technical crypto traders.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freqtrade.io' OR LOWER(`name`) = 'freqtrade') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free open-source Python crypto trading bot with backtesting and optimisation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Freqtrade is a free open-source crypto trading bot written in Python. It supports major exchanges, is controlled via Telegram or a web UI, downloads historical data, backtests, plots, manages money and optimises strategies with machine learning. It requires technical skills to set up. Crypto trading is very risky.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Open-source Python
Backtesting and optimisation
Control via Telegram or web
Major exchange support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and technical crypto traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Відкритий код, безкоштовно.', 'Open source, free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source, free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Interactive Brokers — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interactivebrokers.com' OR LOWER(`name`) = 'interactive brokers')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Interactive Brokers', NULL, 'https://www.interactivebrokers.com', NULL, NULL, 'Брокер із прямим доступом до світових ринків: акції, опціони, ф''ючерси, валюти, облігації, фонди.', 'A broker with direct access to global markets: stocks, options, futures, currencies, bonds and funds.', 'Interactive Brokers дає трейдерам, інвесторам і радникам прямий доступ до акцій, опціонів, ф''ючерсів, валют, облігацій і фондів на світових ринках. Є фіксовані, багаторівневі й нульові комісії: з планом IBKR Lite угоди з акціями та ETF США — без комісії. Сканери ринку, складні стратегії й симульована торгівля, щоб спробувати платформу без ризику. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Interactive Brokers gives traders, investors and advisers direct access to stocks, options, futures, currencies, bonds and funds in global markets. There are fixed, tiered and $0 commissions: with IBKR Lite, US stocks and ETFs trade commission-free. Market scanners, complex strategies and simulated trading let you try the platform risk-free. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Доступ до світових ринків
Акції, опціони, ф''ючерси, облігації
IBKR Lite без комісії на акції США
Симульована торгівля
Сканери ринку', 'Global market access
Stocks, options, futures, bonds
IBKR Lite: $0 on US stocks
Simulated trading
Market scanners', 'Активні трейдери й інвестори, зокрема з-поза США.', 'Active traders and investors, including outside the US.', 'desktop,web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interactivebrokers.com' OR LOWER(`name`) = 'interactive brokers') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A broker with direct access to global markets: stocks, options, futures, currencies, bonds and funds.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Interactive Brokers gives traders, investors and advisers direct access to stocks, options, futures, currencies, bonds and funds in global markets. There are fixed, tiered and $0 commissions: with IBKR Lite, US stocks and ETFs trade commission-free. Market scanners, complex strategies and simulated trading let you try the platform risk-free. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Global market access
Stocks, options, futures, bonds
IBKR Lite: $0 on US stocks
Simulated trading
Market scanners', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Active traders and investors, including outside the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; IBKR Lite — $0 комісії на акції й ETF США, інші тарифи — на сайті.', 'Opening an account is free; IBKR Lite has $0 commissions on US stocks and ETFs; other pricing on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; IBKR Lite has $0 commissions on US stocks and ETFs; other pricing on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Charles Schwab — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'schwab.com' OR LOWER(`name`) = 'charles schwab')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Charles Schwab', NULL, 'https://www.schwab.com', NULL, NULL, 'Американський брокер: акції, ETF, опціони, облігації, пенсійні рахунки, онлайн-угоди з акціями без комісії.', 'A US broker: stocks, ETFs, options, bonds, retirement accounts and $0 online equity trades.', 'Charles Schwab пропонує брокерські й пенсійні рахунки (Roth і Traditional IRA) для інвестування в акції, ETF, опціони й облігації. Онлайн-угоди з акціями — без комісії, діє гарантія задоволення. Для активних трейдерів є платформа thinkorswim, для інших — фінансове планування й поради. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Charles Schwab offers brokerage and retirement accounts (Roth and Traditional IRA) for investing in stocks, ETFs, options and bonds. Online equity trades are commission-free, backed by a satisfaction guarantee. Active traders get the thinkorswim platform, others financial planning and advice. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Акції, ETF, опціони, облігації
$0 за онлайн-угоди з акціями
Пенсійні рахунки IRA
Платформа thinkorswim', 'Stocks, ETFs, options, bonds
$0 online equity trades
IRA retirement accounts
thinkorswim platform', 'Інвестори в США.', 'Investors in the US.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'schwab.com' OR LOWER(`name`) = 'charles schwab') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A US broker: stocks, ETFs, options, bonds, retirement accounts and $0 online equity trades.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Charles Schwab offers brokerage and retirement accounts (Roth and Traditional IRA) for investing in stocks, ETFs, options and bonds. Online equity trades are commission-free, backed by a satisfaction guarantee. Active traders get the thinkorswim platform, others financial planning and advice. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stocks, ETFs, options, bonds
$0 online equity trades
IRA retirement accounts
thinkorswim platform', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Онлайн-угоди з акціями $0; інші тарифи — на сайті.', '$0 online equity trades; other pricing on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$0 online equity trades; other pricing on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fidelity — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fidelity.com' OR LOWER(`name`) = 'fidelity')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fidelity', NULL, 'https://www.fidelity.com', NULL, NULL, 'Американська інвестиційна компанія: торгівля акціями й ETF США без комісії, дробові акції від $1, пенсійні рахунки.', 'A US investment company: commission-free US stocks and ETFs, fractional shares from $1, retirement accounts.', 'Fidelity Investments дозволяє онлайн-торгівлю акціями й ETF США без комісії, а дробові акції можна купувати від $1. Можна інвестувати самостійно або доручити це Fidelity: акції, ETF, криптовалюти та інші інструменти. Є пенсійні рахунки, зокрема Roth IRA, і інструменти пенсійного планування. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Fidelity Investments offers commission-free online trading of US stocks and ETFs, and fractional shares from $1. You can invest on your own or have Fidelity do it: stocks, ETFs, crypto and more. There are retirement accounts, including Roth IRA, and retirement planning tools. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Акції й ETF США без комісії
Дробові акції від $1
Криптовалюти
Пенсійні рахунки', 'Commission-free US stocks and ETFs
Fractional shares from $1
Crypto
Retirement accounts', 'Інвестори в США.', 'Investors in the US.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fidelity.com' OR LOWER(`name`) = 'fidelity') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A US investment company: commission-free US stocks and ETFs, fractional shares from $1, retirement accounts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fidelity Investments offers commission-free online trading of US stocks and ETFs, and fractional shares from $1. You can invest on your own or have Fidelity do it: stocks, ETFs, crypto and more. There are retirement accounts, including Roth IRA, and retirement planning tools. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Commission-free US stocks and ETFs
Fractional shares from $1
Crypto
Retirement accounts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Онлайн-угоди з акціями й ETF США $0; інші тарифи — на сайті.', '$0 online US stock and ETF trades; other pricing on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$0 online US stock and ETF trades; other pricing on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Webull — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'webull.com' OR LOWER(`name`) = 'webull')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Webull', NULL, 'https://www.webull.com', NULL, NULL, 'Застосунок для торгівлі акціями, опціонами, ф''ючерсами, криптовалютами й ринками прогнозів.', 'An app for trading stocks, options, futures, crypto and prediction markets.', 'Webull — інвестиційна платформа з акціями США, міжнародними акціями через ADR, дробовими й позабіржовими акціями, опціонами з безкоштовними котируваннями в реальному часі, «греками» й IV, ф''ючерсами, криптовалютами та ринками прогнозів в одному застосунку. Є скринер ETF і спільнота інвесторів. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Webull is an investing platform with US stocks, international stocks via ADRs, fractional and OTC shares, options with free real-time quotes, Greeks and IV, futures, crypto and prediction markets in one app. There is an ETF screener and an investor community. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Акції, опціони, ф''ючерси, крипто
Дробові акції
Котирування опціонів у реальному часі
Скринер ETF і спільнота', 'Stocks, options, futures, crypto
Fractional shares
Real-time options quotes
ETF screener and community', 'Трейдери й інвестори, що шукають брокера.', 'Traders and investors looking for a broker.', 'web,mobile,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'webull.com' OR LOWER(`name`) = 'webull') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app for trading stocks, options, futures, crypto and prediction markets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Webull is an investing platform with US stocks, international stocks via ADRs, fractional and OTC shares, options with free real-time quotes, Greeks and IV, futures, crypto and prediction markets in one app. There is an ETF screener and an investor community. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stocks, options, futures, crypto
Fractional shares
Real-time options quotes
ETF screener and community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders and investors looking for a broker.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- eToro — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'etoro.com' OR LOWER(`name`) = 'etoro')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'eToro', NULL, 'https://www.etoro.com', NULL, NULL, 'Платформа для інвестування в акції, ETF і криптовалюти з копіюванням угод інших інвесторів.', 'A platform for investing in stocks, ETFs and crypto with copy trading of other investors.', 'eToro поєднує інвестування в акції, ETF і криптовалюти з соціальною мережею інвесторів: можна копіювати портфелі інших користувачів. Дробові акції доступні від невеликих сум, плати за управління немає, а комісія за криптовалюти — від 0,3% для великих обсягів і не більше 1%. Розділ eToro Edge об''єднує графіки, списки спостереження й сповіщення. Повний перелік комісій — на сторінці тарифів. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'eToro combines investing in stocks, ETFs and crypto with a social network of investors: you can copy other users'' portfolios. Fractional shares are available from small amounts, there are no management fees, and crypto fees start at 0.3% for high volumes and are capped at 1%. eToro Edge brings charts, watchlists and alerts together. The full fee schedule is on the fees page. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Копіювання угод (CopyTrader)
Акції, ETF, криптовалюти
Дробові акції
eToro Edge: графіки й сповіщення', 'Copy trading
Stocks, ETFs, crypto
Fractional shares
eToro Edge: charts and alerts', 'Початківці й інвестори, яким цікаво копіювати інших.', 'Beginners and investors interested in copying others.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'etoro.com' OR LOWER(`name`) = 'etoro') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform for investing in stocks, ETFs and crypto with copy trading of other investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'eToro combines investing in stocks, ETFs and crypto with a social network of investors: you can copy other users'' portfolios. Fractional shares are available from small amounts, there are no management fees, and crypto fees start at 0.3% for high volumes and are capped at 1%. eToro Edge brings charts, watchlists and alerts together. The full fee schedule is on the fees page. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Copy trading
Stocks, ETFs, crypto
Fractional shares
eToro Edge: charts and alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginners and investors interested in copying others.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Без плати за управління; комісія за криптовалюти 0,3–1%; повний перелік — на сайті.', 'No management fees; crypto fees 0.3–1%; full schedule on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'No management fees; crypto fees 0.3–1%; full schedule on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Trading 212 — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trading212.com' OR LOWER(`name`) = 'trading 212')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Trading 212', NULL, 'https://www.trading212.com', NULL, NULL, 'Інвестування в акції й ETF без комісії, готові «пироги» портфелів і рахунки в кількох валютах.', 'Commission-free investing in stocks and ETFs, ready-made portfolio "pies" and multi-currency accounts.', 'Trading 212 дозволяє інвестувати в тисячі акцій і ETF без комісії, обирати готові «пироги» (кошики інструментів) або збирати власні. Можна поповнювати рахунок і інвестувати в кількох валютах, щоб уникати витрат на обмін. Для британських клієнтів кошти зберігаються на окремому рахунку й захищені FSCS до £120 000. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Trading 212 lets you invest in thousands of stocks and ETFs commission-free, choose ready-made "pies" (baskets of instruments) or build your own. You can deposit and invest in several currencies to avoid FX costs. For UK clients, funds are held in a segregated account and protected by the FSCS up to £120,000. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Акції й ETF без комісії
Готові й власні «пироги»
Кілька валют на рахунку
Захист FSCS (UK)', 'Commission-free stocks and ETFs
Ready-made and custom pies
Multi-currency accounts
FSCS protection (UK)', 'Інвестори-початківці в Європі та Великій Британії.', 'Beginner investors in Europe and the UK.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trading212.com' OR LOWER(`name`) = 'trading 212') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Commission-free investing in stocks and ETFs, ready-made portfolio "pies" and multi-currency accounts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Trading 212 lets you invest in thousands of stocks and ETFs commission-free, choose ready-made "pies" (baskets of instruments) or build your own. You can deposit and invest in several currencies to avoid FX costs. For UK clients, funds are held in a segregated account and protected by the FSCS up to £120,000. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Commission-free stocks and ETFs
Ready-made and custom pies
Multi-currency accounts
FSCS protection (UK)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner investors in Europe and the UK.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Інвестування в акції й ETF без комісії; інші збори — на сайті.', 'Commission-free stocks and ETFs; other fees on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Commission-free stocks and ETFs; other fees on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Freedom24 — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freedom24.com' OR LOWER(`name`) = 'freedom24')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Freedom24', NULL, 'https://freedom24.com', NULL, NULL, 'Брокер із доступом до бірж США, Європи й Азії: акції, ETF, облігації, ф''ючерси й опціони.', 'A broker with access to US, European and Asian exchanges: stocks, ETFs, bonds, futures and options.', 'Freedom24 — вебплатформа й мобільний застосунок для інвестування в акції, ETF, облігації, ф''ючерси й опціони на основних біржах США, Європи й Азії. Рахунок можна відкрити приблизно за 10 хвилин і поповнити банківським переказом без комісії або карткою. Опціони можна використовувати для хеджування позицій. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Freedom24 is a web platform and mobile app for investing in stocks, ETFs, bonds, futures and options on major US, European and Asian exchanges. You can open an account in about 10 minutes and fund it by commission-free bank transfer or by card. Options can be used to hedge positions. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Біржі США, Європи й Азії
Акції, ETF, облігації
Ф''ючерси й опціони
Відкриття рахунку за 10 хвилин', 'US, European and Asian exchanges
Stocks, ETFs, bonds
Futures and options
Account opening in 10 minutes', 'Трейдери й інвестори, що шукають брокера.', 'Traders and investors looking for a broker.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freedom24.com' OR LOWER(`name`) = 'freedom24') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A broker with access to US, European and Asian exchanges: stocks, ETFs, bonds, futures and options.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Freedom24 is a web platform and mobile app for investing in stocks, ETFs, bonds, futures and options on major US, European and Asian exchanges. You can open an account in about 10 minutes and fund it by commission-free bank transfer or by card. Options can be used to hedge positions. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'US, European and Asian exchanges
Stocks, ETFs, bonds
Futures and options
Account opening in 10 minutes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders and investors looking for a broker.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Saxo — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'home.saxo' OR LOWER(`name`) = 'saxo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Saxo', NULL, 'https://www.home.saxo', NULL, NULL, 'Ліцензований датський банк з платформою для інвестування на світових ринках.', 'A licensed Danish bank with a platform for investing in global markets.', 'Saxo Bank A/S — повністю ліцензований і регульований датський банк з онлайн-платформою для інвестування й торгівлі на світових фінансових ринках. Набір продуктів і функцій залежить від країни проживання й типу клієнта. Saxo попереджає: CFD — складні інструменти, і 64% рахунків роздрібних інвесторів втрачають гроші на CFD з цим провайдером. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Saxo Bank A/S is a fully licensed and regulated Danish bank with an online platform for investing and trading in global financial markets. Products and features depend on your country of residence and client type. Saxo warns that CFDs are complex instruments and 64% of retail investor accounts lose money trading CFDs with this provider. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Регульований банк з ліцензією
Світові ринки
Веб, десктоп і мобільні платформи
Акції, ETF, облігації, CFD', 'Regulated bank with a licence
Global markets
Web, desktop and mobile platforms
Stocks, ETFs, bonds, CFDs', 'Трейдери й інвестори, що шукають брокера.', 'Traders and investors looking for a broker.', 'web,mobile,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'home.saxo' OR LOWER(`name`) = 'saxo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A licensed Danish bank with a platform for investing in global markets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Saxo Bank A/S is a fully licensed and regulated Danish bank with an online platform for investing and trading in global financial markets. Products and features depend on your country of residence and client type. Saxo warns that CFDs are complex instruments and 64% of retail investor accounts lose money trading CFDs with this provider. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Regulated bank with a licence
Global markets
Web, desktop and mobile platforms
Stocks, ETFs, bonds, CFDs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders and investors looking for a broker.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Public.com — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'public.com' OR LOWER(`name`) = 'public.com')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Public.com', NULL, 'https://public.com', NULL, NULL, 'Інвестиційна платформа: акції, облігації, опціони, ETF, крипто, AI-агенти для торгівлі й API.', 'An investing platform: stocks, bonds, options, ETFs, crypto, AI trading agents and an API.', 'Public.com дозволяє торгувати понад 9000 акціями, ETF, опціонами з ребейтами, облігаціями, казначейськими паперами, понад 60 криптоактивами й ринками прогнозів. Можна створювати AI-агентів для торгівлі, торгувати через API без комісії, мати пенсійні рахунки IRA і високодохідний рахунок для готівки. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Public.com lets you trade more than 9,000 stocks, ETFs, options with rebates, bonds, Treasuries, 60+ crypto assets and prediction markets. You can build AI trading agents, trade via a commission-free API, and hold IRA retirement accounts and a high-yield cash account. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Понад 9000 акцій
Опціони з ребейтами
AI-агенти для торгівлі
Торговий API без комісії
Крипто й облігації', '9,000+ stocks
Options with rebates
AI trading agents
Commission-free trading API
Crypto and bonds', 'Інвестори в США.', 'Investors in the US.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'public.com' OR LOWER(`name`) = 'public.com') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An investing platform: stocks, bonds, options, ETFs, crypto, AI trading agents and an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Public.com lets you trade more than 9,000 stocks, ETFs, options with rebates, bonds, Treasuries, 60+ crypto assets and prediction markets. You can build AI trading agents, trade via a commission-free API, and hold IRA retirement accounts and a high-yield cash account. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '9,000+ stocks
Options with rebates
AI trading agents
Commission-free trading API
Crypto and bonds', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- moomoo — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moomoo.com' OR LOWER(`name`) = 'moomoo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'moomoo', NULL, 'https://www.moomoo.com', NULL, NULL, 'Онлайн-платформа для торгівлі акціями й опціонами без комісії з аналітикою для активних трейдерів.', 'An online platform for commission-free stock and options trading with analytics for active traders.', 'moomoo — платформа для торгівлі акціями й опціонами без комісійних зборів, з графіками, даними й аналітичними інструментами. Фінансові послуги в застосунку в США надає Moomoo Financial Inc. Опціони ризиковані й підходять не всім; перед торгівлею варто прочитати документ про опціони. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'moomoo is a platform for stock and options trading without commission fees, with charts, data and analytics tools. In the US, financial services in the app are provided by Moomoo Financial Inc. Options are risky and not suitable for all investors; read the options disclosure document before trading. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Акції й опціони без комісії
Графіки й аналітика
Десктоп і мобільний застосунок
Дані для активних трейдерів', 'Commission-free stocks and options
Charts and analytics
Desktop and mobile app
Data for active traders', 'Трейдери й інвестори, що шукають брокера.', 'Traders and investors looking for a broker.', 'web,mobile,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moomoo.com' OR LOWER(`name`) = 'moomoo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An online platform for commission-free stock and options trading with analytics for active traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'moomoo is a platform for stock and options trading without commission fees, with charts, data and analytics tools. In the US, financial services in the app are provided by Moomoo Financial Inc. Options are risky and not suitable for all investors; read the options disclosure document before trading. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Commission-free stocks and options
Charts and analytics
Desktop and mobile app
Data for active traders', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders and investors looking for a broker.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- tastytrade — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tastytrade.com' OR LOWER(`name`) = 'tastytrade')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'tastytrade', NULL, 'https://tastytrade.com', NULL, NULL, 'Брокер для активних трейдерів: опціони, акції, ф''ючерси, крипто, бектест опціонів, API і MCP.', 'A broker for active traders: options, stocks, futures, crypto, options backtesting, API and MCP.', 'tastytrade — брокер для активних трейдерів з опціонами, акціями, ф''ючерсами, опціонами на ф''ючерси, ETF, криптовалютами, Форекс і ринками прогнозів. Є мобільна, настільна й веб-платформи, бектест опціонних стратегій, API і MCP для автоматизації та портфельна маржа. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'tastytrade is a broker for active traders with options, stocks, futures, futures options, ETFs, crypto, forex and prediction markets. There are mobile, desktop and web platforms, options backtesting, an API and MCP for automation, and portfolio margin. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Опціони, акції, ф''ючерси
Бектест опціонів
API і MCP
Портфельна маржа', 'Options, stocks, futures
Options backtesting
API and MCP
Portfolio margin', 'Активні опціонні трейдери.', 'Active options traders.', 'web,mobile,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tastytrade.com' OR LOWER(`name`) = 'tastytrade') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A broker for active traders: options, stocks, futures, crypto, options backtesting, API and MCP.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'tastytrade is a broker for active traders with options, stocks, futures, futures options, ETFs, crypto, forex and prediction markets. There are mobile, desktop and web platforms, options backtesting, an API and MCP for automation, and portfolio margin. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Options, stocks, futures
Options backtesting
API and MCP
Portfolio margin', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Active options traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Firstrade — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firstrade.com' OR LOWER(`name`) = 'firstrade')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Firstrade', NULL, 'https://www.firstrade.com', NULL, NULL, 'Брокер з угодами без комісії на акції, опціони, взаємні фонди й облігації, нічна торгівля.', 'A broker with commission-free trades on stocks, options, mutual funds and bonds, and overnight trading.', 'Firstrade Securities пропонує акції з NYSE, AMEX, Nasdaq і позабіржового ринку, опціони, взаємні фонди й інструменти з фіксованим доходом. Угоди з акціями — без комісії, а опціони — без комісії й без плати за контракт. Є нічна торгівля без комісії. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Firstrade Securities offers stocks listed on NYSE, AMEX, Nasdaq and OTC markets, options, mutual funds and fixed income. Stock trades are commission-free, and options have $0 commission and $0 contract fees. Overnight trading is also commission-free. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Акції без комісії
Опціони: $0 комісія і $0 за контракт
Нічна торгівля
Взаємні фонди й облігації', 'Commission-free stocks
Options: $0 commission and $0 contract fees
Overnight trading
Mutual funds and bonds', 'Трейдери й інвестори, що шукають брокера.', 'Traders and investors looking for a broker.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firstrade.com' OR LOWER(`name`) = 'firstrade') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A broker with commission-free trades on stocks, options, mutual funds and bonds, and overnight trading.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Firstrade Securities offers stocks listed on NYSE, AMEX, Nasdaq and OTC markets, options, mutual funds and fixed income. Stock trades are commission-free, and options have $0 commission and $0 contract fees. Overnight trading is also commission-free. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Commission-free stocks
Options: $0 commission and $0 contract fees
Overnight trading
Mutual funds and bonds', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders and investors looking for a broker.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Угоди з акціями й опціонами без комісії; інші збори — на сайті.', 'Commission-free stock and options trades; other fees on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Commission-free stock and options trades; other fees on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- E*TRADE — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'us.etrade.com' OR LOWER(`name`) = 'e*trade')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'E*TRADE', NULL, 'https://us.etrade.com', NULL, NULL, 'Брокер Morgan Stanley для інвестування, торгівлі й пенсійних заощаджень з навчальними матеріалами.', 'Morgan Stanley''s broker for investing, trading and retirement savings, with learning materials.', 'E*TRADE від Morgan Stanley — брокерські, пенсійні й ощадні рахунки для інвестування й торгівлі. На сайті є навчальні матеріали про торгівлю, інвестування й пенсійне планування, а також хаб Crypto Essentials з освітою й коментарями щодо криптовалют. Діють акції для нових рахунків — умови на сайті. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'E*TRADE from Morgan Stanley offers brokerage, retirement and savings accounts for investing and trading. The site has learning materials on trading, investing and retirement planning, plus the Crypto Essentials hub with crypto education and commentary. There are offers for new accounts; terms on the site. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Брокерські й пенсійні рахунки
Навчальні матеріали
Хаб Crypto Essentials
Ощадні рахунки', 'Brokerage and retirement accounts
Learning materials
Crypto Essentials hub
Savings accounts', 'Інвестори в США.', 'Investors in the US.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'us.etrade.com' OR LOWER(`name`) = 'e*trade') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Morgan Stanley''s broker for investing, trading and retirement savings, with learning materials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'E*TRADE from Morgan Stanley offers brokerage, retirement and savings accounts for investing and trading. The site has learning materials on trading, investing and retirement planning, plus the Crypto Essentials hub with crypto education and commentary. There are offers for new accounts; terms on the site. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Brokerage and retirement accounts
Learning materials
Crypto Essentials hub
Savings accounts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lightyear — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lightyear.com' OR LOWER(`name`) = 'lightyear')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lightyear', NULL, 'https://lightyear.com', NULL, NULL, 'Європейська інвестиційна платформа: акції й фонди світу, без комісії за ордери на ETF, Lightyear AI.', 'A European investing platform: global stocks and funds, no ETF order fees, Lightyear AI.', 'Lightyear — інвестиційна платформа, регульована EFSA (Естонія), з тисячами акцій і фондів світу, облігаціями, криптовалютами та готовими планами. Ордери на ETF — без комісії, а AI-інструменти Lightyear AI допомагають розбиратися з ринковими даними. Є рахунок заощаджень з відсотком. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Lightyear is an investing platform regulated by the EFSA (Estonia), with thousands of global stocks and funds, bonds, crypto and ready-made plans. ETF orders have no fees, and Lightyear AI tools help you make sense of market data. There is an interest-bearing savings account. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Акції й фонди світу
Без комісії за ордери на ETF
Lightyear AI
Готові плани й заощадження', 'Global stocks and funds
No ETF order fees
Lightyear AI
Ready-made plans and savings', 'Інвестори в Європі.', 'Investors in Europe.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lightyear.com' OR LOWER(`name`) = 'lightyear') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A European investing platform: global stocks and funds, no ETF order fees, Lightyear AI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lightyear is an investing platform regulated by the EFSA (Estonia), with thousands of global stocks and funds, bonds, crypto and ready-made plans. ETF orders have no fees, and Lightyear AI tools help you make sense of market data. There is an interest-bearing savings account. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Global stocks and funds
No ETF order fees
Lightyear AI
Ready-made plans and savings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors in Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Ордери на ETF без комісії; інші тарифи — на сайті.', 'No ETF order fees; other pricing on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'No ETF order fees; other pricing on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Scalable Capital — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scalable.capital' OR LOWER(`name`) = 'scalable capital')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Scalable Capital', NULL, 'https://scalable.capital', NULL, NULL, 'Німецький брокер і банк: брокерський рахунок, ETF-плани заощаджень, керування капіталом і кредит.', 'A German broker and bank: brokerage account, ETF savings plans, wealth management and credit.', 'Scalable Capital пропонує брокерський рахунок Scalable Broker для самостійного інвестування від €1 і сервіс Scalable Wealth, де портфелем керують експерти. Є ETF-плани заощаджень, пенсійний рахунок, відсоток на нічні заощадження й кредит під цінні папери до €250 000. Кредитне інвестування має додаткові ризики. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Scalable Capital offers the Scalable Broker account for self-directed investing from €1 and Scalable Wealth, where experts manage your portfolio. There are ETF savings plans, a retirement account, interest on overnight savings and securities-backed credit up to €250,000. Credit-financed investing carries extra risk. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Scalable Broker від €1
Scalable Wealth (керування)
ETF-плани заощаджень
Кредит під цінні папери', 'Scalable Broker from €1
Scalable Wealth (managed)
ETF savings plans
Securities-backed credit', 'Інвестори в Німеччині та Європі.', 'Investors in Germany and Europe.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scalable.capital' OR LOWER(`name`) = 'scalable capital') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A German broker and bank: brokerage account, ETF savings plans, wealth management and credit.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Scalable Capital offers the Scalable Broker account for self-directed investing from €1 and Scalable Wealth, where experts manage your portfolio. There are ETF savings plans, a retirement account, interest on overnight savings and securities-backed credit up to €250,000. Credit-financed investing carries extra risk. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Scalable Broker from €1
Scalable Wealth (managed)
ETF savings plans
Securities-backed credit', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors in Germany and Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Trade Republic — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'traderepublic.com' OR LOWER(`name`) = 'trade republic')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Trade Republic', NULL, 'https://traderepublic.com', NULL, NULL, 'Європейський брокер і банк: інвестування від €1, відсоток на готівку й картка з Saveback.', 'A European broker and bank: investing from €1, interest on cash and a card with Saveback.', 'Trade Republic поєднує брокера й банк: інвестувати в акції, ETF та інші інструменти можна від €1, на залишок готівки нараховується відсоток, а картка з Saveback повертає 1% витрат у план заощаджень. Безкоштовні зняття готівки в банкоматах світу — від €100. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Trade Republic combines a broker and a bank: you can invest in stocks, ETFs and other instruments from €1, earn interest on cash, and a card with Saveback returns 1% of spending into your savings plan. Free ATM withdrawals worldwide from €100. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Інвестування від €1
Відсоток на готівку
Картка з Saveback
Плани заощаджень', 'Investing from €1
Interest on cash
Card with Saveback
Savings plans', 'Інвестори в країнах ЄС.', 'Investors in EU countries.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'traderepublic.com' OR LOWER(`name`) = 'trade republic') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A European broker and bank: investing from €1, interest on cash and a card with Saveback.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Trade Republic combines a broker and a bank: you can invest in stocks, ETFs and other instruments from €1, earn interest on cash, and a card with Saveback returns 1% of spending into your savings plan. Free ATM withdrawals worldwide from €100. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Investing from €1
Interest on cash
Card with Saveback
Savings plans', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors in EU countries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- XTB — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'xtb.com' OR LOWER(`name`) = 'xtb')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'XTB', NULL, 'https://www.xtb.com', NULL, NULL, 'Застосунок для інвестицій і торгівлі: акції й ETF без комісії до €100 000 обороту на місяць, CFD.', 'An investing and trading app: commission-free stocks and ETFs up to €100,000 monthly turnover, CFDs.', 'XTB поєднує інвестиції, торгівлю й заощадження в одному застосунку та вебплатформі. Акції й ETF — без комісії до €100 000 обороту на місяць, вище — 0,2% (мінімум €10). Є ETF-плани для пасивного інвестування, аналітика ринку й навчальні матеріали. CFD — складні інструменти з високим ризиком швидкої втрати коштів через кредитне плече. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'XTB combines investing, trading and savings in one app and web platform. Stocks and ETFs are commission-free up to €100,000 monthly turnover; above that the fee is 0.2% (min. €10). There are ETF plans for passive investing, market insights and learning materials. CFDs are complex instruments with a high risk of losing money rapidly due to leverage. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Акції й ETF без комісії до €100 000/міс
ETF-плани
CFD на сировину й індекси
Аналітика й навчання', '$0 stocks and ETFs up to €100,000/month
ETF plans
CFDs on commodities and indices
Insights and education', 'Трейдери й інвестори, що шукають брокера.', 'Traders and investors looking for a broker.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'xtb.com' OR LOWER(`name`) = 'xtb') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An investing and trading app: commission-free stocks and ETFs up to €100,000 monthly turnover, CFDs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'XTB combines investing, trading and savings in one app and web platform. Stocks and ETFs are commission-free up to €100,000 monthly turnover; above that the fee is 0.2% (min. €10). There are ETF plans for passive investing, market insights and learning materials. CFDs are complex instruments with a high risk of losing money rapidly due to leverage. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '$0 stocks and ETFs up to €100,000/month
ETF plans
CFDs on commodities and indices
Insights and education', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders and investors looking for a broker.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', '0% комісії на акції й ETF до €100 000 обороту на місяць, далі 0,2% (мін. €10).', '0% commission on stocks and ETFs up to €100,000 monthly turnover, then 0.2% (min. €10).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '0% commission on stocks and ETFs up to €100,000 monthly turnover, then 0.2% (min. €10).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- EXANTE — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'exante.eu' OR LOWER(`name`) = 'exante')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'EXANTE', NULL, 'https://exante.eu', NULL, NULL, 'Прайм-брокер з доступом до 2 млн+ інструментів на 50+ ринках, власною платформою й безкоштовним API.', 'A prime broker with access to 2M+ instruments on 50+ markets, its own platform and a free API.', 'EXANTE з 2011 року надає доступ до акцій, ETF, облігацій, ф''ючерсів, опціонів, сировини й валют — понад 2 мільйони інструментів на понад 50 ринках через власну платформу. Платформа доступна на десктопі, у вебі й на мобільних, є безкоштовний API. Ставки налаштовуються, плати за зберігання акцій і ETF немає. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Since 2011 EXANTE has offered access to stocks, ETFs, bonds, futures, options, commodities and currencies: more than 2 million instruments on 50+ markets through its own platform. The platform runs on desktop, web and mobile, and there is a free API. Rates are customisable, and there are no custody fees on stocks and ETFs. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', '2 млн+ інструментів на 50+ ринках
Власна платформа
Безкоштовний API
Без плати за зберігання акцій і ETF', '2M+ instruments on 50+ markets
Proprietary platform
Free API
No custody fees on stocks and ETFs', 'Досвідчені інвестори й професіонали.', 'Experienced investors and professionals.', 'web,mobile,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'exante.eu' OR LOWER(`name`) = 'exante') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A prime broker with access to 2M+ instruments on 50+ markets, its own platform and a free API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Since 2011 EXANTE has offered access to stocks, ETFs, bonds, futures, options, commodities and currencies: more than 2 million instruments on 50+ markets through its own platform. The platform runs on desktop, web and mobile, and there is a free API. Rates are customisable, and there are no custody fees on stocks and ETFs. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '2M+ instruments on 50+ markets
Proprietary platform
Free API
No custody fees on stocks and ETFs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Experienced investors and professionals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tiger Brokers — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'itiger.com' OR LOWER(`name`) = 'tiger brokers')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tiger Brokers', NULL, 'https://www.itiger.com', NULL, NULL, 'Брокер для інвестицій в акції США, Сінгапуру, Гонконгу, китайські A-shares та інші активи.', 'A broker for investing in US, Singapore and Hong Kong stocks, China A-shares and other assets.', 'Tiger Brokers — платформа для інвестицій в акції США, Сінгапурської й Гонконгської бірж, китайські A-shares та інші світові активи, з опціонами й ф''ючерсами. Застосунок розрахований і на нових, і на досвідчених інвесторів. Компанія попереджає про шахраїв і радить перевіряти інформацію лише через офіційні канали. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'Tiger Brokers is a platform for investing in US, Singapore and Hong Kong stocks, China A-shares and other global assets, with options and futures. The app is designed for both new and experienced investors. The company warns about scams and advises verifying information only through official channels. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Акції США, SGX і Гонконгу
Китайські A-shares
Опціони й ф''ючерси
Мобільний застосунок', 'US, SGX and HK stocks
China A-shares
Options and futures
Mobile app', 'Інвестори в Азії.', 'Investors in Asia.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'itiger.com' OR LOWER(`name`) = 'tiger brokers') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A broker for investing in US, Singapore and Hong Kong stocks, China A-shares and other assets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tiger Brokers is a platform for investing in US, Singapore and Hong Kong stocks, China A-shares and other global assets, with options and futures. The app is designed for both new and experienced investors. The company warns about scams and advises verifying information only through official channels. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'US, SGX and HK stocks
China A-shares
Options and futures
Mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors in Asia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SoFi Invest — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sofi.com/invest' OR LOWER(`name`) = 'sofi invest')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SoFi Invest', NULL, 'https://www.sofi.com/invest/', NULL, NULL, 'Інвестування в застосунку SoFi: акції, ETF, IPO за ціною розміщення й автоматичне інвестування.', 'Investing in the SoFi app: stocks, ETFs, IPOs at IPO prices and automated investing.', 'SoFi Invest дозволяє торгувати акціями й ETF, купувати акції IPO за ціною розміщення або обрати автоматичне інвестування — усе в застосунку SoFi. Для нових рахунків діють бонуси на умовах, описаних на сайті. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'SoFi Invest lets you trade stocks and ETFs, buy IPO shares at IPO prices or choose automated investing, all in the SoFi app. New accounts can get bonuses under the terms on the site. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Акції й ETF
IPO за ціною розміщення
Автоматичне інвестування
Застосунок SoFi', 'Stocks and ETFs
IPOs at IPO prices
Automated investing
SoFi app', 'Інвестори в США.', 'Investors in the US.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sofi.com/invest' OR LOWER(`name`) = 'sofi invest') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Investing in the SoFi app: stocks, ETFs, IPOs at IPO prices and automated investing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SoFi Invest lets you trade stocks and ETFs, buy IPO shares at IPO prices or choose automated investing, all in the SoFi app. New accounts can get bonuses under the terms on the site. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stocks and ETFs
IPOs at IPO prices
Automated investing
SoFi app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- IG — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ig.com' OR LOWER(`name`) = 'ig')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'IG', NULL, 'https://www.ig.com', NULL, NULL, 'Провайдер CFD і Форекс: тисячі акцій, індекси, сировина, опціони, безкоштовний демо-рахунок.', 'A CFD and forex provider: thousands of shares, indices, commodities, options and a free demo account.', 'IG дозволяє торгувати CFD на акції, Форекс, індекси, сировину, опціони та інше — загалом понад 17 000 ринків з можливістю відкривати як довгі, так і короткі позиції. Є безкоштовний демо-рахунок і навчальна IG Academy. IG попереджає: 70% рахунків роздрібних клієнтів втрачають гроші на позабіржових продуктах з кредитним плечем, зокрема CFD. Інвестиції та торгівля пов''язані з ризиком втрати коштів. Доступність послуг залежить від країни проживання.', 'IG lets you trade CFDs on shares, forex, indices, commodities, options and more: over 17,000 markets, going long or short. There is a free demo account and the IG Academy for learning. IG warns that 70% of retail client accounts lose money when trading OTC leveraged products, including CFDs. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'Понад 17 000 ринків
CFD і Форекс
Безкоштовний демо-рахунок
Навчання IG Academy', '17,000+ markets
CFDs and forex
Free demo account
IG Academy', 'Досвідчені трейдери, що розуміють ризики плеча.', 'Experienced traders who understand leverage risks.', 'web,mobile,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ig.com' OR LOWER(`name`) = 'ig') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A CFD and forex provider: thousands of shares, indices, commodities, options and a free demo account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'IG lets you trade CFDs on shares, forex, indices, commodities, options and more: over 17,000 markets, going long or short. There is a free demo account and the IG Academy for learning. IG warns that 70% of retail client accounts lose money when trading OTC leveraged products, including CFDs. Investing and trading involve the risk of losing money. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '17,000+ markets
CFDs and forex
Free demo account
IG Academy', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Experienced traders who understand leverage risks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Демо', 'Demo', 0.00, 'free', 'Безкоштовний демо-рахунок.', 'Free demo account.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Демо' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Demo', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free demo account.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Брокерський рахунок', 'Brokerage account', NULL, 'one_time', 'Відкриття рахунку безкоштовне; комісії залежать від ринку й інструменту — див. тарифи на сайті.', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Брокерський рахунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Brokerage account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Opening an account is free; fees depend on the market and instrument — see the pricing page.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Binance — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'binance.com' OR LOWER(`name`) = 'binance')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Binance', NULL, 'https://www.binance.com', NULL, NULL, 'Криптобіржа для купівлі, продажу й торгівлі криптовалютами з мобільним застосунком.', 'A crypto exchange for buying, selling and trading cryptocurrencies, with a mobile app.', 'Binance — криптобіржа, де можна купувати, продавати й торгувати Bitcoin, Ethereum та багатьма іншими криптовалютами, зокрема токенізованими акціями. Є застосунки для iOS та Android. Користувачів зі США сайт перенаправляє на окремий регульований партнерський сервіс Binance.US. Криптовалюти дуже волатильні, можна втратити всі вкладені кошти. Доступність послуг залежить від країни проживання.', 'Binance is a crypto exchange where you can buy, sell and trade Bitcoin, Ethereum and many other cryptocurrencies, including tokenised stocks. There are iOS and Android apps. Users in the US are redirected to Binance.US, a separate regulated partner. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'Купівля й продаж криптовалют
Спотова торгівля
Токенізовані акції
Застосунки iOS та Android', 'Buy and sell crypto
Spot trading
Tokenised stocks
iOS and Android apps', 'Криптотрейдери й інвестори.', 'Crypto traders and investors.', 'web,mobile,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'binance.com' OR LOWER(`name`) = 'binance') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A crypto exchange for buying, selling and trading cryptocurrencies, with a mobile app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Binance is a crypto exchange where you can buy, sell and trade Bitcoin, Ethereum and many other cryptocurrencies, including tokenised stocks. There are iOS and Android apps. Users in the US are redirected to Binance.US, a separate regulated partner. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Buy and sell crypto
Spot trading
Tokenised stocks
iOS and Android apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crypto traders and investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Торгові комісії', 'Trading fees', NULL, 'one_time', 'Комісії залежать від виду торгівлі й обсягу — див. сайт.', 'Fees depend on trading type and volume; see the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Торгові комісії' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Trading fees', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Fees depend on trading type and volume; see the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Coinbase — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coinbase.com' OR LOWER(`name`) = 'coinbase')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Coinbase', NULL, 'https://www.coinbase.com', NULL, NULL, 'Криптоплатформа для купівлі, продажу, стейкінгу й зберігання криптовалют, а також торгівлі акціями.', 'A crypto platform for buying, selling, staking and storing crypto, plus stock trading.', 'Coinbase дозволяє купувати й продавати Bitcoin, Ethereum та інші криптовалюти, а в деяких країнах — і акції. Є стейкінг, винагороди за USDC, крипто-позики, дебетова й кредитна картки та гаманець Coinbase Wallet. Для бізнесу — криптоплатежі й торгівля. Криптовалюти дуже волатильні, можна втратити всі вкладені кошти. Доступність послуг залежить від країни проживання.', 'Coinbase lets you buy and sell Bitcoin, Ethereum and other crypto, and in some countries stocks too. There is staking, USDC rewards, crypto-backed loans, debit and credit cards and Coinbase Wallet. For businesses there are crypto payments and trading. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'Купівля й продаж криптовалют
Стейкінг і винагороди
Coinbase Wallet
Торгівля акціями (у деяких країнах)', 'Buy and sell crypto
Staking and rewards
Coinbase Wallet
Stock trading (in some countries)', 'Початківці й інвестори в криптовалюти.', 'Beginners and crypto investors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coinbase.com' OR LOWER(`name`) = 'coinbase') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A crypto platform for buying, selling, staking and storing crypto, plus stock trading.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Coinbase lets you buy and sell Bitcoin, Ethereum and other crypto, and in some countries stocks too. There is staking, USDC rewards, crypto-backed loans, debit and credit cards and Coinbase Wallet. For businesses there are crypto payments and trading. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Buy and sell crypto
Staking and rewards
Coinbase Wallet
Stock trading (in some countries)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginners and crypto investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Торгові комісії', 'Trading fees', NULL, 'one_time', 'Комісії залежать від способу оплати й обсягу — див. сайт.', 'Fees depend on payment method and volume; see the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Торгові комісії' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Trading fees', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Fees depend on payment method and volume; see the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kraken — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kraken.com' OR LOWER(`name`) = 'kraken')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kraken', NULL, 'https://www.kraken.com', NULL, NULL, 'Криптобіржа з 2011 року: 600+ крипто-пар, акції й ETF, ф''ючерси, API.', 'A crypto exchange since 2011: 600+ crypto pairs, stocks and ETFs, futures and an API.', 'Kraken працює з 2011 року. Тут можна торгувати понад 600 криптовалютними парами, понад 11 000 акціями й ETF, ф''ючерсами, використовувати плече й API для спотової та ф''ючерсної торгівлі. Є вебплатформа, мобільний застосунок, самостійне зберігання криптовалют і картка для витрат. Криптовалюти дуже волатильні, можна втратити всі вкладені кошти. Доступність послуг залежить від країни проживання.', 'Kraken has operated since 2011. You can trade 600+ crypto pairs, 11,000+ stocks and ETFs and futures, use leverage and trade spot and futures via API. There is a web platform, a mobile app, self-custody and a card for spending. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', '600+ криптовалютних пар
11 000+ акцій і ETF
Ф''ючерси й API
Самостійне зберігання', '600+ crypto pairs
11,000+ stocks and ETFs
Futures and API
Self-custody', 'Криптотрейдери й інвестори.', 'Crypto traders and investors.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kraken.com' OR LOWER(`name`) = 'kraken') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A crypto exchange since 2011: 600+ crypto pairs, stocks and ETFs, futures and an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kraken has operated since 2011. You can trade 600+ crypto pairs, 11,000+ stocks and ETFs and futures, use leverage and trade spot and futures via API. There is a web platform, a mobile app, self-custody and a card for spending. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '600+ crypto pairs
11,000+ stocks and ETFs
Futures and API
Self-custody', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crypto traders and investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Торгові комісії', 'Trading fees', NULL, 'one_time', 'Комісії залежать від продукту й обсягу — див. сайт.', 'Fees depend on product and volume; see the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Торгові комісії' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Trading fees', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Fees depend on product and volume; see the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- WhiteBIT — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'whitebit.com' OR LOWER(`name`) = 'whitebit')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'WhiteBIT', NULL, 'https://whitebit.com', NULL, NULL, 'Криптобіржа: купівля криптовалют, ф''ючерси з плечем, TradFi-ф''ючерси, крипто-кредитування й картка Nova.', 'A crypto exchange: buying crypto, leveraged futures, TradFi futures, crypto lending and the Nova card.', 'WhiteBIT дозволяє купувати криптовалюту без попереднього досвіду, торгувати USDT-маржинальними ф''ючерсами з плечем до 100x і TradFi-ф''ючерсами на традиційні інструменти. Є крипто-кредитування, миттєві перекази між користувачами QuickSend, коди WB Check і картка Nova з кешбеком. Торгівля з високим плечем особливо ризикована. Криптовалюти дуже волатильні, можна втратити всі вкладені кошти. Доступність послуг залежить від країни проживання.', 'WhiteBIT lets you buy crypto without prior experience, trade USDT-margined futures with up to 100x leverage and TradFi futures on traditional instruments. There is crypto lending, QuickSend instant transfers between users, WB Check codes and the Nova card with cashback. High-leverage trading is especially risky. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'Купівля криптовалют
Ф''ючерси з плечем
TradFi-ф''ючерси
Крипто-кредитування
Картка Nova', 'Buy crypto
Leveraged futures
TradFi futures
Crypto lending
Nova card', 'Криптотрейдери, зокрема в Україні та Європі.', 'Crypto traders, including in Ukraine and Europe.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'whitebit.com' OR LOWER(`name`) = 'whitebit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A crypto exchange: buying crypto, leveraged futures, TradFi futures, crypto lending and the Nova card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'WhiteBIT lets you buy crypto without prior experience, trade USDT-margined futures with up to 100x leverage and TradFi futures on traditional instruments. There is crypto lending, QuickSend instant transfers between users, WB Check codes and the Nova card with cashback. High-leverage trading is especially risky. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Buy crypto
Leveraged futures
TradFi futures
Crypto lending
Nova card', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crypto traders, including in Ukraine and Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Торгові комісії', 'Trading fees', NULL, 'one_time', 'Комісії — див. сайт.', 'Fees: see the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Торгові комісії' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Trading fees', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Fees: see the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bybit — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bybit.com' OR LOWER(`name`) = 'bybit')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bybit', NULL, 'https://www.bybit.com', NULL, NULL, 'Біржа для криптовалют і TradFi: спот, деривативи, токенізовані акції, золото й Форекс в одному рахунку.', 'An exchange for crypto and TradFi: spot, derivatives, tokenised stocks, gold and forex in one account.', 'Bybit поєднує криптовалюти й традиційні фінанси: спот, деривативи й TradFi-інструменти (акції США, золото, Форекс, індекси) з розрахунками в USDT. За даними сайту, на біржі понад 3300 криптовалют. Є продукти для заробітку на крипті й фіаті та інвестиції в токенізовані акції й сировину. Деривативи з плечем — високоризиковий інструмент. Криптовалюти дуже волатильні, можна втратити всі вкладені кошти. Доступність послуг залежить від країни проживання.', 'Bybit combines crypto and traditional finance: spot, derivatives and TradFi instruments (US stocks, gold, forex, indices) settled in USDT. According to the site, more than 3,300 cryptocurrencies are listed. There are earn products for crypto and fiat and investments in tokenised stocks and commodities. Leveraged derivatives are high-risk. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', '3300+ криптовалют
Спот і деривативи
TradFi: акції, золото, Форекс
Токенізовані активи', '3,300+ cryptocurrencies
Spot and derivatives
TradFi: stocks, gold, forex
Tokenised assets', 'Активні криптотрейдери.', 'Active crypto traders.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bybit.com' OR LOWER(`name`) = 'bybit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An exchange for crypto and TradFi: spot, derivatives, tokenised stocks, gold and forex in one account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bybit combines crypto and traditional finance: spot, derivatives and TradFi instruments (US stocks, gold, forex, indices) settled in USDT. According to the site, more than 3,300 cryptocurrencies are listed. There are earn products for crypto and fiat and investments in tokenised stocks and commodities. Leveraged derivatives are high-risk. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3,300+ cryptocurrencies
Spot and derivatives
TradFi: stocks, gold, forex
Tokenised assets', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Active crypto traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Торгові комісії', 'Trading fees', NULL, 'one_time', 'Комісії — див. сайт.', 'Fees: see the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Торгові комісії' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Trading fees', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Fees: see the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OKX — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'okx.com' OR LOWER(`name`) = 'okx')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OKX', NULL, 'https://www.okx.com', NULL, NULL, 'Криптобіржа й Web3-платформа: спот, ф''ючерси, опціони, торгові боти, акції за криптовалюту.', 'A crypto exchange and Web3 platform: spot, futures, options, trading bots and stocks for crypto.', 'OKX дозволяє купувати й продавати криптовалюти понад 100 способами оплати, обмінювати їх без торгових комісій, торгувати безстроковими й строковими ф''ючерсами з плечем, опціонами, а також акціями, ETF і сировиною за криптовалюту. Є торгові боти для автоматизації, програми винагород і Web3-гаманець для DeFi. Криптовалюти дуже волатильні, можна втратити всі вкладені кошти. Доступність послуг залежить від країни проживання.', 'OKX lets you buy and sell crypto with 100+ payment methods, convert with zero trading fees, trade perpetual and expiry futures with leverage, options, and stocks, ETFs and commodities using crypto. There are trading bots for automation, reward programmes and a Web3 wallet for DeFi. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'Спот і ф''ючерси
Торгові боти
Акції й ETF за криптовалюту
Web3-гаманець і DeFi', 'Spot and futures
Trading bots
Stocks and ETFs with crypto
Web3 wallet and DeFi', 'Криптотрейдери.', 'Crypto traders.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'okx.com' OR LOWER(`name`) = 'okx') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A crypto exchange and Web3 platform: spot, futures, options, trading bots and stocks for crypto.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OKX lets you buy and sell crypto with 100+ payment methods, convert with zero trading fees, trade perpetual and expiry futures with leverage, options, and stocks, ETFs and commodities using crypto. There are trading bots for automation, reward programmes and a Web3 wallet for DeFi. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Spot and futures
Trading bots
Stocks and ETFs with crypto
Web3 wallet and DeFi', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crypto traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Торгові комісії', 'Trading fees', NULL, 'one_time', 'Конвертація без торгових комісій; інші комісії — див. сайт.', 'Zero-fee conversion; other fees on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Торгові комісії' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Trading fees', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Zero-fee conversion; other fees on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bitstamp — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bitstamp.net' OR LOWER(`name`) = 'bitstamp')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bitstamp', NULL, 'https://www.bitstamp.net', NULL, NULL, 'Криптобіржа з 2011 року (тепер у складі Robinhood) з режимами Basic і Pro та API для алгоритмів.', 'A crypto exchange since 2011 (now part of Robinhood) with Basic and Pro modes and APIs for algorithms.', 'Bitstamp працює з 2011 року й тепер належить Robinhood. Мобільний застосунок має режим Basic для простої купівлі й продажу і Pro для досвідчених трейдерів. Біржа обслуговує приватних клієнтів та інституції, пропонує високу ліквідність і API для власних торгових інтерфейсів і алгоритмічних стратегій. Криптовалюти дуже волатильні, можна втратити всі вкладені кошти. Доступність послуг залежить від країни проживання.', 'Bitstamp has operated since 2011 and is now part of Robinhood. Its mobile app has a Basic mode for simple buying and selling and a Pro mode for experienced traders. The exchange serves individuals and institutions, offering high liquidity and APIs for custom trading interfaces and algorithmic strategies. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'Режими Basic і Pro
API для алгоритмів
Для приватних клієнтів та інституцій
Мобільний застосунок', 'Basic and Pro modes
APIs for algorithms
For individuals and institutions
Mobile app', 'Інвестори й трейдери криптовалют.', 'Crypto investors and traders.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bitstamp.net' OR LOWER(`name`) = 'bitstamp') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A crypto exchange since 2011 (now part of Robinhood) with Basic and Pro modes and APIs for algorithms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bitstamp has operated since 2011 and is now part of Robinhood. Its mobile app has a Basic mode for simple buying and selling and a Pro mode for experienced traders. The exchange serves individuals and institutions, offering high liquidity and APIs for custom trading interfaces and algorithmic strategies. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Basic and Pro modes
APIs for algorithms
For individuals and institutions
Mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crypto investors and traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Торгові комісії', 'Trading fees', NULL, 'one_time', 'Комісії — див. сайт.', 'Fees: see the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Торгові комісії' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Trading fees', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Fees: see the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- 3Commas — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '3commas.io' OR LOWER(`name`) = '3commas')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT '3Commas', NULL, 'https://3commas.io', NULL, NULL, 'Платформа торгових ботів для криптовалют з бектестом, ризик-менеджментом і AI-інструментом QuantPilot.', 'A crypto trading bot platform with backtesting, risk management and the QuantPilot AI tool.', '3Commas з 2017 року автоматизує торгівлю криптовалютами на біржах. Ботів можна налаштувати й протестувати на хвилинних свічках з 11 індикаторами, задати розширене управління ризиками, а Signal Bot приймає стратегії з TradingView на Pine Script через вебхуки. QuantPilot допомагає з AI перетворювати торгові ідеї на стратегії. Боти не гарантують прибутку. Криптовалюти дуже волатильні, можна втратити всі вкладені кошти. Доступність послуг залежить від країни проживання.', 'Since 2017 3Commas has automated crypto trading on exchanges. Bots can be configured and backtested on 1-minute candles with 11 indicators, with advanced risk management, and the Signal Bot accepts TradingView Pine Script strategies via webhooks. QuantPilot uses AI to turn trading ideas into strategies. Bots do not guarantee profit. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'Торгові боти для криптобірж
Бектест на хвилинних свічках
Signal Bot з TradingView
AI-інструмент QuantPilot', 'Crypto exchange bots
Backtesting on 1-minute candles
Signal Bot with TradingView
QuantPilot AI tool', 'Криптотрейдери, що автоматизують стратегії.', 'Crypto traders automating strategies.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '3commas.io' OR LOWER(`name`) = '3commas') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A crypto trading bot platform with backtesting, risk management and the QuantPilot AI tool.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Since 2017 3Commas has automated crypto trading on exchanges. Bots can be configured and backtested on 1-minute candles with 11 indicators, with advanced risk management, and the Signal Bot accepts TradingView Pine Script strategies via webhooks. QuantPilot uses AI to turn trading ideas into strategies. Bots do not guarantee profit. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Crypto exchange bots
Backtesting on 1-minute candles
Signal Bot with TradingView
QuantPilot AI tool', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crypto traders automating strategies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'month', 'Є безкоштовний пробний період; ціни на сайті.', 'Free trial available; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free trial available; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Cryptohopper — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cryptohopper.com' OR LOWER(`name`) = 'cryptohopper')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cryptohopper', NULL, 'https://www.cryptohopper.com', NULL, NULL, 'Налаштовуваний криптобот: DCA, трейлінг, AI, копіювання угод і маркетплейс стратегій.', 'A customisable crypto bot: DCA, trailing, AI, copy trading and a strategy marketplace.', 'Cryptohopper автоматизує торгівлю криптовалютами на основних біржах. Можна налаштувати бота з усередненням (DCA) і трейлінг-ордерами, використати AI-функції, копіювати угоди інших трейдерів або взяти стратегії й сигнали з маркетплейсу. Є можливість підключити власну AI-модель до ринкових даних. Почати можна безкоштовно. Криптовалюти дуже волатильні, можна втратити всі вкладені кошти. Доступність послуг залежить від країни проживання.', 'Cryptohopper automates crypto trading on major exchanges. You can configure a bot with dollar-cost averaging (DCA) and trailing orders, use AI features, copy other traders or pick strategies and signals from the marketplace. You can also connect your own AI model to market data. You can start for free. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'Торгові боти для основних бірж
DCA і трейлінг
AI-функції
Копіювання угод
Маркетплейс стратегій', 'Bots for major exchanges
DCA and trailing
AI features
Copy trading
Strategy marketplace', 'Криптотрейдери.', 'Crypto traders.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cryptohopper.com' OR LOWER(`name`) = 'cryptohopper') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A customisable crypto bot: DCA, trailing, AI, copy trading and a strategy marketplace.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Cryptohopper automates crypto trading on major exchanges. You can configure a bot with dollar-cost averaging (DCA) and trailing orders, use AI features, copy other traders or pick strategies and signals from the marketplace. You can also connect your own AI model to market data. You can start for free. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Bots for major exchanges
DCA and trailing
AI features
Copy trading
Strategy marketplace', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crypto traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний старт.', 'Free to start.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to start.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CoinGecko — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coingecko.com' OR LOWER(`name`) = 'coingecko')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CoinGecko', NULL, 'https://www.coingecko.com', NULL, NULL, 'Ціни, графіки, капіталізація й обсяги торгів криптовалют, трендові монети та API.', 'Crypto prices, charts, market cap and trading volume, trending coins and an API.', 'CoinGecko показує ціни криптовалют у реальному часі, графіки, ринкову капіталізацію й обсяги торгів, нові й трендові монети, лідерів зростання й падіння. Пошук охоплює токени, DEX-пари, біржі, категорії й NFT. Є мобільний застосунок для відстеження цін і портфеля та API для розробників.', 'CoinGecko shows real-time crypto prices, charts, market cap and trading volume, new and trending coins and top gainers and losers. Search covers tokens, DEX pairs, exchanges, categories and NFTs. There is a mobile app for tracking prices and portfolios and an API for developers.', 'Ціни й капіталізація
Трендові й нові монети
Дані про біржі та DEX
Мобільний застосунок і API', 'Prices and market cap
Trending and new coins
Exchange and DEX data
Mobile app and API', 'Усі, хто стежить за криптовалютами.', 'Anyone who follows crypto.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coingecko.com' OR LOWER(`name`) = 'coingecko') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Crypto prices, charts, market cap and trading volume, trending coins and an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CoinGecko shows real-time crypto prices, charts, market cap and trading volume, new and trending coins and top gainers and losers. Search covers tokens, DEX pairs, exchanges, categories and NFTs. There is a mobile app for tracking prices and portfolios and an API for developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Prices and market cap
Trending and new coins
Exchange and DEX data
Mobile app and API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who follows crypto.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'API', 'API', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'API' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'API', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CoinMarketCap — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coinmarketcap.com' OR LOWER(`name`) = 'coinmarketcap')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CoinMarketCap', NULL, 'https://coinmarketcap.com', NULL, NULL, 'Ціни й графіки криптовалют за ринковою капіталізацією, дані про біржі, ETF і API.', 'Crypto prices and charts ranked by market cap, exchange and ETF data and an API.', 'CoinMarketCap надає безкоштовний доступ до поточних і історичних даних про Bitcoin і тисячі альткоїнів, впорядкованих за ринковою капіталізацією. Є огляд ринку, дані про біржі та потоки на них, крипто-ETF, новини й статті, а для розробників — API для криптовалют і DEX.', 'CoinMarketCap gives free access to current and historical data on Bitcoin and thousands of altcoins ranked by market cap. There is a market overview, exchange and flow data, crypto ETFs, news and articles, and for developers a crypto and DEX API.', 'Ціни й капіталізація
Історичні дані
Дані про біржі й ETF
API для криптовалют і DEX', 'Prices and market cap
Historical data
Exchange and ETF data
Crypto and DEX API', 'Усі, хто стежить за криптовалютами.', 'Anyone who follows crypto.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coinmarketcap.com' OR LOWER(`name`) = 'coinmarketcap') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Crypto prices and charts ranked by market cap, exchange and ETF data and an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CoinMarketCap gives free access to current and historical data on Bitcoin and thousands of altcoins ranked by market cap. There is a market overview, exchange and flow data, crypto ETFs, news and articles, and for developers a crypto and DEX API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Prices and market cap
Historical data
Exchange and ETF data
Crypto and DEX API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who follows crypto.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'API', 'API', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'API' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'API', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Coinigy — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coinigy.com' OR LOWER(`name`) = 'coinigy')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Coinigy', NULL, 'https://www.coinigy.com', NULL, NULL, 'Керування криптопортфелем і торгівля на 45+ біржах з одного місця: графіки, сповіщення, ордери.', 'Manage a crypto portfolio and trade on 45+ exchanges from one place: charts, alerts and orders.', 'Coinigy з 2014 року допомагає керувати криптопортфелем і торгувати на понад 45 біржах з одного інтерфейсу. Сервіс цілодобово відстежує біржі й гаманці, має графіки з понад 75 індикаторами, торгівлю без додаткових комісій, стоп-лімітні й інші типи ордерів та серверні сповіщення про ціну й обсяг. Для розробників — API CryptoFeed. Криптовалюти дуже волатильні, можна втратити всі вкладені кошти. Доступність послуг залежить від країни проживання.', 'Since 2014 Coinigy has helped manage crypto portfolios and trade on 45+ exchanges from one interface. It monitors exchanges and wallets 24/7 and offers charts with 75+ indicators, trading with no added fees, stop-limit and other order types and server-side price and volume alerts. Developers get the CryptoFeed API. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', '45+ криптобірж в одному місці
Графіки з 75+ індикаторами
Сповіщення про ціну й обсяг
API CryptoFeed', '45+ crypto exchanges in one place
Charts with 75+ indicators
Price and volume alerts
CryptoFeed API', 'Криптотрейдери з рахунками на кількох біржах.', 'Crypto traders with accounts on several exchanges.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coinigy.com' OR LOWER(`name`) = 'coinigy') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Manage a crypto portfolio and trade on 45+ exchanges from one place: charts, alerts and orders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Since 2014 Coinigy has helped manage crypto portfolios and trade on 45+ exchanges from one interface. It monitors exchanges and wallets 24/7 and offers charts with 75+ indicators, trading with no added fees, stop-limit and other order types and server-side price and volume alerts. Developers get the CryptoFeed API. Crypto assets are highly volatile and you can lose all the money you invest. Availability of services depends on your country of residence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '45+ crypto exchanges in one place
Charts with 75+ indicators
Price and volume alerts
CryptoFeed API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crypto traders with accounts on several exchanges.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sharesight — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sharesight.com' OR LOWER(`name`) = 'sharesight')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sharesight', NULL, 'https://www.sharesight.com', NULL, NULL, 'Трекер портфеля акцій: ціни, угоди, дивіденди, дохідність і податкові звіти з інтеграцією сотень брокерів.', 'A stock portfolio tracker: prices, trades, dividends, performance and tax reports, integrated with hundreds of brokers.', 'Sharesight зводить акції, ETF, дивіденди, дорогоцінні метали й рахунки в різних брокерів і на світових ринках в одне зведення. Він інтегрується з сотнями брокерів і фінансових застосунків, зокрема Robinhood, Charles Schwab та Interactive Brokers, і готує звіти про дохідність і податки. Безкоштовно можна відстежувати до 10 позицій.', 'Sharesight brings stocks, ETFs, dividends, precious metals and accounts at different brokers and global markets into one consolidated view. It integrates with hundreds of brokers and finance apps, including Robinhood, Charles Schwab and Interactive Brokers, and produces performance and tax reports. You can track up to 10 holdings for free.', 'Трекер акцій, ETF і дивідендів
Інтеграція з сотнями брокерів
Звіти про дохідність
Податкові звіти', 'Stock, ETF and dividend tracker
Integration with hundreds of brokers
Performance reports
Tax reports', 'Інвестори з рахунками в кількох брокерів.', 'Investors with accounts at several brokers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sharesight.com' OR LOWER(`name`) = 'sharesight') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A stock portfolio tracker: prices, trades, dividends, performance and tax reports, integrated with hundreds of brokers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sharesight brings stocks, ETFs, dividends, precious metals and accounts at different brokers and global markets into one consolidated view. It integrates with hundreds of brokers and finance apps, including Robinhood, Charles Schwab and Interactive Brokers, and produces performance and tax reports. You can track up to 10 holdings for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stock, ETF and dividend tracker
Integration with hundreds of brokers
Performance reports
Tax reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors with accounts at several brokers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'До 10 позицій безкоштовно.', 'Up to 10 holdings free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Up to 10 holdings free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Snowball Analytics — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'snowball-analytics.com' OR LOWER(`name`) = 'snowball analytics')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Snowball Analytics', NULL, 'https://snowball-analytics.com', NULL, NULL, 'Трекер і аналітика інвестиційного портфеля: акції, ETF і фонди на всіх основних біржах.', 'An investment portfolio tracker and analytics: stocks, ETFs and funds on all major exchanges.', 'Snowball Analytics замінює таблиці Excel для відстеження інвестицій. Він підтримує тисячі акцій, ETF і взаємних фондів на всіх основних біржах і показує аналітику портфеля, дохідність і дивіденди. Є 14-денний безкоштовний пробний період до всіх функцій без картки.', 'Snowball Analytics replaces Excel spreadsheets for tracking investments. It supports thousands of stocks, ETFs and mutual funds on all major exchanges and shows portfolio analytics, performance and dividends. A 14-day free trial of all features is available with no card.', 'Трекер акцій, ETF і фондів
Аналітика портфеля
Дивіденди
14 днів безкоштовно', 'Stock, ETF and fund tracker
Portfolio analytics
Dividends
14-day free trial', 'Довгострокові й дивідендні інвестори.', 'Long-term and dividend investors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'snowball-analytics.com' OR LOWER(`name`) = 'snowball analytics') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An investment portfolio tracker and analytics: stocks, ETFs and funds on all major exchanges.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Snowball Analytics replaces Excel spreadsheets for tracking investments. It supports thousands of stocks, ETFs and mutual funds on all major exchanges and shows portfolio analytics, performance and dividends. A 14-day free trial of all features is available with no card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stock, ETF and fund tracker
Portfolio analytics
Dividends
14-day free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Long-term and dividend investors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний старт.', 'Free to start.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to start.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'month', '14 днів повного доступу безкоштовно; ціни на сайті.', '14 days of full access free; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '14 days of full access free; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Delta — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'delta.app' OR LOWER(`name`) = 'delta')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Delta', NULL, 'https://delta.app', NULL, NULL, 'Застосунок від eToro для відстеження всього портфеля: акції, ETF, фонди й криптовалюти.', 'An app by eToro for tracking your whole portfolio: stocks, ETFs, funds and crypto.', 'Delta від eToro відстежує весь портфель в одному застосунку: акції, взаємні фонди, ETF і криптовалюти. Можна підключити криптогаманці й біржі, щоб консолідувати рахунки, стежити за прибутками й збитками та отримувати персональні сповіщення про ринок і зміни в портфелі.', 'Delta by eToro tracks your whole portfolio in one app: stocks, mutual funds, ETFs and crypto. You can connect crypto wallets and exchanges to consolidate accounts, follow gains and losses and get personalised alerts on market and portfolio changes.', 'Акції, фонди, ETF і крипто
Підключення гаманців і бірж
Прибутки й збитки
Персональні сповіщення', 'Stocks, funds, ETFs and crypto
Wallet and exchange connections
Gains and losses
Personalised alerts', 'Інвестори з різними типами активів.', 'Investors holding different asset types.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'delta.app' OR LOWER(`name`) = 'delta') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app by eToro for tracking your whole portfolio: stocks, ETFs, funds and crypto.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Delta by eToro tracks your whole portfolio in one app: stocks, mutual funds, ETFs and crypto. You can connect crypto wallets and exchanges to consolidate accounts, follow gains and losses and get personalised alerts on market and portfolio changes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stocks, funds, ETFs and crypto
Wallet and exchange connections
Gains and losses
Personalised alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors holding different asset types.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Delta PRO', 'Delta PRO', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Delta PRO' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Delta PRO', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- getquin — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getquin.com' OR LOWER(`name`) = 'getquin')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'getquin', NULL, 'https://www.getquin.com', NULL, NULL, 'AI-платформа для відстеження капіталу, інвестицій і дохідності портфеля з підключенням тисяч провайдерів.', 'An AI wealth tracking platform for net worth, investments and portfolio performance, connecting thousands of providers.', 'getquin допомагає відстежувати чисту вартість активів, інвестиції й дохідність портфеля, планувати пенсію й оптимізувати капітал. Брокерські й банківські рахунки підключаються через захищені API-інтеграції з тисячами провайдерів. Є розширена аналітика, AI-інструменти й послуги консультування. За даними сайту, на платформі відстежується понад €20 млрд.', 'getquin helps you track net worth, investments and portfolio performance, plan for retirement and optimise your wealth. Brokerage and bank accounts connect via secure API integrations with thousands of providers. There are advanced analytics, AI tools and advisory services. According to the site, more than €20B is tracked on the platform.', 'Чиста вартість активів
Підключення тисяч провайдерів
AI-інструменти
Пенсійне планування', 'Net worth tracking
Thousands of provider connections
AI tools
Retirement planning', 'Приватні інвестори в Європі.', 'Individual investors in Europe.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getquin.com' OR LOWER(`name`) = 'getquin') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI wealth tracking platform for net worth, investments and portfolio performance, connecting thousands of providers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'getquin helps you track net worth, investments and portfolio performance, plan for retirement and optimise your wealth. Brokerage and bank accounts connect via secure API integrations with thousands of providers. There are advanced analytics, AI tools and advisory services. According to the site, more than €20B is tracked on the platform.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Net worth tracking
Thousands of provider connections
AI tools
Retirement planning', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Individual investors in Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kubera — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kubera.com' OR LOWER(`name`) = 'kubera')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kubera', NULL, 'https://www.kubera.com', NULL, NULL, 'Баланс усього капіталу: акції, облігації, крипто, нерухомість, авто, борги, у будь-яких валютах.', 'A balance sheet for all your wealth: stocks, bonds, crypto, property, cars and debts in any currency.', 'Kubera відстежує акції, облігації, криптовалюти, альтернативні інвестиції, будинки, авто, сировину й борги в одному місці, підтримує міжнародні банківські й брокерські рахунки та всі валюти. Щоденні знімки показують історію капіталу. Дані можна передати власному AI-агенту як джерело істини. Ціна фіксована — не відсоток від капіталу.', 'Kubera tracks stocks, bonds, crypto, alternatives, homes, cars, commodities and debts in one place, supports international bank and brokerage accounts and all currencies. Daily snapshots show your wealth history. You can point your own AI agent at it as a source of truth. The price is flat, not a percentage of your wealth.', 'Усі активи й борги
Міжнародні рахунки й валюти
Щоденні знімки капіталу
Доступ для AI-агентів', 'All assets and debts
International accounts and currencies
Daily wealth snapshots
Access for AI agents', 'Інвестори з диверсифікованим капіталом.', 'Investors with diversified wealth.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kubera.com' OR LOWER(`name`) = 'kubera') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A balance sheet for all your wealth: stocks, bonds, crypto, property, cars and debts in any currency.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kubera tracks stocks, bonds, crypto, alternatives, homes, cars, commodities and debts in one place, supports international bank and brokerage accounts and all currencies. Daily snapshots show your wealth history. You can point your own AI agent at it as a source of truth. The price is flat, not a percentage of your wealth.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'All assets and debts
International accounts and currencies
Daily wealth snapshots
Access for AI agents', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors with diversified wealth.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Kubera', 'Kubera', 250.00, 'year', '$250 на рік незалежно від розміру капіталу.', '$250 a year regardless of wealth size.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Kubera' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Kubera', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$250 a year regardless of wealth size.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Parqet — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'parqet.com' OR LOWER(`name`) = 'parqet')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Parqet', NULL, 'https://parqet.com', NULL, NULL, 'Трекер дохідності портфеля для акцій, ETF і криптовалют з діаграмами розподілу активів.', 'A portfolio performance tracker for stocks, ETFs and crypto with allocation charts.', 'Parqet візуалізує розвиток капіталу від першої покупки цінного паперу до сьогодні за будь-які періоди. Комбіновані діаграми розподілу показують вкладення за галузями, класами активів, країнами тощо. Сервіс розрахований на інвесторів в акції, ETF і криптовалюти; за даними сайту, ним користуються понад 400 000 людей.', 'Parqet visualises your wealth from your first security purchase to today over any period. Combined allocation charts show your capital by industry, asset class, country and more. The service is designed for stock, ETF and crypto investors; according to the site, more than 400,000 people use it.', 'Дохідність портфеля за будь-який період
Розподіл за галузями й країнами
Акції, ETF, крипто
Веб і мобільний застосунок', 'Portfolio performance for any period
Allocation by industry and country
Stocks, ETFs, crypto
Web and mobile app', 'Інвестори в Німеччині та Європі.', 'Investors in Germany and Europe.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'parqet.com' OR LOWER(`name`) = 'parqet') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A portfolio performance tracker for stocks, ETFs and crypto with allocation charts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Parqet visualises your wealth from your first security purchase to today over any period. Combined allocation charts show your capital by industry, asset class, country and more. The service is designed for stock, ETF and crypto investors; according to the site, more than 400,000 people use it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Portfolio performance for any period
Allocation by industry and country
Stocks, ETFs, crypto
Web and mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors in Germany and Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Portfolio Visualizer — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'portfoliovisualizer.com' OR LOWER(`name`) = 'portfolio visualizer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Portfolio Visualizer', NULL, 'https://www.portfoliovisualizer.com', NULL, NULL, 'Онлайн-аналіз портфеля: бектест розподілу активів, Монте-Карло, оптимізація, факторні регресії.', 'Online portfolio analysis: asset allocation backtests, Monte Carlo, optimisation and factor regressions.', 'Portfolio Visualizer пропонує онлайн-інструменти для бектесту розподілу активів, симуляції Монте-Карло, тактичного розподілу й оптимізації портфеля, а також факторних регресій фондів і ETF, кореляцій і ефективних меж. Сайт наголошує: результати гіпотетичні й не вказують на майбутню дохідність, а сервіс не надає інвестиційних порад.', 'Portfolio Visualizer offers online tools for asset allocation backtesting, Monte Carlo simulation, tactical allocation and portfolio optimisation, plus fund and ETF factor regressions, correlations and efficient frontiers. The site stresses that results are hypothetical and not indicative of future returns, and it does not provide investment advice.', 'Бектест розподілу активів
Симуляція Монте-Карло
Оптимізація портфеля
Факторні регресії', 'Asset allocation backtests
Monte Carlo simulation
Portfolio optimisation
Factor regressions', 'Інвестори, що будують довгострокові портфелі.', 'Investors building long-term portfolios.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'portfoliovisualizer.com' OR LOWER(`name`) = 'portfolio visualizer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online portfolio analysis: asset allocation backtests, Monte Carlo, optimisation and factor regressions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Portfolio Visualizer offers online tools for asset allocation backtesting, Monte Carlo simulation, tactical allocation and portfolio optimisation, plus fund and ETF factor regressions, correlations and efficient frontiers. The site stresses that results are hypothetical and not indicative of future returns, and it does not provide investment advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Asset allocation backtests
Monte Carlo simulation
Portfolio optimisation
Factor regressions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors building long-term portfolios.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до базових функцій.', 'Free access to core features.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to core features.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tradervue — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tradervue.com' OR LOWER(`name`) = 'tradervue')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tradervue', NULL, 'https://www.tradervue.com', NULL, NULL, 'Журнал угод для акцій, ф''ючерсів і Форекс: імпорт угод, аналіз поведінки й нотатки.', 'A trading journal for stocks, futures and forex: trade import, behaviour analysis and notes.', 'Tradervue допомагає відстежувати, аналізувати й покращувати угоди з акціями, ф''ючерсами й Форекс. Угоди імпортуються автоматично, до них можна додавати нотатки й аналізувати закономірності у власній поведінці, щоб зрозуміти, що працює, а що ні. Є безкоштовна версія й платні рівні.', 'Tradervue helps you track, analyse and improve your stock, futures and forex trades. Trades are imported automatically; you can add notes and analyse patterns in your own behaviour to see what works and what does not. There is a free version and paid tiers.', 'Автоматичний імпорт угод
Аналіз закономірностей
Нотатки до угод
Акції, ф''ючерси, Форекс', 'Automatic trade import
Pattern analysis
Trade notes
Stocks, futures, forex', 'Активні трейдери.', 'Active traders.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tradervue.com' OR LOWER(`name`) = 'tradervue') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A trading journal for stocks, futures and forex: trade import, behaviour analysis and notes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tradervue helps you track, analyse and improve your stock, futures and forex trades. Trades are imported automatically; you can add notes and analyse patterns in your own behaviour to see what works and what does not. There is a free version and paid tiers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic trade import
Pattern analysis
Trade notes
Stocks, futures, forex', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Active traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовна версія.', 'Free version.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free version.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Edgewonk — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'edgewonk.com' OR LOWER(`name`) = 'edgewonk')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Edgewonk', NULL, 'https://edgewonk.com', NULL, NULL, 'Автоматизований журнал угод з AI-аналізом для Форекс, акцій, ф''ючерсів, крипто й CFD.', 'An automated trading journal with AI analysis for forex, stocks, futures, crypto and CFDs.', 'Edgewonk — онлайн-журнал угод для Форекс, акцій, ф''ючерсів, криптовалют, опціонів, індексів, сировини й CFD. Угоди імпортуються автоматично, а аналітика й AI-аналіз показують, як покращити вашу перевагу. Звіти налаштовуються під ваш підхід, продукт щотижня оновлюється; за даними сайту, у ньому вже понад 8 мільйонів угод.', 'Edgewonk is an online trading journal for forex, stocks, futures, crypto, options, indices, commodities and CFDs. Trades import automatically, and analytics and AI-driven analysis show how to improve your edge. Reports are customisable to your approach and the product is updated weekly; according to the site, more than 8 million trades have been journaled.', 'Автоматичний імпорт угод
AI-аналіз торгівлі
Налаштовувані звіти
Усі ринки', 'Automatic trade import
AI trading analysis
Customisable reports
All markets', 'Трейдери, що хочуть системно аналізувати свої угоди.', 'Traders who want to analyse their trades systematically.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'edgewonk.com' OR LOWER(`name`) = 'edgewonk') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An automated trading journal with AI analysis for forex, stocks, futures, crypto and CFDs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Edgewonk is an online trading journal for forex, stocks, futures, crypto, options, indices, commodities and CFDs. Trades import automatically, and analytics and AI-driven analysis show how to improve your edge. Reports are customisable to your approach and the product is updated weekly; according to the site, more than 8 million trades have been journaled.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic trade import
AI trading analysis
Customisable reports
All markets', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders who want to analyse their trades systematically.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'year', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TradeZella — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tradezella.com' OR LOWER(`name`) = 'tradezella')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TradeZella', NULL, 'https://www.tradezella.com', NULL, NULL, 'AI-журнал угод: автоматичне ведення, теги сетапів, огляд сесій, імпорт з 500+ брокерів.', 'An AI trading journal: automatic journaling, setup tagging, session reviews, import from 500+ brokers.', 'TradeZella — AI-партнер для трейдера: журнал записує кожну угоду, позначає сетапи й автоматично переглядає торгові сесії, а також допомагає скласти план гри. Імпорт з понад 500 брокерів і понад 50 аналітичних звітів. Журналом можна поділитися з ментором чи торговою групою, щоб отримати зворотний зв''язок.', 'TradeZella is an AI partner for traders: the journal records every trade, tags setups, automatically reviews trading sessions and helps build a game plan. It imports from 500+ brokers and offers 50+ analytics reports. You can share your journal with a mentor or trading group for feedback.', 'AI-огляд торгових сесій
Імпорт з 500+ брокерів
50+ аналітичних звітів
Спільний доступ для ментора', 'AI session reviews
Import from 500+ brokers
50+ analytics reports
Sharing with mentors', 'Активні трейдери.', 'Active traders.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tradezella.com' OR LOWER(`name`) = 'tradezella') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI trading journal: automatic journaling, setup tagging, session reviews, import from 500+ brokers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TradeZella is an AI partner for traders: the journal records every trade, tags setups, automatically reviews trading sessions and helps build a game plan. It imports from 500+ brokers and offers 50+ analytics reports. You can share your journal with a mentor or trading group for feedback.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI session reviews
Import from 500+ brokers
50+ analytics reports
Sharing with mentors', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Active traders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Розширені можливості за підпискою; актуальні ціни — на сайті.', 'Advanced features by subscription; current prices are on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features by subscription; current prices are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kinfo — Торгівля на біржі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kinfo.com' OR LOWER(`name`) = 'kinfo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kinfo', NULL, 'https://kinfo.com', NULL, NULL, 'Безкоштовний перевірений журнал угод, підключений до брокера, із соціальними функціями.', 'A free verified trading journal connected to your broker, with social features.', 'Kinfo підключається до вашого брокера, щоб точно відстежувати, перевіряти й показувати результати торгівлі. Це соціальна платформа: можна стежити за трейдерами з перевіреною статистикою й ділитися своєю. Реєстрація займає менше хвилини й безкоштовна, без картки; є застосунки для iOS та Android.', 'Kinfo connects to your broker to track, verify and share accurate trading performance. It is a social platform: you can follow traders with verified statistics and share your own. Sign-up takes under a minute and is free, no card required; there are iOS and Android apps.', 'Підключення до брокера
Перевірена статистика
Соціальні функції
iOS та Android', 'Broker connection
Verified statistics
Social features
iOS and Android', 'Трейдери, що хочуть прозорої статистики.', 'Traders who want transparent statistics.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-09 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kinfo.com' OR LOWER(`name`) = 'kinfo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free verified trading journal connected to your broker, with social features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kinfo connects to your broker to track, verify and share accurate trading performance. It is a social platform: you can follow traders with verified statistics and share your own. Sign-up takes under a minute and is free, no card required; there are iOS and Android apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Broker connection
Verified statistics
Social features
iOS and Android', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Traders who want transparent statistics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно, без картки.', 'Free, no card required.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, no card required.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Trade Ideas — додатково в «Торгівля на біржі»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Trade Ideas') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- TrendSpider — додатково в «Торгівля на біржі»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('TrendSpider') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- Stock Rover — додатково в «Торгівля на біржі»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Stock Rover') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- Tickeron — додатково в «Торгівля на біржі»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Tickeron') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- PortfolioPilot — додатково в «Торгівля на біржі»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('PortfolioPilot') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- AlphaSense — додатково в «Торгівля на біржі»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('AlphaSense') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- Kavout — додатково в «Торгівля на біржі»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Kavout') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- Magnifi — додатково в «Торгівля на біржі»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Magnifi') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- Robinhood — додатково в «Торгівля на біржі»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Robinhood') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Перевірка: кількість продуктів у підкатегорії
SELECT COUNT(*) AS stock_trading_products FROM `product_subcategories` WHERE `subcategory_id` = @sub;
