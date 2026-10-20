# Цифрові матеріали маркетплейсу (2026-10-22)

Зображення, ілюстрації й персонажі (`mp_listings.section = 'asset'` + `mp_assets`). Логіка — `app/asset.php`,
тексти — `app/asset-i18n.php`, адмінка — `app/asset-admin.php` (вкладки в «Маркетплейс: оголошення»).
Міграція — `database/migration-2026-10-22-digital-assets.sql`. Перевірки — `php tests/asset-tests.php`.

## Чесно про захист

Повністю унеможливити копіювання того, що показано на екрані, неможливо. Заходи:
приватні оригінали (поза `public/`), малоцінні превʼю (зменшені, без EXIF, з водяним знаком по всьому
зображенню), підписані адреси превʼю з терміном дії, ліміти й тимчасові блоки на анонімний хеш IP,
журнал завантажень (`asset_downloads`), XMP з `download_id` у виданому файлі (легко прибрати — це доказова
підтримка), sha256 + dHash і сигнал «схоже на #N» модератору, «Підтвердження публікації» (технічний запис,
не свідоцтво), robots.txt і `noai/noimageai` (добровільні сигнали), скарги з автоприховуванням.
Невидимої мітки й C2PA немає (надійно на GD не зробити).

## Ліцензії

`asset_license_types`: view_only, personal_free, cc_by, commercial_paid, custom (тексти — ЧЕРНЕТКИ для юриста).
Оригінал завантажується лише для personal_free / cc_by / custom і лише якщо автор дозволив
(`mp_assets.allow_download`); view_only і commercial_paid — ніколи. Платежів немає: «Зв'язатися з автором»
(контакти через `mp-contact.php`, як у дошці).

## Розгортання на хостингу (adm.tools)

1. **Приватні каталоги поза коренем сайту.** Менеджер файлів → `/home/gu621051/marketplace-files/` (там, де
   вже `photos`) → створити теки `assets-original` і `assets-preview` (права 750).
2. **config/storage.php** (не в git; створити в `www/config/` за шаблоном `config/storage.example.php`):
   ```php
   <?php
   return [
       'assets_original_dir' => '/home/gu621051/marketplace-files/assets-original',
       'assets_preview_dir'  => '/home/gu621051/marketplace-files/assets-preview',
       'secret'              => '…64 випадкові hex-символи…',
   ];
   ```
   Секрет: `php -r "echo bin2hex(random_bytes(32));"` (або будь-який генератор паролів, ≥ 32 символи).
3. **Розширення PHP.** Адмінка → «Маркетплейс: оголошення» → «Активи: налаштування» → «Стан сервера»:
   GD (обов'язково), fileinfo (обов'язково), WebP і EXIF (бажано). Без GD публікація активів вимикається
   з поясненням (форма віддає 503, у лог пишеться причина). Imagick не потрібен.
4. **Ліміти завантаження.** Там само видно `upload_max_filesize` / `post_max_size`; вони мають бути ≥
   `assets_max_mb` (початково 20 МБ). Якщо менші — зменште `assets_max_mb` або підніміть ліміти в
   налаштуваннях PHP хостингу.
5. **SQL** — `database/increment_latest.sql` у phpMyAdmin.
6. **Перевірка.** `https://…/assets.php` відкривається; адреса `asset-preview.php?id=1` без підпису — 403;
   `robots.txt` містить блок для GPTBot; у формі `asset-post.php` видно приклад водяного знака.

## Налаштування (site_settings, вкладка «Активи: налаштування»)

assets_max_mb 20 · assets_preview_px 1000 · assets_preview_ttl_min 15 · assets_preview_per_min 60 ·
assets_unique_burst 40 · assets_block_minutes 30 · assets_downloads_per_day 20 · assets_download_token_min 5 ·
assets_similarity_threshold 10 · assets_listing_days 365 · assets_context_guard 1 · copyright_auto_hide 1 ·
copyright_counter_days 10 · copyright_strikes_limit 3.
