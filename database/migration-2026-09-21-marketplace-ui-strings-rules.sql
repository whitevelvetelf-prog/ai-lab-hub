-- =====================================================================
-- AI LAB HUB — міграція: EN-написи сторінки Правил і галочки згоди Marketplace
--
--   Ключі: mpb_f_rules_text (EN-переклад тексту галочки; УКРАЇНСЬКИЙ текст галочки береться з
--   docs/marketplace_rules_uk.md, розділ «Текст для галочки», у app/translations.php його немає),
--   mpb_f_rules_link, footer_mp_rules, mpb_rules_uk_only. Решта українських рядків — у app/translations.php. Безпечно повторювати: INSERT IGNORE (унікальний
--   ключ (key_name, lang)); якщо EN-рядок mpb_f_rules_link уже є з 07 — він не перезаписується.
--   Тільки INSERT: жодних DROP/DELETE/TRUNCATE/ALTER.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('mpb_f_rules_text', 'en', 'I have read the Listing Rules and agree to them. I confirm that I have the right to post this offer, and that the contacts I provided may be shown to authorized users to get in touch about this listing.', 'manual'),
('mpb_f_rules_link', 'en', 'Listing rules', 'manual'),
('footer_mp_rules', 'en', 'Listing rules', 'manual'),
('mpb_rules_uk_only', 'en', 'The rules are available in Ukrainian only.', 'manual');
