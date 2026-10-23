# Система відеореклами (promo)

Відеореклама AI LAB HUB за моделлю Facebook/YouTube Ads, спрощено: рекламодавець у кабінеті
створює й оплачує кампанію, адмін модерує, відвідувачі бачать позначене «Реклама» відео,
облік і списання автоматичні. Нейтральні назви (`promo`, `sponsored`), бо шляхи й класи з
`ad`/`ads`/`banner` блокують розширення-блокувальники.

## Принципи

- **Глобальний перемикач** `ad_settings.enabled` (за замовчуванням `0`) вимикає ВСЮ рекламу:
  відео й старі банери (`app/ads.php`). Без нього рекламодавці не бачать кабінету (адмін бачить завжди).
- Кожна реклама позначена «Реклама» / «Sponsored», посилання `rel="sponsored noopener noreferrer"`.
- Ніякої реклами в Елі, кабінеті, на сторінках входу та в підвалі.
- Нічого без модерації; будь-яке редагування повертає кампанію на модерацію.
- Ціни задає адмін (`ad_rate_card` початково порожня); без ціни платна кампанія не надсилається.
- Таргетинг без персональних даних: мова, пристрій, категорія/підкатегорія сторінки.
- Гроші — цілі копійки (UAH).

## Схема (`database/migration-2026-10-11-promo-video.sql`)

| Таблиця | Призначення |
|---|---|
| `ad_campaigns` | **Розширена наявна** таблиця: `format` (`banner` — старі банери, `video` — нова система), власник, ціль, `pricing_model` (cpm/cpc), `unit_price`, бюджети, `spent`, `spent_today`, `cpm_accrual` (тисячні копійки), статуси `draft → pending_review → active ⇄ paused → completed / rejected`, `stop_reason`. Власна реклама сайту = `campaign_type='internal'`. |
| `ad_creatives` | Відео (upload/YouTube), постер, тексти, CTA, адреса переходу, статус модерації (`draft/pending/approved/rejected/suspended`). |
| `ad_targets` | Рядок на розміщення × категорію/підкатегорію (NULL = усі) × мова × пристрій; `unit_price` — знімок ціни для розміщення. |
| `ad_events` | Сирі події impression/view/click з анонімним `session_hash`; зберігаються 30 днів. |
| `ad_stats_daily` | Агрегати за днем × кампанією × креативом × розміщенням (оновлюються в момент події). |
| `ad_balances`, `ad_transactions` | Баланс рекламодавця й журнал (topup / spend — агрегований рядок на кампанію на день / refund / adjust). |
| `ad_rate_card` | Прайс: розміщення × модель. |
| `ad_settings` | Ключ-значення: `enabled`, ліміти відео, `min_topup`, реквізити UA/EN, ліміт показів на сеанс, заборонені категорії UA/EN, текст правил UA/EN. |
| `ad_reports` | Скарги відвідувачів (одна на креатив від сеансу). |
| `ad_rate_limits` | Ліміти дій рекламодавця на добу (кампанії 10, завантаження 20, заявки 10). |

Старі `ads`, `ad_zones`, `ad_impressions`, `ad_clicks` не змінюються; стара CRM банерів
(`crm-ads-*.php`) показує лише `format='banner'`.

## Потоки

**Показ.** Сторінка виводить прихований слот (`promo_slot()` у `app/promo.php`) →
`sponsored.js` питає `promo-serve.php` → `promo_pick()` повертає один креатив із підписаним
HMAC-токеном (креатив, кампанія, розміщення, сеанс, час) або 204 (тоді слот лишається прихованим).
Платні кампанії мають пріоритет над власною рекламою; серед платних — вага
«залишок бюджету / днів до кінця». Розміщення: `catalog_card` (3-тя картка каталогу/пошуку),
`product_page` (під описом продукту), `blog_inline` (перед другим розділом статті).

**Облік.** impression — ≥50% картки видно ≥1 с; view — ≥3 с відтворення (лише власне відео);
події йдуть через `navigator.sendBeacon` на `promo-event.php`. Клік — лише
`promo-click.php?t=ТОКЕН`: адреса з БД (без відкритого редиректу), підроблений токен → 400.
Відсікаються боти (User-Agent), чужий сеанс, прострочений токен (2 год), дублі
(показ/перегляд — 10 с, клік — 30 хв), понад 30 подій сеансу за хвилину.

