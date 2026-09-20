-- AI LAB HUB — експорт наявних продуктів для tools/autofill (existing.csv).
--
-- Виконати у phpMyAdmin (вкладка SQL) на базі, з якої треба брати «реальність»
-- (для антидубля й підрахунку прогалин — зазвичай база хостингу; локальна
-- відстає, якщо ви ще не заливали hosting-sync.sql). Лише SELECT — нічого не змінює.
--
-- Далі: результат → «Експорт» → формат CSV, роздільник «,», прапорець
-- «Назви стовпців — у першому рядку», кодування UTF-8 → зберегти як
--   tools/autofill/existing.csv
-- і виконати:  php autofill.php load-existing existing.csv
--
-- Заголовок обов'язково: name,website,subcategories
-- subcategories — пари «Категорія › Підкатегорія» через «|» (як у taxonomy.csv).
-- Продукти без підкатегорій теж потрапляють (subcategories порожнє), архівні —
-- теж: вони займають домен, тож дублювати їх не можна.

SET SESSION group_concat_max_len = 100000;

SELECT
    p.name                                                            AS name,
    p.official_url                                                    AS website,
    GROUP_CONCAT(DISTINCT CONCAT(c.name, ' › ', s.name)
                 ORDER BY c.id, s.id SEPARATOR '|')                   AS subcategories
FROM products p
LEFT JOIN product_subcategories ps ON ps.product_id = p.id
LEFT JOIN subcategories s           ON s.id = ps.subcategory_id
LEFT JOIN categories c              ON c.id = s.category_id
WHERE p.official_url IS NOT NULL AND p.official_url <> ''
GROUP BY p.id, p.name, p.official_url
ORDER BY p.id;
