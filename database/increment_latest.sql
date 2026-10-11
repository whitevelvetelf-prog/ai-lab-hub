-- =====================================================================
-- AI LAB HUB — міграція: загальні налаштування сайту + сторінка донатів (2026-10-11).
--
-- site_settings — ключ → значення для налаштувань, які адмін змінює в кабінеті
-- (зараз: реквізити донатів donate_*, розділ «Донати» в account.php).
-- ЛИШЕ СТРУКТУРА: реквізити (картка, IBAN, посилання на банку тощо) сюди
-- НЕ пишуться — адмін вводить їх у кабінеті після деплою. Поки значень немає,
-- сторінка donate.php показує нейтральний текст «Скоро».
--
-- Плюс готовий EN-переклад написів сторінки донатів (ui_translations, source='manual')
-- — це лише тексти інтерфейсу, не реквізити.
--
-- Лише CREATE TABLE IF NOT EXISTS / INSERT IGNORE. Жодних DROP / DELETE / TRUNCATE.
-- Безпечно застосовувати повторно.
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS site_settings (
    setting_key   VARCHAR(64) NOT NULL,
    setting_value TEXT NOT NULL,
    updated_at    TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (setting_key)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('donate_page_title', 'en', 'Support AI LAB HUB', 'manual'),
('donate_intro', 'en', 'AI LAB HUB is an independent catalog of AI tools. If you find it useful, you can support the project with a voluntary contribution: it helps us grow and expand the catalog.', 'manual'),
('donate_thanks', 'en', 'Thank you for any support!', 'manual'),
('donate_soon', 'en', 'Ways to support the project will appear here soon. Thank you for stopping by!', 'manual'),
('donate_ua_title', 'en', 'Donations from Ukraine', 'manual'),
('donate_intl_title', 'en', 'International transfers', 'manual'),
('donate_jar_btn', 'en', 'Open the donation jar', 'manual'),
('donate_qr_hint', 'en', 'Or scan the QR code with your phone camera', 'manual'),
('donate_card', 'en', 'Card number', 'manual'),
('donate_recipient', 'en', 'Recipient', 'manual'),
('donate_iban_uah', 'en', 'IBAN (UAH)', 'manual'),
('donate_iban_usd', 'en', 'IBAN (USD)', 'manual'),
('donate_iban_eur', 'en', 'IBAN (EUR)', 'manual'),
('donate_swift', 'en', 'SWIFT / BIC', 'manual'),
('donate_bank', 'en', 'Bank', 'manual'),
('donate_purpose', 'en', 'Payment reference', 'manual'),
('donate_purpose_default', 'en', 'Voluntary contribution to the development of AI LAB HUB', 'manual'),
('donate_intl_note', 'en', 'International transfers usually take a few business days, and intermediary banks may charge a fee.', 'manual'),
('donate_copy', 'en', 'Copy', 'manual'),
('donate_copied', 'en', 'Copied', 'manual'),
('donate_copy_failed', 'en', 'Could not copy — please select the text and copy it manually', 'manual'),
('donate_legal_note', 'en', 'A donation is voluntary, is not a payment for services and is non-refundable.', 'manual'),
('donate_terms_link', 'en', 'Terms of Use', 'manual');
