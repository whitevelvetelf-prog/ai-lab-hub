<?php

declare(strict_types=1);

/**
 * AI LAB HUB — геодовідник: МІСЦЕВІ назви місць (мовами країни) як доповнення до uk/en з scripts/geo-import.php.
 *
 * Навіщо: автопідказка шукає за будь-якою назвою (geo_place_names.name LIKE 'q%'), а етап 6 імпортував лише uk/en —
 * тож «Warszawa», «München», «Praha», «Lwów» не знаходились. Тут додаються назви мовами, які GeoNames вказує для
 * країни місця (countryInfo.txt, колонка Languages), ОКРІМ російської (рішення власника 2026-11-19).
 * Історичні й розмовні назви не беруться. Назва, що вже є в місця (без урахування регістру й діакритики — як
 * колація utf8mb4_unicode_ci), не дублюється. Місця не додаються: лише назви для id, що вже є в geo_places
 * (локальна база = прод, той самий імпорт 2026-11-03).
 *
 * Запуск (CLI):
 *   php scripts/geo-local-names.php <тека з countryInfo.txt і alternateNamesV2.txt> [--out=hosting-upload/marketplace-geo-local] [--max-bytes=2000000]
 *
 * Результат: <out>/geo-local-NN.sql — лише INSERT IGNORE у geo_place_names (UNIQUE place_id, lang, name),
 * повторний імпорт безпечний. Жодних DROP / DELETE / TRUNCATE. Дані: GeoNames (CC BY 4.0).
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

const GEO_LOCAL_EXCLUDE = ['ru'];

$args = array_slice($argv, 1);
$opts = ['out' => dirname(__DIR__) . '/hosting-upload/marketplace-geo-local', 'max-bytes' => '2000000'];
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
if ($src === null || !is_file("$src/countryInfo.txt") || !is_file("$src/alternateNamesV2.txt")) {
    fwrite(STDERR, "Використання: php scripts/geo-local-names.php <тека з countryInfo.txt і alternateNamesV2.txt> [--out=…] [--max-bytes=2000000]\n");
    exit(2);
}
$maxBytes = max(200000, (int) $opts['max-bytes']);

function gl_q(string $s): string
{
    return "'" . str_replace(['\\', "'", "\0", "\n", "\r", "\x1a"], ['\\\\', "\\'", '\\0', '\\n', '\\r', '\\Z'], $s) . "'";
}

function gl_clean(string $s): string
{
    return mb_substr(trim(preg_replace('/\s+/u', ' ', $s) ?? ''), 0, 200);
}

/** Ключ порівняння, близький до utf8mb4_unicode_ci: без регістру й діакритики. */
function gl_key(string $s): string
{
    $s = mb_strtolower($s);
    if (class_exists('Normalizer')) {
        $d = Normalizer::normalize($s, Normalizer::FORM_D);
        if (is_string($d)) {
            $s = preg_replace('/\p{Mn}+/u', '', $d) ?? $s;
        }
    }

    return $s;
}

// --- Мови країн -----------------------------------------------------------------
$langsByCc = [];
foreach (file("$src/countryInfo.txt", FILE_IGNORE_NEW_LINES) as $line) {
    if ($line === '' || $line[0] === '#') {
        continue;
    }
    $c = explode("\t", $line);
    $cc = $c[0] ?? '';
    if (preg_match('/^[A-Z]{2}$/', $cc) !== 1) {
        continue;
    }
    $set = [];
    foreach (explode(',', (string) ($c[15] ?? '')) as $l) {
        $l = strtolower(trim(explode('-', trim($l))[0]));
        if (preg_match('/^[a-z]{2,3}$/', $l) === 1 && !in_array($l, GEO_LOCAL_EXCLUDE, true) && $l !== 'uk' && $l !== 'en') {
            $set[$l] = true;   // uk/en уже імпортовані основним скриптом
        }
    }
    $langsByCc[$cc] = $set;
}

// --- Місця й наявні назви з бази ------------------------------------------------
/** @var PDO $pdo */
$pdo = require dirname(__DIR__) . '/config/database.php';
$ccById = [];
foreach ($pdo->query('SELECT id, country_code FROM geo_places', PDO::FETCH_NUM) as [$id, $cc]) {
    $ccById[(int) $id] = (string) $cc;
}
$have = [];
foreach ($pdo->query('SELECT place_id, name FROM geo_place_names', PDO::FETCH_NUM) as [$pid, $name]) {
    $have[(int) $pid][gl_key((string) $name)] = true;
}
fwrite(STDERR, sprintf("Місць у базі: %d\n", count($ccById)));

