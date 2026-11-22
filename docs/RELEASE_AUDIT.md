# Аудит перед релізом Marketplace (2026-11-22)

Частина 0 завдання «Підготовка релізу Marketplace» — розвідка, лише читання (крім виправлення трьох тестів, див. нижче).
Нічого не залито на хостинг і нічого не відправлено у віддалений репозиторій.

## 1. Стан репозиторію

- Гілка `main`, робоче дерево чисте на початку роботи; remote не налаштовано (`git remote -v` порожній).
- Останній коміт перед аудитом: `9e82a08` (2026-11-21, наповнення підкатегорій). Останні 60 комітів:
  продуктові пакети (лише БД), геолокація (2026-11-19), повідомлення (2026-11-18), Правила й юридичні механізми (2026-11-17),
  контакти, Хвиля 1 (2026-11-09) — див. `git log --oneline -60`.

## 2. Що зараз на живому сайті (базова точка)

**Важливо: завдання описує Marketplace як ще не випущений, але живий сайт уже давно працює з ним.**
За журналом розгортань (`database/MARKETPLACE_HOSTING.md`, нотатки розгортань у `docs/`) і пам'яттю проєкту:

| Функція | На проді з | Стан на проді |
|---|---|---|
| Marketplace відкритий для перегляду (`public_enabled` + `site_settings.marketplace_public = 1`) | 2026-10-19 | увімкнено |
| Подача оголошень для всіх (`posting_enabled = true` у серверному `config/marketplace.php`) | 2026-09-28 | увімкнено |
| Геолокація, «Поблизу мене», географія реклами, країна за IP | 2026-11-03 / 2026-11-19 | увімкнено |
| Дерево категорій, верифікація, чернетки | 2026-11-06 | є |
| Хвиля 1 (фільтри вакансій, збережені пошуки, сторінка продавця, статистика) | 2026-11-09 | є |
| Правила й юридичні механізми (міграція `marketplace_legal_migration.sql`) | 2026-11-17 / 2026-11-18 | є |
| Внутрішні повідомлення (`config/marketplace.local.php` на сервері: `messaging_enabled => true`) | 2026-11-18 | увімкнено |
| Міграції № 26–28 (країна за IP, частини міст, EN-тексти правових сторінок) | 2026-11-19 | застосовано |

**Перевірка без входу (лише GET, 2026-11-22):** усі 38 статичних файлів `public/assets/js/**`, `public/assets/css/**`,
`public/sw.js`, `public/manifest.json` на живому сайті збігаються з `HEAD` побайтно (без урахування CRLF), зокрема
`share-button.js/.css` з останнього кодового коміту `8840975` (2026-11-21). PHP-файли так перевірити не можна.

**Висновок:** найімовірніша базова точка коду на живому сайті — `9e82a08` (після `8840975` були лише SQL-пакети продуктів,
уже застосовані на проді). Упевненість висока для статичних файлів, середня для PHP (за журналом розгортань).
У `hosting-upload/` немає `CHECKSUMS.txt` і `marketplace-ALL-*.sql`; архіви `deploy*.zip` у корені — від 2026-10-07 до 2026-10-19
(старі, пізніші архіви не зберігались). Тому порівняння в майбутньому — через `hosting-upload/RELEASE_MANIFEST.txt` (частина 3).

## 3. Матриця готовності

Тести запускались локально 2026-11-22 на PHP 8.3.30 (той, що в Laragon Apache; CLI-збірки 8.5/8.6 без php.ini не мають pdo_mysql і mbstring).

