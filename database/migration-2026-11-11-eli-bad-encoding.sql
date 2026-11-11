-- AI LAB HUB — Еля: запит не в UTF-8 (public/api-eli-chat.php, eli_bad_encoding), EN. Ідемпотентно.
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('eli_bad_encoding', 'en', 'Could not read the request text. Please type it again.', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
