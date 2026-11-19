-- № 26 (2026-11-19): Політика конфіденційності 3.5 — країну за IP увімкнено (заголовок хостингу GEOIP_COUNTRY_CODE).
-- Лише оновлення EN-тексту; безпечно запускати повторно. Без DROP/DELETE/TRUNCATE.
SET NAMES utf8mb4;

INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('legal_privacy_cookies_geo', 'en', 'Local listings and ads by IP (only with consent, off by default): if you turn this category on in “Cookie settings”, we may detect only your country from your IP address to show local ads and listings. Your IP address is not stored, logged or shared for this; the detected country is kept only for the session. Your own location choice always takes priority. The country is determined by our hosting server from the request IP address; no third-party geolocation services are used.', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
