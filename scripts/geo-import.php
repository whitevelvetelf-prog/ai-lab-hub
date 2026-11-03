<?php

declare(strict_types=1);

/**
 * AI LAB HUB — геодовідник Marketplace: файли GeoNames → SQL-частини для phpMyAdmin (≤ 2 МБ кожна).
 *
 * Джерело: https://download.geonames.org/export/dump/ (ліцензія CC BY 4.0, атрибуція «GeoNames»
 * показується на сторінці пошуку Marketplace). Потрібні файли (розпаковані, в одній теці):
 *   countryInfo.txt, admin1CodesASCII.txt, cities5000.txt (або cities15000.txt), alternateNamesV2.txt
 *
 * Запуск (CLI):
 *   php scripts/geo-import.php <тека з файлами GeoNames> [--cities=cities5000] [--out=hosting-upload/marketplace-geo] [--max-bytes=2000000]
 *
 * Результат: <out>/geo-data-01.sql, geo-data-02.sql, … — лише INSERT IGNORE у geo_places і geo_place_names
 * (таблиці створює database/migration-2026-11-03-marketplace-geo-places.sql — її запускати ПЕРШОЮ).
 * Повторний імпорт безпечний: id місця = geonameid (однакові id локально й на хостингу), назви —
 * UNIQUE (place_id, lang, name). Жодних DROP / DELETE / TRUNCATE.
 *
 * Що потрапляє: країни (countryInfo), регіони першого рівня (admin1), міста з файлу cities*; назви — лише
 * мовами uk та en (alternateNamesV2) + основна назва GeoNames і ASCII-варіант як en. Історичні й розмовні
 * назви йдуть як додаткові (для пошуку), основною (is_primary) не стають.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$args = array_slice($argv, 1);
$opts = ['cities' => 'cities5000', 'out' => dirname(__DIR__) . '/hosting-upload/marketplace-geo', 'max-bytes' => '2000000'];
$src = null;
foreach ($args as $a) {
    if (preg_match('/^--([a-z-]+)=(.*)$/', $a, $m) === 1 && array_key_exists($m[1], $opts)) {
        $opts[$m[1]] = $m[2];
    } elseif ($src === null && !str_starts_with($a, '--')) {
        $src = rtrim($a, '/\\');
    } else {
        fwrite(STDERR, "Невідомий аргумент: $a\n");
        exit(2);
    }
}
if ($src === null || !is_dir($src)) {
    fwrite(STDERR, "Використання: php scripts/geo-import.php <тека GeoNames> [--cities=cities5000|cities15000] [--out=…] [--max-bytes=2000000]\n");
    exit(2);
}
if (!in_array($opts['cities'], ['cities500', 'cities1000', 'cities5000', 'cities15000'], true)) {
    fwrite(STDERR, "--cities: cities500 | cities1000 | cities5000 | cities15000\n");
    exit(2);
}
$maxBytes = max(200000, (int) $opts['max-bytes']);
$files = [
    'country' => "$src/countryInfo.txt",
    'admin1'  => "$src/admin1CodesASCII.txt",
    'cities'  => "$src/{$opts['cities']}.txt",
    'alt'     => "$src/alternateNamesV2.txt",
];
foreach ($files as $f) {
    if (!is_file($f)) {
        fwrite(STDERR, "Немає файлу: $f\n");
        exit(2);
    }
}

const GEO_LANGS = ['uk', 'en'];

/** Рядок для SQL-літерала (MySQL, NO_BACKSLASH_ESCAPES вимкнено — типово і в phpMyAdmin). */
function geo_q(?string $s): string
{
    if ($s === null) {
        return 'NULL';
    }

    return "'" . str_replace(['\\', "'", "\0", "\n", "\r", "\x1a"], ['\\\\', "\\'", '\\0', '\\n', '\\r', '\\Z'], $s) . "'";
}

function geo_clean_name(string $s): string
{
    $s = trim(preg_replace('/\s+/u', ' ', $s) ?? '');

    return mb_substr($s, 0, 200);
}

// --- 1. Місця ---------------------------------------------------------------

/** @var array<int,array{type:string,cc:string,parent:?int,lat:?string,lon:?string,pop:int,tz:?string}> $places */
$places = [];
/** @var array<int,array<string,array<string,int>>> $names place => lang => [name => is_primary] */
$names = [];
$addName = static function (int $id, string $lang, string $name, int $primary) use (&$names): void {
    $name = geo_clean_name($name);
    if ($name === '') {
        return;
    }
    // Ключ без урахування регістру: колація utf8mb4_unicode_ci однаково зіллє їх в UNIQUE.
    $k = mb_strtolower($name);
    $cur = $names[$id][$lang][$k] ?? null;
    if ($cur === null) {
        $names[$id][$lang][$k] = [$name, $primary];
    } elseif ($primary && !$cur[1]) {
        $names[$id][$lang][$k] = [$name, 1];
    }
};

