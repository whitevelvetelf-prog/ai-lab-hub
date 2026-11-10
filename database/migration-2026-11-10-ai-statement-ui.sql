-- AI LAB HUB — «Як ми використовуємо АІ»: попередження чернетки тепер для admin і employee.
-- Ідемпотентно. Позначка мови для EN — наявний ключ mp_original_lang («Text in the original language: %s»).
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('ais_admin_warning', 'en', 'Draft: %d [CONFIRM] markers left. Until they are removed the page is visible to administrators and employees only (404 for everyone else) and is not linked in the footer.', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
-- ais_uk_only більше не використовується (замінено на mp_original_lang); рядок у БД нешкідливий, не видаляємо.
