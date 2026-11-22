<?php

declare(strict_types=1);

/**
 * AI LAB HUB — збирає консолідований ідемпотентний SQL-пакет Marketplace для phpMyAdmin (CLI).
 *
 *   php scripts/build-release-sql.php            — зібрати hosting-upload/marketplace-ALL-04-28-partN.sql + INDEX.md + CHECKSUMS.txt
 *   php scripts/build-release-sql.php --check    — лише перевірити міграції (нічого не пише)
 *
 * Порядок — нумерація Marketplace (database/MARKETPLACE_HOSTING.md, docs/RELEASE_AUDIT.md), міграції без номера («б/н»)
 * стоять за датою. Кожна частина ≤ 2 МБ (ліміт імпорту phpMyAdmin), ділиться лише між файлами (або між інструкціями,
 * якщо один файл більший). На початку частини 1 — перевірка версії СУБД (MySQL ≥ 5.6.5 або MariaDB ≥ 10.0; інакше
 * імпорт зупиняється помилкою з поясненням у назві таблиці). У кінці кожної частини — SELECT 'OK частина N'.
 * Збірка ЗУПИНЯЄТЬСЯ, якщо поза коментарями знайдено DROP / TRUNCATE / DELETE.
 * Дані GeoNames (hosting-upload/marketplace-geo/geo-data-*.sql, ~9 МБ) і довідники місць не входять — це дані,
 * а не міграції; вони окремо в INDEX.md.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

const PART_LIMIT = 2_000_000;   // байт; з запасом до 2 МБ (2 097 152)

$root = dirname(__DIR__);
$check = in_array('--check', $argv, true);

/** № => [файл у database/, призначення] — у порядку застосування. */
$migrations = [
    ['04',  'migration-2026-09-21-marketplace-core.sql', 'таблиці mp_*, продавець ailabhub, категорії «Готових рішень»'],
    ['05',  'migration-2026-09-21-marketplace-ui-strings.sql', 'EN-написи вітрини'],
    ['06',  'migration-2026-09-21-marketplace-classifieds.sql', 'колонки оголошень, фото/скарги/вибране/розкриття, категорії дошки'],
    ['б/н', 'migration-2026-09-21-marketplace-rename-hardware.sql', 'категорія дошки hardware'],
    ['07',  'migration-2026-09-21-marketplace-ui-strings-classifieds.sql', 'EN-написи дошки'],
    ['08',  'migration-2026-09-21-marketplace-email-verification.sql', 'mp_email_verifications'],
    ['09',  'migration-2026-09-21-marketplace-ui-strings-email.sql', 'EN-написи підтвердження пошти'],
    ['10',  'migration-2026-09-21-marketplace-ui-strings-rules.sql', 'EN-написи згоди з Правилами'],
    ['11',  'migration-2026-09-21-marketplace-rules-version.sql', 'mp_listings.rules_version'],
    ['12',  'migration-2026-09-21-marketplace-rate-limits.sql', 'mp_rate_limits'],
    ['13',  'migration-2026-09-21-marketplace-ui-strings-ratelimit.sql', 'EN «Too many requests»'],
    ['14',  'migration-2026-09-21-marketplace-ui-strings-posting.sql', 'EN «Listing submission will open soon»'],
    ['б/н', 'migration-2026-09-24-marketplace-ui-strings-offer.sql', 'EN-написи сторінки пропозиції'],
    ['б/н', 'migration-2026-10-10-marketplace-solution-ads.sql', 'реклама «Готових рішень» (campaigns)'],
    ['б/н', 'migration-2026-10-10-marketplace-ui-strings-nav.sql', 'EN-написи навігації'],
    ['б/н', 'migration-2026-10-10-marketplace-ui-strings-solutions.sql', 'EN-написи рішень'],
    ['б/н', 'migration-2026-10-16-marketplace-switch.sql', 'перемикач marketplace_public (типово 0)'],
    ['б/н', 'migration-2026-10-19-marketplace-listings.sql', 'оголошення компаній: вакансії, курси, послуги'],
    ['б/н', 'migration-2026-11-03-search-index.sql', 'пошуковий індекс і синоніми'],
    ['15',  'migration-2026-11-03-marketplace-geo-places.sql', 'довідник місць (структура; дані — окремо)'],
    ['16',  'migration-2026-11-03-marketplace-listing-geo.sql', 'місце й ціна в USD в оголошеннях'],
    ['17',  'migration-2026-11-03-marketplace-ui-strings-geo.sql', 'EN-написи геолокації'],
    ['18',  'migration-2026-11-06-marketplace-category-tree.sql', 'дерево категорій (блоки → підкатегорії)'],
    ['19',  'migration-2026-11-06-marketplace-ui-strings-tree.sql', 'EN-написи дерева'],
    ['б/н', 'migration-2026-11-06-marketplace-verify-drafts.sql', 'перевірка й чернетки'],
    ['20',  'migration-2026-11-09-marketplace-wave1.sql', 'Хвиля 1: зарплати, теги, популярні запити, збережені пошуки, статистика'],
    ['21',  'migration-2026-11-09-marketplace-ui-strings-wave1.sql', 'EN-написи Хвилі 1'],
    ['б/н', 'migration-2026-11-10-ai-statement-ui.sql', 'EN-написи сторінки «Як ми використовуємо АІ»'],
    ['б/н', 'marketplace_legal_migration.sql', 'Правила й юридичні механізми (скарги, оскарження, санкції)'],
    ['22',  'migration-2026-11-18-marketplace-messaging.sql', 'внутрішні повідомлення (таблиці; функція — за прапором)'],
    ['23',  'migration-2026-11-18-marketplace-ui-strings-messaging.sql', 'EN-написи повідомлень'],
    ['24',  'migration-2026-11-19-ad-geo.sql', 'географія показу реклами'],
    ['25',  'migration-2026-11-19-geo-ui-strings.sql', 'EN-написи геолокації відвідувача'],
    ['26',  'migration-2026-11-19-geo-ip-on.sql', 'EN-текст Політики 3.5 (країна за IP)'],
    ['27',  'migration-2026-11-19-geo-place-sections.sql', 'geo_place_sections (структура; дані — окремо)'],
    ['28',  'migration-2026-11-19-legal-pages-en.sql', 'EN-тексти «Про проєкт», Політики, Умов'],
];

