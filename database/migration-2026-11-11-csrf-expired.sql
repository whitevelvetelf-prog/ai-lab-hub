-- AI LAB HUB — CSRF у публічних формах (app/csrf.php, csrf_expired), EN. Ідемпотентно.
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('csrf_expired', 'en', 'The page has expired or the form was not sent from it. Check the fields and submit the form again.', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
