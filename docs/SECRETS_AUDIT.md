# Аудит секретів (2026-11-22)

Перевірено ВСЮ історію git (`git log --all -p`) і поточне дерево. Значення не наводяться — лише шлях, коміт і статус.

## Що шукали

`config/database.php`, `config/translation.php`, `config/ai-assistant.php`, `config/oauth.php`, `config/mail.php`,
`config/promo.php`, `config/storage.php`, `config/marketplace.local.php`, `.env`, ключі API за форматами
(Google/Gemini `AIza…`, Anthropic `sk-ant-…`, OpenAI `sk-…`, GitHub `ghp_…`, Google OAuth `GOCSPX-…`, Slack `xox…`),
приватні ключі (`BEGIN … PRIVATE KEY`), присвоєння `*_api_key` / `password` / `secret` / `token` з непорожнім значенням,
посилання на банку monobank, номери карток (16 цифр, перевірка Луна), SQL-дампи з користувачами, `storage/`, `logs/`,
`backups/`, `public/uploads/`, архіви збірки `*.zip` / `*.tar.gz`, `marketplace-seed/`, `tools/autofill/config.php`.

## Результат

| Що | Де | Коміт | Поточне дерево | Історія | Опубліковано на GitHub* |
|---|---|---|---|---|---|
| Робочі конфіги з секретами (`config/database.php`, `translation.php`, `ai-assistant.php`, `oauth.php`, `mail.php`, `promo.php`, `storage.php`, `marketplace.local.php`, `.env`) | — | — | **відсутні** (у .gitignore) | **ніколи не комітились** | ні |
| Ключі API за форматами (Gemini, Anthropic, OpenAI, GitHub, Google OAuth, Slack), приватні ключі | — | — | відсутні | відсутні | ні |
| Присвоєння `$claude_api_key`, `$gemini_api_key`, `$translation_api_key`, `$password`, `$secret`, `gemini_api_key` | `config/*.example.php`, `tools/eli-selftest.php`, `tests/eli-quota-tests.php` | 8a0d5f9, 1ece136, a660619, 06815e6, b8699a6, 14de07a | є | є | так |
| ↳ статус значень | усі 7 — **заглушки** (`your…`, `test…`, `example…`), не справжні ключі | | | | |
| Секрети в `config/marketplace.php` (`cron_token`, `rate_limit_salt`, `saved_search_secret`, `messaging_secret`) | `config/marketplace.php` | — | **порожні** | завжди порожні | так (порожні) |
| Посилання на банку monobank (справжнє) | `public/donate.php` | bb1834d (2026-09-17, додано), ee211d3 (2026-10-11, прибрано) | **відсутнє** (з 2026-10-11 — лише в БД `site_settings`) | **є** | **так** |
| Номер картки, проходить перевірку Луна, ймовірно справжній (маска 4874…23) | `public/donate.php` | bb1834d | відсутній | **є** | **так** |
| Тестові номери карток (4111…, 4149…, 4567…) | `tests/donate-tests.php`, `tests/ai-fixes-tests.php` | a4008d4, 6bd979e | є | є | ні (лише локально) |
| Дамп живої бази з таблицею `users` (1 хеш пароля bcrypt, 2 адреси пошти) | `database/export_live_full.sql` | bb1834d | **є** | є | **так** |
| Дамп категорій без персональних даних | `database/export_live.sql` | 0c70d64 | є | є | так (без ПД) |
| `storage/`, `logs/`, `backups/`, `public/uploads/*` (крім index.html/.htaccess), `deploy*.zip`, `*.tar.gz` | — | — | на диску, у .gitignore | **ніколи не комітились** | ні |
| `marketplace-seed/` (власні безкоштовні матеріали, не секрет) | — | def6134 / 8577b05 | відсутня | є | так |
| `tools/autofill/config.php` (ключ API автонаповнення) | — | — | на диску, у .gitignore | ніколи не комітився | ні |
| Налаштування донатів у SQL (`site_settings` `donate_*`) | — | — | відсутні | відсутні | ні |

\* **Remote `origin` = GitHub, репозиторій ПУБЛІЧНИЙ** (перевірено 2026-11-22 запитом до API без входу), останнє
відправлення 2026-10-28 (`origin/main` = `d774cb8`). Коміти bb1834d і ee211d3 — у `origin/main`, тобто вже доступні всім.

## Висновок: чи безпечно додавати / використовувати віддалений репозиторій

**Ні, у поточному вигляді — ні**, доки не виконано план нижче. Ключів API й паролів у git немає, але в історії є
персональні дані (дамп `users`) і реквізити донатів, а наявний remote публічний.

## План (НЕ виконано — рішення за власницею)

1. **Одразу (5 хв):** GitHub → репозиторій → Settings → General → Danger Zone → **Change visibility → Private**.
   Це не видаляє історію, але закриває її від сторонніх.
2. **Користувач із дампу** `database/export_live_full.sql`: змінити йому пароль на сайті (хеш bcrypt міг бути скопійований);
   якщо це обліковий запис власниці — змінити свій пароль.
3. **Номер картки** з bb1834d: картка публікувалась і на сторінці донатів, тож сам номер не є таємницею, але якщо картка
   більше не використовується для донатів — нічого робити не треба; якщо використовується — розглянути перевипуск у банку.
   Посилання на банку — публічне за природою (воно на сайті), перевипуск не потрібен.
4. **Ключі API, OAuth client secret, SMTP, токени cron перевипускати не потрібно** — вони ніколи не потрапляли в git.
5. **Чиста історія.** Рекомендую новий приватний репозиторій без історії:
   `git checkout --orphan clean-main` → `git rm --cached database/export_live_full.sql` (файл лишається на диску, вже під
   `.gitignore`-правилом за потреби) → один коміт «Початковий стан» → новий приватний remote. Старий публічний репозиторій —
   зробити приватним або видалити на GitHub (робить власниця). Альтернатива зі збереженням історії —
   `git filter-repo --path database/export_live_full.sql --invert-paths` + переписування `public/donate.php` у bb1834d…ee211d3,
   але тоді всі хеші комітів зміняться, і старий публічний репозиторій однаково треба закрити.
6. Після цього — лише приватний remote, `git push` робить власниця (у цій роботі нічого не відправлялось).

Покроково про приватний репозиторій і відновлення на новому комп'ютері — `docs/BACKUP.md`.
