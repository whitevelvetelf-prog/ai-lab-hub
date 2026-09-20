# AI LAB HUB — автонаповнення каталогу (tools/autofill)

Локальний CLI-пайплайн (PHP 8.1+, запускається в Laragon). Жива база сайту не чіпається: скрипт готує **SQL-пакети** для вкладки SQL у phpMyAdmin — так само, як ваш `database/increment_latest.sql`.

```
кандидати → fetch (сайт продукту) → enrich (Claude) → validate → valid → export (.sql + logos.zip)
                       │                                   └→ review (очима) / manual (сайт блокує ботів)
```

## Встановлення
1. PHP-розширення: `curl, dom, mbstring, pdo_sqlite, gd (з webp), zip` (у Laragon: Menu → PHP → Extensions).
2. `copy config.example.php config.php`, вписати `anthropic_key`. Якщо помилка "SSL certificate problem" — задати `ca_bundle`.
3. `taxonomy.csv` — **замінити експортом із вашої БД** (колонки `category,subcategory`). Зараз там список із затверджених рішень, але 21 порожню підкатегорію ви видаляли, а нові додавали — актуальний перелік знає лише БД.
4. `schema_map.php` — **звірити з реальною схемою** (`SHOW CREATE TABLE products, …`). Це єдине місце, що залежить від схеми.
5. Вивантажити наявні продукти в `existing.csv` (заголовок саме такий: `name,website,subcategories`) і виконати `php autofill.php load-existing existing.csv`. Приклад запиту (адаптувати):
   ```sql
   SET SESSION group_concat_max_len = 100000;
   SELECT p.name, p.website_url AS website,
          GROUP_CONCAT(CONCAT(c.name,' › ',s.name) SEPARATOR '|') AS subcategories
   FROM products p
   LEFT JOIN product_subcategories ps ON ps.product_id = p.id
   LEFT JOIN subcategories s ON s.id = ps.subcategory_id
   LEFT JOIN categories c ON c.id = s.category_id
   GROUP BY p.id;
   ```

## Робочий цикл
```
php autofill.php gaps                                  # де бракує до 10 у підкатегорії
php autofill.php discover:llm --gaps                   # Claude пропонує кандидатів на всі прогалини
php autofill.php discover:urls my-list.txt --subcat "Мультимедіа › Аудіо"
php autofill.php run --limit 50                        # fetch → enrich → validate (спершу мала партія!)
php autofill.php sample --n 10                         # вибірково подивитись valid
php autofill.php review                                # сумнівні + approve/reject <id...>
php autofill.php export                                # → export/batch_0001.sql (+ _logos.zip)
php autofill.php export-manual                         # → export/manual.csv (заблоковані сайти)
```
Після імпорту `.sql` — знову вивантажити `existing.csv` і `load-existing`, щоб `gaps` показував реальність.

Імпорт безпечний для повторів: `INSERT … WHERE NOT EXISTS` за `website`, категорії/тарифи додаються лише щойно створеним продуктам.

## Що свідомо НЕ автоматизується
- Партнерська реєстрація — лише **підказка**: якщо на сайті знайдено сторінку affiliate/referral, її URL кладеться в `internal_registration_url`. Статус партнерства = «Знайдено».
- Рейтинги/відгуки/кількість користувачів не збираються й у тексті карток відсікаються валідатором.

## Джерела й тексти
- Опис генерується **із сайту самого продукту**, а не копіюється з каталогів-конкурентів (TAAFT, Futurepedia тощо) — масовий скрейпінг їхніх сторінок не закладено (ToS, авторське право на добірки/тексти).
- Кандидати: свій список URL, Product Hunt API (перевірте умови комерційного використання), GitHub topics, Claude по підкатегоріях (URL перевіряються живим запитом, назва має бути на сайті).
- Поважається robots.txt; User-Agent представляється з контактним email.

## Очікування
- Швидкість: послідовно ≈ 5–8 с на продукт → 500–700/годину; тисяча — вечір/ніч. Витрати на Haiku — порядку 1–2 центів за картку (перевірте ціни в config).
- Частина карток піде в `review`/`manual` (сайти за Cloudflare, SPA без тексту, низька впевненість). Реальний відсоток видно лише на першій сотні — почніть з `--limit 50`.
- Ціни на сайтах змінюються: тарифи — знімок на дату імпорту. Якщо цін на сторінці немає, поле лишається порожнім (не вгадується).

## Далі (за потреби)
Паралельний fetch (`curl_multi`), Batch API Anthropic (−50% вартості, асинхронно), рендер JS-сайтів, шар перекладів на 80+ мов поверх базового UA.
