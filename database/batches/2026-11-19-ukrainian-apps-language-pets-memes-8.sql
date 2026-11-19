SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-19: «Українські додатки» / «Ukrainian Apps» (slug ukrainian-apps) — українська мова, тварини.
-- + 6 нових продуктів і 0 прив'язок наявних (функцію звірено на офіційних сайтах 2026-11-19).
-- Якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються.
-- Тексти UA/EN — за офіційними сайтами, звірено 2026-11-19.
-- Пропущено: UAnimals, Zootovary (403), «Є-Мова» (домен не знайдено).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Горох — українські словники — ua-language (новий)
--   СЛОВНИК.ua — ua-language (новий)
--   Ukrainian Lessons — ua-language (новий)
--   Animal-ID — ua-pets (новий)
--   Happy Paw — ua-pets (новий)
--   PetChoice — ua-pets (новий)
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);

-- Горох — українські словники
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'goroh.pp.ua' OR LOWER(`name`) = 'горох — українські словники')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Горох — українські словники', NULL, 'https://goroh.pp.ua', NULL, NULL, 'Українські словники онлайн: тлумачний (508 тис. слів), словозміна, синоніми, рими, етимологія, переклад і ігри.', 'Ukrainian dictionaries online: explanatory (508k words), inflection, synonyms, rhymes, etymology, translation and games.', 'Горох — публічна електронна бібліотека українських словників. Тлумачний словник на 508 тисяч слів, словозміна й орфографія, фонетична транскрипція, рими, синоніми, переклад вісьмома мовами, частотний словник на корпусі 260 млн слів, етимологія, фразеологія, морфеміка, анаграми й розділ типових помилок слововживання. Є ігри Alias і Wordle та Telegram-бот @goroh_bot. Безкоштовно з рекламою; рекламу можна вимкнути за підпискою.', 'Goroh is a public online library of Ukrainian dictionaries. It has an explanatory dictionary of 508,000 words, inflection and spelling, phonetic transcription, rhymes, synonyms, translation into eight languages, a frequency dictionary built on a 260-million-word corpus, etymology, phraseology, morphemes, anagrams and a section on common usage errors. There are Alias and Wordle games and the @goroh_bot Telegram bot. Free with ads; an ad-free subscription is available.', 'Тлумачний словник на 508 тис. слів
Словозміна й синоніми
Етимологія та фразеологія
Типові помилки слововживання
Telegram-бот та ігри', 'Explanatory dictionary of 508k words
Inflection and synonyms
Etymology and phraseology
Common usage errors
Telegram bot and games', 'Усім, хто пише й говорить українською, вивчає мову чи переходить на українську.', 'Anyone writing and speaking Ukrainian, learning the language or switching to it.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'goroh.pp.ua' OR LOWER(`name`) = 'горох — українські словники') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-language' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrainian dictionaries online: explanatory (508k words), inflection, synonyms, rhymes, etymology, translation and games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Goroh is a public online library of Ukrainian dictionaries. It has an explanatory dictionary of 508,000 words, inflection and spelling, phonetic transcription, rhymes, synonyms, translation into eight languages, a frequency dictionary built on a 260-million-word corpus, etymology, phraseology, morphemes, anagrams and a section on common usage errors. There are Alias and Wordle games and the @goroh_bot Telegram bot. Free with ads; an ad-free subscription is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Explanatory dictionary of 508k words
Inflection and synonyms
Etymology and phraseology
Common usage errors
Telegram bot and games', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone writing and speaking Ukrainian, learning the language or switching to it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно.', 'Free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Без реклами', 'Ad-free', 0.00, 'one_time', 'Підписка без реклами; ціна — на сайті.', 'Ad-free subscription; price on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Без реклами' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Ad-free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Ad-free subscription; price on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- СЛОВНИК.ua
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'slovnyk.ua' OR LOWER(`name`) = 'словник.ua')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'СЛОВНИК.ua', NULL, 'https://slovnyk.ua', NULL, NULL, 'Онлайн-словник української: СУМ, орфографія, наголоси, звертання, транслітерація й «Помічник» проти суржику.', 'Online Ukrainian dictionary: SUM, spelling, stress marks, forms of address, transliteration and an anti-surzhyk helper.', 'СЛОВНИК.ua — онлайн-словник української мови. Тлумачний словник на основі 11-томного СУМ (з дозволу Інституту мовознавства ім. О. О. Потебні) і доповнення користувачів, понад 260 тисяч словоформ, звертання (2600+ імен), офіційна й неофіційні транслітерації, пошук за правописом 2019 року, інструмент наголосів (бета) і «Помічник» — понад 700 слів-суржиків із правильними відповідниками. Безкоштовно.', 'SLOVNYK.ua is an online Ukrainian dictionary. It has an explanatory dictionary based on the 11-volume SUM (with permission from the Potebnia Institute of Linguistics) plus user additions, over 260,000 word forms, forms of address (2,600+ names), official and unofficial transliteration, search in the 2019 orthography, a stress-marking tool (beta) and a Helper with 700+ surzhyk words and their correct equivalents. Free.', 'Тлумачний словник (СУМ)
260+ тис. словоформ
Правопис 2019
Наголоси й транслітерація
Помічник проти суржику', 'Explanatory dictionary (SUM)
260k+ word forms
2019 orthography
Stress marks and transliteration
Anti-surzhyk helper', 'Усім, хто пише й говорить українською, вивчає мову чи переходить на українську.', 'Anyone writing and speaking Ukrainian, learning the language or switching to it.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'slovnyk.ua' OR LOWER(`name`) = 'словник.ua') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-language' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online Ukrainian dictionary: SUM, spelling, stress marks, forms of address, transliteration and an anti-surzhyk helper.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SLOVNYK.ua is an online Ukrainian dictionary. It has an explanatory dictionary based on the 11-volume SUM (with permission from the Potebnia Institute of Linguistics) plus user additions, over 260,000 word forms, forms of address (2,600+ names), official and unofficial transliteration, search in the 2019 orthography, a stress-marking tool (beta) and a Helper with 700+ surzhyk words and their correct equivalents. Free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Explanatory dictionary (SUM)
260k+ word forms
2019 orthography
Stress marks and transliteration
Anti-surzhyk helper', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone writing and speaking Ukrainian, learning the language or switching to it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно.', 'Free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ukrainian Lessons
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ukrainianlessons.com' OR LOWER(`name`) = 'ukrainian lessons')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ukrainian Lessons', NULL, 'https://www.ukrainianlessons.com', NULL, NULL, 'Вивчення української для іноземців: подкаст, міні-уроки, безкоштовний онлайн-підручник, робочі зошити й картки.', 'Learn Ukrainian as a foreign language: podcast, mini-lessons, a free online textbook, workbooks and flashcards.', 'Ukrainian Lessons — проєкт викладачки Анни Огойко для тих, хто вивчає українську як іноземну. Подкаст Ukrainian Lessons Podcast, 60 міні-уроків «5 Minute Ukrainian», блог як безкоштовний цифровий підручник, стартовий набір зі 100 слів із картками Anki, а також книжки: граматичний зошит «Ого!» A1, «500+ Ukrainian Verbs», «1000 Most Useful Ukrainian Words», прописи й розмовник. Подкаст і блог безкоштовні, преміум-доступ (транскрипти, вправи, картки) і книжки — платні. Сайт англійською.', 'Ukrainian Lessons is a project by teacher Anna Ohoiko for people learning Ukrainian as a foreign language. It offers the Ukrainian Lessons Podcast, 60 “5 Minute Ukrainian” mini-lessons, a blog that works as a free digital textbook, a starter kit of 100 words with Anki flashcards, and books: the “Ogo!” A1 grammar workbook, “500+ Ukrainian Verbs”, “1000 Most Useful Ukrainian Words”, a handwriting book and a phrasebook. The podcast and blog are free; premium membership (transcripts, exercises, flashcards) and books are paid. The site is in English.', 'Подкаст для вивчення української
60 міні-уроків
Безкоштовний онлайн-підручник
Робочі зошити й книжки
Картки Anki', 'Ukrainian learning podcast
60 mini-lessons
Free online textbook
Workbooks and books
Anki flashcards', 'Іноземцям і всім, хто вивчає українську з нуля чи хоче підтягнути рівень.', 'Foreigners and anyone learning Ukrainian from scratch or improving their level.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ukrainianlessons.com' OR LOWER(`name`) = 'ukrainian lessons') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-language' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Learn Ukrainian as a foreign language: podcast, mini-lessons, a free online textbook, workbooks and flashcards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ukrainian Lessons is a project by teacher Anna Ohoiko for people learning Ukrainian as a foreign language. It offers the Ukrainian Lessons Podcast, 60 “5 Minute Ukrainian” mini-lessons, a blog that works as a free digital textbook, a starter kit of 100 words with Anki flashcards, and books: the “Ogo!” A1 grammar workbook, “500+ Ukrainian Verbs”, “1000 Most Useful Ukrainian Words”, a handwriting book and a phrasebook. The podcast and blog are free; premium membership (transcripts, exercises, flashcards) and books are paid. The site is in English.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ukrainian learning podcast
60 mini-lessons
Free online textbook
Workbooks and books
Anki flashcards', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Foreigners and anyone learning Ukrainian from scratch or improving their level.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно.', 'Free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Animal-ID
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'animal-id.net' OR LOWER(`name`) = 'animal-id')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Animal-ID', NULL, 'https://animal-id.net', NULL, NULL, 'Реєстрація тварин і пошук за мікрочипом, QR-нашийники, карта ветклінік і притулків; застосунок для iPhone та Android.', 'Pet registration and microchip lookup, QR tags, a vet and shelter map; iPhone and Android app.', 'Animal-ID — сервіс реєстрації домашніх тварин із офісом у Дрогобичі. Пошук тварини за номером мікрочипа, персоналізовані QR-адресники, мікрочипи й сканери, карта ветклінік і притулків, програма для притулків і перепис безпритульних тварин. Базова реєстрація безкоштовна довічно, преміум-захист — платний. Є застосунок для iPhone та Android.', 'Animal-ID is a pet registration service with an office in Drohobych, Ukraine. It offers microchip lookup, personalised QR tags, microchips and scanners, a map of vets and shelters, shelter software and stray animal censuses. Basic registration is free for life; premium protection is paid. There is an iPhone and Android app.', 'Пошук за мікрочипом
Безкоштовна реєстрація тварини
QR-адресники
Карта ветклінік і притулків
Застосунок для iPhone та Android', 'Microchip lookup
Free pet registration
QR tags
Vet and shelter map
iPhone and Android app', 'Власникам котів і собак, волонтерам і всім, хто допомагає тваринам.', 'Cat and dog owners, volunteers and anyone helping animals.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'animal-id.net' OR LOWER(`name`) = 'animal-id') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-pets' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Pet registration and microchip lookup, QR tags, a vet and shelter map; iPhone and Android app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Animal-ID is a pet registration service with an office in Drohobych, Ukraine. It offers microchip lookup, personalised QR tags, microchips and scanners, a map of vets and shelters, shelter software and stray animal censuses. Basic registration is free for life; premium protection is paid. There is an iPhone and Android app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Microchip lookup
Free pet registration
QR tags
Vet and shelter map
iPhone and Android app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cat and dog owners, volunteers and anyone helping animals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Базова реєстрація безкоштовна довічно.', 'Basic registration is free for life.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic registration is free for life.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Happy Paw
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'happypaw.ua' OR LOWER(`name`) = 'happy paw')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Happy Paw', NULL, 'https://happypaw.ua', NULL, NULL, 'Благодійний фонд допомоги безпритульним тваринам: лікування, опіка, прилаштування, загублені й знайдені тварини.', 'Charity foundation for stray animals: treatment, guardianship, adoption and lost & found pets.', 'Happy Paw — благодійний фонд допомоги безпритульним тваринам. На сайті можна взяти тварину чи прилаштувати знайдену, повідомити про загублену або знайдену тварину, стати опікуном тварини чи притулку дистанційно, підтримати лікування тяжкохворих тварин і переглянути звіти фонду. Користуватися сайтом безкоштовно, пожертви — добровільні.', 'Happy Paw is a charity foundation helping stray animals. On the website you can adopt an animal or rehome one you found, report a lost or found pet, become a remote guardian of an animal or a shelter, support treatment of seriously ill animals and read the foundation’s reports. The site is free to use; donations are voluntary.', 'Взяти тварину з притулку
Загублені й знайдені тварини
Дистанційна опіка
Допомога тяжкохворим тваринам
Звіти фонду', 'Adopt a shelter animal
Lost and found pets
Remote guardianship
Help for seriously ill animals
Foundation reports', 'Власникам котів і собак, волонтерам і всім, хто допомагає тваринам.', 'Cat and dog owners, volunteers and anyone helping animals.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'happypaw.ua' OR LOWER(`name`) = 'happy paw') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-pets' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Charity foundation for stray animals: treatment, guardianship, adoption and lost & found pets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Happy Paw is a charity foundation helping stray animals. On the website you can adopt an animal or rehome one you found, report a lost or found pet, become a remote guardian of an animal or a shelter, support treatment of seriously ill animals and read the foundation’s reports. The site is free to use; donations are voluntary.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Adopt a shelter animal
Lost and found pets
Remote guardianship
Help for seriously ill animals
Foundation reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cat and dog owners, volunteers and anyone helping animals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно.', 'Free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PetChoice
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petchoice.ua' OR LOWER(`name`) = 'petchoice')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PetChoice', NULL, 'https://petchoice.ua', NULL, NULL, 'Одеський інтернет-зоомагазин: корм, здоров''я, догляд, амуніція; доставка Новою поштою й питання ветеринару.', 'Odesa-based online pet shop: food, health, grooming, accessories; Nova Poshta delivery and free vet questions.', 'PetChoice — інтернет-зоомагазин з Одеси. Товари для котів, собак, рибок, птахів і гризунів: харчування, здоров''я, догляд і гігієна, амуніція й аксесуари, речі для дому й подорожей. Доставка Новою поштою або кур''єром, безкоштовно від 1500 грн; оплата карткою, Приват24 або готівкою. Можна безкоштовно поставити питання ветеринару онлайн.', 'PetChoice is an online pet shop from Odesa. It sells products for cats, dogs, fish, birds and rodents: food, health, grooming and hygiene, accessories, and items for home and travel. Delivery by Nova Poshta or courier, free from UAH 1,500; payment by card, Privat24 or cash. You can ask a vet a question online for free.', 'Товари для котів, собак та інших тварин
Харчування й здоров''я
Доставка, безкоштовно від 1500 грн
Питання ветеринару онлайн
Акції', 'Products for cats, dogs and other pets
Food and health
Delivery, free from UAH 1,500
Ask a vet online
Deals', 'Власникам котів і собак, волонтерам і всім, хто допомагає тваринам.', 'Cat and dog owners, volunteers and anyone helping animals.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petchoice.ua' OR LOWER(`name`) = 'petchoice') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-pets' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Odesa-based online pet shop: food, health, grooming, accessories; Nova Poshta delivery and free vet questions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PetChoice is an online pet shop from Odesa. It sells products for cats, dogs, fish, birds and rodents: food, health, grooming and hygiene, accessories, and items for home and travel. Delivery by Nova Poshta or courier, free from UAH 1,500; payment by card, Privat24 or cash. You can ask a vet a question online for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Products for cats, dogs and other pets
Food and health
Delivery, free from UAH 1,500
Ask a vet online
Deals', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cat and dog owners, volunteers and anyone helping animals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив'язки наявних продуктів (за назвою, без id)