/** Текст без коментарів (-- …, # …, /* … *\/) і без вмісту рядкових літералів — для пошуку заборонених інструкцій. */
function strip_sql(string $sql): string
{
    $out = '';
    $n = strlen($sql);
    for ($i = 0; $i < $n; $i++) {
        $c = $sql[$i];
        if ($c === "'" || $c === '"' || $c === '`') {
            $q = $c;
            $out .= ' ';
            for ($i++; $i < $n; $i++) {
                if ($sql[$i] === '\\' && $q !== '`') {
                    $i++;
                    continue;
                }
                if ($sql[$i] === $q) {
                    if ($i + 1 < $n && $sql[$i + 1] === $q) {
                        $i++;
                        continue;
                    }
                    break;
                }
            }
            continue;
        }
        if ($c === '-' && ($sql[$i + 1] ?? '') === '-' || $c === '#') {
            while ($i < $n && $sql[$i] !== "\n") {
                $i++;
            }
            $out .= "\n";
            continue;
        }
        if ($c === '/' && ($sql[$i + 1] ?? '') === '*') {
            $e = strpos($sql, '*/', $i + 2);
            $i = $e === false ? $n : $e + 1;
            $out .= ' ';
            continue;
        }
        $out .= $c;
    }
    return $out;
}

$problems = [];
$bodies = [];
foreach ($migrations as [$no, $file, $what]) {
    $path = "{$root}/database/{$file}";
    if (!is_file($path)) {
        $problems[] = "немає файлу database/{$file}";
        continue;
    }
    $sql = (string) file_get_contents($path);
    $sql = preg_replace('/^\xEF\xBB\xBF/', '', $sql);   // BOM
    $plain = strip_sql($sql);
    // Заборонені інструкції поза коментарями й літералами. Динамічний SQL у PREPARE — у літералах, тож перевіряємо й їх.
    if (preg_match('/\b(DROP\s+(TABLE|DATABASE|SCHEMA|COLUMN|INDEX|VIEW)|TRUNCATE\b|DELETE\s+FROM)\b/i', $plain, $m) === 1) {
        $problems[] = "{$file}: заборонена інструкція «{$m[0]}»";
    }
    $literals = [];
    preg_match_all("/'((?:[^'\\\\]|\\\\.|'')*)'/s", $sql, $literals);
    foreach ($literals[1] as $lit) {
        if (preg_match('/^\s*(DROP\s+(TABLE|COLUMN|INDEX)|TRUNCATE\s|DELETE\s+FROM)/i', $lit, $m) === 1
            || preg_match('/ALTER\s+TABLE\s+\S+\s+DROP\s/i', $lit, $m) === 1) {
            $problems[] = "{$file}: заборонена інструкція в динамічному SQL «{$m[0]}»";
        }
    }
    if (preg_match('/^\s*DELIMITER\b/im', $plain) === 1) {
        $problems[] = "{$file}: DELIMITER не підтримується в пакеті";
    }
    $bodies[] = [$no, $file, $what, rtrim($sql) . "\n"];
}