| Функція | Є в коді | Тести | Прапор (типове значення в git) | Стан на проді |
|---|---|---|---|---|
| Дерево категорій і блоки | так | `mp-tree-e2e` 48/48 | розділ цілком — `public_enabled` (false) + `marketplace_public` (0) | на проді |
| Пошук з індексом і синонімами | так | `search-tests` OK, `catalog-fill-tests` 38/38 | без прапора (індекс заповнюється сам) | на проді |
| Підтвердження пошти | так | `mp-flow-e2e` 49/49 (після виправлення тесту) | частина Marketplace (`public_enabled`) | на проді |
| Подача й модерація | так | `mp-flow-e2e` 49/49, `mp-legal-e2e` OK, `mp-photo-e2e` 35/35 | `posting_enabled` — **true** у git (не вимкнено за замовчуванням) | увімкнено |
| Фільтри вакансій | так | `mp-wave1-tests` OK | без окремого прапора (у межах `public_enabled`) | на проді |
| Збережені пошуки | так | `mp-wave1-tests` OK | сама функція без прапора; листи — `saved_search_email_enabled` (false) | на проді, листи вимкнено |
| Сторінка продавця й статистика | так | `mp-wave1-tests` OK | без окремого прапора (`page_public` у кожного продавця) | на проді |
| Повідомлення між користувачами | так | `mp-messages-e2e` 79/79 | `messaging_enabled` (false), листи `messaging_email_enabled` (false) | **увімкнено** (`marketplace.local.php`) |
| Геолокація й таргетинг реклами | так | `mp-geo-tests` OK, `geo_match_test` OK | `config/geo.php` `geo_ip_enabled` — **true** у git; решта без прапора | увімкнено |
| Сторінка «Як ми використовуємо АІ» | так | `ai-statement-tests` OK | сама себе ховає (404), поки в `docs/ai_statement_uk.md` є маркери | 404 (10 маркерів) |
| Донати | так | `donate-tests` OK | `site_settings` (кабінет «Донати») | на проді (лише банка) |
| Еля й переклади | так | `eli-quota-tests`, `eli-sensitive-tests` 23/23, `ai-fixes-tests` OK | налаштування Елі в БД/`config/ai-assistant.php` (не в git) | на проді |

Решта набору: `asset-tests`, `crm-campaign-csrf-tests`, `public-csrf-tests`, `account-admin-render-tests` 17/17,
`outreach-tests` 79/79, `promo-fx-tests` 28/28, `promo-internal-tests` 67/67, `promo-quiet-tests` 31/31 — усе пройдено.
Тестові записи тести прибирають самі (кожен друкує «тестових записів не лишилося»).

**Виправлено (окремий коміт частини 0):** `tests/mp-flow-e2e.php`, `tests/mp-tree-e2e.php`, `tests/mp-photo-e2e.php` падали
(10/49, 40/48, 24/35) не через код сайту, а тому, що POST входу в тесті не передавав CSRF-токен, обов'язковий з 2026-11-11.
Тепер токен береться з форми входу; результати 49/49, 48/48, 35/35.

## 4. Міграції

Нумерація Marketplace — за `database/MARKETPLACE_HOSTING.md` і `hosting-upload/*/`. «б/н» — міграція без номера.
Колонка «двічі» заповнена за репетицією частини 3 (`docs/RELEASE_REHEARSAL.md`).

| № | Файл `database/` | Копія в `hosting-upload/` | Залежить від порядку |
|---|---|---|---|
| 04 | migration-2026-09-21-marketplace-core.sql | ні (пакет видалено 2026-10-06) | база сайту (users, ui_translations) |
| 05 | …-09-21-marketplace-ui-strings.sql | ні | 04 |
| 06 | …-09-21-marketplace-classifieds.sql | ні | 04 |
| б/н | …-09-21-marketplace-rename-hardware.sql | ні | 06 |
| 07 | …-09-21-marketplace-ui-strings-classifieds.sql | ні | 06 |
| 08 | …-09-21-marketplace-email-verification.sql | ні | 04 |
| 09 | …-09-21-marketplace-ui-strings-email.sql | ні | — |
| 10 | …-09-21-marketplace-ui-strings-rules.sql | ні | — |
| 11 | …-09-21-marketplace-rules-version.sql | ні | 06 |
| 12 | …-09-21-marketplace-rate-limits.sql | ні | — |
| 13 | …-09-21-marketplace-ui-strings-ratelimit.sql | ні | — |
| 14 | …-09-21-marketplace-ui-strings-posting.sql | ні | — |
| б/н | …-09-24-marketplace-ui-strings-offer.sql | ні | — |
| б/н | …-10-10-marketplace-solution-ads.sql | ні | 04, рекламні таблиці (campaigns) |
| б/н | …-10-10-marketplace-ui-strings-nav.sql, …-solutions.sql | ні | — |
| б/н | …-10-16-marketplace-switch.sql | ні | site_settings |
| б/н | …-10-19-marketplace-listings.sql | ні | 06 |
| б/н | …-11-03-search-index.sql | ні | products |
| 15 | …-11-03-marketplace-geo-places.sql (+ дані GeoNames `geo-data-01…05`) | так, `marketplace-geo/` | — |
| 16 | …-11-03-marketplace-listing-geo.sql | так | 06, 15, fx_rates |
| 17 | …-11-03-marketplace-ui-strings-geo.sql | так | — |
| 18 | …-11-06-marketplace-category-tree.sql | так, `marketplace-tree/` | 04, 06 |
| 19 | …-11-06-marketplace-ui-strings-tree.sql | так | — |
| б/н | …-11-06-marketplace-verify-drafts.sql | ні | 04 |
| 20 | …-11-09-marketplace-wave1.sql | ні | 04, 06 |
| 21 | …-11-09-marketplace-ui-strings-wave1.sql | ні | — |
| б/н | …-11-10-ai-statement-ui.sql | ні | — |
| б/н | marketplace_legal_migration.sql (2026-11-17) | ні | 06, users |
| 22 | …-11-18-marketplace-messaging.sql | так, `marketplace-messaging/` | 06, legal |
| 23 | …-11-18-marketplace-ui-strings-messaging.sql | так | — |
| 24 | …-11-19-ad-geo.sql | так, `geo-ads/` | 15, рекламні таблиці |
| 25 | …-11-19-geo-ui-strings.sql | так | — |
| 26 | …-11-19-geo-ip-on.sql | ні | — |
| 27 | …-11-19-geo-place-sections.sql (+ дані `geo-sections-01`) | дані так, `marketplace-geo-local/` | 15 |
| 28 | …-11-19-legal-pages-en.sql | ні | — |

