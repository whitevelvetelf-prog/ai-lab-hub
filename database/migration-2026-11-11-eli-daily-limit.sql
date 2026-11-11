-- AI LAB HUB — Еля: текст при вичерпаному добовому ліміті (app/eli.php, eli_daily_limit), EN. Ідемпотентно.
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('eli_daily_limit', 'en', 'Today''s limit for smart matching has been reached. Here is what we found in the catalog by keywords:', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
