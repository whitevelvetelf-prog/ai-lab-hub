SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція: нативна реклама в списках 2026-10-21
--
-- Вставити ЯК Є у phpMyAdmin (вкладка SQL або «Импорт»). Безпечно повторювати:
-- лише CREATE TABLE IF NOT EXISTS, додавання колонок/індексів через
-- information_schema + PREPARE (працює і на MySQL, і на MariaDB), UPDATE
-- налаштувань та INSERT ... ON DUPLICATE KEY UPDATE. Жодних DROP / TRUNCATE.
-- =====================================================================

-- ---------------------------------------------------------------------
-- Етап 1. Нативні картки в списках.
-- ---------------------------------------------------------------------

-- Переклад заголовка й підпису креативів (система перекладу сайту,
-- app/translation-cache.php). ad_translations прив'язана зовнішнім ключем
-- до старої таблиці ads, тож для ad_creatives — окрема таблиця тієї ж будови.
CREATE TABLE IF NOT EXISTS ad_creative_translations (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    creative_id     INT NOT NULL,
    field_name      VARCHAR(50) NOT NULL,
    lang            VARCHAR(5) NOT NULL,
    translated_text MEDIUMTEXT NOT NULL,
    source          ENUM('auto', 'manual') NOT NULL DEFAULT 'auto',
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_creative_field_lang (creative_id, field_name, lang),
    CONSTRAINT fk_ad_creative_translations_creative
        FOREIGN KEY (creative_id) REFERENCES ad_creatives (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Місця-списки: нативна картка на 3-й позиції, далі кожні 8 елементів, до 2 на сторінку
-- (app/ad-card.php → promo_placement_positions). Розділи маркетплейсу — теж у списку,
-- а не окремим блоком над ним.
UPDATE ad_placements SET position_rule = '{"position":3,"every":8}', slots_per_page = 2,
    description_uk = 'Нативна картка в сітці підкатегорій: 3-тя позиція, далі кожні 8 карток, до 2 на сторінку.',
    description_en = 'A native card in the subcategory grid: 3rd position, then every 8 cards, up to 2 per page.'
 WHERE placement_key = 'category_page';
UPDATE ad_placements SET position_rule = '{"position":3,"every":8}', slots_per_page = 2,
    description_uk = 'Нативна картка серед продуктів підкатегорії: 3-тя позиція, далі кожні 8 карток, до 2 на сторінку.',
    description_en = 'A native card among the subcategory products: 3rd position, then every 8 cards, up to 2 per page.'
 WHERE placement_key = 'subcategory_list';
UPDATE ad_placements SET position_rule = '{"position":3,"every":8}', slots_per_page = 2,
    description_uk = 'Нативна картка в результатах пошуку й добірках каталогу: 3-тя позиція, далі кожні 8 карток, до 2 на сторінку.',
    description_en = 'A native card in search results and catalog collections: 3rd position, then every 8 cards, up to 2 per page.'
 WHERE placement_key = 'search_results';
UPDATE ad_placements SET position_rule = '{"position":3,"every":8}', slots_per_page = 2,
    description_uk = 'Нативна картка в стрічці оголошень: 3-тя позиція, далі кожні 8 карток, до 2 на сторінку.',
    description_en = 'A native card in the listings feed: 3rd position, then every 8 cards, up to 2 per page.'
 WHERE placement_key = 'marketplace_feed';
UPDATE ad_placements SET position_rule = '{"position":3,"every":8}', slots_per_page = 2,
    description_uk = 'Нативна картка в результатах пошуку й фільтрів маркетплейсу: 3-тя позиція, далі кожні 8 карток, до 2 на сторінку.',
    description_en = 'A native card in marketplace search and filter results: 3rd position, then every 8 cards, up to 2 per page.'
 WHERE placement_key = 'marketplace_search';
UPDATE ad_placements SET position_rule = '{"position":3,"every":8}', slots_per_page = 2,
    description_uk = 'Нативна картка в списках розділів (вакансії, курси, послуги, оголошення, готові рішення): 3-тя позиція, далі кожні 8 карток, до 2 на сторінку.',
    description_en = 'A native card in section lists (jobs, courses, services, listings, ready-made solutions): 3rd position, then every 8 cards, up to 2 per page.'
 WHERE placement_key = 'marketplace_category';

-- ---------------------------------------------------------------------
-- Етап 2. Зображення й короткі відео.
-- ---------------------------------------------------------------------

-- Тип медіа креативу — наявна колонка ad_creatives.creative_type (VARCHAR):
-- 'video' (відео: video_type upload/youtube, video_path, video_url, poster_path),
-- 'image' (зображення в poster_path, без відео), 'card' (власна реклама без медіа).
-- Вага для зваженого вибору серед платних (на старті всі = 1).
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_creatives' AND COLUMN_NAME = 'weight') = 0,
  'ALTER TABLE ad_creatives ADD COLUMN weight INT NOT NULL DEFAULT 1 AFTER creative_type', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Короткі ролики: до 15 с і до 5 МБ (перевірка при завантаженні, app/promo-advertiser.php).
INSERT INTO ad_settings (setting_key, setting_value) VALUES ('max_video_sec', '15'), ('max_video_mb', '5')
  ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);
