-- AI LAB HUB — 2026-10-02: бейдж «Ціна не вказана» для продуктів без жодного тарифу
-- (public/catalog.php, public/saved.php — price_badge(); ключ price_not_specified у app/translations.php).
-- Застосування: phpMyAdmin → SQL → вставити → Вперёд. Повторний запуск безпечний.
SET NAMES utf8mb4;

INSERT IGNORE INTO `ui_translations` (`key_name`, `lang`, `translated_text`, `source`) VALUES
('price_not_specified', 'en', 'Price not specified', 'manual');