if ($problems !== []) {
    fwrite(STDERR, "ЗБІРКУ ЗУПИНЕНО:\n  - " . implode("\n  - ", $problems) . "\n");
    exit(1);
}
fwrite(STDOUT, 'Перевірено міграцій: ' . count($bodies) . " — DROP / TRUNCATE / DELETE не знайдено.\n");
if ($check) {
    exit(0);
}

$first = $bodies[0][0];
$last = $bodies[count($bodies) - 1][0];
$range = '04-28';

$versionCheck = <<<'SQL'
-- ---------------------------------------------------------------------
-- Перевірка версії СУБД: MySQL ≥ 5.6.5 або MariaDB ≥ 10.0. Якщо версія нижча — імпорт зупиниться помилкою
-- «Table '…ПОМИЛКА_потрібна_MySQL_5.6.5_або_MariaDB_10.0' doesn't exist», і нічого далі не виконається.
-- ---------------------------------------------------------------------
SET NAMES utf8mb4;
SET @ailh_v = VERSION();
SET @ailh_maria = @ailh_v LIKE '%MariaDB%';
SET @ailh_major = CAST(SUBSTRING_INDEX(@ailh_v, '.', 1) AS UNSIGNED);
SET @ailh_minor = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(@ailh_v, '.', 2), '.', -1) AS UNSIGNED);
SET @ailh_patch = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(SUBSTRING_INDEX(@ailh_v, '-', 1), '.', 3), '.', -1) AS UNSIGNED);
SET @ailh_ok = IF(@ailh_maria, @ailh_major >= 10,
                  (@ailh_major * 10000 + @ailh_minor * 100 + @ailh_patch) >= 50605);
SET @s = IF(@ailh_ok, 'DO 0', 'SELECT 1 FROM `ПОМИЛКА_потрібна_MySQL_5.6.5_або_MariaDB_10.0`');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
SELECT CONCAT('Версія СУБД: ', @ailh_v, ' — підходить') AS `Перевірка`;

SQL;

// Розкладка по частинах.
$parts = [];
$cur = '';
$curItems = [];
$flush = static function () use (&$parts, &$cur, &$curItems): void {
    if ($cur !== '') {
        $parts[] = [$cur, $curItems];
    }
    $cur = '';
    $curItems = [];
};
foreach ($bodies as [$no, $file, $what, $sql]) {
    $block = "\n-- =====================================================================\n"
        . "-- № {$no}: database/{$file}\n-- {$what}\n"
        . "-- =====================================================================\n" . $sql;
    if ($cur !== '' && strlen($cur) + strlen($block) > PART_LIMIT - 4096) {
        $flush();
    }
    if (strlen($block) > PART_LIMIT - 4096) {
        // Великий файл — ділимо між інструкціями (по «;» у кінці рядка).
        foreach (preg_split('/(?<=;)\s*\n/', $block) as $stmt) {
            if ($cur !== '' && strlen($cur) + strlen($stmt) > PART_LIMIT - 4096) {
                $flush();
            }
            $cur .= $stmt . "\n";
            $curItems[$no . ' ' . $file] = true;
        }
        continue;
    }
    $cur .= $block;
    $curItems[$no . ' ' . $file] = true;
}
$flush();

