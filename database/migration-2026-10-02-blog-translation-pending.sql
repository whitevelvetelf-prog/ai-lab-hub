-- AI LAB HUB — 2026-10-02: напис «переклад статті ще готується» для блогу
-- (public/blog.php, public/blog-post.php; ключ blog_translation_pending у app/translations.php).
-- Застосування: phpMyAdmin → SQL → вставити → Вперёд. Повторний запуск безпечний.
SET NAMES utf8mb4;

INSERT IGNORE INTO `ui_translations` (`key_name`, `lang`, `translated_text`, `source`) VALUES
('blog_translation_pending', 'en', 'The English translation of this article is still in progress — showing the Ukrainian version for now.', 'manual');