-- =====================================================================
-- AI LAB HUB — партія 2026-11-19: «Розважальні» / «Entertainment» (slug entertainment) — меми.
-- + 2 нових продуктів і 0 прив'язок наявних (функцію звірено на офіційних сайтах 2026-11-19).
-- Якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються.
-- Тексти UA/EN — за офіційними сайтами, звірено 2026-11-19.
-- Пропущено: VEED (сторінка мем-генератора 404), Mematic (сторінка порожня, App Store 404).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Make a Meme — memes (новий)
--   Flixier — memes (новий)
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'entertainment' LIMIT 1);

-- Make a Meme
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'makeameme.org' OR LOWER(`name`) = 'make a meme')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Make a Meme', NULL, 'https://makeameme.org', NULL, NULL, 'Безкоштовний онлайн-конструктор мемів: тисячі шаблонів або своє фото, підписи, 50+ шрифтів і AI-генератор.', 'Free online meme maker: thousands of templates or your own photo, captions, 50+ fonts and an AI meme generator.', 'Make a Meme — безкоштовний сайт для створення мемів. Можна завантажити власне зображення або вибрати шаблон із великої бібліотеки (знаменитості, ігри, спорт та інші), додати верхній і нижній підпис, назву, вибрати шрифт (понад 50), колір тексту й обведення та опублікувати мем. Є AI-генератор мемів і розділ порожніх шаблонів. Реєстрація безкоштовна.', 'Make a Meme is a free website for making memes. You can upload your own image or pick a template from a large library (celebrities, gaming, sports and more), add top and bottom captions and a title, choose a font (50+), text colour and outline, and publish the meme. There is an AI meme generator and a blank templates section. Registration is free.', 'Бібліотека шаблонів мемів
Власне фото
50+ шрифтів
AI-генератор мемів
Публікація мемів', 'Meme template library
Upload your own image
50+ fonts
AI meme generator
Publish memes', 'Усім, хто робить меми для соцмереж і чатів.', 'Anyone making memes for social media and chats.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'makeameme.org' OR LOWER(`name`) = 'make a meme') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'memes' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free online meme maker: thousands of templates or your own photo, captions, 50+ fonts and an AI meme generator.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Make a Meme is a free website for making memes. You can upload your own image or pick a template from a large library (celebrities, gaming, sports and more), add top and bottom captions and a title, choose a font (50+), text colour and outline, and publish the meme. There is an AI meme generator and a blank templates section. Registration is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meme template library
Upload your own image
50+ fonts
AI meme generator
Publish memes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone making memes for social media and chats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно.', 'Free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Flixier
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flixier.com/tools/meme-generator' OR LOWER(`name`) = 'flixier')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Flixier', NULL, 'https://flixier.com/tools/meme-generator', NULL, NULL, 'Онлайн-відеоредактор із конструктором мемів: відео, GIF і картинки, 1000+ шрифтів, анімація тексту й AI-підписи.', 'Online video editor with a meme maker: video, GIF and image memes, 1,000+ fonts, text animation and AI captions.', 'Flixier — відеоредактор у браузері з окремим конструктором мемів. Мем можна зробити з відео, GIF чи зображення: завантажити з пристрою, хмари чи за посиланням, додати текст (понад 1000 шрифтів, кольори, фони, анімація), обрізати й вирізати кадри, згенерувати підписи за допомогою AI. Експорт у відео чи GIF і публікація просто в Instagram, TikTok, YouTube, Facebook. Безкоштовний план — 720p із водяним знаком; платні — від $19 за місце на місяць.', 'Flixier is a browser-based video editor with a dedicated meme maker. You can make a meme from video, GIF or an image — upload from your device, cloud storage or a link — add text (1,000+ fonts, colours, backgrounds, animation), trim and cut frames, and generate captions with AI. Export as video or GIF and publish straight to Instagram, TikTok, YouTube and Facebook. The free plan exports 720p with a watermark; paid plans start at $19 per seat per month.', 'Меми з відео, GIF і картинок
1000+ шрифтів і анімація тексту
AI-підписи до мемів
Експорт у відео чи GIF
Публікація в соцмережі', 'Video, GIF and image memes
1,000+ fonts and text animation
AI meme captions
Export to video or GIF
Publish to social media', 'Усім, хто робить меми для соцмереж і чатів.', 'Anyone making memes for social media and chats.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flixier.com/tools/meme-generator' OR LOWER(`name`) = 'flixier') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'memes' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online video editor with a meme maker: video, GIF and image memes, 1,000+ fonts, text animation and AI captions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Flixier is a browser-based video editor with a dedicated meme maker. You can make a meme from video, GIF or an image — upload from your device, cloud storage or a link — add text (1,000+ fonts, colours, backgrounds, animation), trim and cut frames, and generate captions with AI. Export as video or GIF and publish straight to Instagram, TikTok, YouTube and Facebook. The free plan exports 720p with a watermark; paid plans start at $19 per seat per month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video, GIF and image memes
1,000+ fonts and text animation
AI meme captions
Export to video or GIF
Publish to social media', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone making memes for social media and chats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '10 хв експорту на місяць, 720p, водяний знак.', '10 min export per month, 720p, watermark.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '10 min export per month, 720p, watermark.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', 19.00, 'month', 'За місце: 60 хв експорту, 1080p, без водяного знака.', 'Per seat: 60 min export, 1080p, no watermark.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per seat: 60 min export, 1080p, no watermark.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Creator', 'Creator', 39.00, 'month', 'За місце: необмежений експорт, 4K.', 'Per seat: unlimited exports, 4K.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Creator' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Creator', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per seat: unlimited exports, 4K.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив'язки наявних продуктів (за назвою, без id)