$outDir = "{$root}/hosting-upload";
if (!is_dir($outDir) && !mkdir($outDir, 0750, true) && !is_dir($outDir)) {
    fwrite(STDERR, "Не вдалося створити {$outDir}\n");
    exit(1);
}
$total = count($parts);
$written = [];
foreach ($parts as $i => [$body, $items]) {
    $n = $i + 1;
    $name = "marketplace-ALL-{$range}-part{$n}.sql";
    $head = "-- =====================================================================\n"
        . "-- AI LAB HUB — консолідований пакет міграцій Marketplace № {$range}, частина {$n} з {$total}\n"
        . "-- Зібрано: " . date('Y-m-d H:i') . ", коміт " . trim((string) shell_exec('git -C ' . escapeshellarg($root) . ' rev-parse --short HEAD')) . "\n"
        . "-- Ідемпотентний: лише CREATE TABLE IF NOT EXISTS, ADD COLUMN / INDEX за перевіркою information_schema,\n"
        . "-- INSERT IGNORE / INSERT … WHERE NOT EXISTS, UPDATE за ключем. Жодних DROP / TRUNCATE / DELETE.\n"
        . "-- phpMyAdmin → виберіть базу → «Імпорт» → цей файл (кодування utf-8) → «Вперед». Частини — строго по порядку.\n"
        . "-- =====================================================================\n\n";
    $content = $head . ($n === 1 ? $versionCheck : "SET NAMES utf8mb4;\n") . $body
        . "\n-- Кінець частини {$n}\nSELECT 'OK частина {$n}' AS `Результат`;\n";
    if (strlen($content) > 2_097_152) {
        fwrite(STDERR, "{$name}: " . strlen($content) . " байт — більше 2 МБ\n");
        exit(1);
    }
    file_put_contents("{$outDir}/{$name}", $content);
    $written[] = [$name, strlen($content), array_keys($items)];
    fwrite(STDOUT, sprintf("OK %s — %s байт, міграцій: %d\n", $name, number_format(strlen($content), 0, '.', ' '), count($items)));
}

// INDEX.md
$idx = "# hosting-upload/ — пакети для ручного імпорту (phpMyAdmin) і заливки\n\n"
    . "Згенеровано `php scripts/build-release-sql.php` " . date('Y-m-d H:i') . ". Тека поза git (`.gitignore`).\n\n"
    . "> **Живий сайт (ailabhub-directory.com) уже містить УСІ міграції № 04–28** (див. `docs/RELEASE_AUDIT.md`). Для нього\n"
    . "> імпорт пакета **не потрібен**. Повторний імпорт безпечний для даних, але може повернути назви/порядок категорій\n"
    . "> Marketplace і EN-тексти, змінені пізніше вручну. Пакет — для нової або відновленої бази.\n\n"
    . "## 1. Консолідований пакет міграцій (порядок імпорту)\n\n| Порядок | Файл | Розмір | Що всередині |\n|---|---|---|---|\n";
foreach ($written as $k => [$name, $size, $items]) {
    $idx .= sprintf("| %d | `%s` | %s КБ | %s |\n", $k + 1, $name, number_format($size / 1024, 1, ',', ' '), implode('; ', array_map(static fn ($s) => '№ ' . $s, $items)));
}
$idx .= "\nНа початку частини 1 — перевірка версії (MySQL ≥ 5.6.5 / MariaDB ≥ 10.0); у кінці кожної — `SELECT 'OK частина N'`.\n\n"
    . "### Склад за номерами\n\n| № | Файл у `database/` | Призначення |\n|---|---|---|\n";
