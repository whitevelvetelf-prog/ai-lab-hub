-- =====================================================================
-- AI LAB HUB — міграція 2026-10-16: перемикач «Marketplace для відвідувачів» (етап 0, блок 2)
--
--   site_settings.marketplace_public = '0' — поки вітрина порожня, Marketplace прихований:
--   немає в меню, підвалі, на головній і в рекламі; прямі адреси показують сторінку «Скоро»
--   з noindex (app/marketplace.php). Співробітники бачать розділ як раніше.
--   Перемикач — account.php → CRM (лише admin). INSERT IGNORE: наявне значення не змінюється.
--
--   Плюс EN-підписи сторінки «Скоро» й перемикача (ui_translations, source='manual').
--
-- Лише INSERT IGNORE / INSERT … ON DUPLICATE KEY UPDATE. Жодних DROP / TRUNCATE.
-- Застосування: phpMyAdmin → БД → вкладка SQL → вставити файл → Вперёд.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO site_settings (setting_key, setting_value) VALUES ('marketplace_public', '0');

INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('mp_soon_title', 'en', 'Marketplace is coming soon', 'manual'),
('mp_soon_text', 'en', 'We are preparing a section with ready-made AI solutions and listings. In the meantime, browse the AI tools catalog or ask our assistant Elya.', 'manual'),
('mp_soon_contact', 'en', 'Want to place your solution or an ad? Write to us:', 'manual'),
('mp_soon_catalog', 'en', 'Go to the catalog', 'manual'),
('mp_soon_advertise', 'en', 'Advertise on the site', 'manual'),
('mp_switch_title', 'en', 'Marketplace for visitors', 'manual'),
('mp_switch_on', 'en', 'shown', 'manual'),
('mp_switch_off', 'en', 'hidden — direct links show the “Coming soon” page', 'manual'),
('mp_switch_show', 'en', 'Show to visitors', 'manual'),
('mp_switch_hide', 'en', 'Hide', 'manual'),
('mp_switch_note', 'en', 'While hidden, the section is not in the menu, footer, home page or ads, and its pages are not indexed. Staff still see it as before.', 'manual'),
('mp_switch_error', 'en', 'Could not save. Please try again.', 'manual'),
('mp_switch_config_off', 'en', 'The section is disabled in config/marketplace.php (public_enabled); the switch takes effect once it is enabled.', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
