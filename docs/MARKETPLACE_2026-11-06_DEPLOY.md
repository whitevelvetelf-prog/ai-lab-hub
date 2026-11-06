# Marketplace 2026-11-06: підтвердження пошти, черга модерації, подача, блоки-категорії — випуск на хостинг

Стан: **не залито**. `public_enabled` і `posting_enabled` не змінювались.

## Порядок
1. Резервна копія БД (phpMyAdmin → Експорт) і коду.
2. SQL **до коду**: `database/migration-2026-11-06-marketplace-verify-drafts.sql` (phpMyAdmin → Імпорт).
   Лише `ADD COLUMN mp_email_verifications.next_path` за перевіркою і `CREATE TABLE IF NOT EXISTS mp_form_drafts`.
   Повторний запуск безпечний. Контроль у кінці файлу: обидва рядки = 1. Код працює і без міграції (без чернеток і next).
3. Код — архів лише з файлами нижче (шляхи від кореня проєкту `www/`), розпакувати в `www` з перезаписом.
4. Ctrl+F5 / перевідкрити застосунок з екрана «Додому» (нова версія sw.js `ailabhub-static-v3`).

## Файли
Нові:
- `app/canonical.php` — 301 з www./http-варіанта на `site_url`
- `app/mp-verify-core.php` — єдине джерело «пошту підтверджено»
- `app/mp-flow-i18n.php` — рядки UA/EN
- `app/mp-drafts.php`, `public/mp-draft.php`, `public/assets/js/mp-draft.js` — чернетки форм

Змінені:
- `app/auth.php`, `app/marketplace-email.php`, `app/marketplace-board.php`, `app/marketplace.php`
- `app/listing.php`, `app/listing-account.php`, `app/listing-admin-cabinet.php`
- `public/login.php`, `public/register.php`, `public/auth-google.php`, `public/auth-google-callback.php`
- `public/mp-verify.php`, `public/mp-verify-email.php`, `public/mp-moderation.php`
- `public/listing-post.php`, `public/marketplace-post.php`, `public/listings.php`, `public/account.php`
- `public/sw.js`, `public/assets/css/mp-public.css`, `public/assets/css/promo-cabinet.css`

**Не заливати** `config/marketplace.php` (на сервері свій). Нові ключі мають значення за замовчуванням у коді:
`show_empty_categories` = false, `canonical_redirect` = true (редірект на `site_url`).

## Що зміниться для користувачів одразу після заливки
- `www.ailabhub-directory.com` і `http://…` → 301 на `site_url` (на проді, судячи з canonical-тегів, `https://ailabhub-directory.com`).
  Перевірити `site_url` у `www/config/marketplace.php` до заливки: саме ця адреса стане єдиною.
- Вхід через Google: колбек лишається `https://www.…/auth-google-callback.php` (як у Google Console); він отримає 301 на
  канонічний хост разом із `code`/`state` — вхід працює без змін у Google Console.
- Файли сесій переїжджають у `www/storage/sessions` (створюється автоматично, поза webroot). **Усі, хто зараз увійшов,
  один раз вийдуть із акаунта.** Якщо PHP не може створити теку — лишаються налаштування хостингу (без помилки).
- Кукі входу живе 30 днів (не «до закриття браузера»).

## Перевірка після заливки
1. `curl -I https://www.ailabhub-directory.com/` → `301`, `Location: https://ailabhub-directory.com/`.
2. `curl -I http://ailabhub-directory.com/login.php` → `301` на https.
3. Вхід через Google → кабінет (не помилка state).
4. Кабінет admin → «Маркетплейс: оголошення» → «Модерація (N)»; у меню CRM «Модерація оголошень (N)».
5. `listings.php?type=job` — блоки категорій або запрошення подати оголошення.
6. Сценарій підтвердження з iPhone — у звіті (розділ «Що перевірити вручну»).
