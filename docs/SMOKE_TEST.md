# Димовий тест (`scripts/smoke-test.php`)

```
php scripts/smoke-test.php <base_url> --stage=closed|view|open [--delay=1] [--simulate=missing-page|php-error]
powershell -ExecutionPolicy Bypass -File scripts/smoke-test.ps1 <base_url> --stage=view      # сам знаходить PHP з curl у Laragon
```

- Лише GET: без входу, форм і POST. User-Agent `AILH-smoke/1.0`, тайм-аут 15 с, пауза між запитами `--delay` (за замовчуванням 1 с).
  Запити — лише на хост `base_url` і його варіант www/без www; перенаправлення не виконуються автоматично.
- Значення посилань на банку, cookie, токенів не друкуються — лише «є / відсутнє».
- Звіт — у консоль і `storage/smoke-report-РРРРММДД-ГГХХ.txt` (поза git). Код виходу 1, якщо є FAIL; 2 — неправильні аргументи / немає curl.
- Коли: **до** заливки — проти локального сайту, **після** — проти живого (`https://ailabhub-directory.com`).

## Що перевіряється

| Група | Перевірки |
|---|---|
| Головна | 200, є `<title>` / заголовок |
| Пошук | «Midjourney» — Midjourney першим; «відео» і «video» — непорожньо, ≥ 30 % спільних на першій сторінці; «ШІ» — є продукти й посилання на категорії, знайдено < 500 (не весь каталог) |
| Каталог | категорія → підкатегорія → продукт (посилання беруться з головної): 200, заголовок, не «м'який 404» |
| Інше | донати — є посилання на банку; сторінка Елі 200; `?lang=en` → `<html lang="en">` і англійські рядки |
| Канонічна адреса (лише https) | `http://`, `http://www.`, `https://www.` → один 301/308 на `base_url`, далі 200 |
| closed | marketplace.php, marketplace-solutions.php, listings.php, marketplace-post.php, mp-rules.php — прихований: 404 (розділ не розгорнуто) або «Скоро» (200, noindex, без оголошень і полів подачі — вимкнено перемикачем у кабінеті) |
| view | marketplace.php 200, блоки категорій, сторінка оголошення 200; форми подачі гостю недоступні; mp-rules.php і ai-statement.php — 404, поки у відповідних `docs/*.md` є маркери, і відкриті, коли маркерів немає (рахується за локальними файлами); сторінка категорії з `?q=` — `noindex` |
| open | як view + кнопка подачі на marketplace.php і гостя з форми відправляє на вхід (302 на login.php або 401 з посиланням login.php) |
| Закриті шляхи (403/404) | /config/database.php, /config/, /docs/, /database/, /hosting-upload/, /marketplace-seed/, /scripts/, /storage/, /backups/, /.git/config, /_check-env.php, /_session-check.php, /uploads/marketplace/, /config/marketplace.local.php |
| Заголовки | `Cache-Control: no-store` на login.php, mp-verify-email.php, account.php; cookie сесії HttpOnly, SameSite=Lax, на https — Secure |
| Помилки PHP | на всіх відкритих сторінках немає «Fatal error», «Warning:», «Notice:», «Parse error», «Stack trace», «Deprecated:», «Uncaught » |

## Самоперевірка 2026-11-22

| Прогін | Результат | Код |
|---|---|---|
| локально, `--stage=view` | PASS 44, FAIL 0, SKIP 2 (https-перевірки) | 0 |
| локально, `--stage=open` | PASS 45, FAIL 0, SKIP 2 | 0 |
| локально, `--stage=closed` (перемикач `marketplace_public` тимчасово 0, потім повернуто 1) | PASS 41, FAIL 0, SKIP 2 — сторінки «Скоро» | 0 |
| **збій:** `--stage=closed` проти відкритого розділу | FAIL 5 («сторінка з вмістом Marketplace») | 1 |
| **збій:** `--simulate=missing-page` | FAIL 2 (категорія «не знайдено» — м'який 404; далі немає підкатегорії) | 1 |
| **збій:** `--simulate=php-error` | FAIL 1 («Fatal error» на головній) | 1 |
| живий сайт, `--stage=open`, `--delay=1` | **PASS 49, FAIL 0, SKIP 0** | 0 |

## Знахідка

`category.php?id=<неіснуючий>` відповідав **200** зі сторінкою «Категорію не знайдено» (локально й на проді) —
«м'який 404» для пошуковиків. **Виправлено 2026-11-22:** тепер 404 + `noindex`, сторінка для людей та сама; димовий тест
перевіряє це окремим пунктом «Неіснуюча категорія … 404». Так само виправлено й перевіряється `product.php?id=<неіснуючий>`
і `blog-post.php?slug=<неіснуючий>` (пункти «Неіснуючий продукт» і «Неіснуюча стаття»).
