SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-25 (друга): доповнення категорії «Езотерика» / «Esoterics» (slug esoterics), 18 підкатегорій:
--   * Астрологія та гороскопи / Astrology & Horoscopes (slug astrology)
--   * Астропрограми та натальні карти / Astrology Software & Charts (slug astro-software)
--   * Ведична астрологія / Vedic Astrology (Jyotish) (slug vedic-astrology)
--   * Фен-шуй і китайська метафізика / Feng Shui & Chinese Metaphysics (slug feng-shui)
--   * Таро й оракули / Tarot & Oracles (slug tarot)
--   * Колоди таро та видавці / Tarot Decks & Publishers (slug tarot-decks)
--   * Нумерологія / Numerology (slug numerology)
--   * Ворожіння: руни, І-цзин, хіромантія / Divination: Runes, I Ching, Palmistry (slug divination)
--   * Екстрасенси та медіуми / Psychics & Mediums (slug psychics)
--   * Магія, вікка та відьомство / Magic, Wicca & Witchcraft (slug witchcraft)
--   * Обереги та захист від зла / Amulets & Protection (slug protection)
--   * Кристали та камені / Crystals & Stones (slug crystals)
--   * Пахощі, свічки та ритуальні товари / Incense, Candles & Ritual Supplies (slug incense-candles)
--   * Енергетичні практики / Energy Practices (slug energy-practices)
--   * Дизайн людини / Human Design (slug human-design)
--   * Сонники та тлумачення снів / Dream Interpretation (slug dreams)
--   * Місячні календарі / Moon Calendars (slug moon-calendars)
--   * Езотеричні книги та школи / Esoteric Books & Schools (slug esoteric-learning)
-- + 34 продуктів (якщо продукт уже є на сайті за адресою чи назвою — лише прив'язується до категорії, тексти не змінюються).
-- Тексти UA/EN написано з офіційних сайтів і сторінок у магазинах застосунків, звірено 2026-10-25. Без медичних обіцянок;
--   у картках енергетичних практик — застереження, що вони не замінюють медичної допомоги.
-- Ціни не вказано: план «Ціна: див. сайт» (0, one_time); Free — де офіційне джерело підтверджує безкоштовний рівень.
-- Категорія чутлива (categories.search_only_on_match = 1): Еля пропонує ці продукти лише на прямі запити (таро, гороскоп, руни…).
-- Пропущено: Remee (магазин не оновлювався з 2023), Badali, Mejuri (не езотерика), Jeremy Taylor (меморіальний сайт), недоступні й продані домени.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
INSERT INTO `categories` (`name`, `name_en`, `slug`) SELECT 'Езотерика', 'Esoterics', 'esoterics' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `categories` WHERE `slug` = 'esoterics');
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'esoterics' LIMIT 1);
SET @has_flag = (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'categories' AND COLUMN_NAME = 'search_only_on_match');
SET @sql = IF(@has_flag > 0 AND @cat IS NOT NULL, CONCAT('UPDATE `categories` SET `search_only_on_match` = 1 WHERE `id` = ', @cat), 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Астрологія та гороскопи', 'Astrology & Horoscopes', 'astrology' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'astrology');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Астропрограми та натальні карти', 'Astrology Software & Charts', 'astro-software' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'astro-software');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Ведична астрологія', 'Vedic Astrology (Jyotish)', 'vedic-astrology' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vedic-astrology');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Фен-шуй і китайська метафізика', 'Feng Shui & Chinese Metaphysics', 'feng-shui' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'feng-shui');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Таро й оракули', 'Tarot & Oracles', 'tarot' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tarot');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Колоди таро та видавці', 'Tarot Decks & Publishers', 'tarot-decks' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tarot-decks');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Нумерологія', 'Numerology', 'numerology' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'numerology');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Ворожіння: руни, І-цзин, хіромантія', 'Divination: Runes, I Ching, Palmistry', 'divination' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'divination');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Екстрасенси та медіуми', 'Psychics & Mediums', 'psychics' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'psychics');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Магія, вікка та відьомство', 'Magic, Wicca & Witchcraft', 'witchcraft' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'witchcraft');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Обереги та захист від зла', 'Amulets & Protection', 'protection' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'protection');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Кристали та камені', 'Crystals & Stones', 'crystals' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'crystals');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Пахощі, свічки та ритуальні товари', 'Incense, Candles & Ritual Supplies', 'incense-candles' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'incense-candles');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Енергетичні практики', 'Energy Practices', 'energy-practices' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'energy-practices');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Дизайн людини', 'Human Design', 'human-design' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'human-design');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Сонники та тлумачення снів', 'Dream Interpretation', 'dreams' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dreams');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Місячні календарі', 'Moon Calendars', 'moon-calendars' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'moon-calendars');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Езотеричні книги та школи', 'Esoteric Books & Schools', 'esoteric-learning' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'esoteric-learning');