**Списання.** `promo_charge()`: транзакція з `SELECT … FOR UPDATE` (кампанія, потім баланс),
сума обрізається до залишку загального бюджету, денного бюджету й балансу. Вичерпано загальний
бюджет → `completed`; баланс → `paused` (`stop_reason='balance'`, після підтвердження поповнення
кампанія відновлюється сама); денний ліміт лише ховає кампанію до кінця дня.

**Кабінет рекламодавця** (`account.php` → «Реклама»): кампанії, майстер із 5 кроків
(ціль → креатив → аудиторія → бюджет → підтвердження), баланс і заявки на поповнення,
статистика з CSV. Обробник — `promo-action.php`.

**Адмінка** (`account.php` → «Реклама: адмін», лише admin, роль перевіряється за БД):
перемикач усієї реклами, модерація, кампанії (екстрена зупинка), платежі (підтвердження,
коригування), прайс, налаштування, звіти й скарги, власна реклама. Обробник — `promo-admin-action.php`.

**Оплата** (`app/promo-payments.php`): інтерфейс `PaymentProvider`; працює `ManualBankTransfer`
(заявка з призначенням `AILABHUB-PROMO-<id>`, підтвердження адміном). `WayForPayProvider`,
`LiqPayProvider`, `StripeProvider` — заглушки з описом потрібних параметрів (немає мерчанта).
Номери карток не зберігаються ніколи.

## Файли

- Логіка: `app/promo.php`, `promo-advertiser.php`, `promo-admin.php`, `promo-payments.php`, `promo-i18n.php`
- Розмітка: `app/promo-cabinet.php`, `app/promo-admin-cabinet.php`
- Публічні: `public/promo-serve.php`, `promo-event.php`, `promo-click.php`, `promo-report.php`,
  `promo-action.php`, `promo-admin-action.php`, `promo-rules.php`, `promo-cron.php`
- Фронтенд: `public/assets/js/sponsored.js`, `promo-cabinet.js`; `public/assets/css/sponsored.css`, `promo-cabinet.css`
- Відео й постери: `public/uploads/promo/` (випадкові імена, лише mp4/webm/jpg/png/webp; `.htaccess`
  з `php_flag`/`Options` на хостингу дає 500, тож захист — білий список і `index.html` проти лістингу)

## Налаштування сервера

- `config/promo.php` (не в git; шаблон `config/promo.example.php`): `secret` (≥32 символи, HMAC
  токенів; без нього відео не показується) і `cron_key`.
- Cron раз на добу: `php …/www/public/promo-cron.php` (або `promo-cron.php?key=<cron_key>`):
  завершує кампанії з минулою датою й чистить сирі події старші 30 днів.
- `upload_max_filesize` / `post_max_size` мають бути ≥ `max_video_mb` (адмінка показує попередження).

## Блоки F–I (2026-10-12)

- **F. Медіакіт** `public/advertise.php` (+ `app/promo-audience.php`, кеш `promo_audience_stats`,
  анонімні `page_views.device_class` / `lang`).
- **G. Перевірка посилань** `app/promo-linkcheck.php` (SSRF-захист, Safe Browsing / Web Risk,
  `ad_link_checks`, `ad_domain_blocklist`, `promo_event_log`, автопауза → повторна модерація).
- **H. Виключення** `app/promo-exclusions.php` (`no_promo`, `promo_blog_flags`,
  `ad_campaigns.advertiser_category`, `promo_category_rules`, «перевірити сторінку»).
- **I. Пошта й cron** `app/promo-mail.php` (PHPMailer у `app/lib/phpmailer`, `mail_queue`,
  `promo_notify_prefs`), `cron/*.php` (`cron_runs`), вкладка «Стан».
- Час у БД — UTC (`promo_db_utc` в ендпоінтах реклами й cron), «доба» — Europe/Kyiv
  (`promo_today`); денний бюджет рахується з `ad_stats_daily` за київську добу.
- Міграція: `database/migration-2026-10-12-promo-operations.sql`. Експлуатація:
  `docs/PROMO_OPERATIONS.md`.

## Місця показу (2026-10-18, блоки L1–L5)

- `ad_placements` (міграція `database/migration-2026-10-18-promo-placements.sql`): category_page,
  subcategory_list, search_results, product_page, blog_list, blog_article (маркетплейс — див. нижче).
  Логіка — `app/promo-placements.php`; галочки в майстрі — `app/promo-placement-picker.php`;
  ємність — `public/promo-capacity.php`; вкладка адмінки «Місця показу».
- Старі ключі працюють: `catalog_card` = subcategory_list + search_results, `blog_inline` = blog_article
  (`PROMO_LEGACY_PLACEMENTS`, `promo_placement_match_keys`). Міграція копіює їхні таргети й ціни.
