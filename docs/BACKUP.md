# Резервні копії й відновлення проєкту

## 1. Що є що

| Що | Де лежить | Чим копіюється |
|---|---|---|
| Код | git (`app/`, `public/`, `config/*.example.php`, `database/`, `docs/`, …) | приватний репозиторій (розділ 3) |
| Секрети (паролі БД, ключі API, OAuth, SMTP, токени) | `config/database.php`, `config/translation.php`, `config/ai-assistant.php`, `config/oauth.php`, `config/mail.php`, `config/promo.php`, `config/storage.php`, `config/marketplace.local.php`, `tools/autofill/config.php` | **ніколи не в git** — менеджер паролів або зашифрований архів |
| База даних | MySQL (локально `ailabhub_db`, на хостингу — у phpMyAdmin) | `php scripts/backup-db.php` (локально) / phpMyAdmin → Експорт (хостинг) |
| Завантаження користувачів (фото оголошень, логотипи, банери, обкладинки, файли матеріалів) | `public/uploads/`, `public/assets/images/logos/`, `…/ads/uploads/`, `…/marketplace/covers/`, `storage/marketplace/` (на хостингу — `/home/<акаунт>/marketplace-files/`) | `php scripts/backup-db.php` (локально) / архів теки у файловому менеджері (хостинг) |

## 2. Локальна копія (кожного разу перед великою зміною)

1. Відкрийте термінал у теці проєкту (`C:\laragon\www\ai-lab-hub`).
2. Виконайте:
   ```
   C:\laragon\bin\php\php-8.3.30-Win32-vs16-x64\php.exe scripts\backup-db.php
   ```
3. У теці `backups\` з'являться два файли з датою: `ailh-db-<база>-РРРРММДД-ГГХХСС.sql.gz` і `ailh-uploads-РРРРММДД-ГГХХСС.tar.gz`.
   Скрипт зберігає 7 останніх копій кожного виду і видаляє лише власні старіші копії.
4. Раз на тиждень скопіюйте теку `backups\` на зовнішній диск або в особисту хмару (вона не в git).

Варіанти: `--db-only`, `--files-only`, `--dry-run` (лише показати), `--php-export` (без mysqldump).

## 3. Приватний репозиторій (GitHub)

> Спершу прочитайте `docs/SECRETS_AUDIT.md`: наявний репозиторій `origin` публічний і містить у історії дані, які варто прибрати.

1. github.com → «+» → **New repository** → назва, напр. `ai-lab-hub-private` → **Private** → без README → **Create repository**.
2. У терміналі в теці проєкту:
   ```
   git remote -v                       # подивитися наявні remote
   git remote rename origin old-public # старий публічний — під іншим ім'ям (або git remote remove origin)
   git remote add origin https://github.com/<ваш-логін>/ai-lab-hub-private.git
   git push -u origin main
   git push origin --tags
   ```
3. Перевірте на GitHub, що репозиторій позначено **Private** і що в ньому немає файлів `config/database.php`, `config/*.local.php`, `.env`.

## 4. Відновлення на новому комп'ютері

1. Встановіть **Laragon** (з PHP 8.3+ і MySQL 8) і **Git for Windows**.
2. `cd C:\laragon\www` → `git clone https://github.com/<ваш-логін>/ai-lab-hub-private.git ai-lab-hub`.
3. Конфіги: для кожного `config\*.example.php` створіть копію без `.example` і впишіть свої значення
   (паролі — з менеджера паролів): `database.php`, `translation.php`, `ai-assistant.php`, `oauth.php`, `mail.php`,
   `promo.php`, `storage.php`; за потреби `marketplace.local.php` (з `marketplace.local.example.php`).
4. База: Laragon → «Database» (HeidiSQL) або phpMyAdmin → створіть базу `ailabhub_db` з кодуванням `utf8mb4_unicode_ci`.
5. Розпакуйте останній дамп і імпортуйте:
   ```
   "C:\Program Files\Git\usr\bin\gzip.exe" -dk backups\ailh-db-ailabhub_db-<дата>.sql.gz
   C:\laragon\bin\mysql\mysql-8.4.3-winx64\bin\mysql.exe -uroot ailabhub_db < backups\ailh-db-ailabhub_db-<дата>.sql
   ```
6. Завантаження: розпакуйте `backups\ailh-uploads-<дата>.tar.gz` (7-Zip) і розкладіть теки з архіву:
   `uploads/` → `public\uploads\`, `logos/` → `public\assets\images\logos\`, `ad-uploads/` → `public\assets\images\ads\uploads\`,
   `mp-covers/` → `public\assets\images\marketplace\covers\`, `mp-photos/` і `mp-files/` → теки `photo_dir` і `file_storage_dir`
   з `config\marketplace.php` (локально `storage\marketplace\photos\` і `storage\marketplace\files\`).
7. Laragon → «Start All» → відкрийте `http://ai-lab-hub.test/`.
8. Перевірка: `php scripts\smoke-test.php http://ai-lab-hub.test --stage=view` і `php scripts\schema-check.php --db=ailabhub_db`.

## 5. Хостинг (adm.tools)

- База: adm.tools → Бази даних → «Увійти» → phpMyAdmin → ваша база → **Експорт** → «Швидкий» → SQL → «Вперед».
- Файли: файловий менеджер → `www` → «Архівувати» → завантажте архів собі; окремо тека `marketplace-files` поза `www`.
- Робить це власниця перед кожним релізом (див. `docs/RELEASE_STAGE_A.md`).