-- Quantum Human Design — Дизайн людини, Езотеричні книги та школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'quantumhumandesign.com' OR LOWER(`name`) = 'quantum human design')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Quantum Human Design', NULL, 'https://quantumhumandesign.com', NULL, NULL, 'Система Quantum Human Design Карен Каррі Паркер: безкоштовна карта, читання, школа й сертифікації.', 'Karen Curry Parker’s Quantum Human Design: a free chart, readings, a school and certifications.', 'Quantum Human Design — авторська версія Дизайну людини Карен Каррі Паркер з власною мовою опису карти. На сайті можна отримати безкоштовну карту, замовити читання, знайти сертифікованого спеціаліста QHD, пройти навчання в школі (Essentials Training, сертифікації QHD і QAS, програма Passion and Profit) та прочитати блог.', 'Quantum Human Design is Karen Curry Parker’s take on Human Design with its own language for the chart. The site offers a free chart, readings, a directory of certified QHD specialists, a school (Essentials Training, QHD and QAS certifications, Passion and Profit) and a blog.', 'Безкоштовна карта
Читання
Каталог спеціалістів
Сертифікації QHD і QAS', 'Free chart
Readings
Specialist directory
QHD and QAS certifications', 'Тим, хто хоче вивчати Дизайн людини системно.', 'People who want to study Human Design systematically.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'quantumhumandesign.com' OR LOWER(`name`) = 'quantum human design') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'human-design' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'esoteric-learning' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Karen Curry Parker’s Quantum Human Design: a free chart, readings, a school and certifications.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Quantum Human Design is Karen Curry Parker’s take on Human Design with its own language for the chart. The site offers a free chart, readings, a directory of certified QHD specialists, a school (Essentials Training, QHD and QAS certifications, Passion and Profit) and a blog.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free chart
Readings
Specialist directory
QHD and QAS certifications', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to study Human Design systematically.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Emma Dunwoody — Transformational Human Design — Дизайн людини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'emmadunwoody.com' OR LOWER(`name`) = 'emma dunwoody — transformational human design')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Emma Dunwoody — Transformational Human Design', NULL, 'https://www.emmadunwoody.com', NULL, NULL, 'Майстер-коуч Емма Данвуді: Дизайн людини як «експеримент», подкаст, спільнота HDx, АІ-помічниця Maggie.', 'Master coach Emma Dunwoody: Human Design as an experiment, a podcast, the HDx Collective and the Maggie AI assistant.', 'Емма Данвуді — майстер-коуч із Дизайну людини й ведуча подкасту. Вона пропонує не «застрягати у знаннях», а проживати свій дизайн як експеримент, зокрема в бізнесі (програма Human Design for Visionaries). На сайті є безкоштовна карта, спільнота HDx Collective, АІ-помічниця Maggie, книга й послуги.', 'Emma Dunwoody is a Human Design master coach and podcast host. She encourages living your design as an experiment rather than getting stuck in knowledge, including in business (Human Design for Visionaries). The site has a free chart, the HDx Collective community, the Maggie AI assistant, a book and services.', 'Безкоштовна карта
Подкаст
Спільнота HDx Collective
АІ-помічниця Maggie', 'Free chart
Podcast
HDx Collective community
Maggie AI assistant', 'Підприємцям, які застосовують Дизайн людини.', 'Entrepreneurs applying Human Design.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'emmadunwoody.com' OR LOWER(`name`) = 'emma dunwoody — transformational human design') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'human-design' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Master coach Emma Dunwoody: Human Design as an experiment, a podcast, the HDx Collective and the Maggie AI assistant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Emma Dunwoody is a Human Design master coach and podcast host. She encourages living your design as an experiment rather than getting stuck in knowledge, including in business (Human Design for Visionaries). The site has a free chart, the HDx Collective community, the Maggie AI assistant, a book and services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free chart
Podcast
HDx Collective community
Maggie AI assistant', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Entrepreneurs applying Human Design.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Human Design Space — Дизайн людини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'humandesign.org.uk' OR LOWER(`name`) = 'the human design space')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Human Design Space', NULL, 'https://www.humandesign.org.uk', NULL, NULL, 'Британська аналітикиня Дизайну людини Рейчел Волмслі: читання, коучинг, курси й фестиваль для рефлекторів.', 'UK Human Design analyst Rachel Walmsley: readings, coaching, courses and a festival for Reflectors.', 'Рейчел Волмслі — аналітикиня й провідниця Дизайну людини, понад 10 років сертифікована Міжнародною школою Дизайну людини (IHDS). Вона проводить читання карт, коучинг і курси, має окремі матеріали й фестиваль для рефлекторів та бібліотеку ресурсів. Сесії бронюються на сайті.', 'Rachel Walmsley is a Human Design analyst and guide, certified by the International Human Design School for over 10 years. She offers chart readings, coaching and courses, with dedicated material and a festival for Reflectors and a resource library. Sessions are booked on the site.', 'Читання карт
Коучинг і курси
Матеріали для рефлекторів
Сертифікація IHDS', 'Chart readings
Coaching and courses
Reflector resources
IHDS certified', 'Тим, хто хоче особисте читання карти.', 'People wanting a personal chart reading.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'humandesign.org.uk' OR LOWER(`name`) = 'the human design space') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'human-design' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'UK Human Design analyst Rachel Walmsley: readings, coaching, courses and a festival for Reflectors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Rachel Walmsley is a Human Design analyst and guide, certified by the International Human Design School for over 10 years. She offers chart readings, coaching and courses, with dedicated material and a festival for Reflectors and a resource library. Sessions are booked on the site.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Chart readings
Coaching and courses
Reflector resources
IHDS certified', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People wanting a personal chart reading.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Human Design Hub — Дизайн людини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'humandesignhub.app' OR LOWER(`name`) = 'human design hub')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Human Design Hub', NULL, 'https://humandesignhub.app', NULL, NULL, 'Безкоштовний калькулятор і аналіз карти Дизайну людини: композити, групова пента, транзити, API.', 'A free Human Design chart calculator and analysis: composites, group penta, transits and an API.', 'Human Design Hub безкоштовно рахує й аналізує карту: тип, стратегію, авторитет, центри й ворота. Є композитна сумісність пари, аналіз групи (пента), транзити дня, бібліотека знань і карти знаменитостей. Для розробників — API, npm-компоненти та сервер MCP для підключення до АІ-асистентів.', 'Human Design Hub calculates and analyses your chart for free: type, strategy, authority, centers and gates. It offers composite compatibility, group penta analysis, daily transits, a knowledge library and celebrity charts. Developers get an API, npm components and an MCP server for AI assistants.', 'Безкоштовна карта
Композит і пента
Транзити
API та MCP', 'Free chart
Composite and penta
Transits
API and MCP', 'Користувачам і розробникам продуктів Дизайну людини.', 'Users and builders of Human Design products.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'humandesignhub.app' OR LOWER(`name`) = 'human design hub') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'human-design' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free Human Design chart calculator and analysis: composites, group penta, transits and an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Human Design Hub calculates and analyses your chart for free: type, strategy, authority, centers and gates. It offers composite compatibility, group penta analysis, daily transits, a knowledge library and celebrity charts. Developers get an API, npm components and an MCP server for AI assistants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free chart
Composite and penta
Transits
API and MCP', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users and builders of Human Design products.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Felicia Bender — Practical Numerologist — Нумерологія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'feliciabender.com' OR LOWER(`name`) = 'felicia bender — practical numerologist')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Felicia Bender — Practical Numerologist', NULL, 'https://feliciabender.com', NULL, NULL, 'Нумерологиня Фелісія Бендер: число життєвого шляху, місячні прогнози, приватні сесії й звіти.', 'Numerologist Felicia Bender: Life Path, monthly forecasts, private sessions and reports.', 'Фелісія Бендер, «практична нумерологиня», використовує піфагорейську нумерологію, щоб допомогти визначити «шлях і призначення». На сайті — матеріали про числа життєвого шляху, щомісячні прогнози, статті, індивідуальні нумерологічні звіти, приватні сесії та магазин; вона також має книги й програму навчання.', 'Felicia Bender, “the Practical Numerologist”, uses Pythagorean numerology to help define your pathway and purpose. The site has Life Path material, monthly forecasts, articles, individual numerology reports, private sessions and a shop; she also has books and a training program.', 'Число життєвого шляху
Місячні прогнози
Приватні сесії
Індивідуальні звіти', 'Life Path
Monthly forecasts
Private sessions
Individual reports', 'Тим, хто хоче практичну нумерологію.', 'People wanting practical numerology.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'feliciabender.com' OR LOWER(`name`) = 'felicia bender — practical numerologist') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'numerology' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Numerologist Felicia Bender: Life Path, monthly forecasts, private sessions and reports.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Felicia Bender, “the Practical Numerologist”, uses Pythagorean numerology to help define your pathway and purpose. The site has Life Path material, monthly forecasts, articles, individual numerology reports, private sessions and a shop; she also has books and a training program.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Life Path
Monthly forecasts
Private sessions
Individual reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People wanting practical numerology.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Glynis Has Your Number — Нумерологія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'glynishasyournumber.com' OR LOWER(`name`) = 'glynis has your number')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Glynis Has Your Number', NULL, 'https://www.glynishasyournumber.com', NULL, NULL, 'Нумерологиня Глініс Маккантс: читання, книги про числа й кохання, безкоштовна розсилка.', 'Numerologist Glynis McCants: readings, books on numbers and love, and a free newsletter.', 'Глініс Маккантс — нумерологиня, авторка книг Glynis Has Your Number і Love by the Numbers. На її сайті можна замовити читання, купити продукти, дізнатися про значення чисел і підписатися на безкоштовну розсилку з нумерологічними прогнозами й рубрикою «Просто спитай Глініс».', 'Glynis McCants is a numerologist and author of Glynis Has Your Number and Love by the Numbers. Her site offers readings, products, number meanings and a free newsletter with numerology projections and a Just Ask Glynis section.', 'Нумерологічні читання
Книги авторки
Значення чисел
Безкоштовна розсилка', 'Numerology readings
Author’s books
Number meanings
Free newsletter', 'Тим, хто цікавиться нумерологією стосунків.', 'People interested in relationship numerology.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'glynishasyournumber.com' OR LOWER(`name`) = 'glynis has your number') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'numerology' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Numerologist Glynis McCants: readings, books on numbers and love, and a free newsletter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Glynis McCants is a numerologist and author of Glynis Has Your Number and Love by the Numbers. Her site offers readings, products, number meanings and a free newsletter with numerology projections and a Just Ask Glynis section.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Numerology readings
Author’s books
Number meanings
Free newsletter', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People interested in relationship numerology.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Numerology Show — Нумерологія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thenumerologyshow.buzzsprout.com' OR LOWER(`name`) = 'the numerology show')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Numerology Show', NULL, 'https://thenumerologyshow.buzzsprout.com', NULL, NULL, 'Подкаст Гейдена Кроуфорда про нумерологію з розмовами з нумерологами й духовними вчителями.', 'Hayden Crawford’s numerology podcast with conversations with numerologists and spiritual teachers.', 'The Numerology Show веде Гейден Кроуфорд з Dreemtime Academy. У кожному епізоді — розмова з нумерологами, духовними вчителями й «космічними мислителями» про те, як числа, на їхню думку, впливають на долю, і про «священну мову чисел». Епізоди безкоштовні.', 'The Numerology Show is hosted by Hayden Crawford of Dreemtime Academy. Each episode is a conversation with numerologists, spiritual teachers and cosmic thinkers about how, in their view, numbers shape destiny and the sacred language of numbers. Episodes are free.', 'Подкаст про нумерологію
Гості-нумерологи
Безкоштовно', 'Numerology podcast
Numerologist guests
Free', 'Слухачам, які вивчають нумерологію.', 'Listeners learning numerology.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thenumerologyshow.buzzsprout.com' OR LOWER(`name`) = 'the numerology show') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'numerology' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hayden Crawford’s numerology podcast with conversations with numerologists and spiritual teachers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Numerology Show is hosted by Hayden Crawford of Dreemtime Academy. Each episode is a conversation with numerologists, spiritual teachers and cosmic thinkers about how, in their view, numbers shape destiny and the sacred language of numbers. Episodes are free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Numerology podcast
Numerologist guests
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Listeners learning numerology.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kari Samuels — Нумерологія, Астрологія та гороскопи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'karisamuels.com' OR LOWER(`name`) = 'kari samuels')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kari Samuels', NULL, 'https://www.karisamuels.com', NULL, NULL, 'Нумерологиня й астрологиня Карі Семюелс: сесії, калькулятор життєвого шляху, звіти й курси.', 'Numerologist and astrologer Kari Samuels: sessions, a Life Path calculator, reports and courses.', 'Карі Семюелс поєднує нумерологію, астрологію й «зцілення душі». На сайті — калькулятор числа життєвого шляху, безкоштовна електронна книга з нумерології, нумерологічні звіти й курси, безкоштовний калькулятор натальної карти, гід за знаками Сонця, астрологічні звіти й курси, медитації та сесії.', 'Kari Samuels combines numerology, astrology and soul healing. The site has a Life Path calculator, a free numerology e-book, numerology reports and courses, a free natal chart calculator, a sun sign guide, astrology reports and courses, meditations and sessions.', 'Калькулятор життєвого шляху
Безкоштовна книга
Курси нумерології й астрології
Сесії', 'Life Path calculator
Free e-book
Numerology and astrology courses
Sessions', 'Тим, хто хоче вивчити нумерологію.', 'People wanting to learn numerology.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'karisamuels.com' OR LOWER(`name`) = 'kari samuels') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'numerology' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'astrology' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Numerologist and astrologer Kari Samuels: sessions, a Life Path calculator, reports and courses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kari Samuels combines numerology, astrology and soul healing. The site has a Life Path calculator, a free numerology e-book, numerology reports and courses, a free natal chart calculator, a sun sign guide, astrology reports and courses, meditations and sessions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Life Path calculator
Free e-book
Numerology and astrology courses
Sessions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People wanting to learn numerology.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Chaldean Numerology Calculator — Нумерологія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chaldeannumerology.com' OR LOWER(`name`) = 'chaldean numerology calculator')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Chaldean Numerology Calculator', NULL, 'https://chaldeannumerology.com', NULL, NULL, 'Безкоштовний калькулятор халдейської нумерології для імені чи слова — «лише для розваги».', 'A free Chaldean numerology calculator for a name or word — “for entertainment only”.', 'Chaldean Numerology рахує нумерологічне значення імені чи слова за халдейською системою. Розробники прямо зазначають, що інструмент створено лише для розваги, він не має спрямовувати життєві рішення, а самі вони — халдейські католики.', 'Chaldean Numerology calculates the numerological value of a name or word using the Chaldean system. The developers state plainly that the tool is for entertainment only and should not guide life decisions; they themselves are Chaldean Catholics.', 'Халдейська система
Розрахунок імені чи слова
Безкоштовно', 'Chaldean system
Name or word calculation
Free', 'Тим, хто хоче спробувати халдейську нумерологію.', 'People curious about Chaldean numerology.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chaldeannumerology.com' OR LOWER(`name`) = 'chaldean numerology calculator') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'numerology' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free Chaldean numerology calculator for a name or word — “for entertainment only”.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Chaldean Numerology calculates the numerological value of a name or word using the Chaldean system. The developers state plainly that the tool is for entertainment only and should not guide life decisions; they themselves are Chaldean Catholics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Chaldean system
Name or word calculation
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People curious about Chaldean numerology.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- iBand+ — Сонники та тлумачення снів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ibandplus.com' OR LOWER(`name`) = 'iband+')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'iBand+', NULL, 'https://www.ibandplus.com', NULL, NULL, 'ЕЕГ-пов’язка на голову для сну й усвідомлених снів з аудіовізуальними сигналами та розумним будильником.', 'An EEG headband for sleep and lucid dreaming with audio-visual cues and a smart alarm.', 'iBand+ — пов’язка з ЕЕГ-датчиками, яка відстежує фази сну й у потрібний момент подає аудіовізуальні сигнали, щоб допомогти усвідомити сон. Також є функції покращення сну, розумний будильник і застосунок; розробники згадують АІ й запатентовану технологію. Продається на офіційному сайті.', 'iBand+ is a headband with EEG sensors that tracks sleep stages and gives audio-visual cues at the right moment to help you become aware you are dreaming. It also offers sleep improvement, a smart alarm and an app; the makers mention AI and patented technology. Sold on the official site.', 'ЕЕГ-датчики
Сигнали для усвідомлених снів
Розумний будильник
Застосунок', 'EEG sensors
Lucid dreaming cues
Smart alarm
App', 'Тим, хто практикує усвідомлені сни.', 'Lucid dreaming practitioners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ibandplus.com' OR LOWER(`name`) = 'iband+') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dreams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An EEG headband for sleep and lucid dreaming with audio-visual cues and a smart alarm.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'iBand+ is a headband with EEG sensors that tracks sleep stages and gives audio-visual cues at the right moment to help you become aware you are dreaming. It also offers sleep improvement, a smart alarm and an app; the makers mention AI and patented technology. Sold on the official site.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'EEG sensors
Lucid dreaming cues
Smart alarm
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Lucid dreaming practitioners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dream Studies Portal (Ryan Hurd) — Сонники та тлумачення снів, Езотеричні книги та школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dreamstudies.org' OR LOWER(`name`) = 'dream studies portal (ryan hurd)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dream Studies Portal (Ryan Hurd)', NULL, 'https://dreamstudies.org', NULL, NULL, 'Портал Раяна Герда про усвідомлені сни: блог, подкаст, спільнота, курси й безкоштовний міні-курс.', 'Ryan Hurd’s lucid dreaming portal: a blog, podcast, community, courses and a free mini course.', 'Dream Studies Portal веде Раян Герд — дослідник і практик роботи зі снами. Тут можна пройти безкоштовний 6-денний відеокурс «Підготовка до усвідомлених снів», читати блог і щотижневу розсилку, слухати подкаст, долучитися до спільноти, пройти курси й знайти книги та «спорядження для снів».', 'Dream Studies Portal is run by Ryan Hurd, a researcher and practitioner of dreamwork. It offers a free 6-day video course, Preparing for Lucid Dreaming, a blog and weekly newsletter, a podcast, a community, courses and books and dream gear.', 'Безкоштовний міні-курс
Блог і подкаст
Спільнота
Курси', 'Free mini course
Blog and podcast
Community
Courses', 'Тим, хто вчиться усвідомлених снів.', 'People learning lucid dreaming.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dreamstudies.org' OR LOWER(`name`) = 'dream studies portal (ryan hurd)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dreams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'esoteric-learning' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ryan Hurd’s lucid dreaming portal: a blog, podcast, community, courses and a free mini course.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dream Studies Portal is run by Ryan Hurd, a researcher and practitioner of dreamwork. It offers a free 6-day video course, Preparing for Lucid Dreaming, a blog and weekly newsletter, a podcast, a community, courses and books and dream gear.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free mini course
Blog and podcast
Community
Courses', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People learning lucid dreaming.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Lucid Dreaming Experience — Сонники та тлумачення снів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'luciddreamingmagazine.com' OR LOWER(`name`) = 'the lucid dreaming experience')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Lucid Dreaming Experience', NULL, 'https://luciddreamingmagazine.com', NULL, NULL, 'Безкоштовний щоквартальний журнал про усвідомлені сни, що виходить з 2001 року.', 'A free quarterly magazine devoted to lucid dreaming, published since 2001.', 'The Lucid Dreaming Experience — безкоштовний журнал, який існує на підтримку читачів і виходить щокварталу з 2001 року. Він публікує статті про техніки й поради, інтерв’ю, розв’язання проблем і подолання кошмарів у снах, творчість, духовні й «вражаючі» усвідомлені сни, а також архів випусків. Читачі можуть надсилати власні сни.', 'The Lucid Dreaming Experience is a free, reader-supported quarterly magazine published since 2001. It covers techniques and tips, interviews, problem solving and healing nightmares, creativity, spiritual and mind-blowing lucid dreams, plus past issues. Readers can submit their own dreams.', 'Щоквартальний журнал
Техніки й поради
Інтерв’ю
Архів з 2001 року', 'Quarterly magazine
Techniques and tips
Interviews
Archive since 2001', 'Тим, хто практикує усвідомлені сни.', 'Lucid dreamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'luciddreamingmagazine.com' OR LOWER(`name`) = 'the lucid dreaming experience') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dreams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free quarterly magazine devoted to lucid dreaming, published since 2001.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Lucid Dreaming Experience is a free, reader-supported quarterly magazine published since 2001. It covers techniques and tips, interviews, problem solving and healing nightmares, creativity, spiritual and mind-blowing lucid dreams, plus past issues. Readers can submit their own dreams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Quarterly magazine
Techniques and tips
Interviews
Archive since 2001', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Lucid dreamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Way of the Dreamer (Robert Moss) — Сонники та тлумачення снів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mossdreams.com' OR LOWER(`name`) = 'way of the dreamer (robert moss)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Way of the Dreamer (Robert Moss)', NULL, 'https://www.mossdreams.com', NULL, NULL, 'Блог і практики «активного сновидіння» письменника Роберта Мосса.', 'Writer Robert Moss’s blog and practices of “active dreaming”.', 'Роберт Мосс — автор книг про сни й засновник підходу «активного сновидіння». Його сайт Way of the Dreamer публікує есе про сни, ворожіння й духовні традиції різних культур — наприклад, про оракул Іфа йоруба — та інформацію про його навчання.', 'Robert Moss is an author of books on dreams and the founder of Active Dreaming. His site, Way of the Dreamer, publishes essays on dreams, divination and spiritual traditions across cultures — such as the Yoruba Ifa oracle — and information on his teaching.', 'Есе про сни
Активне сновидіння
Традиції ворожіння
Навчання', 'Dream essays
Active Dreaming
Divination traditions
Teaching', 'Читачам, які цікавляться снами й міфологією.', 'Readers interested in dreams and myth.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mossdreams.com' OR LOWER(`name`) = 'way of the dreamer (robert moss)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dreams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Writer Robert Moss’s blog and practices of “active dreaming”.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Robert Moss is an author of books on dreams and the founder of Active Dreaming. His site, Way of the Dreamer, publishes essays on dreams, divination and spiritual traditions across cultures — such as the Yoruba Ifa oracle — and information on his teaching.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dream essays
Active Dreaming
Divination traditions
Teaching', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers interested in dreams and myth.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- World of Lucid Dreaming — Сонники та тлумачення снів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'world-of-lucid-dreaming.com' OR LOWER(`name`) = 'world of lucid dreaming')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'World of Lucid Dreaming', NULL, 'https://www.world-of-lucid-dreaming.com', NULL, NULL, 'Гід з усвідомлених снів із 2008 року: статті, безкоштовний курс, спільнота в Discord і YouTube.', 'A lucid dreaming guide since 2008: articles, a free course, a Discord community and YouTube.', 'World of Lucid Dreaming з 2008 року пояснює, що таке усвідомлені сни — коли людина розуміє, що спить, залишаючись уві сні, — і як цього навчитися. Є статті, ресурси, безкоштовний курс, спільнота в Discord і канал на YouTube.', 'Since 2008 World of Lucid Dreaming has explained lucid dreaming — becoming aware you are dreaming while still in the dream — and how to learn it. It offers articles, resources, a free course, a Discord community and a YouTube channel.', 'Статті про усвідомлені сни
Безкоштовний курс
Спільнота Discord
YouTube', 'Lucid dreaming articles
Free course
Discord community
YouTube', 'Початківцям в усвідомлених снах.', 'Lucid dreaming beginners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'world-of-lucid-dreaming.com' OR LOWER(`name`) = 'world of lucid dreaming') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dreams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A lucid dreaming guide since 2008: articles, a free course, a Discord community and YouTube.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Since 2008 World of Lucid Dreaming has explained lucid dreaming — becoming aware you are dreaming while still in the dream — and how to learn it. It offers articles, resources, a free course, a Discord community and a YouTube channel.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Lucid dreaming articles
Free course
Discord community
YouTube', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Lucid dreaming beginners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Feng Shui Society — Фен-шуй і китайська метафізика, Езотеричні книги та школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fengshuisociety.org.uk' OR LOWER(`name`) = 'the feng shui society')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Feng Shui Society', NULL, 'https://www.fengshuisociety.org.uk', NULL, NULL, 'Британський орган реєстрації акредитованих консультантів і викладачів фен-шую, курси й конференції.', 'The UK registration body for accredited feng shui consultants and teachers, with courses and conferences.', 'The Feng Shui Society — професійний орган реєстрації акредитованих консультантів і викладачів фен-шую у Великій Британії та Європі. Тут можна знайти консультанта, акредитовані школи й курси, вебінари й конференції, дізнатися про кодекс поведінки та як отримати акредитацію.', 'The Feng Shui Society is the professional registration body for accredited feng shui consultants and teachers in the UK and Europe. You can find a consultant, accredited schools and courses, webinars and conferences, and read its code of conduct and how to become accredited.', 'Пошук консультанта
Акредитовані школи
Вебінари й конференції
Кодекс поведінки', 'Find a consultant
Accredited schools
Webinars and conferences
Code of conduct', 'Клієнтам і практикам фен-шую в Європі.', 'Feng shui clients and practitioners in Europe.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fengshuisociety.org.uk' OR LOWER(`name`) = 'the feng shui society') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'feng-shui' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'esoteric-learning' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The UK registration body for accredited feng shui consultants and teachers, with courses and conferences.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Feng Shui Society is the professional registration body for accredited feng shui consultants and teachers in the UK and Europe. You can find a consultant, accredited schools and courses, webinars and conferences, and read its code of conduct and how to become accredited.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Find a consultant
Accredited schools
Webinars and conferences
Code of conduct', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Feng shui clients and practitioners in Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Marie Diamond — Фен-шуй і китайська метафізика
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mariediamond.com' OR LOWER(`name`) = 'marie diamond')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Marie Diamond', NULL, 'https://www.mariediamond.com', NULL, NULL, 'Консультантка й викладачка фен-шую Марі Даймонд: консультації, курси фен-шую, лозошукання й медитації, подкаст.', 'Feng shui consultant and teacher Marie Diamond: consulting, feng shui, dowsing and meditation courses, and a podcast.', 'Марі Даймонд консультує з фен-шую й лозошукання, менторить, виступає як спікерка й веде подкаст. На сайті — курси фен-шую, «маніфестації», медитації та лозошукання, каталог Diamond Directory, медіа, блог, події та магазин.', 'Marie Diamond offers feng shui and dowsing consulting and mentoring, speaks and hosts a podcast. Her site has courses in feng shui, manifestation, meditation and dowsing, the Diamond Directory, media, a blog, events and a shop.', 'Консультації з фен-шую
Курси фен-шую й лозошукання
Подкаст
Diamond Directory', 'Feng shui consulting
Feng shui and dowsing courses
Podcast
Diamond Directory', 'Тим, хто хоче вивчати фен-шуй онлайн.', 'People who want to learn feng shui online.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mariediamond.com' OR LOWER(`name`) = 'marie diamond') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'feng-shui' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Feng shui consultant and teacher Marie Diamond: consulting, feng shui, dowsing and meditation courses, and a podcast.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Marie Diamond offers feng shui and dowsing consulting and mentoring, speaks and hosts a podcast. Her site has courses in feng shui, manifestation, meditation and dowsing, the Diamond Directory, media, a blog, events and a shop.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Feng shui consulting
Feng shui and dowsing courses
Podcast
Diamond Directory', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to learn feng shui online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Anjie Cho — Фен-шуй і китайська метафізика
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'anjiecho.com' OR LOWER(`name`) = 'anjie cho')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Anjie Cho', NULL, 'https://www.anjiecho.com', NULL, NULL, 'Нью-йоркська архітекторка й консультантка з фен-шую, медитації та ікебани: послуги, курси, подкаст.', 'A New York architect and consultant in feng shui, meditation and ikebana: services, courses and a podcast.', 'Анджі Чо створює «гармонійні й живильні простори» на перетині архітектури, фен-шую та ікебани. Вона пропонує фен-шуй-консультації й дизайн житлових і комерційних інтер’єрів, курси, події, подкаст, блог, приватні воркшопи з ікебани та книги.', 'Anjie Cho creates nourishing spaces at the intersection of architecture, feng shui and ikebana. She offers feng shui consultations and residential and commercial interior design, courses, events, a podcast, a blog, private ikebana workshops and books.', 'Фен-шуй-консультації
Дизайн інтер’єрів
Курси й подкаст
Ікебана', 'Feng shui consultations
Interior design
Courses and podcast
Ikebana', 'Тим, хто облаштовує дім чи офіс за фен-шуєм.', 'People arranging home or office with feng shui.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'anjiecho.com' OR LOWER(`name`) = 'anjie cho') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'feng-shui' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A New York architect and consultant in feng shui, meditation and ikebana: services, courses and a podcast.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Anjie Cho creates nourishing spaces at the intersection of architecture, feng shui and ikebana. She offers feng shui consultations and residential and commercial interior design, courses, events, a podcast, a blog, private ikebana workshops and books.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Feng shui consultations
Interior design
Courses and podcast
Ikebana', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People arranging home or office with feng shui.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Blue Mountain Institute — Фен-шуй і китайська метафізика
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bluemountainfengshui.com' OR LOWER(`name`) = 'blue mountain institute')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Blue Mountain Institute', NULL, 'https://www.bluemountainfengshui.com', NULL, NULL, 'Інститут фен-шую й «природних законів» (раніше Blue Mountain Feng Shui Institute): послуги, навчання, магазин.', 'An institute of feng shui and Natural Laws (formerly Blue Mountain Feng Shui Institute): services, training and a store.', 'Blue Mountain Institute, раніше Blue Mountain Feng Shui Institute, навчає роботи з «природними законами» й ці у фен-шуї та сучасному дизайні. На сайті — послуги, програма сертифікації, новини й події, архів, галерея, відео, блог і магазин.', 'Blue Mountain Institute, formerly Blue Mountain Feng Shui Institute, teaches working with Natural Laws and Chi in feng shui and modern design. The site has services, a certification program, news and events, archives, a gallery, videos, a blog and a store.', 'Програма сертифікації
Послуги
Відео й блог
Магазин', 'Certification program
Services
Videos and blog
Store', 'Тим, хто вивчає фен-шуй професійно.', 'Professional feng shui students.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bluemountainfengshui.com' OR LOWER(`name`) = 'blue mountain institute') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'feng-shui' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An institute of feng shui and Natural Laws (formerly Blue Mountain Feng Shui Institute): services, training and a store.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Blue Mountain Institute, formerly Blue Mountain Feng Shui Institute, teaches working with Natural Laws and Chi in feng shui and modern design. The site has services, a certification program, news and events, archives, a gallery, videos, a blog and a store.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Certification program
Services
Videos and blog
Store', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professional feng shui students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mindful Design School — Фен-шуй і китайська метафізика, Езотеричні книги та школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mindfuldesignschool.com' OR LOWER(`name`) = 'mindful design school')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mindful Design School', NULL, 'https://mindfuldesignschool.com', NULL, NULL, 'Школа фен-шую з холістичним підходом: курси, сертифікація, подкаст і каталог консультантів.', 'A feng shui school with a holistic approach: courses, certification, a podcast and a consultant directory.', 'Mindful Design School пропонує «новий спосіб вивчати фен-шуй» — поєднання знань традиції з інтуїцією та увагою до внутрішньої й зовнішньої ці. Школа має курси, програму сертифікації, блог, подкаст, каталог консультантів і книгу.', 'Mindful Design School offers a new way to learn feng shui — balancing lineage knowledge with intuition and awareness of inner and outer qi. It has courses, a certification program, a blog, a podcast, a consultant directory and a book.', 'Курси фен-шую
Сертифікація
Подкаст
Каталог консультантів', 'Feng shui courses
Certification
Podcast
Consultant directory', 'Майбутнім консультантам із фен-шую.', 'Aspiring feng shui consultants.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mindfuldesignschool.com' OR LOWER(`name`) = 'mindful design school') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'feng-shui' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'esoteric-learning' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A feng shui school with a holistic approach: courses, certification, a podcast and a consultant directory.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mindful Design School offers a new way to learn feng shui — balancing lineage knowledge with intuition and awareness of inner and outer qi. It has courses, a certification program, a blog, a podcast, a consultant directory and a book.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Feng shui courses
Certification
Podcast
Consultant directory', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Aspiring feng shui consultants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Feng Shui Designs Inc. — Фен-шуй і китайська метафізика
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fengshuidesigns.com' OR LOWER(`name`) = 'feng shui designs inc.')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Feng Shui Designs Inc.', NULL, 'https://fengshuidesigns.com', NULL, NULL, 'Найдовша в США програма підготовки практиків фен-шую (з 1993): онлайн-сертифікація, хоум-стейджинг, консультації.', 'America’s longest-running feng shui practitioner training (since 1993): online certification, home staging and consultations.', 'Feng Shui Designs, Inc. з 1993 року навчає й сертифікує практиків фен-шую в США за школою BTB. Є онлайн-сертифікація, сертифікація професійного фен-шуй-стейджингу житла, консультації, читання І-цзин, «енергетичне балансування», кристали й папір для обрядів.', 'Since 1993 Feng Shui Designs, Inc. has trained and certified feng shui practitioners across the US in the BTB school. It offers online certification, professional feng shui home staging certification, consultations, I Ching readings, energy balancing, crystals and joss paper.', 'Онлайн-сертифікація BTB
Сертифікація хоум-стейджингу
Консультації
Читання І-цзин', 'Online BTB certification
Home staging certification
Consultations
I Ching readings', 'Тим, хто хоче стати практиком фен-шую.', 'People who want to become feng shui practitioners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fengshuidesigns.com' OR LOWER(`name`) = 'feng shui designs inc.') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'feng-shui' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'America’s longest-running feng shui practitioner training (since 1993): online certification, home staging and consultations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Since 1993 Feng Shui Designs, Inc. has trained and certified feng shui practitioners across the US in the BTB school. It offers online certification, professional feng shui home staging certification, consultations, I Ching readings, energy balancing, crystals and joss paper.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online BTB certification
Home staging certification
Consultations
I Ching readings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to become feng shui practitioners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Laura Cerrano Feng Shui — Фен-шуй і китайська метафізика
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fengshuimanhattan.com' OR LOWER(`name`) = 'laura cerrano feng shui')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Laura Cerrano Feng Shui', NULL, 'https://www.fengshuimanhattan.com', NULL, NULL, 'Консультантка з фен-шую й дизайну Лаура Серрано з понад 30-річним досвідом у Нью-Йорку й Лос-Анджелесі.', 'Feng shui and design consultant Laura Cerrano with 30+ years of experience in New York and Los Angeles.', 'Лаура Серрано понад 30 років консультує з фен-шую й дизайну на місці та дистанційно — у Мангеттені, Брукліні, Квінсі, на Лонг-Айленді й у Лос-Анджелесі, а також міжнародно. Вона проводить консультації, семінари й заняття.', 'Laura Cerrano has offered on-site and remote feng shui and design consulting for over 30 years — in Manhattan, Brooklyn, Queens, Long Island and Los Angeles, and internationally. She provides consultations, seminars and classes.', 'Консультації на місці й онлайн
Семінари й заняття
Нью-Йорк і Лос-Анджелес
30+ років досвіду', 'On-site and remote consultations
Seminars and classes
New York and Los Angeles
30+ years of experience', 'Клієнтам у США та онлайн.', 'Clients in the US and online.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fengshuimanhattan.com' OR LOWER(`name`) = 'laura cerrano feng shui') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'feng-shui' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Feng shui and design consultant Laura Cerrano with 30+ years of experience in New York and Los Angeles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Laura Cerrano has offered on-site and remote feng shui and design consulting for over 30 years — in Manhattan, Brooklyn, Queens, Long Island and Los Angeles, and internationally. She provides consultations, seminars and classes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'On-site and remote consultations
Seminars and classes
New York and Los Angeles
30+ years of experience', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Clients in the US and online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Spirit Daughter — Місячні календарі, Астрологія та гороскопи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spiritdaughter.com' OR LOWER(`name`) = 'spirit daughter')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Spirit Daughter', NULL, 'https://spiritdaughter.com', NULL, NULL, 'Місячні робочі зошити, застосунок Moment, курси з астрології й натальна карта від Джилл Вінтерсгайдер.', 'Moon workbooks, the Moment app, astrology courses and natal chart readings from Jill Wintersteen.', 'Spirit Daughter поєднує астрологію з добробутом. Найвідоміші продукти — місячні робочі зошити, а також застосунок Moment із пробним періодом, завантажувані гіди, курси (Call It In, Awaken, натальна карта, астрологія стосунків), читання натальної карти, книга, подкаст, кристали й йога.', 'Spirit Daughter combines astrology with wellbeing. Best known for its moon workbooks, it also offers the Moment app with a free trial, downloadable guides, courses (Call It In, Awaken, natal chart, astrology and relationships), natal chart readings, a book, a podcast, crystals and yoga.', 'Місячні робочі зошити
Застосунок Moment
Курси астрології
Подкаст', 'Moon workbooks
Moment app
Astrology courses
Podcast', 'Тим, хто живе за місячними циклами.', 'People living by lunar cycles.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spiritdaughter.com' OR LOWER(`name`) = 'spirit daughter') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'moon-calendars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'astrology' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Moon workbooks, the Moment app, astrology courses and natal chart readings from Jill Wintersteen.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Spirit Daughter combines astrology with wellbeing. Best known for its moon workbooks, it also offers the Moment app with a free trial, downloadable guides, courses (Call It In, Awaken, natal chart, astrology and relationships), natal chart readings, a book, a podcast, crystals and yoga.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Moon workbooks
Moment app
Astrology courses
Podcast', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People living by lunar cycles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kirsty Gallagher — Lunar Living — Місячні календарі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kirstygallagher.com' OR LOWER(`name`) = 'kirsty gallagher — lunar living')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kirsty Gallagher — Lunar Living', NULL, 'https://www.kirstygallagher.com', NULL, NULL, 'Авторка бестселера «Lunar Living» Кірсті Галлахер: членство, місячні ритуали, календар фаз і знак Місяця.', 'Lunar Living author Kirsty Gallagher: membership, moon rituals, a phase calendar and Moon sign tools.', 'Кірсті Галлахер — авторка бестселерів Sunday Times Lunar Living, The Goddess Path і Your Cosmic Purpose. Вона веде членство Lunar Living Sisterhood, пропонує пакет місячних ритуалів, медитації, книги й безкоштовні ресурси: календар фаз Місяця, визначення знака Місяця, натальну карту, челенджі.', 'Kirsty Gallagher is the Sunday Times bestselling author of Lunar Living, The Goddess Path and Your Cosmic Purpose. She runs the Lunar Living Sisterhood membership and offers a Moon Ritual Pack, meditations, books and free resources: a moon phase calendar, a Moon sign finder, a birth chart and challenges.', 'Членство Lunar Living
Місячні ритуали
Календар фаз
Знак Місяця', 'Lunar Living membership
Moon rituals
Phase calendar
Moon sign finder', 'Тим, хто практикує місячні ритуали.', 'People practising moon rituals.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kirstygallagher.com' OR LOWER(`name`) = 'kirsty gallagher — lunar living') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'moon-calendars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lunar Living author Kirsty Gallagher: membership, moon rituals, a phase calendar and Moon sign tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kirsty Gallagher is the Sunday Times bestselling author of Lunar Living, The Goddess Path and Your Cosmic Purpose. She runs the Lunar Living Sisterhood membership and offers a Moon Ritual Pack, meditations, books and free resources: a moon phase calendar, a Moon sign finder, a birth chart and challenges.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Lunar Living membership
Moon rituals
Phase calendar
Moon sign finder', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People practising moon rituals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NASA SVS — Moon Phase and Libration — Місячні календарі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'svs.gsfc.nasa.gov/gallery/moonphase' OR LOWER(`name`) = 'nasa svs — moon phase and libration')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NASA SVS — Moon Phase and Libration', NULL, 'https://svs.gsfc.nasa.gov/gallery/moonphase/', NULL, NULL, 'Візуалізація NASA: вигляд Місяця на будь-яку годину року — фаза, лібрація, відстань (Dial-A-Moon).', 'A NASA visualization showing the Moon at any hour of the year — phase, libration and distance (Dial-A-Moon).', 'Студія наукової візуалізації NASA щороку з 2011 року готує 8760 погодинних зображень Місяця з точними розміром, орієнтацією й освітленістю. Інструмент Dial-A-Moon показує, як виглядав чи виглядатиме Місяць у заданий час UTC: фаза, діаметр, відстань, координати. Зображення можна завантажити.', 'NASA’s Scientific Visualization Studio has produced 8,760 hourly renderings of the Moon each year since 2011, with precise size, orientation and illumination. Dial-A-Moon shows what the Moon looked or will look like at a given UTC time: phase, diameter, distance and coordinates. Images can be downloaded.', 'Dial-A-Moon
8760 зображень на рік
Фаза й лібрація
Завантаження зображень', 'Dial-A-Moon
8,760 images a year
Phase and libration
Image downloads', 'Тим, хто хоче точну астрономічну картину Місяця.', 'People wanting an accurate astronomical Moon view.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'svs.gsfc.nasa.gov/gallery/moonphase' OR LOWER(`name`) = 'nasa svs — moon phase and libration') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'moon-calendars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A NASA visualization showing the Moon at any hour of the year — phase, libration and distance (Dial-A-Moon).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NASA’s Scientific Visualization Studio has produced 8,760 hourly renderings of the Moon each year since 2011, with precise size, orientation and illumination. Dial-A-Moon shows what the Moon looked or will look like at a given UTC time: phase, diameter, distance and coordinates. Images can be downloaded.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dial-A-Moon
8,760 images a year
Phase and libration
Image downloads', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People wanting an accurate astronomical Moon view.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PhasesMoon — Місячні календарі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'phasesmoon.com' OR LOWER(`name`) = 'phasesmoon')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PhasesMoon', NULL, 'https://phasesmoon.com', NULL, NULL, 'Фаза Місяця сьогодні: освітленість, вік, схід і захід, сузір’я, календар повень і назви повних місяців.', 'The moon phase today: illumination, age, rise and set, constellation, full moon calendar and names.', 'PhasesMoon показує фазу Місяця сьогодні й завтра — освітленість, вік, час сходу й заходу, тривалість видимості, сузір’я й знак, — а також місячний цикл, Місяць на день народження, календар фаз і повень, назви повних місяців і фази для різних країн. Є арабська, іспанська й французька версії.', 'PhasesMoon shows today’s and tomorrow’s moon phase — illumination, age, rise and set times, visibility duration, constellation and sign — plus the lunar cycle, a birthday moon, phase and full moon calendars, full moon names and phases by country. Arabic, Spanish and French versions exist.', 'Фаза сьогодні й завтра
Схід і захід
Місяць на день народження
Календар повень', 'Phase today and tomorrow
Rise and set
Birthday moon
Full moon calendar', 'Тим, хто стежить за Місяцем.', 'Moon watchers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'phasesmoon.com' OR LOWER(`name`) = 'phasesmoon') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'moon-calendars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The moon phase today: illumination, age, rise and set, constellation, full moon calendar and names.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PhasesMoon shows today’s and tomorrow’s moon phase — illumination, age, rise and set times, visibility duration, constellation and sign — plus the lunar cycle, a birthday moon, phase and full moon calendars, full moon names and phases by country. Arabic, Spanish and French versions exist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Phase today and tomorrow
Rise and set
Birthday moon
Full moon calendar', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Moon watchers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ConjureDoctor (Dr. E. Products) — Магія, вікка та відьомство, Обереги та захист від зла
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'conjuredoctor.com' OR LOWER(`name`) = 'conjuredoctor (dr. e. products)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ConjureDoctor (Dr. E. Products)', NULL, 'https://www.conjuredoctor.com', NULL, NULL, 'Товари худу Dr. E.: олії, порошки, ванни, мішечки моджо, засоби «захисту й очищення», читання.', 'Dr. E.’s hoodoo supplies: condition oils, sachet powders, herb baths, mojo bags, protection and cleansing items and readings.', 'ConjureDoctor.com продає товари худу Dr. E., створені за фольклором південної народної магії: олії, порошки, трав’яні ванни, мішечки моджо, води й одеколони, свічки, набори та книги. Товари згруповано за призначенням, зокрема «захист і очищення». На сайті є пояснення, що таке худу і як користуватися продуктами, а також читання й «запалювання свічок».', 'ConjureDoctor.com sells Dr. E. hoodoo products based on Southern folk magic: condition oils, sachet powders, herb baths, mojo bags, waters and colognes, candles, spell kits and books. Products are grouped by use, including protection and cleansing. The site explains what hoodoo is and how to use the products, and offers readings and candle setting.', 'Олії й порошки худу
Мішечки моджо
Засоби захисту й очищення
Інструкції', 'Hoodoo oils and powders
Mojo bags
Protection and cleansing items
How-to guides', 'Практикам худу.', 'Hoodoo practitioners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'conjuredoctor.com' OR LOWER(`name`) = 'conjuredoctor (dr. e. products)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'witchcraft' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'protection' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Dr. E.’s hoodoo supplies: condition oils, sachet powders, herb baths, mojo bags, protection and cleansing items and readings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ConjureDoctor.com sells Dr. E. hoodoo products based on Southern folk magic: condition oils, sachet powders, herb baths, mojo bags, waters and colognes, candles, spell kits and books. Products are grouped by use, including protection and cleansing. The site explains what hoodoo is and how to use the products, and offers readings and candle setting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hoodoo oils and powders
Mojo bags
Protection and cleansing items
How-to guides', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Hoodoo practitioners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Runecasting — Ворожіння: руни, І-цзин, хіромантія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'runecasting.com' OR LOWER(`name`) = 'runecasting')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Runecasting', NULL, 'https://www.runecasting.com', NULL, NULL, 'Безкоштовне онлайн-ворожіння на рунах: щоденна руна, розклади на 1, 3, 5 і 9 рун, значення 24 рун, журнал.', 'Free online rune casting: a daily rune, 1-, 3-, 5- and 9-rune readings, all 24 meanings and a journal.', 'Runecasting дозволяє безкоштовно й без реєстрації кинути руни онлайн: розклади на одну, три, п’ять і дев’ять рун, щоденна руна з запитанням для роздумів. Є значення всіх 24 рун Старшого футарку, навчальні матеріали, книги й особистий журнал читань. Сайт подає руни як інструмент рефлексії.', 'Runecasting lets you cast runes online for free with no account: one-, three-, five- and nine-rune readings and a daily rune with a reflection question. It covers all 24 Elder Futhark meanings, learning material, books and a personal reading journal. The site frames runes as a tool for reflection.', 'Щоденна руна
Розклади на 1–9 рун
Значення 24 рун
Журнал читань', 'Daily rune
1–9 rune spreads
24 rune meanings
Reading journal', 'Тим, хто хоче спробувати руни онлайн.', 'People who want to try runes online.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'runecasting.com' OR LOWER(`name`) = 'runecasting') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'divination' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free online rune casting: a daily rune, 1-, 3-, 5- and 9-rune readings, all 24 meanings and a journal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Runecasting lets you cast runes online for free with no account: one-, three-, five- and nine-rune readings and a daily rune with a reflection question. It covers all 24 Elder Futhark meanings, learning material, books and a personal reading journal. The site frames runes as a tool for reflection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily rune
1–9 rune spreads
24 rune meanings
Reading journal', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to try runes online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mid-Atlantic Geomancy — Ворожіння: руни, І-цзин, хіромантія, Езотеричні книги та школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'geomancy.org' OR LOWER(`name`) = 'mid-atlantic geomancy')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mid-Atlantic Geomancy', NULL, 'https://www.geomancy.org', NULL, NULL, 'Ресурс Сіга Лонгрена про геомантію Землі: священна геометрія, лабіринти, лозошукання, священні місця.', 'Sig Lonegren’s resource on Earth geomancy: sacred geometry, labyrinths, dowsing and sacred space.', 'Mid-Atlantic Geomancy (MAG) досліджує, як свідомість людини «діалогує з духом Землі», і як гармонізувати стосунки людини й місця. На сайті — розділи про астрономію, священну геометрію, священні й світські простори, лозошукання, лабіринти, е-журнал, ресурси, читання таро й навчання із Сігом Лонгреном.', 'Mid-Atlantic Geomancy (MAG) explores how human consciousness dialogues with the Spirit of the Earth and how to harmonize person and place. The site covers astronomy, sacred geometry, sacred and secular space, dowsing, labyrinths, an e-zine, resources, tarot readings and study with Sig Lonegren.', 'Священна геометрія
Лабіринти
Лозошукання
Е-журнал', 'Sacred geometry
Labyrinths
Dowsing
E-zine', 'Тим, хто цікавиться земною геомантією.', 'People interested in Earth geomancy.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'geomancy.org' OR LOWER(`name`) = 'mid-atlantic geomancy') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'divination' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'esoteric-learning' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sig Lonegren’s resource on Earth geomancy: sacred geometry, labyrinths, dowsing and sacred space.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mid-Atlantic Geomancy (MAG) explores how human consciousness dialogues with the Spirit of the Earth and how to harmonize person and place. The site covers astronomy, sacred geometry, sacred and secular space, dowsing, labyrinths, an e-zine, resources, tarot readings and study with Sig Lonegren.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sacred geometry
Labyrinths
Dowsing
E-zine', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People interested in Earth geomancy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ciro Marchetti — Колоди таро та видавці
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ciromarchetti.com' OR LOWER(`name`) = 'ciro marchetti')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ciro Marchetti', NULL, 'https://www.ciromarchetti.com', NULL, NULL, 'Фентезійне й таро-мистецтво Чіро Маркетті: спеціальні видання колод, міні-колоди, тканини для читань.', 'Ciro Marchetti’s fantasy and tarot art: special edition decks, mini decks and reading cloths.', 'Чіро Маркетті — художник, відомий фентезійними колодами таро. На його сайті продаються спеціальні видання колод, підписані міні-колоди з тематичними тканинами для читань у шкіряних мішечках, тканини, кімоно-шалі й дерев’яні скриньки. Є промо й безкоштовні матеріали.', 'Ciro Marchetti is an artist known for fantasy tarot decks. His site sells special edition decks, signed mini decks with themed reading cloths in leather pouches, fabrics, kimono shawls and wooden boxes. There are promotions and free stuff.', 'Спеціальні видання колод
Підписані міні-колоди
Тканини для читань
Дерев’яні скриньки', 'Special edition decks
Signed mini decks
Reading cloths
Wooden boxes', 'Колекціонерам авторських колод.', 'Collectors of artist decks.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ciromarchetti.com' OR LOWER(`name`) = 'ciro marchetti') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tarot-decks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ciro Marchetti’s fantasy and tarot art: special edition decks, mini decks and reading cloths.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ciro Marchetti is an artist known for fantasy tarot decks. His site sells special edition decks, signed mini decks with themed reading cloths in leather pouches, fabrics, kimono shawls and wooden boxes. There are promotions and free stuff.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Special edition decks
Signed mini decks
Reading cloths
Wooden boxes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Collectors of artist decks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Camoin Tarot de Marseille — Колоди таро та видавці, Таро й оракули
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'en.camoin.com/tarot/-home-en-.html' OR LOWER(`name`) = 'camoin tarot de marseille')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Camoin Tarot de Marseille', NULL, 'https://en.camoin.com/tarot/-Home-en-.html', NULL, NULL, 'Марсельське таро Каміна — Ходоровського: реконструкція колоди, школа таро, курси, форум і магазин.', 'The Camoin–Jodorowsky Tarot de Marseille: deck reconstruction, a tarot school, courses, a forum and a shop.', 'Філіп Камуан — спадковий майстер-картяр із Марселя (традиція від Ніколя Конвера, 1760). Разом з Алехандро Ходоровським він реконструював марсельське таро. Сайт розповідає про реконструкцію, «закони» й метод читання Камуана, має школу таро з курсами й календарем, форум, музей, журнал і бутик.', 'Philippe Camoin is a hereditary master card-maker of Marseille (a lineage going back to Nicolas Conver, 1760). With Alejandro Jodorowsky he reconstructed the Tarot de Marseille. The site covers the reconstruction, Camoin’s laws and reading method, a tarot school with courses and a calendar, a forum, a museum, a magazine and a boutique.', 'Таро Каміна — Ходоровського
Школа таро
Метод читання
Форум і бутик', 'Camoin–Jodorowsky Tarot
Tarot school
Reading method
Forum and boutique', 'Шанувальникам марсельського таро.', 'Fans of the Tarot de Marseille.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'en.camoin.com/tarot/-home-en-.html' OR LOWER(`name`) = 'camoin tarot de marseille') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tarot-decks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tarot' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Camoin–Jodorowsky Tarot de Marseille: deck reconstruction, a tarot school, courses, a forum and a shop.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Philippe Camoin is a hereditary master card-maker of Marseille (a lineage going back to Nicolas Conver, 1760). With Alejandro Jodorowsky he reconstructed the Tarot de Marseille. The site covers the reconstruction, Camoin’s laws and reading method, a tarot school with courses and a calendar, a forum, a museum, a magazine and a boutique.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Camoin–Jodorowsky Tarot
Tarot school
Reading method
Forum and boutique', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fans of the Tarot de Marseille.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tarot de Marseille Héritage — Колоди таро та видавці
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tarot-de-marseille-heritage.com' OR LOWER(`name`) = 'tarot de marseille héritage')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tarot de Marseille Héritage', NULL, 'https://tarot-de-marseille-heritage.com', NULL, NULL, 'Факсиміле й реконструкції історичних марсельських таро XVIII століття.', 'Facsimiles and restorations of historical 18th-century Tarot de Marseille decks.', 'Tarot de Marseille Héritage зберігає традицію марсельського таро, випускаючи факсиміле й нові реконструкції історичних колод: Pierre Madenié (1709), Jean-Pierre Payen (1713), François Héri (1718, 1730) та інших. На сайті — каталог, магазин французькою й англійською, блог і відео про історичні таро.', 'Tarot de Marseille Héritage preserves the Tarot de Marseille tradition by producing facsimiles and new restorations of historical decks: Pierre Madenié (1709), Jean-Pierre Payen (1713), François Héri (1718, 1730) and others. The site has a catalogue, a French and English shop, a blog and videos on historical tarots.', 'Факсиміле історичних колод
Колоди XVIII століття
Магазин FR/EN
Відео й блог', 'Historical deck facsimiles
18th-century decks
FR/EN shop
Videos and blog', 'Колекціонерам і дослідникам таро.', 'Tarot collectors and researchers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tarot-de-marseille-heritage.com' OR LOWER(`name`) = 'tarot de marseille héritage') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tarot-decks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Facsimiles and restorations of historical 18th-century Tarot de Marseille decks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tarot de Marseille Héritage preserves the Tarot de Marseille tradition by producing facsimiles and new restorations of historical decks: Pierre Madenié (1709), Jean-Pierre Payen (1713), François Héri (1718, 1730) and others. The site has a catalogue, a French and English shop, a blog and videos on historical tarots.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Historical deck facsimiles
18th-century decks
FR/EN shop
Videos and blog', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tarot collectors and researchers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CBD Tarot de Marseille (Yoav Ben-Dov) — Колоди таро та видавці, Таро й оракули
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cbdtarot.com' OR LOWER(`name`) = 'cbd tarot de marseille (yoav ben-dov)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CBD Tarot de Marseille (Yoav Ben-Dov)', NULL, 'https://cbdtarot.com', NULL, NULL, 'Колода CBD Tarot de Marseille й книга «Tarot — the Open Reading» Йоава Бен-Дова, безкоштовні завантаження.', 'Yoav Ben-Dov’s CBD Tarot de Marseille deck and book Tarot — the Open Reading, with free downloads.', 'Йоав Бен-Дов (1957–2016) — фізик і таролог, автор колоди CBD Tarot de Marseille та книги Tarot — the Open Reading. На сайті — зображення карт, особливості колоди, відео, короткі тлумачення, онлайн-розклад на три карти, завантаження, рецензії й нагороди. Матеріали доступні кількома мовами.', 'Yoav Ben-Dov (1957–2016) was a physicist and tarot reader, creator of the CBD Tarot de Marseille deck and the book Tarot — the Open Reading. The site has card images, deck features, videos, short interpretations, an online three-card spread, downloads, reviews and awards. Material is in several languages.', 'Колода CBD Tarot de Marseille
Книга про «відкрите читання»
Онлайн-розклад на 3 карти
Безкоштовні завантаження', 'CBD Tarot de Marseille deck
Open Reading book
Online 3-card spread
Free downloads', 'Читачам марсельського таро.', 'Tarot de Marseille readers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cbdtarot.com' OR LOWER(`name`) = 'cbd tarot de marseille (yoav ben-dov)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tarot-decks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tarot' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Yoav Ben-Dov’s CBD Tarot de Marseille deck and book Tarot — the Open Reading, with free downloads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Yoav Ben-Dov (1957–2016) was a physicist and tarot reader, creator of the CBD Tarot de Marseille deck and the book Tarot — the Open Reading. The site has card images, deck features, videos, short interpretations, an online three-card spread, downloads, reviews and awards. Material is in several languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'CBD Tarot de Marseille deck
Open Reading book
Online 3-card spread
Free downloads', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tarot de Marseille readers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Little Red Tarot — Колоди таро та видавці, Таро й оракули
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'littleredtarot.com' OR LOWER(`name`) = 'little red tarot')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Little Red Tarot', NULL, 'https://littleredtarot.com', NULL, NULL, 'Британський магазин інді-таро й «радикальної магії»: незалежні колоди, оракули, книги, інтерв’ю з авторами.', 'A UK shop of indie tarot and radical magic: independent decks, oracles, books and creator interviews.', 'Little Red Tarot — британський магазин і медіа про альтернативні підходи до таро, ритуалів і магії. Тут продаються незалежно видані колоди таро й оракулів, путівники й книги, а також є інтерв’ю з авторами, поради, як обрати колоду, добірки для початківців і стала упаковка. Доставку в ЄС тимчасово призупинено.', 'Little Red Tarot is a UK shop and publication on alternative approaches to tarot, ritual and magic. It sells independently published tarot and oracle decks, guidebooks and books, with creator interviews, advice on choosing a deck, beginner picks and sustainable packaging. EU shipping is currently paused.', 'Інді-колоди таро й оракулів
Інтерв’ю з авторами
Як обрати колоду
Стала упаковка', 'Indie tarot and oracle decks
Creator interviews
Choosing a deck
Sustainable packaging', 'Шанувальникам незалежних колод.', 'Fans of indie decks.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'littleredtarot.com' OR LOWER(`name`) = 'little red tarot') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tarot-decks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tarot' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A UK shop of indie tarot and radical magic: independent decks, oracles, books and creator interviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Little Red Tarot is a UK shop and publication on alternative approaches to tarot, ritual and magic. It sells independently published tarot and oracle decks, guidebooks and books, with creator interviews, advice on choosing a deck, beginner picks and sustainable packaging. EU shipping is currently paused.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Indie tarot and oracle decks
Creator interviews
Choosing a deck
Sustainable packaging', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fans of indie decks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Shadowscapes (Stephanie Law) — Колоди таро та видавці
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shadowscapes.com' OR LOWER(`name`) = 'shadowscapes (stephanie law)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Shadowscapes (Stephanie Law)', NULL, 'https://www.shadowscapes.com', NULL, NULL, 'Мистецтво Стефані Лоу — авторки Shadowscapes Tarot, Verdance Tarot і оракула Dreamdance.', 'The art of Stephanie Law, creator of the Shadowscapes Tarot, Verdance Tarot and Dreamdance Oracle.', 'Shadowscapes — сайт художниці Стефані Пуі-Мун Лоу. Вона створила колоди Shadowscapes Tarot і Verdance Tarot та оракул Dreamdance, а також серії картин про казки й міфологію, фей, створінь, зодіак і ботаніку. На сайті є галереї, оригінальні роботи на продаж і принти.', 'Shadowscapes is the site of artist Stephanie Pui-Mun Law. She created the Shadowscapes Tarot, the Verdance Tarot and the Dreamdance Oracle, as well as series on fairytales and mythology, faeries, creatures, the zodiac and botanicals. The site has galleries, original works for sale and prints.', 'Shadowscapes Tarot
Verdance Tarot
Оракул Dreamdance
Оригінали й принти', 'Shadowscapes Tarot
Verdance Tarot
Dreamdance Oracle
Originals and prints', 'Шанувальникам фентезійних колод.', 'Fans of fantasy decks.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shadowscapes.com' OR LOWER(`name`) = 'shadowscapes (stephanie law)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tarot-decks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The art of Stephanie Law, creator of the Shadowscapes Tarot, Verdance Tarot and Dreamdance Oracle.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Shadowscapes is the site of artist Stephanie Pui-Mun Law. She created the Shadowscapes Tarot, the Verdance Tarot and the Dreamdance Oracle, as well as series on fairytales and mythology, faeries, creatures, the zodiac and botanicals. The site has galleries, original works for sale and prints.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Shadowscapes Tarot
Verdance Tarot
Dreamdance Oracle
Originals and prints', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fans of fantasy decks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Інтенти запасного пошуку Елі для «Езотерики» (php tools/eli-intents.php sql | grep esoterics)

