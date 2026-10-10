-- AI LAB HUB — 2026-10-09: фільтр статей блогу за тематикою (категорія / підкатегорія каталогу)
-- (public/blog.php; ключі blog_topics_label, blog_topic_all, blog_topic_all_in_category у app/translations.php).
-- Застосування: phpMyAdmin → SQL → вставити → Вперёд. Повторний запуск безпечний.
SET NAMES utf8mb4;

INSERT INTO `ui_translations` (`key_name`, `lang`, `translated_text`, `source`) VALUES
('blog_topics_label', 'en', 'Article topics', 'manual'),
('blog_topic_all', 'en', 'All topics', 'manual'),
('blog_topic_all_in_category', 'en', 'Whole category', 'manual')
ON DUPLICATE KEY UPDATE `translated_text` = VALUES(`translated_text`), `source` = VALUES(`source`);
