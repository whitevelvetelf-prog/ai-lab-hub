-- =====================================================================
-- AI LAB HUB — increment 2026-10-12. Два безпечні блоки (повторне застосування безпечне):
--   1) міграція реклами F–I: database/migration-2026-10-12-promo-operations.sql
--   2) каталог: database/batches/2026-10-12-family-dogs-35.sql (Виховання дітей, Дресирування собак,
--      Робочі та службові собаки; 35 нових продуктів + 7 прив'язок)
-- Порядок важливий: спершу міграція (колонка no_promo для «Виховання дітей»).
-- phpMyAdmin → gu621051_ailabhublive → «Импорт» → цей файл → Вперёд.
-- =====================================================================

-- =====================================================================
-- AI LAB HUB — міграція: відеореклама, блоки F–I (2026-10-12).
--   F  медіакіт (public/advertise.php): анонімні колонки page_views
--      (клас пристрою, мова) і кеш агрегатів аудиторії promo_audience_stats.
--   G  перевірка посилань креативів (додається нижче)
--   H  виключення чутливих сторінок і категорії рекламодавців (додається нижче)
--   I  e-mail і cron (додається нижче)
--
-- Працює поверх migration-2026-10-11-promo-video.sql (його треба застосувати раніше).
-- Лише CREATE TABLE IF NOT EXISTS / умовні ALTER / INSERT IGNORE / UPDATE прапорців.
-- Жодних DROP / TRUNCATE. Безпечно застосовувати повторно.
-- ad_settings.enabled НЕ змінюється.
-- Час у нових таблицях — UTC (DATETIME, пише код); межі «доби» — Europe/Kyiv.
-- =====================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- F1) page_views: анонімний клас пристрою (mobile/tablet/desktop/bot) і мова
--     інтерфейсу для агрегованої статистики аудиторії. Без UA, без IP.
--     Старі рядки лишаються NULL (дані накопичуються лише для нових переглядів).
-- ---------------------------------------------------------------------
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='page_views' AND COLUMN_NAME='device_class')=0,
  'ALTER TABLE page_views ADD COLUMN device_class VARCHAR(10) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='page_views' AND COLUMN_NAME='lang')=0,
  'ALTER TABLE page_views ADD COLUMN lang VARCHAR(5) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- ---------------------------------------------------------------------
-- F2) promo_audience_stats — кеш агрегатів аудиторії за період (оновлює
--     cron/promo-daily.php). metric: page_views, sessions, lang, lang_known,
--     device, device_known, top_category (dim = id категорії).
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS promo_audience_stats (
    period_from DATE NOT NULL,
    period_to   DATE NOT NULL,
    metric      VARCHAR(32) NOT NULL,
    dim         VARCHAR(64) NOT NULL DEFAULT '',
    value       BIGINT NOT NULL DEFAULT 0,
    computed_at DATETIME NOT NULL,
    PRIMARY KEY (period_to, metric, dim)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- F3) Посилання «Реклама на сайті» в підвалі (українська — у app/translations.php).
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('footer_advertise', 'en', 'Advertise', 'manual');

-- F4) Текст строку модерації для медіакіту (порожньо = «фіксованого строку немає»).
INSERT IGNORE INTO ad_settings (setting_key, setting_value) VALUES
('moderation_time_text_uk', ''),
('moderation_time_text_en', '');

-- =====================================================================
-- G) Перевірка посилань рекламних креативів (app/promo-linkcheck.php).
-- =====================================================================

-- G1) Журнал перевірок адрес переходу. Час — UTC.
CREATE TABLE IF NOT EXISTS ad_link_checks (
    id                   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    creative_id          INT NOT NULL,
    checked_at           DATETIME NOT NULL,
    url                  VARCHAR(500) NOT NULL,
    final_url            VARCHAR(1000) NULL,
    final_host           VARCHAR(255) NULL,
    http_status          SMALLINT UNSIGNED NULL,
    redirect_count       TINYINT UNSIGNED NOT NULL DEFAULT 0,
    response_ms          INT UNSIGNED NOT NULL DEFAULT 0,
    safe_browsing_status ENUM('ok', 'flagged', 'unknown', 'skipped') NOT NULL DEFAULT 'skipped',
    flags                VARCHAR(255) NOT NULL DEFAULT '',
    notes                TEXT NULL,
    PRIMARY KEY (id),
    KEY idx_ad_link_checks_creative (creative_id, id),
    KEY idx_ad_link_checks_checked (checked_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- G2) Чорний список доменів (керує адмін; батьківський домен блокує й піддомени).
CREATE TABLE IF NOT EXISTS ad_domain_blocklist (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    domain     VARCHAR(255) NOT NULL,
    reason     VARCHAR(255) NULL,
    created_by INT UNSIGNED NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_ad_domain_blocklist (domain)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- G3) Журнал подій реклами (автопауза, повторні перевірки, схвалення з підтвердженням тощо).
CREATE TABLE IF NOT EXISTS promo_event_log (
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    created_at  DATETIME NOT NULL,
    event       VARCHAR(40) NOT NULL,
    creative_id INT NULL,
    campaign_id INT NULL,
    user_id     INT UNSIGNED NULL,
    details     TEXT NULL,
    PRIMARY KEY (id),
    KEY idx_promo_event_log_created (created_at),
    KEY idx_promo_event_log_campaign (campaign_id, id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- G4) Стан перевірки на креативі. link_final_host — кінцевий домен, зафіксований
--     під час модерації (для виявлення підміни); link_fail_streak — помилки поспіль;
--     recheck_reason — чому креатив повернуто на повторну модерацію.
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_creatives' AND COLUMN_NAME='link_check_status')=0,
  'ALTER TABLE ad_creatives ADD COLUMN link_check_status VARCHAR(10) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_creatives' AND COLUMN_NAME='link_checked_at')=0,
  'ALTER TABLE ad_creatives ADD COLUMN link_checked_at DATETIME NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_creatives' AND COLUMN_NAME='link_final_host')=0,
  'ALTER TABLE ad_creatives ADD COLUMN link_final_host VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_creatives' AND COLUMN_NAME='link_fail_streak')=0,
  'ALTER TABLE ad_creatives ADD COLUMN link_fail_streak TINYINT UNSIGNED NOT NULL DEFAULT 0','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_creatives' AND COLUMN_NAME='recheck_reason')=0,
  'ALTER TABLE ad_creatives ADD COLUMN recheck_reason VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- G5) Список доменів-скорочувачів (рядок на домен; редагує адмін). INSERT IGNORE не
--     перезаписує вже змінений список.
INSERT IGNORE INTO ad_settings (setting_key, setting_value) VALUES
('shortener_domains', 'bit.ly\ntinyurl.com\nt.co\ngoo.gl\now.ly\nis.gd\nbuff.ly\ncutt.ly\nrebrand.ly\nshorturl.at\nt.ly\ntiny.cc\nrb.gy\nbitly.com\ns.id\nclck.ru\nv.gd\nlnkd.in\nshort.io\nqr.ae');

-- =====================================================================
-- H) Виключення чутливих сторінок і категорії рекламодавців.
-- =====================================================================

-- H1) Прапорець «без реклами» (no_promo). Сторінка без реклами, якщо прапорець має
--     вона сама або її категорія/підкатегорія. Статті блогу — файли, тож для них
--     окрема таблиця за slug.
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='categories' AND COLUMN_NAME='no_promo')=0,
  'ALTER TABLE categories ADD COLUMN no_promo TINYINT(1) NOT NULL DEFAULT 0','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='subcategories' AND COLUMN_NAME='no_promo')=0,
  'ALTER TABLE subcategories ADD COLUMN no_promo TINYINT(1) NOT NULL DEFAULT 0','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='products' AND COLUMN_NAME='no_promo')=0,
  'ALTER TABLE products ADD COLUMN no_promo TINYINT(1) NOT NULL DEFAULT 0','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

CREATE TABLE IF NOT EXISTS promo_blog_flags (
    slug       VARCHAR(191) NOT NULL,
    no_promo   TINYINT(1) NOT NULL DEFAULT 0,
    updated_at DATETIME NULL,
    PRIMARY KEY (slug)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- H2) Значення за замовчуванням — ЛИШЕ при першому застосуванні (маркер у ad_settings),
--     щоб повторний запуск не повертав прапорці, які адмін потім зняв.
--     Підкатегорія «Ментальне здоров'я та харчова поведінка» (slug
--     mental-health-eating-behavior у категорії health-beauty), усі її продукти,
--     статті ai-and-eating-behavior-support і ai-for-psychology-and-mental-health.
SET @h2 := (SELECT COUNT(*) FROM ad_settings WHERE setting_key = 'no_promo_defaults_2026_10_12');
SET @sub_meb := (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id
                 WHERE s.slug = 'mental-health-eating-behavior' AND c.slug = 'health-beauty' LIMIT 1);

UPDATE subcategories SET no_promo = 1 WHERE @h2 = 0 AND id = @sub_meb;

UPDATE products p JOIN product_subcategories ps ON ps.product_id = p.id
SET p.no_promo = 1
WHERE @h2 = 0 AND ps.subcategory_id = @sub_meb;

INSERT INTO promo_blog_flags (slug, no_promo, updated_at)
SELECT x.slug, 1, UTC_TIMESTAMP() FROM (
    SELECT 'ai-and-eating-behavior-support' AS slug UNION ALL SELECT 'ai-for-psychology-and-mental-health'
) x
WHERE @h2 = 0
ON DUPLICATE KEY UPDATE no_promo = 1;

