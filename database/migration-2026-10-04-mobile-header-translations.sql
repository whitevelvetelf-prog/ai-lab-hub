SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — 2026-10-04: ручні EN-переклади нових написів мобільної шапки.
--   nav_menu_toggle — текстовий перемикач мобільного меню (UA «Вхід» → EN «Menu»)
--   pwa_*           — кнопка «Додаток» (встановлення PWA) та інструкція для iOS
-- Застосування: phpMyAdmin → БД → «Импорт» / вкладка SQL. Повторний запуск безпечний
-- (ON DUPLICATE KEY оновлює лише ці ключі й позначає їх як manual).
-- =====================================================================

INSERT INTO `ui_translations` (`key_name`, `lang`, `translated_text`, `source`) VALUES
('nav_menu_toggle', 'en', 'Menu', 'manual'),
('pwa_app_button', 'en', 'App', 'manual'),
('pwa_app_aria', 'en', 'Install the AI LAB HUB app', 'manual'),
('pwa_ios_hint', 'en', 'To install AI LAB HUB as an app: in Safari tap “Share”, then “Add to Home Screen”.', 'manual'),
('pwa_ios_ok', 'en', 'Got it', 'manual'),
('pwa_close', 'en', 'Close', 'manual')
ON DUPLICATE KEY UPDATE `translated_text` = VALUES(`translated_text`), `source` = 'manual';
