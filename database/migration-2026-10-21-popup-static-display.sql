SET NAMES utf8mb4;
-- AI LAB HUB — спливаюче вікно: оголошення без відео (зображення, картка власної реклами) закривається саме
-- через 20 с (налаштування ad_popup_static_display_seconds; «Пропустити» — як і раніше, через 10–15 с).
-- Безпечно повторювати: INSERT IGNORE не змінює значення, яке адмін уже задав.
INSERT IGNORE INTO ad_settings (setting_key, setting_value) VALUES ('ad_popup_static_display_seconds', '20');