INSERT IGNORE INTO ad_settings (setting_key, setting_value) VALUES ('no_promo_defaults_2026_10_12', '1');

-- H3) Категорія реклами (обирає рекламодавець у майстрі, перевіряє модератор):
--     ai_tools, education, dev_it, business_marketing, finance, health_wellness,
--     food_nutrition, gambling, adult, other.
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='advertiser_category')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN advertiser_category VARCHAR(30) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- H4) Правила: яка категорія реклами заборонена де. scope_type all — всюди;
--     category / subcategory — на сторінках цієї категорії/підкатегорії (scope_id).
CREATE TABLE IF NOT EXISTS promo_category_rules (
    id                  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    scope_type          ENUM('category', 'subcategory', 'all') NOT NULL,
    scope_id            INT UNSIGNED NULL,
    advertiser_category VARCHAR(30) NOT NULL,
    rule                ENUM('block') NOT NULL DEFAULT 'block',
    note                VARCHAR(255) NULL,
    created_at          DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY idx_promo_category_rules (advertiser_category, scope_type, scope_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Початкові правила (лише якщо такого правила ще немає).
INSERT INTO promo_category_rules (scope_type, scope_id, advertiser_category, rule, note, created_at)
SELECT 'all', NULL, 'gambling', 'block', 'Ставки й азартні ігри заборонені всюди (модерація відхиляє)', UTC_TIMESTAMP() FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM promo_category_rules WHERE scope_type = 'all' AND advertiser_category = 'gambling');

INSERT INTO promo_category_rules (scope_type, scope_id, advertiser_category, rule, note, created_at)
SELECT 'all', NULL, 'adult', 'block', 'Контент для дорослих заборонений всюди (модерація відхиляє)', UTC_TIMESTAMP() FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM promo_category_rules WHERE scope_type = 'all' AND advertiser_category = 'adult');

SET @cat_health := (SELECT id FROM categories WHERE slug = 'health-beauty' LIMIT 1);
INSERT INTO promo_category_rules (scope_type, scope_id, advertiser_category, rule, note, created_at)
SELECT 'category', @cat_health, 'food_nutrition', 'block', 'Реклама їжі й харчування не показується на сторінках здоров''я', UTC_TIMESTAMP() FROM DUAL
WHERE @cat_health IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM promo_category_rules WHERE scope_type = 'category' AND scope_id = @cat_health AND advertiser_category = 'food_nutrition');

-- =====================================================================
-- I) E-mail і cron.
-- =====================================================================

-- I1) Черга листів: сайт лише додає, відправляє cron/promo-mail.php. Час — UTC.
CREATE TABLE IF NOT EXISTS mail_queue (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    to_email   VARCHAR(255) NOT NULL,
    to_name    VARCHAR(190) NOT NULL DEFAULT '',
    subject    VARCHAR(255) NOT NULL,
    body_text  MEDIUMTEXT NOT NULL,
    body_html  MEDIUMTEXT NOT NULL,
    lang       CHAR(2) NOT NULL DEFAULT 'uk',
    status     ENUM('pending', 'sent', 'failed') NOT NULL DEFAULT 'pending',
    attempts   TINYINT UNSIGNED NOT NULL DEFAULT 0,
    last_error VARCHAR(500) NULL,
    send_after DATETIME NOT NULL,
    created_at DATETIME NOT NULL,
    sent_at    DATETIME NULL,
    PRIMARY KEY (id),
    KEY idx_mail_queue_pending (status, send_after)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- I2) Налаштування сповіщень рекламодавця: мова листів і «низький баланс» (можна вимкнути).
CREATE TABLE IF NOT EXISTS promo_notify_prefs (
    user_id     INT UNSIGNED NOT NULL,
    lang        CHAR(2) NOT NULL DEFAULT 'uk',
    low_balance TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (user_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- I3) Журнал запусків cron-завдань (адмінка → «Стан»).
CREATE TABLE IF NOT EXISTS cron_runs (
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    job         VARCHAR(40) NOT NULL,
    started_at  DATETIME NOT NULL,
    finished_at DATETIME NULL,
    status      ENUM('running', 'ok', 'error', 'skipped') NOT NULL DEFAULT 'running',
    message     VARCHAR(1000) NULL,
    PRIMARY KEY (id),
    KEY idx_cron_runs_job (job, id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- I4) Коли рекламодавцю надіслано лист «кампанія стартувала».
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='started_notified_at')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN started_notified_at DATETIME NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Кампанії, що вже йдуть на момент міграції, листа «стартувала» не отримують (лише раз).
SET @i4 := (SELECT COUNT(*) FROM ad_settings WHERE setting_key = 'started_notified_init_2026_10_12');
UPDATE ad_campaigns SET started_notified_at = UTC_TIMESTAMP()
WHERE @i4 = 0 AND format = 'video' AND status IN ('active', 'paused', 'completed') AND started_notified_at IS NULL;
INSERT IGNORE INTO ad_settings (setting_key, setting_value) VALUES ('started_notified_init_2026_10_12', '1');

SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-12: три нові підкатегорії в категорії «Мій дім» (slug my-home):
--   * Виховання дітей / Parenting (slug parenting) — no_promo=1 (дитяча тема), якщо колонка no_promo є
--   * Дресирування собак / Dog training (slug dog-training)
--   * Робочі та службові собаки / Working and service dogs (slug working-dogs)
-- + 35 нових продуктів, 7 наявних лише прив'язано (тексти не змінюються):
--   Cozi Family Organizer, Dogo, Puppr, Woofz, Pupford, Gingr, MoeGo
-- EN-тексти приміток-застережень підкатегорій (UA — app/translations.php, механізм app/subcategory-note.php).
-- Описи нейтральні, без медичних/психологічних/юридичних порад і обіцянок результату; факти — з офіційних сторінок
-- і завдання користувача, звірено 2026-10-12. Ціни не вказано: план «Ціна: див. сайт» (0, one_time); Free — де є безкоштовний рівень.
-- Пропущено: GoodPup (goodpup.com переадресовує на Rover, застосунок у App Store недоступний),
--            K-9 Training Log (GoCanvas) — сторінки шаблону більше немає.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Wizzer: Parenting Coach — Виховання дітей
--   ChildMind AI: Parenting Coach — Виховання дітей
--   TinyPal — Виховання дітей
--   Parentii: AI Parenting Coach — Виховання дітей
--   MyBaby.help — Виховання дітей
--   Avocado Health — Виховання дітей
--   Kinedu — Виховання дітей
--   Nurtoora — Виховання дітей
--   The Wonder Weeks — Виховання дітей
--   Huckleberry — Виховання дітей
--   Glow Baby — Виховання дітей
--   BabyMind — Виховання дітей
--   Google Family Link — Виховання дітей
--   Canopy — Виховання дітей
--   OurFamilyWizard — Виховання дітей
--   AppClose — Виховання дітей
--   BestInterest — Виховання дітей
--   TalkingParents — Виховання дітей
--   Zigzag — Дресирування собак
--   PawChamp — Дресирування собак
--   Doggy Time — Дресирування собак
--   Hundeo — Дресирування собак
--   Pup to Date — Дресирування собак
--   iTrainer Dog Whistle & Clicker — Дресирування собак
--   DogBase — Робочі та службові собаки
--   K9Codex (SYSTALOG) — Робочі та службові собаки
--   RAM K9 Training: Dog Logbook — Робочі та службові собаки
--   PackTrack — Робочі та службові собаки
--   DogTracks — Робочі та службові собаки
--   tracking-dog — Робочі та службові собаки
--   PupManager — Робочі та службові собаки
--   Heeldash — Робочі та службові собаки
--   PetPocketbook — Робочі та службові собаки
--   Time To Pet — Робочі та службові собаки
--   RunLoyal — Робочі та службові собаки
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'my-home' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Виховання дітей', 'Parenting', 'parenting' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'parenting');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Дресирування собак', 'Dog training', 'dog-training' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dog-training');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Робочі та службові собаки', 'Working and service dogs', 'working-dogs' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'working-dogs');

-- Примітки-застереження (EN).
INSERT IGNORE INTO `ui_translations` (`key_name`, `lang`, `translated_text`, `source`) VALUES ('subcat_note_parenting', 'en', 'Apps do not replace advice from a pediatrician, psychologist or other specialist. Before entering data about a child, review the service''s privacy policy.', 'manual');
INSERT IGNORE INTO `ui_translations` (`key_name`, `lang`, `translated_text`, `source`) VALUES ('subcat_note_dog_training', 'en', 'Training methods vary. Choose methods that avoid pain and fear. Serious behavior problems are best discussed with a trainer or a veterinarian.', 'manual');
INSERT IGNORE INTO `ui_translations` (`key_name`, `lang`, `translated_text`, `source`) VALUES ('subcat_note_working_dogs', 'en', 'These are record-keeping and support tools. They do not replace certification, a qualified handler or your agency''s own rules. Handle sensitive data carefully.', 'manual');

-- «Виховання дітей» без реклами (лише якщо міграцію реклами 2026-10-12 уже застосовано).
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='subcategories' AND COLUMN_NAME='no_promo')=1,
  'UPDATE subcategories SET no_promo = 1 WHERE slug = ''parenting'' AND category_id = (SELECT id FROM categories WHERE slug = ''my-home'' LIMIT 1)','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- =================== Виховання дітей ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'parenting' LIMIT 1);

