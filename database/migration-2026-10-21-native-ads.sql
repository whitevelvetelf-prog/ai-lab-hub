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