$countryByCc = [];
foreach (file($files['country'], FILE_IGNORE_NEW_LINES) as $line) {
    if ($line === '' || $line[0] === '#') {
        continue;
    }
    $c = explode("\t", $line);
    $cc = $c[0] ?? '';
    $gid = (int) ($c[16] ?? 0);
    if (preg_match('/^[A-Z]{2}$/', $cc) !== 1 || $gid <= 0) {
        continue;
    }
    $places[$gid] = ['type' => 'country', 'cc' => $cc, 'parent' => null, 'lat' => null, 'lon' => null, 'pop' => (int) ($c[7] ?? 0), 'tz' => null];
    $countryByCc[$cc] = $gid;
    $addName($gid, 'en', (string) $c[4], 1);
}

$regionByCode = [];
foreach (file($files['admin1'], FILE_IGNORE_NEW_LINES) as $line) {
    $c = explode("\t", $line);
    if (count($c) < 4) {
        continue;
    }
    [$code, $name, $ascii, $gid] = $c;
    $gid = (int) $gid;
    $cc = substr($code, 0, 2);
    if ($gid <= 0 || !isset($countryByCc[$cc]) || isset($places[$gid])) {
        continue;
    }
    $places[$gid] = ['type' => 'region', 'cc' => $cc, 'parent' => $countryByCc[$cc], 'lat' => null, 'lon' => null, 'pop' => 0, 'tz' => null];
    $regionByCode[$code] = $gid;
    $addName($gid, 'en', $name, 1);
    if ($ascii !== $name) {
        $addName($gid, 'en', $ascii, 0);
    }
}

$fh = fopen($files['cities'], 'rb');
while (($line = fgets($fh)) !== false) {
    $c = explode("\t", rtrim($line, "\r\n"));
    if (count($c) < 19) {
        continue;
    }
    $gid = (int) $c[0];
    $cc = $c[8];
    if ($gid <= 0 || !isset($countryByCc[$cc]) || isset($places[$gid])) {
        continue;
    }
    $parent = $regionByCode[$cc . '.' . $c[10]] ?? $countryByCc[$cc];
    $places[$gid] = [
        'type' => 'city', 'cc' => $cc, 'parent' => $parent,
        'lat' => number_format((float) $c[4], 6, '.', ''), 'lon' => number_format((float) $c[5], 6, '.', ''),
        'pop' => max(0, (int) $c[14]), 'tz' => $c[17] !== '' ? mb_substr($c[17], 0, 40) : null,
    ];
    $addName($gid, 'en', $c[1], 1);
    if ($c[2] !== '' && $c[2] !== $c[1]) {
        $addName($gid, 'en', $c[2], 0);
    }
}
fclose($fh);
fwrite(STDERR, sprintf("Місць: %d (країн %d, регіонів %d, міст %d)\n", count($places), count($countryByCc), count($regionByCode),
    count($places) - count($countryByCc) - count($regionByCode)));

// --- 2. Назви uk / en з alternateNamesV2 -------------------------------------
// Основна назва мови — «бажана» (isPreferredName) і не історична/розмовна; для en вона заміняє основну назву GeoNames.

$preferred = [];   // place => lang => name
$fh = fopen($files['alt'], 'rb');
$n = 0;
while (($line = fgets($fh)) !== false) {
    // Швидкий відсів до explode: мова — третє поле.
    $p1 = strpos($line, "\t");
    $p2 = $p1 === false ? false : strpos($line, "\t", $p1 + 1);
    $p3 = $p2 === false ? false : strpos($line, "\t", $p2 + 1);
    if ($p3 === false) {
        continue;
    }
    $lang = substr($line, $p2 + 1, $p3 - $p2 - 1);
    if ($lang !== 'uk' && $lang !== 'en') {
        continue;
    }
    $c = explode("\t", rtrim($line, "\r\n"));
    $gid = (int) $c[1];
    if (!isset($places[$gid])) {
        continue;
    }
    $name = (string) ($c[3] ?? '');
    $isPref = ($c[4] ?? '') === '1';
    $isHist = ($c[7] ?? '') === '1';
    $isColl = ($c[6] ?? '') === '1';
    if ($isPref && !$isHist && !$isColl && !isset($preferred[$gid][$lang])) {
        $preferred[$gid][$lang] = geo_clean_name($name);
    }
    $addName($gid, $lang, $name, 0);
    $n++;
}
fclose($fh);
fwrite(STDERR, "Альтернативних назв uk/en: $n\n");

