# Заливка на хостинг — 2026-09-21

База хостингу: `gu621051_ailabhublive`. Пакет готовий у теці `hosting-upload/` (локально, у git не потрапляє):

| Файл | Що це | Куди |
|---|---|---|
| `01-ad-server.sql` | Реклама: 6 таблиць, зони, 4 оголошення, переклади оголошень | phpMyAdmin → Імпорт |
| `02-products-manual-batches.sql` | Усі ручні партії каталогу: **69 продуктів, 136 тарифів, 14 прив'язок наявних продуктів**, виправлення SEO-партії | phpMyAdmin → Імпорт |
| `03-products-autofill-imagen.sql` | Автозаповнення «Генерація зображень»: 8 продуктів | phpMyAdmin → Імпорт |
| `logos/` (6 файлів `.webp`) | Логотипи для файлу 03 | на хостинг у `public/assets/images/logos/` |
| `code/deploy13.zip` | Код сайту (актуальний, після нього код не змінювався) | розпакувати в корінь сайту |

**Файли 02 і 03 безпечні для будь-яких id на хостингу:** продукт додається, лише якщо продукту з таким самим URL ще немає (без `http(s)://`, `www.`, кінцевого слеша); id визначається через `@pid`, категорії й підкатегорії — за slug. Їх можна запускати повторно, і вони не дублюють уже залиті раніше продукти. **Окремі файли з `database/batches/` (fixed-id) виконувати не потрібно** — файл 02 їх замінює.

## 0. Перед початком
1. phpMyAdmin → база → **Експорт** (швидкий, SQL) — резервна копія.
2. Для файлів краще вкладка **Імпорт** (завантаження файлу, кодування `utf-8`), а не вставка тексту: файл 02 має ~240 КБ.

## 1. Перевірка перед заливкою (вкладка SQL)
Усі потрібні підкатегорії існують (має повернути **порожньо**, інакше прив'язки для відсутніх пропадуть мовчки):
```sql
SELECT t.cat, t.sub FROM (
  SELECT 'business-marketing' cat, 'crm' sub UNION ALL SELECT 'business-marketing','lead-generation'
  UNION ALL SELECT 'design-creative','graphic-design' UNION ALL SELECT 'design-creative','tattoo-design'
  UNION ALL SELECT 'education-knowledge','certificates' UNION ALL SELECT 'education-knowledge','courses' UNION ALL SELECT 'education-knowledge','tests'
  UNION ALL SELECT 'finance-legal','documents' UNION ALL SELECT 'finance-legal','finance' UNION ALL SELECT 'finance-legal','legal-services'
  UNION ALL SELECT 'my-home','beekeeping' UNION ALL SELECT 'my-home','cooking' UNION ALL SELECT 'my-home','fish' UNION ALL SELECT 'my-home','garden'
  UNION ALL SELECT 'my-home','houseplants' UNION ALL SELECT 'my-home','kitchen-garden' UNION ALL SELECT 'my-home','livestock'
  UNION ALL SELECT 'my-home','pet-grooming-vet' UNION ALL SELECT 'my-home','pets' UNION ALL SELECT 'my-home','poultry'
  UNION ALL SELECT 'seo-content','seo' UNION ALL SELECT 'seo-content','trends'
  UNION ALL SELECT 'tools-automation','automation' UNION ALL SELECT 'translation-languages','translation'
) t
LEFT JOIN categories c ON c.slug = t.cat
LEFT JOIN subcategories s ON s.category_id = c.id AND s.slug = t.sub
WHERE s.id IS NULL;
```
Для файлу 03 (шукає за назвою) — має повернути **1 рядок**:
```sql
SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id
WHERE c.name = 'Мультимедіа' AND s.name = 'Генерація зображень';
```
Інформаційно (безпечні файли від цього не залежать): `SELECT MAX(id) FROM products; SELECT MAX(id) FROM pricing_plans;`

## 2. Порядок заливки
1. **`01-ad-server.sql`** — до коду (сторінки категорій читають нові таблиці; без цього вони можуть упасти). Якщо цей блок уже виконували — безпечно повторити.
2. **`02-products-manual-batches.sql`**.
3. **`03-products-autofill-imagen.sql`**.
4. **Логотипи:** скопіювати 6 файлів із `logos/` у `public/assets/images/logos/` на хостингу (теку створити, якщо немає): `getimg-ai.webp`, `mage-space.webp`, `pixlr-com.webp`, `scenario-com.webp`, `seaart-ai.webp`, `starryai-com.webp`. Логотипи мають лише ці 6 продуктів; в інших (`NULL`) логотипа немає.
5. **Код:** розпакувати `code/deploy13.zip` у корінь сайту з перезаписом. `config/database.php` в архіві немає — конфіги на сервері лишаться. Після цього відкрити сайт з Ctrl+F5 (сервіс-воркер може віддавати стару копію).

## 3. Перевірка після заливки
Нових продуктів без підкатегорії має бути **0**:
```sql
SELECT p.id, p.name FROM products p
LEFT JOIN product_subcategories ps ON ps.product_id = p.id
WHERE p.created_at >= '2026-09-20' AND ps.product_id IS NULL;
```
Підкатегорії, де менше 10 опублікованих продуктів (на хостингу таксономія може відрізнятися від локальної — наприклад, залишилися зайві підкатегорії, тому короткий список тут не помилка):
```sql
SELECT c.name AS категорія, s.name AS підкатегорія, COUNT(p.id) AS cnt
FROM categories c JOIN subcategories s ON s.category_id = c.id
LEFT JOIN product_subcategories ps ON ps.subcategory_id = s.id
LEFT JOIN products p ON p.id = ps.product_id AND p.status = 'published' AND p.is_archived = 0
GROUP BY c.id, s.id HAVING cnt < 10 ORDER BY c.id, s.id;
```
Дублі за URL (у локальній базі є 3 старі: `apps.apple.com`, `notion.com`, `play.google.com`):
```sql
SELECT official_url, COUNT(*) AS n, GROUP_CONCAT(id) AS ids FROM products
WHERE official_url IS NOT NULL GROUP BY official_url HAVING n > 1;
```
Реклама: відкрити сторінку категорії та підкатегорії — має з'явитися банер; у CRM (`crm-ads-list.php`, admin) видно кампанію «AI LAB HUB».

## Що очікувати
- На хостингу нових продуктів буде до **77** (69 + 8), менше — якщо частину вже залито раніше. Локальна база після файлу 03 матиме 692 продукти (зараз 684, файл 03 локально не виконувався).
- Тарифи для сервісів, чиї ціни не вдалося підтвердити на офіційних сторінках, порожні (див. звіти по партіях).
- Якщо щось пішло не так — відновити базу з резервної копії кроку 0.
