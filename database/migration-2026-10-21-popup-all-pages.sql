SET NAMES utf8mb4;
-- AI LAB HUB — спливаюча реклама на всіх сторінках, крім головної (index.php) та Елі (eli.php).
-- Раніше виключались умови, конфіденційність, кабінет, CRM/адмінка тощо. Безпечно повторювати.
INSERT INTO ad_settings (setting_key, setting_value) VALUES ('ad_popup_excluded_pages', 'index.php\neli.php')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);
