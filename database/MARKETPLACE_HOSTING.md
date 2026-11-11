# Marketplace: випуск на хостинг (Хостинг Україна, adm.tools)

Стан на 2026-09-21: **нічого не залито**. Запуск — **поетапний**:

| Етап | `public_enabled` | `posting_enabled` | Хто що бачить |
|---|---|---|---|
| **1 (цей випуск)** | `true` (після перевірок) | **`false`** | «Готові рішення» й дошка відкриті всім; **створювати/редагувати оголошення можуть лише employee/admin**. Звичайний користувач бачить «Подача оголошень відкриється згодом»; кнопки «Подати оголошення» і сторінки Правил для публіки немає. Вибране, перегляд, розкриття контактів (з підтвердженим email) і скарги працюють. |
| 2 (пізніше) | `true` | `true` | Подача відкрита всім. Див. розділ «Як відкрити подачу для всіх». |

> **Архів (Marketplace уже на проді).** Локальний пакет для заливки видалено 2026-10-06. Джерела файлів у репозиторії: SQL `04`–`14` і `16` → `database/migration-2026-09-2*-marketplace-*.sql` (`15-marketplace-listing-ads.sql` — разове перенесення одного оголошення, уже виконане, у репозиторії його немає); код (`deploy-mp.zip`) збирає `scripts/build-deploy.ps1 -IncludeMarketplace`; шаблон конфігу — `config/marketplace.dist.php` в архіві коду; стартові матеріали — `scripts/mp-import-seed.php` (повернуто в репозиторій 2026-11-05) і тека `marketplace-seed/` (у репозиторії не зберігається; перші 7 матеріалів: `git checkout 8577b05 -- marketplace-seed`). 2026-11-05 ще 6 матеріалів перенесено на прод як draft (id 38–43) через згенерований SQL + файли в `marketplace-files`, без запуску скрипта на сервері.
**Виконуйте кроки строго по порядку.** SQL — **до** коду; `public_enabled` вмикається **останнім**.

---

## Крок 1. Резервна копія
1. phpMyAdmin → ваша база → **Експорт** (швидкий, SQL, utf-8) → збережіть файл.
2. Файловий менеджер → скопіюйте (або заархівуйте) поточний код сайту (`app/`, `public/`, `config/`).
3. Запишіть, де лежить `config/database.php` — його заливка **не чіпає**.
4. **Окремо — завантаження Marketplace (їх немає ні в Git, ні в архіві коду, відновити без копії неможливо):** фото оголошень (`photo_dir`, на проді `/home/<акаунт>/marketplace-files/photos/`) і обкладинки (`public/assets/images/marketplace/covers/`). На проді: файловий менеджер → тека `marketplace-files` → «Архівувати» → завантажте архів собі. Там, де є PHP CLI (локально, cron хостингу): `php scripts/backup-uploads.php` → `backups/marketplace-uploads-<дата>.tar.gz` (поза Git і поза збіркою, лишає 5 останніх; вихідні теки лише читає). Після випуску — адмінська сторінка `mp-photo-check.php` («Перевірка зображень Marketplace», лише читання): лічильник відсутніх файлів має бути 0.

## Крок 2. Перевірка середовища (версії, розширення)
adm.tools → Хостинг → PHP (версія й розширення) і phpMyAdmin. Що має бути:
   - **PHP ≥ 8.1** (код використовує тип `never`). Змінити: adm.tools → Хостинг → PHP.
   - розширення **`fileinfo`**, **`gd` з підтримкою WebP**, `mbstring`, `pdo_mysql` (`exif` — бажано);
   - **`upload_max_filesize` ≥ 6M, `post_max_size` ≥ 48M, `max_file_uploads` ≥ 8, `memory_limit` ≥ 128M, `display_errors` = Off** (змініть у налаштуваннях PHP хостингу);
   - версія БД: **MySQL ≥ 5.7 або MariaDB ≥ 10.3** (SQL використовує `PREPARE/EXECUTE`, `ON DUPLICATE KEY`, `GET_LOCK`). Локально перевірено на MySQL 8.4; на MariaDB окремо не запускалось — після імпорту звірте контрольні запити кроку 3.
4. Вручну (phpMyAdmin → SQL): `SELECT VERSION();` і `SHOW TABLES LIKE 'ui_translations';` (має бути 1 рядок — таблиця з міграції 2026-09-17-translation-tables).