Жодна з них не містить `DROP` / `TRUNCATE` / `DELETE` (перевірено пошуком поза коментарями). Є `UPDATE` за (section, slug)
у № 18 і `rename-hardware`, `UPDATE campaigns` у `solution-ads`, `UPDATE mp_listings` для заповнення нових колонок у № 16 і
`ON DUPLICATE KEY UPDATE` EN-рядків інтерфейсу (№ 25, 26, 28, `ai-statement-ui`, `marketplace-switch`). Повторний запуск на
проді не ламає даних, але **може повернути назви/порядок категорій чи EN-тексти, змінені пізніше вручну** — тому на живому
сайті, де все це вже застосовано, пакет повторно імпортувати не потрібно (див. `hosting-upload/INDEX.md`).

## 5. Блокери й маркери

- Падаючі тести: немає (після виправлення трьох тестів).
- `docs/ai_statement_uk.md`: **10 маркерів `[ПІДТВЕРДИТИ]`** → сторінка `ai-statement.php` лишається 404 (так задумано).
- `docs/marketplace_rules_uk.md`: маркерів немає, слова «ЧЕРНЕТКА» немає, «Редакція від [MP_RULES_VERSION]» підставляється
  з `MP_RULES_VERSION = 2026-11-17`. Отже `mp-rules.php`/`marketplace-rules.php` **не** 404 — це розходиться з очікуванням
  завдання для режиму view («404, поки є маркери»): маркерів уже немає.
- Незавершене: листи збережених пошуків і листи про повідомлення (немає секретів і cron, пошта на проді не готова);
  DMARC для домену не налаштовано.

## 6. Висновок

| Функція | Рішення |
|---|---|
| Дерево, пошук, підтвердження пошти, фільтри вакансій, збережені пошуки (без листів), продавець і статистика, донати, Еля | **входить у реліз** (тести пройдені; на проді вже працює) |
| Подача й модерація | **входить**, але `posting_enabled` у git = true, тобто не «вимкнено за замовчуванням»; керування — серверним конфігом (етап A/B) |
| Сторінка «Як ми використовуємо АІ» | **вимкнено** (сама ховається до зняття маркерів) |
| Листи збережених пошуків, листи про повідомлення | **вимкнено прапором** |
| Повідомлення між користувачами | за правилом завдання — **виключити з першого релізу** (етапні конфіги ставлять `messaging_enabled=false`), **але на проді вже ввімкнено** — вимикати чи ні, вирішує власниця |
| Геотаргетинг реклами й країна за IP | за правилом — **виключити** (`geo_ip_enabled` у git = true, окремого прапора таргетингу немає), **але на проді вже працює** |

Функцій без тестів у переліку немає; функції без прапора, вимкненого за замовчуванням, — геотаргетинг (див. вище).
