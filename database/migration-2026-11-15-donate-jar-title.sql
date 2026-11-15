-- AI LAB HUB — сторінка донатів (public/donate.php): заголовок банки без «з України» і підпис
-- про картки будь-якої країни. EN-тексти. Ідемпотентно. site_settings не чіпає.
-- UA — у app/translations.php (donate_jar_title, donate_jar_note).
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('donate_jar_title', 'en', 'monobank donation jar', 'manual'),
('donate_jar_note', 'en', 'Accepts Visa and Mastercard from any country, plus Apple Pay and Google Pay', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
