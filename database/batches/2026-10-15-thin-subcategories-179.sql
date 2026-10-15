SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-15: заповнення підкатегорій, де було менше 10 продуктів (45 підкатегорій).
-- 179 нових продуктів + 19 наявних лише прив'язано до тонких підкатегорій (тексти не змінюються):
--   Otter.ai, Voiceitt, MongoDB Atlas, Hive Moderation, Resemble AI, HouseCanary, Zillow, Virtual Staging AI, CoinMarketCap, CoinGecko, Hyperice, GOWOD, pliability, STRETCHIT, YouCam Makeup, Fotor, Better Analyst, Ash (Slingshot AI), ElevenLabs.
-- Тексти UA/EN написано заново з офіційних сайтів, звірено 2026-10-15. Ціни не вказано: план «Ціна: див. сайт»;
--   Free — лише де офіційний сайт підтверджує безкоштовний доступ. Медичні описи — без порад і обіцянок результату;
--   релігійні — нейтральні, за офіційними ресурсами організацій. Крипто — дані, не інвестиційні поради.
-- Пропущено: TroveSkin (сайт мертвий), Docus (змінив профіль), Stardust, Caria, TherapyNotes, Autonotes, Arkham, Kaito, FlowGPT, Lexica,
--   Paradot, Friend, Notion Mail, Guru.com, Epique AI, Google Career Certificates (сторінки без опису/недоступні або за антибот-перевіркою),
--   Arc (лише оновлення Chromium), Isha Outreach (= наявний Save Soil), HK Taoist Association (сайт на оновленні), Hi Waifu (романтичний профіль).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою; категорії/підкатегорії — за slug.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Petralex — Для глухих і слабочуючих
--   Otter.ai — Для глухих і слабочуючих (наявний, прив'язка)
--   Look to Speak — Керування без рук
--   Quha Zono — Керування без рук
--   Voiceitt — Керування без рук (наявний, прив'язка)
--   HireVue — HR і рекрутинг
--   Paradox — HR і рекрутинг
--   Textio — HR і рекрутинг
--   Manatal — HR і рекрутинг
--   PeoplePerHour — Фриланс
--   Kabanchik — Фриланс
--   Workana — Фриланс
--   Truelancer — Фриланс
--   Freelance.ua — Фриланс
--   Tor Browser — VPN і приватність
--   Windscribe — VPN і приватність
--   Trend Micro — Антивіруси та захист пристроїв
--   Emsisoft — Антивіруси та захист пристроїв
--   Lookout — Антивіруси та захист пристроїв
--   Firefox Relay — Захист особистих даних
--   SimpleLogin — Захист особистих даних
--   Privacy Bee — Захист особистих даних
--   Kanary — Захист особистих даних
--   Realtime Colors — Кольори
--   Color Hunt — Кольори
--   DSPy — Фреймворки для LLM-застосунків
--   Semantic Kernel — Фреймворки для LLM-застосунків
--   Pydantic AI — Фреймворки для LLM-застосунків
--   Opik — Моніторинг і оцінка LLM
--   Galileo — Моніторинг і оцінка LLM
--   Evidently AI — Моніторинг і оцінка LLM
--   pgvector — Векторні бази даних
--   LanceDB — Векторні бази даних
--   Vespa — Векторні бази даних
--   turbopuffer — Векторні бази даних
--   Zilliz Cloud — Векторні бази даних
--   MongoDB Atlas — Векторні бази даних (наявний, прив'язка)
--   Prometheus — Сертифікати
--   Hive Moderation — Безпека даних (наявний, прив'язка)
--   Resemble AI — Безпека даних (наявний, прив'язка)
--   Styldod — Нерухомість
--   HouseCanary — Нерухомість (наявний, прив'язка)
--   Zillow — Нерухомість (наявний, прив'язка)
--   Virtual Staging AI — Нерухомість (наявний, прив'язка)
--   Dune — Крипто та Web3
--   Token Terminal — Крипто та Web3
--   DefiLlama — Крипто та Web3
--   Santiment — Крипто та Web3
--   Chainalysis — Крипто та Web3
--   Glassnode — Крипто та Web3
--   Etherscan — Крипто та Web3
--   CoinMarketCap — Крипто та Web3 (наявний, прив'язка)
--   CoinGecko — Крипто та Web3 (наявний, прив'язка)
--   Bend — Масаж і відновлення
--   Compex — Масаж і відновлення
--   Renpho — Масаж і відновлення
--   Hyperice — Масаж і відновлення (наявний, прив'язка)
--   GOWOD — Масаж і відновлення (наявний, прив'язка)
--   pliability — Масаж і відновлення (наявний, прив'язка)
--   STRETCHIT — Масаж і відновлення (наявний, прив'язка)
--   BetterSleep — Сон
--   SleepScore — Сон
--   Loóna — Сон
--   Buoy Health — Перевірка симптомів
--   Ubie — Перевірка симптомів
--   Infermedica — Перевірка симптомів
--   Mediktor — Перевірка симптомів
--   Doctronic — Перевірка симптомів
--   Miiskin — Догляд за шкірою
--   Proven Skincare — Догляд за шкірою
--   Dermatica — Догляд за шкірою
--   Skin Bliss — Догляд за шкірою
--   First Derm — Догляд за шкірою
--   YouCam Makeup — Догляд за шкірою (наявний, прив'язка)
--   Ovia — Жіноче здоров'я
--   Maven Clinic — Жіноче здоров'я
--   Perifit — Жіноче здоров'я
--   Balance — Жіноче здоров'я
--   Premom — Жіноче здоров'я
--   Elvie — Жіноче здоров'я
--   Mira — Жіноче здоров'я
--   Oova — Жіноче здоров'я
--   SimplePractice — Інструменти для психологів
--   Eleos Health — Інструменти для психологів
--   Supanote — Інструменти для психологів
--   TheraNest — Інструменти для психологів
--   Jane — Інструменти для психологів
--   Removal.AI — Видалення фону
--   Slazzer — Видалення фону
--   Erase.bg — Видалення фону
--   PhotoScissors — Видалення фону
--   Fotor — Видалення фону (наявний, прив'язка)
--   Decktopus — Презентації
--   SlidesAI — Презентації
--   Prezi — Презентації
--   Better Analyst — Таблиці (наявний, прив'язка)
--   SheetAI — Таблиці
--   Coefficient — Таблиці
--   Wanderlog — Подорожі
--   TripIt — Подорожі
--   Hopper — Подорожі
--   GuideGeek — Подорожі
--   KAYAK — Подорожі
--   Tripadvisor — Подорожі
--   Lucidchart — Дошки та діаграми
--   Excalidraw — Дошки та діаграми
--   FigJam — Дошки та діаграми
--   Eraser — Дошки та діаграми
--   Spark Mail — Поштові асистенти
--   Canary Mail — Поштові асистенти
--   SaneBox — Поштові асистенти
--   Mailbutler — Поштові асистенти
--   MailMaestro — Поштові асистенти
--   Ellie — Поштові асистенти
--   Gmelius — Поштові асистенти
--   ChatGPT Atlas — AI-браузери
--   Microsoft Edge — AI-браузери
--   Fellou — AI-браузери
--   Sigma AI Browser — AI-браузери
--   Opera One — AI-браузери
--   Taoist Sanctuary of San Diego — Даосизм і конфуціанство
--   Abode of the Eternal Tao — Даосизм і конфуціанство
--   Scientology Newsroom — Саєнтологія
--   Freedom Magazine — Саєнтологія
--   Applied Scholastics — Саєнтологія
--   Peace of Mind TV — Брахма Кумаріс
--   Brahma Kumaris South Africa — Брахма Кумаріс
--   Global Retreat Centre — Брахма Кумаріс
--   Maharishi International University — Трансцендентальна медитація
--   Transcendental Meditation UK — Трансцендентальна медитація
--   Maharishi School — Трансцендентальна медитація
--   OSHO Times — Ошо
--   OSHO Meditation Resort — Ошо
--   Osho News — Ошо
--   Sahaja Yoga Australia — Сахаджа-йога
--   Sahaja Yoga India — Сахаджа-йога
--   Sahaja Yoga Canada — Сахаджа-йога
--   Sahaja Yoga Germany — Сахаджа-йога
--   Eckankar Australia — Еканкар
--   Eckankar Nigeria — Еканкар
--   Eckankar Germany — Еканкар
--   Eckankar Netherlands — Еканкар
--   Eckankar Switzerland — Еканкар
--   Eckankar Sweden — Еканкар
--   Eckankar Explore — Еканкар
--   Aga Khan Development Network — Ісмаїліти
--   Aga Khan Foundation — Ісмаїліти
--   Aga Khan University — Ісмаїліти
--   Aga Khan Museum — Ісмаїліти
--   Global Centre for Pluralism — Ісмаїліти
--   Aga Khan Trust for Culture — Ісмаїліти
--   University of Central Asia — Ісмаїліти
--   The Christian Science Monitor — Християнська наука
--   The Herald of Christian Science — Християнська наука
--   Principia — Християнська наука
--   The Mother Church (Boston) — Християнська наука
--   Isha Yoga Center — Isha Foundation (Садгуру)
--   Isha Vidhya — Isha Foundation (Садгуру)
--   Self-Realization Magazine — Self-Realization Fellowship (Йогананда)
--   SRF Lake Shrine — Self-Realization Fellowship (Йогананда)
--   SRF Encinitas Temple — Self-Realization Fellowship (Йогананда)
--   SRF Hollywood Temple — Self-Realization Fellowship (Йогананда)
--   IAHV — Мистецтво життя (Art of Living)
--   Sri Sri University — Мистецтво життя (Art of Living)
--   Sri Sri Tattva — Мистецтво життя (Art of Living)
--   Sri Sri School of Yoga — Мистецтво життя (Art of Living)
--   Art of Living USA — Мистецтво життя (Art of Living)
--   Sudarshan Kriya (SKY) — Мистецтво життя (Art of Living)
--   DeepL Write — Перефразування і граматика
--   Ginger — Перефразування і граматика
--   Paperpal — Перефразування і граматика
--   Trinka — Перефразування і граматика
--   Scribbr Paraphrasing Tool — Перефразування і граматика
--   PromptPerfect — Генератори промптів
--   Promptitude — Генератори промптів
--   Snack Prompt — Генератори промптів
--   PromptHero — Генератори промптів
--   prompts.chat — Генератори промптів
--   Prompt Engineering Guide — Генератори промптів
--   Pi — AI-компаньйони
--   Kindroid — AI-компаньйони
--   Nomi — AI-компаньйони
--   Talkie — AI-компаньйони
--   Tolan — AI-компаньйони
--   Sesame — AI-компаньйони
--   Ash (Slingshot AI) — AI-компаньйони (наявний, прив'язка)
--   Kuki — AI-компаньйони
--   Google Document AI — Розпізнавання тексту (OCR)
--   Amazon Textract — Розпізнавання тексту (OCR)
--   Azure AI Document Intelligence — Розпізнавання тексту (OCR)
--   Mistral OCR — Розпізнавання тексту (OCR)
--   Tesseract OCR — Розпізнавання тексту (OCR)
--   Rossum — Розпізнавання тексту (OCR)
--   Docsumo — Розпізнавання тексту (OCR)
--   PolyAI — Голосові агенти
--   Thoughtly — Голосові агенти
--   Cognigy — Голосові агенти
--   ElevenLabs — Голосові агенти (наявний, прив'язка)
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);

-- =================== Для глухих і слабочуючих (accessibility/deaf-hard-of-hearing) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'accessibility' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'deaf-hard-of-hearing' LIMIT 1);

-- Petralex
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petralex.pro' OR LOWER(`name`) = 'petralex')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Petralex', NULL, 'https://petralex.pro/', NULL, NULL, 'Застосунок-підсилювач звуку для смартфона: налаштовує звук під ваш слух і працює з будь-якими навушниками.', 'A smartphone sound-amplifier app that tunes audio to your hearing and works with any earphones.', 'Petralex перетворює смартфон на персональний підсилювач звуку. Застосунок проводить тест слуху, будує профіль і підсилює мовлення й навколишні звуки через звичайні дротові чи бездротові навушники. Є режим Live Listen і регулювання гучності для різних ситуацій. Завантаження безкоштовне, розширені функції доступні в Premium. Застосунок не замінює консультацію лікаря-сурдолога.', 'Petralex turns a smartphone into a personal sound amplifier. The app runs a hearing test, builds a profile and boosts speech and surrounding sounds through ordinary wired or wireless earphones. It includes a Live Listen mode and volume control for different situations. The download is free, with extended features in Premium. The app does not replace a consultation with a hearing specialist.', 'Тест слуху й персональний профіль
Підсилення звуку через будь-які навушники
Режим Live Listen
Безкоштовне завантаження, Premium-функції', 'Hearing test and personal profile
Sound boost through any earphones
Live Listen mode
Free download with Premium features', 'Людям зі зниженим слухом, які хочуть простий перший крок до кращого чуття.', 'People with reduced hearing who want a simple first step toward hearing better.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petralex.pro' OR LOWER(`name`) = 'petralex') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A smartphone sound-amplifier app that tunes audio to your hearing and works with any earphones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Petralex turns a smartphone into a personal sound amplifier. The app runs a hearing test, builds a profile and boosts speech and surrounding sounds through ordinary wired or wireless earphones. It includes a Live Listen mode and volume control for different situations. The download is free, with extended features in Premium. The app does not replace a consultation with a hearing specialist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hearing test and personal profile
Sound boost through any earphones
Live Listen mode
Free download with Premium features', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with reduced hearing who want a simple first step toward hearing better.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Otter.ai (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'otter.ai' OR LOWER(`name`) = 'otter.ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- =================== Керування без рук (accessibility/hands-free) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'accessibility' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hands-free' LIMIT 1);

-- Look to Speak
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'experiments.withgoogle.com/looktospeak' OR LOWER(`name`) = 'look to speak')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Look to Speak', NULL, 'https://experiments.withgoogle.com/looktospeak', NULL, NULL, 'Безкоштовний Android-застосунок Google: погляд очима вибирає готові фрази, і телефон промовляє їх уголос.', 'A free Google Android app: eye movements select pre-written phrases and the phone speaks them aloud.', 'Look to Speak створили художниця Сара Езекіль, яка живе з хворобою моторних нейронів, і Google Creative Lab. Застосунок використовує фронтальну камеру телефона: людина дивиться ліворуч, праворуч або вгору, щоб звузити список і вибрати фразу, яку телефон озвучує. Фрази можна редагувати під себе. Застосунок призначений для людей із порушеннями мовлення та рухів.', 'Look to Speak was created by artist Sarah Ezekiel, who lives with motor neurone disease, together with Google Creative Lab. The app uses the phone’s front camera: the person looks left, right or up to narrow the list and choose a phrase, which the phone then speaks. Phrases can be edited to suit the user. It is designed for people with speech and motor impairments.', 'Керування поглядом через фронтальну камеру
Озвучення вибраних фраз
Власний список фраз
Безкоштовно для Android', 'Eye-gaze control via the front camera
Speaks the selected phrases
Custom phrase list
Free for Android', 'Людям із порушеннями мовлення та рухів, їхнім рідним і логопедам.', 'People with speech and motor impairments, their families and speech therapists.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'experiments.withgoogle.com/looktospeak' OR LOWER(`name`) = 'look to speak') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free Google Android app: eye movements select pre-written phrases and the phone speaks them aloud.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Look to Speak was created by artist Sarah Ezekiel, who lives with motor neurone disease, together with Google Creative Lab. The app uses the phone’s front camera: the person looks left, right or up to narrow the list and choose a phrase, which the phone then speaks. Phrases can be edited to suit the user. It is designed for people with speech and motor impairments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Eye-gaze control via the front camera
Speaks the selected phrases
Custom phrase list
Free for Android', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with speech and motor impairments, their families and speech therapists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Quha Zono
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'quha.com' OR LOWER(`name`) = 'quha zono')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Quha Zono', NULL, 'https://www.quha.com/', NULL, NULL, 'Гіроскопічна бездротова «головна миша»: курсор керується рухами голови, без використання рук.', 'A gyroscopic wireless head mouse: the cursor follows head movements, no hands needed.', 'Quha Zono X — мініатюрна Bluetooth-миша, яку кріплять на голову або окуляри. Рухи голови переміщують курсор на комп’ютері чи мобільному пристрої, а кліки можна робити через затримку курсора, кнопку-перемикач або безконтактний «пуф»-перемикач Quha Sento. Пристрій отримав нагороду Zero Project 2025 за внесок у доступність технологій.', 'Quha Zono X is a tiny Bluetooth mouse worn on the head or glasses. Head movements move the cursor on a computer or mobile device, and clicks can be made by dwell, a switch, or the contactless Quha Sento puff switch. The device received a Zero Project 2025 award for accessible technology.', 'Керування курсором рухами голови
Bluetooth для комп’ютера й мобільних пристроїв
Клік затримкою або перемикачем
Безконтактний перемикач Quha Sento', 'Cursor control by head movement
Bluetooth for computers and mobile devices
Dwell or switch clicking
Contactless Quha Sento switch', 'Людям, які не можуть користуватися руками, і фахівцям з асистивних технологій.', 'People who cannot use their hands and assistive-technology professionals.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'quha.com' OR LOWER(`name`) = 'quha zono') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A gyroscopic wireless head mouse: the cursor follows head movements, no hands needed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Quha Zono X is a tiny Bluetooth mouse worn on the head or glasses. Head movements move the cursor on a computer or mobile device, and clicks can be made by dwell, a switch, or the contactless Quha Sento puff switch. The device received a Zero Project 2025 award for accessible technology.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cursor control by head movement
Bluetooth for computers and mobile devices
Dwell or switch clicking
Contactless Quha Sento switch', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who cannot use their hands and assistive-technology professionals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Voiceitt (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voiceitt.com' OR LOWER(`name`) = 'voiceitt') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- =================== HR і рекрутинг (business-marketing/hr-recruiting) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'business-marketing' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hr-recruiting' LIMIT 1);

-- HireVue
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hirevue.com' OR LOWER(`name`) = 'hirevue')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HireVue', NULL, 'https://www.hirevue.com/', NULL, NULL, 'Платформа для відеоспівбесід, оцінювання навичок і AI-скринінгу кандидатів.', 'A platform for video interviews, skills assessments and AI candidate screening.', 'HireVue поєднує асинхронні й живі відеоспівбесіди, тести навичок, ігрові оцінювання та чат-агента на сайті компанії, який допомагає кандидатам знайти відповідну вакансію. Рекомендації супроводжуються поясненням, на основі яких відповідей їх зроблено. Платформа працює з великими обсягами найму й інтегрується з ATS.', 'HireVue combines on-demand and live video interviews, skills tests, game-based assessments and a careers-site chat agent that helps candidates find the right role. Recommendations come with the evidence behind them. The platform handles high-volume hiring and integrates with ATS systems.', 'Відеоспівбесіди наживо й у записі
Тести навичок і симуляції
AI-скринінг 24/7
Чат-агент для кандидатів на сайті', 'Live and on-demand video interviews
Skills tests and simulations
24/7 AI screening
Careers-site chat agent for candidates', 'HR-командам і рекрутерам середніх і великих компаній.', 'HR teams and recruiters at mid-size and large companies.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hirevue.com' OR LOWER(`name`) = 'hirevue') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform for video interviews, skills assessments and AI candidate screening.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'HireVue combines on-demand and live video interviews, skills tests, game-based assessments and a careers-site chat agent that helps candidates find the right role. Recommendations come with the evidence behind them. The platform handles high-volume hiring and integrates with ATS systems.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live and on-demand video interviews
Skills tests and simulations
24/7 AI screening
Careers-site chat agent for candidates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'HR teams and recruiters at mid-size and large companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Paradox
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'paradox.ai' OR LOWER(`name`) = 'paradox')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Paradox', NULL, 'https://www.paradox.ai/', NULL, NULL, 'Розмовний AI-асистент Olivia, що веде кандидатів через найм: від запитань до призначення співбесід.', 'A conversational AI assistant, Olivia, that guides candidates through hiring, from questions to interview scheduling.', 'Paradox автоматизує рутину масового найму через двосторонні повідомлення: асистент Olivia відповідає кандидатам, проводить попередній відбір і сам призначає співбесіди. Платформа орієнтована на мобільний досвід лінійного персоналу, має інтерактивне знайомство з вакансією і працює поверх наявної HR-системи, зокрема з Indeed Apply.', 'Paradox automates the routine of high-volume hiring through two-way messaging: the Olivia assistant answers candidates, pre-screens them and schedules interviews on its own. The platform is mobile-first for frontline workers, offers an immersive job preview and works on top of the existing HR system, including Indeed Apply.', 'AI-асистент Olivia для кандидатів
Автоматичне призначення співбесід
Мобільний досвід для лінійного персоналу
Інтеграції з HR-системами та Indeed', 'Olivia AI assistant for candidates
Automatic interview scheduling
Mobile-first experience for frontline roles
Integrations with HR systems and Indeed', 'Компаніям із масовим наймом: ритейлу, ресторанам, логістиці.', 'Companies with high-volume hiring: retail, restaurants, logistics.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'paradox.ai' OR LOWER(`name`) = 'paradox') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A conversational AI assistant, Olivia, that guides candidates through hiring, from questions to interview scheduling.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Paradox automates the routine of high-volume hiring through two-way messaging: the Olivia assistant answers candidates, pre-screens them and schedules interviews on its own. The platform is mobile-first for frontline workers, offers an immersive job preview and works on top of the existing HR system, including Indeed Apply.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Olivia AI assistant for candidates
Automatic interview scheduling
Mobile-first experience for frontline roles
Integrations with HR systems and Indeed', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Companies with high-volume hiring: retail, restaurants, logistics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Textio
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'textio.com' OR LOWER(`name`) = 'textio')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Textio', NULL, 'https://textio.com/', NULL, NULL, 'AI для текстів вакансій, структурованих співбесід і відгуків про роботу працівників.', 'AI for job posts, structured interviews and employee performance feedback.', 'Textio допомагає писати оголошення про вакансії без упередженої лексики й у стилі бренду роботодавця, вирівнювати питання співбесід під вимоги ролі та фіксувати відгуки про кожного кандидата. Друга частина продукту підказує менеджерам, як давати конкретний відгук для розвитку працівника. Працює на сайті Textio або всередині ATS і систем управління ефективністю.', 'Textio helps write job posts without biased language and in the employer’s brand voice, align interview questions with role requirements and record feedback on every candidate. Another part of the product coaches managers to give specific, growth-oriented feedback. It works on textio.com or inside ATS and performance-management tools.', 'Перевірка текстів вакансій на упередженість
Структуровані співбесіди
Підказки для відгуків менеджерів
Інтеграція з ATS', 'Bias checks for job posts
Structured interviews
Feedback guidance for managers
ATS integration', 'Рекрутерам, HR і керівникам команд.', 'Recruiters, HR and team managers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'textio.com' OR LOWER(`name`) = 'textio') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI for job posts, structured interviews and employee performance feedback.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Textio helps write job posts without biased language and in the employer’s brand voice, align interview questions with role requirements and record feedback on every candidate. Another part of the product coaches managers to give specific, growth-oriented feedback. It works on textio.com or inside ATS and performance-management tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Bias checks for job posts
Structured interviews
Feedback guidance for managers
ATS integration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Recruiters, HR and team managers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Manatal
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'manatal.com' OR LOWER(`name`) = 'manatal')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Manatal', NULL, 'https://www.manatal.com/', NULL, NULL, 'ATS і CRM для рекрутингу з AI-рекомендаціями кандидатів і AI-інтерв’юером.', 'An ATS and recruitment CRM with AI candidate recommendations and an AI interviewer.', 'Manatal — система відстеження кандидатів і CRM для рекрутингових агенцій та компаній. Вона збирає кандидатів із LinkedIn, сайтів вакансій і рекомендацій, збагачує профілі даними поза резюме, а AI підбирає відповідних кандидатів. Новий AI Interviewer може проводити співбесіди з багатьма кандидатами одночасно. Є 14-денний пробний період.', 'Manatal is an applicant tracking system and CRM for recruitment agencies and companies. It sources candidates from LinkedIn, job boards and referrals, enriches profiles beyond the résumé and uses AI to suggest suitable candidates. The new AI Interviewer can interview many candidates at once. There is a 14-day free trial.', 'ATS і рекрутингова CRM
AI-рекомендації кандидатів
AI Interviewer
Пошук у LinkedIn і на сайтах вакансій', 'ATS and recruitment CRM
AI candidate recommendations
AI Interviewer
Sourcing from LinkedIn and job boards', 'Рекрутинговим агенціям, HR-командам і незалежним рекрутерам.', 'Recruitment agencies, HR teams and independent recruiters.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'manatal.com' OR LOWER(`name`) = 'manatal') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An ATS and recruitment CRM with AI candidate recommendations and an AI interviewer.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Manatal is an applicant tracking system and CRM for recruitment agencies and companies. It sources candidates from LinkedIn, job boards and referrals, enriches profiles beyond the résumé and uses AI to suggest suitable candidates. The new AI Interviewer can interview many candidates at once. There is a 14-day free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'ATS and recruitment CRM
AI candidate recommendations
AI Interviewer
Sourcing from LinkedIn and job boards', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Recruitment agencies, HR teams and independent recruiters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Фриланс (career/freelance) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'career' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'freelance' LIMIT 1);

-- PeoplePerHour
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'peopleperhour.com' OR LOWER(`name`) = 'peopleperhour')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PeoplePerHour', NULL, 'https://www.peopleperhour.com/', NULL, NULL, 'Британська біржа фрилансу: можна опублікувати проєкт або купити готову послугу з фіксованою ціною.', 'A UK freelance marketplace: post a project or buy ready-made services at a fixed price.', 'PeoplePerHour з’єднує клієнтів і фрилансерів у дизайні, розробці, маркетингу, текстах, бухгалтерії та інших напрямах. Кожного фрилансера перевіряють вручну. Клієнт може безкоштовно опублікувати проєкт і отримати пропозиції, написати фрилансерам напряму або купити готовий пакет послуги з фіксованою ціною. Близько 60% користувачів — із Великої Британії, але платформа працює у понад 100 країнах.', 'PeoplePerHour connects clients and freelancers in design, development, marketing, writing, accounting and more. Every freelancer is hand-reviewed. Clients can post a project for free and receive proposals, contact freelancers directly, or buy a ready-made fixed-price service package. About 60% of users are UK-based, but the platform works in over 100 countries.', 'Безкоштовна публікація проєкту
Готові послуги з фіксованою ціною
Ручна перевірка фрилансерів
Користувачі у 100+ країнах', 'Free project posting
Fixed-price ready-made services
Hand-reviewed freelancers
Users in 100+ countries', 'Фрилансерам і малому бізнесу, особливо з Великої Британії.', 'Freelancers and small businesses, especially in the UK.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'peopleperhour.com' OR LOWER(`name`) = 'peopleperhour') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A UK freelance marketplace: post a project or buy ready-made services at a fixed price.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PeoplePerHour connects clients and freelancers in design, development, marketing, writing, accounting and more. Every freelancer is hand-reviewed. Clients can post a project for free and receive proposals, contact freelancers directly, or buy a ready-made fixed-price service package. About 60% of users are UK-based, but the platform works in over 100 countries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free project posting
Fixed-price ready-made services
Hand-reviewed freelancers
Users in 100+ countries', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Freelancers and small businesses, especially in the UK.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kabanchik
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabanchik.ua' OR LOWER(`name`) = 'kabanchik')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kabanchik', NULL, 'https://kabanchik.ua/', NULL, NULL, 'Український сервіс замовлення послуг: понад 100 000 перевірених фахівців для побутових і бізнес-завдань.', 'A Ukrainian service marketplace with 100,000+ verified specialists for household and business tasks.', 'Kabanchik.ua допомагає знайти виконавця для побутових і бізнес-завдань: майстрів, прибиральників, кур’єрів, перевізників, а також фрилансерів для дизайну, розробки, SMM і технічних завдань. Замовник описує завдання, отримує пропозиції від фахівців і обирає виконавця за відгуками. Фахівці можуть знаходити тут замовлення.', 'Kabanchik.ua helps find someone for household and business tasks: handymen, cleaners, couriers, movers, as well as freelancers for design, development, social media and technical work. The customer describes the task, receives offers and chooses a specialist by reviews. Specialists can find orders here too.', 'Понад 100 000 перевірених фахівців
Побутові й бізнес-завдання
Відгуки про виконавців
Замовлення для фрилансерів', '100,000+ verified specialists
Household and business tasks
Reviews of specialists
Orders for freelancers', 'Жителям України, яким потрібен виконавець, і фахівцям, які шукають замовлення.', 'People in Ukraine looking for a specialist, and specialists looking for orders.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabanchik.ua' OR LOWER(`name`) = 'kabanchik') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Ukrainian service marketplace with 100,000+ verified specialists for household and business tasks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kabanchik.ua helps find someone for household and business tasks: handymen, cleaners, couriers, movers, as well as freelancers for design, development, social media and technical work. The customer describes the task, receives offers and chooses a specialist by reviews. Specialists can find orders here too.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '100,000+ verified specialists
Household and business tasks
Reviews of specialists
Orders for freelancers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Ukraine looking for a specialist, and specialists looking for orders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Workana
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'workana.com' OR LOWER(`name`) = 'workana')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Workana', NULL, 'https://www.workana.com/', NULL, NULL, 'Платформа віддаленого найму фрилансерів і розробників у Латинській Америці.', 'A remote-hiring platform for freelancers and developers in Latin America.', 'Workana з’єднує компанії з фрилансерами різних напрямів і попередньо відібраними та сертифікованими розробниками, які працюють у часовому поясі замовника. Можна наймати на проєкт із фіксованою метою, погодинно або на визначений період. Фахівці отримують оплату в місцевій валюті чи доларах і можуть працювати з компаніями зі США.', 'Workana connects companies with freelancers across disciplines and with pre-selected, certified developers who work in the client’s time zone. Hiring can be goal-based, hourly or for a set period. Professionals are paid in local currency or USD and can work for US companies.', 'Фрилансери різних напрямів
Сертифіковані розробники на період
Погодинна або проєктна оплата
Оплата в місцевій валюті чи USD', 'Freelancers across disciplines
Certified developers for a set period
Hourly or goal-based work
Payment in local currency or USD', 'Компаніям, що наймають віддалено, і фрилансерам Латинської Америки.', 'Companies hiring remotely and Latin American freelancers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'workana.com' OR LOWER(`name`) = 'workana') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A remote-hiring platform for freelancers and developers in Latin America.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Workana connects companies with freelancers across disciplines and with pre-selected, certified developers who work in the client’s time zone. Hiring can be goal-based, hourly or for a set period. Professionals are paid in local currency or USD and can work for US companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Freelancers across disciplines
Certified developers for a set period
Hourly or goal-based work
Payment in local currency or USD', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Companies hiring remotely and Latin American freelancers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Truelancer
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'truelancer.com' OR LOWER(`name`) = 'truelancer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Truelancer', NULL, 'https://www.truelancer.com/', NULL, NULL, 'Індійська біржа фрилансу з безпечним депозитом, а також напрямами повної зайнятості й AI-тренування.', 'An Indian freelance marketplace with Safe Deposit, plus full-time hiring and AI-training gigs.', 'Truelancer дозволяє опублікувати проєкт, порівняти пропозиції, профілі й відгуки фрилансерів, провести співбесіду та доручити роботу. Оплата резервується через Safe Deposit і переказується виконавцю після прийняття роботи. Крім фрилансу, платформа має окремі розділи для повної зайнятості й завдань з навчання AI-моделей.', 'Truelancer lets you post a project, compare proposals, profiles and reviews, interview freelancers and award the work. Payment is held in Safe Deposit and released once the work is accepted. Besides freelance projects, the platform has separate sections for full-time hiring and AI-training gigs.', 'Публікація проєкту й порівняння пропозицій
Безпечний депозит Safe Deposit
Чат і обмін файлами
Розділи повної зайнятості та AI-тренування', 'Project posting and proposal comparison
Safe Deposit escrow
Chat and file sharing
Full-time and AI-training sections', 'Фрилансерам і замовникам, зокрема з Індії.', 'Freelancers and clients, especially in India.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'truelancer.com' OR LOWER(`name`) = 'truelancer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An Indian freelance marketplace with Safe Deposit, plus full-time hiring and AI-training gigs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Truelancer lets you post a project, compare proposals, profiles and reviews, interview freelancers and award the work. Payment is held in Safe Deposit and released once the work is accepted. Besides freelance projects, the platform has separate sections for full-time hiring and AI-training gigs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Project posting and proposal comparison
Safe Deposit escrow
Chat and file sharing
Full-time and AI-training sections', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Freelancers and clients, especially in India.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Freelance.ua
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freelance.ua' OR LOWER(`name`) = 'freelance.ua')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Freelance.ua', NULL, 'https://freelance.ua/', NULL, NULL, 'Українська фриланс-біржа: опис завдання, пропозиції виконавців, резервування коштів і відгуки.', 'A Ukrainian freelance exchange: task brief, offers from freelancers, funds reservation and reviews.', 'Freelance.ua — українська біржа віддаленої роботи. Замовник детально описує завдання, порівнює пропозиції фрилансерів за ціною, термінами, портфоліо й репутацією, резервує кошти й обговорює деталі в чаті. Після виконання він підтверджує роботу й залишає відгук. Фрилансери-початківці можуть знайти тут перших клієнтів.', 'Freelance.ua is a Ukrainian remote-work exchange. A client describes the task, compares freelancers’ offers by price, timing, portfolio and reputation, reserves funds and discusses details in chat. Afterwards the client confirms completion and leaves a review. Beginner freelancers can find their first clients here.', 'Пропозиції з цінами й термінами
Резервування коштів
Чат із виконавцем
Відгуки й репутація', 'Offers with prices and deadlines
Funds reservation
Chat with the freelancer
Reviews and reputation', 'Українським фрилансерам і замовникам.', 'Ukrainian freelancers and clients.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freelance.ua' OR LOWER(`name`) = 'freelance.ua') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Ukrainian freelance exchange: task brief, offers from freelancers, funds reservation and reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Freelance.ua is a Ukrainian remote-work exchange. A client describes the task, compares freelancers’ offers by price, timing, portfolio and reputation, reserves funds and discusses details in chat. Afterwards the client confirms completion and leaves a review. Beginner freelancers can find their first clients here.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Offers with prices and deadlines
Funds reservation
Chat with the freelancer
Reviews and reputation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ukrainian freelancers and clients.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== VPN і приватність (cybersecurity/vpn-privacy) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'cybersecurity' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vpn-privacy' LIMIT 1);

-- Tor Browser
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'torproject.org' OR LOWER(`name`) = 'tor browser')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tor Browser', NULL, 'https://www.torproject.org/', NULL, NULL, 'Безкоштовний браузер із відкритим кодом, що шифрує трафік і пропускає його через мережу Tor для анонімності.', 'A free, open-source browser that encrypts traffic and routes it through the Tor network for anonymity.', 'Tor Browser від некомерційної організації Tor Project приховує, які сайти ви відвідуєте, від тих, хто стежить за з’єднанням. Трафік тричі шифрується й проходить через тисячі серверів-ретрансляторів, які підтримують волонтери. Браузер робить усіх користувачів схожими, щоб ускладнити відстеження за «відбитком» пристрою, і допомагає відкривати сайти, заблоковані в мережі.', 'Tor Browser from the non-profit Tor Project hides which websites you visit from anyone watching your connection. Traffic is encrypted three times and relayed through thousands of volunteer-run servers. The browser makes all users look alike to resist device fingerprinting and helps open sites blocked on your network.', 'Трирівневе шифрування через мережу Tor
Захист від відстеження за відбитком
Обхід блокувань
Безкоштовно й з відкритим кодом', 'Three-layer encryption over the Tor network
Anti-fingerprinting protection
Censorship circumvention
Free and open source', 'Журналістам, активістам і всім, кому важлива приватність у мережі.', 'Journalists, activists and anyone who values online privacy.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'torproject.org' OR LOWER(`name`) = 'tor browser') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free, open-source browser that encrypts traffic and routes it through the Tor network for anonymity.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tor Browser from the non-profit Tor Project hides which websites you visit from anyone watching your connection. Traffic is encrypted three times and relayed through thousands of volunteer-run servers. The browser makes all users look alike to resist device fingerprinting and helps open sites blocked on your network.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Three-layer encryption over the Tor network
Anti-fingerprinting protection
Censorship circumvention
Free and open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Journalists, activists and anyone who values online privacy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Windscribe
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'windscribe.com' OR LOWER(`name`) = 'windscribe')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Windscribe', NULL, 'https://windscribe.com/', NULL, NULL, 'VPN із безкоштовним тарифом, серверами у 130+ локаціях і клієнтами з відкритим кодом.', 'A VPN with a free plan, servers in 130+ locations and open-source clients.', 'Windscribe — VPN-сервіс із застосунками для комп’ютерів, телефонів і браузерним розширенням. Безкоштовний тариф не вимагає ні оплати, ні email. Інфраструктура працює на RAM-дисках без збереження ідентифікаційних даних, а застосунки мають відкритий код. Є блокування реклами й трекерів через DNS і платні тарифи з усіма локаціями.', 'Windscribe is a VPN service with apps for computers and phones plus a browser extension. The free plan requires neither payment nor an email. The infrastructure runs on RAM disks that store no identifying data, and the apps are open source. It offers DNS-level ad and tracker blocking and paid plans with all locations.', 'Безкоштовний тариф без email
Сервери у 130+ локаціях
Відкритий код застосунків
Блокування реклами й трекерів', 'Free plan without email
Servers in 130+ locations
Open-source apps
Ad and tracker blocking', 'Користувачам, які хочуть захистити з’єднання й приватність.', 'Users who want to protect their connection and privacy.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'windscribe.com' OR LOWER(`name`) = 'windscribe') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A VPN with a free plan, servers in 130+ locations and open-source clients.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Windscribe is a VPN service with apps for computers and phones plus a browser extension. The free plan requires neither payment nor an email. The infrastructure runs on RAM disks that store no identifying data, and the apps are open source. It offers DNS-level ad and tracker blocking and paid plans with all locations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free plan without email
Servers in 130+ locations
Open-source apps
Ad and tracker blocking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who want to protect their connection and privacy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Антивіруси та захист пристроїв (cybersecurity/device-protection) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'cybersecurity' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'device-protection' LIMIT 1);

-- Trend Micro
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trendmicro.com/en_us/forhome.html' OR LOWER(`name`) = 'trend micro')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Trend Micro', NULL, 'https://www.trendmicro.com/en_us/forHome.html', NULL, NULL, 'Антивірус і захист від шахрайства для Windows, Mac, Android, iOS і Chromebook.', 'Antivirus and scam protection for Windows, Mac, Android, iOS and Chromebook.', 'Домашні продукти Trend Micro захищають пристрої від шкідливих програм, допомагають уникати фішингу й шахрайства та стежать за витоками особистих даних. Окремий інструмент ScamCheck перевіряє підозрілі повідомлення, посилання й дзвінки, зокрема шахрайство з використанням AI. Є безкоштовні інструменти й онлайн-сканування, повний захист — за підпискою.', 'Trend Micro’s home products protect devices from malware, help avoid phishing and scams and watch for personal-data leaks. A separate tool, ScamCheck, checks suspicious messages, links and calls, including AI-driven scams. Free tools and an online scan are available; full protection is by subscription.', 'Антивірус для 5 платформ
ScamCheck проти шахрайства
Захист особистих даних
Безкоштовні інструменти', 'Antivirus for 5 platforms
ScamCheck against scams
Identity protection
Free tools', 'Сім’ям і домашнім користувачам.', 'Families and home users.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trendmicro.com/en_us/forhome.html' OR LOWER(`name`) = 'trend micro') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Antivirus and scam protection for Windows, Mac, Android, iOS and Chromebook.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Trend Micro’s home products protect devices from malware, help avoid phishing and scams and watch for personal-data leaks. A separate tool, ScamCheck, checks suspicious messages, links and calls, including AI-driven scams. Free tools and an online scan are available; full protection is by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Antivirus for 5 platforms
ScamCheck against scams
Identity protection
Free tools', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families and home users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Emsisoft
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'emsisoft.com' OR LOWER(`name`) = 'emsisoft')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Emsisoft', NULL, 'https://www.emsisoft.com/', NULL, NULL, 'Антивірус і захист кінцевих точок для малого й середнього бізнесу з двома рушіями сканування.', 'Antivirus and endpoint protection for small and mid-size businesses with a dual-engine scanner.', 'Emsisoft поєднує два антивірусні рушії в одному швидкому сканері, який знаходить і видаляє шкідливі та небажані програми, а також багаторівневий захист на пристрої й у хмарі. Керування можна вести з хмарної консолі. За конкретними загрозами можна звернутися до сертифікованих фахівців із видалення. Є 30-денний безкоштовний пробний період.', 'Emsisoft combines two antivirus engines in one fast scanner that finds and removes malware and unwanted programs, plus layered on-device and cloud protection. It is managed from a cloud console. Certified removal experts help with specific threats. A 30-day free trial is available.', 'Сканер із двома рушіями
Багаторівневий захист
Хмарна консоль керування
30 днів безкоштовно', 'Dual-engine scanner
Layered protection
Cloud management console
30-day free trial', 'Малому й середньому бізнесу та IT-адміністраторам.', 'Small and mid-size businesses and IT admins.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'emsisoft.com' OR LOWER(`name`) = 'emsisoft') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Antivirus and endpoint protection for small and mid-size businesses with a dual-engine scanner.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Emsisoft combines two antivirus engines in one fast scanner that finds and removes malware and unwanted programs, plus layered on-device and cloud protection. It is managed from a cloud console. Certified removal experts help with specific threats. A 30-day free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dual-engine scanner
Layered protection
Cloud management console
30-day free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Small and mid-size businesses and IT admins.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lookout
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lookout.com' OR LOWER(`name`) = 'lookout')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lookout', NULL, 'https://www.lookout.com/', NULL, NULL, 'Захист мобільних пристроїв компаній від фішингу, шкідливих застосунків і витоку даних.', 'Mobile endpoint security for companies against phishing, risky apps and data leaks.', 'Lookout — корпоративна платформа безпеки для смартфонів і планшетів. Вона блокує цільові атаки через месенджери й SMS, оцінює ризики сторонніх застосунків, захищає корпоративні дані на особистих пристроях і передає мобільну телеметрію в SIEM. Окремо платформа допомагає виявляти несанкціоновані AI-інструменти. Є безкоштовний тест на вразливість співробітників до соціальної інженерії.', 'Lookout is an enterprise security platform for phones and tablets. It blocks targeted attacks across messaging apps and SMS, assesses third-party app risks, protects corporate data on personal devices and feeds mobile telemetry into SIEM. It also helps detect unsanctioned AI tools. A free test shows how exposed staff are to social engineering.', 'Захист від фішингу в месенджерах
Оцінка ризиків застосунків
Захист даних на особистих пристроях
Інтеграція з SIEM', 'Phishing protection across messaging apps
App risk assessment
Data protection on personal devices
SIEM integration', 'Службам безпеки й IT-відділам компаній.', 'Security and IT teams at companies.', 'mobile,web', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lookout.com' OR LOWER(`name`) = 'lookout') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mobile endpoint security for companies against phishing, risky apps and data leaks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lookout is an enterprise security platform for phones and tablets. It blocks targeted attacks across messaging apps and SMS, assesses third-party app risks, protects corporate data on personal devices and feeds mobile telemetry into SIEM. It also helps detect unsanctioned AI tools. A free test shows how exposed staff are to social engineering.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Phishing protection across messaging apps
App risk assessment
Data protection on personal devices
SIEM integration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Security and IT teams at companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Захист особистих даних (cybersecurity/identity-protection) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'cybersecurity' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'identity-protection' LIMIT 1);

-- Firefox Relay
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'relay.firefox.com' OR LOWER(`name`) = 'firefox relay')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Firefox Relay', NULL, 'https://relay.firefox.com/', NULL, NULL, 'Маски email і телефону від Mozilla: листи й дзвінки пересилаються вам, а справжні контакти лишаються прихованими.', 'Email and phone masks from Mozilla: messages and calls are forwarded to you while your real contacts stay hidden.', 'Firefox Relay створює випадкові адреси-маски, які можна вказувати на сайтах, у магазинах і застосунках. Листи пересилаються на вашу справжню пошту, а відповісти можна, не розкриваючи її. У Premium є необмежена кількість масок і окремий замаскований номер телефону для дзвінків і SMS (доступний не в усіх країнах). Маски, що збирають спам, можна заблокувати в панелі керування.', 'Firefox Relay creates random mask addresses you can give to websites, stores and apps. Emails are forwarded to your real inbox, and you can reply without revealing it. Premium adds unlimited masks and a masked phone number for calls and texts (not available in every country). Masks that attract spam can be blocked from the dashboard.', '5 email-масок безкоштовно
Відповіді без розкриття адреси
Замаскований номер телефону в Premium
Блокування спамних масок', '5 free email masks
Replies without revealing your address
Masked phone number in Premium
Blocking of spammy masks', 'Усім, хто не хоче роздавати справжню пошту й номер.', 'Anyone who would rather not hand out their real email and number.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'relay.firefox.com' OR LOWER(`name`) = 'firefox relay') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Email and phone masks from Mozilla: messages and calls are forwarded to you while your real contacts stay hidden.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Firefox Relay creates random mask addresses you can give to websites, stores and apps. Emails are forwarded to your real inbox, and you can reply without revealing it. Premium adds unlimited masks and a masked phone number for calls and texts (not available in every country). Masks that attract spam can be blocked from the dashboard.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '5 free email masks
Replies without revealing your address
Masked phone number in Premium
Blocking of spammy masks', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who would rather not hand out their real email and number.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SimpleLogin
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simplelogin.io' OR LOWER(`name`) = 'simplelogin')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SimpleLogin', NULL, 'https://simplelogin.io/', NULL, NULL, 'Сервіс email-псевдонімів із відкритим кодом: захищає справжню адресу від спаму та фішингу.', 'An open-source email alias service that shields your real address from spam and phishing.', 'SimpleLogin дає змогу вказувати на сайтах псевдонім замість справжньої пошти. Усі листи на псевдонім пересилаються вам, а відповідь іде від імені псевдоніма. Псевдоніми швидко створюються з розширення браузера чи мобільного застосунку. Увесь код — застосунки, сервіс і сайт — відкритий. Є безкоштовний тариф.', 'SimpleLogin lets you give websites an alias instead of your real email. All mail sent to the alias is forwarded to you, and replies are sent from the alias. Aliases are created quickly from a browser extension or mobile app. All the code — apps, service and website — is open source. A free plan is available.', 'Email-псевдоніми з пересиланням
Відповіді від імені псевдоніма
Розширення браузера й застосунки
Відкритий код', 'Forwarding email aliases
Replies sent from the alias
Browser extension and apps
Open source', 'Користувачам, які дбають про приватність пошти.', 'Users who care about email privacy.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simplelogin.io' OR LOWER(`name`) = 'simplelogin') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source email alias service that shields your real address from spam and phishing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SimpleLogin lets you give websites an alias instead of your real email. All mail sent to the alias is forwarded to you, and replies are sent from the alias. Aliases are created quickly from a browser extension or mobile app. All the code — apps, service and website — is open source. A free plan is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Forwarding email aliases
Replies sent from the alias
Browser extension and apps
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who care about email privacy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Privacy Bee
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'privacybee.com' OR LOWER(`name`) = 'privacy bee')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Privacy Bee', NULL, 'https://privacybee.com/', NULL, NULL, 'Видаляє ваші особисті дані з 1250 брокерів даних і тисяч інших сайтів та стежить, щоб вони не повернулися.', 'Removes your personal data from 1,250 data brokers and thousands of other sites and keeps it gone.', 'Privacy Bee починає з безкоштовного сканування цифрового сліду, а потім надсилає запити на видалення ваших контактів і особистих даних із сайтів брокерів даних і пошукових результатів. Сервіс постійно моніторить нові появи даних. Мета — менше спаму, рекламних дзвінків і матеріалу для шахраїв.', 'Privacy Bee starts with a free scan of your digital footprint and then sends removal requests for your contact and personal data to data-broker sites and search results. The service keeps monitoring for new exposures. The aim is less spam, fewer marketing calls and less material for scammers.', 'Безкоштовне сканування цифрового сліду
Видалення з 1250 брокерів даних
Постійний моніторинг
Запити на видалення від вашого імені', 'Free digital-footprint scan
Removal from 1,250 data brokers
Ongoing monitoring
Removal requests on your behalf', 'Людям, яких турбують спам-дзвінки й витоки особистих даних, переважно у США.', 'People troubled by spam calls and personal-data exposure, mainly in the US.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'privacybee.com' OR LOWER(`name`) = 'privacy bee') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Removes your personal data from 1,250 data brokers and thousands of other sites and keeps it gone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Privacy Bee starts with a free scan of your digital footprint and then sends removal requests for your contact and personal data to data-broker sites and search results. The service keeps monitoring for new exposures. The aim is less spam, fewer marketing calls and less material for scammers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free digital-footprint scan
Removal from 1,250 data brokers
Ongoing monitoring
Removal requests on your behalf', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People troubled by spam calls and personal-data exposure, mainly in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kanary
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kanary.com' OR LOWER(`name`) = 'kanary')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kanary', NULL, 'https://www.kanary.com/', NULL, NULL, 'Платформа захисту людей від доксингу, підробних акаунтів і фізичних ризиків через моніторинг даних у мережі.', 'A platform protecting people from doxxing, impersonation and physical risk by monitoring their data online.', 'Kanary будує модель загроз для кожної людини, знаходить відкриті особисті дані, підробні акаунти та інші вразливості й допомагає їх усунути. Сервіс розрахований на людей із публічною присутністю — блогерів, керівників некомерційних організацій, медійних осіб — і на компанії, які захищають своїх співробітників. Є окремі тарифи для приватних осіб.', 'Kanary builds a threat model for each person, finds exposed personal data, impersonating accounts and other weak spots, and helps remove them. It is built for people with a public presence — creators, non-profit leaders, public figures — and for organizations protecting their staff. There are separate plans for individuals.', 'Індивідуальна модель загроз
Пошук і видалення відкритих даних
Захист від доксингу й підробних акаунтів
Звіти для організацій', 'Individual threat model
Finding and removing exposed data
Protection from doxxing and impersonation
Reports for organizations', 'Публічним людям і організаціям, що захищають співробітників.', 'Public figures and organizations protecting their people.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kanary.com' OR LOWER(`name`) = 'kanary') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform protecting people from doxxing, impersonation and physical risk by monitoring their data online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kanary builds a threat model for each person, finds exposed personal data, impersonating accounts and other weak spots, and helps remove them. It is built for people with a public presence — creators, non-profit leaders, public figures — and for organizations protecting their staff. There are separate plans for individuals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Individual threat model
Finding and removing exposed data
Protection from doxxing and impersonation
Reports for organizations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Public figures and organizations protecting their people.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Кольори (design-creative/colors) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'design-creative' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'colors' LIMIT 1);

-- Realtime Colors
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'realtimecolors.com' OR LOWER(`name`) = 'realtime colors')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Realtime Colors', NULL, 'https://www.realtimecolors.com/', NULL, NULL, 'Безкоштовний інструмент, що одразу показує вашу палітру й шрифти на макеті справжнього сайту.', 'A free tool that instantly shows your palette and fonts on a mock-up of a real website.', 'Realtime Colors розподіляє кольори по справжній сторінці сайту, тож видно, як палітра працює в інтерфейсі. Ви задаєте кольори тексту й фону, основний, додатковий і акцентний кольори, а також шрифти. Готову палітру можна експортувати у CSS, SCSS, PNG, QR-код та інші формати. Інструмент повністю безкоштовний.', 'Realtime Colors spreads your colors across a real web page so you can see how the palette works in an interface. You set text and background colors, primary, secondary and accent colors, and fonts. The finished palette exports to CSS, SCSS, PNG, a QR code and more. The tool is completely free.', 'Попередній перегляд палітри на сайті
Налаштування шрифтів
Експорт у CSS, SCSS, PNG
Повністю безкоштовно', 'Palette preview on a website
Font pairing
Export to CSS, SCSS, PNG
Completely free', 'Веб-дизайнерам, розробникам і власникам сайтів.', 'Web designers, developers and site owners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'realtimecolors.com' OR LOWER(`name`) = 'realtime colors') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free tool that instantly shows your palette and fonts on a mock-up of a real website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Realtime Colors spreads your colors across a real web page so you can see how the palette works in an interface. You set text and background colors, primary, secondary and accent colors, and fonts. The finished palette exports to CSS, SCSS, PNG, a QR code and more. The tool is completely free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Palette preview on a website
Font pairing
Export to CSS, SCSS, PNG
Completely free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Web designers, developers and site owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Color Hunt
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'colorhunt.co' OR LOWER(`name`) = 'color hunt')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Color Hunt', NULL, 'https://colorhunt.co/', NULL, NULL, 'Безкоштовна колекція вручну відібраних колірних палітр для дизайну й мистецтва.', 'A free collection of hand-picked color palettes for design and art.', 'Color Hunt — відкрита добірка палітр із чотирьох кольорів, які щодня поповнюються й відбираються вручну. Палітри можна переглядати за популярністю й темами, зберігати улюблені та копіювати HEX-коди в один клік. Сервіс зручний як джерело натхнення для дизайну інтерфейсів, брендингу й ілюстрацій.', 'Color Hunt is an open collection of four-color palettes, hand-picked and updated daily. Palettes can be browsed by popularity and theme, saved as favorites, and their HEX codes copied in one click. It is a handy source of inspiration for interface design, branding and illustration.', 'Вручну відібрані палітри
Пошук за темами й популярністю
Копіювання HEX-кодів
Безкоштовно', 'Hand-picked palettes
Browse by theme and popularity
One-click HEX copy
Free', 'Дизайнерам, ілюстраторам і художникам.', 'Designers, illustrators and artists.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'colorhunt.co' OR LOWER(`name`) = 'color hunt') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free collection of hand-picked color palettes for design and art.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Color Hunt is an open collection of four-color palettes, hand-picked and updated daily. Palettes can be browsed by popularity and theme, saved as favorites, and their HEX codes copied in one click. It is a handy source of inspiration for interface design, branding and illustration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hand-picked palettes
Browse by theme and popularity
One-click HEX copy
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Designers, illustrators and artists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Фреймворки для LLM-застосунків (development-it/llm-frameworks) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'development-it' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'llm-frameworks' LIMIT 1);

-- DSPy
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dspy.ai' OR LOWER(`name`) = 'dspy')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DSPy', NULL, 'https://dspy.ai/', NULL, NULL, 'Python-фреймворк, у якому LLM-завдання описують типізованими сигнатурами, а промпти оптимізуються автоматично.', 'A Python framework where LLM tasks are described as typed signatures and prompts are optimized automatically.', 'DSPy пропонує описувати завдання для мовної моделі як типізовані входи й виходи, а не як довгі промпти. Модулі визначають, як виконувати завдання: міркування, агент з інструментами (ReAct), ансамблі. Якщо дати приклади й функцію оцінки, оптимізатор DSPy сам підбирає промпти, доки якість не стабілізується. Фреймворк відкритий і безкоштовний.', 'DSPy lets you describe language-model tasks as typed inputs and outputs rather than long prompts. Modules define how a task runs: reasoning, a tool-using agent (ReAct), ensembles. Given examples and a scoring function, DSPy’s optimizer tunes the prompts until quality converges. The framework is open source and free.', 'Типізовані сигнатури замість промптів
Модулі для міркувань і агентів
Автоматична оптимізація промптів
Відкритий код', 'Typed signatures instead of prompts
Modules for reasoning and agents
Automatic prompt optimization
Open source', 'Python-розробникам LLM-застосунків і дослідникам.', 'Python developers of LLM apps and researchers.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dspy.ai' OR LOWER(`name`) = 'dspy') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Python framework where LLM tasks are described as typed signatures and prompts are optimized automatically.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DSPy lets you describe language-model tasks as typed inputs and outputs rather than long prompts. Modules define how a task runs: reasoning, a tool-using agent (ReAct), ensembles. Given examples and a scoring function, DSPy’s optimizer tunes the prompts until quality converges. The framework is open source and free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Typed signatures instead of prompts
Modules for reasoning and agents
Automatic prompt optimization
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Python developers of LLM apps and researchers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Semantic Kernel
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'learn.microsoft.com/en-us/semantic-kernel/overview' OR LOWER(`name`) = 'semantic kernel')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Semantic Kernel', NULL, 'https://learn.microsoft.com/en-us/semantic-kernel/overview/', NULL, NULL, 'Відкритий SDK від Microsoft для створення AI-агентів і підключення моделей у коді на C#, Python і Java.', 'Microsoft’s open-source SDK for building AI agents and integrating models into C#, Python and Java code.', 'Semantic Kernel — легкий набір інструментів, що виступає проміжним шаром між вашим кодом і мовними моделями. Він дає змогу будувати агентів, підключати функції та плагіни, міняти моделі без переписування логіки. Версії для C#, Python і Java мають стабільний API, а телеметрія, хуки й фільтри допомагають контролювати роботу AI у продакшені.', 'Semantic Kernel is a lightweight toolkit that acts as middleware between your code and language models. It lets you build agents, connect functions and plugins, and swap models without rewriting logic. The C#, Python and Java versions have a stable API, and telemetry, hooks and filters help keep AI behavior under control in production.', 'SDK для C#, Python і Java
Агенти й плагіни
Заміна моделей без переписування коду
Телеметрія, хуки й фільтри', 'SDK for C#, Python and Java
Agents and plugins
Model swapping without code rewrites
Telemetry, hooks and filters', 'Розробникам корпоративних AI-рішень, особливо в екосистемі .NET.', 'Developers of enterprise AI solutions, especially in the .NET ecosystem.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'learn.microsoft.com/en-us/semantic-kernel/overview' OR LOWER(`name`) = 'semantic kernel') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Microsoft’s open-source SDK for building AI agents and integrating models into C#, Python and Java code.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Semantic Kernel is a lightweight toolkit that acts as middleware between your code and language models. It lets you build agents, connect functions and plugins, and swap models without rewriting logic. The C#, Python and Java versions have a stable API, and telemetry, hooks and filters help keep AI behavior under control in production.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'SDK for C#, Python and Java
Agents and plugins
Model swapping without code rewrites
Telemetry, hooks and filters', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers of enterprise AI solutions, especially in the .NET ecosystem.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Pydantic AI
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ai.pydantic.dev' OR LOWER(`name`) = 'pydantic ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pydantic AI', NULL, 'https://ai.pydantic.dev/', NULL, NULL, 'Python-фреймворк від команди Pydantic для типізованих AI-агентів, що працює з будь-якими моделями.', 'A Python framework from the Pydantic team for typed AI agents that works with any model.', 'Pydantic AI дає змогу будувати агентів — від простого вилучення даних у типізовані структури до довгих багатоагентних процесів — з перевіркою типів від початку до кінця. Підтримуються різні постачальники моделей, голосовий режим у реальному часі, генерація зображень і ембединги. Поруч є окремі пакети для тестування поведінки агентів і спостереження через OpenTelemetry. Фреймворк відкритий.', 'Pydantic AI lets you build agents — from simple extraction into typed structures to long-running multi-agent workflows — with end-to-end type checking. It supports many model providers, realtime voice, image generation and embeddings. Companion packages cover agent behavior testing and OpenTelemetry-based observability. The framework is open source.', 'Типізовані агенти на Python
Будь-які постачальники моделей
Тестування поведінки агентів
Спостереження через OpenTelemetry', 'Typed Python agents
Any model provider
Agent behavior testing
OpenTelemetry observability', 'Python-розробникам, які будують агентів для продакшену.', 'Python developers building production agents.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ai.pydantic.dev' OR LOWER(`name`) = 'pydantic ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Python framework from the Pydantic team for typed AI agents that works with any model.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Pydantic AI lets you build agents — from simple extraction into typed structures to long-running multi-agent workflows — with end-to-end type checking. It supports many model providers, realtime voice, image generation and embeddings. Companion packages cover agent behavior testing and OpenTelemetry-based observability. The framework is open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Typed Python agents
Any model provider
Agent behavior testing
OpenTelemetry observability', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Python developers building production agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Моніторинг і оцінка LLM (development-it/llmops) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'development-it' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'llmops' LIMIT 1);

-- Opik
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'comet.com/site/products/opik' OR LOWER(`name`) = 'opik')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Opik', NULL, 'https://www.comet.com/site/products/opik/', NULL, NULL, 'Платформа з відкритим кодом від Comet для трасування, оцінювання й моніторингу LLM-агентів.', 'An open-source platform from Comet for tracing, evaluating and monitoring LLM agents.', 'Opik записує кожен крок агента: запити користувача, пошук контексту, виклики інструментів. На цих даних можна запускати автоматичні оцінювання, зокрема LLM-as-a-judge, керувати промптами й стежити за якістю в продакшені. Основні функції доступні у відкритому коді, є щедрий безкоштовний хмарний тариф і корпоративна версія.', 'Opik logs every step an agent takes: user requests, context retrieval and tool calls. On top of that data you can run automated evaluations, including LLM-as-a-judge, manage prompts and monitor quality in production. The core features are open source, with a generous free cloud tier and an enterprise version.', 'Трасування кроків агента
Автоматичні оцінювання LLM-as-a-judge
Керування промптами
Моніторинг у продакшені', 'Agent step tracing
Automated LLM-as-a-judge evaluations
Prompt management
Production monitoring', 'Розробникам LLM-застосунків і ML-командам.', 'LLM app developers and ML teams.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'comet.com/site/products/opik' OR LOWER(`name`) = 'opik') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source platform from Comet for tracing, evaluating and monitoring LLM agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Opik logs every step an agent takes: user requests, context retrieval and tool calls. On top of that data you can run automated evaluations, including LLM-as-a-judge, manage prompts and monitor quality in production. The core features are open source, with a generous free cloud tier and an enterprise version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Agent step tracing
Automated LLM-as-a-judge evaluations
Prompt management
Production monitoring', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'LLM app developers and ML teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Galileo
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'galileo.ai' OR LOWER(`name`) = 'galileo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Galileo', NULL, 'https://galileo.ai/', NULL, NULL, 'Платформа оцінювання й спостереження за AI, де офлайн-оцінки стають запобіжниками в продакшені.', 'An AI evaluation and observability platform where offline evals become production guardrails.', 'Galileo допомагає збирати набори даних із синтетичних, тестових і живих даних, додавати анотації експертів і налаштовувати метрики під власне середовище. Є понад 20 готових оцінок для RAG, агентів, безпеки й захисту. Оптимізовані оцінки можна перетворити на компактні моделі Luna, які перевіряють увесь трафік дешевше. Почати можна безкоштовно.', 'Galileo helps build datasets from synthetic, development and live data, add expert annotations and tune metrics to your own environment. It offers 20+ ready-made evals for RAG, agents, safety and security. Optimized evals can be distilled into compact Luna models that check all traffic at lower cost. You can start for free.', '20+ готових оцінок для RAG і агентів
Анотації експертів
Моделі Luna для запобіжників
Безкоштовний старт', '20+ ready evals for RAG and agents
Expert annotations
Luna models for guardrails
Free start', 'Командам, що виводять AI-агентів і RAG у продакшен.', 'Teams shipping AI agents and RAG to production.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'galileo.ai' OR LOWER(`name`) = 'galileo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI evaluation and observability platform where offline evals become production guardrails.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Galileo helps build datasets from synthetic, development and live data, add expert annotations and tune metrics to your own environment. It offers 20+ ready-made evals for RAG, agents, safety and security. Optimized evals can be distilled into compact Luna models that check all traffic at lower cost. You can start for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '20+ ready evals for RAG and agents
Expert annotations
Luna models for guardrails
Free start', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams shipping AI agents and RAG to production.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Evidently AI
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'evidentlyai.com' OR LOWER(`name`) = 'evidently ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Evidently AI', NULL, 'https://www.evidentlyai.com/', NULL, NULL, 'Відкритий фреймворк для оцінювання, тестування й моніторингу LLM, RAG, агентів і ML-моделей.', 'An open-source framework for evaluating, testing and monitoring LLMs, RAG, agents and ML models.', 'Evidently AI допомагає систематично вимірювати якість відповідей AI: генерувати тестові випадки, ловити небезпечний вміст, атаки через промпти, зміщення даних і збої в ланцюжках агентів. Бібліотека повністю відкрита під ліцензією Apache 2.0, поруч є хмарна платформа. Команда також веде безкоштовні курси з оцінювання LLM.', 'Evidently AI helps measure AI output quality systematically: generate test cases and catch unsafe content, prompt attacks, data drift and failures in agent chains. The library is fully open source under Apache 2.0, alongside a cloud platform. The team also runs free courses on LLM evaluation.', 'Оцінювання LLM, RAG і агентів
Генерація тестових випадків
Моніторинг зміщення даних
Apache 2.0, безкоштовні курси', 'LLM, RAG and agent evaluation
Test-case generation
Data drift monitoring
Apache 2.0, free courses', 'ML-інженерам і розробникам AI-продуктів.', 'ML engineers and AI product developers.', 'web,desktop', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'evidentlyai.com' OR LOWER(`name`) = 'evidently ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source framework for evaluating, testing and monitoring LLMs, RAG, agents and ML models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Evidently AI helps measure AI output quality systematically: generate test cases and catch unsafe content, prompt attacks, data drift and failures in agent chains. The library is fully open source under Apache 2.0, alongside a cloud platform. The team also runs free courses on LLM evaluation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'LLM, RAG and agent evaluation
Test-case generation
Data drift monitoring
Apache 2.0, free courses', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'ML engineers and AI product developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Векторні бази даних (development-it/vector-databases) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'development-it' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vector-databases' LIMIT 1);

-- pgvector
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/pgvector/pgvector' OR LOWER(`name`) = 'pgvector')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'pgvector', NULL, 'https://github.com/pgvector/pgvector', NULL, NULL, 'Відкрите розширення PostgreSQL для зберігання векторів і пошуку схожих поруч з іншими даними.', 'An open-source PostgreSQL extension for storing vectors and similarity search alongside your other data.', 'pgvector додає до PostgreSQL векторний тип даних і точний та наближений пошук найближчих сусідів. Підтримуються вектори одинарної й половинної точності, бінарні та розріджені, а також кілька метрик відстані: L2, скалярний добуток, косинусна, Хеммінга та інші. Вектори зберігаються разом з рештою даних, тож працюють транзакції, JOIN і відновлення бази.', 'pgvector adds a vector data type to PostgreSQL along with exact and approximate nearest-neighbor search. It supports single- and half-precision, binary and sparse vectors, and several distance metrics: L2, inner product, cosine, Hamming and more. Vectors live with the rest of your data, so transactions, JOINs and recovery all work.', 'Векторний тип у PostgreSQL
Точний і наближений пошук
Кілька метрик відстані
Відкритий код', 'Vector type in PostgreSQL
Exact and approximate search
Multiple distance metrics
Open source', 'Розробникам, які вже використовують PostgreSQL.', 'Developers already using PostgreSQL.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/pgvector/pgvector' OR LOWER(`name`) = 'pgvector') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open-source PostgreSQL extension for storing vectors and similarity search alongside your other data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'pgvector adds a vector data type to PostgreSQL along with exact and approximate nearest-neighbor search. It supports single- and half-precision, binary and sparse vectors, and several distance metrics: L2, inner product, cosine, Hamming and more. Vectors live with the rest of your data, so transactions, JOINs and recovery all work.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vector type in PostgreSQL
Exact and approximate search
Multiple distance metrics
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers already using PostgreSQL.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LanceDB
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lancedb.com' OR LOWER(`name`) = 'lancedb')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LanceDB', NULL, 'https://lancedb.com/', NULL, NULL, 'Мультимодальна база для AI з векторним, повнотекстовим і гібридним пошуком на форматі Lance.', 'A multimodal database for AI with vector, full-text and hybrid search on the Lance format.', 'LanceDB зберігає дані у відкритому форматі Lance в об’єктному сховищі й поєднує векторний, повнотекстовий і гібридний пошук із SQL-фільтрами. Точність пошуку можна налаштовувати під час запиту, а нові дані відразу стають доступними для пошуку. Крім пошуку, платформа допомагає дедуплікувати великі набори даних і шукати крайові випадки. Є відкрита версія.', 'LanceDB stores data in the open Lance format on object storage and combines vector, full-text and hybrid search with SQL filters. Search precision can be tuned at query time, and new data becomes searchable immediately. Beyond search, it helps deduplicate large datasets and surface edge cases. An open-source version is available.', 'Векторний, повнотекстовий і гібридний пошук
SQL-фільтри
Відкритий формат Lance
Масштаб до мільярдів векторів', 'Vector, full-text and hybrid search
SQL filters
Open Lance format
Scales to billions of vectors', 'AI-інженерам, які працюють із мультимодальними даними.', 'AI engineers working with multimodal data.', 'web,desktop', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lancedb.com' OR LOWER(`name`) = 'lancedb') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A multimodal database for AI with vector, full-text and hybrid search on the Lance format.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LanceDB stores data in the open Lance format on object storage and combines vector, full-text and hybrid search with SQL filters. Search precision can be tuned at query time, and new data becomes searchable immediately. Beyond search, it helps deduplicate large datasets and surface edge cases. An open-source version is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vector, full-text and hybrid search
SQL filters
Open Lance format
Scales to billions of vectors', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'AI engineers working with multimodal data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Vespa
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vespa.ai' OR LOWER(`name`) = 'vespa')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vespa', NULL, 'https://vespa.ai/', NULL, NULL, 'Платформа AI-пошуку з векторним і текстовим пошуком, ранжуванням і ML-інференсом в одному місці.', 'An AI search platform combining vector and text search, ranking and ML inference in one place.', 'Vespa дає змогу шукати й робити висновки за векторами, тензорами, текстом і структурованими даними. Платформа масштабується до мільярдів записів, що постійно змінюються, з тисячами запитів на секунду та затримкою менш як 100 мс. Вбудований розподілений інференс моделей допомагає точно ранжувати результати. Vespa використовують для пошуку, рекомендацій і RAG. Є відкрита версія та пробний період хмари.', 'Vespa lets you query and infer over vectors, tensors, text and structured data. It scales to billions of constantly changing items with thousands of queries per second and latency under 100 ms. Built-in distributed model inference helps rank results precisely. Vespa is used for search, recommendations and RAG. There is an open-source version and a cloud free trial.', 'Векторний і текстовий пошук
Вбудований ML-інференс для ранжування
Мільярди записів, <100 мс
Відкритий код і хмара', 'Vector and text search
Built-in ML inference for ranking
Billions of items, <100 ms
Open source and cloud', 'Командам, що будують пошук, рекомендації та RAG на великих обсягах.', 'Teams building search, recommendations and RAG at scale.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vespa.ai' OR LOWER(`name`) = 'vespa') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI search platform combining vector and text search, ranking and ML inference in one place.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vespa lets you query and infer over vectors, tensors, text and structured data. It scales to billions of constantly changing items with thousands of queries per second and latency under 100 ms. Built-in distributed model inference helps rank results precisely. Vespa is used for search, recommendations and RAG. There is an open-source version and a cloud free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vector and text search
Built-in ML inference for ranking
Billions of items, <100 ms
Open source and cloud', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams building search, recommendations and RAG at scale.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- turbopuffer
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'turbopuffer.com' OR LOWER(`name`) = 'turbopuffer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'turbopuffer', NULL, 'https://turbopuffer.com/', NULL, NULL, 'Векторний і повнотекстовий пошук на об’єктному сховищі: швидкий, дешевший і дуже масштабований.', 'Vector and full-text search built on object storage: fast, cheaper and highly scalable.', 'turbopuffer зберігає дані в об’єктному сховищі на кшталт S3, а «гарячі» дані тримає в кеші пам’яті та SSD. Завдяки цьому сервіс поєднує швидкий векторний і повнотекстовий пошук із нижчою вартістю зберігання. Дані розділяються на простори імен (namespaces), що зручно для багатьох клієнтів чи користувачів. Доступ — через API.', 'turbopuffer stores data on object storage such as S3 and keeps hot data in a memory and SSD cache. This combines fast vector and full-text search with lower storage cost. Data is split into namespaces, which suits many tenants or users. Access is via API.', 'Векторний і повнотекстовий пошук
Зберігання в об’єктному сховищі
Кеш у пам’яті та на SSD
Простори імен для багатьох клієнтів', 'Vector and full-text search
Object-storage persistence
Memory and SSD cache
Namespaces for multi-tenancy', 'Розробникам AI-продуктів із великими обсягами даних.', 'Developers of AI products with large data volumes.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'turbopuffer.com' OR LOWER(`name`) = 'turbopuffer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Vector and full-text search built on object storage: fast, cheaper and highly scalable.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'turbopuffer stores data on object storage such as S3 and keeps hot data in a memory and SSD cache. This combines fast vector and full-text search with lower storage cost. Data is split into namespaces, which suits many tenants or users. Access is via API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vector and full-text search
Object-storage persistence
Memory and SSD cache
Namespaces for multi-tenancy', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers of AI products with large data volumes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Zilliz Cloud
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zilliz.com/cloud' OR LOWER(`name`) = 'zilliz cloud')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Zilliz Cloud', NULL, 'https://zilliz.com/cloud', NULL, NULL, 'Керована векторна база від творців Milvus для пошуку в реальному часі та AI-операцій із даними.', 'A managed vector database from the creators of Milvus for real-time search and AI data operations.', 'Zilliz Cloud — повністю керований сервіс на основі відкритої бази Milvus. Він виконує векторний пошук у реальному часі, працює з наборами даних масштабу «озера даних» і бере на себе налаштування, масштабування й надійність. Є безкоштовний тариф і гнучкі платні плани для команд будь-якого розміру.', 'Zilliz Cloud is a fully managed service built on the open-source Milvus database. It runs real-time vector search, handles lake-scale datasets and takes care of tuning, scaling and reliability. There is a free tier and flexible paid plans for teams of any size.', 'Керований Milvus
Векторний пошук у реальному часі
Автоматичне масштабування
Безкоштовний тариф', 'Managed Milvus
Real-time vector search
Automatic scaling
Free tier', 'Командам, яким потрібна векторна база без власного адміністрування.', 'Teams that need a vector database without running it themselves.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zilliz.com/cloud' OR LOWER(`name`) = 'zilliz cloud') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A managed vector database from the creators of Milvus for real-time search and AI data operations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Zilliz Cloud is a fully managed service built on the open-source Milvus database. It runs real-time vector search, handles lake-scale datasets and takes care of tuning, scaling and reliability. There is a free tier and flexible paid plans for teams of any size.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Managed Milvus
Real-time vector search
Automatic scaling
Free tier', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams that need a vector database without running it themselves.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MongoDB Atlas (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mongodb.com/atlas' OR LOWER(`name`) = 'mongodb atlas') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- =================== Сертифікати (education-knowledge/certificates) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'education-knowledge' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'certificates' LIMIT 1);

-- Prometheus
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prometheus.org.ua' OR LOWER(`name`) = 'prometheus')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Prometheus', NULL, 'https://prometheus.org.ua/', NULL, NULL, 'Найбільша українська платформа онлайн-курсів із сертифікатами: безкоштовні та платні програми.', 'Ukraine’s largest online course platform with certificates, offering free and paid programs.', 'Prometheus публікує онлайн-курси від великих українських роботодавців і провідних світових університетів: IT, AI та робота з даними, бізнес, англійська мова, курси для освітян і військових. Після проходження курсу можна отримати сертифікат. Багато програм безкоштовні, а платні курси Prometheus+ допомагають фінансувати переклад і створення безкоштовних.', 'Prometheus publishes online courses from major Ukrainian employers and leading world universities: IT, AI and data, business, English, courses for educators and the military. A certificate is available after completing a course. Many programs are free, and paid Prometheus+ courses help fund translation and creation of free ones.', 'Курси від роботодавців і університетів
Сертифікати про проходження
Безкоштовні програми
Напрями IT, бізнес, мови, освіта', 'Courses from employers and universities
Completion certificates
Free programs
IT, business, languages, education', 'Українцям, які навчаються новій професії або підвищують кваліфікацію.', 'Ukrainians learning a new profession or upskilling.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prometheus.org.ua' OR LOWER(`name`) = 'prometheus') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukraine’s largest online course platform with certificates, offering free and paid programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Prometheus publishes online courses from major Ukrainian employers and leading world universities: IT, AI and data, business, English, courses for educators and the military. A certificate is available after completing a course. Many programs are free, and paid Prometheus+ courses help fund translation and creation of free ones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Courses from employers and universities
Completion certificates
Free programs
IT, business, languages, education', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ukrainians learning a new profession or upskilling.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Безпека даних (finance-legal/data-security) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'finance-legal' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'data-security' LIMIT 1);

-- Hive Moderation (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hivemoderation.com' OR LOWER(`name`) = 'hive moderation') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Resemble AI (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'resemble.ai' OR LOWER(`name`) = 'resemble ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- =================== Нерухомість (finance-legal/real-estate) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'finance-legal' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'real-estate' LIMIT 1);

-- Styldod
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'styldod.com' OR LOWER(`name`) = 'styldod')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Styldod', NULL, 'https://www.styldod.com/', NULL, NULL, 'AI-візуалізації для оголошень про нерухомість: віртуальне облаштування й плани оновлення з реальними товарами.', 'AI visuals for property listings: virtual staging and upgrade plans with real products.', 'Styldod створює зображення для продажу житла, які зберігають справжню структуру приміщення, і плани ремонту з реальними товарами в межах бюджету. Для агентів і брокерів є самообслуговування через ReimagineHome, а для MLS — автоматизовані процеси з перевіркою відповідності правилам. Мета — візуали, на які можна покладатися під час рішень, а не лише «гарні картинки».', 'Styldod produces home-selling visuals that preserve the real structure of a space, plus renovation plans with real products within budget. Agents and brokers can self-serve via ReimagineHome, while MLSs get automated workflows with built-in compliance checks. The goal is visuals you can rely on for decisions, not just pretty pictures.', 'Віртуальне облаштування зі збереженням планування
Плани оновлення з реальними товарами
Самообслуговування через ReimagineHome
Рішення для MLS', 'Virtual staging that keeps the real layout
Upgrade plans with real products
Self-serve via ReimagineHome
MLS solutions', 'Агентам із нерухомості, брокерам і MLS.', 'Real-estate agents, brokers and MLSs.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'styldod.com' OR LOWER(`name`) = 'styldod') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI visuals for property listings: virtual staging and upgrade plans with real products.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Styldod produces home-selling visuals that preserve the real structure of a space, plus renovation plans with real products within budget. Agents and brokers can self-serve via ReimagineHome, while MLSs get automated workflows with built-in compliance checks. The goal is visuals you can rely on for decisions, not just pretty pictures.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Virtual staging that keeps the real layout
Upgrade plans with real products
Self-serve via ReimagineHome
MLS solutions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Real-estate agents, brokers and MLSs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HouseCanary (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'housecanary.com' OR LOWER(`name`) = 'housecanary') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Zillow (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zillow.com' OR LOWER(`name`) = 'zillow') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Virtual Staging AI (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'virtualstagingai.app' OR LOWER(`name`) = 'virtual staging ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- =================== Крипто та Web3 (finance-legal/crypto-web3) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'finance-legal' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'crypto-web3' LIMIT 1);

-- Dune
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dune.com' OR LOWER(`name`) = 'dune')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dune', NULL, 'https://dune.com/', NULL, NULL, 'Нормалізовані блокчейн-дані про стейблкоїни, токенізовані активи, платежі й торгівлю — через дашборди, API і MCP.', 'Normalized blockchain data on stablecoins, tokenized assets, payments and trading — via dashboards, API and MCP.', 'Dune збирає й упорядковує ончейн-дані з багатьох мереж: пропозицію й перекази стейблкоїнів, баланси токенів на 23 EVM-мережах, токенізовані реальні активи, дані ринків прогнозів. Дані можна аналізувати SQL-запитами, публічними дашбордами й звітами або отримувати у сховище даних, через API, MCP і конектори. Частина аналітики й звітів доступна безкоштовно.', 'Dune collects and structures on-chain data across many networks: stablecoin supply and transfers, token balances on 23 EVM chains, tokenized real-world assets and prediction-market data. Data can be explored with SQL queries, public dashboards and reports, or delivered to a data warehouse, API, MCP and connectors. Some analytics and reports are free.', 'SQL-запити до блокчейн-даних
Публічні дашборди й звіти
API, MCP і конектори
Дані стейблкоїнів і токенізованих активів', 'SQL queries over blockchain data
Public dashboards and reports
API, MCP and connectors
Stablecoin and tokenized-asset data', 'Аналітикам, дослідникам і командам у сфері цифрових активів.', 'Analysts, researchers and digital-asset teams.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dune.com' OR LOWER(`name`) = 'dune') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Normalized blockchain data on stablecoins, tokenized assets, payments and trading — via dashboards, API and MCP.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dune collects and structures on-chain data across many networks: stablecoin supply and transfers, token balances on 23 EVM chains, tokenized real-world assets and prediction-market data. Data can be explored with SQL queries, public dashboards and reports, or delivered to a data warehouse, API, MCP and connectors. Some analytics and reports are free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'SQL queries over blockchain data
Public dashboards and reports
API, MCP and connectors
Stablecoin and tokenized-asset data', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Analysts, researchers and digital-asset teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Token Terminal
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tokenterminal.com' OR LOWER(`name`) = 'token terminal')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Token Terminal', NULL, 'https://tokenterminal.com/', NULL, NULL, 'Стандартизовані фінансові й користувацькі метрики блокчейнів і застосунків: комісії, дохід, користувачі.', 'Standardized financial and usage metrics for blockchains and apps: fees, revenue, users.', 'Token Terminal перетворює сирі блокчейн-дані на порівнянні метрики: комісії, дохід, кількість користувачів для мереж, застосунків і токенізованих активів. Дані збираються напряму з вузлів понад 300 блокчейнів і простежуються до конкретного блоку й транзакції. Переглядати дані можна безкоштовно, розширений доступ — за підпискою.', 'Token Terminal turns raw blockchain data into comparable metrics: fees, revenue and user counts for chains, apps and tokenized assets. Data is ingested directly from nodes of 300+ blockchains and traces back to the specific block and transaction. Browsing is free; extended access requires a subscription.', 'Порівнянні метрики протоколів
Понад 300 блокчейнів
Простежуваність до транзакції
Безкоштовний перегляд', 'Comparable protocol metrics
300+ blockchains
Traceable to the transaction
Free browsing', 'Аналітикам, інвесторам-дослідникам і журналістам крипторинку.', 'Analysts, research-minded investors and crypto journalists.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tokenterminal.com' OR LOWER(`name`) = 'token terminal') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Standardized financial and usage metrics for blockchains and apps: fees, revenue, users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Token Terminal turns raw blockchain data into comparable metrics: fees, revenue and user counts for chains, apps and tokenized assets. Data is ingested directly from nodes of 300+ blockchains and traces back to the specific block and transaction. Browsing is free; extended access requires a subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Comparable protocol metrics
300+ blockchains
Traceable to the transaction
Free browsing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Analysts, research-minded investors and crypto journalists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DefiLlama
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'defillama.com' OR LOWER(`name`) = 'defillama')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DefiLlama', NULL, 'https://defillama.com/', NULL, NULL, 'Безкоштовна аналітика DeFi без реклами: TVL, доходи, комісії, обсяги й дохідність понад 7000 протоколів.', 'Free, ad-free DeFi analytics: TVL, revenue, fees, volumes and yields across 7,000+ protocols.', 'DefiLlama відстежує загальну заблоковану вартість (TVL), доходи, комісії, обсяги торгів і дохідність у понад 7000 DeFi-протоколів на 500+ мережах. Дані відкриті й без реклами. AI-асистент LlamaAI відповідає на запитання про DeFi і новини ринку; у перший тиждень доступні безкоштовні запитання щодня.', 'DefiLlama tracks total value locked (TVL), revenue, fees, trading volumes and yields across 7,000+ DeFi protocols on 500+ chains. The data is open and ad-free. The LlamaAI assistant answers questions about DeFi and market news, with free daily questions during the first week.', 'TVL і доходи 7000+ протоколів
500+ мереж
AI-асистент LlamaAI
Без реклами', 'TVL and revenue for 7,000+ protocols
500+ chains
LlamaAI assistant
Ad-free', 'Усім, хто досліджує DeFi.', 'Anyone researching DeFi.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'defillama.com' OR LOWER(`name`) = 'defillama') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free, ad-free DeFi analytics: TVL, revenue, fees, volumes and yields across 7,000+ protocols.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DefiLlama tracks total value locked (TVL), revenue, fees, trading volumes and yields across 7,000+ DeFi protocols on 500+ chains. The data is open and ad-free. The LlamaAI assistant answers questions about DeFi and market news, with free daily questions during the first week.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'TVL and revenue for 7,000+ protocols
500+ chains
LlamaAI assistant
Ad-free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone researching DeFi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Santiment
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'santiment.net' OR LOWER(`name`) = 'santiment')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Santiment', NULL, 'https://santiment.net/', NULL, NULL, 'Поведінкова аналітика крипторинку: ончейн-, соціальні, фінансові дані та дані розробки.', 'Behavioral crypto analytics: on-chain, social, financial and development data.', 'Santiment з 2016 року збирає метрики, які допомагають досліджувати крипторинок: ончейн-активність, соціальні настрої, фінансові показники, активність розробників і спільноти. Платформа має інструменти для графіків, сповіщень і досліджень від аналітиків. Почати можна безкоштовно. Сервіс надає дані, а не інвестиційні поради.', 'Since 2016 Santiment has collected metrics that help research the crypto market: on-chain activity, social sentiment, financial indicators, developer and community activity. The platform includes charting, alerts and research from its analysts. You can start for free. It provides data, not investment advice.', 'Ончейн- і соціальні метрики
Активність розробників
Сповіщення й графіки
Безкоштовний старт', 'On-chain and social metrics
Developer activity
Alerts and charts
Free start', 'Дослідникам і аналітикам крипторинку.', 'Crypto market researchers and analysts.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'santiment.net' OR LOWER(`name`) = 'santiment') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Behavioral crypto analytics: on-chain, social, financial and development data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Since 2016 Santiment has collected metrics that help research the crypto market: on-chain activity, social sentiment, financial indicators, developer and community activity. The platform includes charting, alerts and research from its analysts. You can start for free. It provides data, not investment advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'On-chain and social metrics
Developer activity
Alerts and charts
Free start', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crypto market researchers and analysts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Chainalysis
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chainalysis.com' OR LOWER(`name`) = 'chainalysis')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Chainalysis', NULL, 'https://www.chainalysis.com/', NULL, NULL, 'Платформа блокчейн-даних і AI для розслідувань, комплаєнсу й захисту від крипто-шахрайства.', 'A blockchain data and AI platform for investigations, compliance and crypto-fraud protection.', 'Chainalysis поєднує блокчейн-дані й AI, щоб допомагати державним органам, криптобізнесу й фінансовим установам безпечно працювати з криптовалютами. Платформа відстежує рух коштів між мережами, робить швидкий AI-аналіз інцидентів, надсилає сповіщення про загрози й підтримує податковий нагляд і комплаєнс. Компанія також публікує дослідження про криптозлочинність і регулювання.', 'Chainalysis combines blockchain data and AI to help government agencies, crypto businesses and financial institutions work with crypto safely. The platform traces funds across chains, provides fast AI-assisted incident triage, alerts on threats and supports tax enforcement and compliance. The company also publishes research on crypto crime and regulation.', 'Відстеження коштів між мережами
AI-аналіз інцидентів
Сповіщення про загрози
Дослідження криптозлочинності', 'Cross-chain fund tracing
AI incident triage
Threat alerts
Crypto-crime research', 'Державним органам, біржам, банкам і службам комплаєнсу.', 'Government agencies, exchanges, banks and compliance teams.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chainalysis.com' OR LOWER(`name`) = 'chainalysis') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A blockchain data and AI platform for investigations, compliance and crypto-fraud protection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Chainalysis combines blockchain data and AI to help government agencies, crypto businesses and financial institutions work with crypto safely. The platform traces funds across chains, provides fast AI-assisted incident triage, alerts on threats and supports tax enforcement and compliance. The company also publishes research on crypto crime and regulation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cross-chain fund tracing
AI incident triage
Threat alerts
Crypto-crime research', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Government agencies, exchanges, banks and compliance teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Glassnode
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'glassnode.com' OR LOWER(`name`) = 'glassnode')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Glassnode', NULL, 'https://glassnode.com/', NULL, NULL, 'Аналітика цифрових активів: понад 1700 ончейн- і ринкових метрик, дашборди, API та дослідження.', 'Digital-asset market intelligence: 1,700+ on-chain and market metrics, dashboards, API and research.', 'Glassnode об’єднує спотові й ф’ючерсні дані, опціони, ETF, макропоказники та ончейн-метрики активності, зростання й економіки мереж для понад 1500 активів. Платформа Studio дає готові графіки й дашборди, а також доступ через API, MCP і CLI. Аналітики компанії публікують дослідження, частина з яких безкоштовна. Сервіс надає дані, а не інвестиційні поради.', 'Glassnode unifies spot and futures data, options, ETFs, macro indicators and on-chain metrics of network activity, growth and economics for 1,500+ assets. The Studio platform offers ready charts and dashboards plus access via API, MCP and CLI. Its analysts publish research, some of it free. It provides data, not investment advice.', '1700+ метрик для 1500+ активів
Дашборди Studio
API, MCP і CLI
Безкоштовні дослідження', '1,700+ metrics for 1,500+ assets
Studio dashboards
API, MCP and CLI
Free research', 'Дослідникам, аналітикам і професійним учасникам ринку.', 'Researchers, analysts and professional market participants.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'glassnode.com' OR LOWER(`name`) = 'glassnode') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Digital-asset market intelligence: 1,700+ on-chain and market metrics, dashboards, API and research.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Glassnode unifies spot and futures data, options, ETFs, macro indicators and on-chain metrics of network activity, growth and economics for 1,500+ assets. The Studio platform offers ready charts and dashboards plus access via API, MCP and CLI. Its analysts publish research, some of it free. It provides data, not investment advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '1,700+ metrics for 1,500+ assets
Studio dashboards
API, MCP and CLI
Free research', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Researchers, analysts and professional market participants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Etherscan
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'etherscan.io' OR LOWER(`name`) = 'etherscan')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Etherscan', NULL, 'https://etherscan.io/', NULL, NULL, 'Оглядач блокчейну Ethereum: пошук транзакцій, адрес, токенів і смарт-контрактів.', 'The Ethereum blockchain explorer: search transactions, addresses, tokens and smart contracts.', 'Etherscan дає змогу переглядати й шукати все, що відбувається в мережі Ethereum: транзакції, баланси адрес, токени, смарт-контракти, комісії. Можна залишати приватні нотатки до адрес і транзакцій. Для розробників є API з платними тарифами. Переглядати дані можна безкоштовно.', 'Etherscan lets you browse and search everything happening on the Ethereum network: transactions, address balances, tokens, smart contracts and fees. You can add private notes to addresses and transactions. Developers get an API with paid tiers. Browsing the data is free.', 'Пошук транзакцій і адрес
Дані токенів і смарт-контрактів
Приватні нотатки
API для розробників', 'Transaction and address search
Token and smart-contract data
Private notes
Developer API', 'Користувачам і розробникам Ethereum.', 'Ethereum users and developers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'etherscan.io' OR LOWER(`name`) = 'etherscan') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Ethereum blockchain explorer: search transactions, addresses, tokens and smart contracts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Etherscan lets you browse and search everything happening on the Ethereum network: transactions, address balances, tokens, smart contracts and fees. You can add private notes to addresses and transactions. Developers get an API with paid tiers. Browsing the data is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Transaction and address search
Token and smart-contract data
Private notes
Developer API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ethereum users and developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CoinMarketCap (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coinmarketcap.com' OR LOWER(`name`) = 'coinmarketcap') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- CoinGecko (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coingecko.com' OR LOWER(`name`) = 'coingecko') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- =================== Масаж і відновлення (health-beauty/massage-recovery) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'health-beauty' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'massage-recovery' LIMIT 1);

-- Bend
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bend.com' OR LOWER(`name`) = 'bend')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bend', NULL, 'https://www.bend.com/', NULL, NULL, 'Застосунок для щоденної розтяжки й рухливості з короткими програмами для будь-якого віку.', 'An app for daily stretching and mobility with short routines for any age.', 'Bend пропонує прості щоденні програми розтяжки з ілюстраціями й відео, щоб покращувати гнучкість і підтримувати природну амплітуду рухів. Програми підходять для різного віку й рівня підготовки, а власну можна скласти з бібліотеки вправ. Застосунок нагадує про заняття й показує прогрес. Є безкоштовний пробний період.', 'Bend offers simple daily stretching routines with illustrations and videos to improve flexibility and maintain natural range of motion. Routines suit all ages and experience levels, and you can build your own from the exercise library. The app sends reminders and tracks progress. A free trial is available.', 'Короткі щоденні програми розтяжки
Ілюстрації й відео
Власні програми з бібліотеки вправ
Нагадування й прогрес', 'Short daily stretching routines
Illustrations and videos
Custom routines from an exercise library
Reminders and progress tracking', 'Людям, які хочуть рухатися більше й бути гнучкішими.', 'People who want to move more and be more flexible.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bend.com' OR LOWER(`name`) = 'bend') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app for daily stretching and mobility with short routines for any age.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bend offers simple daily stretching routines with illustrations and videos to improve flexibility and maintain natural range of motion. Routines suit all ages and experience levels, and you can build your own from the exercise library. The app sends reminders and tracks progress. A free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Short daily stretching routines
Illustrations and videos
Custom routines from an exercise library
Reminders and progress tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to move more and be more flexible.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Compex
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'compex.com' OR LOWER(`name`) = 'compex')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Compex', NULL, 'https://www.compex.com/', NULL, NULL, 'Міостимулятори EMS і TENS та масажні пристрої для тренувань і відновлення м’язів.', 'EMS and TENS muscle stimulators and massage devices for training and muscle recovery.', 'Compex виробляє електроміостимулятори з функцією TENS (серії SP і Fit), пояс CoreBelt для м’язів кора та масажні пристрої. Їх використовують для тренувань, відновлення після навантажень і відновлення м’язового тонусу після перерви. Компанія публікує наукові дослідження про свої пристрої. Перед використанням варто порадитися з лікарем.', 'Compex makes muscle stimulators with TENS (SP and Fit series), the CoreBelt for core muscles, and massage devices. They are used for training, post-workout recovery and muscle reconditioning after inactivity. The company publishes the scientific studies behind its products. Consult a doctor before use.', 'EMS-міостимулятори з TENS
Пояс CoreBelt
Масажні пристрої
Програми для відновлення', 'EMS stimulators with TENS
CoreBelt
Massage devices
Recovery programs', 'Спортсменам і людям, які відновлюються після навантажень.', 'Athletes and people recovering from training.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'compex.com' OR LOWER(`name`) = 'compex') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'EMS and TENS muscle stimulators and massage devices for training and muscle recovery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Compex makes muscle stimulators with TENS (SP and Fit series), the CoreBelt for core muscles, and massage devices. They are used for training, post-workout recovery and muscle reconditioning after inactivity. The company publishes the scientific studies behind its products. Consult a doctor before use.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'EMS stimulators with TENS
CoreBelt
Massage devices
Recovery programs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Athletes and people recovering from training.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Renpho
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'renpho.com' OR LOWER(`name`) = 'renpho')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Renpho', NULL, 'https://renpho.com/', NULL, NULL, 'Масажери, розумні ваги й інші пристрої для здоров’я, що працюють разом із застосунком Renpho.', 'Massagers, smart scales and other wellness devices that work with the Renpho app.', 'Renpho випускає доступні пристрої для домашнього догляду за здоров’ям: масажери для очей, шиї, ніг і масажні пістолети, а також розумні ваги з аналізом складу тіла та кухонні ваги з відстеженням харчування. Дані з пристроїв синхронізуються в застосунку Renpho.', 'Renpho makes affordable home wellness devices: massagers for eyes, neck and feet and massage guns, plus smart scales with body-composition analysis and kitchen scales with nutrition tracking. Device data syncs to the Renpho app.', 'Масажери й масажні пістолети
Розумні ваги зі складом тіла
Кухонні ваги з відстеженням харчування
Застосунок Renpho', 'Massagers and massage guns
Smart body-composition scales
Kitchen scales with nutrition tracking
Renpho app', 'Людям, які доглядають за здоров’ям удома.', 'People looking after their wellness at home.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'renpho.com' OR LOWER(`name`) = 'renpho') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Massagers, smart scales and other wellness devices that work with the Renpho app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Renpho makes affordable home wellness devices: massagers for eyes, neck and feet and massage guns, plus smart scales with body-composition analysis and kitchen scales with nutrition tracking. Device data syncs to the Renpho app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Massagers and massage guns
Smart body-composition scales
Kitchen scales with nutrition tracking
Renpho app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking after their wellness at home.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hyperice (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hyperice.com' OR LOWER(`name`) = 'hyperice') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- GOWOD (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gowod.app' OR LOWER(`name`) = 'gowod') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- pliability (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pliability.com' OR LOWER(`name`) = 'pliability') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- STRETCHIT (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stretchitapp.com' OR LOWER(`name`) = 'stretchit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- =================== Сон (health-beauty/sleep) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'health-beauty' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'sleep' LIMIT 1);

-- BetterSleep
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bettersleep.com' OR LOWER(`name`) = 'bettersleep')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BetterSleep', NULL, 'https://www.bettersleep.com/', NULL, NULL, 'Застосунок для сну з медитаціями, історіями, звуками для засинання та відстеженням сну.', 'A sleep app with meditations, stories, sleep sounds and sleep tracking.', 'BetterSleep допомагає розслабитися й заснути: дає змогу змішувати власні звукові доріжки, слухати історії перед сном, керовані медитації та гіпноз. Застосунок відстежує сон і записує звуки вночі. Є безкоштовний пробний період, далі — підписка.', 'BetterSleep helps you relax and fall asleep: mix your own sound blends, listen to bedtime stories, guided meditations and hypnosis. The app tracks sleep and records night-time sounds. There is a free trial, followed by a subscription.', 'Власні мікси звуків для сну
Історії й медитації
Відстеження та запис сну
Безкоштовний пробний період', 'Custom sleep-sound mixes
Stories and meditations
Sleep tracking and recording
Free trial', 'Людям, яким важко розслабитися й заснути.', 'People who find it hard to relax and fall asleep.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bettersleep.com' OR LOWER(`name`) = 'bettersleep') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A sleep app with meditations, stories, sleep sounds and sleep tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BetterSleep helps you relax and fall asleep: mix your own sound blends, listen to bedtime stories, guided meditations and hypnosis. The app tracks sleep and records night-time sounds. There is a free trial, followed by a subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Custom sleep-sound mixes
Stories and meditations
Sleep tracking and recording
Free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who find it hard to relax and fall asleep.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SleepScore
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sleep.ai/sleepscore' OR LOWER(`name`) = 'sleepscore')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SleepScore', NULL, 'https://www.sleep.ai/sleepscore/', NULL, NULL, 'Застосунок, що відстежує сон за допомогою сонара смартфона й дає поради на основі досліджень.', 'An app that tracks sleep with smartphone sonar and gives research-based coaching.', 'SleepScore вимірює сон без носимих пристроїв: смартфон біля ліжка використовує запатентовану сонарну технологію. Застосунок оцінює якість сну й дає науково обґрунтовані поради, щоб швидше засинати й краще висипатися. Компанія Sleep.ai також співпрацює з університетами й публікує рецензовані дослідження.', 'SleepScore measures sleep without wearables: a phone by the bed uses patented sonar technology. The app scores sleep quality and offers science-based coaching to fall asleep faster and sleep better. Its company, Sleep.ai, also works with universities and publishes peer-reviewed research.', 'Відстеження сну без браслета
Сонарна технологія смартфона
Оцінка якості сну
Поради на основі досліджень', 'Sleep tracking without wearables
Smartphone sonar technology
Sleep-quality score
Research-based coaching', 'Людям, які хочуть зрозуміти й покращити свій сон.', 'People who want to understand and improve their sleep.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sleep.ai/sleepscore' OR LOWER(`name`) = 'sleepscore') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app that tracks sleep with smartphone sonar and gives research-based coaching.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SleepScore measures sleep without wearables: a phone by the bed uses patented sonar technology. The app scores sleep quality and offers science-based coaching to fall asleep faster and sleep better. Its company, Sleep.ai, also works with universities and publishes peer-reviewed research.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sleep tracking without wearables
Smartphone sonar technology
Sleep-quality score
Research-based coaching', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to understand and improve their sleep.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Loóna
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'loona.app' OR LOWER(`name`) = 'loóna')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Loóna', NULL, 'https://loona.app/', NULL, NULL, 'Застосунок для вечірнього розслаблення: розфарбовування діорам під заспокійливу розповідь.', 'An evening wind-down app: coloring dioramas to calming narration.', 'Loóna пропонує «Escapes» — інтерактивні вечірні сесії, де ви розфарбовуєте чарівну діораму, яка обертається, під заспокійливу розповідь. Заняття м’яко займає увагу, щоб відволіктися від нав’язливих думок перед сном, і допомагає створити спокійний вечірній ритуал.', 'Loóna offers Escapes — interactive evening sessions where you color a magical rotating diorama while guided by soothing narration. The activity gently occupies your mind to quiet racing thoughts before bed and helps build a calm night-time routine.', 'Інтерактивні сесії Escapes
Розфарбовування діорам
Заспокійлива розповідь
Вечірній ритуал', 'Interactive Escapes sessions
Diorama coloring
Soothing narration
Night-time routine', 'Людям, яким заважають заснути тривожні думки.', 'People whose racing thoughts keep them awake.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'loona.app' OR LOWER(`name`) = 'loóna') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An evening wind-down app: coloring dioramas to calming narration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Loóna offers Escapes — interactive evening sessions where you color a magical rotating diorama while guided by soothing narration. The activity gently occupies your mind to quiet racing thoughts before bed and helps build a calm night-time routine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Interactive Escapes sessions
Diorama coloring
Soothing narration
Night-time routine', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People whose racing thoughts keep them awake.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Перевірка симптомів (health-beauty/symptom-checkers) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'health-beauty' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'symptom-checkers' LIMIT 1);

-- Buoy Health
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'buoyhealth.com' OR LOWER(`name`) = 'buoy health')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Buoy Health', NULL, 'https://www.buoyhealth.com/', NULL, NULL, 'AI-помічник, який ставить уточнювальні запитання про симптоми й підказує, куди звернутися по допомогу.', 'An AI assistant that asks follow-up questions about symptoms and suggests where to seek care.', 'Buoy Health ставить запитання з урахуванням вашої ситуації й допомагає звузити можливі причини нездужання, а потім підказує відповідний варіант допомоги: від самодогляду до візиту до лікаря. Довідкові статті перевіряють медичні експерти, а команда рецензентів допомагає обрати сервіс чи фахівця. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Buoy Health asks questions tailored to your situation, helps narrow down possible causes of feeling unwell, and then points to a suitable care option, from self-care to seeing a doctor. Its articles are vetted by medical experts, and a reviewer team helps choose a service or specialist. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'AI-опитування про симптоми
Можливі причини й варіанти допомоги
Статті, перевірені експертами
Безкоштовна перевірка', 'AI symptom questionnaire
Possible causes and care options
Expert-vetted articles
Free check', 'Дорослим у США, які хочуть зрозуміти, куди звернутися.', 'Adults in the US who want to know where to seek care.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'buoyhealth.com' OR LOWER(`name`) = 'buoy health') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI assistant that asks follow-up questions about symptoms and suggests where to seek care.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Buoy Health asks questions tailored to your situation, helps narrow down possible causes of feeling unwell, and then points to a suitable care option, from self-care to seeing a doctor. Its articles are vetted by medical experts, and a reviewer team helps choose a service or specialist. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI symptom questionnaire
Possible causes and care options
Expert-vetted articles
Free check', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults in the US who want to know where to seek care.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ubie
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ubiehealth.com' OR LOWER(`name`) = 'ubie')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ubie', NULL, 'https://ubiehealth.com/', NULL, NULL, 'Безкоштовна AI-перевірка симптомів: 3-хвилинна анкета й звіт про можливі причини.', 'A free AI symptom checker: a 3-minute questionnaire and a report on possible causes.', 'Ubie ставить запитання, адаптовані до ваших симптомів, віку, статі та історії хвороб, і за кілька хвилин формує безкоштовний звіт із можливими причинами. Звіт допомагає підготуватися до розмови з лікарем і зрозуміти, до якого фахівця звернутися. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Ubie asks questions adapted to your symptoms, age, sex and medical history and produces a free report of possible causes within minutes. The report helps you prepare to talk to a doctor and understand which specialist to see. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Анкета на 3 хвилини
Звіт про можливі причини
Урахування віку, статі й історії
Безкоштовно', '3-minute questionnaire
Report on possible causes
Accounts for age, sex and history
Free', 'Дорослим, які хочуть краще зрозуміти свої симптоми перед візитом до лікаря.', 'Adults who want to understand their symptoms before seeing a doctor.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ubiehealth.com' OR LOWER(`name`) = 'ubie') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free AI symptom checker: a 3-minute questionnaire and a report on possible causes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ubie asks questions adapted to your symptoms, age, sex and medical history and produces a free report of possible causes within minutes. The report helps you prepare to talk to a doctor and understand which specialist to see. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3-minute questionnaire
Report on possible causes
Accounts for age, sex and history
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults who want to understand their symptoms before seeing a doctor.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Infermedica
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'infermedica.com' OR LOWER(`name`) = 'infermedica')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Infermedica', NULL, 'https://infermedica.com/', NULL, NULL, 'Клінічний AI-тріаж для медичних організацій: допомагає спрямувати пацієнта до потрібної допомоги.', 'Clinical AI triage for healthcare organizations that helps route patients to the right care.', 'Infermedica — B2B-платформа медичного AI для страховиків, лікарень і телемедичних сервісів. Її модуль тріажу збирає симптоми пацієнта й рекомендує відповідний рівень допомоги, щоб пацієнт отримав правильну допомогу вчасно. Компанія також розробила публічний перевіряльник симптомів Symptomate. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Infermedica is a B2B medical AI platform for insurers, hospitals and telehealth services. Its triage module collects a patient’s symptoms and recommends the appropriate level of care so patients get the right care at the right time. The company also built the public Symptomate symptom checker. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'AI-тріаж симптомів
Рекомендація рівня допомоги
Інтеграція в сервіси медичних організацій
Від творців Symptomate', 'AI symptom triage
Care-level recommendation
Integration into healthcare services
From the makers of Symptomate', 'Страховикам, клінікам і телемедичним компаніям.', 'Insurers, clinics and telehealth companies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'infermedica.com' OR LOWER(`name`) = 'infermedica') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Clinical AI triage for healthcare organizations that helps route patients to the right care.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Infermedica is a B2B medical AI platform for insurers, hospitals and telehealth services. Its triage module collects a patient’s symptoms and recommends the appropriate level of care so patients get the right care at the right time. The company also built the public Symptomate symptom checker. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI symptom triage
Care-level recommendation
Integration into healthcare services
From the makers of Symptomate', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Insurers, clinics and telehealth companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mediktor
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mediktor.com' OR LOWER(`name`) = 'mediktor')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mediktor', NULL, 'https://www.mediktor.com/', NULL, NULL, 'Розмовний AI-асистент для оцінки симптомів і спрямування пацієнтів, створений лікарями.', 'A conversational AI assistant, created by doctors, for symptom assessment and patient routing.', 'Mediktor пропонує перевірку симптомів для пацієнтів і платформу для страховиків, клінік, фармкомпаній і телемедицини. Розмовний асистент збирає скарги, спрямовує людину до відповідної послуги, допомагає виявляти недіагностовані стани й підтримує дотримання лікування через AI-нагадування. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Mediktor offers a symptom checker for patients and a platform for insurers, clinics, pharma and telehealth. The conversational assistant gathers complaints, routes people to the right service, helps flag undiagnosed conditions and supports treatment adherence with AI follow-ups. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Перевірка симптомів для пацієнтів
Спрямування до потрібної послуги
AI-супровід лікування
Рішення для бізнесу', 'Symptom checker for patients
Routing to the right service
AI treatment follow-up
Business solutions', 'Пацієнтам і медичним організаціям.', 'Patients and healthcare organizations.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mediktor.com' OR LOWER(`name`) = 'mediktor') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A conversational AI assistant, created by doctors, for symptom assessment and patient routing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mediktor offers a symptom checker for patients and a platform for insurers, clinics, pharma and telehealth. The conversational assistant gathers complaints, routes people to the right service, helps flag undiagnosed conditions and supports treatment adherence with AI follow-ups. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Symptom checker for patients
Routing to the right service
AI treatment follow-up
Business solutions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Patients and healthcare organizations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Doctronic
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'doctronic.ai' OR LOWER(`name`) = 'doctronic')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Doctronic', NULL, 'https://www.doctronic.ai/', NULL, NULL, 'Безкоштовний анонімний AI-чат про симптоми з можливістю платної онлайн-консультації лікаря у США.', 'A free, anonymous AI chat about symptoms with an option for paid online doctor visits in the US.', 'Doctronic дає змогу безкоштовно й анонімно описати симптоми AI-асистенту, отримати пояснення й план дій, а за потреби — записатися на онлайн-прийом ліцензованого лікаря у США (оплата за візит або страховкою). Лікар бачить історію розмови, тож не доводиться повторювати все спочатку. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Doctronic lets you describe symptoms to an AI assistant for free and anonymously, get explanations and an action plan, and, if needed, book an online visit with a licensed US doctor (pay per visit or via insurance). The doctor sees the conversation history, so you don’t have to repeat everything. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Безкоштовний анонімний AI-чат
План дій за симптомами
Онлайн-лікар у США
Передача історії лікарю', 'Free, anonymous AI chat
Action plan for symptoms
Online doctors in the US
History shared with the doctor', 'Дорослим у США, які шукають швидку довідку про симптоми.', 'Adults in the US looking for quick symptom guidance.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'doctronic.ai' OR LOWER(`name`) = 'doctronic') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free, anonymous AI chat about symptoms with an option for paid online doctor visits in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Doctronic lets you describe symptoms to an AI assistant for free and anonymously, get explanations and an action plan, and, if needed, book an online visit with a licensed US doctor (pay per visit or via insurance). The doctor sees the conversation history, so you don’t have to repeat everything. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free, anonymous AI chat
Action plan for symptoms
Online doctors in the US
History shared with the doctor', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults in the US looking for quick symptom guidance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Догляд за шкірою (health-beauty/skin-care) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'health-beauty' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'skin-care' LIMIT 1);

-- Miiskin
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'miiskin.com' OR LOWER(`name`) = 'miiskin')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Miiskin', NULL, 'https://miiskin.com/', NULL, NULL, 'Телемедична платформа онлайн-консультацій із незалежними сертифікованими дерматологами у США.', 'A teledermatology platform for online consultations with independent board-certified dermatologists in the US.', 'Miiskin з’єднує пацієнтів у всіх штатах США з незалежними сертифікованими дерматологами. Пацієнт сам обирає лікаря, може продовжувати лікування з ним і отримувати рецепти в будь-якій аптеці. Платформа відповідає вимогам HIPAA і не продає ліки напряму. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Miiskin connects patients in all US states with independent board-certified dermatologists. Patients choose their own doctor, can keep seeing them for follow-ups and fill prescriptions at any pharmacy. The platform is HIPAA-compliant and does not sell medications directly. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Онлайн-консультації дерматолога
Вибір власного лікаря
Рецепти в будь-яку аптеку
Відповідність HIPAA', 'Online dermatology visits
Choose your own doctor
Prescriptions to any pharmacy
HIPAA-compliant', 'Дорослим у США з проблемами шкіри та волосся.', 'Adults in the US with skin and hair concerns.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'miiskin.com' OR LOWER(`name`) = 'miiskin') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A teledermatology platform for online consultations with independent board-certified dermatologists in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Miiskin connects patients in all US states with independent board-certified dermatologists. Patients choose their own doctor, can keep seeing them for follow-ups and fill prescriptions at any pharmacy. The platform is HIPAA-compliant and does not sell medications directly. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online dermatology visits
Choose your own doctor
Prescriptions to any pharmacy
HIPAA-compliant', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults in the US with skin and hair concerns.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Proven Skincare
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'provenskincare.com' OR LOWER(`name`) = 'proven skincare')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Proven Skincare', NULL, 'https://www.provenskincare.com/', NULL, NULL, 'Персоналізований догляд за шкірою: формули підлаштовуються під тип шкіри, спосіб життя й довкілля.', 'Personalized skincare with formulas adapted to your skin, lifestyle and environment.', 'Proven Skincare складає засоби догляду під конкретну людину: враховує тип і цілі шкіри, спосіб життя та умови довкілля, де ви живете. Формули містять клінічно перевірені активні інгредієнти й змінюються разом із потребами шкіри.', 'Proven Skincare builds skincare for the individual, taking into account skin type and goals, lifestyle and the environment where you live. Formulas use clinically proven active ingredients and evolve with your skin’s needs.', 'Персоналізовані формули
Урахування довкілля й способу життя
Клінічно перевірені активні інгредієнти
Оновлення формули з часом', 'Personalized formulas
Accounts for environment and lifestyle
Clinically proven actives
Formula updates over time', 'Людям, які хочуть індивідуальний догляд замість підбору навмання.', 'People who want tailored skincare instead of guesswork.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'provenskincare.com' OR LOWER(`name`) = 'proven skincare') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Personalized skincare with formulas adapted to your skin, lifestyle and environment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Proven Skincare builds skincare for the individual, taking into account skin type and goals, lifestyle and the environment where you live. Formulas use clinically proven active ingredients and evolve with your skin’s needs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personalized formulas
Accounts for environment and lifestyle
Clinically proven actives
Formula updates over time', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want tailored skincare instead of guesswork.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dermatica
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dermatica.com' OR LOWER(`name`) = 'dermatica')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dermatica', NULL, 'https://www.dermatica.com/', NULL, NULL, 'Онлайн-лікування за рецептом від акне, пігментації, розацеа та ознак старіння шкіри.', 'Online prescription treatment for acne, hyperpigmentation, rosacea and signs of skin aging.', 'Dermatica пропонує засоби за рецептом після онлайн-оцінки, а також лінійку очищувальних засобів, сироваток із ретиналем і зволожувачів. Медичні фахівці проводять безкоштовні контрольні консультації, перший місяць доступний як пробний період. Персональні формули сервіс більше не приймає. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Dermatica offers prescription treatments after an online assessment, plus a range of cleansers, retinal serums and moisturizers. Clinicians provide free follow-up check-ins, and the first month is available as a trial. The service no longer accepts personalized formula requests. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Лікування за рецептом онлайн
Сироватки з ретиналем
Безкоштовні контрольні консультації
Пробний місяць', 'Online prescription treatment
Retinal serums
Free follow-up check-ins
Trial month', 'Дорослим із проблемами шкіри, переважно у Великій Британії та США.', 'Adults with skin concerns, mainly in the UK and US.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dermatica.com' OR LOWER(`name`) = 'dermatica') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online prescription treatment for acne, hyperpigmentation, rosacea and signs of skin aging.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dermatica offers prescription treatments after an online assessment, plus a range of cleansers, retinal serums and moisturizers. Clinicians provide free follow-up check-ins, and the first month is available as a trial. The service no longer accepts personalized formula requests. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online prescription treatment
Retinal serums
Free follow-up check-ins
Trial month', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults with skin concerns, mainly in the UK and US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Skin Bliss
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getskinbliss.com' OR LOWER(`name`) = 'skin bliss')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Skin Bliss', NULL, 'https://getskinbliss.com/', NULL, NULL, 'Сканер косметики: перевіряє, чи підходить засіб вашій шкірі, і складає ранкову й вечірню рутину.', 'A skincare scanner that checks whether a product suits your skin and builds morning and evening routines.', 'Skin Bliss один раз дізнається тип шкіри, проблеми та чутливість, а потім для кожного засобу показує оцінку сумісності з поясненням. Засоби можна сканувати за штрихкодом, шукати за назвою або сфотографувати всю полицю. Сканування обличчя допомагає стежити за змінами шкіри. Застосунок безкоштовний, Pro — за бажанням.', 'Skin Bliss learns your skin type, concerns and sensitivities once, then gives every product a match score with reasons. Scan a barcode, search by name or photograph your whole shelf. A face scan helps track skin changes over time. The app is free, with optional Pro.', 'Оцінка сумісності засобів
Сканування штрихкоду й полиці
Конструктор рутини
Безкоштовно, Pro за бажанням', 'Product match scores
Barcode and shelf scanning
Routine builder
Free, optional Pro', 'Людям, які підбирають косметику під свою шкіру.', 'People choosing skincare for their own skin.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getskinbliss.com' OR LOWER(`name`) = 'skin bliss') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A skincare scanner that checks whether a product suits your skin and builds morning and evening routines.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Skin Bliss learns your skin type, concerns and sensitivities once, then gives every product a match score with reasons. Scan a barcode, search by name or photograph your whole shelf. A face scan helps track skin changes over time. The app is free, with optional Pro.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Product match scores
Barcode and shelf scanning
Routine builder
Free, optional Pro', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People choosing skincare for their own skin.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- First Derm
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firstderm.com' OR LOWER(`name`) = 'first derm')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'First Derm', NULL, 'https://www.firstderm.com/', NULL, NULL, 'Анонімна онлайн-консультація дерматолога за фото, без запису й реєстрації, та AI-пошук за зображенням.', 'Anonymous online dermatology by photo, no appointment or account, plus AI skin image search.', 'First Derm дає змогу завантажити два фото проблемної ділянки шкіри й короткий опис, а сертифікований дерматолог надішле оцінку. Реєстрація не потрібна, консультації доступні для дорослих, підлітків і дітей. Окремо є AI-інструмент Skin Image Search для попереднього пошуку схожих станів. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'First Derm lets you upload two photos of a skin concern and a short description, and a board-certified dermatologist sends an assessment. No account is needed, and consultations are available for adults, teens and children. There is also an AI Skin Image Search tool for a preliminary look at similar conditions. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Консультація за фото
Анонімно, без реєстрації
Для дорослих і дітей
AI Skin Image Search', 'Photo-based consultation
Anonymous, no account
For adults and children
AI Skin Image Search', 'Людям, які хочуть швидку думку дерматолога.', 'People who want a quick dermatologist opinion.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firstderm.com' OR LOWER(`name`) = 'first derm') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Anonymous online dermatology by photo, no appointment or account, plus AI skin image search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'First Derm lets you upload two photos of a skin concern and a short description, and a board-certified dermatologist sends an assessment. No account is needed, and consultations are available for adults, teens and children. There is also an AI Skin Image Search tool for a preliminary look at similar conditions. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo-based consultation
Anonymous, no account
For adults and children
AI Skin Image Search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want a quick dermatologist opinion.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- YouCam Makeup (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'youcamapps.com' OR LOWER(`name`) = 'youcam makeup') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- =================== Жіноче здоров'я (health-beauty/womens-health) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'health-beauty' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'womens-health' LIMIT 1);

-- Ovia
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oviahealth.com' OR LOWER(`name`) = 'ovia')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ovia', NULL, 'https://www.oviahealth.com/', NULL, NULL, 'Платформа здоров’я жінок і родин: фертильність, вагітність, батьківство й підтримка медичної команди.', 'A women’s and family health platform covering fertility, pregnancy, parenting and care-team support.', 'Ovia Health пропонує доказові програми, персоналізовані поради на основі даних і підтримку команди медичних фахівців на всіх етапах: від планування вагітності до батьківства й здоров’я жінки в різному віці. Платформа доступна передусім через роботодавців і страхові плани у США. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Ovia Health offers evidence-based programs, personalized data insights and care-team support at every stage, from planning a pregnancy to parenting and women’s health at any age. It is mainly available through employers and health plans in the US. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Програми з фертильності й вагітності
Підтримка батьків
Персоналізовані поради
Команда медичних фахівців', 'Fertility and pregnancy programs
Parenting support
Personalized insights
Care team', 'Жінкам і родинам, роботодавцям і страховикам у США.', 'Women and families, employers and health plans in the US.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oviahealth.com' OR LOWER(`name`) = 'ovia') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A women’s and family health platform covering fertility, pregnancy, parenting and care-team support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ovia Health offers evidence-based programs, personalized data insights and care-team support at every stage, from planning a pregnancy to parenting and women’s health at any age. It is mainly available through employers and health plans in the US. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fertility and pregnancy programs
Parenting support
Personalized insights
Care team', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Women and families, employers and health plans in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Maven Clinic
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mavenclinic.com' OR LOWER(`name`) = 'maven clinic')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Maven Clinic', NULL, 'https://www.mavenclinic.com/', NULL, NULL, 'Віртуальна клініка для жінок і родин: фертильність, вагітність, післяпологовий період, менопауза й педіатрія.', 'A virtual clinic for women and families: fertility, pregnancy, postpartum, menopause and pediatrics.', 'Maven Clinic дає учасникам доступ до лікарів і фахівців онлайн на шляху до вагітності, під час неї, після пологів і повернення на роботу, а також під час менопаузи. Батькам доступна педіатрична допомога 24/7. Сервіс безкоштовний для учасників, бо його оплачують понад 2300 роботодавців і страхових планів. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Maven Clinic gives members online access to doctors and specialists on the path to pregnancy, during pregnancy, postpartum and return to work, and through menopause. Parents get 24/7 pediatric care. It is free for members because it is covered by 2,300+ employers and health plans. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Онлайн-фахівці з жіночого здоров’я
Супровід вагітності й післяпологового періоду
Педіатрія 24/7
Оплачує роботодавець або страховка', 'Online women’s health specialists
Pregnancy and postpartum support
24/7 pediatrics
Covered by employer or health plan', 'Працівникам компаній-партнерів Maven та їхнім родинам.', 'Employees of Maven partner companies and their families.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mavenclinic.com' OR LOWER(`name`) = 'maven clinic') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A virtual clinic for women and families: fertility, pregnancy, postpartum, menopause and pediatrics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Maven Clinic gives members online access to doctors and specialists on the path to pregnancy, during pregnancy, postpartum and return to work, and through menopause. Parents get 24/7 pediatric care. It is free for members because it is covered by 2,300+ employers and health plans. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online women’s health specialists
Pregnancy and postpartum support
24/7 pediatrics
Covered by employer or health plan', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Employees of Maven partner companies and their families.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Perifit
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'perifit.co' OR LOWER(`name`) = 'perifit')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Perifit', NULL, 'https://perifit.co/', NULL, NULL, 'Тренажер м’язів тазового дна з відеоіграми, а також молоковідсмоктувачі для жінок.', 'A pelvic-floor trainer controlled through video games, plus breast pumps for women.', 'Perifit — пристрій для тренування м’язів тазового дна, який підключається до застосунку: вправи виконуються як відеоігри, де ви керуєте персонажем скороченням м’язів. Компанія також випускає носимі молоковідсмоктувачі Perifit Pump і кульки для вправ Perifit Pearls. Продукти орієнтовані на відновлення після пологів і підтримку жінок різного віку. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Perifit is a pelvic-floor training device that connects to an app: exercises play like video games where you control a character with your muscle contractions. The company also makes the wearable Perifit Pump breast pumps and Perifit Pearls exercise balls. The products focus on postpartum recovery and supporting women of all ages. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Тренування тазового дна через ігри
Застосунок із прогресом
Носимі молоковідсмоктувачі
Кульки Perifit Pearls', 'Pelvic-floor training through games
App with progress tracking
Wearable breast pumps
Perifit Pearls exercise balls', 'Жінкам після пологів і всім, хто хоче зміцнити тазове дно.', 'Postpartum women and anyone wanting a stronger pelvic floor.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'perifit.co' OR LOWER(`name`) = 'perifit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A pelvic-floor trainer controlled through video games, plus breast pumps for women.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Perifit is a pelvic-floor training device that connects to an app: exercises play like video games where you control a character with your muscle contractions. The company also makes the wearable Perifit Pump breast pumps and Perifit Pearls exercise balls. The products focus on postpartum recovery and supporting women of all ages. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pelvic-floor training through games
App with progress tracking
Wearable breast pumps
Perifit Pearls exercise balls', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Postpartum women and anyone wanting a stronger pelvic floor.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Balance
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'balance-app.com' OR LOWER(`name`) = 'balance')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Balance', NULL, 'https://balance-app.com/', NULL, NULL, 'Безкоштовний застосунок про гормональне здоров’я: перименопауза, менопауза, ПМС, ендометріоз, СПКЯ.', 'A free hormone-health app: perimenopause, menopause, PMS, endometriosis, PCOS.', 'Balance допомагає зрозуміти, як гормони впливають на самопочуття. Застосунок дає змогу записувати симптоми й містить сотні матеріалів на основі доказів про ПМС, ПМДР, післяпологову депресію, ендометріоз, СПКЯ, перименопаузу й менопаузу. Є підтримувальна спільнота. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Balance helps you understand how hormones affect how you feel. The app lets you log symptoms and offers hundreds of evidence-based resources on PMS, PMDD, postnatal depression, endometriosis, PCOS, perimenopause and menopause. There is a supportive community. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Журнал симптомів
Доказові матеріали про гормони
Перименопауза й менопауза
Спільнота', 'Symptom log
Evidence-based hormone resources
Perimenopause and menopause
Community', 'Жінкам, які хочуть краще розуміти гормональні зміни.', 'Women who want to understand hormonal changes better.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'balance-app.com' OR LOWER(`name`) = 'balance') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free hormone-health app: perimenopause, menopause, PMS, endometriosis, PCOS.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Balance helps you understand how hormones affect how you feel. The app lets you log symptoms and offers hundreds of evidence-based resources on PMS, PMDD, postnatal depression, endometriosis, PCOS, perimenopause and menopause. There is a supportive community. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Symptom log
Evidence-based hormone resources
Perimenopause and menopause
Community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Women who want to understand hormonal changes better.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Premom
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'premom.com' OR LOWER(`name`) = 'premom')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Premom', NULL, 'https://premom.com/', NULL, NULL, 'Безкоштовний трекер циклу й овуляції з цифровим зчитуванням домашніх тестів на овуляцію.', 'A free period and ovulation tracker that digitally reads at-home ovulation tests.', 'Premom допомагає визначити фертильні дні: застосунок зчитує результати домашніх тестів на овуляцію з фото, будує графіки фертильності й працює з Bluetooth-термометрами для базальної температури. Окремий режим PCOS Pro розрахований на нерегулярні цикли. Є віртуальні консультації з фахівцями. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Premom helps identify fertile days: the app reads at-home ovulation test results from a photo, builds fertility charts and works with Bluetooth basal thermometers. A separate PCOS Pro mode is designed for irregular cycles. Virtual consultations with specialists are available. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Зчитування тестів на овуляцію
Графіки фертильності
Bluetooth-термометр
Режим PCOS Pro', 'Ovulation test reader
Fertility charts
Bluetooth thermometer
PCOS Pro mode', 'Жінкам, які планують вагітність.', 'Women trying to conceive.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'premom.com' OR LOWER(`name`) = 'premom') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free period and ovulation tracker that digitally reads at-home ovulation tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Premom helps identify fertile days: the app reads at-home ovulation test results from a photo, builds fertility charts and works with Bluetooth basal thermometers. A separate PCOS Pro mode is designed for irregular cycles. Virtual consultations with specialists are available. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ovulation test reader
Fertility charts
Bluetooth thermometer
PCOS Pro mode', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Women trying to conceive.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Elvie
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'elvie.com' OR LOWER(`name`) = 'elvie')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Elvie', NULL, 'https://elvie.com/', NULL, NULL, 'Технології для жінок: тренажер тазового дна Elvie Trainer, носимі молоковідсмоктувачі та розумна колиска.', 'Technology for women: the Elvie Trainer pelvic-floor device, wearable breast pumps and a smart bassinet.', 'Elvie створює продукти для жіночого здоров’я та материнства: тренажер тазового дна Elvie Trainer із застосунком, тихі носимі молоковідсмоктувачі Elvie Pump і Stride, а також розумний шезлонг-колиску Elvie Rise. Застосунки допомагають відстежувати вправи й годування. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Elvie makes products for women’s health and motherhood: the app-connected Elvie Trainer for the pelvic floor, the quiet wearable Elvie Pump and Stride breast pumps, and the Elvie Rise smart bouncer-bassinet. The apps help track exercises and feeding. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Тренажер тазового дна із застосунком
Носимі молоковідсмоктувачі
Розумна колиска Elvie Rise
Відстеження в застосунку', 'App-connected pelvic-floor trainer
Wearable breast pumps
Elvie Rise smart bassinet
App tracking', 'Жінкам і молодим мамам.', 'Women and new mothers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'elvie.com' OR LOWER(`name`) = 'elvie') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Technology for women: the Elvie Trainer pelvic-floor device, wearable breast pumps and a smart bassinet.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Elvie makes products for women’s health and motherhood: the app-connected Elvie Trainer for the pelvic floor, the quiet wearable Elvie Pump and Stride breast pumps, and the Elvie Rise smart bouncer-bassinet. The apps help track exercises and feeding. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'App-connected pelvic-floor trainer
Wearable breast pumps
Elvie Rise smart bassinet
App tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Women and new mothers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mira
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'miracare.com' OR LOWER(`name`) = 'mira')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mira', NULL, 'https://www.miracare.com/', NULL, NULL, 'Домашній монітор гормонів для відстеження овуляції, фертильності й перименопаузи.', 'An at-home hormone monitor for tracking ovulation, fertility and perimenopause.', 'Mira вимірює рівні гормонів за тест-смужками вдома й показує в застосунку персоналізований прогноз овуляції. Система підходить для різних циклів, має режим для перименопаузи, ранній тест на вагітність і домашній тест якості сперми. Застосунок безкоштовний, аналізатор і смужки купуються окремо. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Mira measures hormone levels from test wands at home and shows personalized ovulation tracking in its app. It suits different cycles and includes a perimenopause mode, an early pregnancy test and an at-home sperm test. The app is free; the analyzer and wands are purchased separately. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Вимірювання гормонів удома
Персоналізоване відстеження овуляції
Режим перименопаузи
Безкоштовний застосунок', 'At-home hormone measurement
Personalized ovulation tracking
Perimenopause mode
Free app', 'Жінкам, які планують вагітність або проходять перименопаузу.', 'Women trying to conceive or going through perimenopause.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'miracare.com' OR LOWER(`name`) = 'mira') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An at-home hormone monitor for tracking ovulation, fertility and perimenopause.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mira measures hormone levels from test wands at home and shows personalized ovulation tracking in its app. It suits different cycles and includes a perimenopause mode, an early pregnancy test and an at-home sperm test. The app is free; the analyzer and wands are purchased separately. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'At-home hormone measurement
Personalized ovulation tracking
Perimenopause mode
Free app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Women trying to conceive or going through perimenopause.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Oova
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oova.life' OR LOWER(`name`) = 'oova')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Oova', NULL, 'https://www.oova.life/', NULL, NULL, 'Щоденний домашній тест і застосунок, що показують зміни рівнів гормонів для фертильності й перименопаузи.', 'A daily at-home test and app that show hormone patterns for fertility and perimenopause.', 'Oova дає змогу вдома зробити тест сечі й за допомогою застосунку отримати кількісні рівні гормонів LH, E3G і PdG приблизно за 10 хвилин, без окремого пристрою. Застосунок показує, як змінюються гормони від циклу до циклу та як з ними пов’язані симптоми. Результатами можна поділитися з лікарем. Сервіс використовують понад 600 клінік. Сервіс не замінює консультацію лікаря; у невідкладних випадках звертайтеся по екстрену допомогу.', 'Oova lets you take a urine test at home and get quantitative LH, E3G and PdG levels in about 10 minutes via the app, with no separate device. The app shows how hormones change across cycles and how symptoms align with them. Results can be shared with a clinician. It is used in 600+ clinics. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'Кількісні рівні LH, E3G, PdG
Зчитування тесту застосунком
Порівняння циклів
Звіт для лікаря', 'Quantitative LH, E3G, PdG levels
App reads the test
Cycle comparison
Report for your clinician', 'Жінкам, які відстежують фертильність або перименопаузу.', 'Women tracking fertility or perimenopause.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oova.life' OR LOWER(`name`) = 'oova') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A daily at-home test and app that show hormone patterns for fertility and perimenopause.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Oova lets you take a urine test at home and get quantitative LH, E3G and PdG levels in about 10 minutes via the app, with no separate device. The app shows how hormones change across cycles and how symptoms align with them. Results can be shared with a clinician. It is used in 600+ clinics. The service does not replace a doctor’s consultation; in an emergency, call emergency services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Quantitative LH, E3G, PdG levels
App reads the test
Cycle comparison
Report for your clinician', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Women tracking fertility or perimenopause.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Інструменти для психологів (health-beauty/psychologist-tools) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'health-beauty' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'psychologist-tools' LIMIT 1);

-- SimplePractice
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simplepractice.com' OR LOWER(`name`) = 'simplepractice')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SimplePractice', NULL, 'https://www.simplepractice.com/', NULL, NULL, 'Медична картка й керування практикою для психотерапевтів: розклад, нотатки, телемедицина, оплати.', 'EHR and practice management for therapists: scheduling, notes, telehealth and billing.', 'SimplePractice — HIPAA-сумісна система для понад 250 000 психотерапевтів і фахівців зі здоров’я. Вона поєднує календар, бібліотеку шаблонів нотаток, вбудовану телемедицину, виставлення рахунків і роботу зі страховками. Є 30-денний безкоштовний пробний період без картки.', 'SimplePractice is a HIPAA-compliant system used by 250,000+ therapists and wellness professionals. It combines a calendar, a note-template library, built-in telehealth, billing and insurance tools. A 30-day free trial requires no credit card.', 'Календар і онлайн-запис
Шаблони клінічних нотаток
Вбудована телемедицина
Рахунки й страховки', 'Calendar and online booking
Clinical note templates
Built-in telehealth
Billing and insurance', 'Психотерапевтам і приватним практикам у США.', 'Therapists and private practices in the US.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simplepractice.com' OR LOWER(`name`) = 'simplepractice') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'EHR and practice management for therapists: scheduling, notes, telehealth and billing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SimplePractice is a HIPAA-compliant system used by 250,000+ therapists and wellness professionals. It combines a calendar, a note-template library, built-in telehealth, billing and insurance tools. A 30-day free trial requires no credit card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Calendar and online booking
Clinical note templates
Built-in telehealth
Billing and insurance', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Therapists and private practices in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eleos Health
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eleos.health' OR LOWER(`name`) = 'eleos health')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eleos Health', NULL, 'https://eleos.health/', NULL, NULL, 'AI-платформа документування й комплаєнсу для організацій поведінкового та громадського здоров’я.', 'An AI documentation and compliance platform for behavioral and community-based care organizations.', 'Eleos документує кожну сесію, перевіряє всі нотатки на відповідність вимогам і допомагає вчасно знаходити ризики для фінансування. AI-агенти платформи супроводжують весь шлях допомоги, а фахівці витрачають менше часу на паперову роботу. Платформою користуються понад 300 організацій у США.', 'Eleos documents every session, reviews all notes for compliance and flags revenue at risk early. The platform’s AI agents support the whole care journey so clinicians spend less time on paperwork. It is used by 300+ organizations in the US.', 'Автоматичне документування сесій
Перевірка нотаток на комплаєнс
AI-агенти для процесів допомоги
Аналітика ризиків', 'Automatic session documentation
Compliance review of notes
AI agents for care workflows
Risk analytics', 'Організаціям поведінкового здоров’я й громадської допомоги.', 'Behavioral health and community-based care organizations.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eleos.health' OR LOWER(`name`) = 'eleos health') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI documentation and compliance platform for behavioral and community-based care organizations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Eleos documents every session, reviews all notes for compliance and flags revenue at risk early. The platform’s AI agents support the whole care journey so clinicians spend less time on paperwork. It is used by 300+ organizations in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic session documentation
Compliance review of notes
AI agents for care workflows
Risk analytics', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Behavioral health and community-based care organizations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Supanote
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'supanote.ai' OR LOWER(`name`) = 'supanote')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Supanote', NULL, 'https://www.supanote.ai/', NULL, NULL, 'AI-нотатки для психотерапевтів у форматах SOAP, DAP і власних шаблонах за кілька хвилин.', 'AI therapy notes for clinicians in SOAP, DAP and custom templates within minutes.', 'Supanote створює HIPAA-сумісні нотатки сесій у форматах SOAP, DAP або власних шаблонах і підлаштовується під стиль терапевта. Фахівці зазначають, що економлять кілька годин на тиждень на документації. Почати можна за кілька хвилин, є безкоштовний пробний період.', 'Supanote creates HIPAA-compliant session notes in SOAP, DAP or custom templates and adapts to the therapist’s style. Clinicians report saving several hours a week on documentation. Getting started takes minutes, and there is a free trial.', 'Нотатки SOAP і DAP
Власні шаблони
Підлаштування під стиль терапевта
Відповідність HIPAA', 'SOAP and DAP notes
Custom templates
Adapts to the therapist’s style
HIPAA-compliant', 'Психотерапевтам, консультантам і соціальним працівникам.', 'Therapists, counselors and social workers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'supanote.ai' OR LOWER(`name`) = 'supanote') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI therapy notes for clinicians in SOAP, DAP and custom templates within minutes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Supanote creates HIPAA-compliant session notes in SOAP, DAP or custom templates and adapts to the therapist’s style. Clinicians report saving several hours a week on documentation. Getting started takes minutes, and there is a free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'SOAP and DAP notes
Custom templates
Adapts to the therapist’s style
HIPAA-compliant', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Therapists, counselors and social workers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TheraNest
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ensorahealth.com/product/theranest-mental-health' OR LOWER(`name`) = 'theranest')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TheraNest', NULL, 'https://ensorahealth.com/product/theranest-mental-health/', NULL, NULL, 'Медична картка й керування практикою для психологів і клінік ментального здоров’я з AI-нотатками.', 'EHR and practice management for mental health providers and clinics, with AI notes.', 'TheraNest від Ensora Health поєднує медичну картку, розклад, телемедицину й виставлення рахунків для приватних практик і клінік ментального здоров’я. Вбудований AI Ensora записує сесії, складає чернетки нотаток і відповідає на запитання фахівця. Є безкоштовний пробний період.', 'TheraNest by Ensora Health combines an EHR, scheduling, telehealth and billing for private practices and mental health clinics. The built-in Ensora AI records sessions, drafts notes and answers the clinician’s questions. A free trial is available.', 'Медична картка й розклад
Телемедицина
AI-чернетки нотаток
Рахунки й оплати', 'EHR and scheduling
Telehealth
AI note drafts
Billing and payments', 'Психологам, психотерапевтам і клінікам ментального здоров’я.', 'Psychologists, therapists and mental health clinics.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ensorahealth.com/product/theranest-mental-health' OR LOWER(`name`) = 'theranest') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'EHR and practice management for mental health providers and clinics, with AI notes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TheraNest by Ensora Health combines an EHR, scheduling, telehealth and billing for private practices and mental health clinics. The built-in Ensora AI records sessions, drafts notes and answers the clinician’s questions. A free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'EHR and scheduling
Telehealth
AI note drafts
Billing and payments', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Psychologists, therapists and mental health clinics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jane
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jane.app' OR LOWER(`name`) = 'jane')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jane', NULL, 'https://jane.app/', NULL, NULL, 'Платформа для клінік і практиків: онлайн-запис, AI-документування, рахунки, оплати й комунікація з клієнтами.', 'A platform for clinics and practitioners: online booking, AI charting, billing, payments and client messaging.', 'Jane поєднує в одній системі запис і розклад, документування з AI-підказками, автоматичні форми, шаблони, звіти, рахунки й оплати. Нагадування зменшують кількість пропущених візитів. Платформою користуються психотерапевти, фізіотерапевти, масажисти та інші фахівці зі здоров’я.', 'Jane brings booking and scheduling, AI-assisted charting, automatic forms, templates, reports, billing and payments into one system. Reminders reduce missed appointments. It is used by therapists, physiotherapists, massage therapists and other health practitioners.', 'Онлайн-запис і нагадування
AI-документування
Рахунки й оплати
Звіти про практику', 'Online booking and reminders
AI charting
Billing and payments
Practice reports', 'Приватним практикам і клінікам у сфері здоров’я.', 'Private practices and health clinics.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jane.app' OR LOWER(`name`) = 'jane') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform for clinics and practitioners: online booking, AI charting, billing, payments and client messaging.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Jane brings booking and scheduling, AI-assisted charting, automatic forms, templates, reports, billing and payments into one system. Reminders reduce missed appointments. It is used by therapists, physiotherapists, massage therapists and other health practitioners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online booking and reminders
AI charting
Billing and payments
Practice reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Private practices and health clinics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Видалення фону (multimedia/background-removal) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'multimedia' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'background-removal' LIMIT 1);

-- Removal.AI
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'removal.ai' OR LOWER(`name`) = 'removal.ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Removal.AI', NULL, 'https://removal.ai/', NULL, NULL, 'Автоматичне видалення фону з фото за секунди, без реєстрації, з опцією ручної обробки професіоналами.', 'Automatic background removal from photos in seconds, no sign-up, with optional editing by professionals.', 'Removal.AI визначає передній план і за кілька секунд робить фон прозорим. Спробувати можна безкоштовно й без реєстрації, а для великих обсягів є платні кредити, пакетна обробка та API. Якщо зображення має особливі вимоги, можна замовити обробку в професійних редакторів.', 'Removal.AI detects the foreground and makes the background transparent in seconds. You can try it for free without signing up, and paid credits, batch processing and an API cover larger volumes. For images with special requirements, professional editors can be hired.', 'Прозорий фон за секунди
Без реєстрації
Пакетна обробка й API
Професійна ручна обробка', 'Transparent background in seconds
No sign-up
Batch processing and API
Professional manual editing', 'Інтернет-магазинам, дизайнерам і SMM-фахівцям.', 'Online stores, designers and social media managers.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'removal.ai' OR LOWER(`name`) = 'removal.ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Automatic background removal from photos in seconds, no sign-up, with optional editing by professionals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Removal.AI detects the foreground and makes the background transparent in seconds. You can try it for free without signing up, and paid credits, batch processing and an API cover larger volumes. For images with special requirements, professional editors can be hired.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Transparent background in seconds
No sign-up
Batch processing and API
Professional manual editing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Online stores, designers and social media managers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Slazzer
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'slazzer.com' OR LOWER(`name`) = 'slazzer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Slazzer', NULL, 'https://www.slazzer.com/', NULL, NULL, 'Видаляє фон із фото за 5 секунд, додає згенеровані фони й природні тіні для товарних фото.', 'Removes photo backgrounds in 5 seconds and adds generated backgrounds and natural shadows for product shots.', 'Slazzer автоматично прибирає фон із зображень, а також генерує реалістичні нові фони, додає тіні та покращує розмиті чи тьмяні фото одним кліком. Сервіс розрахований передусім на продавців маркетплейсів і фотографів. Є безкоштовна спроба, платні кредити й API.', 'Slazzer automatically removes image backgrounds and also generates realistic new backgrounds, adds shadows and fixes blurry or dull photos in one click. It targets marketplace sellers and photographers. There is a free trial, paid credits and an API.', 'Автоматичне видалення фону
Генерація нових фонів
Природні тіні
Покращення фото в один клік', 'Automatic background removal
New background generation
Natural shadows
One-click photo enhancement', 'Продавцям маркетплейсів і фотографам.', 'Marketplace sellers and photographers.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'slazzer.com' OR LOWER(`name`) = 'slazzer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Removes photo backgrounds in 5 seconds and adds generated backgrounds and natural shadows for product shots.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Slazzer automatically removes image backgrounds and also generates realistic new backgrounds, adds shadows and fixes blurry or dull photos in one click. It targets marketplace sellers and photographers. There is a free trial, paid credits and an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic background removal
New background generation
Natural shadows
One-click photo enhancement', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Marketplace sellers and photographers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Erase.bg
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'erase.bg' OR LOWER(`name`) = 'erase.bg')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Erase.bg', NULL, 'https://www.erase.bg/', NULL, NULL, 'Безкоштовне видалення фону з фото людей, тварин і предметів у високій роздільності, зокрема пакетно.', 'Free background removal for photos of people, animals and objects in high resolution, including in bulk.', 'Erase.bg робить фон прозорим на фото людей, тварин чи товарів і дає змогу завантажити результат у високій роздільності для особистих цілей та e-commerce. Можна обробити одразу кілька зображень. Після реєстрації надаються безкоштовні кредити, а розширені можливості входять до екосистеми Pixelbin.', 'Erase.bg makes the background transparent on photos of people, animals or products and lets you download the result in high resolution for personal and e-commerce use. Several images can be processed at once. Free credits are given on sign-up, and extended features are part of the Pixelbin ecosystem.', 'Видалення фону для будь-яких об’єктів
Висока роздільність
Пакетна обробка
Безкоштовні кредити', 'Background removal for any subject
High resolution
Bulk processing
Free credits', 'E-commerce, дизайнерам і звичайним користувачам.', 'E-commerce, designers and everyday users.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'erase.bg' OR LOWER(`name`) = 'erase.bg') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free background removal for photos of people, animals and objects in high resolution, including in bulk.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Erase.bg makes the background transparent on photos of people, animals or products and lets you download the result in high resolution for personal and e-commerce use. Several images can be processed at once. Free credits are given on sign-up, and extended features are part of the Pixelbin ecosystem.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Background removal for any subject
High resolution
Bulk processing
Free credits', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'E-commerce, designers and everyday users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PhotoScissors
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'photoscissors.com' OR LOWER(`name`) = 'photoscissors')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PhotoScissors', NULL, 'https://photoscissors.com/', NULL, NULL, 'Видаляє фон автоматично й замінює його на прозорий, однотонний або інше зображення; є десктоп-версія з разовою оплатою.', 'Removes backgrounds automatically and replaces them with transparency, a solid color or another image; desktop version with a one-time fee.', 'PhotoScissors швидко відокремлює людину чи предмет від фону, щоб вставити в іншу картинку, а фон замінити на прозорий, кольоровий або власне зображення. Онлайн-версія працює безкоштовно, а програма для комп’ютера купується разово без обмеження кількості зображень. Той самий розробник має інструмент для видалення небажаних об’єктів.', 'PhotoScissors quickly separates a person or object from the background so you can paste it elsewhere and replace the background with transparency, a color or your own image. The online version is free, and the desktop app is a one-time purchase with no image limits. The same developer offers a tool for removing unwanted objects.', 'Автоматичне вирізання об’єкта
Заміна фону на колір чи зображення
Безкоштовна онлайн-версія
Десктоп-програма з разовою оплатою', 'Automatic subject cut-out
Replace background with color or image
Free online version
One-time-fee desktop app', 'Користувачам, яким потрібно швидко прибрати фон без складних редакторів.', 'Users who need to remove a background quickly without complex editors.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'photoscissors.com' OR LOWER(`name`) = 'photoscissors') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Removes backgrounds automatically and replaces them with transparency, a solid color or another image; desktop version with a one-time fee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PhotoScissors quickly separates a person or object from the background so you can paste it elsewhere and replace the background with transparency, a color or your own image. The online version is free, and the desktop app is a one-time purchase with no image limits. The same developer offers a tool for removing unwanted objects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic subject cut-out
Replace background with color or image
Free online version
One-time-fee desktop app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who need to remove a background quickly without complex editors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fotor (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fotor.com' OR LOWER(`name`) = 'fotor') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- =================== Презентації (productivity/presentations) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'productivity' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'presentations' LIMIT 1);

-- Decktopus
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'decktopus.com' OR LOWER(`name`) = 'decktopus')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Decktopus', NULL, 'https://www.decktopus.com/', NULL, NULL, 'AI-конструктор презентацій із коучингом для репетиції та аналітикою переглядів.', 'An AI presentation maker with rehearsal coaching and view analytics.', 'Decktopus генерує повну презентацію в стилі бренду з опису теми: структуру, текст і дизайн. Вбудований AI-коуч допомагає відрепетирувати виступ, а після надсилання презентація відстежує перегляди й допомагає збирати заявки. Також можна створювати каруселі для соцмереж.', 'Decktopus generates a complete on-brand deck from a topic description: structure, content and design. A built-in AI coach helps rehearse, and shared decks track views and help capture leads. It can also create social media carousels.', 'Генерація презентації з теми
AI-коуч для репетиції
Аналітика переглядів
Каруселі для соцмереж', 'Deck generation from a topic
AI rehearsal coach
View analytics
Social media carousels', 'Консультантам, продавцям і всім, кому треба швидко зробити професійну презентацію.', 'Consultants, salespeople and anyone who needs a professional deck fast.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'decktopus.com' OR LOWER(`name`) = 'decktopus') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI presentation maker with rehearsal coaching and view analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Decktopus generates a complete on-brand deck from a topic description: structure, content and design. A built-in AI coach helps rehearse, and shared decks track views and help capture leads. It can also create social media carousels.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Deck generation from a topic
AI rehearsal coach
View analytics
Social media carousels', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Consultants, salespeople and anyone who needs a professional deck fast.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SlidesAI
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'slidesai.io' OR LOWER(`name`) = 'slidesai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SlidesAI', NULL, 'https://www.slidesai.io/', NULL, NULL, 'Перетворює нотатки, документи, PDF і промпти на презентації в Google Slides, PowerPoint, ChatGPT або вебі.', 'Turns notes, documents, PDFs and prompts into presentations in Google Slides, PowerPoint, ChatGPT or the web.', 'SlidesAI працює там, де ви вже створюєте презентації: як доповнення для Google Slides і PowerPoint, у ChatGPT і як вебзастосунок. Достатньо вставити текст або завантажити документ, щоб отримати готові слайди без імпорту файлів. Є безкоштовні шаблони й платні тарифи для більшої кількості презентацій.', 'SlidesAI works where you already make presentations: as an add-on for Google Slides and PowerPoint, inside ChatGPT and as a web app. Paste text or upload a document to get ready slides without importing files. Free templates and paid plans for more decks are available.', 'Доповнення для Google Slides і PowerPoint
Працює в ChatGPT
Слайди з тексту, PDF і документів
Безкоштовні шаблони', 'Add-on for Google Slides and PowerPoint
Works in ChatGPT
Slides from text, PDFs and documents
Free templates', 'Викладачам, студентам і офісним працівникам.', 'Teachers, students and office workers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'slidesai.io' OR LOWER(`name`) = 'slidesai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Turns notes, documents, PDFs and prompts into presentations in Google Slides, PowerPoint, ChatGPT or the web.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SlidesAI works where you already make presentations: as an add-on for Google Slides and PowerPoint, inside ChatGPT and as a web app. Paste text or upload a document to get ready slides without importing files. Free templates and paid plans for more decks are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Add-on for Google Slides and PowerPoint
Works in ChatGPT
Slides from text, PDFs and documents
Free templates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teachers, students and office workers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Prezi
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prezi.com' OR LOWER(`name`) = 'prezi')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Prezi', NULL, 'https://prezi.com/', NULL, NULL, 'Інтерактивна платформа презентацій з AI, живими опитуваннями й вікторинами для аудиторії.', 'An interactive presentation platform with AI, live polls and quizzes for the audience.', 'Prezi дає змогу завантажити наявні слайди з PowerPoint, Google Slides, Canva чи PDF або описати тему одним реченням, і AI збудує презентацію. Під час виступу аудиторія за QR-кодом відповідає на опитування, вікторини й ставить запитання з телефонів. Після заняття одне посилання продовжує працювати для учасників. Почати можна безкоштовно.', 'Prezi lets you bring existing slides from PowerPoint, Google Slides, Canva or PDF, or describe your topic in a sentence and let AI build the presentation. During the session the audience joins polls, quizzes and Q&A from their phones via a QR code. Afterwards a single link keeps working for participants. Free to start.', 'AI-генерація з опису теми
Імпорт PowerPoint, Google Slides, PDF
Живі опитування й вікторини
Посилання після виступу', 'AI generation from a topic
Import from PowerPoint, Google Slides, PDF
Live polls and quizzes
Shareable link after the session', 'Викладачам, тренерам і командам.', 'Educators, trainers and teams.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prezi.com' OR LOWER(`name`) = 'prezi') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An interactive presentation platform with AI, live polls and quizzes for the audience.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Prezi lets you bring existing slides from PowerPoint, Google Slides, Canva or PDF, or describe your topic in a sentence and let AI build the presentation. During the session the audience joins polls, quizzes and Q&A from their phones via a QR code. Afterwards a single link keeps working for participants. Free to start.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI generation from a topic
Import from PowerPoint, Google Slides, PDF
Live polls and quizzes
Shareable link after the session', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Educators, trainers and teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Таблиці (productivity/spreadsheets) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'productivity' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'spreadsheets' LIMIT 1);

-- Better Analyst (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'betteranalyst.com' OR LOWER(`name`) = 'better analyst') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- SheetAI
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sheetai.app' OR LOWER(`name`) = 'sheetai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SheetAI', NULL, 'https://www.sheetai.app/', NULL, NULL, 'Доповнення для Google Sheets, що генерує текст, зображення, відео й музику формулою прямо в клітинках.', 'A Google Sheets add-on that generates text, images, video and music with a formula right in the cells.', 'SheetAI додає до Google Sheets функцію =SHEETAI(): один промпт заповнює сотні рядків текстом, а через Replicate можна масово генерувати зображення, відео й музику. Зі своїм API-ключем доповнення безкоштовне, ви платите лише постачальникам моделей; є й платні хостингові тарифи.', 'SheetAI adds a =SHEETAI() function to Google Sheets: one prompt fills hundreds of rows with text, and via Replicate you can bulk-generate images, video and music. With your own API key the add-on is free and you pay only the model providers; hosted paid plans are also available.', 'Функція =SHEETAI() у клітинках
Масова генерація тексту
Зображення, відео й музика через Replicate
Безкоштовно зі своїм ключем', '=SHEETAI() cell function
Bulk text generation
Images, video and music via Replicate
Free with your own key', 'Маркетологам і контент-командам, що працюють у Google Sheets.', 'Marketers and content teams working in Google Sheets.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sheetai.app' OR LOWER(`name`) = 'sheetai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Google Sheets add-on that generates text, images, video and music with a formula right in the cells.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SheetAI adds a =SHEETAI() function to Google Sheets: one prompt fills hundreds of rows with text, and via Replicate you can bulk-generate images, video and music. With your own API key the add-on is free and you pay only the model providers; hosted paid plans are also available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '=SHEETAI() cell function
Bulk text generation
Images, video and music via Replicate
Free with your own key', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Marketers and content teams working in Google Sheets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Coefficient
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coefficient.io' OR LOWER(`name`) = 'coefficient')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Coefficient', NULL, 'https://coefficient.io/', NULL, NULL, 'Підключає Google Sheets і Excel до Salesforce, QuickBooks, Snowflake та 100+ джерел, будує живі дашборди з AI.', 'Connects Google Sheets and Excel to Salesforce, QuickBooks, Snowflake and 100+ sources and builds live AI dashboards.', 'Coefficient підтягує актуальні дані з CRM, бухгалтерії, баз даних та інших сервісів у Google Sheets і Excel і автоматично їх оновлює. На цих даних можна будувати аналіз і дашборди за допомогою AI, а готові шаблони прискорюють старт. Команди використовують його замість сотень таблиць, які оновлювали вручну. Є безкоштовний тариф.', 'Coefficient pulls live data from CRMs, accounting tools, databases and other services into Google Sheets and Excel and refreshes it automatically. You can build analysis and dashboards on that data with AI, and ready templates speed up the start. Teams use it to replace hundreds of manually updated spreadsheets. A free plan is available.', 'Конектори до 100+ джерел
Автоматичне оновлення даних
AI-аналіз і дашборди
Готові шаблони', 'Connectors to 100+ sources
Automatic data refresh
AI analysis and dashboards
Ready templates', 'RevOps, фінансовим і аналітичним командам.', 'RevOps, finance and analytics teams.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coefficient.io' OR LOWER(`name`) = 'coefficient') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Connects Google Sheets and Excel to Salesforce, QuickBooks, Snowflake and 100+ sources and builds live AI dashboards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Coefficient pulls live data from CRMs, accounting tools, databases and other services into Google Sheets and Excel and refreshes it automatically. You can build analysis and dashboards on that data with AI, and ready templates speed up the start. Teams use it to replace hundreds of manually updated spreadsheets. A free plan is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Connectors to 100+ sources
Automatic data refresh
AI analysis and dashboards
Ready templates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'RevOps, finance and analytics teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Подорожі (productivity/travel) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'productivity' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'travel' LIMIT 1);

-- Wanderlog
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wanderlog.com' OR LOWER(`name`) = 'wanderlog')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wanderlog', NULL, 'https://wanderlog.com/', NULL, NULL, 'Безкоштовний планувальник подорожей: маршрути на мапі, путівники користувачів і бронювання в одному місці.', 'A free trip planner: map-based itineraries, user guides and bookings in one place.', 'Wanderlog дає змогу скласти детальний маршрут подорожі, де всі пам’ятки одразу позначені на мапі, переглядати путівники інших мандрівників і зберігати бронювання. Маршрут можна спільно редагувати з попутниками, навіть у безкоштовній версії. Працює в браузері та в мобільних застосунках.', 'Wanderlog lets you build a detailed itinerary with all attractions plotted on a map, browse guides from other travelers and keep your bookings together. Itineraries can be edited together with travel companions, even in the free version. It works in the browser and in mobile apps.', 'Маршрут на мапі
Спільне планування
Путівники мандрівників
Збереження бронювань', 'Map-based itinerary
Collaborative planning
Traveler guides
Booking storage', 'Мандрівникам, які самі планують поїздки.', 'Travelers who plan their own trips.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wanderlog.com' OR LOWER(`name`) = 'wanderlog') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free trip planner: map-based itineraries, user guides and bookings in one place.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Wanderlog lets you build a detailed itinerary with all attractions plotted on a map, browse guides from other travelers and keep your bookings together. Itineraries can be edited together with travel companions, even in the free version. It works in the browser and in mobile apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Map-based itinerary
Collaborative planning
Traveler guides
Booking storage', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travelers who plan their own trips.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TripIt
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tripit.com' OR LOWER(`name`) = 'tripit')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TripIt', NULL, 'https://www.tripit.com/', NULL, NULL, 'Автоматично збирає маршрут подорожі з листів-підтверджень бронювань і надсилає оновлення в дорозі.', 'Automatically builds your itinerary from booking confirmation emails and sends updates on the go.', 'TripIt упорядковує плани поїздок незалежно від того, де ви бронювали: досить переслати листи-підтвердження на спеціальну адресу, і за секунди з’явиться маршрут. У застосунку всі деталі подорожі в одному місці, а платна версія надсилає сповіщення про зміни рейсів та інші події. Сервіс працює вже 20 років.', 'TripIt organizes travel plans wherever you booked: forward your confirmation emails to a special address and an itinerary appears in seconds. The app keeps all trip details in one place, and the paid version sends alerts about flight changes and other events. The service has been running for 20 years.', 'Маршрут із листів-підтверджень
Усі деталі поїздки в одному місці
Сповіщення про зміни
Безкоштовна реєстрація', 'Itinerary from confirmation emails
All trip details in one place
Change alerts
Free sign-up', 'Діловим і приватним мандрівникам.', 'Business and leisure travelers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tripit.com' OR LOWER(`name`) = 'tripit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Automatically builds your itinerary from booking confirmation emails and sends updates on the go.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TripIt organizes travel plans wherever you booked: forward your confirmation emails to a special address and an itinerary appears in seconds. The app keeps all trip details in one place, and the paid version sends alerts about flight changes and other events. The service has been running for 20 years.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Itinerary from confirmation emails
All trip details in one place
Change alerts
Free sign-up', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Business and leisure travelers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hopper
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hopper.com' OR LOWER(`name`) = 'hopper')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hopper', NULL, 'https://www.hopper.com/', NULL, NULL, 'Застосунок для бронювання авіаквитків, готелів і авто з прогнозами цін та знижками для учасників.', 'An app for booking flights, hotels and cars with price predictions and member discounts.', 'Hopper допомагає планувати й бронювати подорожі: авіаквитки, готелі, оренду авто тощо. Застосунок відомий прогнозами цін, які підказують, коли купувати, а авторизованим користувачам відкриває нижчі ціни. Сервісом користуються понад 120 мільйонів мандрівників, він доступний на iOS та Android.', 'Hopper helps plan and book trips: flights, hotels, car rentals and more. The app is known for price predictions that suggest when to buy and unlocks lower prices for signed-in users. More than 120 million travelers use it on iOS and Android.', 'Бронювання авіаквитків і готелів
Прогнози цін
Знижки для учасників
Застосунки iOS та Android', 'Flight and hotel booking
Price predictions
Member discounts
iOS and Android apps', 'Мандрівникам, які стежать за цінами.', 'Price-conscious travelers.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hopper.com' OR LOWER(`name`) = 'hopper') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app for booking flights, hotels and cars with price predictions and member discounts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hopper helps plan and book trips: flights, hotels, car rentals and more. The app is known for price predictions that suggest when to buy and unlocks lower prices for signed-in users. More than 120 million travelers use it on iOS and Android.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Flight and hotel booking
Price predictions
Member discounts
iOS and Android apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Price-conscious travelers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GuideGeek
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'guidegeek.com' OR LOWER(`name`) = 'guidegeek')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GuideGeek', NULL, 'https://guidegeek.com/', NULL, NULL, 'Безкоштовний AI-помічник для подорожей у месенджерах Meta з актуальними даними про рейси й житло.', 'A free AI travel assistant in Meta messaging apps with real-time info on flights and stays.', 'GuideGeek допомагає придумати, спланувати й забронювати подорож у форматі листування, як із другом. Помічник використовує дані в реальному часі про рейси, житло, ресторани й розваги, порівнює ціни та дає місцеві поради й мапи. Спілкуватися з ним можна в Instagram, WhatsApp і Messenger.', 'GuideGeek helps dream up, plan and book a trip through chat, like texting a friend. It uses real-time data on flights, stays, restaurants and experiences, compares prices and offers local tips and maps. You can chat with it on Instagram, WhatsApp and Messenger.', 'AI-планування поїздки в чаті
Дані в реальному часі
Порівняння цін
Instagram, WhatsApp, Messenger', 'AI trip planning in chat
Real-time data
Price comparison
Instagram, WhatsApp, Messenger', 'Мандрівникам, які люблять планувати через месенджер.', 'Travelers who like planning by chat.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'guidegeek.com' OR LOWER(`name`) = 'guidegeek') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free AI travel assistant in Meta messaging apps with real-time info on flights and stays.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GuideGeek helps dream up, plan and book a trip through chat, like texting a friend. It uses real-time data on flights, stays, restaurants and experiences, compares prices and offers local tips and maps. You can chat with it on Instagram, WhatsApp and Messenger.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI trip planning in chat
Real-time data
Price comparison
Instagram, WhatsApp, Messenger', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travelers who like planning by chat.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- KAYAK
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kayak.com' OR LOWER(`name`) = 'kayak')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'KAYAK', NULL, 'https://www.kayak.com/', NULL, NULL, 'Метапошук авіаквитків, готелів і авто: порівнює пропозиції сотень туристичних сайтів одночасно.', 'Metasearch for flights, hotels and cars that compares offers from hundreds of travel sites at once.', 'KAYAK шукає на сотнях туристичних сайтів одночасно, щоб показати найкращі пропозиції авіаквитків, готелів і оренди авто. Є фільтри, сповіщення про зміну цін і мобільний застосунок. Сайт доступний українською, пошук безкоштовний, бронювання відбувається на сайті обраного постачальника.', 'KAYAK searches hundreds of travel sites at once to show the best deals on flights, hotels and car rentals. It offers filters, price alerts and a mobile app. The site is available in Ukrainian, search is free, and booking happens on the chosen provider’s site.', 'Пошук на сотнях сайтів
Авіаквитки, готелі, авто
Сповіщення про ціни
Українська версія', 'Search across hundreds of sites
Flights, hotels, cars
Price alerts
Ukrainian version', 'Усім, хто шукає вигідні квитки й житло.', 'Anyone looking for good deals on travel.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kayak.com' OR LOWER(`name`) = 'kayak') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Metasearch for flights, hotels and cars that compares offers from hundreds of travel sites at once.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'KAYAK searches hundreds of travel sites at once to show the best deals on flights, hotels and car rentals. It offers filters, price alerts and a mobile app. The site is available in Ukrainian, search is free, and booking happens on the chosen provider’s site.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Search across hundreds of sites
Flights, hotels, cars
Price alerts
Ukrainian version', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone looking for good deals on travel.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tripadvisor
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tripadvisor.com' OR LOWER(`name`) = 'tripadvisor')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tripadvisor', NULL, 'https://www.tripadvisor.com/', NULL, NULL, 'Понад мільярд відгуків про готелі, ресторани й пам’ятки та 400 000+ екскурсій і вражень для бронювання.', 'Over a billion reviews of hotels, restaurants and attractions, plus 400,000+ experiences to book.', 'Tripadvisor збирає відгуки мандрівників про готелі, ресторани, пам’ятки й розваги по всьому світу. На сайті можна порівнювати ціни на житло, бронювати понад 400 000 екскурсій і вражень та переглядати добірки Travelers’ Choice. Сервіс безкоштовний для мандрівників.', 'Tripadvisor collects traveler reviews of hotels, restaurants, attractions and activities worldwide. You can compare hotel prices, book 400,000+ tours and experiences, and browse Travelers’ Choice picks. It is free for travelers.', 'Мільярд відгуків
Порівняння цін на житло
400 000+ екскурсій
Добірки Travelers’ Choice', 'A billion reviews
Hotel price comparison
400,000+ experiences
Travelers’ Choice picks', 'Мандрівникам, які обирають житло й розваги за відгуками.', 'Travelers choosing stays and activities by reviews.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tripadvisor.com' OR LOWER(`name`) = 'tripadvisor') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Over a billion reviews of hotels, restaurants and attractions, plus 400,000+ experiences to book.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tripadvisor collects traveler reviews of hotels, restaurants, attractions and activities worldwide. You can compare hotel prices, book 400,000+ tours and experiences, and browse Travelers’ Choice picks. It is free for travelers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'A billion reviews
Hotel price comparison
400,000+ experiences
Travelers’ Choice picks', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travelers choosing stays and activities by reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Дошки та діаграми (productivity/whiteboards) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'productivity' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'whiteboards' LIMIT 1);

-- Lucidchart
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lucidchart.com' OR LOWER(`name`) = 'lucidchart')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lucidchart', NULL, 'https://www.lucidchart.com/', NULL, NULL, 'Сервіс діаграм з AI, імпортом даних і автоматизацією для схем процесів, систем і організацій.', 'A diagramming service with AI, data import and automation for process, system and org charts.', 'Lucidchart допомагає візуалізувати процеси й системи: діаграми можна згенерувати з AI або з імпортованих даних чи намалювати вручну зручними інструментами. Над схемами працюють разом у реальному часі або асинхронно, створюючи спільну візуальну документацію. Є безкоштовна реєстрація й платні тарифи.', 'Lucidchart helps visualize processes and systems: diagrams can be generated with AI or from imported data, or drawn by hand with intuitive tools. Teams collaborate in real time or asynchronously to build shared visual documentation. There is a free sign-up and paid plans.', 'AI-генерація діаграм
Імпорт даних
Спільна робота в реальному часі
Візуальна документація', 'AI diagram generation
Data import
Real-time collaboration
Visual documentation', 'Командам продукту, IT, операцій і бізнес-аналітикам.', 'Product, IT and operations teams and business analysts.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lucidchart.com' OR LOWER(`name`) = 'lucidchart') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A diagramming service with AI, data import and automation for process, system and org charts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lucidchart helps visualize processes and systems: diagrams can be generated with AI or from imported data, or drawn by hand with intuitive tools. Teams collaborate in real time or asynchronously to build shared visual documentation. There is a free sign-up and paid plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI diagram generation
Data import
Real-time collaboration
Visual documentation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Product, IT and operations teams and business analysts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Excalidraw
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'excalidraw.com' OR LOWER(`name`) = 'excalidraw')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Excalidraw', NULL, 'https://excalidraw.com/', NULL, NULL, 'Безкоштовна віртуальна дошка з «рукописним» стилем для схем і ескізів, зі спільною роботою.', 'A free virtual whiteboard with a hand-drawn style for diagrams and sketches, with collaboration.', 'Excalidraw дає змогу швидко накидати схему, діаграму чи ескіз інтерфейсу в стилі малюнка від руки. Працює в браузері без реєстрації, малюнки зберігаються локально та експортуються у файл. Можна запросити інших до спільної сесії. Платна версія Excalidraw+ додає хмарне зберігання й командні функції. Проєкт має відкритий код.', 'Excalidraw lets you quickly sketch a diagram, chart or UI mock-up in a hand-drawn style. It works in the browser without sign-up, drawings are stored locally and exported to a file, and you can invite others to a live session. The paid Excalidraw+ adds cloud storage and team features. The project is open source.', 'Рукописний стиль
Без реєстрації
Спільні сесії
Відкритий код, Excalidraw+ для команд', 'Hand-drawn style
No sign-up
Live collaboration
Open source, Excalidraw+ for teams', 'Розробникам, дизайнерам і викладачам.', 'Developers, designers and teachers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'excalidraw.com' OR LOWER(`name`) = 'excalidraw') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free virtual whiteboard with a hand-drawn style for diagrams and sketches, with collaboration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Excalidraw lets you quickly sketch a diagram, chart or UI mock-up in a hand-drawn style. It works in the browser without sign-up, drawings are stored locally and exported to a file, and you can invite others to a live session. The paid Excalidraw+ adds cloud storage and team features. The project is open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hand-drawn style
No sign-up
Live collaboration
Open source, Excalidraw+ for teams', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers, designers and teachers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- FigJam
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'figma.com/figjam' OR LOWER(`name`) = 'figjam')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'FigJam', NULL, 'https://www.figma.com/figjam/', NULL, NULL, 'Онлайн-дошка від Figma для мозкових штурмів, діаграм і командних зустрічей з AI-функціями.', 'Figma’s online whiteboard for brainstorming, diagrams and team meetings, with AI features.', 'FigJam — візуальна дошка, де команди малюють діаграми, проводять мозкові штурми й упорядковують ідеї в реальному часі. AI допомагає генерувати шаблони, сортувати й підсумовувати стікери. Дошка входить до всіх місць на будь-якому тарифі Figma, а гостей з інших компаній можна безкоштовно запросити на 24 години без входу.', 'FigJam is a visual whiteboard where teams diagram, brainstorm and organize ideas in real time. AI helps generate templates and sort and summarize stickies. It is included with every seat on every Figma plan, and guests from other companies can join free for 24 hours without logging in.', 'Мозкові штурми й діаграми
AI для шаблонів і підсумків
Входить до тарифів Figma
Гостьовий доступ на 24 години', 'Brainstorms and diagrams
AI for templates and summaries
Included in Figma plans
24-hour guest access', 'Продуктовим командам, дизайнерам і фасилітаторам.', 'Product teams, designers and facilitators.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'figma.com/figjam' OR LOWER(`name`) = 'figjam') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Figma’s online whiteboard for brainstorming, diagrams and team meetings, with AI features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'FigJam is a visual whiteboard where teams diagram, brainstorm and organize ideas in real time. AI helps generate templates and sort and summarize stickies. It is included with every seat on every Figma plan, and guests from other companies can join free for 24 hours without logging in.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Brainstorms and diagrams
AI for templates and summaries
Included in Figma plans
24-hour guest access', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Product teams, designers and facilitators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eraser
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eraser.io' OR LOWER(`name`) = 'eraser')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eraser', NULL, 'https://www.eraser.io/', NULL, NULL, 'AI для технічних діаграм: архітектура, процеси, схеми з промпта, Terraform чи дизайн-документа.', 'AI for technical diagrams: architecture, processes and flows from a prompt, Terraform or a design doc.', 'Eraser перетворює текстовий опис, код Terraform або дизайн-документ на готові до використання технічні діаграми. Його можна підключити до власних даних і робочих процесів, щоб схеми були узгодженими й точними. Є безкоштовний тариф і безкоштовні інструменти для діаграм, частина коду відкрита.', 'Eraser turns a text prompt, Terraform code or a design doc into production-ready technical diagrams. It can be connected to your own data and workflows to keep diagrams consistent and accurate. There is a free plan and free diagram tools, and parts of it are open source.', 'Діаграми з промпта
Імпорт Terraform і документів
Узгодженість схем
Безкоштовний тариф', 'Diagrams from a prompt
Terraform and doc import
Consistent diagrams
Free plan', 'Архітекторам ПЗ, інженерам і технічним письменникам.', 'Software architects, engineers and technical writers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eraser.io' OR LOWER(`name`) = 'eraser') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI for technical diagrams: architecture, processes and flows from a prompt, Terraform or a design doc.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Eraser turns a text prompt, Terraform code or a design doc into production-ready technical diagrams. It can be connected to your own data and workflows to keep diagrams consistent and accurate. There is a free plan and free diagram tools, and parts of it are open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Diagrams from a prompt
Terraform and doc import
Consistent diagrams
Free plan', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Software architects, engineers and technical writers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Поштові асистенти (productivity/email-assistants) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'productivity' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'email-assistants' LIMIT 1);

-- Spark Mail
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sparkmailapp.com' OR LOWER(`name`) = 'spark mail')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Spark Mail', NULL, 'https://sparkmailapp.com/', NULL, NULL, 'Поштовий клієнт від української Readdle з AI для пошуку, підсумків і відповідей та фільтрацією шуму.', 'An email client from Ukraine’s Readdle with AI for search, summaries and replies, plus noise filtering.', 'Spark — кросплатформений поштовий клієнт, який одразу показує важливі листи й допомагає швидко прибрати решту. AI знаходить і підсумовує листи, допомагає відповідати, а функції фокусу зменшують відволікання. Застосунок створила українська компанія Readdle. Завантаження безкоштовне, розширені можливості — у платних тарифах.', 'Spark is a cross-platform email client that surfaces important mail first and helps clear the rest quickly. AI finds and summarizes emails and helps with replies, while focus features cut distractions. It is made by Ukrainian company Readdle. The download is free, with extended features in paid plans.', 'Розумна вхідна скринька
AI-пошук і підсумки
Функції фокусу
Усі платформи', 'Smart inbox
AI search and summaries
Focus features
All platforms', 'Усім, хто отримує багато листів, і командам.', 'Anyone with a busy inbox, and teams.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sparkmailapp.com' OR LOWER(`name`) = 'spark mail') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An email client from Ukraine’s Readdle with AI for search, summaries and replies, plus noise filtering.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Spark is a cross-platform email client that surfaces important mail first and helps clear the rest quickly. AI finds and summarizes emails and helps with replies, while focus features cut distractions. It is made by Ukrainian company Readdle. The download is free, with extended features in paid plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Smart inbox
AI search and summaries
Focus features
All platforms', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone with a busy inbox, and teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Canary Mail
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'canarymail.io' OR LOWER(`name`) = 'canary mail')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Canary Mail', NULL, 'https://canarymail.io/', NULL, NULL, 'Поштовий клієнт з AI-написанням листів, підсумками й календарем для всіх акаунтів в одній скриньці.', 'An email client with AI writing, summaries and a calendar for all your accounts in one inbox.', 'Canary Mail об’єднує всі поштові акаунти в одну зручну скриньку. AI складає листи у вашому стилі, підсумовує довгі ланцюжки за секунди й автоматично сортує пошту за категоріями. Є вбудований календар і акцент на безпеці та приватності.', 'Canary Mail brings all email accounts into one easy inbox. AI drafts messages in your voice, summarizes long threads in seconds and automatically categorizes mail. It includes a built-in calendar and a focus on security and privacy.', 'Усі акаунти в одній скриньці
AI-написання листів
Підсумки ланцюжків
Календар', 'All accounts in one inbox
AI email writing
Thread summaries
Calendar', 'Людям і командам із кількома поштовими акаунтами.', 'People and teams with several email accounts.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'canarymail.io' OR LOWER(`name`) = 'canary mail') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An email client with AI writing, summaries and a calendar for all your accounts in one inbox.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Canary Mail brings all email accounts into one easy inbox. AI drafts messages in your voice, summarizes long threads in seconds and automatically categorizes mail. It includes a built-in calendar and a focus on security and privacy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'All accounts in one inbox
AI email writing
Thread summaries
Calendar', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People and teams with several email accounts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SaneBox
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sanebox.com' OR LOWER(`name`) = 'sanebox')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SaneBox', NULL, 'https://www.sanebox.com/', NULL, NULL, 'AI-фільтрація пошти для будь-якої скриньки: прибирає неважливі листи, відписує й нагадує про відповіді.', 'AI email filtering for any inbox: moves unimportant mail, unsubscribes and reminds you to follow up.', 'SaneBox працює з будь-якою поштою без встановлення: аналізує листи й переносить неважливі в окремі папки, відписує від небажаних розсилок одним кліком, нагадує про листи без відповіді й надсилає щоденний дайджест. За даними сервісу, користувачі заощаджують 3–4 години на тиждень. Є безкоштовний пробний період.', 'SaneBox works with any email provider with nothing to install: it analyzes mail and moves unimportant messages into separate folders, unsubscribes from unwanted senders in one click, reminds you to follow up and sends a daily digest. The service reports users save 3–4 hours a week. A free trial is available.', 'Фільтрація неважливих листів
Відписка одним кліком
Нагадування про відповіді
Щоденний дайджест', 'Filtering of unimportant mail
One-click unsubscribe
Follow-up reminders
Daily digest', 'Професіоналам і командам із переповненою поштою.', 'Professionals and teams with overloaded inboxes.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sanebox.com' OR LOWER(`name`) = 'sanebox') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI email filtering for any inbox: moves unimportant mail, unsubscribes and reminds you to follow up.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SaneBox works with any email provider with nothing to install: it analyzes mail and moves unimportant messages into separate folders, unsubscribes from unwanted senders in one click, reminds you to follow up and sends a daily digest. The service reports users save 3–4 hours a week. A free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Filtering of unimportant mail
One-click unsubscribe
Follow-up reminders
Daily digest', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals and teams with overloaded inboxes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mailbutler
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mailbutler.io' OR LOWER(`name`) = 'mailbutler')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mailbutler', NULL, 'https://www.mailbutler.io/', NULL, NULL, 'Розширення для пошти з AI-асистентом, відстеженням листів, шаблонами й масовими розсилками.', 'An email extension with an AI assistant, email tracking, templates and mail merge.', 'Mailbutler додає інструменти продуктивності в Gmail, Outlook і Apple Mail: Smart Assistant упорядковує й підсумовує листи та складає відповіді, відстеження показує, як отримувачі взаємодіють із листами, а функція злиття дає змогу надсилати персоналізовані масові розсилки. Є 14-денний безкоштовний пробний період.', 'Mailbutler adds productivity tools to Gmail, Outlook and Apple Mail: the Smart Assistant organizes and summarizes emails and drafts replies, tracking shows how recipients engage, and mail merge sends personalized bulk emails. A 14-day free trial is available.', 'AI Smart Assistant
Відстеження листів
Персоналізовані розсилки
Gmail, Outlook, Apple Mail', 'AI Smart Assistant
Email tracking
Personalized mail merge
Gmail, Outlook, Apple Mail', 'Фрилансерам, продавцям і малому бізнесу.', 'Freelancers, salespeople and small businesses.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mailbutler.io' OR LOWER(`name`) = 'mailbutler') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An email extension with an AI assistant, email tracking, templates and mail merge.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mailbutler adds productivity tools to Gmail, Outlook and Apple Mail: the Smart Assistant organizes and summarizes emails and drafts replies, tracking shows how recipients engage, and mail merge sends personalized bulk emails. A 14-day free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI Smart Assistant
Email tracking
Personalized mail merge
Gmail, Outlook, Apple Mail', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Freelancers, salespeople and small businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MailMaestro
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'maestrolabs.com' OR LOWER(`name`) = 'mailmaestro')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MailMaestro', NULL, 'https://www.maestrolabs.com/', NULL, NULL, 'AI-асистент для Outlook і Gmail, що складає відповіді й нагадування, від Maestro Labs.', 'An AI assistant for Outlook and Gmail that drafts replies and follow-ups, from Maestro Labs.', 'MailMaestro миттєво складає чернетки відповідей, нагадувань та нових листів, підсумовує довгі ланцюжки й допомагає керувати поштою. Компанія Maestro Labs також має TeamsMaestro для нотаток зустрічей у Microsoft Teams. Продуктами користуються понад 300 000 команд, наголос — на корпоративній безпеці й приватності. Почати можна безкоштовно.', 'MailMaestro instantly drafts replies, follow-ups and new emails, summarizes long threads and helps manage your inbox. Maestro Labs also makes TeamsMaestro for meeting notes in Microsoft Teams. Its products are used by 300,000+ teams, with a focus on enterprise security and privacy. Free to start.', 'AI-чернетки листів
Підсумки ланцюжків
Outlook і Gmail
Корпоративна безпека', 'AI email drafts
Thread summaries
Outlook and Gmail
Enterprise security', 'Офісним працівникам і командам у Microsoft 365.', 'Office workers and teams on Microsoft 365.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'maestrolabs.com' OR LOWER(`name`) = 'mailmaestro') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI assistant for Outlook and Gmail that drafts replies and follow-ups, from Maestro Labs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MailMaestro instantly drafts replies, follow-ups and new emails, summarizes long threads and helps manage your inbox. Maestro Labs also makes TeamsMaestro for meeting notes in Microsoft Teams. Its products are used by 300,000+ teams, with a focus on enterprise security and privacy. Free to start.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI email drafts
Thread summaries
Outlook and Gmail
Enterprise security', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Office workers and teams on Microsoft 365.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ellie
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tryellie.com' OR LOWER(`name`) = 'ellie')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ellie', NULL, 'https://tryellie.com/', NULL, NULL, 'Підключається до Gmail чи Outlook і вночі готує чернетки відповідей у вашому стилі.', 'Connects to Gmail or Outlook and drafts replies overnight in your voice.', 'Ellie аналізує вашу пошту й заздалегідь створює чернетки відповідей у потрібних ланцюжках, написані у вашому стилі, тож уранці лишається перевірити й надіслати. Працює з Gmail і Outlook, зокрема як надбудова для Outlook на комп’ютері. Є 7-денний безкоштовний пробний період без картки.', 'Ellie reads your mail and pre-drafts replies in the right threads, written in your voice, so in the morning you just review and send. It works with Gmail and Outlook, including as an Outlook desktop add-in. A 7-day free trial requires no card.', 'Чернетки відповідей у вашому стилі
Gmail і Outlook
Надбудова для Outlook
7 днів безкоштовно', 'Drafts in your voice
Gmail and Outlook
Outlook add-in
7-day free trial', 'Людям, які щодня відповідають на багато листів.', 'People who answer lots of email every day.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tryellie.com' OR LOWER(`name`) = 'ellie') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Connects to Gmail or Outlook and drafts replies overnight in your voice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ellie reads your mail and pre-drafts replies in the right threads, written in your voice, so in the morning you just review and send. It works with Gmail and Outlook, including as an Outlook desktop add-in. A 7-day free trial requires no card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Drafts in your voice
Gmail and Outlook
Outlook add-in
7-day free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who answer lots of email every day.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Gmelius
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gmelius.com' OR LOWER(`name`) = 'gmelius')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gmelius', NULL, 'https://gmelius.com/', NULL, NULL, 'Командна скринька в Gmail з AI-агентами, які виконують завдання у пов’язаних застосунках.', 'A team inbox inside Gmail with AI agents that complete tasks across connected apps.', 'Gmelius перетворює Gmail на спільну робочу скриньку для команди й додає AI-агентів на чолі з Meli — «AI-керівником апарату», який знає ваших клієнтів і бізнес. Агенти виконують завдання в пов’язаних застосунках і каналах, допомагаючи автоматизувати операційну роботу. Понад 10 000 команд використовують сервіс. Є безкоштовна спроба.', 'Gmelius turns Gmail into a shared team inbox and adds AI agents led by Meli, an AI chief of staff that knows your clients and business. The agents complete tasks across connected apps and channels to automate operational work. More than 10,000 teams use it. A free trial is available.', 'Спільна скринька в Gmail
AI-агент Meli
Інтеграції з застосунками
Автоматизація процесів', 'Shared inbox in Gmail
Meli AI agent
App integrations
Workflow automation', 'Командам підтримки, продажів і операцій.', 'Support, sales and operations teams.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gmelius.com' OR LOWER(`name`) = 'gmelius') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A team inbox inside Gmail with AI agents that complete tasks across connected apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Gmelius turns Gmail into a shared team inbox and adds AI agents led by Meli, an AI chief of staff that knows your clients and business. The agents complete tasks across connected apps and channels to automate operational work. More than 10,000 teams use it. A free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Shared inbox in Gmail
Meli AI agent
App integrations
Workflow automation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Support, sales and operations teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== AI-браузери (productivity/ai-browsers) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'productivity' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ai-browsers' LIMIT 1);

-- ChatGPT Atlas
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chatgpt.com/atlas' OR LOWER(`name`) = 'chatgpt atlas')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ChatGPT Atlas', NULL, 'https://chatgpt.com/atlas', NULL, NULL, 'Браузер OpenAI з ChatGPT усередині: допомагає на будь-якій сторінці й виконує завдання в режимі агента.', 'OpenAI’s browser with ChatGPT built in: it helps on any page and completes tasks in agent mode.', 'ChatGPT Atlas — веббраузер, у центрі якого ChatGPT. Асистент бачить сторінку, на якій ви перебуваєте, і допомагає без копіювання тексту. Необов’язкова «пам’ять браузера» дає змогу ChatGPT згадувати контекст відвіданих сайтів; її можна переглядати й видаляти. У режимі агента ChatGPT досліджує, автоматизує завдання й бронює прямо під час перегляду (для платних тарифів).', 'ChatGPT Atlas is a web browser built around ChatGPT. The assistant sees the page you are on and helps without copy-pasting. Optional browser memories let ChatGPT recall context from sites you visit, and you can view or delete them. In agent mode ChatGPT researches, automates tasks and books things as you browse (on paid plans).', 'ChatGPT на будь-якій сторінці
Необов’язкова пам’ять браузера
Режим агента
Від OpenAI', 'ChatGPT on any page
Optional browser memories
Agent mode
From OpenAI', 'Користувачам ChatGPT, які хочуть AI у браузері.', 'ChatGPT users who want AI in their browser.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chatgpt.com/atlas' OR LOWER(`name`) = 'chatgpt atlas') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OpenAI’s browser with ChatGPT built in: it helps on any page and completes tasks in agent mode.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ChatGPT Atlas is a web browser built around ChatGPT. The assistant sees the page you are on and helps without copy-pasting. Optional browser memories let ChatGPT recall context from sites you visit, and you can view or delete them. In agent mode ChatGPT researches, automates tasks and books things as you browse (on paid plans).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'ChatGPT on any page
Optional browser memories
Agent mode
From OpenAI', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'ChatGPT users who want AI in their browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Microsoft Edge
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'microsoft.com/en-us/edge' OR LOWER(`name`) = 'microsoft edge')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Microsoft Edge', NULL, 'https://www.microsoft.com/en-us/edge', NULL, NULL, 'Безкоштовний браузер Microsoft із вбудованим Copilot, який порівнює вкладки й допомагає виконувати завдання.', 'Microsoft’s free browser with built-in Copilot that compares tabs and helps complete tasks.', 'Microsoft Edge має вбудований Copilot, який працює з відкритими вкладками: порівнює варіанти, пояснює головне й допомагає виконувати дії, а з вашого дозволу враховує історію перегляду для персональної допомоги. Браузер захищає від шахрайських сторінок типу scareware, організовує вкладки й дає доступ до безкоштовних вебзастосунків Microsoft 365.', 'Microsoft Edge has Copilot built in, working across your open tabs: it compares options, explains what matters and helps take actions, and with your permission uses browsing history for more personal help. The browser protects against scareware pages, organizes tabs and gives access to free Microsoft 365 web apps.', 'Вбудований Copilot
Порівняння вкладок
Захист від scareware
Безкоштовні вебзастосунки Microsoft 365', 'Built-in Copilot
Tab comparison
Scareware protection
Free Microsoft 365 web apps', 'Користувачам Windows і Microsoft 365.', 'Windows and Microsoft 365 users.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'microsoft.com/en-us/edge' OR LOWER(`name`) = 'microsoft edge') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Microsoft’s free browser with built-in Copilot that compares tabs and helps complete tasks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Microsoft Edge has Copilot built in, working across your open tabs: it compares options, explains what matters and helps take actions, and with your permission uses browsing history for more personal help. The browser protects against scareware pages, organizes tabs and gives access to free Microsoft 365 web apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Built-in Copilot
Tab comparison
Scareware protection
Free Microsoft 365 web apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Windows and Microsoft 365 users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fellou
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fellou.ai' OR LOWER(`name`) = 'fellou')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fellou', NULL, 'https://fellou.ai/', NULL, NULL, 'Агентний AI-браузер, який сам виконує багатокрокові завдання на сайтах і робить глибокі дослідження.', 'An agentic AI browser that performs multi-step tasks on websites and runs deep research.', 'Fellou позиціонує себе як «самокерований» браузер: AI не лише відповідає, а й діє — переходить між сайтами, збирає дані, аналізує конкурентів, планує поїздки чи готує огляди новин. Для розробників є відкритий фреймворк Eko 2.0 для створення власних агентів.', 'Fellou bills itself as a self-driving browser: AI does not just chat, it acts — moving across websites, gathering data, analyzing competitors, planning trips or compiling news briefings. Developers get the open-source Eko 2.0 framework for building custom agents.', 'Автоматизація дій на сайтах
Глибокі дослідження
Аналіз даних
Відкритий фреймворк Eko 2.0', 'Automated actions on websites
Deep research
Data analysis
Open-source Eko 2.0 framework', 'Дослідникам, аналітикам і тим, хто хоче делегувати рутину в мережі.', 'Researchers, analysts and anyone delegating online busywork.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fellou.ai' OR LOWER(`name`) = 'fellou') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An agentic AI browser that performs multi-step tasks on websites and runs deep research.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fellou bills itself as a self-driving browser: AI does not just chat, it acts — moving across websites, gathering data, analyzing competitors, planning trips or compiling news briefings. Developers get the open-source Eko 2.0 framework for building custom agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automated actions on websites
Deep research
Data analysis
Open-source Eko 2.0 framework', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Researchers, analysts and anyone delegating online busywork.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sigma AI Browser
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sigmabrowser.com' OR LOWER(`name`) = 'sigma ai browser')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sigma AI Browser', NULL, 'https://www.sigmabrowser.com/', NULL, NULL, 'Легкий приватний браузер з AI-агентом, який сам переходить сторінками й заповнює форми.', 'A lightweight private browser with an AI agent that navigates pages and fills in forms.', 'Sigma поєднує браузер із AI-агентом, якому достатньо описати мету: він сам переходить сторінками, заповнює форми й доводить завдання до кінця. Вбудований AI Chat відповідає на запитання, проводить глибокі дослідження, генерує зображення й тексти. Браузер робить акцент на приватності, частина компонентів має відкритий код.', 'Sigma combines a browser with an AI agent: describe the goal and it navigates pages, fills in forms and finishes the task. The built-in AI Chat answers questions, runs deep research and generates images and text. The browser emphasizes privacy, and some components are open source.', 'AI-агент для дій на сайтах
AI Chat і глибокі дослідження
Генерація зображень і текстів
Акцент на приватності', 'AI agent for on-site actions
AI Chat and deep research
Image and text generation
Privacy focus', 'Користувачам, які хочуть AI-агента в легкому браузері.', 'Users who want an AI agent in a lightweight browser.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sigmabrowser.com' OR LOWER(`name`) = 'sigma ai browser') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A lightweight private browser with an AI agent that navigates pages and fills in forms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sigma combines a browser with an AI agent: describe the goal and it navigates pages, fills in forms and finishes the task. The built-in AI Chat answers questions, runs deep research and generates images and text. The browser emphasizes privacy, and some components are open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI agent for on-site actions
AI Chat and deep research
Image and text generation
Privacy focus', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who want an AI agent in a lightweight browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Opera One
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'opera.com/one' OR LOWER(`name`) = 'opera one')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Opera One', NULL, 'https://www.opera.com/one', NULL, NULL, 'Безкоштовний браузер Opera з вбудованим AI, групами вкладок Tab Islands і безкоштовним VPN.', 'Opera’s free browser with built-in AI, Tab Islands tab groups and a free VPN.', 'Opera One має вбудований AI-асистент, який після оновлення R3 працює швидше й на кращих моделях. Вкладки автоматично групуються в Tab Islands, яким можна давати назви, а бічна панель і розділений екран допомагають працювати з кількома сторінками. У браузер вбудовано безкоштовний VPN.', 'Opera One has a built-in AI assistant that, after the R3 update, runs faster on better models. Tabs are grouped into nameable Tab Islands, and the sidebar and split screen help work with several pages. A free VPN is built in.', 'Вбудований AI-асистент
Tab Islands
Бічна панель і розділений екран
Безкоштовний VPN', 'Built-in AI assistant
Tab Islands
Sidebar and split screen
Free VPN', 'Користувачам, які хочуть функціональний безкоштовний браузер.', 'Users who want a feature-rich free browser.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'opera.com/one' OR LOWER(`name`) = 'opera one') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Opera’s free browser with built-in AI, Tab Islands tab groups and a free VPN.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Opera One has a built-in AI assistant that, after the R3 update, runs faster on better models. Tabs are grouped into nameable Tab Islands, and the sidebar and split screen help work with several pages. A free VPN is built in.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Built-in AI assistant
Tab Islands
Sidebar and split screen
Free VPN', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who want a feature-rich free browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Даосизм і конфуціанство (religion/taoism-confucianism) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'religion' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'taoism-confucianism' LIMIT 1);

-- Taoist Sanctuary of San Diego
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'taoistsanctuary.org' OR LOWER(`name`) = 'taoist sanctuary of san diego')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Taoist Sanctuary of San Diego', NULL, 'https://www.taoistsanctuary.org/', NULL, NULL, 'Некомерційна школа в Сан-Дієго, що з 1975 року навчає тайцзіцюань, цигун, даоської медитації та філософії.', 'A San Diego non-profit school teaching taijiquan, qigong, Taoist meditation and philosophy since 1975.', 'Taoist Sanctuary of San Diego — некомерційна організація, заснована 1975 року. Вона проводить заняття з тайцзіцюань, цигун і даоської медитації, курси даоської філософії та традиційних китайських методів оздоровлення. Заняття відбуваються в приміщенні й просто неба, проводяться семінари із запрошеними майстрами. Перше заняття для початківців можна відвідати безкоштовно.', 'The Taoist Sanctuary of San Diego is a non-profit founded in 1975. It offers classes in taijiquan, qigong and Taoist meditation, courses in Taoist philosophy and traditional Chinese healing methods. Classes run indoors and outdoors, and workshops with visiting masters are held. Beginners can try a class for free.', 'Тайцзіцюань і цигун
Даоська медитація й філософія
Семінари із запрошеними майстрами
Пробне заняття безкоштовно', 'Taijiquan and qigong
Taoist meditation and philosophy
Workshops with visiting masters
Free trial class', 'Тим, хто цікавиться даоськими практиками, зокрема жителям Сан-Дієго.', 'People interested in Taoist practices, especially in San Diego.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'taoistsanctuary.org' OR LOWER(`name`) = 'taoist sanctuary of san diego') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A San Diego non-profit school teaching taijiquan, qigong, Taoist meditation and philosophy since 1975.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Taoist Sanctuary of San Diego is a non-profit founded in 1975. It offers classes in taijiquan, qigong and Taoist meditation, courses in Taoist philosophy and traditional Chinese healing methods. Classes run indoors and outdoors, and workshops with visiting masters are held. Beginners can try a class for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Taijiquan and qigong
Taoist meditation and philosophy
Workshops with visiting masters
Free trial class', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People interested in Taoist practices, especially in San Diego.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Abode of the Eternal Tao
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'abodetao.com' OR LOWER(`name`) = 'abode of the eternal tao')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Abode of the Eternal Tao', NULL, 'https://abodetao.com/', NULL, NULL, 'Даоський центр і видавець журналу The Empty Vessel: статті, інтерв’ю та курс «Embarking Upon the Way».', 'A Taoist center and publisher of The Empty Vessel journal: articles, interviews and the course Embarking Upon the Way.', 'Abode of the Eternal Tao публікує статті й інтерв’ю про даосизм, цигун, медитацію, фен-шуй та зв’язок даосизму з чань-буддизмом, зокрема матеріали журналу The Empty Vessel. Центр пропонує вступний курс із даосизму «Embarking Upon the Way» для тих, хто хоче систематично познайомитися з традицією.', 'Abode of the Eternal Tao publishes articles and interviews on Taoism, qigong, meditation, feng shui and the links between Taoism and Chan Buddhism, including material from The Empty Vessel journal. The center offers an introductory Taoism course, Embarking Upon the Way, for those who want a structured introduction to the tradition.', 'Статті та інтерв’ю про даосизм
Матеріали журналу The Empty Vessel
Курс «Embarking Upon the Way»
Цигун і медитація', 'Articles and interviews on Taoism
The Empty Vessel journal content
Embarking Upon the Way course
Qigong and meditation', 'Тим, хто вивчає даоську філософію й практики.', 'Those studying Taoist philosophy and practice.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'abodetao.com' OR LOWER(`name`) = 'abode of the eternal tao') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Taoist center and publisher of The Empty Vessel journal: articles, interviews and the course Embarking Upon the Way.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Abode of the Eternal Tao publishes articles and interviews on Taoism, qigong, meditation, feng shui and the links between Taoism and Chan Buddhism, including material from The Empty Vessel journal. The center offers an introductory Taoism course, Embarking Upon the Way, for those who want a structured introduction to the tradition.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Articles and interviews on Taoism
The Empty Vessel journal content
Embarking Upon the Way course
Qigong and meditation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Those studying Taoist philosophy and practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Саєнтологія (religion/scientology) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'religion' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'scientology' LIMIT 1);

-- Scientology Newsroom
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scientologynews.org' OR LOWER(`name`) = 'scientology newsroom')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Scientology Newsroom', NULL, 'https://www.scientologynews.org/', NULL, NULL, 'Офіційний сайт новин Церкви саєнтології: події, відкриття церков і соціальні програми.', 'The official news site of the Church of Scientology: events, church openings and social programs.', 'Scientology Newsroom — офіційний ресурс новин Церкви саєнтології. Тут публікують повідомлення про релігійні події, відкриття нових церков, гуманітарні й соціальні програми, які підтримує церква, а також контакти представників для преси.', 'Scientology Newsroom is the official news outlet of the Church of Scientology. It publishes announcements about religious events, new church openings, humanitarian and social programs supported by the church, and press contacts.', 'Новини церкви
Відкриття нових церков
Соціальні програми
Контакти для преси', 'Church news
New church openings
Social programs
Press contacts', 'Журналістам і тим, хто цікавиться офіційною позицією церкви.', 'Journalists and those interested in the church’s official statements.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scientologynews.org' OR LOWER(`name`) = 'scientology newsroom') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official news site of the Church of Scientology: events, church openings and social programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Scientology Newsroom is the official news outlet of the Church of Scientology. It publishes announcements about religious events, new church openings, humanitarian and social programs supported by the church, and press contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Church news
New church openings
Social programs
Press contacts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Journalists and those interested in the church’s official statements.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Freedom Magazine
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freedommag.org' OR LOWER(`name`) = 'freedom magazine')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Freedom Magazine', NULL, 'https://www.freedommag.org/', NULL, NULL, 'Журнал, який видає Церква саєнтології: розслідування та публікації на суспільні теми.', 'A magazine published by the Church of Scientology: investigations and articles on social issues.', 'Freedom — журнал, який видає Церква саєнтології. Він публікує розслідувальні матеріали та статті на суспільні теми, зокрема про програми проти вживання наркотиків, а також відповіді церкви на публікації в інших медіа.', 'Freedom is a magazine published by the Church of Scientology. It runs investigative pieces and articles on social issues, including anti-drug programs, as well as the church’s responses to coverage in other media.', 'Розслідувальні статті
Соціальні теми
Відповіді на публікації в медіа
Онлайн-архів', 'Investigative articles
Social issues
Responses to media coverage
Online archive', 'Читачам, які цікавляться позицією церкви.', 'Readers interested in the church’s perspective.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freedommag.org' OR LOWER(`name`) = 'freedom magazine') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A magazine published by the Church of Scientology: investigations and articles on social issues.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Freedom is a magazine published by the Church of Scientology. It runs investigative pieces and articles on social issues, including anti-drug programs, as well as the church’s responses to coverage in other media.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Investigative articles
Social issues
Responses to media coverage
Online archive', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers interested in the church’s perspective.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Applied Scholastics
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'appliedscholastics.org' OR LOWER(`name`) = 'applied scholastics')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Applied Scholastics', NULL, 'https://www.appliedscholastics.org/', NULL, NULL, 'Некомерційна освітня організація, що поширює «технологію навчання» за методикою Л. Рона Хаббарда.', 'A non-profit educational organization promoting “Study Technology” based on L. Ron Hubbard’s methods.', 'Applied Scholastics International — некомерційна освітня організація зі штаб-квартирою в Міссурі (США). Вона впроваджує методи навчання, розроблені Л. Роном Хаббардом, у школах і програмах грамотності, зокрема Applied Scholastics Achievement Program і Hollywood Education and Literacy Project.', 'Applied Scholastics International is a non-profit educational organization headquartered in Missouri, USA. It implements learning methods developed by L. Ron Hubbard in schools and literacy programs, including the Applied Scholastics Achievement Program and the Hollywood Education and Literacy Project.', 'Методики «технології навчання»
Програми грамотності
Навчання освітян
Безкоштовна книга', 'Study Technology methods
Literacy programs
Educator training
Free book', 'Освітянам і батькам, які цікавляться цими методиками.', 'Educators and parents interested in these methods.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'appliedscholastics.org' OR LOWER(`name`) = 'applied scholastics') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A non-profit educational organization promoting “Study Technology” based on L. Ron Hubbard’s methods.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Applied Scholastics International is a non-profit educational organization headquartered in Missouri, USA. It implements learning methods developed by L. Ron Hubbard in schools and literacy programs, including the Applied Scholastics Achievement Program and the Hollywood Education and Literacy Project.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Study Technology methods
Literacy programs
Educator training
Free book', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Educators and parents interested in these methods.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Брахма Кумаріс (religion/brahma-kumaris) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'religion' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'brahma-kumaris' LIMIT 1);

-- Peace of Mind TV
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pmtv.in' OR LOWER(`name`) = 'peace of mind tv')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Peace of Mind TV', NULL, 'https://pmtv.in/', NULL, NULL, 'Телеканал Брахма Кумаріс зі студією в Шантівані: медитація, духовні лекції та програми про спокій розуму.', 'The Brahma Kumaris TV channel based at Shantivan: meditation, spiritual talks and programs on peace of mind.', 'Peace of Mind TV — телеканал, який веде Брахма Кумаріс у Шантівані (Абу-Роуд, Індія). Він транслює програми з медитації раджа-йоги, духовні лекції та передачі про позитивне мислення. Канал доступний в індійських супутникових і кабельних мережах та онлайн.', 'Peace of Mind TV is a channel run by the Brahma Kumaris at Shantivan (Abu Road, India). It broadcasts Raja Yoga meditation programs, spiritual talks and shows on positive thinking. It is available on Indian satellite and cable networks and online.', 'Програми медитації раджа-йоги
Духовні лекції
Супутникові мережі Індії
Онлайн-трансляція', 'Raja Yoga meditation programs
Spiritual talks
Indian satellite networks
Online streaming', 'Глядачам, що цікавляться медитацією й духовністю.', 'Viewers interested in meditation and spirituality.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pmtv.in' OR LOWER(`name`) = 'peace of mind tv') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Brahma Kumaris TV channel based at Shantivan: meditation, spiritual talks and programs on peace of mind.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Peace of Mind TV is a channel run by the Brahma Kumaris at Shantivan (Abu Road, India). It broadcasts Raja Yoga meditation programs, spiritual talks and shows on positive thinking. It is available on Indian satellite and cable networks and online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Raja Yoga meditation programs
Spiritual talks
Indian satellite networks
Online streaming', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Viewers interested in meditation and spirituality.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Brahma Kumaris South Africa
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.org.za' OR LOWER(`name`) = 'brahma kumaris south africa')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Brahma Kumaris South Africa', NULL, 'https://brahmakumaris.org.za/', NULL, NULL, 'Південноафриканське відділення Брахма Кумаріс: медитація, курси й заходи для особистої трансформації.', 'The South African branch of the Brahma Kumaris: meditation, courses and events for personal transformation.', 'Brahma Kumaris South Africa — частина всесвітнього духовного руху, який навчає сприймати світ як передусім духовний і пропонує медитацію раджа-йоги для особистої трансформації. Відділення проводить курси, медитації й заходи в Південній Африці.', 'Brahma Kumaris South Africa is part of the worldwide spiritual movement that teaches viewing the world as essentially spiritual and offers Raja Yoga meditation for personal transformation. The branch runs courses, meditations and events in South Africa.', 'Курси медитації раджа-йоги
Заходи в Південній Африці
Духовні матеріали
Частина всесвітнього руху', 'Raja Yoga meditation courses
Events in South Africa
Spiritual resources
Part of a worldwide movement', 'Жителям Південної Африки, які цікавляться медитацією.', 'People in South Africa interested in meditation.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.org.za' OR LOWER(`name`) = 'brahma kumaris south africa') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The South African branch of the Brahma Kumaris: meditation, courses and events for personal transformation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Brahma Kumaris South Africa is part of the worldwide spiritual movement that teaches viewing the world as essentially spiritual and offers Raja Yoga meditation for personal transformation. The branch runs courses, meditations and events in South Africa.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Raja Yoga meditation courses
Events in South Africa
Spiritual resources
Part of a worldwide movement', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in South Africa interested in meditation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Global Retreat Centre
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'globalretreatcentre.org' OR LOWER(`name`) = 'global retreat centre')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Global Retreat Centre', NULL, 'https://www.globalretreatcentre.org/', NULL, NULL, 'Ретритний центр Брахма Кумаріс біля Оксфорда: ретрити, лекції, семінари й курси медитації з 1993 року.', 'A Brahma Kumaris retreat centre near Oxford: retreats, talks, seminars and meditation courses since 1993.', 'Global Retreat Centre поблизу Оксфорда з 1993 року приймає гостей з усього світу. Центр пропонує ретрити з проживанням і одноденні, лекції, семінари й курси з медитації та духовного розвитку. Ним опікується Brahma Kumaris World Spiritual University UK — зареєстрована благодійна організація.', 'Since 1993 the Global Retreat Centre near Oxford has welcomed guests from around the world. It offers residential and one-day retreats, lectures, seminars and courses on meditation and spiritual development. It is run by the Brahma Kumaris World Spiritual University UK, a registered charity.', 'Ретрити з проживанням і одноденні
Лекції та семінари
Курси медитації
Онлайн-заходи', 'Residential and one-day retreats
Lectures and seminars
Meditation courses
Online events', 'Тим, хто шукає ретрит для медитації у Великій Британії.', 'People seeking a meditation retreat in the UK.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'globalretreatcentre.org' OR LOWER(`name`) = 'global retreat centre') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Brahma Kumaris retreat centre near Oxford: retreats, talks, seminars and meditation courses since 1993.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Since 1993 the Global Retreat Centre near Oxford has welcomed guests from around the world. It offers residential and one-day retreats, lectures, seminars and courses on meditation and spiritual development. It is run by the Brahma Kumaris World Spiritual University UK, a registered charity.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Residential and one-day retreats
Lectures and seminars
Meditation courses
Online events', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People seeking a meditation retreat in the UK.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Трансцендентальна медитація (religion/transcendental-meditation) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'religion' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'transcendental-meditation' LIMIT 1);

-- Maharishi International University
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'miu.edu' OR LOWER(`name`) = 'maharishi international university')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Maharishi International University', NULL, 'https://www.miu.edu/', NULL, NULL, 'Акредитований некомерційний університет в Айові з «освітою на основі свідомості» та практикою ТМ.', 'An accredited non-profit university in Iowa with Consciousness-Based Education and TM practice.', 'Maharishi International University (раніше Maharishi University of Management) — акредитований некомерційний університет у Ферфілді, Айова. Навчання побудоване на підході Consciousness-Based Education, а студенти й викладачі практикують Трансцендентальну медитацію. Є програми бакалаврату й магістратури на кампусі та онлайн.', 'Maharishi International University (formerly Maharishi University of Management) is an accredited non-profit university in Fairfield, Iowa. Its teaching follows the Consciousness-Based Education approach, and students and faculty practice Transcendental Meditation. Bachelor’s and master’s programs are offered on campus and online.', 'Акредитовані програми
Навчання на кампусі й онлайн
Практика ТМ
Consciousness-Based Education', 'Accredited programs
On-campus and online study
TM practice
Consciousness-Based Education', 'Абітурієнтам і студентам, яким цікавий цей підхід до освіти.', 'Prospective and current students interested in this approach to education.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'miu.edu' OR LOWER(`name`) = 'maharishi international university') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An accredited non-profit university in Iowa with Consciousness-Based Education and TM practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Maharishi International University (formerly Maharishi University of Management) is an accredited non-profit university in Fairfield, Iowa. Its teaching follows the Consciousness-Based Education approach, and students and faculty practice Transcendental Meditation. Bachelor’s and master’s programs are offered on campus and online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Accredited programs
On-campus and online study
TM practice
Consciousness-Based Education', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Prospective and current students interested in this approach to education.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Transcendental Meditation UK
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tm.org/en-gb' OR LOWER(`name`) = 'transcendental meditation uk')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Transcendental Meditation UK', NULL, 'https://www.tm.org/en-gb', NULL, NULL, 'Офіційний сайт ТМ для Великої Британії: курс медитації один на один і безкоштовні інформаційні зустрічі.', 'The official TM website for the UK: one-to-one meditation course and free info sessions.', 'Британська версія офіційного сайту Трансцендентальної медитації пояснює, як проходить курс: техніці навчають індивідуально сертифіковані викладачі. Можна записатися на безкоштовну інформаційну зустріч офлайн чи онлайн і знайти найближчий центр ТМ.', 'The UK edition of the official Transcendental Meditation website explains how the course works: the technique is taught one-to-one by certified teachers. You can book a free info session in person or online and find your nearest TM centre.', 'Індивідуальне навчання техніці
Безкоштовні інформаційні зустрічі
Пошук центрів ТМ
Матеріали про дослідження', 'One-to-one technique instruction
Free info sessions
TM centre finder
Research materials', 'Жителям Великої Британії, які хочуть навчитися ТМ.', 'People in the UK who want to learn TM.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tm.org/en-gb' OR LOWER(`name`) = 'transcendental meditation uk') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official TM website for the UK: one-to-one meditation course and free info sessions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The UK edition of the official Transcendental Meditation website explains how the course works: the technique is taught one-to-one by certified teachers. You can book a free info session in person or online and find your nearest TM centre.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'One-to-one technique instruction
Free info sessions
TM centre finder
Research materials', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in the UK who want to learn TM.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Maharishi School
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'maharishischool.org' OR LOWER(`name`) = 'maharishi school')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Maharishi School', NULL, 'https://www.maharishischool.org/', NULL, NULL, 'Незалежна акредитована школа (дошкілля — 12 клас) у Ферфілді, Айова, з освітою на основі свідомості.', 'An independent accredited PreK–12 school in Fairfield, Iowa, with Consciousness-Based Education.', 'Maharishi School поєднує поглиблену підготовку до коледжу з підходом Consciousness-Based Education і щоденною практикою, що розвиває зосередженість. Невеликі класи й міжнародна шкільна спільнота. Школа акредитована й приймає дітей від дошкільного віку до 12 класу.', 'Maharishi School combines rigorous college-preparatory academics with Consciousness-Based Education and a daily practice that builds focus. It has small classes and an international school community. The school is accredited and enrolls children from preschool to grade 12.', 'Підготовка до коледжу
Невеликі класи
Щоденна практика зосередженості
Від дошкілля до 12 класу', 'College-preparatory academics
Small classes
Daily focus practice
Preschool to grade 12', 'Батькам, які обирають школу з таким підходом.', 'Parents choosing a school with this approach.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'maharishischool.org' OR LOWER(`name`) = 'maharishi school') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An independent accredited PreK–12 school in Fairfield, Iowa, with Consciousness-Based Education.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Maharishi School combines rigorous college-preparatory academics with Consciousness-Based Education and a daily practice that builds focus. It has small classes and an international school community. The school is accredited and enrolls children from preschool to grade 12.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'College-preparatory academics
Small classes
Daily focus practice
Preschool to grade 12', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents choosing a school with this approach.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Ошо (religion/osho) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'religion' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'osho' LIMIT 1);

-- OSHO Times
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oshotimes.com' OR LOWER(`name`) = 'osho times')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OSHO Times', NULL, 'https://www.oshotimes.com/', NULL, NULL, 'Онлайн-журнал з уривками бесід Ошо та статтями про медитацію, усвідомленість і життя.', 'An online magazine with excerpts from Osho’s talks and articles on meditation, awareness and life.', 'OSHOTimes публікує уривки з бесід Ошо та статті на теми медитації, свободи, творчості, стосунків і суспільства. Матеріали згруповано за темами, доступ до сайту вільний.', 'OSHOTimes publishes excerpts from Osho’s talks and articles on meditation, freedom, creativity, relationships and society. Material is grouped by theme, and the site is freely accessible.', 'Уривки бесід Ошо
Статті про медитацію
Тематичні розділи
Вільний доступ', 'Excerpts from Osho’s talks
Articles on meditation
Thematic sections
Free access', 'Читачам, які цікавляться ідеями Ошо.', 'Readers interested in Osho’s ideas.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oshotimes.com' OR LOWER(`name`) = 'osho times') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An online magazine with excerpts from Osho’s talks and articles on meditation, awareness and life.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OSHOTimes publishes excerpts from Osho’s talks and articles on meditation, freedom, creativity, relationships and society. Material is grouped by theme, and the site is freely accessible.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Excerpts from Osho’s talks
Articles on meditation
Thematic sections
Free access', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers interested in Osho’s ideas.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OSHO Meditation Resort
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'osho.com/osho-meditation-resort' OR LOWER(`name`) = 'osho meditation resort')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OSHO Meditation Resort', NULL, 'https://www.osho.com/osho-meditation-resort', NULL, NULL, 'Міжнародний медитаційний курорт OSHO в Пуні: курси, медитації, сесії та програми відпочинку.', 'The OSHO International Meditation Resort in Pune: courses, meditations, sessions and wellness programs.', 'OSHO International Meditation Resort у Пуні (Індія) пропонує щоденні медитації, курси, індивідуальні сесії та оздоровчі програми. Бронювання курсів відбувається через booking.osho.com після безкоштовної реєстрації; для знайомства є пробні заняття.', 'The OSHO International Meditation Resort in Pune, India, offers daily meditations, courses, individual sessions and wellness programs. Courses are booked via booking.osho.com after free registration, and taster sessions are available.', 'Щоденні медитації
Курси й індивідуальні сесії
Пробні заняття
Онлайн-бронювання', 'Daily meditations
Courses and individual sessions
Taster sessions
Online booking', 'Тим, хто планує поїздку на медитаційний курорт.', 'People planning a meditation retreat trip.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'osho.com/osho-meditation-resort' OR LOWER(`name`) = 'osho meditation resort') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The OSHO International Meditation Resort in Pune: courses, meditations, sessions and wellness programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The OSHO International Meditation Resort in Pune, India, offers daily meditations, courses, individual sessions and wellness programs. Courses are booked via booking.osho.com after free registration, and taster sessions are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily meditations
Courses and individual sessions
Taster sessions
Online booking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People planning a meditation retreat trip.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Osho News
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oshonews.com' OR LOWER(`name`) = 'osho news')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Osho News', NULL, 'https://www.oshonews.com/', NULL, NULL, 'Онлайн-журнал для спільноти санньясинів Ошо та всіх, хто цікавиться медитацією й духовним зростанням.', 'An online magazine for the Osho sannyas community and anyone interested in meditation and spiritual growth.', 'Osho News публікує профілі людей і місць, нотатки про медитацію та зцілення, мистецтво, рецензії на книжки й фільми, новини й анонси подій, а також цитати й уривки бесід Ошо. Журнал створює спільнота, доступ вільний.', 'Osho News publishes profiles of people and places, notes on meditation and healing, art, book and film reviews, news and event listings, plus Osho quotes and discourse excerpts. It is made by the community and free to read.', 'Профілі й есе
Медитація та зцілення
Рецензії й анонси подій
Цитати Ошо', 'Profiles and essays
Meditation and healing
Reviews and event listings
Osho quotes', 'Спільноті санньясинів і читачам, що цікавляться медитацією.', 'The sannyas community and readers interested in meditation.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oshonews.com' OR LOWER(`name`) = 'osho news') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An online magazine for the Osho sannyas community and anyone interested in meditation and spiritual growth.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Osho News publishes profiles of people and places, notes on meditation and healing, art, book and film reviews, news and event listings, plus Osho quotes and discourse excerpts. It is made by the community and free to read.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Profiles and essays
Meditation and healing
Reviews and event listings
Osho quotes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'The sannyas community and readers interested in meditation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Сахаджа-йога (religion/sahaja-yoga) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'religion' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'sahaja-yoga' LIMIT 1);

-- Sahaja Yoga Australia
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajayoga.org.au' OR LOWER(`name`) = 'sahaja yoga australia')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sahaja Yoga Australia', NULL, 'https://sahajayoga.org.au/', NULL, NULL, 'Офіційний сайт Сахаджа-йоги для Австралії: безкоштовні заняття з медитації за методом Шрі Матаджі Нірмали Деві.', 'The official Sahaja Yoga site for Australia: free meditation classes in the method of Shri Mataji Nirmala Devi.', 'Сахаджа-йога — метод медитації, заснований 1970 року Шрі Матаджі Нірмалою Деві й поширений у понад 100 країнах. Сайт для Австралії розповідає про практику й розклад занять. Волонтери проводять безкоштовні заняття наживо та онлайн-сесії в YouTube, Facebook і Zoom.', 'Sahaja Yoga is a meditation method founded in 1970 by Shri Mataji Nirmala Devi and practiced in over 100 countries. The Australia site explains the practice and lists class schedules. Volunteers run free in-person classes and online sessions on YouTube, Facebook and Zoom.', 'Безкоштовні заняття з медитації
Розклад і адреси центрів
Онлайн-сесії
Матеріали про практику', 'Free meditation classes
Centre schedules and locations
Online sessions
Practice resources', 'Жителям Австралії, які хочуть спробувати медитацію.', 'People in Australia who want to try meditation.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajayoga.org.au' OR LOWER(`name`) = 'sahaja yoga australia') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official Sahaja Yoga site for Australia: free meditation classes in the method of Shri Mataji Nirmala Devi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sahaja Yoga is a meditation method founded in 1970 by Shri Mataji Nirmala Devi and practiced in over 100 countries. The Australia site explains the practice and lists class schedules. Volunteers run free in-person classes and online sessions on YouTube, Facebook and Zoom.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free meditation classes
Centre schedules and locations
Online sessions
Practice resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Australia who want to try meditation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sahaja Yoga India
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajayoga.org.in' OR LOWER(`name`) = 'sahaja yoga india')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sahaja Yoga India', NULL, 'https://sahajayoga.org.in/', NULL, NULL, 'Офіційний сайт Сахаджа-йоги для Індії: безкоштовні заняття з медитації за методом Шрі Матаджі Нірмали Деві.', 'The official Sahaja Yoga site for India: free meditation classes in the method of Shri Mataji Nirmala Devi.', 'Сахаджа-йога — метод медитації, заснований 1970 року Шрі Матаджі Нірмалою Деві й поширений у понад 100 країнах. Сайт для Індії розповідає про практику й розклад занять. Сайт допомагає знайти найближчий центр медитації та пропонує онлайн-знайомство з практикою.', 'Sahaja Yoga is a meditation method founded in 1970 by Shri Mataji Nirmala Devi and practiced in over 100 countries. The India site explains the practice and lists class schedules. The site helps find a nearby meditation centre and offers an online introduction to the practice.', 'Безкоштовні заняття з медитації
Розклад і адреси центрів
Онлайн-сесії
Матеріали про практику', 'Free meditation classes
Centre schedules and locations
Online sessions
Practice resources', 'Жителям Індії, які хочуть спробувати медитацію.', 'People in India who want to try meditation.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajayoga.org.in' OR LOWER(`name`) = 'sahaja yoga india') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official Sahaja Yoga site for India: free meditation classes in the method of Shri Mataji Nirmala Devi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sahaja Yoga is a meditation method founded in 1970 by Shri Mataji Nirmala Devi and practiced in over 100 countries. The India site explains the practice and lists class schedules. The site helps find a nearby meditation centre and offers an online introduction to the practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free meditation classes
Centre schedules and locations
Online sessions
Practice resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in India who want to try meditation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sahaja Yoga Canada
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajayoga.ca' OR LOWER(`name`) = 'sahaja yoga canada')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sahaja Yoga Canada', NULL, 'https://www.sahajayoga.ca/', NULL, NULL, 'Офіційний сайт Сахаджа-йоги для Канади: безкоштовні заняття з медитації за методом Шрі Матаджі Нірмали Деві.', 'The official Sahaja Yoga site for Canada: free meditation classes in the method of Shri Mataji Nirmala Devi.', 'Сахаджа-йога — метод медитації, заснований 1970 року Шрі Матаджі Нірмалою Деві й поширений у понад 100 країнах. Сайт для Канади розповідає про практику й розклад занять. Центри проводять безкоштовні заняття для людей будь-якого віку.', 'Sahaja Yoga is a meditation method founded in 1970 by Shri Mataji Nirmala Devi and practiced in over 100 countries. The Canada site explains the practice and lists class schedules. Centres run free classes for people of any age.', 'Безкоштовні заняття з медитації
Розклад і адреси центрів
Онлайн-сесії
Матеріали про практику', 'Free meditation classes
Centre schedules and locations
Online sessions
Practice resources', 'Жителям Канади, які хочуть спробувати медитацію.', 'People in Canada who want to try meditation.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajayoga.ca' OR LOWER(`name`) = 'sahaja yoga canada') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official Sahaja Yoga site for Canada: free meditation classes in the method of Shri Mataji Nirmala Devi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sahaja Yoga is a meditation method founded in 1970 by Shri Mataji Nirmala Devi and practiced in over 100 countries. The Canada site explains the practice and lists class schedules. Centres run free classes for people of any age.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free meditation classes
Centre schedules and locations
Online sessions
Practice resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Canada who want to try meditation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sahaja Yoga Germany
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajayoga.de' OR LOWER(`name`) = 'sahaja yoga germany')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sahaja Yoga Germany', NULL, 'https://www.sahajayoga.de/', NULL, NULL, 'Офіційний сайт Сахаджа-йоги для Німеччини: безкоштовні заняття з медитації за методом Шрі Матаджі Нірмали Деві.', 'The official Sahaja Yoga site for Germany: free meditation classes in the method of Shri Mataji Nirmala Devi.', 'Сахаджа-йога — метод медитації, заснований 1970 року Шрі Матаджі Нірмалою Деві й поширений у понад 100 країнах. Сайт для Німеччини розповідає про практику й розклад занять. Курси проходять по всій Німеччині; сайт німецькою мовою.', 'Sahaja Yoga is a meditation method founded in 1970 by Shri Mataji Nirmala Devi and practiced in over 100 countries. The Germany site explains the practice and lists class schedules. Courses run across Germany; the site is in German.', 'Безкоштовні заняття з медитації
Розклад і адреси центрів
Онлайн-сесії
Матеріали про практику', 'Free meditation classes
Centre schedules and locations
Online sessions
Practice resources', 'Жителям Німеччини, які хочуть спробувати медитацію.', 'People in Germany who want to try meditation.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajayoga.de' OR LOWER(`name`) = 'sahaja yoga germany') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official Sahaja Yoga site for Germany: free meditation classes in the method of Shri Mataji Nirmala Devi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sahaja Yoga is a meditation method founded in 1970 by Shri Mataji Nirmala Devi and practiced in over 100 countries. The Germany site explains the practice and lists class schedules. Courses run across Germany; the site is in German.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free meditation classes
Centre schedules and locations
Online sessions
Practice resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Germany who want to try meditation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Еканкар (religion/eckankar) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'religion' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'eckankar' LIMIT 1);

-- Eckankar Australia
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.org.au' OR LOWER(`name`) = 'eckankar australia')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eckankar Australia', NULL, 'https://www.eckankar.org.au/', NULL, NULL, 'Сайт Еканкару для Австралії: заходи, семінари й духовні вправи «шляху духовної свободи».', 'The Eckankar site for Australia: events, seminars and spiritual exercises of the “Path of Spiritual Freedom.”', 'Еканкар навчає, що Душа пізнає Світло й Звук Бога через духовні вправи ECK, зокрема спів HU. Сайт для Австралії (англійською) анонсує місцеві заходи, семінари й зустрічі, розповідає про вчення та контакти місцевих груп.', 'Eckankar teaches that Soul experiences the Light and Sound of God through the Spiritual Exercises of ECK, including singing HU. The Australia site (in English) lists local events, seminars and gatherings and describes the teachings and local contacts.', 'Місцеві заходи й семінари
Духовні вправи ECK
Спів HU
Контакти груп', 'Local events and seminars
Spiritual Exercises of ECK
Singing HU
Group contacts', 'Жителям Австралії, які цікавляться Еканкаром.', 'People in Australia interested in Eckankar.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.org.au' OR LOWER(`name`) = 'eckankar australia') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Eckankar site for Australia: events, seminars and spiritual exercises of the “Path of Spiritual Freedom.”', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Eckankar teaches that Soul experiences the Light and Sound of God through the Spiritual Exercises of ECK, including singing HU. The Australia site (in English) lists local events, seminars and gatherings and describes the teachings and local contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local events and seminars
Spiritual Exercises of ECK
Singing HU
Group contacts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Australia interested in Eckankar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eckankar Nigeria
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankarnigeria.org' OR LOWER(`name`) = 'eckankar nigeria')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eckankar Nigeria', NULL, 'https://www.eckankarnigeria.org/', NULL, NULL, 'Сайт Еканкару для Нігерії: заходи, семінари й духовні вправи «шляху духовної свободи».', 'The Eckankar site for Nigeria: events, seminars and spiritual exercises of the “Path of Spiritual Freedom.”', 'Еканкар навчає, що Душа пізнає Світло й Звук Бога через духовні вправи ECK, зокрема спів HU. Сайт для Нігерії (англійською) анонсує місцеві заходи, семінари й зустрічі, розповідає про вчення та контакти місцевих груп.', 'Eckankar teaches that Soul experiences the Light and Sound of God through the Spiritual Exercises of ECK, including singing HU. The Nigeria site (in English) lists local events, seminars and gatherings and describes the teachings and local contacts.', 'Місцеві заходи й семінари
Духовні вправи ECK
Спів HU
Контакти груп', 'Local events and seminars
Spiritual Exercises of ECK
Singing HU
Group contacts', 'Жителям Нігерії, які цікавляться Еканкаром.', 'People in Nigeria interested in Eckankar.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankarnigeria.org' OR LOWER(`name`) = 'eckankar nigeria') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Eckankar site for Nigeria: events, seminars and spiritual exercises of the “Path of Spiritual Freedom.”', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Eckankar teaches that Soul experiences the Light and Sound of God through the Spiritual Exercises of ECK, including singing HU. The Nigeria site (in English) lists local events, seminars and gatherings and describes the teachings and local contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local events and seminars
Spiritual Exercises of ECK
Singing HU
Group contacts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Nigeria interested in Eckankar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eckankar Germany
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.de' OR LOWER(`name`) = 'eckankar germany')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eckankar Germany', NULL, 'https://eckankar.de/', NULL, NULL, 'Сайт Еканкару для Німеччини: заходи, семінари й духовні вправи «шляху духовної свободи».', 'The Eckankar site for Germany: events, seminars and spiritual exercises of the “Path of Spiritual Freedom.”', 'Еканкар навчає, що Душа пізнає Світло й Звук Бога через духовні вправи ECK, зокрема спів HU. Сайт для Німеччини (німецькою) анонсує місцеві заходи, семінари й зустрічі, розповідає про вчення та контакти місцевих груп.', 'Eckankar teaches that Soul experiences the Light and Sound of God through the Spiritual Exercises of ECK, including singing HU. The Germany site (in German) lists local events, seminars and gatherings and describes the teachings and local contacts.', 'Місцеві заходи й семінари
Духовні вправи ECK
Спів HU
Контакти груп', 'Local events and seminars
Spiritual Exercises of ECK
Singing HU
Group contacts', 'Жителям Німеччини, які цікавляться Еканкаром.', 'People in Germany interested in Eckankar.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.de' OR LOWER(`name`) = 'eckankar germany') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Eckankar site for Germany: events, seminars and spiritual exercises of the “Path of Spiritual Freedom.”', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Eckankar teaches that Soul experiences the Light and Sound of God through the Spiritual Exercises of ECK, including singing HU. The Germany site (in German) lists local events, seminars and gatherings and describes the teachings and local contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local events and seminars
Spiritual Exercises of ECK
Singing HU
Group contacts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Germany interested in Eckankar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eckankar Netherlands
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.nl' OR LOWER(`name`) = 'eckankar netherlands')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eckankar Netherlands', NULL, 'https://www.eckankar.nl/', NULL, NULL, 'Сайт Еканкару для Нідерландів: заходи, семінари й духовні вправи «шляху духовної свободи».', 'The Eckankar site for the Netherlands: events, seminars and spiritual exercises of the “Path of Spiritual Freedom.”', 'Еканкар навчає, що Душа пізнає Світло й Звук Бога через духовні вправи ECK, зокрема спів HU. Сайт для Нідерландів (нідерландською) анонсує місцеві заходи, семінари й зустрічі, розповідає про вчення та контакти місцевих груп.', 'Eckankar teaches that Soul experiences the Light and Sound of God through the Spiritual Exercises of ECK, including singing HU. The the Netherlands site (in Dutch) lists local events, seminars and gatherings and describes the teachings and local contacts.', 'Місцеві заходи й семінари
Духовні вправи ECK
Спів HU
Контакти груп', 'Local events and seminars
Spiritual Exercises of ECK
Singing HU
Group contacts', 'Жителям Нідерландів, які цікавляться Еканкаром.', 'People in the Netherlands interested in Eckankar.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.nl' OR LOWER(`name`) = 'eckankar netherlands') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Eckankar site for the Netherlands: events, seminars and spiritual exercises of the “Path of Spiritual Freedom.”', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Eckankar teaches that Soul experiences the Light and Sound of God through the Spiritual Exercises of ECK, including singing HU. The the Netherlands site (in Dutch) lists local events, seminars and gatherings and describes the teachings and local contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local events and seminars
Spiritual Exercises of ECK
Singing HU
Group contacts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in the Netherlands interested in Eckankar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eckankar Switzerland
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.ch' OR LOWER(`name`) = 'eckankar switzerland')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eckankar Switzerland', NULL, 'https://www.eckankar.ch/', NULL, NULL, 'Сайт Еканкару для Швейцарії: заходи, семінари й духовні вправи «шляху духовної свободи».', 'The Eckankar site for Switzerland: events, seminars and spiritual exercises of the “Path of Spiritual Freedom.”', 'Еканкар навчає, що Душа пізнає Світло й Звук Бога через духовні вправи ECK, зокрема спів HU. Сайт для Швейцарії (німецькою) анонсує місцеві заходи, семінари й зустрічі, розповідає про вчення та контакти місцевих груп.', 'Eckankar teaches that Soul experiences the Light and Sound of God through the Spiritual Exercises of ECK, including singing HU. The Switzerland site (in German) lists local events, seminars and gatherings and describes the teachings and local contacts.', 'Місцеві заходи й семінари
Духовні вправи ECK
Спів HU
Контакти груп', 'Local events and seminars
Spiritual Exercises of ECK
Singing HU
Group contacts', 'Жителям Швейцарії, які цікавляться Еканкаром.', 'People in Switzerland interested in Eckankar.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.ch' OR LOWER(`name`) = 'eckankar switzerland') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Eckankar site for Switzerland: events, seminars and spiritual exercises of the “Path of Spiritual Freedom.”', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Eckankar teaches that Soul experiences the Light and Sound of God through the Spiritual Exercises of ECK, including singing HU. The Switzerland site (in German) lists local events, seminars and gatherings and describes the teachings and local contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local events and seminars
Spiritual Exercises of ECK
Singing HU
Group contacts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Switzerland interested in Eckankar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eckankar Sweden
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.se' OR LOWER(`name`) = 'eckankar sweden')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eckankar Sweden', NULL, 'https://www.eckankar.se/', NULL, NULL, 'Сайт Еканкару для Швеції: заходи, семінари й духовні вправи «шляху духовної свободи».', 'The Eckankar site for Sweden: events, seminars and spiritual exercises of the “Path of Spiritual Freedom.”', 'Еканкар навчає, що Душа пізнає Світло й Звук Бога через духовні вправи ECK, зокрема спів HU. Сайт для Швеції (шведською) анонсує місцеві заходи, семінари й зустрічі, розповідає про вчення та контакти місцевих груп.', 'Eckankar teaches that Soul experiences the Light and Sound of God through the Spiritual Exercises of ECK, including singing HU. The Sweden site (in Swedish) lists local events, seminars and gatherings and describes the teachings and local contacts.', 'Місцеві заходи й семінари
Духовні вправи ECK
Спів HU
Контакти груп', 'Local events and seminars
Spiritual Exercises of ECK
Singing HU
Group contacts', 'Жителям Швеції, які цікавляться Еканкаром.', 'People in Sweden interested in Eckankar.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.se' OR LOWER(`name`) = 'eckankar sweden') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Eckankar site for Sweden: events, seminars and spiritual exercises of the “Path of Spiritual Freedom.”', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Eckankar teaches that Soul experiences the Light and Sound of God through the Spiritual Exercises of ECK, including singing HU. The Sweden site (in Swedish) lists local events, seminars and gatherings and describes the teachings and local contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local events and seminars
Spiritual Exercises of ECK
Singing HU
Group contacts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Sweden interested in Eckankar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eckankar Explore
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.org/explore' OR LOWER(`name`) = 'eckankar explore')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eckankar Explore', NULL, 'https://www.eckankar.org/explore/', NULL, NULL, 'Розділ офіційного сайту Еканкару для знайомства з вченням: HU, сни, подорожі душі, курси й подкасти.', 'The introductory section of the official Eckankar site: HU, dreams, Soul Travel, courses and podcasts.', 'Розділ Explore на eckankar.org пояснює основи вчення: що таке Еканкар, спів HU — «Звук Душі», сни, подорожі душі, минулі життя, Світло й Звук. Тут же є безкоштовне завантаження HU, безкоштовна книжка за запитом, курси духовного життя, подкасти, журнал і щоденні натхненні тексти.', 'The Explore section of eckankar.org explains the basics: what Eckankar is, HU — the Sound of Soul — dreams, Soul Travel, past lives, Light and Sound. It also offers a free HU download, a free book on request, spiritual living courses, podcasts, a magazine and daily inspiration.', 'Основи вчення
Безкоштовне завантаження HU
Курси й подкасти
Безкоштовна книжка', 'Basics of the teachings
Free HU download
Courses and podcasts
Free book', 'Тим, хто вперше знайомиться з Еканкаром.', 'Newcomers to Eckankar.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.org/explore' OR LOWER(`name`) = 'eckankar explore') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The introductory section of the official Eckankar site: HU, dreams, Soul Travel, courses and podcasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Explore section of eckankar.org explains the basics: what Eckankar is, HU — the Sound of Soul — dreams, Soul Travel, past lives, Light and Sound. It also offers a free HU download, a free book on request, spiritual living courses, podcasts, a magazine and daily inspiration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Basics of the teachings
Free HU download
Courses and podcasts
Free book', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Newcomers to Eckankar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Ісмаїліти (religion/ismailis) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'religion' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ismailis' LIMIT 1);

-- Aga Khan Development Network
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'the.akdn' OR LOWER(`name`) = 'aga khan development network')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aga Khan Development Network', NULL, 'https://the.akdn/', NULL, NULL, 'Мережа агенцій розвитку, заснована Ага Ханом: освіта, охорона здоров’я, культура й економічний розвиток.', 'A network of development agencies founded by the Aga Khan: education, health, culture and economic development.', 'Aga Khan Development Network (AKDN) об’єднує агенції, які працюють над покращенням якості життя в бідних громадах Азії, Африки та Близького Сходу незалежно від віри. Мережа діє в освіті, охороні здоров’я, культурі, мікрофінансуванні та розвитку територій. Її очолює Ага Хан — імам ісмаїлітів-нізаритів.', 'The Aga Khan Development Network (AKDN) brings together agencies working to improve quality of life in poor communities across Asia, Africa and the Middle East, regardless of faith. It works in education, health, culture, microfinance and area development. It is led by the Aga Khan, Imam of the Nizari Ismailis.', 'Освіта й охорона здоров’я
Культурні програми
Економічний розвиток
Новини проєктів', 'Education and health
Cultural programs
Economic development
Project news', 'Тим, хто цікавиться розвитком громад і роботою інституцій ісмаїлітів.', 'Those interested in community development and Ismaili institutions.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'the.akdn' OR LOWER(`name`) = 'aga khan development network') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A network of development agencies founded by the Aga Khan: education, health, culture and economic development.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Aga Khan Development Network (AKDN) brings together agencies working to improve quality of life in poor communities across Asia, Africa and the Middle East, regardless of faith. It works in education, health, culture, microfinance and area development. It is led by the Aga Khan, Imam of the Nizari Ismailis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Education and health
Cultural programs
Economic development
Project news', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Those interested in community development and Ismaili institutions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aga Khan Foundation
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'the.akdn/en/how-we-work/our-agencies/aga-khan-foundation' OR LOWER(`name`) = 'aga khan foundation')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aga Khan Foundation', NULL, 'https://the.akdn/en/how-we-work/our-agencies/aga-khan-foundation', NULL, NULL, 'Позаконфесійна агенція розвитку AKDN, яка понад 50 років працює над подоланням причин бідності.', 'AKDN’s non-denominational development agency, working on the root causes of poverty for over 50 years.', 'Aga Khan Foundation (AKF) — агенція мережі AKDN, яка понад 50 років підтримує найбідніші громади: розвиток раннього дитинства й освіти, можливості для сільської молоді, участь жінок у місцевому самоврядуванні, сільське господарство й здоров’я. Фонд працює незалежно від віросповідання людей.', 'The Aga Khan Foundation (AKF) is an AKDN agency that has supported the poorest communities for over 50 years: early childhood and education, opportunities for rural youth, women’s participation in local governance, agriculture and health. It serves people regardless of faith.', 'Освіта й раннє дитинство
Молодь і зайнятість
Жінки в місцевому самоврядуванні
Позаконфесійна робота', 'Education and early childhood
Youth and livelihoods
Women in local governance
Non-denominational work', 'Тим, хто цікавиться міжнародним розвитком.', 'Those interested in international development.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'the.akdn/en/how-we-work/our-agencies/aga-khan-foundation' OR LOWER(`name`) = 'aga khan foundation') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AKDN’s non-denominational development agency, working on the root causes of poverty for over 50 years.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Aga Khan Foundation (AKF) is an AKDN agency that has supported the poorest communities for over 50 years: early childhood and education, opportunities for rural youth, women’s participation in local governance, agriculture and health. It serves people regardless of faith.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Education and early childhood
Youth and livelihoods
Women in local governance
Non-denominational work', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Those interested in international development.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aga Khan University
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aku.edu' OR LOWER(`name`) = 'aga khan university')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aga Khan University', NULL, 'https://www.aku.edu/', NULL, NULL, 'Міжнародний університет, заснований Ага Ханом: медицина, освіта, наука й дослідження для країн, що розвиваються.', 'An international university founded by the Aga Khan: medicine, education, sciences and research for the developing world.', 'Aga Khan University має кампуси в Пакистані, Східній Африці та Великій Британії. Університет готує лідерів у медицині, медсестринстві, освіті, мистецтвах і науках, має дослідницькі центри з глобального здоров’я, клімату й медичної освіти. Він прагне поєднувати високу якість навчання з плюралізмом і рішеннями для країн, що розвиваються.', 'The Aga Khan University has campuses in Pakistan, East Africa and the UK. It trains leaders in medicine, nursing, education, arts and sciences and runs research centres on global health, climate and medical education. It aims to combine academic excellence with pluralism and solutions for the developing world.', 'Медицина й медсестринство
Освіта, мистецтва й науки
Дослідницькі центри
Кампуси на трьох континентах', 'Medicine and nursing
Education, arts and sciences
Research centres
Campuses on three continents', 'Абітурієнтам, науковцям і медичним фахівцям.', 'Prospective students, researchers and health professionals.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aku.edu' OR LOWER(`name`) = 'aga khan university') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An international university founded by the Aga Khan: medicine, education, sciences and research for the developing world.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Aga Khan University has campuses in Pakistan, East Africa and the UK. It trains leaders in medicine, nursing, education, arts and sciences and runs research centres on global health, climate and medical education. It aims to combine academic excellence with pluralism and solutions for the developing world.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Medicine and nursing
Education, arts and sciences
Research centres
Campuses on three continents', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Prospective students, researchers and health professionals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aga Khan Museum
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'agakhanmuseum.org' OR LOWER(`name`) = 'aga khan museum')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aga Khan Museum', NULL, 'https://agakhanmuseum.org/', NULL, NULL, 'Музей у Торонто, присвячений мистецтву мусульманських культур і їхнім зв’язкам з іншими культурами.', 'A Toronto museum devoted to the arts of Muslim cultures and their connections with other cultures.', 'Aga Khan Museum, відкритий 2014 року в Торонто, через мистецтво пробуджує цікавість і порозуміння щодо мусульманських культур та їхнього внеску у світову спадщину. Музей має постійну колекцію, тимчасові виставки, концерти й освітні програми.', 'Founded in 2014 in Toronto, the Aga Khan Museum uses the arts to spark curiosity and understanding of Muslim cultures and their contributions to world heritage. It has a permanent collection, temporary exhibitions, concerts and education programs.', 'Постійна колекція
Тимчасові виставки
Концерти й події
Освітні програми', 'Permanent collection
Temporary exhibitions
Concerts and events
Education programs', 'Відвідувачам Торонто й поціновувачам ісламського мистецтва.', 'Visitors to Toronto and lovers of Islamic art.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'agakhanmuseum.org' OR LOWER(`name`) = 'aga khan museum') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Toronto museum devoted to the arts of Muslim cultures and their connections with other cultures.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Founded in 2014 in Toronto, the Aga Khan Museum uses the arts to spark curiosity and understanding of Muslim cultures and their contributions to world heritage. It has a permanent collection, temporary exhibitions, concerts and education programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Permanent collection
Temporary exhibitions
Concerts and events
Education programs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Visitors to Toronto and lovers of Islamic art.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Global Centre for Pluralism
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pluralism.ca' OR LOWER(`name`) = 'global centre for pluralism')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Global Centre for Pluralism', NULL, 'https://www.pluralism.ca/', NULL, NULL, 'Незалежний центр в Оттаві, заснований Ага Ханом і урядом Канади для підтримки плюралізму.', 'An independent Ottawa centre founded by the Aga Khan and the Government of Canada to advance pluralism.', 'Global Centre for Pluralism співпрацює з лідерами, освітянами й політиками по всьому світу, щоб сприяти більш інклюзивним, справедливим і мирним суспільствам. Центр проводить дослідження, освітні програми та присуджує премію за внесок у плюралізм.', 'The Global Centre for Pluralism partners with leaders, educators and policymakers worldwide to foster more inclusive, just and peaceful societies. It conducts research, runs education programs and awards a prize for contributions to pluralism.', 'Дослідження плюралізму
Освітні програми
Премія за плюралізм
Партнерства з лідерами', 'Pluralism research
Education programs
Pluralism prize
Partnerships with leaders', 'Освітянам, дослідникам і політикам.', 'Educators, researchers and policymakers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pluralism.ca' OR LOWER(`name`) = 'global centre for pluralism') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An independent Ottawa centre founded by the Aga Khan and the Government of Canada to advance pluralism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Global Centre for Pluralism partners with leaders, educators and policymakers worldwide to foster more inclusive, just and peaceful societies. It conducts research, runs education programs and awards a prize for contributions to pluralism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pluralism research
Education programs
Pluralism prize
Partnerships with leaders', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Educators, researchers and policymakers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aga Khan Trust for Culture
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'the.akdn/en/how-we-work/our-agencies/aga-khan-trust-culture' OR LOWER(`name`) = 'aga khan trust for culture')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aga Khan Trust for Culture', NULL, 'https://the.akdn/en/how-we-work/our-agencies/aga-khan-trust-culture', NULL, NULL, 'Агенція AKDN, що використовує культуру для розвитку: архітектура, реставрація, музика, історія, освіта.', 'An AKDN agency using culture for development: architecture, restoration, music, history and education.', 'Aga Khan Trust for Culture (AKTC) показує, як культура може бути основою розвитку громад. Вона реставрує історичні міста й пам’ятки, вручає Премію Ага Хана з архітектури, підтримує Музичну програму Ага Хана та музейні ініціативи.', 'The Aga Khan Trust for Culture (AKTC) shows how culture can drive community development. It restores historic cities and monuments, runs the Aga Khan Award for Architecture, supports the Aga Khan Music Programme and museum initiatives.', 'Реставрація історичних міст
Премія Ага Хана з архітектури
Музична програма
Культурна освіта', 'Restoration of historic cities
Aga Khan Award for Architecture
Music Programme
Cultural education', 'Архітекторам, музикантам і всім, хто цікавиться культурною спадщиною.', 'Architects, musicians and anyone interested in cultural heritage.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'the.akdn/en/how-we-work/our-agencies/aga-khan-trust-culture' OR LOWER(`name`) = 'aga khan trust for culture') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AKDN agency using culture for development: architecture, restoration, music, history and education.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Aga Khan Trust for Culture (AKTC) shows how culture can drive community development. It restores historic cities and monuments, runs the Aga Khan Award for Architecture, supports the Aga Khan Music Programme and museum initiatives.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Restoration of historic cities
Aga Khan Award for Architecture
Music Programme
Cultural education', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Architects, musicians and anyone interested in cultural heritage.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- University of Central Asia
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ucentralasia.org' OR LOWER(`name`) = 'university of central asia')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'University of Central Asia', NULL, 'https://ucentralasia.org/', NULL, NULL, 'Університет, заснований Ага Ханом і урядами Таджикистану, Киргизстану й Казахстану для гірських регіонів.', 'A university founded by the Aga Khan and the governments of Tajikistan, Kyrgyzstan and Kazakhstan for mountain regions.', 'University of Central Asia має кампуси в гірських регіонах Центральної Азії. Університет пропонує бакалаврські програми, професійну й безперервну освіту, проводить дослідження в галузі публічної політики, сталого розвитку гірських територій і сучасності Центральної Азії.', 'The University of Central Asia has campuses in the mountain regions of Central Asia. It offers bachelor’s programs, professional and continuing education, and research on public policy, sustainable mountain development and modern Central Asia.', 'Бакалаврські програми
Професійна освіта
Дослідження розвитку гірських регіонів
Кампуси в Центральній Азії', 'Bachelor’s programs
Professional education
Mountain development research
Campuses in Central Asia', 'Студентам і дослідникам Центральної Азії.', 'Students and researchers in Central Asia.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ucentralasia.org' OR LOWER(`name`) = 'university of central asia') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A university founded by the Aga Khan and the governments of Tajikistan, Kyrgyzstan and Kazakhstan for mountain regions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The University of Central Asia has campuses in the mountain regions of Central Asia. It offers bachelor’s programs, professional and continuing education, and research on public policy, sustainable mountain development and modern Central Asia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Bachelor’s programs
Professional education
Mountain development research
Campuses in Central Asia', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students and researchers in Central Asia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Християнська наука (religion/christian-science) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'religion' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'christian-science' LIMIT 1);

-- The Christian Science Monitor
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'csmonitor.com' OR LOWER(`name`) = 'the christian science monitor')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Christian Science Monitor', NULL, 'https://www.csmonitor.com/', NULL, NULL, 'Відзначене нагородами видання, яке з 1908 року публікує Церква Христа-Вченого.', 'An award-winning news outlet published since 1908 by The First Church of Christ, Scientist.', 'The Christian Science Monitor належить Першій Церкві Христа-Вченого, яка відкрито про це повідомляє. Церква видає Monitor, бо вважає якісну журналістику важливою для прогресу. Засновниця Мері Бейкер Едді визначила мету видання «нікому не шкодити, а благословляти все людство». Monitor публікує новини світу, аналітику й щоденну розсилку.', 'The Christian Science Monitor is owned by The First Church of Christ, Scientist, which is open about it. The church publishes the Monitor because it sees good journalism as vital to progress. Founder Mary Baker Eddy set its aim “to injure no man, but to bless all mankind.” The Monitor publishes world news, analysis and a daily newsletter.', 'Міжнародні новини
Аналітичні матеріали
Щоденна розсилка
Видається з 1908 року', 'International news
In-depth analysis
Daily newsletter
Published since 1908', 'Читачам, які шукають виважену журналістику.', 'Readers looking for thoughtful journalism.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'csmonitor.com' OR LOWER(`name`) = 'the christian science monitor') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An award-winning news outlet published since 1908 by The First Church of Christ, Scientist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Christian Science Monitor is owned by The First Church of Christ, Scientist, which is open about it. The church publishes the Monitor because it sees good journalism as vital to progress. Founder Mary Baker Eddy set its aim “to injure no man, but to bless all mankind.” The Monitor publishes world news, analysis and a daily newsletter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'International news
In-depth analysis
Daily newsletter
Published since 1908', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers looking for thoughtful journalism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Herald of Christian Science
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'herald.christianscience.com' OR LOWER(`name`) = 'the herald of christian science')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Herald of Christian Science', NULL, 'https://herald.christianscience.com/', NULL, NULL, 'Багатомовний журнал Християнської науки зі статтями про духовне зцілення й щотижневою розсилкою.', 'A multilingual Christian Science magazine with articles on spiritual healing and a weekly newsletter.', 'The Herald of Christian Science виходить кількома мовами, щоб, за словами видання, «проголошувати універсальну дію й доступність Істини». Тут публікують статті та свідчення про духовне зцілення. На оновлення можна підписатися через email або WhatsApp.', 'The Herald of Christian Science is published in several languages, in its own words “to proclaim the universal activity and availability of Truth.” It publishes articles and testimonies about spiritual healing. Updates are available by email or WhatsApp.', 'Видання кількома мовами
Статті про духовне зцілення
Свідчення читачів
Розсилка email і WhatsApp', 'Published in several languages
Articles on spiritual healing
Reader testimonies
Email and WhatsApp updates', 'Читачам, які цікавляться Християнською наукою.', 'Readers interested in Christian Science.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'herald.christianscience.com' OR LOWER(`name`) = 'the herald of christian science') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A multilingual Christian Science magazine with articles on spiritual healing and a weekly newsletter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Herald of Christian Science is published in several languages, in its own words “to proclaim the universal activity and availability of Truth.” It publishes articles and testimonies about spiritual healing. Updates are available by email or WhatsApp.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Published in several languages
Articles on spiritual healing
Reader testimonies
Email and WhatsApp updates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers interested in Christian Science.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Principia
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'principia.edu' OR LOWER(`name`) = 'principia')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Principia', NULL, 'https://www.principia.edu/', NULL, NULL, 'Навчальний заклад від дошкілля до коледжу, заснований 1898 року на принципах Християнської науки.', 'A preschool-through-college institution founded in 1898 on Christian Science principles.', 'Principia об’єднує школу (від дошкілля до старших класів) у Сент-Луїсі та коледж Principia College в Іллінойсі. Навчання ґрунтується на принципах Християнської науки й розвиває лідерство, комунікацію та творче розв’язання задач.', 'Principia includes a school (preschool through upper school) in St. Louis and Principia College in Illinois. Education is based on Christian Science principles and builds leadership, communication and creative problem-solving.', 'Школа від дошкілля
Principia College
Розвиток лідерства
Спільнота випускників', 'School from preschool
Principia College
Leadership development
Alumni community', 'Родинам і студентам, які шукають освіту на цих принципах.', 'Families and students seeking education on these principles.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'principia.edu' OR LOWER(`name`) = 'principia') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A preschool-through-college institution founded in 1898 on Christian Science principles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Principia includes a school (preschool through upper school) in St. Louis and Principia College in Illinois. Education is based on Christian Science principles and builds leadership, communication and creative problem-solving.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'School from preschool
Principia College
Leadership development
Alumni community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families and students seeking education on these principles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Mother Church (Boston)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'christianscience.com/the-mother-church-in-boston' OR LOWER(`name`) = 'the mother church (boston)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Mother Church (Boston)', NULL, 'https://www.christianscience.com/the-mother-church-in-boston', NULL, NULL, 'Перша Церква Христа-Вченого в Бостоні: служби, відвідування, події та основи вчення.', 'The First Church of Christ, Scientist in Boston: services, visiting, events and key teachings.', 'Сторінка Материнської церкви — Першої Церкви Христа-Вченого в Бостоні — розповідає про служби, відвідування й події, а також про ключові вчення Християнської науки, Мері Бейкер Едді та дві книги, центральні для цієї віри.', 'The page for The Mother Church — The First Church of Christ, Scientist, in Boston — covers services, visiting and events, plus the key teachings of Christian Science, Mary Baker Eddy and the two books central to the faith.', 'Служби й події
Інформація для відвідувачів
Основи вчення
Про Мері Бейкер Едді', 'Services and events
Visitor information
Key teachings
About Mary Baker Eddy', 'Відвідувачам Бостона й тим, хто знайомиться з Християнською наукою.', 'Visitors to Boston and those new to Christian Science.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'christianscience.com/the-mother-church-in-boston' OR LOWER(`name`) = 'the mother church (boston)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The First Church of Christ, Scientist in Boston: services, visiting, events and key teachings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The page for The Mother Church — The First Church of Christ, Scientist, in Boston — covers services, visiting and events, plus the key teachings of Christian Science, Mary Baker Eddy and the two books central to the faith.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Services and events
Visitor information
Key teachings
About Mary Baker Eddy', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Visitors to Boston and those new to Christian Science.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Isha Foundation (Садгуру) (religion/isha-foundation) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'religion' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'isha-foundation' LIMIT 1);

-- Isha Yoga Center
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org/en/center/isha-yoga-center-coimbatore' OR LOWER(`name`) = 'isha yoga center')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Isha Yoga Center', NULL, 'https://isha.sadhguru.org/en/center/isha-yoga-center-coimbatore', NULL, NULL, 'Штаб-квартира Isha Foundation біля підніжжя гір Веллянгірі (Коїмбатур): програми, проживання, відвідування.', 'Isha Foundation’s headquarters at the foothills of the Velliangiri Mountains (Coimbatore): programs, stays and visits.', 'Isha Yoga Center біля Коїмбатура — головний центр Isha Foundation і простір для практик самотрансформації. Сторінка допомагає спланувати візит: бронювання котеджів, контакти, маршрут, програми й заходи, зокрема онлайн-практики з Садгуру.', 'The Isha Yoga Center near Coimbatore is the headquarters of the Isha Foundation and a space for self-transformation practices. The page helps plan a visit: cottage booking, contacts, directions, programs and events, including online practices with Sadhguru.', 'Програми й заходи центру
Бронювання проживання
Маршрут і контакти
Онлайн-практики', 'Centre programs and events
Accommodation booking
Directions and contacts
Online practices', 'Тим, хто планує поїздку до центру Isha.', 'People planning a trip to the Isha centre.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org/en/center/isha-yoga-center-coimbatore' OR LOWER(`name`) = 'isha yoga center') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Isha Foundation’s headquarters at the foothills of the Velliangiri Mountains (Coimbatore): programs, stays and visits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Isha Yoga Center near Coimbatore is the headquarters of the Isha Foundation and a space for self-transformation practices. The page helps plan a visit: cottage booking, contacts, directions, programs and events, including online practices with Sadhguru.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Centre programs and events
Accommodation booking
Directions and contacts
Online practices', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People planning a trip to the Isha centre.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Isha Vidhya
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'consciousplanet.org/en/isha-vidhya' OR LOWER(`name`) = 'isha vidhya')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Isha Vidhya', NULL, 'https://consciousplanet.org/en/isha-vidhya', NULL, NULL, 'Освітня ініціатива Isha для сільських дітей Індії: англомовні школи з сучасними методами навчання.', 'An Isha education initiative for rural children in India: English-medium schools with modern teaching methods.', 'Isha Vidhya прагне підвищити рівень освіти й грамотності в сільській Індії та допомогти дітям з бідних родин розкрити свій потенціал. Проєкт відкриває англомовні школи з інноваційними методами навчання й підтримує державні школи.', 'Isha Vidhya aims to raise education and literacy levels in rural India and help disadvantaged children realize their potential. The project runs English-medium schools with innovative teaching methods and supports government schools.', 'Англомовні сільські школи
Сучасні методи навчання
Підтримка державних шкіл
Можливість допомогти', 'English-medium rural schools
Modern teaching methods
Support for government schools
Ways to donate', 'Тим, хто хоче підтримати освіту в сільській Індії.', 'Those who want to support education in rural India.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'consciousplanet.org/en/isha-vidhya' OR LOWER(`name`) = 'isha vidhya') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An Isha education initiative for rural children in India: English-medium schools with modern teaching methods.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Isha Vidhya aims to raise education and literacy levels in rural India and help disadvantaged children realize their potential. The project runs English-medium schools with innovative teaching methods and supports government schools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'English-medium rural schools
Modern teaching methods
Support for government schools
Ways to donate', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Those who want to support education in rural India.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Self-Realization Fellowship (Йогананда) (religion/self-realization-fellowship) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'religion' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'self-realization-fellowship' LIMIT 1);

-- Self-Realization Magazine
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yogananda.org/self-realization-magazine' OR LOWER(`name`) = 'self-realization magazine')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Self-Realization Magazine', NULL, 'https://yogananda.org/self-realization-magazine', NULL, NULL, 'Журнал Self-Realization Fellowship зі статтями Парамаханси Йогананди та матеріалами про медитацію.', 'The Self-Realization Fellowship magazine with writings of Paramahansa Yogananda and articles on meditation.', 'Self-Realization Magazine, заснований Парамахансою Йоганандою, публікує його бесіди й тексти, статті ченців SRF і матеріали про медитацію та духовне життя. Журнал доступний у друкованому й цифровому форматі на сайті yogananda.org.', 'Self-Realization Magazine, founded by Paramahansa Yogananda, publishes his talks and writings, articles by SRF monastics and material on meditation and spiritual living. It is available in print and digitally on yogananda.org.', 'Тексти Парамаханси Йогананди
Статті ченців SRF
Друкована й цифрова версії
Матеріали про медитацію', 'Writings of Paramahansa Yogananda
Articles by SRF monastics
Print and digital editions
Meditation resources', 'Читачам, які практикують крія-йогу або цікавляться вченням Йогананди.', 'Readers practicing Kriya Yoga or interested in Yogananda’s teachings.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yogananda.org/self-realization-magazine' OR LOWER(`name`) = 'self-realization magazine') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Self-Realization Fellowship magazine with writings of Paramahansa Yogananda and articles on meditation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Self-Realization Magazine, founded by Paramahansa Yogananda, publishes his talks and writings, articles by SRF monastics and material on meditation and spiritual living. It is available in print and digitally on yogananda.org.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Writings of Paramahansa Yogananda
Articles by SRF monastics
Print and digital editions
Meditation resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers practicing Kriya Yoga or interested in Yogananda’s teachings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SRF Lake Shrine
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lakeshrine.org' OR LOWER(`name`) = 'srf lake shrine')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SRF Lake Shrine', NULL, 'https://lakeshrine.org/', NULL, NULL, 'Храм і медитаційні сади Self-Realization Fellowship у Пасифік-Палісейдс (Лос-Анджелес).', 'The Self-Realization Fellowship temple and meditation gardens in Pacific Palisades, Los Angeles.', 'Lake Shrine — храм і відкриті для всіх медитаційні сади SRF у Пасифік-Палісейдс. У храмі проводять недільні медитації й служби, а сади працюють кілька днів на тиждень; для відвідування потрібне безкоштовне бронювання.', 'Lake Shrine is an SRF temple with meditation gardens open to all in Pacific Palisades. The temple holds Sunday meditations and services, and the gardens open several days a week; visits require a free reservation.', 'Медитаційні сади
Недільні служби й медитації
Безкоштовне бронювання візиту
Відкрито для всіх', 'Meditation gardens
Sunday services and meditations
Free visit reservation
Open to all', 'Відвідувачам Лос-Анджелеса, які шукають місце для тиші й медитації.', 'Visitors to Los Angeles seeking a place for quiet and meditation.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lakeshrine.org' OR LOWER(`name`) = 'srf lake shrine') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Self-Realization Fellowship temple and meditation gardens in Pacific Palisades, Los Angeles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lake Shrine is an SRF temple with meditation gardens open to all in Pacific Palisades. The temple holds Sunday meditations and services, and the gardens open several days a week; visits require a free reservation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meditation gardens
Sunday services and meditations
Free visit reservation
Open to all', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Visitors to Los Angeles seeking a place for quiet and meditation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SRF Encinitas Temple
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'encinitastemple.org' OR LOWER(`name`) = 'srf encinitas temple')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SRF Encinitas Temple', NULL, 'https://encinitastemple.org/', NULL, NULL, 'Храм Self-Realization Fellowship в Енсінітасі: лекції, медитації, кіртани й недільна школа.', 'The Self-Realization Fellowship temple in Encinitas: talks, meditations, kirtans and Sunday school.', 'Encinitas Temple — відділення SRF, організації, яку 1920 року заснував Парамаханса Йогананда для поширення вчення крія-йоги. Храм проводить натхненні служби, медитації, читання писань, кіртани (спільний спів), недільну школу та церемонії крія-йоги.', 'The Encinitas Temple is a branch of SRF, the organization founded in 1920 by Paramahansa Yogananda to share the teachings of Kriya Yoga. The temple holds inspirational services, meditations, scripture readings, kirtans (devotional chanting), Sunday school and Kriya Yoga ceremonies.', 'Служби й медитації
Кіртани
Недільна школа
Церемонії крія-йоги', 'Services and meditations
Kirtans
Sunday school
Kriya Yoga ceremonies', 'Жителям Сан-Дієго й відвідувачам Енсінітаса.', 'San Diego residents and visitors to Encinitas.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'encinitastemple.org' OR LOWER(`name`) = 'srf encinitas temple') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Self-Realization Fellowship temple in Encinitas: talks, meditations, kirtans and Sunday school.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Encinitas Temple is a branch of SRF, the organization founded in 1920 by Paramahansa Yogananda to share the teachings of Kriya Yoga. The temple holds inspirational services, meditations, scripture readings, kirtans (devotional chanting), Sunday school and Kriya Yoga ceremonies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Services and meditations
Kirtans
Sunday school
Kriya Yoga ceremonies', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'San Diego residents and visitors to Encinitas.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SRF Hollywood Temple
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hollywoodtemple.org' OR LOWER(`name`) = 'srf hollywood temple')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SRF Hollywood Temple', NULL, 'https://www.hollywoodtemple.org/', NULL, NULL, 'Храм Self-Realization Fellowship у Голлівуді, відкритий Парамахансою Йоганандою 1942 року.', 'The Self-Realization Fellowship temple in Hollywood, opened by Paramahansa Yogananda in 1942.', 'Hollywood Temple — відділення SRF, яке Парамаханса Йогананда відкрив і освятив 1942 року. Храм проводить медитації й натхненні служби, має книжкову крамницю, де можна попросити про екскурсію територією.', 'The Hollywood Temple is an SRF branch opened and dedicated by Paramahansa Yogananda in 1942. It holds meditations and inspirational services and has a bookroom where visitors can ask for a tour of the grounds.', 'Медитації та служби
Історичний храм 1942 року
Книжкова крамниця
Екскурсії', 'Meditations and services
Historic 1942 temple
Bookroom
Tours', 'Відвідувачам Лос-Анджелеса й послідовникам Йогананди.', 'Visitors to Los Angeles and followers of Yogananda.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hollywoodtemple.org' OR LOWER(`name`) = 'srf hollywood temple') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Self-Realization Fellowship temple in Hollywood, opened by Paramahansa Yogananda in 1942.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Hollywood Temple is an SRF branch opened and dedicated by Paramahansa Yogananda in 1942. It holds meditations and inspirational services and has a bookroom where visitors can ask for a tour of the grounds.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meditations and services
Historic 1942 temple
Bookroom
Tours', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Visitors to Los Angeles and followers of Yogananda.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Мистецтво життя (Art of Living) (religion/art-of-living) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'religion' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'art-of-living' LIMIT 1);

-- IAHV
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iahv.org' OR LOWER(`name`) = 'iahv')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'IAHV', NULL, 'https://www.iahv.org/', NULL, NULL, 'Міжнародна асоціація людських цінностей, заснована Шрі Шрі Раві Шанкаром: гуманітарні й освітні програми.', 'The International Association for Human Values, founded by Sri Sri Ravi Shankar: humanitarian and education programs.', 'International Association for Human Values (IAHV) пропонує досліджені програми, що працюють з першопричинами суспільних проблем: травма й стрес, конфлікти, молодь, гуманітарна дипломатія. Організація має глобальну мережу тренерів і збирала допомогу для українських біженців.', 'The International Association for Human Values (IAHV) offers researched programs addressing root causes of social problems: trauma and stress, conflict, youth, humanitarian diplomacy. It has a global trainer network and raised relief for Ukrainian refugees.', 'Програми подолання стресу й травми
Гуманітарна дипломатія
Молодіжні ініціативи
Глобальна мережа тренерів', 'Stress and trauma programs
Humanitarian diplomacy
Youth initiatives
Global trainer network', 'Організаціям і людям, які працюють із громадами й кризами.', 'Organizations and people working with communities and crises.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iahv.org' OR LOWER(`name`) = 'iahv') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The International Association for Human Values, founded by Sri Sri Ravi Shankar: humanitarian and education programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The International Association for Human Values (IAHV) offers researched programs addressing root causes of social problems: trauma and stress, conflict, youth, humanitarian diplomacy. It has a global trainer network and raised relief for Ukrainian refugees.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stress and trauma programs
Humanitarian diplomacy
Youth initiatives
Global trainer network', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Organizations and people working with communities and crises.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sri Sri University
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'srisriuniversity.edu.in' OR LOWER(`name`) = 'sri sri university')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sri Sri University', NULL, 'https://srisriuniversity.edu.in/', NULL, NULL, 'Університет у Бхубанешварі, створений за задумом Шрі Шрі Раві Шанкара: «найкраще зі Сходу й Заходу».', 'A university in Bhubaneswar envisioned by Sri Sri Ravi Shankar: “the best of East and West.”', 'Sri Sri University в Бхубанешварі (Індія) поєднує сучасні програми з традиційними знаннями: інформатика й кібербезпека, психологія (контемплятивні студії), харчування, дизайн, виконавські мистецтва (одіссі, гіндустанський вокал) та інші напрями.', 'Sri Sri University in Bhubaneswar, India, combines modern programs with traditional knowledge: computer science and cybersecurity, psychology (contemplative studies), nutrition, design, performing arts (Odissi, Hindustani vocal) and more.', 'Інформатика й кібербезпека
Психологія й контемплятивні студії
Виконавські мистецтва
Студентські клуби', 'Computer science and cybersecurity
Psychology and contemplative studies
Performing arts
Student clubs', 'Абітурієнтам в Індії та іноземним студентам.', 'Prospective students in India and abroad.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'srisriuniversity.edu.in' OR LOWER(`name`) = 'sri sri university') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A university in Bhubaneswar envisioned by Sri Sri Ravi Shankar: “the best of East and West.”', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sri Sri University in Bhubaneswar, India, combines modern programs with traditional knowledge: computer science and cybersecurity, psychology (contemplative studies), nutrition, design, performing arts (Odissi, Hindustani vocal) and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Computer science and cybersecurity
Psychology and contemplative studies
Performing arts
Student clubs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Prospective students in India and abroad.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sri Sri Tattva
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'srisritattva.com' OR LOWER(`name`) = 'sri sri tattva')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sri Sri Tattva', NULL, 'https://www.srisritattva.com/', NULL, NULL, 'Бренд аюрведичних товарів, пов’язаний з Art of Living: продукти, догляд, пахощі.', 'An Ayurvedic products brand linked to the Art of Living: groceries, personal care, incense.', 'Sri Sri Tattva продає аюрведичні засоби, продукти харчування, засоби догляду, топлене масло, трав’яні соки й пахощі. Частина виручки з кожної покупки йде на проєкт Gift A Smile під егідою Art of Living (Ved Vignan Mahavidyapeeth Trust), який підтримує безкоштовну освіту дітей.', 'Sri Sri Tattva sells Ayurvedic products, groceries, personal care, ghee, herbal juices and incense. Part of every purchase supports the Gift A Smile project under the Art of Living (Ved Vignan Mahavidyapeeth Trust), which funds free education for children.', 'Аюрведичні засоби
Продукти й догляд
Пахощі
Підтримка проєкту Gift A Smile', 'Ayurvedic products
Food and personal care
Incense
Supports Gift A Smile', 'Покупцям в Індії, які цікавляться аюрведою.', 'Shoppers in India interested in Ayurveda.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'srisritattva.com' OR LOWER(`name`) = 'sri sri tattva') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An Ayurvedic products brand linked to the Art of Living: groceries, personal care, incense.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sri Sri Tattva sells Ayurvedic products, groceries, personal care, ghee, herbal juices and incense. Part of every purchase supports the Gift A Smile project under the Art of Living (Ved Vignan Mahavidyapeeth Trust), which funds free education for children.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ayurvedic products
Food and personal care
Incense
Supports Gift A Smile', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shoppers in India interested in Ayurveda.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sri Sri School of Yoga
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'srisrischoolofyoga.org' OR LOWER(`name`) = 'sri sri school of yoga')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sri Sri School of Yoga', NULL, 'https://www.srisrischoolofyoga.org/', NULL, NULL, 'Школа йоги Art of Living у Європі: глибоке навчання йозі в традиційній лінії, а не «швидкі рішення».', 'The Art of Living yoga school in Europe: in-depth yoga training within a traditional lineage, not quick fixes.', 'Sri Sri School of Yoga пропонує курси й навчання викладачів йоги в Європі, які спираються на традиційну лінію передачі знань. Школа наголошує на розумінні механізмів йоги й довгостроковій практиці замість модних тренувань.', 'Sri Sri School of Yoga offers yoga courses and teacher training in Europe grounded in a traditional lineage. The school emphasizes understanding how yoga works and long-term practice rather than trendy workouts.', 'Курси йоги
Навчання викладачів
Традиційна лінія
Заняття в Європі', 'Yoga courses
Teacher training
Traditional lineage
Classes in Europe', 'Практикам і майбутнім викладачам йоги в Європі.', 'Practitioners and aspiring yoga teachers in Europe.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'srisrischoolofyoga.org' OR LOWER(`name`) = 'sri sri school of yoga') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Art of Living yoga school in Europe: in-depth yoga training within a traditional lineage, not quick fixes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sri Sri School of Yoga offers yoga courses and teacher training in Europe grounded in a traditional lineage. The school emphasizes understanding how yoga works and long-term practice rather than trendy workouts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Yoga courses
Teacher training
Traditional lineage
Classes in Europe', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Practitioners and aspiring yoga teachers in Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Art of Living USA
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'artofliving.org/us-en' OR LOWER(`name`) = 'art of living usa')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Art of Living USA', NULL, 'https://www.artofliving.org/us-en', NULL, NULL, 'Американський сайт Art of Living: курс Part 1, медитація, дихальні практики й оздоровчі програми.', 'The US Art of Living site: Part 1 course, meditation, breathwork and wellness programs.', 'Сайт Art of Living для США пропонує програми медитації, дихальних практик і йоги, зокрема курс Art of Living Part 1 із технікою SKY. Організацію заснував Гурудев Шрі Шрі Раві Шанкар. На сайті можна знайти заняття онлайн і в місцевих центрах.', 'The US Art of Living site offers meditation, breathwork and yoga programs, including the Art of Living Part 1 course with the SKY technique. The organization was founded by Gurudev Sri Sri Ravi Shankar. You can find online and local-centre classes on the site.', 'Курс Art of Living Part 1
Дихальна техніка SKY
Медитація й йога
Онлайн і місцеві центри', 'Art of Living Part 1 course
SKY breathing technique
Meditation and yoga
Online and local centres', 'Жителям США, які шукають курси медитації й дихання.', 'People in the US looking for meditation and breathwork courses.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'artofliving.org/us-en' OR LOWER(`name`) = 'art of living usa') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The US Art of Living site: Part 1 course, meditation, breathwork and wellness programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The US Art of Living site offers meditation, breathwork and yoga programs, including the Art of Living Part 1 course with the SKY technique. The organization was founded by Gurudev Sri Sri Ravi Shankar. You can find online and local-centre classes on the site.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Art of Living Part 1 course
SKY breathing technique
Meditation and yoga
Online and local centres', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in the US looking for meditation and breathwork courses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sudarshan Kriya (SKY)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'artofliving.org/sudarshan-kriya' OR LOWER(`name`) = 'sudarshan kriya (sky)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sudarshan Kriya (SKY)', NULL, 'https://www.artofliving.org/sudarshan-kriya', NULL, NULL, 'Сторінка Art of Living про дихальну техніку Сударшан-крія та дослідження її впливу на самопочуття.', 'The Art of Living page on the Sudarshan Kriya breathing technique and research on its effects on well-being.', 'Сударшан-крія (SKY) — ритмічна дихальна техніка, якої навчають на курсах Art of Living. Сторінка зводить дослідження з чотирьох континентів, опубліковані в рецензованих журналах, про вплив практики на стрес, сон і якість життя, та пояснює, де їй навчитися.', 'Sudarshan Kriya (SKY) is a rhythmic breathing technique taught on Art of Living courses. The page summarizes peer-reviewed research from four continents on its effects on stress, sleep and quality of life and explains where to learn it.', 'Опис техніки SKY
Огляд досліджень
Рецензовані публікації
Де навчитися', 'SKY technique overview
Research summary
Peer-reviewed studies
Where to learn', 'Тим, хто хоче дізнатися про дихальні практики Art of Living.', 'People curious about Art of Living breathing practices.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'artofliving.org/sudarshan-kriya' OR LOWER(`name`) = 'sudarshan kriya (sky)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Art of Living page on the Sudarshan Kriya breathing technique and research on its effects on well-being.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sudarshan Kriya (SKY) is a rhythmic breathing technique taught on Art of Living courses. The page summarizes peer-reviewed research from four continents on its effects on stress, sleep and quality of life and explains where to learn it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'SKY technique overview
Research summary
Peer-reviewed studies
Where to learn', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People curious about Art of Living breathing practices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Перефразування і граматика (text-chatbots/paraphrasing-grammar) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'text-chatbots' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'paraphrasing-grammar' LIMIT 1);

-- DeepL Write
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'deepl.com/write' OR LOWER(`name`) = 'deepl write')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DeepL Write', NULL, 'https://www.deepl.com/write', NULL, NULL, 'AI-помічник DeepL для письма: виправляє помилки, покращує стиль і пропонує альтернативні формулювання.', 'DeepL’s AI writing companion: fixes errors, improves style and suggests alternative phrasing.', 'DeepL Write допомагає писати чітко й точно: виправляє граматику, пунктуацію та орфографію, перефразовує речення й пропонує кращі слова з урахуванням контексту. Можна обрати тон і стиль тексту. Інструмент від творців перекладача DeepL доступний безкоштовно, з розширеними можливостями в DeepL Pro.', 'DeepL Write helps you write clearly and precisely: it fixes grammar, punctuation and spelling, rephrases sentences and suggests better words in context. You can pick the tone and style. From the makers of the DeepL translator, it is free to use, with extended features in DeepL Pro.', 'Виправлення граматики й орфографії
Перефразування речень
Вибір тону й стилю
Безкоштовна версія', 'Grammar and spelling fixes
Sentence rephrasing
Tone and style choice
Free version', 'Усім, хто пише англійською, німецькою та іншими мовами.', 'Anyone writing in English, German and other languages.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'deepl.com/write' OR LOWER(`name`) = 'deepl write') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'DeepL’s AI writing companion: fixes errors, improves style and suggests alternative phrasing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DeepL Write helps you write clearly and precisely: it fixes grammar, punctuation and spelling, rephrases sentences and suggests better words in context. You can pick the tone and style. From the makers of the DeepL translator, it is free to use, with extended features in DeepL Pro.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Grammar and spelling fixes
Sentence rephrasing
Tone and style choice
Free version', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone writing in English, German and other languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ginger
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gingersoftware.com' OR LOWER(`name`) = 'ginger')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ginger', NULL, 'https://www.gingersoftware.com/', NULL, NULL, 'AI-помічник для англійського письма: контекстні виправлення, покращення стилю, перефразування.', 'An AI assistant for English writing: context-based corrections, style improvement and rephrasing.', 'Ginger аналізує речення цілком і пропонує виправлення з урахуванням контексту, а не лише орфографії й граматики. Також допомагає перефразувати текст і покращити стиль. Працює як розширення браузера, програма для комп’ютера та мобільна клавіатура. Є безкоштовна версія.', 'Ginger looks at whole sentences and suggests context-based corrections beyond spelling and grammar. It also helps rephrase text and improve style. It works as a browser extension, desktop app and mobile keyboard. A free version is available.', 'Контекстні виправлення
Перефразування
Розширення й мобільна клавіатура
Безкоштовна версія', 'Context-based corrections
Rephrasing
Extension and mobile keyboard
Free version', 'Тим, хто пише англійською як іноземною.', 'People writing in English as a second language.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gingersoftware.com' OR LOWER(`name`) = 'ginger') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI assistant for English writing: context-based corrections, style improvement and rephrasing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ginger looks at whole sentences and suggests context-based corrections beyond spelling and grammar. It also helps rephrase text and improve style. It works as a browser extension, desktop app and mobile keyboard. A free version is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Context-based corrections
Rephrasing
Extension and mobile keyboard
Free version', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People writing in English as a second language.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Paperpal
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'paperpal.com' OR LOWER(`name`) = 'paperpal')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Paperpal', NULL, 'https://paperpal.com/', NULL, NULL, 'AI для академічного письма: граматика, перефразування, перевірка плагіату й цитат на базі 250 млн статей.', 'AI for academic writing: grammar, paraphrasing, plagiarism and citation checks grounded in 250M papers.', 'Paperpal допомагає дослідникам і студентам від джерел до готової до подання статті: перевіряє граматику, пропонує перефразування за академічними нормами, перевіряє плагіат і цитування. Можна завантажити PDF і посилання, ставити запитання й отримувати відповіді з цитатами з понад 250 мільйонів наукових статей. Є безкоштовний тариф.', 'Paperpal helps researchers and students go from sources to a submission-ready paper: it checks grammar, suggests academically appropriate paraphrasing, and checks plagiarism and citations. You can upload PDFs and references, ask questions and get cited answers from 250M+ research articles. A free plan is available.', 'Академічна граматика й стиль
Перефразування
Перевірка плагіату й цитат
Відповіді з цитатами з 250 млн статей', 'Academic grammar and style
Paraphrasing
Plagiarism and citation checks
Cited answers from 250M papers', 'Науковцям, аспірантам і студентам.', 'Researchers, PhD candidates and students.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'paperpal.com' OR LOWER(`name`) = 'paperpal') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI for academic writing: grammar, paraphrasing, plagiarism and citation checks grounded in 250M papers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Paperpal helps researchers and students go from sources to a submission-ready paper: it checks grammar, suggests academically appropriate paraphrasing, and checks plagiarism and citations. You can upload PDFs and references, ask questions and get cited answers from 250M+ research articles. A free plan is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Academic grammar and style
Paraphrasing
Plagiarism and citation checks
Cited answers from 250M papers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Researchers, PhD candidates and students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Trinka
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trinka.ai' OR LOWER(`name`) = 'trinka')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Trinka', NULL, 'https://www.trinka.ai/', NULL, NULL, 'AI-перевірка граматики й редагування для академічних і професійних текстів з акцентом на приватність.', 'AI grammar checking and editing for academic and professional writing with a privacy focus.', 'Trinka редагує й вичитує тексти, щоб вони були ясними, стислими й переконливими, з урахуванням академічного та технічного стилю. Для конфіденційних документів є режим, орієнтований на приватність. Компанія також пропонує університетам рішення для академічної доброчесності в епоху AI. Почати можна безкоштовно.', 'Trinka edits and proofreads text to make it clear, concise and impactful, with academic and technical style in mind. A privacy-first mode suits sensitive documents. The company also offers universities academic-integrity solutions for the AI era. Free to start.', 'Академічна й технічна граматика
Режим приватності
Редагування й вичитка
Безкоштовний старт', 'Academic and technical grammar
Privacy mode
Editing and proofreading
Free start', 'Науковцям, студентам і технічним авторам.', 'Researchers, students and technical writers.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trinka.ai' OR LOWER(`name`) = 'trinka') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI grammar checking and editing for academic and professional writing with a privacy focus.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Trinka edits and proofreads text to make it clear, concise and impactful, with academic and technical style in mind. A privacy-first mode suits sensitive documents. The company also offers universities academic-integrity solutions for the AI era. Free to start.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Academic and technical grammar
Privacy mode
Editing and proofreading
Free start', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Researchers, students and technical writers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Scribbr Paraphrasing Tool
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scribbr.com/paraphrasing-tool' OR LOWER(`name`) = 'scribbr paraphrasing tool')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Scribbr Paraphrasing Tool', NULL, 'https://www.scribbr.com/paraphrasing-tool/', NULL, NULL, 'Безкоштовний AI-перефразувальник Scribbr без реєстрації для речень і абзаців.', 'Scribbr’s free AI paraphrasing tool for sentences and paragraphs, no sign-up required.', 'Scribbr Paraphrasing Tool (на основі QuillBot) переформульовує речення й абзаци, допомагаючи студентам і авторам висловити думку своїми словами. На тому ж сайті є перевірка плагіату, детектор AI-тексту, генератор цитат, перевірка граматики та сумаризатор. Базове перефразування безкоштовне й без реєстрації.', 'The Scribbr Paraphrasing Tool (powered by QuillBot) rephrases sentences and paragraphs, helping students and writers express ideas in their own words. The same site offers a plagiarism checker, AI detector, citation generator, grammar checker and summarizer. Basic paraphrasing is free with no sign-up.', 'Перефразування без реєстрації
Кілька режимів
Перевірка плагіату й цитати поруч
Безкоштовно', 'Paraphrasing without sign-up
Several modes
Plagiarism and citation tools alongside
Free', 'Студентам і авторам академічних текстів.', 'Students and academic writers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scribbr.com/paraphrasing-tool' OR LOWER(`name`) = 'scribbr paraphrasing tool') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Scribbr’s free AI paraphrasing tool for sentences and paragraphs, no sign-up required.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Scribbr Paraphrasing Tool (powered by QuillBot) rephrases sentences and paragraphs, helping students and writers express ideas in their own words. The same site offers a plagiarism checker, AI detector, citation generator, grammar checker and summarizer. Basic paraphrasing is free with no sign-up.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Paraphrasing without sign-up
Several modes
Plagiarism and citation tools alongside
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students and academic writers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Генератори промптів (text-chatbots/prompt-generators) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'text-chatbots' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'prompt-generators' LIMIT 1);

-- PromptPerfect
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'promptperfect.jina.ai' OR LOWER(`name`) = 'promptperfect')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PromptPerfect', NULL, 'https://promptperfect.jina.ai/', NULL, NULL, 'Генератор і оптимізатор промптів для мовних і графічних моделей, з чат-асистентом.', 'A prompt generator and optimizer for language and image models, with a chat assistant.', 'PromptPerfect перетворює ідею на точний промпт і оптимізує наявні промпти за секунди для моделей на кшталт GPT, Claude чи Midjourney. Вбудований чат-асистент допомагає одразу використати промпт для створення контенту й розв’язання завдань.', 'PromptPerfect turns an idea into a precise prompt and optimizes existing prompts in seconds for models such as GPT, Claude or Midjourney. A built-in chat assistant helps put the prompt straight to work creating content and solving tasks.', 'Генерація промптів з ідеї
Оптимізація наявних промптів
Для текстових і графічних моделей
Чат-асистент', 'Prompt generation from an idea
Optimization of existing prompts
For text and image models
Chat assistant', 'Користувачам генеративного AI, маркетологам і авторам.', 'Generative AI users, marketers and creators.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'promptperfect.jina.ai' OR LOWER(`name`) = 'promptperfect') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A prompt generator and optimizer for language and image models, with a chat assistant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PromptPerfect turns an idea into a precise prompt and optimizes existing prompts in seconds for models such as GPT, Claude or Midjourney. A built-in chat assistant helps put the prompt straight to work creating content and solving tasks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Prompt generation from an idea
Optimization of existing prompts
For text and image models
Chat assistant', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Generative AI users, marketers and creators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Promptitude
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'promptitude.io' OR LOWER(`name`) = 'promptitude')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Promptitude', NULL, 'https://www.promptitude.io/', NULL, NULL, 'Платформа для організації промптів, створення AI-асистентів і no-code автоматизацій.', 'A platform for organizing prompts, building AI assistants and no-code automations.', 'Promptitude дає змогу зберігати, редагувати й оптимізувати всі промпти в одному місці, створювати власних AI-асистентів і автоматизувати процеси без коду. Промпти можна вбудовувати у свої застосунки через API. Новим користувачам надають безкоштовні токени, є безкоштовний посібник із промпт-інженерії.', 'Promptitude lets you store, edit and optimize all your prompts in one place, build custom AI assistants and automate workflows without code. Prompts can be embedded in your own apps via API. New users get free tokens, and there is a free prompt-engineering guide.', 'Бібліотека промптів
Власні AI-асистенти
No-code автоматизація
API для інтеграції', 'Prompt library
Custom AI assistants
No-code automation
API integration', 'Командам і розробникам, які масштабують роботу з промптами.', 'Teams and developers scaling their prompt work.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'promptitude.io' OR LOWER(`name`) = 'promptitude') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform for organizing prompts, building AI assistants and no-code automations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Promptitude lets you store, edit and optimize all your prompts in one place, build custom AI assistants and automate workflows without code. Prompts can be embedded in your own apps via API. New users get free tokens, and there is a free prompt-engineering guide.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Prompt library
Custom AI assistants
No-code automation
API integration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams and developers scaling their prompt work.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Snack Prompt
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'snackprompt.com' OR LOWER(`name`) = 'snack prompt')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Snack Prompt', NULL, 'https://snackprompt.com/', NULL, NULL, 'Маркетплейс і спільнота промптів, зображень, агентів і автоматизацій для AI.', 'A marketplace and community for AI prompts, images, agents and automations.', 'Snack Prompt — місце, де можна знаходити, ділитися й змінювати під себе промпти, зображення та автоматизації від спільноти. Бібліотека охоплює AI-агентів, фреймворки й готові ланцюжки промптів для різних моделей і завдань.', 'Snack Prompt is a place to discover, share and remix prompts, images and automations from the community. The library covers AI agents, frameworks and ready prompt chains for various models and tasks.', 'Бібліотека промптів спільноти
Агенти й автоматизації
Ремікс і публікація промптів
Для різних моделей', 'Community prompt library
Agents and automations
Remix and publish prompts
For various models', 'Промпт-інженерам і творцям AI-рішень.', 'Prompt engineers and AI builders.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'snackprompt.com' OR LOWER(`name`) = 'snack prompt') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A marketplace and community for AI prompts, images, agents and automations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Snack Prompt is a place to discover, share and remix prompts, images and automations from the community. The library covers AI agents, frameworks and ready prompt chains for various models and tasks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Community prompt library
Agents and automations
Remix and publish prompts
For various models', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Prompt engineers and AI builders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PromptHero
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prompthero.com' OR LOWER(`name`) = 'prompthero')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PromptHero', NULL, 'https://prompthero.com/', NULL, NULL, 'Пошук серед мільйонів промптів для генерації зображень і відео: Midjourney, Stable Diffusion, Sora та інші.', 'Search millions of prompts for image and video generation: Midjourney, Stable Diffusion, Sora and more.', 'PromptHero збирає промпти для генеративних моделей разом із результатами, тож видно, яке зображення чи відео дає конкретний запит. Можна шукати за ключовими словами й моделлю, черпати натхнення з добірок спільноти та копіювати промпти. Почати можна безкоштовно.', 'PromptHero collects prompts for generative models together with their results, so you can see what image or video a given prompt produces. Search by keyword and model, get inspiration from community picks and copy prompts. Free to start.', 'Мільйони промптів із результатами
Пошук за моделлю
Добірки спільноти
Безкоштовний старт', 'Millions of prompts with results
Search by model
Community picks
Free start', 'Художникам, дизайнерам і творцям відео з AI.', 'Artists, designers and AI video creators.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prompthero.com' OR LOWER(`name`) = 'prompthero') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Search millions of prompts for image and video generation: Midjourney, Stable Diffusion, Sora and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PromptHero collects prompts for generative models together with their results, so you can see what image or video a given prompt produces. Search by keyword and model, get inspiration from community picks and copy prompts. Free to start.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Millions of prompts with results
Search by model
Community picks
Free start', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Artists, designers and AI video creators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- prompts.chat
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prompts.chat' OR LOWER(`name`) = 'prompts.chat')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'prompts.chat', NULL, 'https://prompts.chat/', NULL, NULL, 'Безкоштовна бібліотека промптів із відкритим кодом для ChatGPT, Claude, Gemini та інших моделей.', 'A free, open-source prompt library for ChatGPT, Claude, Gemini and other models.', 'prompts.chat виріс із популярного репозиторію awesome-chatgpt-prompts. Тут можна знаходити, збирати й публікувати промпти спільноти для різних моделей. Проєкт повністю безкоштовний і має відкритий код, тож його можна розгорнути на власному сервері.', 'prompts.chat grew out of the popular awesome-chatgpt-prompts repository. You can discover, collect and share community prompts for various models. The project is completely free and open source, so it can be self-hosted.', 'Бібліотека промптів спільноти
Для ChatGPT, Claude, Gemini
Відкритий код
Можливість власного розгортання', 'Community prompt library
For ChatGPT, Claude, Gemini
Open source
Self-hosting option', 'Усім користувачам чат-ботів.', 'All chatbot users.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prompts.chat' OR LOWER(`name`) = 'prompts.chat') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free, open-source prompt library for ChatGPT, Claude, Gemini and other models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'prompts.chat grew out of the popular awesome-chatgpt-prompts repository. You can discover, collect and share community prompts for various models. The project is completely free and open source, so it can be self-hosted.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Community prompt library
For ChatGPT, Claude, Gemini
Open source
Self-hosting option', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'All chatbot users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Prompt Engineering Guide
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'promptingguide.ai' OR LOWER(`name`) = 'prompt engineering guide')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Prompt Engineering Guide', NULL, 'https://www.promptingguide.ai/', NULL, NULL, 'Безкоштовний посібник із промпт-інженерії: техніки, приклади й дослідження роботи з мовними моделями.', 'A free prompt-engineering guide: techniques, examples and research on working with language models.', 'Prompt Engineering Guide пояснює, як створювати й оптимізувати промпти для мовних моделей: від базових принципів до технік на кшталт ланцюжка міркувань, RAG і агентів. Посібник спирається на дослідження й містить приклади, корисні і практикам, і дослідникам.', 'The Prompt Engineering Guide explains how to design and optimize prompts for language models, from basics to techniques such as chain-of-thought, RAG and agents. It draws on research and includes examples useful to practitioners and researchers alike.', 'Основи промпт-інженерії
Техніки міркувань, RAG, агенти
Приклади
Безкоштовно', 'Prompt-engineering basics
Reasoning, RAG and agent techniques
Examples
Free', 'Розробникам і всім, хто вчиться працювати з LLM.', 'Developers and anyone learning to work with LLMs.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'promptingguide.ai' OR LOWER(`name`) = 'prompt engineering guide') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free prompt-engineering guide: techniques, examples and research on working with language models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Prompt Engineering Guide explains how to design and optimize prompts for language models, from basics to techniques such as chain-of-thought, RAG and agents. It draws on research and includes examples useful to practitioners and researchers alike.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Prompt-engineering basics
Reasoning, RAG and agent techniques
Examples
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and anyone learning to work with LLMs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== AI-компаньйони (text-chatbots/ai-companions) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'text-chatbots' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ai-companions' LIMIT 1);

-- Pi
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pi.ai' OR LOWER(`name`) = 'pi')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pi', NULL, 'https://pi.ai/', NULL, NULL, 'Персональний AI від Inflection, щоб обміркувати щось, отримати підтримку чи просто поговорити.', 'Inflection’s personal AI for thinking things through, getting encouragement or just talking.', 'Pi створений як доброзичливий співрозмовник: допомагає обміркувати складну розмову, спланувати день, вибрати подарунок або просто поспілкуватися. Розмовляти можна в браузері та мобільних застосунках, зокрема голосом. Користування безкоштовне. Відповіді генерує AI, тож він не замінює живого спілкування чи фахової допомоги.', 'Pi is designed as a friendly conversation partner: it helps think through a tough conversation, keep your day on track, pick a gift or just chat. You can talk in the browser and mobile apps, including by voice. It is free to use. Responses are AI-generated, so it does not replace human connection or professional help.', 'Доброзичливі розмови
Підтримка в повсякденних справах
Голосовий режим
Безкоштовно', 'Friendly conversations
Everyday support
Voice mode
Free', 'Дорослим, які хочуть поговорити з AI-співрозмовником.', 'Adults who want an AI conversation partner.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pi.ai' OR LOWER(`name`) = 'pi') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Inflection’s personal AI for thinking things through, getting encouragement or just talking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Pi is designed as a friendly conversation partner: it helps think through a tough conversation, keep your day on track, pick a gift or just chat. You can talk in the browser and mobile apps, including by voice. It is free to use. Responses are AI-generated, so it does not replace human connection or professional help.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Friendly conversations
Everyday support
Voice mode
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults who want an AI conversation partner.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kindroid
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kindroid.ai' OR LOWER(`name`) = 'kindroid')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kindroid', NULL, 'https://kindroid.ai/', NULL, NULL, 'AI-компаньйон, який слухає, пам’ятає розмови й «росте» разом із вами; з голосом, аватаром і груповими чатами.', 'An AI companion that listens, remembers and grows with you, with voice, an avatar and group chats.', 'Kindroid дає змогу створити власного AI-друга з характером, голосом і зовнішністю. Компаньйон пам’ятає попередні розмови, а його можна додати до групового чату. Сервіс призначений для дорослих. Відповіді генерує AI, тож він не замінює живого спілкування чи фахової допомоги.', 'Kindroid lets you create your own AI friend with a personality, voice and appearance. The companion remembers previous conversations and can join group chats. The service is for adults. Responses are AI-generated, so it does not replace human connection or professional help.', 'Власний AI-друг
Пам’ять розмов
Голос і аватар
Групові чати', 'Your own AI friend
Conversation memory
Voice and avatar
Group chats', 'Дорослим користувачам AI-компаньйонів.', 'Adult users of AI companions.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kindroid.ai' OR LOWER(`name`) = 'kindroid') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI companion that listens, remembers and grows with you, with voice, an avatar and group chats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kindroid lets you create your own AI friend with a personality, voice and appearance. The companion remembers previous conversations and can join group chats. The service is for adults. Responses are AI-generated, so it does not replace human connection or professional help.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Your own AI friend
Conversation memory
Voice and avatar
Group chats', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adult users of AI companions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nomi
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nomi.ai' OR LOWER(`name`) = 'nomi')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nomi', NULL, 'https://nomi.ai/', NULL, NULL, 'AI-компаньйон з людиноподібною пам’яттю: друг, наставник чи партнер для розмов, з голосовими дзвінками.', 'An AI companion with humanlike memory — friend, mentor or partner — with voice calls.', 'Nomi пропонує стосунки з AI-персонажем, який пам’ятає розмови й розвивається з часом: як друг, наставник чи романтичний партнер. Підтримуються голосові повідомлення й дзвінки, групові чати та створення зображень. Почати можна безкоштовно, сервіс розрахований на дорослих. Відповіді генерує AI, тож він не замінює живого спілкування чи фахової допомоги.', 'Nomi offers a relationship with an AI character that remembers conversations and evolves over time — as a friend, mentor or romantic partner. It supports voice messages and calls, group chats and image creation. Free to start; the service is for adults. Responses are AI-generated, so it does not replace human connection or professional help.', 'Довготривала пам’ять
Голосові дзвінки
Групові чати
Безкоштовний старт', 'Long-term memory
Voice calls
Group chats
Free start', 'Дорослим користувачам AI-компаньйонів.', 'Adult users of AI companions.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nomi.ai' OR LOWER(`name`) = 'nomi') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI companion with humanlike memory — friend, mentor or partner — with voice calls.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Nomi offers a relationship with an AI character that remembers conversations and evolves over time — as a friend, mentor or romantic partner. It supports voice messages and calls, group chats and image creation. Free to start; the service is for adults. Responses are AI-generated, so it does not replace human connection or professional help.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Long-term memory
Voice calls
Group chats
Free start', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adult users of AI companions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Talkie
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'talkie-ai.com' OR LOWER(`name`) = 'talkie')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Talkie', NULL, 'https://www.talkie-ai.com/', NULL, NULL, 'Безкоштовні чати з AI-персонажами, створеними спільнотою, і можливість створити власного.', 'Free chats with community-created AI characters and the option to create your own.', 'Talkie — платформа для розмов з AI-персонажами: історичними, вигаданими, з різних жанрів і світів. Користувачі можуть створювати власних персонажів і ділитися ними. Сервіс безкоштовний, із платними розширеннями. Відповіді генерує AI, тож він не замінює живого спілкування чи фахової допомоги.', 'Talkie is a platform for chatting with AI characters — historical, fictional, from many genres and worlds. Users can create and share their own characters. It is free, with paid extras. Responses are AI-generated, so it does not replace human connection or professional help.', 'Тисячі AI-персонажів
Створення власних персонажів
Різні жанри й сюжети
Безкоштовно', 'Thousands of AI characters
Create your own characters
Many genres and stories
Free', 'Любителям інтерактивних історій і рольових розмов.', 'Fans of interactive stories and role-play chats.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'talkie-ai.com' OR LOWER(`name`) = 'talkie') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free chats with community-created AI characters and the option to create your own.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Talkie is a platform for chatting with AI characters — historical, fictional, from many genres and worlds. Users can create and share their own characters. It is free, with paid extras. Responses are AI-generated, so it does not replace human connection or professional help.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of AI characters
Create your own characters
Many genres and stories
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fans of interactive stories and role-play chats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tolan
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tolans.com' OR LOWER(`name`) = 'tolan')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tolan', NULL, 'https://www.tolans.com/', NULL, NULL, 'Застосунок із дружнім «інопланетним» AI-компаньйоном, що підтримує в повсякденному житті.', 'An app with a friendly “alien” AI companion that supports you in everyday life.', 'Tolan — віртуальний друг-інопланетянин, який допомагає в повсякденних справах і підтримує у складні моменти. Команда досліджує, яким має бути «здоровий» AI-компаньйон, і публікує результати опитувань користувачів. Застосунок має понад 180 000 відгуків. Відповіді генерує AI, тож він не замінює живого спілкування чи фахової допомоги.', 'Tolan is a virtual alien friend that helps with everyday life and offers support in hard moments. The team researches what a healthy AI companion should look like and publishes user survey results. The app has over 180,000 reviews. Responses are AI-generated, so it does not replace human connection or professional help.', 'Дружній віртуальний персонаж
Підтримка в повсякденні
Підхід «здорового» компаньйона
Мобільний застосунок', 'Friendly virtual character
Everyday support
Healthy-companion approach
Mobile app', 'Користувачам, які шукають дружнього AI-співрозмовника.', 'Users looking for a friendly AI companion.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tolans.com' OR LOWER(`name`) = 'tolan') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app with a friendly “alien” AI companion that supports you in everyday life.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tolan is a virtual alien friend that helps with everyday life and offers support in hard moments. The team researches what a healthy AI companion should look like and publishes user survey results. The app has over 180,000 reviews. Responses are AI-generated, so it does not replace human connection or professional help.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Friendly virtual character
Everyday support
Healthy-companion approach
Mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users looking for a friendly AI companion.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sesame
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sesame.com' OR LOWER(`name`) = 'sesame')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sesame', NULL, 'https://www.sesame.com/', NULL, NULL, 'Голосові AI-агенти з «власною точкою зору» для розмов, ідей і повсякденних справ.', 'Voice AI agents “with a point of view” for conversation, ideas and everyday tasks.', 'Sesame створює голосових AI-агентів, які спілкуються природно й допомагають робити більше, обговорювати думки та досліджувати цікаве. Застосунки доступні на iOS та Android, компанія також анонсує підтримку окулярів. Відповіді генерує AI, тож він не замінює живого спілкування чи фахової допомоги.', 'Sesame builds voice AI agents that talk naturally and help you do more, talk things through and follow your curiosity. Apps are available on iOS and Android, and eyewear support has been announced. Responses are AI-generated, so it does not replace human connection or professional help.', 'Природні голосові розмови
Допомога в повсякденних справах
iOS та Android
Анонсовано окуляри', 'Natural voice conversations
Everyday help
iOS and Android
Eyewear announced', 'Тим, хто любить спілкуватися з AI голосом.', 'People who like talking to AI by voice.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sesame.com' OR LOWER(`name`) = 'sesame') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Voice AI agents “with a point of view” for conversation, ideas and everyday tasks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sesame builds voice AI agents that talk naturally and help you do more, talk things through and follow your curiosity. Apps are available on iOS and Android, and eyewear support has been announced. Responses are AI-generated, so it does not replace human connection or professional help.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Natural voice conversations
Everyday help
iOS and Android
Eyewear announced', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who like talking to AI by voice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ash (Slingshot AI) (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'talktoash.com' OR LOWER(`name`) = 'ash (slingshot ai)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Kuki
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kuki.ai' OR LOWER(`name`) = 'kuki')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kuki', NULL, 'https://www.kuki.ai/', NULL, NULL, 'Відзначений нагородами чат-бот і віртуальна інфлюенсерка: з Kuki можна поспілкуватися, а бренди використовують її в кампаніях.', 'An award-winning chatbot and virtual influencer: you can chat with Kuki, and brands use her in campaigns.', 'Kuki — AI-персонаж, з яким можна поспілкуватися в чаті, а також віртуальна модель та інфлюенсерка. Бренди залучають Kuki як віртуального амбасадора: наприклад, H&M провела з нею кампанію в Instagram. Відповіді генерує AI, тож він не замінює живого спілкування чи фахової допомоги.', 'Kuki is an AI character you can chat with, as well as a virtual model and influencer. Brands use Kuki as a virtual ambassador; for example, H&M ran an Instagram campaign with her. Responses are AI-generated, so it does not replace human connection or professional help.', 'Чат із персонажем
Віртуальна інфлюенсерка
Кампанії для брендів
Вебверсія', 'Chat with the character
Virtual influencer
Brand campaigns
Web version', 'Користувачам, які люблять поспілкуватися з чат-ботами, і брендам.', 'Users who enjoy chatbots, and brands.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kuki.ai' OR LOWER(`name`) = 'kuki') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An award-winning chatbot and virtual influencer: you can chat with Kuki, and brands use her in campaigns.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kuki is an AI character you can chat with, as well as a virtual model and influencer. Brands use Kuki as a virtual ambassador; for example, H&M ran an Instagram campaign with her. Responses are AI-generated, so it does not replace human connection or professional help.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Chat with the character
Virtual influencer
Brand campaigns
Web version', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users who enjoy chatbots, and brands.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Розпізнавання тексту (OCR) (tools-automation/ocr) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'tools-automation' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ocr' LIMIT 1);

-- Google Document AI
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cloud.google.com/document-ai' OR LOWER(`name`) = 'google document ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Google Document AI', NULL, 'https://cloud.google.com/document-ai', NULL, NULL, 'Сервіс Google Cloud для OCR, класифікації та вилучення даних із документів із готовими й власними моделями.', 'A Google Cloud service for OCR, classification and data extraction from documents with ready and custom models.', 'Document AI дає розробникам точні процесори для вилучення структурованих і неструктурованих даних із документів, їхньої класифікації та розділення. Є готові моделі для типових документів, Workbench для власних моделей, генеративне підсумовування великих документів та інтеграція з BigQuery. Нові клієнти Google Cloud отримують стартовий кредит.', 'Document AI gives developers high-accuracy processors to extract structured and unstructured data from documents, classify and split them. It includes pretrained models for common documents, Workbench for custom models, generative summarization of large documents and BigQuery integration. New Google Cloud customers get starter credit.', 'OCR і вилучення даних
Готові та власні моделі
Підсумовування документів
Інтеграція з BigQuery', 'OCR and data extraction
Pretrained and custom models
Document summarization
BigQuery integration', 'Розробникам і компаніям, що автоматизують обробку документів.', 'Developers and companies automating document processing.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cloud.google.com/document-ai' OR LOWER(`name`) = 'google document ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Google Cloud service for OCR, classification and data extraction from documents with ready and custom models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Document AI gives developers high-accuracy processors to extract structured and unstructured data from documents, classify and split them. It includes pretrained models for common documents, Workbench for custom models, generative summarization of large documents and BigQuery integration. New Google Cloud customers get starter credit.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'OCR and data extraction
Pretrained and custom models
Document summarization
BigQuery integration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and companies automating document processing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Amazon Textract
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aws.amazon.com/textract' OR LOWER(`name`) = 'amazon textract')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Amazon Textract', NULL, 'https://aws.amazon.com/textract/', NULL, NULL, 'ML-сервіс AWS, що розпізнає текст, рукопис, форми й таблиці зі сканованих документів.', 'An AWS machine-learning service that extracts text, handwriting, forms and tables from scanned documents.', 'Amazon Textract використовує оптичне розпізнавання символів і машинне навчання, щоб автоматично витягати текст, рукописні записи та дані з PDF-сканів, форм і таблиць. Сервіс працює через API в екосистемі AWS і оплачується за кількість оброблених сторінок.', 'Amazon Textract uses OCR and machine learning to automatically extract text, handwriting and data from scanned PDFs, forms and tables. It works via API within AWS and is billed per page processed.', 'Розпізнавання тексту й рукопису
Вилучення форм і таблиць
API в AWS
Оплата за сторінки', 'Text and handwriting recognition
Form and table extraction
API on AWS
Pay per page', 'Розробникам і компаніям на AWS.', 'Developers and companies on AWS.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aws.amazon.com/textract' OR LOWER(`name`) = 'amazon textract') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AWS machine-learning service that extracts text, handwriting, forms and tables from scanned documents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Amazon Textract uses OCR and machine learning to automatically extract text, handwriting and data from scanned PDFs, forms and tables. It works via API within AWS and is billed per page processed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Text and handwriting recognition
Form and table extraction
API on AWS
Pay per page', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and companies on AWS.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Azure AI Document Intelligence
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'azure.microsoft.com/en-us/products/ai-foundry/tools/document-intelligence' OR LOWER(`name`) = 'azure ai document intelligence')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Azure AI Document Intelligence', NULL, 'https://azure.microsoft.com/en-us/products/ai-foundry/tools/document-intelligence', NULL, NULL, 'Сервіс Microsoft Azure для вилучення тексту, структури й полів із документів AI-моделями.', 'A Microsoft Azure service for extracting text, structure and fields from documents with AI models.', 'Azure Document Intelligence (тепер частина Azure Content Understanding у Foundry Tools) швидко витягає текст, структуру й поля з документів: рахунків, квитанцій, посвідчень, договорів. Можна використати готові моделі або навчити власні. Є безкоштовний і стандартні тарифи.', 'Azure Document Intelligence (now part of Azure Content Understanding in Foundry Tools) quickly extracts text, structure and fields from documents such as invoices, receipts, IDs and contracts. Use prebuilt models or train custom ones. Free and standard pricing tiers are available.', 'Вилучення тексту й структури
Готові моделі для типових документів
Власні моделі
Безкоштовний тариф', 'Text and structure extraction
Prebuilt models for common documents
Custom models
Free tier', 'Розробникам і компаніям на Microsoft Azure.', 'Developers and companies on Microsoft Azure.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'azure.microsoft.com/en-us/products/ai-foundry/tools/document-intelligence' OR LOWER(`name`) = 'azure ai document intelligence') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Microsoft Azure service for extracting text, structure and fields from documents with AI models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Azure Document Intelligence (now part of Azure Content Understanding in Foundry Tools) quickly extracts text, structure and fields from documents such as invoices, receipts, IDs and contracts. Use prebuilt models or train custom ones. Free and standard pricing tiers are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Text and structure extraction
Prebuilt models for common documents
Custom models
Free tier', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and companies on Microsoft Azure.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mistral OCR
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mistral.ai/news/mistral-ocr' OR LOWER(`name`) = 'mistral ocr')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mistral OCR', NULL, 'https://mistral.ai/news/mistral-ocr/', NULL, NULL, 'OCR-моделі Mistral AI для розуміння документів: текст, таблиці, формули й зображення.', 'Mistral AI’s OCR models for document understanding: text, tables, equations and images.', 'Mistral OCR — лінійка моделей розпізнавання документів від Mistral AI, яка обробляє текст, таблиці, математичні формули та зображення в документах і повертає структурований результат. Перша версія вже не підтримується, її замінили новіші й потужніші OCR-моделі Mistral, доступні через API. Можливості можна безкоштовно спробувати в продуктах Mistral.', 'Mistral OCR is Mistral AI’s family of document-understanding models that handle text, tables, equations and images and return structured output. The first version is no longer maintained and has been replaced by newer, more powerful Mistral OCR models available via API. The capabilities can be tried for free in Mistral’s products.', 'Розпізнавання тексту, таблиць і формул
Структурований результат
Доступ через API
Безкоштовна спроба', 'Recognition of text, tables and equations
Structured output
API access
Free to try', 'Розробникам, які будують RAG і обробку документів.', 'Developers building RAG and document pipelines.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mistral.ai/news/mistral-ocr' OR LOWER(`name`) = 'mistral ocr') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mistral AI’s OCR models for document understanding: text, tables, equations and images.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mistral OCR is Mistral AI’s family of document-understanding models that handle text, tables, equations and images and return structured output. The first version is no longer maintained and has been replaced by newer, more powerful Mistral OCR models available via API. The capabilities can be tried for free in Mistral’s products.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Recognition of text, tables and equations
Structured output
API access
Free to try', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers building RAG and document pipelines.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tesseract OCR
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/tesseract-ocr/tesseract' OR LOWER(`name`) = 'tesseract ocr')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tesseract OCR', NULL, 'https://github.com/tesseract-ocr/tesseract', NULL, NULL, 'Безкоштовний OCR-рушій із відкритим кодом на нейромережі LSTM з підтримкою понад 100 мов.', 'A free, open-source OCR engine with an LSTM neural network and support for 100+ languages.', 'Tesseract — один із найвідоміших відкритих рушіїв розпізнавання тексту. Починаючи з версії 4, він використовує нейромережу LSTM для розпізнавання рядків і зберігає старий рушій версії 3. Працює з командного рядка або як бібліотека, підтримує понад 100 мов, зокрема українську, і безліч обгорток для різних мов програмування.', 'Tesseract is one of the best-known open-source text recognition engines. Since version 4 it uses an LSTM neural network for line recognition while keeping the legacy version 3 engine. It runs from the command line or as a library, supports 100+ languages including Ukrainian, and has wrappers for many programming languages.', 'Нейромережа LSTM
100+ мов, зокрема українська
Командний рядок і бібліотека
Відкритий код', 'LSTM neural network
100+ languages including Ukrainian
Command line and library
Open source', 'Розробникам і ентузіастам, яким потрібне локальне OCR.', 'Developers and enthusiasts who need local OCR.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/tesseract-ocr/tesseract' OR LOWER(`name`) = 'tesseract ocr') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free, open-source OCR engine with an LSTM neural network and support for 100+ languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tesseract is one of the best-known open-source text recognition engines. Since version 4 it uses an LSTM neural network for line recognition while keeping the legacy version 3 engine. It runs from the command line or as a library, supports 100+ languages including Ukrainian, and has wrappers for many programming languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'LSTM neural network
100+ languages including Ukrainian
Command line and library
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and enthusiasts who need local OCR.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Rossum
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rossum.ai' OR LOWER(`name`) = 'rossum')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rossum', NULL, 'https://rossum.ai/', NULL, NULL, 'AI-обробка документів для транзакційних процесів: рахунки, е-інвойси, закупівлі.', 'AI document processing for transactional workflows: invoices, e-invoices and procurement.', 'Rossum автоматизує складні транзакційні процеси з документами: розпізнає й перевіряє рахунки, обробляє PDF та електронні інвойси на одній платформі й допомагає відповідати новим вимогам щодо е-інвойсингу в Європі. Компанії скорочують ручну роботу й час обробки рахунків.', 'Rossum automates complex transactional document workflows: it reads and validates invoices, processes PDFs and e-invoices on one platform, and helps meet new European e-invoicing mandates. Companies cut manual work and invoice processing time.', 'Розпізнавання рахунків
PDF і е-інвойси на одній платформі
Відповідність вимогам ЄС
Автоматизація процесів', 'Invoice recognition
PDFs and e-invoices on one platform
EU mandate compliance
Workflow automation', 'Фінансовим відділам і службам закупівель.', 'Finance and procurement teams.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rossum.ai' OR LOWER(`name`) = 'rossum') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI document processing for transactional workflows: invoices, e-invoices and procurement.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Rossum automates complex transactional document workflows: it reads and validates invoices, processes PDFs and e-invoices on one platform, and helps meet new European e-invoicing mandates. Companies cut manual work and invoice processing time.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Invoice recognition
PDFs and e-invoices on one platform
EU mandate compliance
Workflow automation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Finance and procurement teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Docsumo
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'docsumo.com' OR LOWER(`name`) = 'docsumo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Docsumo', NULL, 'https://www.docsumo.com/', NULL, NULL, 'AI-агенти, що класифікують, вилучають і перехресно перевіряють дані з банківських виписок та інших документів.', 'AI agents that classify, extract and cross-check data from bank statements and other documents.', 'Docsumo збирає документи, класифікує їх, витягає дані й перевіряє їх між собою, а потім передає структуровані дані у вашу систему; людям лишається переглядати лише винятки. Платформа працює з банківськими виписками, страховими формами ACORD, медичними пакетами документів тощо. Можна безкоштовно обробити 1000 сторінок.', 'Docsumo collects documents, classifies them, extracts data and cross-checks it, then posts structured data to your system so people only review exceptions. It handles bank statements, ACORD insurance forms, Medicaid packets and more. You can process 1,000 pages for free.', 'Класифікація й вилучення даних
Перехресна перевірка документів
Інтеграція з системами
1000 сторінок безкоштовно', 'Classification and extraction
Cross-document checks
System integration
1,000 free pages', 'Кредитним, страховим і фінансовим компаніям.', 'Lending, insurance and finance companies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'docsumo.com' OR LOWER(`name`) = 'docsumo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI agents that classify, extract and cross-check data from bank statements and other documents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Docsumo collects documents, classifies them, extracts data and cross-checks it, then posts structured data to your system so people only review exceptions. It handles bank statements, ACORD insurance forms, Medicaid packets and more. You can process 1,000 pages for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Classification and extraction
Cross-document checks
System integration
1,000 free pages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Lending, insurance and finance companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Голосові агенти (tools-automation/voice-agents) ===================
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'tools-automation' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voice-agents' LIMIT 1);

-- PolyAI
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'poly.ai' OR LOWER(`name`) = 'polyai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PolyAI', NULL, 'https://poly.ai/', NULL, NULL, 'Корпоративна платформа голосових AI-агентів, що доводять розмови з клієнтами до кінця без передачі оператору.', 'An enterprise voice AI platform whose agents resolve customer conversations without escalation.', 'PolyAI створює діалогових голосових агентів для найважливіших розмов компаній із клієнтами: від бронювань до підтримки. Платформа дає змогу проєктувати, будувати, тестувати й постійно покращувати сценарії діалогів. Великі компанії обробляють через неї мільйони дзвінків на місяць.', 'PolyAI builds dialog voice agents for companies’ most critical customer conversations, from bookings to support. The platform lets you design, build, test and continuously optimize dialog experiences. Large enterprises handle millions of calls a month with it.', 'Голосові агенти для контакт-центрів
Проєктування й тестування діалогів
Масштаб у мільйони дзвінків
Корпоративний рівень', 'Voice agents for contact centers
Dialog design and testing
Millions of calls at scale
Enterprise grade', 'Великим компаніям із контакт-центрами.', 'Large companies with contact centers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'poly.ai' OR LOWER(`name`) = 'polyai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An enterprise voice AI platform whose agents resolve customer conversations without escalation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PolyAI builds dialog voice agents for companies’ most critical customer conversations, from bookings to support. The platform lets you design, build, test and continuously optimize dialog experiences. Large enterprises handle millions of calls a month with it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Voice agents for contact centers
Dialog design and testing
Millions of calls at scale
Enterprise grade', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Large companies with contact centers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Thoughtly
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thoughtly.com' OR LOWER(`name`) = 'thoughtly')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Thoughtly', NULL, 'https://www.thoughtly.com/', NULL, NULL, 'Голосові AI-агенти, що за секунди відповідають лідам, кваліфікують їх і призначають зустрічі.', 'Voice AI agents that respond to leads in seconds, qualify them and book meetings.', 'Thoughtly допомагає не втрачати жодного звернення: AI-агенти відповідають на дзвінки й заявки за секунди, відповідають на запитання, кваліфікують потенційних клієнтів і автоматично записують на зустріч. Компанії використовують його, щоб розвантажити або замінити кол-центр.', 'Thoughtly helps you never miss a lead: AI agents respond to calls and inquiries in seconds, answer questions, qualify prospects and book meetings automatically. Companies use it to offload or replace call-center work.', 'Миттєва відповідь лідам
Кваліфікація клієнтів
Автоматичний запис на зустрічі
Вхідні й вихідні дзвінки', 'Instant lead response
Lead qualification
Automatic meeting booking
Inbound and outbound calls', 'Відділам продажів і малому бізнесу.', 'Sales teams and small businesses.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thoughtly.com' OR LOWER(`name`) = 'thoughtly') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Voice AI agents that respond to leads in seconds, qualify them and book meetings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Thoughtly helps you never miss a lead: AI agents respond to calls and inquiries in seconds, answer questions, qualify prospects and book meetings automatically. Companies use it to offload or replace call-center work.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Instant lead response
Lead qualification
Automatic meeting booking
Inbound and outbound calls', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sales teams and small businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Cognigy
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cognigy.com' OR LOWER(`name`) = 'cognigy')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cognigy', NULL, 'https://www.cognigy.com/', NULL, NULL, 'Платформа NiCE Cognigy для генеративних і розмовних AI-агентів у голосовому та текстовому обслуговуванні клієнтів.', 'The NiCE Cognigy platform for generative and conversational AI agents in voice and chat customer service.', 'Cognigy (тепер частина NiCE) дає змогу розгортати AI-агентів у контакт-центрі для швидкого персоналізованого обслуговування голосом і в чатах. Платформа визнана лідером у Forrester Wave 2026 для розмовного AI в обслуговуванні клієнтів; авіакомпанії та інші великі бізнеси автоматизують через неї сотні тисяч розмов на місяць. Є безкоштовна спроба.', 'Cognigy (now part of NiCE) lets you deploy AI agents in the contact center for fast, personalized service over voice and chat. It was named a Leader in the Forrester Wave 2026 for conversational AI in customer service; airlines and other large businesses automate hundreds of thousands of conversations a month with it. A free trial is available.', 'Голосові й текстові AI-агенти
Розгортання в контакт-центрі
Генеративний і розмовний AI
Безкоштовна спроба', 'Voice and chat AI agents
Contact-center deployment
Generative and conversational AI
Free trial', 'Великим компаніям і контакт-центрам.', 'Large companies and contact centers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-15 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cognigy.com' OR LOWER(`name`) = 'cognigy') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The NiCE Cognigy platform for generative and conversational AI agents in voice and chat customer service.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Cognigy (now part of NiCE) lets you deploy AI agents in the contact center for fast, personalized service over voice and chat. It was named a Leader in the Forrester Wave 2026 for conversational AI in customer service; airlines and other large businesses automate hundreds of thousands of conversations a month with it. A free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Voice and chat AI agents
Contact-center deployment
Generative and conversational AI
Free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Large companies and contact centers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ або безкоштовний рівень.', 'Free access or a free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access or a free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ElevenLabs (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'elevenlabs.io' OR LOWER(`name`) = 'elevenlabs') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

