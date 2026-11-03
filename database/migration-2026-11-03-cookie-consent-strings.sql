-- =====================================================================
-- AI LAB HUB — міграція 2026-11-03: EN-написи банера cookie (cc_*) і розділу політики 3.5 (legal_privacy_cookies_*).
-- Українські тексти — в app/translations.php. Готовий людський переклад у ui_translations (source='manual').
-- Безпечно повторювати: INSERT IGNORE (унікальний ключ (key_name, lang)). Лише INSERT.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('cc_title', 'en', 'Cookies on this site', 'manual'),
('cc_text', 'en', 'Without your consent we only use necessary cookies: sign-in, language and your saved Marketplace place. YouTube videos in ads (Google may store its own cookies) load only after “Accept all” or when you press ▶.', 'manual'),
('cc_more', 'en', 'Learn more', 'manual'),
('cc_accept_all', 'en', 'Accept all', 'manual'),
('cc_necessary', 'en', 'Necessary only', 'manual'),
('cc_settings', 'en', 'Cookie settings', 'manual'),
('cc_state_all', 'en', 'Current choice: all accepted.', 'manual'),
('cc_state_necessary', 'en', 'Current choice: necessary only.', 'manual'),
('cc_yt_note', 'en', 'The YouTube video loads after you press ▶', 'manual'),
('legal_privacy_cookies_title', 'en', '3.5. Cookies and local storage', 'manual'),
('legal_privacy_cookies_necessary', 'en', 'Necessary (work without consent): the session cookie — sign-in, interface language, ad frequency; alh_consent — your cookie choice (1 year); mp_loc — your Marketplace search city, only if you pressed “Remember” (1 year, no coordinates). In the browser’s localStorage — the time of the last ad pop-up and the ad sound setting; in sessionStorage — your chat with the assistant Elya until the tab is closed.', 'manual'),
('legal_privacy_cookies_youtube', 'en', 'External media (only with consent): YouTube videos in ads are embedded from youtube-nocookie.com; once playback starts, YouTube (Google) may store its own cookies or browser data. Without consent we show a thumbnail (an image from YouTube’s server), and the video loads only after you press ▶.', 'manual'),
('legal_privacy_cookies_none', 'en', 'We use no analytics, ad trackers or third-party tracking cookies. You can change your choice at any time with the “Cookie settings” link at the bottom of the page.', 'manual');