-- Wizzer: Parenting Coach — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.wizzer.parenta' OR LOWER(`name`) = 'wizzer: parenting coach')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wizzer: Parenting Coach', NULL, 'https://play.google.com/store/apps/details?id=com.wizzer.parenta', NULL, NULL, 'AI-коуч для батьків із порадами за віком дитини, спільнотою батьків і відстеженням прогресу в ігровій формі.', 'An AI parenting coach with age-based tips, a parent community and game-style progress tracking.', 'Wizzer — застосунок для Android, де AI-коуч підказує батькам з урахуванням віку дитини: сон, істерики, екранний час та інші щоденні ситуації. Є спільнота, де батьки діляться досвідом, і ігрова механіка: «дерево» росте, коли ви виконуєте поставлені цілі. Коуч доступний цілодобово.', 'Wizzer is an Android app with an AI coach that gives parents guidance based on the child’s age: sleep, tantrums, screen time and other everyday situations. It includes a community where parents share experience and a game-like mechanic in which a “tree” grows as you complete goals. The coach is available 24/7.', 'AI-коуч за віком дитини
Спільнота батьків
Відстеження прогресу в ігровій формі
Доступ цілодобово', 'AI coach tailored to the child’s age
Parent community
Game-style progress tracking
Available 24/7', 'Батькам, які шукають підказки для щоденних ситуацій з дитиною.', 'Parents looking for tips for everyday situations with their child.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.wizzer.parenta' OR LOWER(`name`) = 'wizzer: parenting coach') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI parenting coach with age-based tips, a parent community and game-style progress tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Wizzer is an Android app with an AI coach that gives parents guidance based on the child’s age: sleep, tantrums, screen time and other everyday situations. It includes a community where parents share experience and a game-like mechanic in which a “tree” grows as you complete goals. The coach is available 24/7.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI coach tailored to the child’s age
Parent community
Game-style progress tracking
Available 24/7', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents looking for tips for everyday situations with their child.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ChildMind AI: Parenting Coach — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.childmind.app.childmind' OR LOWER(`name`) = 'childmind ai: parenting coach')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ChildMind AI: Parenting Coach', NULL, 'https://play.google.com/store/apps/details?id=com.childmind.app.childmind', NULL, NULL, 'Чат-коуч для батьків у складних ситуаціях: істерики, конфлікти, емоційні спалахи й повторювані суперечки.', 'A chat coach for parents in hard moments: tantrums, conflicts, emotional outbursts and repeated arguments.', 'ChildMind AI — застосунок-чат, який допомагає батькам у моменти, коли емоції високі: істерики, конфлікти, повторювані суперечки. Він пропонує практичні формулювання й кроки, які можна застосувати одразу, щоб зберігати спокій у розмові з дитиною. Застосунок не замінює консультацію фахівця.', 'ChildMind AI is a chat app that helps parents when emotions run high: tantrums, conflicts and repeated arguments. It suggests practical wording and steps you can use right away to stay calm when talking with your child. The app does not replace advice from a specialist.', 'Чат-коуч для складних ситуацій
Практичні формулювання для розмови
Підтримка в конфліктах і спалахах', 'Chat coach for difficult moments
Practical wording for conversations
Support during conflicts and outbursts', 'Батькам, які хочуть спокійніше проходити складні моменти з дитиною.', 'Parents who want to handle hard moments with their child more calmly.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.childmind.app.childmind' OR LOWER(`name`) = 'childmind ai: parenting coach') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A chat coach for parents in hard moments: tantrums, conflicts, emotional outbursts and repeated arguments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ChildMind AI is a chat app that helps parents when emotions run high: tantrums, conflicts and repeated arguments. It suggests practical wording and steps you can use right away to stay calm when talking with your child. The app does not replace advice from a specialist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Chat coach for difficult moments
Practical wording for conversations
Support during conflicts and outbursts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents who want to handle hard moments with their child more calmly.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TinyPal — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tinypal.com' OR LOWER(`name`) = 'tinypal')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TinyPal', NULL, 'https://tinypal.com', NULL, NULL, 'Застосунок для батьків дітей 0–12 років: поради за віком і поведінкою, відстеження звичок, баланс екранного часу.', 'An app for parents of children aged 0–12: age- and behavior-based tips, habit tracking, screen-time balance.', 'TinyPal пропонує батькам цілі за віком дитини (наприклад, самостійне харчування, баланс екранного часу, упертість, істерики) і прості щоденні дії для них. Можна відстежувати поведінку й режим, а поради, за описом розробників, адаптуються за допомогою AI. Старт безкоштовний.', 'TinyPal suggests goals based on the child’s age (for example, independent eating, screen-time balance, stubborn behavior, tantrums) and simple daily actions for each. You can track behavior and routines, and according to the developers the tips are adapted with AI. You can start for free.', 'Цілі й поради за віком 0–12 років
Відстеження поведінки й режиму
Баланс екранного часу
Прості щоденні дії', 'Goals and tips for ages 0–12
Behavior and routine tracking
Screen-time balance
Simple daily actions', 'Батькам дітей від народження до 12 років.', 'Parents of children from birth to 12 years.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tinypal.com' OR LOWER(`name`) = 'tinypal') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app for parents of children aged 0–12: age- and behavior-based tips, habit tracking, screen-time balance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TinyPal suggests goals based on the child’s age (for example, independent eating, screen-time balance, stubborn behavior, tantrums) and simple daily actions for each. You can track behavior and routines, and according to the developers the tips are adapted with AI. You can start for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Goals and tips for ages 0–12
Behavior and routine tracking
Screen-time balance
Simple daily actions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents of children from birth to 12 years.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Parentii: AI Parenting Coach — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.parentii.app' OR LOWER(`name`) = 'parentii: ai parenting coach')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Parentii: AI Parenting Coach', NULL, 'https://play.google.com/store/apps/details?id=com.parentii.app', NULL, NULL, 'AI-помічник для батьків із християнським акцентом: режим для криз, таймер істерик, казки, допомога з уроками.', 'A faith-based (Christian) AI parenting helper: crisis mode, tantrum timer, bedtime stories, homework help.', 'Parentii — застосунок для батьків, що поєднує AI-підказки з підходом із християнським акцентом («faith-based»). У ньому є режим для криз, таймер істерик, сенсорні ігри, казки на ніч, допомога з домашніми завданнями й щоденні завдання, а також синхронізація між опікунами дитини.', 'Parentii is a parenting app that combines AI tips with a faith-based, Christian-oriented approach. It offers a crisis mode, a tantrum timer, sensory games, bedtime stories, homework help and daily missions, plus sync between the child’s caregivers.', 'Режим для криз і таймер істерик
Сенсорні ігри й казки на ніч
Допомога з домашніми завданнями
Синхронізація між опікунами', 'Crisis mode and tantrum timer
Sensory games and bedtime stories
Homework help
Caregiver sync', 'Батькам, яким близький підхід до виховання з християнським акцентом.', 'Parents who prefer a Christian, faith-based approach to parenting.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.parentii.app' OR LOWER(`name`) = 'parentii: ai parenting coach') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A faith-based (Christian) AI parenting helper: crisis mode, tantrum timer, bedtime stories, homework help.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Parentii is a parenting app that combines AI tips with a faith-based, Christian-oriented approach. It offers a crisis mode, a tantrum timer, sensory games, bedtime stories, homework help and daily missions, plus sync between the child’s caregivers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Crisis mode and tantrum timer
Sensory games and bedtime stories
Homework help
Caregiver sync', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents who prefer a Christian, faith-based approach to parenting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MyBaby.help — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mybaby.help' OR LOWER(`name`) = 'mybaby.help')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MyBaby.help', NULL, 'https://mybaby.help', NULL, NULL, 'AI-помічник для батьків малюків: персональні відповіді про догляд, годування й розвиток дитини.', 'An AI assistant for parents of babies: personalized answers about care, feeding and development.', 'MyBaby.help — веб-помічник, який, за описом розробників, дає персональні відповіді на щоденні питання про малюка: сон, годування, догляд і відстеження розвитку. Працює кількома мовами, почати можна безкоштовно. Відповіді сервісу не замінюють консультацію педіатра.', 'MyBaby.help is a web assistant that, according to its developers, gives personalized answers to everyday questions about a baby: sleep, feeding, care and development tracking. It works in several languages and you can start for free. Its answers do not replace advice from a pediatrician.', 'Персональні відповіді про догляд
Питання про сон і годування
Відстеження розвитку
Кілька мов інтерфейсу', 'Personalized care answers
Sleep and feeding questions
Development tracking
Several interface languages', 'Батькам немовлят і малюків.', 'Parents of infants and young babies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mybaby.help' OR LOWER(`name`) = 'mybaby.help') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI assistant for parents of babies: personalized answers about care, feeding and development.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MyBaby.help is a web assistant that, according to its developers, gives personalized answers to everyday questions about a baby: sleep, feeding, care and development tracking. It works in several languages and you can start for free. Its answers do not replace advice from a pediatrician.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personalized care answers
Sleep and feeding questions
Development tracking
Several interface languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents of infants and young babies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Avocado Health — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'avocadohealth.ai' OR LOWER(`name`) = 'avocado health')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Avocado Health', NULL, 'https://avocadohealth.ai', NULL, NULL, 'Коучинг для батьків через текстові повідомлення 24/7 без окремого застосунку; поєднує AI і людей.', 'Parent coaching by text message 24/7 without a separate app; combines AI and people.', 'Avocado Health надає батькам підтримку через звичайні повідомлення, без встановлення застосунку, цілодобово — від вагітності до підліткового віку. За словами розробників, AI обмежений клінічно перевіреними порадами, пам’ятає ім’я, вік та історію дитини, нагадує про віхи розвитку й візити до педіатра, а до відповідей залучаються люди-фахівці.', 'Avocado Health supports parents via regular text messages, with no app to install, 24/7 — from pregnancy to the teenage years. According to the developers, the AI is limited to clinically reviewed guidance, remembers the child’s name, age and history, reminds about milestones and pediatric visits, and human experts are involved in answers.', 'Підтримка через повідомлення 24/7
Поєднання AI і людей-фахівців
Нагадування про віхи й візити
Від вагітності до підліткового віку', 'Text-message support 24/7
AI combined with human experts
Milestone and visit reminders
From pregnancy to teenage years', 'Батькам, яким зручніше спілкуватися повідомленнями, ніж через застосунок.', 'Parents who prefer texting to using an app.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'avocadohealth.ai' OR LOWER(`name`) = 'avocado health') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Parent coaching by text message 24/7 without a separate app; combines AI and people.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Avocado Health supports parents via regular text messages, with no app to install, 24/7 — from pregnancy to the teenage years. According to the developers, the AI is limited to clinically reviewed guidance, remembers the child’s name, age and history, reminds about milestones and pediatric visits, and human experts are involved in answers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Text-message support 24/7
AI combined with human experts
Milestone and visit reminders
From pregnancy to teenage years', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents who prefer texting to using an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kinedu — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kinedu.com' OR LOWER(`name`) = 'kinedu')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kinedu', NULL, 'https://www.kinedu.com', NULL, NULL, 'Персональні розвивальні активності для дітей 0–4 років за віком і відміченими віхами розвитку.', 'Personalized developmental activities for children aged 0–4 based on age and logged milestones.', 'Kinedu складає щоденний план простих активностей для малюка відповідно до його віку й віх розвитку, які відмічають батьки. За оглядом, у бібліотеці понад 2400 активностей. Є відстеження віх і заняття з експертами.', 'Kinedu builds a daily plan of simple activities for a baby based on age and the milestones parents log. According to a review, the library has more than 2,400 activities. It also offers milestone tracking and classes with experts.', 'Щоденний план активностей
Відстеження віх розвитку
Понад 2400 активностей (за оглядом)
Заняття з експертами', 'Daily activity plan
Milestone tracking
2,400+ activities (per review)
Classes with experts', 'Батькам дітей від народження до 4 років.', 'Parents of children from birth to 4 years.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kinedu.com' OR LOWER(`name`) = 'kinedu') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Personalized developmental activities for children aged 0–4 based on age and logged milestones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kinedu builds a daily plan of simple activities for a baby based on age and the milestones parents log. According to a review, the library has more than 2,400 activities. It also offers milestone tracking and classes with experts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily activity plan
Milestone tracking
2,400+ activities (per review)
Classes with experts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents of children from birth to 4 years.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nurtoora — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nurtoora.com' OR LOWER(`name`) = 'nurtoora')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nurtoora', NULL, 'https://nurtoora.com', NULL, NULL, 'Відстеження розвитку дитини від народження до 6 років і AI-компаньйон «Ask NurNur».', 'Child development tracking from birth to age 6 with the AI companion “Ask NurNur”.', 'Nurtoora допомагає батькам вести записи про розвиток дитини від народження до 6 років: віхи, настрій, харчування, сон. AI-компаньйон «Ask NurNur», за словами розробників, відповідає на основі внесених даних про дитину, а щотижневі підсумки можна взяти на прийом до фахівця. Доступні застосунок для iPhone і веб-версія.', 'Nurtoora helps parents keep records of a child’s development from birth to age 6: milestones, mood, meals and sleep. The AI companion “Ask NurNur”, according to the developers, answers based on the data you have entered, and weekly summaries can be taken to a specialist appointment. There is an iPhone app and a web version.', 'Відстеження віх розвитку
Щоденні записи: настрій, їжа, сон
AI-компаньйон Ask NurNur
Звіти для фахівця', 'Milestone tracking
Daily logs: mood, meals, sleep
AI companion Ask NurNur
Reports for specialists', 'Батькам дітей до 6 років.', 'Parents of children up to 6 years old.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nurtoora.com' OR LOWER(`name`) = 'nurtoora') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Child development tracking from birth to age 6 with the AI companion “Ask NurNur”.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Nurtoora helps parents keep records of a child’s development from birth to age 6: milestones, mood, meals and sleep. The AI companion “Ask NurNur”, according to the developers, answers based on the data you have entered, and weekly summaries can be taken to a specialist appointment. There is an iPhone app and a web version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Milestone tracking
Daily logs: mood, meals, sleep
AI companion Ask NurNur
Reports for specialists', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents of children up to 6 years old.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Wonder Weeks — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thewonderweeks.com' OR LOWER(`name`) = 'the wonder weeks')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Wonder Weeks', NULL, 'https://www.thewonderweeks.com', NULL, NULL, 'Застосунок про періоди розвитку немовлят — так звані «стрибки».', 'An app about infant developmental periods, the so-called “leaps”.', 'The Wonder Weeks розповідає батькам про періоди розвитку немовлят («стрибки»): коли вони, за описом, можуть настати і що в цей час відбувається з дитиною. Застосунок допомагає орієнтуватися в цих періодах.', 'The Wonder Weeks tells parents about infant developmental periods (“leaps”): when, according to the app, they may occur and what happens with the baby during them. The app helps parents find their way through these periods.', 'Календар «стрибків» розвитку
Пояснення періодів розвитку немовляти', 'Calendar of developmental leaps
Explanations of infant development periods', 'Батькам немовлят.', 'Parents of infants.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thewonderweeks.com' OR LOWER(`name`) = 'the wonder weeks') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app about infant developmental periods, the so-called “leaps”.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Wonder Weeks tells parents about infant developmental periods (“leaps”): when, according to the app, they may occur and what happens with the baby during them. The app helps parents find their way through these periods.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Calendar of developmental leaps
Explanations of infant development periods', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents of infants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Huckleberry — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'huckleberrycare.com' OR LOWER(`name`) = 'huckleberry')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Huckleberry', NULL, 'https://huckleberrycare.com', NULL, NULL, 'Журнал сну, годувань, підгузків та інших дій догляду; корисний, коли складно з режимом сну.', 'A log of sleep, feeds, diapers and other care; especially useful when sleep routines are hard.', 'Huckleberry — трекер догляду за малюком: сон, годування, підгузки та інші щоденні дії в одному журналі. Застосунок особливо орієнтований на сон: за описом розробників, поєднує дитячих фахівців зі сну й AI для створення плану сну під вашу родину. Для дітей від народження до 5 років.', 'Huckleberry is a baby care tracker: sleep, feeds, diapers and other daily care in one log. It focuses especially on sleep: according to the developers, it combines pediatric sleep experts with AI to create a sleep plan for your family. For children from birth to age 5.', 'Журнал сну, годувань і підгузків
План сну від фахівців і AI
Для дітей до 5 років', 'Sleep, feeding and diaper log
Sleep plan from experts and AI
For children up to age 5', 'Батькам малюків, особливо коли складно з режимом сну.', 'Parents of young children, especially when sleep is a struggle.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'huckleberrycare.com' OR LOWER(`name`) = 'huckleberry') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A log of sleep, feeds, diapers and other care; especially useful when sleep routines are hard.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Huckleberry is a baby care tracker: sleep, feeds, diapers and other daily care in one log. It focuses especially on sleep: according to the developers, it combines pediatric sleep experts with AI to create a sleep plan for your family. For children from birth to age 5.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sleep, feeding and diaper log
Sleep plan from experts and AI
For children up to age 5', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents of young children, especially when sleep is a struggle.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Glow Baby — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/glow-baby-tracker-growth-app/id1077177456' OR LOWER(`name`) = 'glow baby')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Glow Baby', NULL, 'https://apps.apple.com/us/app/glow-baby-tracker-growth-app/id1077177456', NULL, NULL, 'Трекер годувань, підгузків, сну й віх розвитку немовляти.', 'A tracker for an infant’s feeds, diapers, sleep and milestones.', 'Glow Baby від компанії Glow допомагає записувати годування (зокрема грудне), підгузки, сон і віхи розвитку немовляти та бачити закономірності. Є матеріали про розвиток і харчування. Застосунок безкоштовний із вбудованими покупками.', 'Glow Baby by Glow lets parents log feeds (including breastfeeding), diapers, sleep and an infant’s milestones and see patterns. It also includes materials on development and nutrition. The app is free with in-app purchases.', 'Годування й грудне вигодовування
Підгузки й сон
Віхи розвитку
Матеріали для батьків', 'Feeding and breastfeeding log
Diapers and sleep
Milestones
Parenting materials', 'Батькам немовлят.', 'Parents of infants.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/glow-baby-tracker-growth-app/id1077177456' OR LOWER(`name`) = 'glow baby') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A tracker for an infant’s feeds, diapers, sleep and milestones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Glow Baby by Glow lets parents log feeds (including breastfeeding), diapers, sleep and an infant’s milestones and see patterns. It also includes materials on development and nutrition. The app is free with in-app purchases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Feeding and breastfeeding log
Diapers and sleep
Milestones
Parenting materials', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents of infants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BabyMind — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'babymind.app' OR LOWER(`name`) = 'babymind')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BabyMind', NULL, 'https://babymind.app', NULL, NULL, 'Застосунок для батьків з AI-підказками: аналіз плачу немовляти, вагітність і розвиток дитини.', 'A parenting app with AI tips: baby cry analysis, pregnancy and child development.', 'Babymind — застосунок для iOS і Android з AI-підказками для батьків. За описом розробників, він аналізує запис плачу й пропонує найімовірнішу причину, а також веде вагітність по тижнях, ріст дитини, сон і календар щеплень. Працює 11 мовами. Підказки застосунку не замінюють консультацію педіатра.', 'Babymind is an iOS and Android app with AI tips for parents. According to the developers, it analyzes a recording of crying and suggests the most likely reason, and also tracks pregnancy week by week, the baby’s growth, sleep and vaccination schedule. Available in 11 languages. Its tips do not replace a pediatrician’s advice.', 'AI-аналіз плачу (за описом)
Вагітність по тижнях
Ріст і сон дитини
Календар щеплень', 'AI cry analysis (per description)
Pregnancy week by week
Growth and sleep tracking
Vaccination calendar', 'Майбутнім і молодим батькам.', 'Expecting and new parents.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'babymind.app' OR LOWER(`name`) = 'babymind') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A parenting app with AI tips: baby cry analysis, pregnancy and child development.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Babymind is an iOS and Android app with AI tips for parents. According to the developers, it analyzes a recording of crying and suggests the most likely reason, and also tracks pregnancy week by week, the baby’s growth, sleep and vaccination schedule. Available in 11 languages. Its tips do not replace a pediatrician’s advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI cry analysis (per description)
Pregnancy week by week
Growth and sleep tracking
Vaccination calendar', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Expecting and new parents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Google Family Link — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'families.google/familylink' OR LOWER(`name`) = 'google family link')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Google Family Link', NULL, 'https://families.google/familylink/', NULL, NULL, 'Батьківський контроль від Google: межі екранного часу, правила застосунків і місцезнаходження для дітей.', 'Parental controls from Google: screen-time limits, app rules and location for kids.', 'Family Link — безкоштовний інструмент Google для батьків, переважно для пристроїв Android: можна встановити межі екранного часу й режим сну, керувати застосунками, налаштуваннями конфіденційності й бачити місцезнаходження дитини. Орієнтований переважно на дітей від 6 років.', 'Family Link is a free Google tool for parents, mainly for Android devices: you can set screen-time limits and downtime, manage apps and privacy settings, and see your child’s location. It is mainly aimed at children aged 6 and up.', 'Межі екранного часу й розклад
Керування застосунками
Місцезнаходження дитини
Налаштування конфіденційності', 'Screen-time limits and schedules
App management
Child location
Privacy settings', 'Батькам дітей, які користуються пристроями Android.', 'Parents of children who use Android devices.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'families.google/familylink' OR LOWER(`name`) = 'google family link') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Parental controls from Google: screen-time limits, app rules and location for kids.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Family Link is a free Google tool for parents, mainly for Android devices: you can set screen-time limits and downtime, manage apps and privacy settings, and see your child’s location. It is mainly aimed at children aged 6 and up.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Screen-time limits and schedules
App management
Child location
Privacy settings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents of children who use Android devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Canopy — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'canopy.us' OR LOWER(`name`) = 'canopy')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Canopy', NULL, 'https://canopy.us', NULL, NULL, 'Батьківський контроль, що за описом використовує AI, щоб фільтрувати неприйнятний вміст на сайтах і в застосунках.', 'Parental controls that, per the developers, use AI to filter inappropriate content on sites and in apps.', 'Canopy, за описом розробників, використовує AI, щоб у реальному часі сканувати й приховувати відвертий вміст на вебсторінках, у соцмережах і AI-чатботах, не блокуючи сайти повністю. Є сповіщення, якщо застосунок намагаються вимкнути, і керування екранним часом. Платні плани з пробним періодом.', 'According to the developers, Canopy uses AI to scan and hide explicit content in real time on web pages, social networks and AI chatbots without blocking entire sites. It alerts you if someone tries to disable it and includes screen-time management. Paid plans with a trial period.', 'AI-фільтр вмісту на сторінках
Фільтр для AI-чатботів
Сповіщення про вимкнення
Керування екранним часом', 'AI content filter on pages
AI chatbot filter
Removal alerts
Screen-time management', 'Батькам, які хочуть фільтрувати вміст, а не блокувати інтернет повністю.', 'Parents who want to filter content rather than block the internet entirely.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'canopy.us' OR LOWER(`name`) = 'canopy') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Parental controls that, per the developers, use AI to filter inappropriate content on sites and in apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'According to the developers, Canopy uses AI to scan and hide explicit content in real time on web pages, social networks and AI chatbots without blocking entire sites. It alerts you if someone tries to disable it and includes screen-time management. Paid plans with a trial period.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI content filter on pages
AI chatbot filter
Removal alerts
Screen-time management', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents who want to filter content rather than block the internet entirely.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OurFamilyWizard — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ourfamilywizard.com' OR LOWER(`name`) = 'ourfamilywizard')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OurFamilyWizard', NULL, 'https://www.ourfamilywizard.com', NULL, NULL, 'Застосунок для спільного батьківства: записи комунікації, придатні як документація, і календар із журналом змін.', 'A co-parenting app: communication records usable as documentation and a calendar with a change log.', 'OurFamilyWizard допомагає батькам, які живуть окремо, координувати опіку над дитиною: повідомлення зберігаються як записи, що можуть слугувати документацією, а спільний календар графіка опіки веде журнал змін. Доступні вебверсія та застосунки для iOS і Android.', 'OurFamilyWizard helps parents who live apart coordinate their child’s care: messages are kept as records that can serve as documentation, and the shared custody calendar keeps a log of changes. Available on the web and as iOS and Android apps.', 'Записи комунікації
Календар опіки з журналом змін
Веб, iOS і Android', 'Communication records
Custody calendar with change log
Web, iOS and Android', 'Батькам, які виховують дитину з різних домівок.', 'Parents raising a child from separate homes.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ourfamilywizard.com' OR LOWER(`name`) = 'ourfamilywizard') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A co-parenting app: communication records usable as documentation and a calendar with a change log.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OurFamilyWizard helps parents who live apart coordinate their child’s care: messages are kept as records that can serve as documentation, and the shared custody calendar keeps a log of changes. Available on the web and as iOS and Android apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Communication records
Custody calendar with change log
Web, iOS and Android', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents raising a child from separate homes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AppClose — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'appclose.com' OR LOWER(`name`) = 'appclose')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AppClose', NULL, 'https://www.appclose.com', NULL, NULL, 'Універсальний застосунок для спільного батьківства з шаблонами графіків опіки й записами комунікації.', 'An all-in-one co-parenting app with custody schedule templates and communication records.', 'AppClose об’єднує для батьків, які живуть окремо, календар опіки з шаблонами графіків, захищені повідомлення й дзвінки та записи комунікації. Працює у вебі та на iOS і Android.', 'AppClose brings together, for parents who live apart, a custody calendar with schedule templates, secure messaging and calls, and communication records. Works on the web, iOS and Android.', 'Шаблони графіків опіки
Захищені повідомлення й дзвінки
Записи комунікації', 'Custody schedule templates
Secure messaging and calls
Communication records', 'Батькам, які спільно виховують дитину окремо.', 'Separated parents co-parenting a child.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'appclose.com' OR LOWER(`name`) = 'appclose') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An all-in-one co-parenting app with custody schedule templates and communication records.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AppClose brings together, for parents who live apart, a custody calendar with schedule templates, secure messaging and calls, and communication records. Works on the web, iOS and Android.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Custody schedule templates
Secure messaging and calls
Communication records', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Separated parents co-parenting a child.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BestInterest — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bestinterest.app' OR LOWER(`name`) = 'bestinterest')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BestInterest', NULL, 'https://bestinterest.app', NULL, NULL, 'Застосунок для спільного батьківства з AI-фільтрацією повідомлень, записами комунікації й спільними графіками.', 'A co-parenting app with AI message filtering, communication records and shared schedules.', 'BestInterest орієнтований на батьків у напружених стосунках: AI фільтрує ворожі повідомлення перед прочитанням і пропонує спокійніші відповіді. Є записи комунікації й спільні графіки; за описом, застосунок працює, навіть якщо другий з батьків не приєднався. Є безкоштовний і платний рівні; iPhone, Android і веб.', 'BestInterest is aimed at parents in high-conflict situations: AI filters hostile messages before you read them and suggests calmer replies. It keeps communication records and shared schedules; according to the description it works even if the other parent does not join. Free and paid tiers; iPhone, Android and web.', 'AI-фільтр ворожих повідомлень
Підказки спокійних відповідей
Записи комунікації
Спільні графіки', 'AI filter for hostile messages
Calm reply suggestions
Communication records
Shared schedules', 'Батькам, які спільно виховують дитину в конфліктній ситуації.', 'Co-parents in high-conflict situations.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bestinterest.app' OR LOWER(`name`) = 'bestinterest') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A co-parenting app with AI message filtering, communication records and shared schedules.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BestInterest is aimed at parents in high-conflict situations: AI filters hostile messages before you read them and suggests calmer replies. It keeps communication records and shared schedules; according to the description it works even if the other parent does not join. Free and paid tiers; iPhone, Android and web.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI filter for hostile messages
Calm reply suggestions
Communication records
Shared schedules', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Co-parents in high-conflict situations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TalkingParents — Виховання дітей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'talkingparents.com' OR LOWER(`name`) = 'talkingparents')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TalkingParents', NULL, 'https://talkingparents.com', NULL, NULL, 'Застосунок для спільного батьківства, що зберігає записи комунікації між батьками.', 'A co-parenting app that keeps records of communication between parents.', 'TalkingParents записує й упорядковує повідомлення, дзвінки, графіки, витрати та інші дані між батьками, які виховують дитину окремо. Записи комунікації зберігаються й доступні для перегляду.', 'TalkingParents records and organizes messages, calls, schedules, expenses and other information between parents raising a child separately. Communication records are kept and available for review.', 'Записані повідомлення й дзвінки
Спільний календар
Облік витрат', 'Recorded messages and calls
Shared calendar
Expense tracking', 'Батькам, які спільно виховують дитину окремо.', 'Separated parents co-parenting a child.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'talkingparents.com' OR LOWER(`name`) = 'talkingparents') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A co-parenting app that keeps records of communication between parents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TalkingParents records and organizes messages, calls, schedules, expenses and other information between parents raising a child separately. Communication records are kept and available for review.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Recorded messages and calls
Shared calendar
Expense tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Separated parents co-parenting a child.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Cozi Family Organizer — Виховання дітей (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cozi.com' OR LOWER(`name`) = 'cozi family organizer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- =================== Дресирування собак ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dog-training' LIMIT 1);

-- Dogo — Дресирування собак (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dogo.app' OR LOWER(`name`) = 'dogo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Zigzag — Дресирування собак
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zigzag.dog' OR LOWER(`name`) = 'zigzag')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Zigzag', NULL, 'https://zigzag.dog', NULL, NULL, 'Застосунок для навчання цуценят за віком і породою з короткими уроками.', 'A puppy training app with short lessons based on age and breed.', 'Zigzag повністю присвячений вихованню цуценят: персональний план із коротких уроків під породу й вік. За описом розробників, програма побудована на 12-тижневій програмі розвитку цуценя за участі сертифікованих фахівців. Є безкоштовний і преміум-рівні.', 'Zigzag is dedicated to puppy training: a personal plan of short lessons tailored to breed and age. According to the developers, it is built on a 12-week puppy development programme with input from certified professionals. Free and premium tiers are available.', 'Персональний план за породою й віком
Короткі уроки
Програма розвитку цуценяти', 'Personal plan by breed and age
Short lessons
Puppy development programme', 'Власникам цуценят.', 'Puppy owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zigzag.dog' OR LOWER(`name`) = 'zigzag') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A puppy training app with short lessons based on age and breed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Zigzag is dedicated to puppy training: a personal plan of short lessons tailored to breed and age. According to the developers, it is built on a 12-week puppy development programme with input from certified professionals. Free and premium tiers are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personal plan by breed and age
Short lessons
Puppy development programme', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Puppy owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Puppr — Дресирування собак (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'puppr.app' OR LOWER(`name`) = 'puppr') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Woofz — Дресирування собак (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'woofz.com' OR LOWER(`name`) = 'woofz') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Pupford — Дресирування собак (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pupford.com' OR LOWER(`name`) = 'pupford') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- PawChamp — Дресирування собак
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'paw-champ.com' OR LOWER(`name`) = 'pawchamp')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PawChamp', NULL, 'https://paw-champ.com', NULL, NULL, 'Персональний план тренувань, поведінки й догляду для собаки будь-якого віку.', 'A personal plan for training, behavior and care for a dog of any age.', 'PawChamp об’єднує тренування, поведінку, здоров’я й догляд в одному персональному плані з покроковими уроками, побудованими на позитивному підкріпленні. За описом, є чат з експертами 24/7 і підтримка AI.', 'PawChamp combines training, behavior, health and care in one personal plan with step-by-step lessons based on positive reinforcement. According to the description, it includes 24/7 chat with experts and AI support.', 'Персональний план
Покрокові уроки
Чат з експертами 24/7 (за описом)
Підтримка AI', 'Personal plan
Step-by-step lessons
24/7 expert chat (per description)
AI support', 'Власникам собак будь-якого віку.', 'Owners of dogs of any age.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'paw-champ.com' OR LOWER(`name`) = 'pawchamp') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A personal plan for training, behavior and care for a dog of any age.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PawChamp combines training, behavior, health and care in one personal plan with step-by-step lessons based on positive reinforcement. According to the description, it includes 24/7 chat with experts and AI support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personal plan
Step-by-step lessons
24/7 expert chat (per description)
AI support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Owners of dogs of any age.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Doggy Time — Дресирування собак
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'doggytime.app' OR LOWER(`name`) = 'doggy time')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Doggy Time', NULL, 'https://doggytime.app', NULL, NULL, 'Відстеження рутин собаки: туалет, прогулянки, годування й тренування.', 'Tracking a dog’s routines: potty, walks, feeding and training.', 'Doggy Time допомагає вести щоденні записи про собаку — туалет, прогулянки, годування, тренування, а також нагадування про щеплення. Записами можна ділитися з родиною; підтримуються й інші тварини.', 'Doggy Time helps keep daily records about your dog — potty, walks, feeding, training, plus vaccination reminders. Records can be shared with family members; other pets are supported too.', 'Журнал туалету й прогулянок
Годування й тренування
Нагадування
Спільний доступ для родини', 'Potty and walk log
Feeding and training
Reminders
Family sharing', 'Власникам собак, особливо цуценят.', 'Dog owners, especially of puppies.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'doggytime.app' OR LOWER(`name`) = 'doggy time') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tracking a dog’s routines: potty, walks, feeding and training.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Doggy Time helps keep daily records about your dog — potty, walks, feeding, training, plus vaccination reminders. Records can be shared with family members; other pets are supported too.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Potty and walk log
Feeding and training
Reminders
Family sharing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dog owners, especially of puppies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hundeo — Дресирування собак
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hundeo.com/en' OR LOWER(`name`) = 'hundeo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hundeo', NULL, 'https://www.hundeo.com/en/', NULL, NULL, 'Персональні плани навчання собаки з відстеженням прогресу, іграми й покроковими відеокурсами.', 'Personal dog training plans with progress tracking, games and step-by-step video courses.', 'Hundeo складає персональний план тренувань під собаку, її вік і ваші цілі та пропонує щодня одну вправу. Є понад 30 курсів із покроковими відео, ігри й інструменти відстеження прогресу.', 'Hundeo builds a personal training plan for your dog, its age and your goals and suggests one exercise a day. It offers 30+ courses with step-by-step videos, games and progress tracking.', 'Персональний план
Понад 30 відеокурсів
Ігри
Відстеження прогресу', 'Personal plan
30+ video courses
Games
Progress tracking', 'Власникам цуценят і дорослих собак.', 'Owners of puppies and adult dogs.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hundeo.com/en' OR LOWER(`name`) = 'hundeo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Personal dog training plans with progress tracking, games and step-by-step video courses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hundeo builds a personal training plan for your dog, its age and your goals and suggests one exercise a day. It offers 30+ courses with step-by-step videos, games and progress tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personal plan
30+ video courses
Games
Progress tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Owners of puppies and adult dogs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Pup to Date — Дресирування собак
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/pup-to-date-puppy-schedule/id1515338968' OR LOWER(`name`) = 'pup to date')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pup to Date', NULL, 'https://apps.apple.com/us/app/pup-to-date-puppy-schedule/id1515338968', NULL, NULL, 'Режим цуценяти: туалет, годування, ліки й нагадування; є застосунок для Apple Watch.', 'A puppy schedule: potty, feeding, meds and reminders; includes an Apple Watch app.', 'Pup to Date допомагає тримати режим цуценяти: видно, коли собака востаннє виходила в туалет, їла чи отримувала ліки. Є повторювані нагадування, календар, віджети, кілька профілів собак і, за описом, застосунок для Apple Watch.', 'Pup to Date helps keep a puppy’s schedule: you see when the dog last went out, ate or got its medication. It offers recurring reminders, a calendar, widgets, multiple dog profiles and, per the description, an Apple Watch app.', 'Журнал туалету, годування й ліків
Нагадування
Календар і віджети
Apple Watch', 'Potty, feeding and meds log
Reminders
Calendar and widgets
Apple Watch', 'Власникам цуценят з iPhone.', 'Puppy owners with an iPhone.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/pup-to-date-puppy-schedule/id1515338968' OR LOWER(`name`) = 'pup to date') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A puppy schedule: potty, feeding, meds and reminders; includes an Apple Watch app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Pup to Date helps keep a puppy’s schedule: you see when the dog last went out, ate or got its medication. It offers recurring reminders, a calendar, widgets, multiple dog profiles and, per the description, an Apple Watch app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Potty, feeding and meds log
Reminders
Calendar and widgets
Apple Watch', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Puppy owners with an iPhone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- iTrainer Dog Whistle & Clicker — Дресирування собак
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/itrainer-dog-whistle-clicker/id1147215836' OR LOWER(`name`) = 'itrainer dog whistle & clicker')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'iTrainer Dog Whistle & Clicker', NULL, 'https://apps.apple.com/us/app/itrainer-dog-whistle-clicker/id1147215836', NULL, NULL, 'Безкоштовний свисток і клікер для дресирування собак на iPhone.', 'A free dog whistle and training clicker for iPhone.', 'iTrainer поєднує високочастотний свисток із налаштуванням частоти, тренувальний клікер, звуки іграшок-пищалок і понад 100 звуків тварин. Є довідники з тренування, віджети й застосунок для Apple Watch.', 'iTrainer combines a high-frequency whistle with adjustable frequency, a training clicker, squeaky-toy sounds and 100+ animal sounds. It includes training guides, widgets and an Apple Watch app.', 'Свисток із налаштуванням частоти
Тренувальний клікер
Звуки іграшок і тварин
Apple Watch', 'Whistle with adjustable frequency
Training clicker
Toy and animal sounds
Apple Watch', 'Власникам собак, які тренують із клікером.', 'Dog owners who use clicker training.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/itrainer-dog-whistle-clicker/id1147215836' OR LOWER(`name`) = 'itrainer dog whistle & clicker') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free dog whistle and training clicker for iPhone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'iTrainer combines a high-frequency whistle with adjustable frequency, a training clicker, squeaky-toy sounds and 100+ animal sounds. It includes training guides, widgets and an Apple Watch app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Whistle with adjustable frequency
Training clicker
Toy and animal sounds
Apple Watch', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dog owners who use clicker training.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Робочі та службові собаки ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'working-dogs' LIMIT 1);

