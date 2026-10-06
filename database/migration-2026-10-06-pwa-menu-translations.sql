SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — 2026-10-06: ручні EN-переклади пункту «Встановити додаток» у мобільному меню.
--   pwa_menu_label — підпис пункту меню
--   pwa_other_hint — інструкція для браузерів без системного діалогу встановлення
-- Застосування: phpMyAdmin → БД → «Импорт» / вкладка SQL. Повторний запуск безпечний.
-- =====================================================================

INSERT INTO `ui_translations` (`key_name`, `lang`, `translated_text`, `source`) VALUES
('pwa_menu_label', 'en', 'Install the app', 'manual'),
('pwa_other_hint', 'en', 'To install AI LAB HUB as an app: open the browser menu (⋮ or ☰) and choose “Install app” or “Add to Home screen”.', 'manual')
ON DUPLICATE KEY UPDATE `translated_text` = VALUES(`translated_text`), `source` = 'manual';