## Крок 3. SQL-міграції — по номерах, **ДО заливки коду**
Імпорт (вкладка **Імпорт**, utf-8). **Варіант А (рекомендую):** один файл `marketplace-ALL-04-14.sql` (усе нижче підряд). **Варіант Б:** окремі файли по номерах:

| № | Файл | Що робить |
|---|---|---|
| 04 | `04-marketplace-core.sql` | 9 таблиць `mp_*`, продавець `ailabhub`, 7 категорій «Готових рішень» |
| 05 | `05-marketplace-ui-strings.sql` | EN-написи вітрини й EN-назви категорій рішень |
| 06 | `06-marketplace-classifieds.sql` | 11 колонок `mp_listings` (`ADD COLUMN` за перевіркою), індекси, таблиці фото/скарг/вибраного/розкриттів, 9 категорій дошки (з `hardware`) |
| 07 | `07-marketplace-ui-strings-classifieds.sql` | EN-написи дошки й категорій дошки |
| 08 | `08-marketplace-email-verification.sql` | `mp_email_verifications` |
| 09 | `09-marketplace-ui-strings-email.sql` | EN-написи підтвердження email |
| 10 | `10-marketplace-ui-strings-rules.sql` | EN-текст галочки згоди, підвал, «Правила лише українською» |
| 11 | `11-marketplace-rules-version.sql` | колонка `mp_listings.rules_version` (`ADD COLUMN` за перевіркою) |
| 12 | `12-marketplace-rate-limits.sql` | `mp_rate_limits` (IP-ліміти) |
| 13 | `13-marketplace-ui-strings-ratelimit.sql` | EN «Too many requests…» |
| 14 | `14-marketplace-ui-strings-posting.sql` | EN «Listing submission will open soon» |

Усі файли безпечно запускати повторно: лише `CREATE TABLE IF NOT EXISTS`, `ADD COLUMN`/`CREATE INDEX` за перевіркою в `information_schema`, `INSERT … WHERE NOT EXISTS` / `INSERT IGNORE`. **Немає `DROP`/`DELETE`/`TRUNCATE`; `ALTER` — лише `mp_listings ADD COLUMN`; таблиці каталогу й `users` не чіпаються.**

Контрольні запити (вкладка SQL) — очікуване в дужках:
```sql
SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME LIKE 'mp\_%';   -- 15
SELECT section, COUNT(*) FROM mp_categories GROUP BY section;                                                -- board 9, solution 7
SELECT COUNT(*) FROM mp_sellers WHERE slug = 'ailabhub';                                                      -- 1
SELECT slug FROM mp_categories WHERE section = 'board' AND slug = 'hardware';                                 -- 1 рядок
SHOW COLUMNS FROM mp_listings LIKE 'rules_version';                                                           -- 1 рядок
SELECT COUNT(*) FROM ui_translations WHERE key_name IN ('mpb_posting_closed','mpb_rate_limited') AND lang='en'; -- 2
```

## Крок 4. Тека для файлів пропозицій і фото — ПОЗА webroot
Файли (pdf, md, zip…) віддає лише `get.php` залогованим, фото оголошень — лише `mp-photo.php` (з перевіркою прав). Тека **не має** бути доступна за URL.
1. Корінь проєкту = тека, де лежать `app/`, `config/`, `public/`. Якщо домен дивиться на `public/`, корінь уже поза веб-коренем; створіть поряд теку `marketplace-files`. Якщо проєкт лежить усередині веб-кореня — створіть її **поруч із** веб-коренем, не в ньому.
2. Права **750/755**, PHP має вміти писати й читати.
3. Запишіть **абсолютний шлях** (вгорі файлового менеджера, `/home/<акаунт>/…`) — він піде в конфіг (крок 6).
4. Перевірка: `https://ваш-домен/marketplace-files/` → **404/403**.
5. Фото лягають у підтеку `photos/` цієї ж теки (`photo_dir` у конфігу, крок 6). PHP створить її сам при першому завантаженні; можна створити й вручну (ті самі права).