// Розставляємо is_primary: рівно одна основна назва на (місце, мову), де назви є.
foreach ($names as $gid => &$byLang) {
    foreach ($byLang as $lang => &$list) {
        $want = $preferred[$gid][$lang] ?? null;
        if ($want !== null && isset($list[mb_strtolower($want)])) {
            foreach ($list as $k => &$v) {
                $v[1] = $k === mb_strtolower($want) ? 1 : 0;
            }
            unset($v);
            continue;
        }
        $hasPrimary = false;
        foreach ($list as &$v) {
            if ($v[1] === 1 && !$hasPrimary) {
                $hasPrimary = true;
            } else {
                $v[1] = 0;
            }
        }
        unset($v);
        if (!$hasPrimary) {
            $first = array_key_first($list);
            $list[$first][1] = 1;
        }
    }
    unset($list);
}
unset($byLang);

// --- 3. SQL-частини ----------------------------------------------------------

if (!is_dir($opts['out']) && !mkdir($opts['out'], 0775, true) && !is_dir($opts['out'])) {
    fwrite(STDERR, "Не вдалося створити теку {$opts['out']}\n");
    exit(1);
}
foreach (glob($opts['out'] . '/geo-data-*.sql') ?: [] as $old) {
    unlink($old);   // власні згенеровані файли попереднього запуску
}

$header = static fn(int $part): string => "-- AI LAB HUB — геодовідник Marketplace, частина $part. Дані: GeoNames (CC BY 4.0), "
    . date('Y-m-d') . ", {$opts['cities']}.\n"
    . "-- Спершу: database/migration-2026-11-03-marketplace-geo-places.sql. Лише INSERT IGNORE — повторний імпорт безпечний.\n"
    . "SET NAMES utf8mb4;\n";

$part = 0;
$buf = '';
$sizes = [];
$flush = static function () use (&$part, &$buf, &$sizes, $opts): void {
    if ($buf === '') {
        return;
    }
    $file = sprintf('%s/geo-data-%02d.sql', $opts['out'], $part);
    file_put_contents($file, $buf);
    $sizes[basename($file)] = strlen($buf);
    $buf = '';
};
$emit = static function (string $insertHead, array $rows) use (&$part, &$buf, $flush, $header, $maxBytes): void {
    $chunk = 400;
    for ($i = 0, $cnt = count($rows); $i < $cnt; $i += $chunk) {
        $stmt = $insertHead . "\n" . implode(",\n", array_slice($rows, $i, $chunk)) . ";\n";
        if ($buf !== '' && strlen($buf) + strlen($stmt) > $maxBytes) {
            $flush();
        }
        if ($buf === '') {
            $part++;
            $buf = $header($part);
        }
        $buf .= $stmt;
    }
};

// Місця: спершу країни, потім регіони, потім міста (батьки раніше за дітей — для читабельності; FK немає).
$order = ['country' => 0, 'region' => 1, 'city' => 2];
uksort($places, static fn(int $a, int $b): int => [$order[$places[$a]['type']], $a] <=> [$order[$places[$b]['type']], $b]);
$rows = [];
foreach ($places as $gid => $p) {
    $rows[] = sprintf('(%d,%d,%s,%s,%s,%s,%s,%d,%s)', $gid, $gid, geo_q($p['type']), geo_q($p['cc']),
        $p['parent'] === null ? 'NULL' : (string) $p['parent'], $p['lat'] ?? 'NULL', $p['lon'] ?? 'NULL', $p['pop'], geo_q($p['tz']));
}
$emit('INSERT IGNORE INTO geo_places (id, geoname_id, type, country_code, parent_id, lat, lon, population, timezone) VALUES', $rows);

$rows = [];
$nameCount = 0;
foreach ($places as $gid => $_) {
    foreach ($names[$gid] ?? [] as $lang => $list) {
        foreach ($list as [$name, $primary]) {
            $rows[] = sprintf('(%d,%s,%s,%d)', $gid, geo_q($lang), geo_q($name), $primary);
            $nameCount++;
        }
    }
}
$emit('INSERT IGNORE INTO geo_place_names (place_id, lang, name, is_primary) VALUES', $rows);
$flush();

$total = array_sum($sizes);
fwrite(STDERR, "Назв: $nameCount\n");
foreach ($sizes as $f => $s) {
    printf("%s\t%s KB\n", $f, number_format($s / 1024, 0, '.', ' '));
}
printf("Разом: %d файлів, %.2f МБ\n", count($sizes), $total / 1048576);
