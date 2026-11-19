SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-19: «Українські додатки» / «Ukrainian Apps» (slug ukrainian-apps) — стоматологія: прив'язка наявного Doc.ua.
-- + 0 нових продуктів і 1 прив'язок наявних (функцію звірено на офіційних сайтах 2026-11-19).
-- Якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються.
-- Doc.ua: розділ «Стоматологічні клініки» з фільтром «Тільки з онлайн-розкладом» і записом, сервіс безкоштовний для пацієнтів (звірено 2026-11-19).
-- Пропущено: Люмі-Дент (сайт за замовчуванням російською), Dentify і МістоДент (сайти недоступні, 403/DNS), Helsi (сторінка не віддала вмісту).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Doc.ua — ua-dental (наявний, прив'язка)
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);

-- Прив'язки наявних продуктів (за назвою, без id)
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'doc.ua' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-dental' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
