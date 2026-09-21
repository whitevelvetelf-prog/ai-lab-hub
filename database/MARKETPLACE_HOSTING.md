# Marketplace: випуск на хостинг (Хостинг Україна, adm.tools)

Стан на 2026-09-21: **на хостинг нічого не залито**. Код Marketplace у збірку потрапляє лише з прапорцем `-IncludeMarketplace`; публічна частина вимкнена перемикачем `public_enabled`.

## 0. Що де лежить

| Що | Файл | Коли |
|---|---|---|
| Таблиці `mp_*` (9 шт., з COLLATE), стартові категорії й продавець | `hosting-upload/04-marketplace-core.sql` (= `database/migration-2026-09-21-marketplace-core.sql`) | до коду |
| Тексти інтерфейсу EN + EN-назви категорій | `hosting-upload/05-marketplace-ui-strings.sql` (= `database/migration-2026-09-21-marketplace-ui-strings.sql`) | після 04 |
| Код (CRM + публічна частина + шаблон конфігу) | `powershell -ExecutionPolicy Bypass -File scripts/build-deploy.ps1 -IncludeMarketplace -Output deploy-mp.zip` | після баз і теки |

Обидва SQL безпечно запускати повторно (`CREATE TABLE IF NOT EXISTS`, `INSERT ... WHERE NOT EXISTS` / `INSERT IGNORE`); у них немає `DROP`/`DELETE`/`TRUNCATE`/`ALTER`.

Звичайна збірка **без** прапорця (`build-deploy.ps1`) Marketplace-сторінок, CRM, міграцій і `config/marketplace.php` не містить. Спільний код, який лише «спить» за перемикачем (`app/marketplace.php`, `app/mp-card.php`, шапка, підвал, головна, `translations.php`), їде завжди — без конфігу `public_enabled` = `false`, тож на сайті нічого не змінюється.

## 1. Тека для файлів пропозицій — ПОЗА webroot

Файли (pdf, md, txt, json, csv, zip), які завантажують у CRM, зберігаються під випадковими іменами й віддаються тільки через `get.php` для залогінених. Тека **не повинна** бути доступна за URL.

1. adm.tools → **Хостинг** → ваш акаунт → **Файловий менеджер** (або FTP).
2. Знайдіть корінь сайту (тека, у якій лежить `public` або `www`, куди розпаковується код). Тека **на рівень вище веб-кореня** (веб-корінь = тека, яку віддає домен) — поза webroot.
   - Якщо домен дивиться на теку `public` проєкту (поруч лежать `app/`, `config/`) — корінь проєкту вже поза webroot.
   - Якщо домен дивиться на теку `www`, а проєкт лежить усередині неї — створіть теку поруч із `www`, а не в ній.
3. Створіть теку, напр. `marketplace-files`. Права: **750** (або 755), власник — користувач PHP (стандартно на shared-хостингу це ваш акаунт). PHP має вміти в неї **писати** (для завантаження в CRM) і **читати** (для `get.php`).
4. Дізнайтеся абсолютний шлях: у файловому менеджері він видно вгорі (`/home/<акаунт>/<домен>/...`). Перевірити напевно: тимчасово залийте `pathcheck.php` з вмістом `<?php echo dirname($_SERVER['DOCUMENT_ROOT']);` у веб-корінь, відкрийте його в браузері, **одразу видаліть**.
5. Перевірка, що тека закрита: спробуйте відкрити в браузері `https://<домен>/marketplace-files/` — має бути 404/403, а не список файлів.

Значення для конфігу — повний шлях **без слеша в кінці**, наприклад `/home/gu621051/ailabhub.example/marketplace-files`.

## 2. Тека для обкладинок (у webroot)

CRM зберігає обкладинки в `public/assets/images/marketplace/covers/`. Створіть її (або `public/assets/images/marketplace/` — код створить `covers` сам, якщо PHP має право писати), права 755/775. Цю теку збірка не перезаписує (обкладинки — користувацький контент, як логотипи).

## 3. Конфіг на хостингу

Реальний `config/marketplace.php` збірка **ніколи** не кладе під цим іменем (щоб деплой не затирав налаштування сервера). З `-IncludeMarketplace` у архіві є шаблон `config/marketplace.dist.php`:

1. У файловому менеджері скопіюйте `config/marketplace.dist.php` → `config/marketplace.php`.
2. Змініть два рядки:

```php
'file_storage_dir' => '/home/gu621051/ailabhub.example/marketplace-files',   // шлях із кроку 1
'public_enabled'   => false,                                                 // true — лише на запуску (крок 5)
```

3. Решту (`max_upload_bytes`, `max_cover_bytes`, `allowed_extensions`) не чіпайте, доки не треба. Ліміт файлу за замовчуванням 10 МБ; реально його обмежують ще `upload_max_filesize` і `post_max_size` у налаштуваннях PHP (adm.tools → Хостинг → PHP: поставте ≥ 12M обидва).
4. Файл `config/marketplace.local.php` (локальне перевизначення) на хостингу **не потрібен**.

## 4. Порядок випуску

