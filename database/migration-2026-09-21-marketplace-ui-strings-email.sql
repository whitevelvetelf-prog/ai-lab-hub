-- =====================================================================
-- AI LAB HUB — міграція: EN-написи підтвердження email Marketplace (етап 5; ключі mpv_*)
--
--   Українські тексти — у app/translations.php. Готовий переклад одразу в ui_translations (source='manual').
--   Безпечно повторювати: INSERT IGNORE. Тільки INSERT: жодних DROP/DELETE/TRUNCATE/ALTER.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('mpv_title', 'en', 'Email confirmation', 'manual'),
('mpv_block_title', 'en', 'Confirm your email', 'manual'),
('mpv_block_text', 'en', 'To post or edit listings, reveal contacts and report listings, please confirm your email. We will send you a message with a link.', 'manual'),
('mpv_send_btn', 'en', 'Send the confirmation email', 'manual'),
('mpv_contact_block', 'en', 'Confirm your email to see the contacts.', 'manual'),
('mpv_page_text', 'en', 'The message will be sent to your account address: %s.', 'manual'),
('mpv_sent', 'en', 'The email was sent. The link is valid for %d hours. Check your inbox (and the spam folder).', 'manual'),
('mpv_too_soon', 'en', 'An email was sent recently. Please wait %d min and try again.', 'manual'),
('mpv_daily', 'en', 'The daily email limit has been reached (%d per day). Try again tomorrow.', 'manual'),
('mpv_already', 'en', 'Your email is already confirmed.', 'manual'),
('mpv_fail', 'en', 'Could not send the email. Please try again later.', 'manual'),
('mpv_ok_title', 'en', 'Email confirmed', 'manual'),
('mpv_fail_title', 'en', 'Could not confirm', 'manual'),
('mpv_ok', 'en', 'Thank you! Your email is confirmed — you can now post listings, reveal contacts and report listings.', 'manual'),
('mpv_expired', 'en', 'This link has expired. Please request a new email.', 'manual'),
('mpv_used', 'en', 'This link has already been used. If your email is not confirmed yet, request a new email.', 'manual'),
('mpv_changed', 'en', 'The account email has changed, so this link is no longer valid. Please request a new email.', 'manual'),
('mpv_invalid', 'en', 'This link is not valid. Please request a new email.', 'manual'),
('mpv_mail_subject', 'en', 'Confirm your email — AI LAB HUB Marketplace', 'manual'),
('mpv_mail_intro', 'en', 'To use the Marketplace, please confirm your email using this link:', 'manual'),
('mpv_mail_button', 'en', 'Confirm email', 'manual'),
('mpv_mail_expiry', 'en', 'The link is valid for %d hours and works once.', 'manual'),
('mpv_mail_ignore', 'en', 'If you did not request this, just ignore this message.', 'manual');
