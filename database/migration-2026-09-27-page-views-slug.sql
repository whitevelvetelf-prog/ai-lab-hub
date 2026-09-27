-- =====================================================================
-- AI LAB HUB — міграція: slug сторінки в page_views (топ статей блогу)
--
--   page_views.page_slug — ідентифікатор сторінки, що живе не в БД, а у
--   файлах (статті блогу: content/blog/, реєстр BLOG_ARTICLES в
--   app/blog.php), тож числового page_id не має. public/blog-post.php
--   пише сюди slug статті (page_type = 'article'); public/admin-stats.php
--   будує з нього «Топ-10 статей блогу за переглядами».
--
--   Перегляди статей, записані до цієї міграції, мають page_slug = NULL:
--   вони враховуються в загальній картці «Перегляди статей блогу», але не
--   в топі по статтях.
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL.
--   * локально: mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-27-page-views-slug.sql
--
--   Безпечно повторно застосовувати: колонка й індекс додаються лише
--   якщо їх ще немає. Жодних DROP / DELETE.
-- =====================================================================

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS
              WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'page_views'
                AND COLUMN_NAME = 'page_slug') = 0,
  'ALTER TABLE `page_views` ADD COLUMN `page_slug` VARCHAR(191) NULL AFTER `page_id`',
  'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.STATISTICS
              WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'page_views'
                AND INDEX_NAME = 'idx_page_views_type_slug') = 0,
  'ALTER TABLE `page_views` ADD KEY `idx_page_views_type_slug` (`page_type`, `page_slug`)',
  'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;