// --- alternateNamesV2 ----------------------------------------------------------
// Колонки: alternateNameId, geonameid, isolanguage, alternate name, isPreferredName, isShortName, isColloquial, isHistoric, from, to
$add = [];        // pid => lang => key => [name, primary]
$fh = fopen("$src/alternateNamesV2.txt", 'rb');
while (($line = fgets($fh)) !== false) {
    $c = explode("\t", rtrim($line, "\r\n"));
    if (count($c) < 4) {
        continue;
    }
    $pid = (int) $c[1];
    $lang = strtolower(explode('-', $c[2])[0]);
    if (!isset($ccById[$pid]) || $lang === '' || !isset($langsByCc[$ccById[$pid]][$lang])) {
        continue;
    }
    if (($c[6] ?? '') === '1' || ($c[7] ?? '') === '1' || (($c[9] ?? '') !== '')) {
        continue;   // розмовні, історичні, з датою завершення
    }
    $name = gl_clean((string) $c[3]);
    if ($name === '' || mb_strlen($name) < 2 || preg_match('/^[\d\W_]+$/u', $name) === 1) {
        continue;
    }
    $k = gl_key($name);
    if (isset($have[$pid][$k]) || isset($add[$pid][$lang][$k])) {
        continue;
    }
    $add[$pid][$lang][$k] = [$name, ($c[4] ?? '') === '1' ? 1 : 0];
}
fclose($fh);

// --- SQL ------------------------------------------------------------------------
if (!is_dir($opts['out']) && !mkdir($opts['out'], 0775, true) && !is_dir($opts['out'])) {
    fwrite(STDERR, "Не вдалося створити теку {$opts['out']}\n");
    exit(1);
}
foreach (glob($opts['out'] . '/geo-local-*.sql') ?: [] as $old) {
    unlink($old);   // власні згенеровані файли попереднього запуску
}
ksort($add);
$rows = [];
$byLang = [];
foreach ($add as $pid => $langs) {
    foreach ($langs as $lang => $list) {
        $primarySeen = false;
        foreach ($list as [$name, $pr]) {
            $pr = $pr === 1 && !$primarySeen ? 1 : 0;
            $primarySeen = $primarySeen || $pr === 1;
            $rows[] = sprintf('(%d,%s,%s,%d)', $pid, gl_q($lang), gl_q($name), $pr);
            $byLang[$lang] = ($byLang[$lang] ?? 0) + 1;
        }
    }
}
$head = static fn(int $p): string => "-- AI LAB HUB — геодовідник: місцеві назви (мовами країни, без ru), частина $p. Дані: GeoNames (CC BY 4.0), "
    . date('Y-m-d') . ".\n-- Доповнює geo-data-01…05 (етап 6). Лише INSERT IGNORE — повторний імпорт безпечний.\nSET NAMES utf8mb4;\n";
$part = 0;
$buf = '';
$sizes = [];
$flush = static function () use (&$part, &$buf, &$sizes, $opts): void {
    if ($buf !== '') {
        $f = sprintf('%s/geo-local-%02d.sql', $opts['out'], $part);
        file_put_contents($f, $buf);
        $sizes[basename($f)] = strlen($buf);
        $buf = '';
    }
};
for ($i = 0, $n = count($rows); $i < $n; $i += 400) {
    $stmt = "INSERT IGNORE INTO geo_place_names (place_id, lang, name, is_primary) VALUES\n" . implode(",\n", array_slice($rows, $i, 400)) . ";\n";
    if ($buf !== '' && strlen($buf) + strlen($stmt) > $maxBytes) {
        $flush();
    }
    if ($buf === '') {
        $part++;
        $buf = $head($part);
    }
    $buf .= $stmt;
}
$flush();

arsort($byLang);
fwrite(STDERR, 'Назв: ' . count($rows) . '; мови (топ-15): ' . implode(', ', array_map(static fn($l, $c) => "$l $c", array_keys(array_slice($byLang, 0, 15, true)), array_slice($byLang, 0, 15, true))) . "\n");
foreach ($sizes as $f => $s) {
    printf("%s\t%s KB\n", $f, number_format($s / 1024, 0, '.', ' '));
}
printf("Разом: %d файлів, %.2f МБ\n", count($sizes), array_sum($sizes) / 1048576);