## Крок 5. Код — `code/deploy-mp.zip`
Розпакуйте в корінь проєкту **з перезаписом** (не в `public/`), потім Ctrl+F5 (сервіс-воркер).
- Додається: `docs/` (правила + `.htaccess`), `config/marketplace.dist.php` (шаблон), `app/…`, `public/mp-*.php` (зокрема `mp-photo.php` — видача фото), `public/marketplace*.php`, `public/offer.php`, `public/get.php`.
- **Не** входять і **не** перезаписуються: `config/database.php`, `config/marketplace.php` (створюєте самі), `config/marketplace.local.php`, `storage/`, `scripts/`, `marketplace-seed/`.
- Крім Marketplace, архів містить актуальні **виправлення безпеки сайту**: лист відновлення пароля будує посилання з `site_url` (не з `Host`), кукі сесії `HttpOnly`+`SameSite=Lax`, захист заголовків листів. Тому робіть копію з кроку 1.

## Крок 6. Конфіг `config/marketplace.php`
1. Шаблон `config/marketplace.dist.php` (з архіву коду) → заповніть **три** місця: `file_storage_dir` (шлях з кроку 4), `photo_dir` (той самий шлях + `/photos`) і `site_url` (адреса сайту точно як відкривається, `https://…`, без слеша; з `www` чи без).
2. Завантажте як **`config/marketplace.php`** (не `.dist`). На цьому етапі: **`'public_enabled' => false`, `'posting_enabled' => false`**.
3. `rate_limit_salt` — задайте випадковий рядок (на проді вже задана в `www/config/marketplace.php`) і не міняйте її після запуску. `trusted_proxy_header` лишайте порожнім (якщо сайт не за проксі; за Cloudflare — `CF-Connecting-IP`).
4. Ключі, яких немає у файлі, беруться зі значень за замовчуванням у коді. `config/marketplace.dist.php` після цього можна видалити.

## Крок 7. Фото оголошень і закриті теки
Фото лежать **поза webroot** (`photo_dir`) і віддаються через `https://ваш-домен/mp-photo.php?f=<ім'я>`: скрипт пропускає лише імена `<32 символи 0-9a-f>[_t].jpg|png|webp`, записані в базі, і показує фото живого оголошення всім, а неопублікованого — лише власнику та employee/admin. Теки `public/uploads/marketplace/` більше немає: заборону виконання PHP у публічній теці adm.tools через `.htaccess` не дозволяє (`Require`/`Order`/`Deny`, `Options`, `php_flag`, `RemoveHandler` дають 500), а надійність інших варіантів залежить від налаштувань хостингу.
1. **Перенесення старих фото (якщо тека є на сервері):** файловим менеджером перемістіть усі файли `*.jpg`, `*.png`, `*.webp` з `public/uploads/marketplace/` у `photo_dir` (напр. `/home/<акаунт>/marketplace-files/photos/`), потім **видаліть теку `public/uploads/marketplace/` повністю** (разом із `.htaccess` і `probe.php`). Порожню `public/uploads/`, якщо в ній більше нічого немає, теж видаліть.
2. **Фото відкриваються:** увійдіть як employee/admin, відкрийте будь-яке оголошення з фото (`offer.php?id=N`) → фото й мініатюри видно; адреса картинки (ПКМ → «Відкрити зображення в новій вкладці») має вигляд `/mp-photo.php?f=…`. Нове фото, додане через `mp-post.php`, з'являється у `photo_dir`.
3. **Чужі імена не віддаються:** `https://ваш-домен/mp-photo.php?f=0123456789abcdef0123456789abcdef.jpg` → **404**; `https://ваш-домен/mp-photo.php?f=../config/database.php` → **404**.
4. `https://ваш-домен/docs/marketplace_rules_uk.md` → **404/403**. `https://ваш-домен/storage/` → 404/403. `https://ваш-домен/marketplace-files/photos/` → 404/403.
5. Тека `photo_dir` доступна PHP на запис (755/775).

## Крок 8. Cron
adm.tools → Хостинг → **Cron**, раз на годину:
`0 * * * * php /home/<акаунт>/…/public/mp-cron-expire.php` (версія PHP — та сама, що в сайту).
Скрипт переводить прострочені оголошення в `expired` (публічні сторінки самі перевіряють `expires_at`, тож сайт без cron коректний) і чистить лічильники IP-лімітів старші за 3 доби. Якщо cron вміє лише URL — задайте `cron_token` у конфігу й викликайте `…/mp-cron-expire.php?token=<ключ>` (порожній ключ = HTTP вимкнено).

