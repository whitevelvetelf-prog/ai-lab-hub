# Marketplace 2026-11-06: єдине дерево категорій (блоки → підкатегорії) — випуск на хостинг

Стан: **не залито**. `public_enabled` і `posting_enabled` не змінювались. Замінює КРОК 4 попереднього випуску
(`docs/MARKETPLACE_2026-11-06_DEPLOY.md`, блоки на `listings.php` — тепер 301 на сторінки блоків).

## Порядок
1. Резервна копія БД (phpMyAdmin → Експорт) щонайменше таблиць `mp_categories`, `mp_category_translations`,
   `mp_listing_categories`, `mp_listings`, і коду.
   **Окремо** — теки завантажень (фото оголошень `marketplace-files/photos/`, обкладинки `public/assets/images/marketplace/covers/`):
   їх немає в Git і в архіві коду. Файловий менеджер → «Архівувати» → завантажити собі; локально — `php scripts/backup-uploads.php`.
2. SQL **до коду**, phpMyAdmin → **Імпорт** (не вкладка «SQL»: там PREPARE з кількох рядків не спрацьовує):
   1. `hosting-upload/marketplace-tree/18-marketplace-category-tree.sql` (= `database/migration-2026-11-06-marketplace-category-tree.sql`)
   2. `hosting-upload/marketplace-tree/19-marketplace-ui-strings-tree.sql` (= `database/migration-2026-11-06-marketplace-ui-strings-tree.sql`)
   Лише `ADD COLUMN` за перевіркою (`mp_listings.post_form`, `mp_categories.is_draft`), `INSERT IGNORE` і `UPDATE` за
   (section, slug). Жодних DROP / DELETE / TRUNCATE. Повторний запуск безпечний.
   Контроль у кінці файлу 18: `board_listings_left = 0`, `board_categories_left = 0`, блоки job 11, course 11,
   service 8, solution 8 (7 + неактивна prompts-templates), goods 5, other 0.
   **Код цього випуску без міграції 18 не працює** (колонка `post_form`) — спершу SQL.
3. Код — архів лише з файлами нижче (шляхи від `www/`), розпакувати в `www` з перезаписом.
4. Ctrl+F5.

## Файли
Нові:
- `app/mp-tree.php` — дерево, лічильники з кешем (storage/cache/mp-tree-counts.json, 5 хв), пошук у блоці, плитки, крихти
- `public/mp-categories.php` — керування категоріями (лише admin)

Змінені:
- `app/marketplace-board.php`, `app/marketplace.php`, `app/mp-search.php`, `app/mp-section-nav.php`, `app/mpb-card.php`, `app/mpb-offer.php`
- `app/listing.php`, `app/listing-i18n.php`, `app/listing-account.php`, `app/listing-admin-cabinet.php`
- `app/asset.php`, `app/promo-admin.php`, `app/promo-advertiser.php`, `app/translations.php`
- `public/marketplace.php`, `public/marketplace-category.php`, `public/marketplace-offer.php`, `public/marketplace-post.php`,
  `public/marketplace-my.php`, `public/marketplace-solutions.php`, `public/listings.php`, `public/listing.php`, `public/listing-post.php`,
  `public/get.php`, `public/mp-list.php`, `public/mp-moderation.php`, `public/mp-settings.php`, `public/sitemap.php`
- `public/assets/css/mp-public.css`

**Не заливати** `config/marketplace.php` (на сервері свій). Новий ключ має значення за замовчуванням у коді:
`always_visible_blocks` = `['job', 'course', 'service', 'solution']`; `show_empty_categories` = false (як було).

## Що зміниться одразу після заливки
- `marketplace.php` — головна: пошук, «Подати оголошення», «Безкоштовні рішення», блоки, «Свіжі оголошення».
- Блок / підкатегорія — `marketplace-category.php?id=N` (id з `mp_categories`; старі id категорій Готових рішень 1–7 — ті самі сторінки).
- 301: `listings.php?type=…` → блок; `marketplace.php?category=solutions[&sub=N]`, `?section=board&cat=N` → блок/підкатегорія;
  `marketplace-solutions.php` → блок «Готові рішення»; `listing.php?id=N` оголошення користувача → `marketplace-offer.php?id=N`.
- Подача: `marketplace-post.php` спершу показує вибір блока; вакансії/курси/послуги → `listing-post.php` (підкатегорії обов'язкові,
  AI-спрямування — необов'язкові, згорнуті); готові рішення/обладнання/інше — форма оголошення.
- CRM: черга й «Усі оголошення» з блоком і підкатегоріями, фільтр за блоком; посилання «категорії» → `mp-categories.php`.
- Нові категорії — «чернетка списку» (видимі); затвердити — `mp-categories.php` → «Затвердити список».

## Перевірка після заливки
1. `marketplace.php`: 4 блоки (Вакансії, Курси та навчання, Послуги, Готові рішення) + «Цифрові матеріали», якщо є матеріали.
2. Блок «Готові рішення» → 7 підкатегорій з лічильниками → картка «Від AI LAB HUB».
3. Оголошення, що було на модерації в дошці, — у CRM «Модерація» з блоком і підкатегорією.
4. `listings.php?type=job` → 301 на сторінку блока «Вакансії».
5. `mp-categories.php` (admin) відкривається.
6. Фото оголошень відкриваються (`/mp-photo.php?f=…` → 200 image/*), «Показати контакти» в оголошенні користувача дає контакти;
   `mp-photo-check.php` (admin): відсутніх файлів — 0 (виправлення 2026-11-07: фільтр `section='board'` у `mp-photo.php` і
   `mpb_contacts()` після міграції 18 відсікав усі оголошення).