1. phpMyAdmin → **Експорт** (резервна копія бази).
2. Імпорт `04-marketplace-core.sql`, потім `05-marketplace-ui-strings.sql` (utf-8). Перевірка: `SELECT COUNT(*) FROM mp_categories;` → 7, `SELECT COUNT(*) FROM mp_sellers;` → 1.
3. Створити теки (кроки 1–2) і `config/marketplace.php` з `public_enabled = false` (крок 3).
4. Зібрати й залити код: `build-deploy.ps1 -IncludeMarketplace -Output deploy-mp.zip`, розпакувати в корінь сайту з перезаписом. Після цього Ctrl+F5.
5. У CRM (`mp-list.php`, `mp-add-offer.php`, роль employee/admin) створити пропозицію (краще по одній кожного типу: link, file, contact), опублікувати. Публічно все ще 404 — це нормально.
6. Увімкнути: у `config/marketplace.php` поставити `'public_enabled' => true`. Пункт «Marketplace» з'явиться в меню, підвалі й на головній, щойно є хоча б одна опублікована пропозиція.
7. Перевірити гостем і залогіненим: `marketplace.php`, картку, «Отримати» для link/contact, для file — гість бачить «Потрібен вхід», залогінений отримує файл.

**Відкат:** `'public_enabled' => false` у `config/marketplace.php` — усі публічні сторінки віддають 404, пункти меню зникають. База й файли лишаються.

## 5. Що варто знати

- Ліміт «Отримано» — не частіше 1 разу на добу для пари (користувач + пропозиція). Для гостя ліміт тримається в сесії (у `mp_claims` немає колонки сесії); очистивши cookie, гість може порахуватися знову.
- Усі файли мають `scan_status = 'pending'`: антивірусної перевірки ще немає. Видача блокується лише для статусів `infected` / `blocked`.
- Ціни, рейтинги й відгуки в Marketplace відсутні; усі пропозиції безкоштовні (`pricing_model = 'free'`).

---

## 5. Дошка оголошень (етап 4) — НЕ залито на хостинг

Стан: код і SQL готові, **на хостинг нічого не заливалось**, `public_enabled` лишається `false`.

### 5.1 SQL (після 04 і 05, у phpMyAdmin, utf-8)

| Файл | Що робить |
|---|---|
| `hosting-upload/06-marketplace-classifieds.sql` (= `database/migration-2026-09-21-marketplace-classifieds.sql`) | 11 нових колонок `mp_listings` (лише `ALTER ... ADD COLUMN`, кожна — після перевірки в `information_schema`), 3 індекси (`CREATE INDEX` з такою ж перевіркою), таблиці `mp_listing_photos`, `mp_reports`, `mp_favorites`, `mp_contact_reveals`, 9 стартових категорій розділу `board` |
| `hosting-upload/07-marketplace-ui-strings-classifieds.sql` | EN-тексти інтерфейсу (147 ключів `mpb_*`) і EN-назви категорій дошки |

Обидва можна запускати повторно. Перевірка: `SELECT COUNT(*) FROM mp_categories WHERE section='board';` → 9.

### 5.2 Тека фото та PHP-налаштування

- Фото зберігаються в **`public/uploads/marketplace/`** (у вебі). Тека має бути доступна PHP на запис (755/775). Код створить її сам; збірка з `-IncludeMarketplace` кладе туди `.htaccess`.
- `.htaccess` віддає лише `jpg/png/webp` під випадковими іменами й забороняє виконання PHP. **Перевірка після заливки:** створіть у теці `probe.php` з `<?php echo 'X';`, відкрийте `https://<домен>/uploads/marketplace/probe.php` — має бути 403 (не «X»), потім видаліть файл. Якщо виходить «X» або 200 — хостинг ігнорує `.htaccess` (`AllowOverride None`): публікацію вмикати не можна, поки не закрито виконання PHP у цій теці.
- До 8 фото по 5 МБ: у PHP (adm.tools → Хостинг → PHP) поставте `upload_max_filesize` ≥ 6M, `post_max_size` ≥ 48M, `max_file_uploads` ≥ 8, `memory_limit` ≥ 128M. Розширення `gd` (з WebP) і `fileinfo` мають бути ввімкнені.
- Ліміти та антиспам — у `config/marketplace.php`: `photo_max_count`, `photo_max_bytes`, `listing_ttl_days` (30), `max_active_per_user` (5), `max_new_per_day` (10), `max_links_in_desc` (2), `stop_words` (порожньо), `reveals_per_day` (30), `reports_threshold` (3).

### 5.3 Cron: завершення терміну (`mp-cron-expire.php`)

Скрипт переводить `published → expired` (і пише в журнал). Публічні сторінки перевіряють `expires_at > NOW()` самі, тож без cron сайт працює правильно — cron лише «прибирає» статуси.

adm.tools → Хостинг → **Cron** → додати завдання раз на годину:

```
0 * * * * php /home/<акаунт>/<домен>/public/mp-cron-expire.php
```

(шлях — до реального `public/mp-cron-expire.php`; версію PHP оберіть таку саму, як у сайту). Якщо cron хостингу вміє лише викликати URL: у `config/marketplace.php` задайте довгий випадковий `'cron_token' => '...'` і викликайте `https://<домен>/mp-cron-expire.php?token=<ключ>`. Порожній `cron_token` (за замовчуванням) → HTTP-доступ до скрипта вимкнений (404).

### 5.4 Порядок випуску (коли вирішите)

1. Резервна копія бази. 2. Імпорт 06, потім 07. 3. Налаштування PHP і cron (5.2, 5.3). 4. Код: `build-deploy.ps1 -IncludeMarketplace`. 5. Перевірка `.htaccess` (5.2). 6. Ще з `public_enabled=false` переглянути CRM: `mp-moderation.php`, `mp-list.php`. 7. `'public_enabled' => true`, пройти сценарій: подати оголошення → схвалити → побачити в списку → показати контакт.

Публічна частина не вимагає підтвердження email: у системі його немає (див. звіт етапу 4).
