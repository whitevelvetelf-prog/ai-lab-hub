SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — 2026-10-30: блок «Статті на цю тему» на сторінці продукту (public/product.php)
-- Англійський напис заголовка блоку (ui_translations, ключ product_related_articles_title, manual),
-- щоб не покладатися на автопереклад. Повторний запуск безпечний (INSERT IGNORE).
-- Застосування: phpMyAdmin → БД → «Импорт».
-- =====================================================================

INSERT IGNORE INTO `ui_translations` (`key_name`, `lang`, `translated_text`, `source`) VALUES
('product_related_articles_title', 'en', 'Related articles', 'manual');