-- DogBase — Робочі та службові собаки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dogbase.co' OR LOWER(`name`) = 'dogbase')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DogBase', NULL, 'https://dogbase.co', NULL, NULL, 'Платформа навчання й управління командами професійних робочих собак: SAR, правоохоронці, детекція.', 'A training and team management platform for professional working dogs: SAR, law enforcement, detection.', 'DogBase призначена для команд з робочими собаками — пошуково-рятувальних, правоохоронних, спортивних і службових. Вона дає змогу швидко логувати сесії й виїзди, вести облік здоров’я, сертифікацій і результатів, отримувати AI-підсумки й підказки, створювати власні типи тренувань, експортувати PDF і працювати в групах. За словами розробників, платформу використовують команди у понад 30 країнах; версія 2 вийшла у квітні 2026 року.', 'DogBase is built for working-dog teams — search and rescue, law enforcement, sport and service. It lets you quickly log sessions and deployments, track health, certifications and results, get AI summaries and hints, create custom training types, export PDFs and collaborate in groups. According to the developers, teams in more than 30 countries use it; version 2 was released in April 2026.', 'Швидке логування сесій і виїздів
Облік здоров’я й сертифікацій
AI-підсумки й підказки
Експорт у PDF, групи', 'Fast session and deployment logging
Health and certification records
AI summaries and hints
PDF export, groups', 'Кінологам і командам із робочими собаками.', 'Handlers and teams working with working dogs.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dogbase.co' OR LOWER(`name`) = 'dogbase') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A training and team management platform for professional working dogs: SAR, law enforcement, detection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DogBase is built for working-dog teams — search and rescue, law enforcement, sport and service. It lets you quickly log sessions and deployments, track health, certifications and results, get AI summaries and hints, create custom training types, export PDFs and collaborate in groups. According to the developers, teams in more than 30 countries use it; version 2 was released in April 2026.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fast session and deployment logging
Health and certification records
AI summaries and hints
PDF export, groups', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Handlers and teams working with working dogs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- K9Codex (SYSTALOG) — Робочі та службові собаки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'systalog.ai/k9-training-software' OR LOWER(`name`) = 'k9codex (systalog)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'K9Codex (SYSTALOG)', NULL, 'https://www.systalog.ai/k9-training-software', NULL, NULL, 'Облік тренувань, сертифікацій, виїздів і готовності службових собак з журналом аудиту (раніше K9 Manager).', 'Records of training, certifications, deployments and readiness of working dogs with an audit log (formerly K9 Manager).', 'K9Codex від SYSTALOG.ai (раніше K9 Manager) веде облік тренувань, сертифікацій, виїздів, кінологів і готовності собак із журналом аудиту. Ролі розділяють польовий запис, нагляд і адміністрування. Розрахований на правоохоронні служби, охоронні структури, пошуково-рятувальні команди й академії, а також на окремих кінологів.', 'K9Codex by SYSTALOG.ai (formerly K9 Manager) records training, certifications, deployments, handlers and dog readiness with an audit log. Roles separate field logging, supervision and administration. Built for law enforcement, security organizations, search and rescue teams and academies, as well as individual handlers.', 'Облік тренувань і виїздів
Сертифікації й готовність
Журнал аудиту
Ролі: поле, нагляд, адміністрування', 'Training and deployment records
Certifications and readiness
Audit log
Roles: field, supervision, admin', 'Кінологічним підрозділам і командам.', 'K9 units and teams.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'systalog.ai/k9-training-software' OR LOWER(`name`) = 'k9codex (systalog)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Records of training, certifications, deployments and readiness of working dogs with an audit log (formerly K9 Manager).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'K9Codex by SYSTALOG.ai (formerly K9 Manager) records training, certifications, deployments, handlers and dog readiness with an audit log. Roles separate field logging, supervision and administration. Built for law enforcement, security organizations, search and rescue teams and academies, as well as individual handlers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Training and deployment records
Certifications and readiness
Audit log
Roles: field, supervision, admin', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'K9 units and teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- RAM K9 Training: Dog Logbook — Робочі та службові собаки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rayallen.com/app' OR LOWER(`name`) = 'ram k9 training: dog logbook')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RAM K9 Training: Dog Logbook', NULL, 'https://www.rayallen.com/app', NULL, NULL, 'Логбук для робочих собак від Ray Allen Manufacturing: кілька собак, експорт CSV, каталог матеріалів.', 'A working-dog logbook from Ray Allen Manufacturing: multiple dogs, CSV export, materials catalog.', 'RAM K9 Training — застосунок для кінологів поліції, військових і пошуково-рятувальних команд: розклад і журнал тренувань (дата, місце, тривалість, мета, нотатки, фото), облік кількох собак і спорядження, експорт CSV і каталог навчальних матеріалів. Відгуки користувачів неоднозначні: частина називає застосунок надто простим.', 'RAM K9 Training is an app for police, military and search-and-rescue handlers: scheduling and training logs (date, location, duration, goal, notes, photos), multiple dogs and gear records, CSV export and a catalog of training materials. User reviews are mixed: some call the app too basic.', 'Журнал тренувань із фото
Кілька собак і спорядження
Експорт CSV
Каталог матеріалів', 'Training log with photos
Multiple dogs and gear
CSV export
Materials catalog', 'Кінологам службових і пошукових собак.', 'Handlers of service and search dogs.', 'mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rayallen.com/app' OR LOWER(`name`) = 'ram k9 training: dog logbook') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A working-dog logbook from Ray Allen Manufacturing: multiple dogs, CSV export, materials catalog.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'RAM K9 Training is an app for police, military and search-and-rescue handlers: scheduling and training logs (date, location, duration, goal, notes, photos), multiple dogs and gear records, CSV export and a catalog of training materials. User reviews are mixed: some call the app too basic.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Training log with photos
Multiple dogs and gear
CSV export
Materials catalog', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Handlers of service and search dogs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PackTrack — Робочі та службові собаки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'packtrackapp.com' OR LOWER(`name`) = 'packtrack')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PackTrack', NULL, 'https://packtrackapp.com', NULL, NULL, 'Облік тренувань і виїздів правоохоронних K9 із GPS-треками й картою кінологів для керівників.', 'Training and deployment records for law-enforcement K9 with GPS tracks and a handler map for supervisors.', 'PackTrack — система обліку для правоохоронних кінологічних підрозділів: слухняність, спритність, затримання, пошуки, слідова робота й виявлення. Записи синхронізуються між пристроями, GPS фіксує маршрут, а керівники переглядають і затверджують записи та бачать кінологів на карті. Безкоштовні акаунти є для тренерів і керівників; застосунок оновлювався у 2025 році.', 'PackTrack is a record-keeping system for law-enforcement K9 units: obedience, agility, apprehension, searches, tracking and detection. Records sync across devices, GPS captures the route, and supervisors review and approve records and see handlers on a map. Free accounts are available for trainers and supervisors; the app was updated in 2025.', 'Облік тренувань і виїздів
GPS-треки
Затвердження записів керівником
Карта кінологів', 'Training and deployment records
GPS tracks
Supervisor approval
Handler map', 'Правоохоронним кінологічним підрозділам.', 'Law-enforcement K9 units.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'packtrackapp.com' OR LOWER(`name`) = 'packtrack') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Training and deployment records for law-enforcement K9 with GPS tracks and a handler map for supervisors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PackTrack is a record-keeping system for law-enforcement K9 units: obedience, agility, apprehension, searches, tracking and detection. Records sync across devices, GPS captures the route, and supervisors review and approve records and see handlers on a map. Free accounts are available for trainers and supervisors; the app was updated in 2025.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Training and deployment records
GPS tracks
Supervisor approval
Handler map', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Law-enforcement K9 units.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DogTracks — Робочі та службові собаки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=se.nabo.dogtracks' OR LOWER(`name`) = 'dogtracks')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DogTracks', NULL, 'https://play.google.com/store/apps/details?id=se.nabo.dogtracks', NULL, NULL, 'Планування, запис і аналіз слідової роботи: мантрейлінг, IGP, слід по крові.', 'Planning, recording and analysis of tracking work: mantrailing, IGP, blood tracking.', 'DogTracks допомагає планувати й записувати слідову роботу собаки: GPS-трек, довжина, час і розташування предметів. Треки прокладача й собаки можна накласти на карті, щоб проаналізувати проходження. Підходить для мантрейлінгу, IGP і сліду по крові.', 'DogTracks helps plan and record a dog’s tracking work: GPS track, length, time and article positions. The layer’s and the dog’s tracks can be overlaid on a map to analyze the run. Suitable for mantrailing, IGP and blood tracking.', 'GPS-запис треку
Предмети на сліді
Накладання треків на карті
Аналіз проходження', 'GPS track recording
Articles on the track
Track overlay on map
Run analysis', 'Кінологам і спортсменам зі слідової роботи.', 'Handlers and sport trainers doing tracking work.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=se.nabo.dogtracks' OR LOWER(`name`) = 'dogtracks') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Planning, recording and analysis of tracking work: mantrailing, IGP, blood tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DogTracks helps plan and record a dog’s tracking work: GPS track, length, time and article positions. The layer’s and the dog’s tracks can be overlaid on a map to analyze the run. Suitable for mantrailing, IGP and blood tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'GPS track recording
Articles on the track
Track overlay on map
Run analysis', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Handlers and sport trainers doing tracking work.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- tracking-dog — Робочі та службові собаки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/tracking-dog-2026/id6476980182' OR LOWER(`name`) = 'tracking-dog')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'tracking-dog', NULL, 'https://apps.apple.com/us/app/tracking-dog-2026/id6476980182', NULL, NULL, 'Застосунок для iPhone від Doegel GmbH: GPS-треки, предмети на треку, аналіз точності, місцевість і погода.', 'An iPhone app by Doegel GmbH: GPS tracks, articles on the track, accuracy analysis, terrain and weather.', 'tracking-dog зберігає GPS-треки тренувань, дає змогу позначати предмети на треку, аналізувати точність проходження й фіксувати дані про місцевість і погоду. Розроблений для рятувальних собак, слідової роботи, IGP і мантрейлінгу, а також для фахівців рятувальних служб, пожежників і поліції.', 'tracking-dog stores GPS training tracks, lets you mark articles on the track, analyze how accurately the dog followed it and record terrain and weather. Made for rescue dogs, tracking, IGP and mantrailing, as well as rescue services, firefighters and police.', 'GPS-треки
Предмети на треку
Аналіз точності
Дані про місцевість і погоду', 'GPS tracks
Articles on the track
Accuracy analysis
Terrain and weather data', 'Рятувальникам, кінологам і спортсменам зі слідової роботи.', 'Rescue teams, handlers and tracking sport enthusiasts.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/tracking-dog-2026/id6476980182' OR LOWER(`name`) = 'tracking-dog') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An iPhone app by Doegel GmbH: GPS tracks, articles on the track, accuracy analysis, terrain and weather.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'tracking-dog stores GPS training tracks, lets you mark articles on the track, analyze how accurately the dog followed it and record terrain and weather. Made for rescue dogs, tracking, IGP and mantrailing, as well as rescue services, firefighters and police.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'GPS tracks
Articles on the track
Accuracy analysis
Terrain and weather data', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Rescue teams, handlers and tracking sport enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Gingr — Робочі та службові собаки (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gingrapp.com' OR LOWER(`name`) = 'gingr') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- PupManager — Робочі та службові собаки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pupmanager.com' OR LOWER(`name`) = 'pupmanager')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PupManager', NULL, 'https://pupmanager.com', NULL, NULL, 'ПЗ для професійних кінологів: розклад, нотатки, відео домашніх завдань, групові заняття, брендований застосунок.', 'Software for professional dog trainers: scheduling, notes, homework videos, group classes, a branded client app.', 'PupManager допомагає кінологам, біхевіористам і доглядачам вести бізнес: розклад, нотатки по клієнтах і собаках, відео домашніх завдань, групові заняття й пакети. Клієнти отримують брендований застосунок (iOS, Android, веб); є інтеграції зі Stripe, Xero і Google Calendar.', 'PupManager helps trainers, behaviourists and pet carers run their business: scheduling, client and dog notes, homework videos, group classes and packages. Clients get a branded app (iOS, Android, web); integrations include Stripe, Xero and Google Calendar.', 'Розклад і пакети
Нотатки по клієнтах і собаках
Відео домашніх завдань
Брендований застосунок для клієнтів', 'Scheduling and packages
Client and dog notes
Homework videos
Branded client app', 'Професійним кінологам і бізнесу з догляду за собаками.', 'Professional dog trainers and dog care businesses.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pupmanager.com' OR LOWER(`name`) = 'pupmanager') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Software for professional dog trainers: scheduling, notes, homework videos, group classes, a branded client app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PupManager helps trainers, behaviourists and pet carers run their business: scheduling, client and dog notes, homework videos, group classes and packages. Clients get a branded app (iOS, Android, web); integrations include Stripe, Xero and Google Calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Scheduling and packages
Client and dog notes
Homework videos
Branded client app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professional dog trainers and dog care businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Heeldash — Робочі та службові собаки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'heeldash.com' OR LOWER(`name`) = 'heeldash')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Heeldash', NULL, 'https://www.heeldash.com', NULL, NULL, 'ПЗ для тренерів, побудоване навколо сесій: оцінювання вправ, графіки прогресу, клієнтський портал.', 'Trainer software built around sessions: exercise scoring, progress charts, a client portal.', 'Heeldash, за описом розробника, будує облік навколо тренувальних сесій: кожна вправа оцінюється, а графіки показують, чи покращується собака. Клієнти бачать прогрес у власному порталі. Є пробний період.', 'According to the developer, Heeldash builds records around training sessions: each exercise is scored and charts show whether the dog is improving. Clients see progress in their own portal. A trial period is available.', 'Оцінювання вправ
Графіки прогресу
Клієнтський портал', 'Exercise scoring
Progress charts
Client portal', 'Професійним тренерам собак.', 'Professional dog trainers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'heeldash.com' OR LOWER(`name`) = 'heeldash') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Trainer software built around sessions: exercise scoring, progress charts, a client portal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'According to the developer, Heeldash builds records around training sessions: each exercise is scored and charts show whether the dog is improving. Clients see progress in their own portal. A trial period is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Exercise scoring
Progress charts
Client portal', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professional dog trainers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MoeGo — Робочі та службові собаки (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moego.pet' OR LOWER(`name`) = 'moego') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- PetPocketbook — Робочі та службові собаки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petpocketbook.com' OR LOWER(`name`) = 'petpocketbook')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PetPocketbook', NULL, 'https://www.petpocketbook.com', NULL, NULL, 'Керування клієнтами для кінологів і вигульників: планування, облік, рахунки й комунікація.', 'Client management for dog trainers and walkers: scheduling, records, billing and communication.', 'PetPocketbook — ПЗ для бізнесу з догляду за собаками, створене з розрахунку на роботу з телефона: планування занять і візитів, автоматичні рахунки та комунікація з клієнтами. За оглядом, підходить і кінологам для відстеження домашніх завдань.', 'PetPocketbook is software for dog care businesses designed mobile-first: scheduling sessions and visits, automated billing and client communication. According to a review, it also suits trainers for tracking homework.', 'Планування
Автоматичні рахунки
Комунікація з клієнтами', 'Scheduling
Automated billing
Client communication', 'Кінологам і вигульникам собак.', 'Dog trainers and dog walkers.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petpocketbook.com' OR LOWER(`name`) = 'petpocketbook') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Client management for dog trainers and walkers: scheduling, records, billing and communication.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PetPocketbook is software for dog care businesses designed mobile-first: scheduling sessions and visits, automated billing and client communication. According to a review, it also suits trainers for tracking homework.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Scheduling
Automated billing
Client communication', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dog trainers and dog walkers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Time To Pet — Робочі та службові собаки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'timetopet.com' OR LOWER(`name`) = 'time to pet')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Time To Pet', NULL, 'https://www.timetopet.com', NULL, NULL, 'ПЗ для керування бізнесом з догляду за тваринами з клієнтським порталом.', 'Pet care business management software with a client portal.', 'Time To Pet допомагає бізнесу з догляду за тваринами (вигул, перетримка, дейкер, грумінг) керувати розкладом, рахунками, платежами, персоналом і комунікацією з клієнтами, які мають власний портал. Є мобільні застосунки.', 'Time To Pet helps pet care businesses (walking, sitting, daycare, grooming) manage scheduling, invoicing, payments, staff and communication with clients, who get their own portal. Mobile apps are available.', 'Розклад і персонал
Рахунки й платежі
Клієнтський портал
Мобільні застосунки', 'Scheduling and staff
Invoicing and payments
Client portal
Mobile apps', 'Бізнесу з догляду за тваринами.', 'Pet care businesses.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'timetopet.com' OR LOWER(`name`) = 'time to pet') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Pet care business management software with a client portal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Time To Pet helps pet care businesses (walking, sitting, daycare, grooming) manage scheduling, invoicing, payments, staff and communication with clients, who get their own portal. Mobile apps are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Scheduling and staff
Invoicing and payments
Client portal
Mobile apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pet care businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- RunLoyal — Робочі та службові собаки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'runloyal.com' OR LOWER(`name`) = 'runloyal')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RunLoyal', NULL, 'https://www.runloyal.com', NULL, NULL, 'ПЗ для бізнесу з догляду за тваринами: брендовані застосунки, кіоски реєстрації, аналітика.', 'Pet care business software: branded apps, check-in kiosks, analytics.', 'RunLoyal пропонує бізнесу з догляду за тваринами (перетримка, дейкер, грумінг, дресирування) бізнес-портал, брендовані застосунки для клієнтів і персоналу, кіоски швидкої реєстрації й аналітику.', 'RunLoyal gives pet care businesses (boarding, daycare, grooming, training) a business portal, branded apps for clients and staff, express check-in kiosks and analytics.', 'Брендовані застосунки
Кіоски реєстрації
Аналітика
Бізнес-портал', 'Branded apps
Check-in kiosks
Analytics
Business portal', 'Бізнесу з догляду за тваринами й дресирування.', 'Pet care and training businesses.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-12 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'runloyal.com' OR LOWER(`name`) = 'runloyal') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Pet care business software: branded apps, check-in kiosks, analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'RunLoyal gives pet care businesses (boarding, daycare, grooming, training) a business portal, branded apps for clients and staff, express check-in kiosks and analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Branded apps
Check-in kiosks
Analytics
Business portal', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pet care and training businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

