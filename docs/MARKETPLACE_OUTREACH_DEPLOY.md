# Деплой: оголошення компаній (M1), ліди (M2), аутріч (M3)

Стан на 2026-10-19: **нічого не залито**. Після деплою маркетплейс лишається прихованим (`marketplace_public` не
змінюється), аутріч вимкнений (`outreach_enabled = 0`), усі джерела лідів вимкнені.

## 1. Резервна копія
phpMyAdmin → `gu621051_ailabhublive` → «Экспорт» (швидкий, SQL). Файловий менеджер — копія `www/app`, `www/public`.

## 2. SQL — ДО коду
phpMyAdmin → `gu621051_ailabhublive` → «Импорт» → `database/increment_latest.sql` → «Вперёд».
Останній запит файлу — перевірка: `mp_tables=2, outreach_tables=6, focus_tags=8, outreach_enabled=0`.
Повторний запуск безпечний (лише CREATE IF NOT EXISTS / ADD COLUMN за перевіркою / INSERT IGNORE).

## 3. Код
Архів `deploy-2026-10-19-marketplace-outreach.zip` (у корені проєкту, не в git; 29 файлів, лише файли без тек):
завантажити в `ailabhub-directory.com/` → позначити → Shift+7 → `www` → ✓.

| Тека | Файли |
|---|---|
| `app/` | listing.php, listing-i18n.php, listing-account.php, listing-admin-cabinet.php, outreach.php, outreach-admin.php, outreach-mail.php, outreach-mail-admin.php — **нові**; mp-section-nav.php, promo-mail.php, eli.php — **змінені** |
| `public/` | listings.php, listing.php, listing-post.php, listing-go.php, listing-report.php, listing-action.php, listing-admin-action.php, marketplace-join.php, unsubscribe.php, outreach-export.php — **нові**; account.php, sitemap.php, robots.txt, assets/css/mp-public.css, assets/css/promo-cabinet.css — **змінені** |
| `cron/` | marketplace-daily.php, outreach-daily.php, outreach-send.php — **нові** |

`config/*.php` не змінювались і в архів не входять. Нових ключів конфігу немає: усі налаштування — у `site_settings`
(кабінет адміна). `tests/` і `docs/` на хостинг не потрібні.

Змінені спільні файли — повні версії з `main`: `app/promo-mail.php` (підтримка `mail_queue.headers_json`; інші листи
без змін), `app/eli.php` (необов'язковий параметр temperature), `public/account.php` (два нові розділи-акордеони),
`public/sitemap.php` (живі оголошення, лише коли маркетплейс показано).

## 4. Cron (adm.tools → «Розклад завдань», часовий пояс панелі — Київ)

| Завдання | Розклад | Команда |
|---|---|---|
| Оголошення: прострочення, листи, звіти | щодня 03:30 (`30 3 * * *`) | `/home/gu621051/ailabhub-directory.com/www/cron/marketplace-daily.php` |
| Збір лідів | щодня 04:40 (`40 4 * * *`) | `/home/gu621051/ailabhub-directory.com/www/cron/outreach-daily.php` |
| Аутріч: диспетчер | кожні 10 хв (`*/10 * * * *`) | `/home/gu621051/ailabhub-directory.com/www/cron/outreach-send.php` |

`promo-mail` (кожні 5 хв) уже налаштований — саме він надсилає листи з `mail_queue`. Поки аутріч вимкнено,
`outreach-send` лише записує «аутріч вимкнено» в `cron_runs`.

## 5. Перевірка після деплою
1. `https://ailabhub-directory.com/listings.php?type=job` у приватному вікні → сторінка «Скоро» (noindex).
2. Увійти адміном → кабінет → «Маркетплейс: оголошення»: вкладки Модерація, Усі оголошення, Налаштування, Ліди,
   Джерела лідів, Аутріч, Налаштування аутрічу, Список заборон, Показники аутрічу, Стан; «Аутріч: ВИМКНЕНО».
3. Під адміном `listings.php?type=job` відкривається (noindex), `listing-post.php?type=course` показує форму.
4. `https://ailabhub-directory.com/sitemap.xml` — без `listing.php` (поки маркетплейс приховано).
5. `https://ailabhub-directory.com/unsubscribe.php?t=x` → «Посилання недійсне».
6. Наступного дня у вкладці «Стан» — запуски `marketplace-daily`, `outreach-daily`, `outreach-send` зі статусом ok.

## 6. Далі (рішення власника)
- Вкладка «Налаштування»: дата «Безкоштовне розміщення до», строк оголошення (60 днів), мета розгляду (48 год).
- Перевірити теги «AI-спрямування» (8 чернеткових) і Правила маркетплейсу: п. 7.1 каже «30 днів», а строк оголошень
  компаній — 60 (налаштування); заборонені категорії для вакансій/курсів/послуг показуються у формі.
- Ліди: увімкнути потрібні джерела, задати виключені країни; Remotive не вмикати.
- Аутріч — лише після чек-листа з [OUTREACH_PLAYBOOK.md](OUTREACH_PLAYBOOK.md), розділ 2 (скринька partners@,
  SMTP, DMARC, юридична адреса, перевірка правил).