- Вимкнене місце не відбирається й не має слота.
- Правило позиції — `position_rule` (JSON): `position`, `after_item`, `min_chars_before/after`.
- Ліміт `slots_per_page` — у `promo_slot`; повтори на сторінці — `exclude` у `promo-serve.php`.
- Адмін-перегляд: `?promo_preview=1` + тестова кампанія `is_test` (токен з `x=1`, події не рахуються).
- Категорії статей: теми з коду (`BLOG_ARTICLE_TOPICS`) + `blog_post_categories` з адмінки.
- Аналітика каталогу: `page_views.page_type='other'`, `page_slug` = `sub:<id>` / `cat:<id>` / `search` / `all`;
  список блогу — `blog`.
- Перевірка (локально): `php tools/promo-placements-check.php` → PASS/FAIL по кожному місцю.

## Місця в маркетплейсі (2026-10-20)

- Міграція `database/migration-2026-10-20-promo-marketplace-placements.sql`. marketplace_listing замінено
  п'ятьма місцями: `marketplace_home` (marketplace.php без фільтрів, 1-ша сторінка — блок над списком),
  `marketplace_feed` (стрічка marketplace.php — картка на 4-й позиції, далі кожні 10, `{"position":4,"every":10}`),
  `marketplace_category` (категорія/Готові рішення в marketplace.php, listings.php?type=… без фільтрів — блок
  на початку списку), `marketplace_search` (пошук і фільтри — 4-та позиція), `marketplace_listing_page`
  (listing.php, marketplace-offer.php — окремий блок після оголошення й кнопки). Нових цін немає.
- Старий ключ `marketplace_listing` = `marketplace_feed` (`PROMO_LEGACY_PLACEMENTS`); міграція копіює таргети
  (без категорій каталогу) і ціни.
- Таргетинг: `ad_targets.mp_section` (NULL — усі розділи; job, course, service, board, board:<id>, solutions).
  Категорії каталогу й правила категорій реклами до маркетплейсу не застосовуються (`promo_pick`).
- Показ лише коли `marketplace_public = 1` (`requires_setting`). До відкриття, якщо
  `ad_settings.ad_allow_marketplace_preselect = 1`, місця можна обрати (`promo_placement_pending`); кампанія лише
  з такими місцями в кабінеті — «Очікує показу», бюджет не витрачається; після відкриття показ починається без
  повторної модерації.
- Аналітика: `page_views.page_type` marketplace_home (page_slug = розділи або `p:<N>` для наступних сторінок),
  marketplace_category, marketplace_search, marketplace_listing (page_id = оголошення); page_slug — розділи через кому.
- Вигляд: `.sponsored-slot[data-group="marketplace"]` — пунктирна тепла рамка й жовта позначка «Реклама».
  Правила реклами: заборона маскування під оголошення; підказка в черзі модерації.

## Юридичне

`promo-rules.php` (вбудована чернетка UA/EN, адмін може замінити текстом у налаштуваннях),
пункт 3.3 у `terms.php`, пункт 3.3 у `privacy.php` — **чернетки, потребують перевірки юристом**.

## Власна реклама платформи (2026-10-23)

- Міграція `database/migration-2026-10-23-house-ads.sql`: `ad_creatives.creative_type` ('video' | 'card'), `card_layout`,
  тексти EN, запасний опис без дати, власний текст кнопки, `ref_code`; `ad_campaigns.house_key`, `house_rules`,
  `acquisition_ref`; `mp_listings.acquisition_ref`; `ad_settings.ad_allow_card_creatives = 0`, `house_frequency_cap = 2`.
- Засів (paused): A «Рекламуйтесь у нас» (house-A1, house-A2 → /advertise.php, усі місця, приховано для тих, хто вже має
  кампанію, не на advertise/кабінеті) і B «Marketplace: оголошення» (house-B1, house-B2 → /marketplace.php, лише сайт і блог,
  `requires_setting = marketplace_public`, приховано для тих, хто вже має оголошення). Активація — адмінка «Власна реклама».
- Відбір (`promo_pick`): платні завжди перші; власна — лише у вільному слоті, один блок на сторінку (`nohouse`),
  `house_frequency_cap` показів кампанії сеансу за добу, умови `promo_house_allowed()`, рівномірна ротація варіантів.
