-- =====================================================================
-- AI LAB HUB — міграція 2026-11-19 (№ 25): EN-написи геолокації відвідувача, нової категорії згоди cookie
-- й «Географії показу» реклами. Ключі geo_* / cc_* / adgeo_* з app/translations.php (українські тексти — там).
-- Людський переклад одразу в ui_translations (source='manual'). Лише INSERT ... ON DUPLICATE KEY UPDATE
-- (унікальний ключ (key_name, lang)); повторний запуск безпечний.
-- =====================================================================

SET NAMES utf8mb4;

INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('geo_place_title', 'en', 'Your location', 'manual'),
('geo_place_set', 'en', 'Set location', 'manual'),
('geo_loc_intro', 'en', 'Your location is used only for “Near me” in the Marketplace and for local ads. Without it everything is shown as usual, regardless of location.', 'manual'),
('geo_loc_current', 'en', 'Current: %s', 'manual'),
('geo_loc_unknown', 'en', 'No location set — listings and ads are shown regardless of location.', 'manual'),
('geo_loc_field', 'en', 'Country and city', 'manual'),
('geo_loc_save', 'en', 'Save', 'manual'),
('geo_loc_none', 'en', 'Don’t specify', 'manual'),
('geo_loc_clear', 'en', 'Clear', 'manual'),
('geo_back', 'en', 'Back', 'manual'),
('geo_loc_saved', 'en', 'Location saved.', 'manual'),
('geo_loc_cleared', 'en', 'Location cleared.', 'manual'),
('geo_loc_err', 'en', 'Choose a city or a country from the suggestions.', 'manual'),
('geo_loc_near_hint', 'en', '“Near me” asks your browser for permission to use your location. We find the nearest city within 100 km; coordinates are not stored.', 'manual'),
('geo_near_fail', 'en', 'No city found nearby (within 100 km). Please type the name.', 'manual'),
('geo_loc_privacy', 'en', 'The choice is stored only in the geo_loc cookie in your browser (a place id or a country code, 180 days) and, if you are signed in, in your profile settings. The site language does not affect it.', 'manual'),
('geo_loc_ip_off', 'en', 'Country detection by IP is turned off.', 'manual'),
('geo_loc_ip_no_consent', 'en', 'We do not detect your country by IP: you have not consented to it.', 'manual'),
('geo_loc_ip_consented', 'en', 'You allowed country detection by IP (the IP is not stored); your choice here always takes priority.', 'manual'),
('geo_cookie_settings', 'en', 'Cookie settings', 'manual'),
('geo_src_user', 'en', 'your choice', 'manual'),
('geo_src_profile', 'en', 'from your profile', 'manual'),
('geo_src_browser', 'en', 'from browser location', 'manual'),
('geo_src_ip', 'en', 'country by IP, with your consent', 'manual'),
('geo_nearby_chip', 'en', 'Near me', 'manual'),
('geo_nearby_using', 'en', 'Near: %s, plus online', 'manual'),
('geo_change_place', 'en', 'Change location', 'manual'),
('geo_nearby_ask', 'en', 'To show listings near you, set your location.', 'manual'),
('cc_customize', 'en', 'Customize', 'manual'),
('cc_save_choice', 'en', 'Save choice', 'manual'),
('cc_yt_title', 'en', 'YouTube videos in ads', 'manual'),
('cc_yt_text', 'en', 'Google may store its own cookies. Without consent, a video loads only after you press ▶.', 'manual'),
('cc_geo_title', 'en', 'Local listings and ads by IP', 'manual'),
('cc_geo_text', 'en', 'Allows us to detect only your country from your IP address to show local ads. The IP is not stored or shared; your own location choice always takes priority. Off by default.', 'manual'),
('adgeo_title', 'en', 'Geographic targeting', 'manual'),
('adgeo_hint', 'en', 'With no places set, the ad is shown to everyone. Pick countries and cities from the suggestions; set a radius for a city. The page language does not affect geography.', 'manual'),
('adgeo_include', 'en', 'Include', 'manual'),
('adgeo_include_hint', 'en', 'show only in these countries and cities (one match is enough)', 'manual'),
('adgeo_exclude', 'en', 'Exclude', 'manual'),
('adgeo_exclude_hint', 'en', 'never show here, even if the place matches “Include”', 'manual'),
('adgeo_place_n', 'en', 'Place %d', 'manual'),
('adgeo_radius', 'en', 'Radius', 'manual'),
('adgeo_radius_default', 'en', '+%d km (default)', 'manual'),
('adgeo_mode', 'en', 'Mode', 'manual'),
('adgeo_mode_soft', 'en', 'Soft (recommended): also show to visitors whose location we don’t know.', 'manual'),
('adgeo_mode_strict', 'en', 'Strict: show only to visitors who set their location or whose country was detected with consent.', 'manual'),
('adgeo_mode_short_soft', 'en', 'soft', 'manual'),
('adgeo_mode_short_strict', 'en', 'strict', 'manual'),
('adgeo_reach_na', 'en', 'Reach estimate unavailable: not enough data about visitor locations.', 'manual'),
('adgeo_everywhere', 'en', 'All countries', 'manual'),
('adgeo_except', 'en', 'except', 'manual'),
('adgeo_col', 'en', 'Geography', 'manual'),
('adgeo_act', 'en', 'Geography', 'manual'),
('adgeo_page_title', 'en', 'Geographic targeting: %s', 'manual'),
('adgeo_page_note', 'en', 'Changing geography does not reset the campaign status and does not require another review.', 'manual'),
('adgeo_saved', 'en', 'Geographic targeting saved.', 'manual'),
('adgeo_save', 'en', 'Save geography', 'manual'),
('adgeo_err_place', 'en', 'One of the places was not found — pick a country or a city from the suggestions.', 'manual'),
('adgeo_err_too_many', 'en', 'Too many places: up to 20 in “Include” and up to 20 in “Exclude”.', 'manual'),
('adgeo_err_both', 'en', 'A place cannot be both included and excluded — kept it in “Include”.', 'manual'),
('adgeo_err_save', 'en', 'Could not save the geography. Please try again.', 'manual'),
('adgeo_new_note', 'en', 'You can set the geography here or later with the “Geography” button in the campaign list.', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';

-- Політика конфіденційності: 3.5 (cookie geo_loc, alh_geo, категорія IP) і пункт про таргетинг реклами.
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('legal_privacy_cookies_necessary', 'en', 'Necessary (work without consent): the session cookie — sign-in, interface language, ad frequency; alh_consent — your cookie choice (1 year); alh_geo — your choice about country detection by IP (1 year); geo_loc — your location (only a city identifier from the GeoNames directory or a country code, no coordinates), set only if you chose it yourself with “Save” or “Remember” (180 days). If you are signed in, the chosen location and search radius are also kept in your profile settings. The “Near me” button sends your browser coordinates once, only after you press it and allow it: the server finds the nearest city within 100 km and does not store the coordinates. In the browser’s localStorage — the time of the last ad pop-up and the ad sound setting; in sessionStorage — your chat with the assistant Elya until the tab is closed.', 'manual'),
('legal_privacy_cookies_geo', 'en', 'Local listings and ads by IP (only with consent, off by default): if you turn this category on in “Cookie settings”, we may detect only your country from your IP address to show local ads and listings. Your IP address is not stored, logged or shared for this; the detected country is kept only for the session. Your own location choice always takes priority. This feature is currently switched off on the site, so even with consent no country is detected by IP.', 'manual'),
('legal_privacy_ads_targeting', 'en', 'IP addresses are not stored in plain form. Advertisers only see aggregated statistics (numbers of impressions, views and clicks). There is no personal targeting: ads are selected only by site language, device type, page topic and — if you set your location yourself (or consented to country detection by IP) — by country or city. Advertisers receive no data about your location.', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';

-- Оновлені тексти етапу 6 (місце більше не підставляється в пошук саме; cookie geo_loc на 180 днів).
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('mpg_settings_note', 'en', 'The place set here is used by the “Near me” switch in Marketplace search and by local ads. Without it there is no location filter.', 'manual'),
('mpg_settings_guest_note', 'en', 'Without signing in, only the city or country is saved — in the geo_loc cookie on this device (180 days). Sign in to save more settings.', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
