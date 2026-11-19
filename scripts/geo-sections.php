<?php

declare(strict_types=1);

/**
 * AI LAB HUB — геодовідник: частини міст (GeoNames feature code PPLX) → SQL для таблиці geo_place_sections (№ 27).
 *
 * Запуск (CLI): php scripts/geo-sections.php <тека з cities5000.txt> [--cities=cities5000] [--out=hosting-upload/marketplace-geo-local]
 * Результат: <out>/geo-sections-01.sql — лише INSERT IGNORE, тільки для id, що вже є в geo_places. Дані: GeoNames (CC BY 4.0).
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$opts = ['cities' => 'cities5000', 'out' => dirname(__DIR__) . '/hosting-upload/marketplace-geo-local'];
$src = null;
foreach (array_slice($argv, 1) as $a) {
    if (preg_match('/^--([a-z-]+)=(.*)$/', $a, $m) === 1 && array_key_exists($m[1], $opts)) {
        $opts[$m[1]] = $m[2];
    } elseif ($src === null && !str_starts_with($a, '--')) {
        $src = rtrim($a, '/\\');
    } else {
        fwrite(STDERR, "Невідомий аргумент: $a\n");
        exit(2);
    }
}
$file = $src . '/' . $opts['cities'] . '.txt';
if ($src === null || !is_file($file) || preg_match('/^cities(500|1000|5000|15000)$/', $opts['cities']) !== 1) {
    fwrite(STDERR, "Використання: php scripts/geo-sections.php <тека з cities5000.txt> [--cities=cities5000] [--out=…]\n");
    exit(2);
}

/** @var PDO $pdo */
$pdo = require dirname(__DIR__) . '/config/database.php';
$cities = [];
foreach ($pdo->query("SELECT id FROM geo_places WHERE type = 'city'", PDO::FETCH_NUM) as [$id]) {
    $cities[(int) $id] = true;
}

// 1) PPLX — частина населеного пункту. 2) GeoNames непослідовний (округи Парижа — PPL, Марселя — PPLA5), тож
// також: назва «<місто> <номер>» («Paris 15 Vaugirard», «Marseille 13», «Budapest XI. kerület»), де <місто> —
// більше місто тієї ж країни в межах 25 км. Номер — лише через пробіл: «Noginsk-9» — окреме селище.
$ids = [];
$all = [];          // id => [name, cc, lat, lon, pop]
$byName = [];       // cc|name => list<id>
$fh = fopen($file, 'rb');
while (($line = fgets($fh)) !== false) {
    $c = explode("\t", $line);
    if (count($c) < 15 || !isset($cities[(int) $c[0]])) {
        continue;
    }
    $id = (int) $c[0];
    if ($c[7] === 'PPLX') {
        $ids[$id] = true;
    }
    $all[$id] = [$c[1], $c[8], (float) $c[4], (float) $c[5], (int) $c[14]];
    $byName[$c[8] . '|' . mb_strtolower($c[1])][] = $id;
}
fclose($fh);
$numbered = 0;
foreach ($all as $id => [$name, $cc, $lat, $lon, $pop]) {
    if (isset($ids[$id]) || preg_match('/^(.+?),? (\d{1,2}|[IVXL]{1,5})\b/u', $name, $m) !== 1) {
        continue;
    }
    foreach ($byName[$cc . '|' . mb_strtolower(trim($m[1]))] ?? [] as $pid) {
        [, , $plat, $plon, $ppop] = $all[$pid];
        $dLat = deg2rad($plat - $lat);
        $dLon = deg2rad($plon - $lon);
        $h = sin($dLat / 2) ** 2 + cos(deg2rad($lat)) * cos(deg2rad($plat)) * sin($dLon / 2) ** 2;
        if ($pid !== $id && $ppop > $pop && 12742 * asin(min(1, sqrt($h))) <= 25) {
            $ids[$id] = true;
            $numbered++;
            break;
        }
    }
}
$ids = array_keys($ids);
sort($ids);
fwrite(STDERR, "З них «місто + номер» (не PPLX): $numbered\n");

if (!is_dir($opts['out'])) {
    mkdir($opts['out'], 0775, true);
}
$sql = "-- AI LAB HUB — частини міст (GeoNames PPLX), " . date('Y-m-d') . ". Спершу міграція № 27. Лише INSERT IGNORE.\nSET NAMES utf8mb4;\n";
foreach (array_chunk($ids, 1000) as $chunk) {
    $sql .= 'INSERT IGNORE INTO geo_place_sections (place_id) VALUES (' . implode('),(', $chunk) . ");\n";
}
$out = $opts['out'] . '/geo-sections-01.sql';
file_put_contents($out, $sql);
printf("Частин міст: %d → %s (%s KB)\n", count($ids), basename($out), number_format(strlen($sql) / 1024, 0, '.', ' '));