- Картка: `promo_card_payload()` — `{free_until}` (дата `marketplace_free_until` мовою інтерфейсу) або запасний текст;
  `sponsored.js` малює `.sponsored-card--card` (градієнт #00032c → #2116ad), компактну в сітках.
- Джерело: `?ref=house-…` → сесія (`app/acquisition.php`) → `acquisition_ref` першої кампанії чи оголошення.
  Звіт — «Звіти» → «Власна реклама за варіантами»; порівняння CTR після 100 показів кожного варіанта (без автовимкнення).
- Перевірка: `php tools/promo-house-check.php`.

## Нативна реклама в списках (2026-10-21)

- Міграція `database/migration-2026-10-21-native-ads.sql` (= `increment_latest.sql`).
- **Картка** `app/ad-card.php` (`ad_card_slot`, `ad_card_positions`): у сітці категорії, підкатегорії, пошуку,
  стрічки/розділів/пошуку Marketplace — того самого розміру, що картка продукту, позначка «Реклама»/«Ad», уся
  картка — посилання на `promo-click.php`. Позиції й ліміт — `ad_placements.position_rule` `{"position":3,"every":8}`,
  `slots_per_page = 2`. Банери зон 1–2 (`app/ad-banner.php`) зі сторінок прибрано; таблиці `ads`/`ad_zones` лишились.
- **Формати**: `ad_creatives.creative_type` = `video` | `image` (картинка в `poster_path`) | `card` (власна);
  `weight` (усі 1). Ліміти ролика `max_video_sec = 15`, `max_video_mb = 5`; тривалість — ffprobe, якщо є, інакше
  розбір заголовка MP4 (WebM — лише тривалість із браузера). Файли — `public/uploads/promo/` (шлях з «ads»
  ріжуть блокувальники).
- **Відео**: src лише поблизу екрана, старт без звуку за IntersectionObserver, кнопка-динамік (звук лише в одному
  ролику), saveData / reduced-motion — постер + «відтворити».
- **Ротація**: до 5 креативів на слот (`promo_pick_set`, `app/promo-select.php`); відео — 2 відтворення, зображення —
  15 с видимого часу; не повторюються на сторінці; останні 20 показаних сеансу — у кінці черги.
- **Масштаб**: без `ORDER BY RAND()`; кеш кандидатів 60 с (APCu або `storage/cache/promo`, скидання —
  `promo_cache_flush()` після дій у кабінеті/адмінці та зупинки кампанії системою); покази й перегляди — лише
  `ad_stats_daily`, дублі/ліміти — у сесії; кліки — `ad_events`; події пакетом через sendBeacon.
  Старі зони — `ad_zone_stats_daily`. Тест: `php tools/promo-load-test.php 5000`.
- **Тексти**: «Умови» 3.3, «Конфіденційність» 3.3, «Про проєкт» — ключі `legal_*`, `about_ads_*` (EN у ui_translations).
- Перевірка вручну: `php tools/promo-demo-ads.php create` / `delete`.

## Спливаюче вікно (2026-10-21, замінює нативні картки в списках)

- Міграція `database/migration-2026-10-21-ad-popup.sql` (= `increment_latest.sql`). Нативні картки зі списків прибрано
  (`app/ad-card.php` видалено; місця category_page, subcategory_list, search_results, marketplace_feed/search/category вимкнено).
- Місце `popup` (ad_placements, група popup; зона «Спливаюча реклама» в ad_zones — довідково). `app/ad-popup.php` з підвалу
  підключає лише скрипт і правила; вікно малює `public/assets/js/ad-popup.js` + `css/ad-popup.css`, оголошення — `public/ad-next.php`
  (JSON або 204, X-Popup-Wait).
- Правила: друга сторінка візиту І ≥ `ad_popup_visit_delay_seconds` (300 = 5 хв, з 2026-10-23) від його початку; інтервал `ad_popup_min_interval_seconds`
  (600) від закриття (localStorage `alh_ad_popup_closed` + сесія `ad_popup`); не під час набору тексту; сторінки
  `ad_popup_excluded_pages` (fnmatch; з 2026-10-21 лише index.php і eli.php — реклама на всіх інших сторінках); боти — скрипт не підключається; no_promo.
- «Пропустити»: `ad_creatives.skip_delay_seconds` (5–15, NULL → `ad_popup_skip_delay_default` = 5, з 2026-10-23); адмінка «Кампанії» → «Пропуск вікна».
- Статистика: `ad_stats_daily.skips`; impression — вікно видно ≥1 с; skip — «Пропустити»/Esc після відліку (і фіксує закриття в сесії).
- Перевірка: `php tools/promo-demo-ads.php create|delete`, `php tools/promo-load-test.php 5000`, тести promo-*-check.