foreach ($bodies as [$no, $file, $what]) {
    $idx .= "| {$no} | `{$file}` | {$what} |\n";
}
$idx .= "\n## 2. Дані (не міграції; лише для нової бази, після частин пакета)\n\n| Порядок | Файл | Розмір | Призначення |\n|---|---|---|---|\n";
$data = ['marketplace-geo/geo-data-01.sql', 'marketplace-geo/geo-data-02.sql', 'marketplace-geo/geo-data-03.sql', 'marketplace-geo/geo-data-04.sql',
    'marketplace-geo/geo-data-05.sql', 'marketplace-geo-local/geo-local-01.sql', 'marketplace-geo-local/geo-uk-wikidata-01.sql', 'marketplace-geo-local/geo-sections-01.sql'];
$purpose = ['GeoNames cities5000, частина 1', 'частина 2', 'частина 3', 'частина 4', 'частина 5', 'місцеві назви місць (без ru)',
    'українські назви з Вікіданих', 'частини міст для підказок'];
foreach ($data as $k => $f) {
    $p = "{$outDir}/{$f}";
    $idx .= sprintf("| %d | `%s` | %s | %s |\n", $k + 1, $f, is_file($p) ? number_format(filesize($p) / 1024, 1, ',', ' ') . ' КБ' : '**відсутній**', $purpose[$k]);
}
$idx .= "\n## 3. Старі окремі пакети (уже застосовані на проді)\n\n`marketplace-geo/15…17`, `marketplace-tree/18…19`, `marketplace-messaging/22…23`, `geo-ads/24…25` — ті самі\n"
    . "міграції, що й у консолідованому пакеті; окремо імпортувати не потрібно.\n\n"
    . "## 4. Код\n\n`RELEASE_MANIFEST.txt` — шлях, розмір і sha256 кожного файла архіву коду (`scripts/build-deploy.ps1 -IncludeMarketplace`).\n"
    . "`marketplace.config.HOSTING.stageA.php` / `stageB.php` — шаблони серверного `config/marketplace.local.php` (див. `docs/RELEASE_STAGE_A.md`).\n"
    . "\n## 5. Оголошення платформи (після пакета, міграцій категорій № 18–19 і релізу етапу A)\n\n"
    . "| Порядок | Файл | Призначення |\n|---|---|---|\n"
    . "| 1 | `database/migration-2026-11-22-mp-platform-promos-ui.sql` (№ 29) | EN-написи кнопки «Create an account» / «Open your dashboard» |\n"
    . "| 2 | код: `app/mp-platform-promo.php`, `app/mpb-offer.php`, `app/mpb-card.php`, `app/marketplace-board.php`, `app/acquisition.php`, `app/promo-house.php`, `app/translations.php`, `app/translation-cache.php` | кнопка, позначка, noindex, ref mp-… |\n"
    . "| 3 | `promos-seed.sql` (`php scripts/mp-seed-promos.php --emit-sql`) | P1, P2 — published, P4 — draft; ідемпотентно, з умовами |\n\n"
    . "P4 публікує `php scripts/mp-publish-promos.php --slug=platform-post-free --emit-sql` (SQL для phpMyAdmin). Деталі — `docs/PROMO_LISTINGS.md`.\n";
file_put_contents("{$outDir}/INDEX.md", $idx);
fwrite(STDOUT, "OK INDEX.md\n");

// CHECKSUMS.txt — sha256 усіх файлів hosting-upload/ (крім самого CHECKSUMS.txt).
$lines = [];
$it = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($outDir, FilesystemIterator::SKIP_DOTS));
$all = [];
foreach ($it as $f) {
    if ($f->isFile() && $f->getFilename() !== 'CHECKSUMS.txt') {
        $all[] = str_replace('\\', '/', substr($f->getPathname(), strlen($outDir) + 1));
    }
}
sort($all);
foreach ($all as $rel) {
    $lines[] = hash_file('sha256', "{$outDir}/{$rel}") . '  ' . $rel;
}
file_put_contents("{$outDir}/CHECKSUMS.txt", "# sha256 файлів hosting-upload/, " . date('Y-m-d H:i') . "\n" . implode("\n", $lines) . "\n");
fwrite(STDOUT, 'OK CHECKSUMS.txt — ' . count($lines) . " файлів\n");
exit(0);