## Крок 9. Пошта: SPF / DKIM / DMARC і тест доставки
Листи (підтвердження email — без нього не працюють «Показати контакт» і «Поскаржитись»; відновлення пароля) йдуть через PHP `mail()` з `hello@ailabhub-directory.com` (`app/mailer.php`); SMTP у проєкті немає. Без правильних DNS-записів Gmail/ukr.net кладуть такі листи в «Спам» або відхиляють.
1. **SPF** (TXT на домені): має дозволяти відправку з серверів хостингу. Точне значення візьміть у підтримки/панелі хостингу (приклад форми: `v=spf1 include:<spf-хостингу> ~all`); у домену має бути **один** SPF-запис.
2. **DKIM**: увімкніть підпис пошти домену в панелі хостингу й додайте виданий TXT-запис (`<selector>._domainkey`).
3. **DMARC** (TXT `_dmarc`): для початку `v=DMARC1; p=none; rua=mailto:admin@ailabhub-directory.com` (звіти без блокування); після стабільної роботи — `p=quarantine`.
4. **Тест доставки (обов'язково до вмикання)** — двічі: зі скриптом **відновлення пароля** (`forgot-password.php`) і зі **підтвердженням email** (потребує `public_enabled=true`, див. крок 11 — тому спершу перевірте forgot-password):
   - завести тестові акаунти на **Gmail** і **ukr.net**;
   - запросити лист → він має прийти **у «Вхідні», не в «Спам»** (перевірте й «Спам»);
   - Gmail: «Показати оригінал» → `SPF: PASS`, `DKIM: PASS`, `DMARC: PASS`; ukr.net: перевірте, що лист не в «Спам», при потребі — заголовки листа;
   - лист має містити посилання на **ваш** домен (`site_url`), а не на чужий/локальний.
   Якщо `mail()` на хостингу не працює або листи в спамі й DNS правильні — потрібен SMTP (окрема робота в `app/mailer.php`), **вмикати подачу/контакти до цього не варто**.

## Крок 10. Імпорт 7 стартових матеріалів (чернетки)
1. Відновіть теку локально (`git checkout 8577b05 -- marketplace-seed`) і залийте в **корінь проєкту** `scripts/mp-import-seed.php` і `marketplace-seed/`.
2. Консоль/SSH або одноразовий cron: `php scripts/mp-import-seed.php` (пробний запуск: 7 × «СТВОРИТИ (draft)»), потім `php scripts/mp-import-seed.php --apply`. Повтор безпечний.
3. **Видаліть `scripts/mp-import-seed.php` і `marketplace-seed/` з сервера.**
4. Перегляньте й опублікуйте в CRM `mp-list.php` (admin/employee). Локальні правки в тексті матеріалів на сервер не переносяться (це нові чернетки з manifest).

## Крок 11. Вмикання (етап 1) і перевірка «наживо»
1. У `config/marketplace.php`: **`'public_enabled' => true`**, `'posting_enabled'` — **`false`**.
2. Перевірка за ролями:
   - **гість:** `marketplace.php`, `marketplace-solutions.php`, картка опублікованого рішення → «Отримати» дає «Потрібен вхід»; `mp-post.php` → «Подача оголошень відкриється згодом» (403); **`mp-rules.php` → 404**; в підвалі немає «Правила оголошень»; кнопки «Подати оголошення» немає;
   - **звичайний користувач** (тестовий акаунт, email підтверджено): те саме + вибране, «Показати контакт», «Поскаржитись» працюють; `mp-post.php` → «відкриється згодом»; кнопки подачі немає; «Отримати» віддає файл;
   - **employee/admin:** `mp-post.php` відкривається (форма з галочкою й посиланням на Правила), `mp-rules.php` → 200 (дата 21.09.2026, без жовтих маркерів), `mp-my.php` («Мої оголошення») і `offer.php` (картка оголошення) теж відкриваються (не 404), `mp-list.php`, `mp-moderation.php`, `mp-add-offer.php`; створене оголошення одразу опубліковане;
   - `mp-cron-expire.php` через cron відпрацював (лог cron).
3. Тестові записи заархівуйте в CRM.

## Відкат
- Швидко: `'public_enabled' => false` у `config/marketplace.php` → усі сторінки Marketplace 404, меню й підвал без Marketplace; база й файли лишаються.
- Повністю: відновити резервні копії бази й файлів (крок 1). Таблиці `mp_*` можна лишити — вони нічого не ламають.

---

## Як відкрити подачу для всіх (етап 2)
Робіть, лише коли готові юридично:
1. **Юрист** переглядає `docs/marketplace_rules_uk.md` (контакти, вимоги, відповідальність, персональні дані) і повертає правки.
2. **Підстановка даних** і правки юриста внесіть у `docs/marketplace_rules_uk.md`. Усі місця для підстановки мають бути заповнені (жодних `[…]`, окрім посилань `[текст](url)`). Оновіть дату: у файлі (рядок «Редакція від»), а головне — `'rules_version' => 'РРРР-ММ-ДД'` у `config/marketplace.php`.
3. **Прибрати «ЧЕРНЕТКА»**: у файлі не має лишатися банера/слова «ЧЕРНЕТКА» (банер прибрано; юридичний перегляд і перевірку доставки листів власник підтвердив 2026-09-28 — **подачу відкрито**).
4. У репозиторії `config/marketplace.php`: **`'posting_enabled' => true`**.
5. **Нова збірка:** `powershell -ExecutionPolicy Bypass -File scripts/build-deploy.ps1 -IncludeMarketplace -Output deploy-mp2.zip`. Збірка **зупиниться**, якщо в Правилах лишились маркери/«ЧЕРНЕТКА», а `rules_version` порожній чи не у форматі `РРРР-ММ-ДД`; без попередження «Правила не фіналізовані» вона пройде лише коли все чисто.
6. Залийте архів із перезаписом (`docs/marketplace_rules_uk.md` оновиться разом із кодом), потім **на сервері** у `config/marketplace.php` поставте `'posting_enabled' => true` і оновіть `rules_version` (серверний конфіг архів не перезаписує).
7. Перевірка: звичайний користувач з підтвердженим email бачить кнопку «Подати оголошення», форму, галочку з посиланням на Правила; `mp-rules.php` відкривається гостю; у підвалі є «Правила оголошень»; нове оголошення потрапляє на модерацію (`mp-moderation.php`).
8. Слідкуйте за чергою модерації й скаргами перші дні. Відкат подачі — `'posting_enabled' => false`.

---

## Довідка

### Налаштування `config/marketplace.php` (значення за замовчуванням)
| Ключ | Типово | Призначення |
|---|---|---|
| `public_enabled` | `false` | публічна частина (вітрини, оголошення, меню) |
| `posting_enabled` | `false` | подача/редагування оголошень для всіх (інакше лише employee/admin) |
| `file_storage_dir` | `<проєкт>/storage/marketplace/files` | файли пропозицій **поза webroot** |
| `photo_dir` | `<проєкт>/storage/marketplace/photos` | фото оголошень **поза webroot** (віддає `mp-photo.php`) |
| `site_url` | `''` | адреса сайту для посилань у листах (обов'язково) |
| `mail_transport` | `mail` | `mail` (PHP `mail()`) або `log` (лише розробка) |
| `rules_version` | дата | дата редакції Правил (показ на сторінці) |
| `rate_limit_salt` | `''` | сіль хешування IP (заповнена в шаблоні) |
| `trusted_proxy_header` | `''` | заголовок проксі з IP (останній елемент); порожньо = `REMOTE_ADDR` |
| `cron_token` | `''` | ключ для виклику cron через URL |
| `photo_max_count` / `photo_max_bytes` | 8 / 5 МБ | фото на оголошення |
| `listing_ttl_days` | 30 | термін оголошення |
| `max_active_per_user` / `max_new_per_day` | 5 / 10 | ліміти на акаунт (не для staff) |
| `reveals_per_day` | 30 | розкриття контактів на акаунт за добу |
| `ip_limit_reveal` / `ip_limit_report` / `ip_limit_post` / `ip_limit_mail` | 100 / 20 / 15 / 20 | ліміти за добу з одного IP (другий шар) |
| `stop_words`, `max_links_in_desc` | `[]`, 2 | антиспам |

### Безпека (коротко)
CSRF на всіх POST; prepared statements; екранування виводу; роль employee/admin перевіряється в БД на кожному запиті; контактів немає в HTML до кліку; фото перекодовуються GD, лежать поза webroot і віддаються лише через `mp-photo.php` (ім'я за шаблоном + запис у БД + права на оголошення); ліміти захищені від паралельних запитів; IP лише як `sha256(IP+сіль)`; токен підтвердження email — 32 байти, у БД лише sha256, одноразовий, підтвердження POST-ом.

### Що НЕ заливати
`config/marketplace.local.php`, `config/database.php` (на сервері свій), `storage/`, `marketplace-seed/` і `scripts/` (крім одноразового імпорту кроку 10), тестові дані.

---

## Етап 6 (2026-11-03): геолокація, розширений пошук, налаштування відвідувача — **НЕ залито**

Пакет SQL: `hosting-upload/marketplace-geo/` (не в git; README там же). Порядок: резервна копія → `15-marketplace-geo-places.sql` → `geo-data-01…05.sql` (GeoNames cities5000, 9,2 МБ, кожна частина ≤ 2 МБ) → `16-marketplace-listing-geo.sql` → `17-marketplace-ui-strings-geo.sql` → код. Джерела міграцій у git: `database/migration-2026-11-03-marketplace-{geo-places,listing-geo,ui-strings-geo}.sql`; дані перегенерувати: `php scripts/geo-import.php <тека GeoNames>`.

Код (без міграцій поводиться як раніше — `mpg_ready()`): `app/mp-geo.php`, `app/mp-geo-form.php`, `app/mp-search.php`, `public/mp-geo-suggest.php`, `public/mp-settings.php`, `public/assets/js/mp-geo.js`, `public/assets/css/mp-geo.css`; змінені `app/marketplace-board.php`, `app/marketplace.php` (`ip_limit_geo_suggest`), `app/mpb-card.php`, `app/mpb-offer.php`, `app/translations.php`, `public/marketplace.php`, `public/marketplace-post.php`, `public/mp-add-offer.php`, `cron/marketplace-daily.php` (перерахунок `price_usd`).

Перевірка після заливки: `php tests/mp-geo-tests.php` — лише локально (тест тимчасово вмикає `marketplace_public` і створює тестові оголошення).

---

## Хвиля 1 (2026-11-09): фільтри вакансій, популярні запити, збережені пошуки, сторінка продавця, статистика, «Як ми використовуємо АІ» — **залито на прод 2026-11-09**

`public_enabled` і `posting_enabled` не змінювались. Перед заливкою — резервна копія бази й коду (крок 1).

### 1. SQL — ДО коду (phpMyAdmin → Імпорт, utf-8), по порядку
| № | Файл | Що робить |
|---|---|---|
| 20 | `database/migration-2026-11-09-marketplace-wave1.sql` | `mp_listings` ADD COLUMN `salary_min_usd`, `salary_max_usd`; `mp_sellers` ADD COLUMN `bio`, `logo`, `page_public`; нові таблиці `mp_listing_tags`, `search_query_stats`, `search_query_overrides`, `mp_saved_searches`, `mp_listing_views_daily` |
| 21 | `database/migration-2026-11-09-marketplace-ui-strings-wave1.sql` | EN-написи (116 рядків, `INSERT IGNORE` у `ui_translations`) |

Лише `CREATE TABLE IF NOT EXISTS` і `ADD COLUMN` за перевіркою `information_schema`; жодних DROP/DELETE/TRUNCATE, змін типів чи FOREIGN KEY. Повтор безпечний.
Контроль: `SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME IN ('mp_listing_tags','search_query_stats','search_query_overrides','mp_saved_searches','mp_listing_views_daily');` → 5 рядків; `SHOW COLUMNS FROM mp_sellers LIKE 'page_public';` → 1 рядок.
Без міграції код не падає: нові блоки просто не показуються (`mpj_ready`, `mpq_ready`, `mpss_ready`, `mpst_ready`, `mpsl_ready`).

### 2. Код (з перезаписом, у корінь проєкту, не в `public/`)
Нові: `app/mp-jobs.php`, `app/mp-popular.php`, `app/mp-saved.php`, `app/mp-seller.php`, `app/mp-stats.php`, `app/ai-statement.php`,
`public/mp-count.php`, `public/mp-saved.php`, `public/mp-seller.php`, `public/mp-seller-settings.php`, `public/mp-stats.php`,
`public/mp-cron-saved-searches.php`, `public/admin-popular-queries.php`, `public/ai-statement.php`, `public/assets/js/mp-filters.js`,
`docs/ai_statement_uk.md` (лежить поза webroot; `docs/.htaccess` уже забороняє доступ).
Змінені: `app/footer.php`, `app/listing.php`, `app/listing-i18n.php`, `app/listing-account.php`, `app/marketplace.php`, `app/marketplace-board.php`,
`app/mp-search.php`, `app/mp-tree.php`, `app/mpb-offer.php`, `app/translations.php`, `cron/marketplace-daily.php`,
`public/account.php`, `public/assets/css/mp-public.css`, `public/listing.php`, `public/listing-post.php`, `public/marketplace.php`,
`public/marketplace-category.php`, `public/marketplace-my.php`, `public/marketplace-offer.php`, `public/mp-cron-expire.php`, `public/mp-photo.php`.
`config/marketplace.php` на сервері **не перезаписувати**: нові ключі мають значення за замовчуванням у `app/marketplace.php → mp_config()`.

### 3. Налаштування (за потреби, у серверному `config/marketplace.php`)
| Ключ | Типово | Призначення |
|---|---|---|
| `suitable_for` | `['students','no_experience','career_switch','junior']` | позначки «Підходить»; вікові значення код відкидає завжди; розширення — лише після юриста |
| `popular_min_hits` | `10` | поріг автоматичних чипів популярних запитів (за 30 днів) |
| `popular_queries_catalog` | `false` | чипи на головній каталогу (не вмикати; запис для каталогу не ведеться) |
| `saved_search_max` | `10` | активних збережених пошуків на користувача |
| `saved_search_email_enabled` | `false` | листи за збереженими пошуками |
| `saved_search_secret` | `''` | секрет HMAC для посилань відписки (≥ 16 символів, випадковий; без нього листи не йдуть) |
| `saved_search_mail_batch` | `50` | листів за один запуск |
| `ip_limit_count` / `ip_limit_saved` | `1500` / `60` | IP-ліміти на добу: лічильник «Показати N результатів» / збереження пошуків |

### 4. Cron — НЕ вмикати зараз
- `mp-cron-expire.php` (уже описаний, крок 8) тепер також видаляє `search_query_stats` і `mp_listing_views_daily` старші за 90 днів. **Налаштовано на проді 2026-11-09:** `15 * * * *` → `/home/gu621051/ailabhub-directory.com/www/public/mp-cron-expire.php` (тестовий запуск — «Виконано», 0,24 с).
- З 2026-11-11 (код ще НЕ на проді) `mp-cron-expire.php` також видаляє запити каталогу без результатів `search_log` старші за `zero_result_retention_days` з `config/search.php` (30 днів; у виводі — `zero_search_deleted`). Нові записи `search_log` маскуються (пошта, телефони, номери карток, 6+ цифр, посилання) і обрізаються до 200 символів. Після заливки перший запуск cron видалить рядки `search_log` старші за 30 днів.
- Листи за збереженими пошуками (коли вирішите ввімкнути: `saved_search_email_enabled => true`, задати `saved_search_secret`, перевірити доставку пошти, крок 9):
  `0 9 * * * php /home/<акаунт>/…/www/public/mp-cron-saved-searches.php` (раз на день) або `…/mp-cron-saved-searches.php?token=<cron_token>`.
  Без цього прапорця скрипт нічого не надсилає (пише `disabled`). Перемикач «Сповіщати поштою» в кабінеті тим часом лише запам'ятовує згоду.
- `cron/marketplace-daily.php` тепер оновлює також `salary_min_usd/salary_max_usd` за курсом НБУ і місто вакансії з геодовідника. Для вже наявних вакансій
  до першого запуску колонки порожні — у фільтр за зарплатою вони потраплять після запуску cron або після редагування.

### 5. Перевірка після заливки
1. `marketplace-category.php?id=<блок «Вакансії»>` — панель фільтрів, «Вакансії за областями» (якщо є вакансії з містом), чипи, «Показати результати: N».
2. Адреса з фільтрами → у коді сторінки `<meta name="robots" content="noindex, follow">` і canonical без фільтрів.
3. `ai-statement.php` → **404** (у тексті ще є маркери [ПІДТВЕРДИТИ]); під admin — сторінка з попередженням; у підвалі посилання немає.
4. `https://<домен>/docs/ai_statement_uk.md` → 403/404.
5. Кабінет: `mp-saved.php`, `mp-seller-settings.php`, «Статистика» біля оголошень; `admin-popular-queries.php` (лише admin).
6. Локальні тести: `php tests/mp-wave1-tests.php` (151 перевірка; лише локально — створює й видаляє свої записи за id).
