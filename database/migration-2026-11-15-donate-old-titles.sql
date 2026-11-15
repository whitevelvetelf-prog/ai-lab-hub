-- AI LAB HUB — прибрати невживані ключі сторінки донатів (заголовки старих блоків «з України» і
-- «міжнародні перекази»; замінені на donate_jar_title у 4feac69). Ідемпотентно. site_settings не чіпає.
DELETE FROM ui_translations WHERE key_name IN ('donate_ua_title', 'donate_intl_title');
