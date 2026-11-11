-- AI LAB HUB — підказка під полем вводу Елі (public/eli.php): EN-тексти. Ідемпотентно.
-- UA — у app/translations.php (eli_privacy_hint, eli_privacy_hint_claude, eli_privacy_more).
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('eli_privacy_hint', 'en', 'Do not enter personal data. Requests are processed by Google.', 'manual'),
('eli_privacy_hint_claude', 'en', 'Do not enter personal data. Requests are processed by Anthropic.', 'manual'),
('eli_privacy_more', 'en', 'Learn more', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
