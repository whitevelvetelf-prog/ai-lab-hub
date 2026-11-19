<?php

declare(strict_types=1);

/**
 * AI LAB HUB — геодовідник: українські назви для місць, яким їх бракує в GeoNames (регіони, найбільші міста, країни).
 *
 * Джерело: Вікідані (CC0) — мітка uk елемента з тим самим GeoNames ID (властивість P1566). Запити до
 * query.wikidata.org пакетами по 200 id, без персональних даних. Результат — SQL лише з INSERT IGNORE у
 * geo_place_names (lang = 'uk'); нові місця не додаються, наявні назви не змінюються.
 *
 * Запуск (CLI):
 *   php scripts/geo-uk-names-wikidata.php [--min-pop=100000] [--out=hosting-upload/marketplace-geo-local] [--dry]
 *
 * Відбір місць: тип region або country — усі без uk-назви; тип city — без uk-назви й population >= --min-pop.
 * Кілька елементів Вікіданих на один GeoNames ID: беремо мітку, спільну для більшості; для міст пропускаємо мітки
 * з «район / громада / муніципалітет / округ / провінція / комуна» (адмінодиниці з тим самим id), за рівності — коротшу.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$opts = ['min-pop' => '100000', 'out' => dirname(__DIR__) . '/hosting-upload/marketplace-geo-local'];
$dry = false;
foreach (array_slice($argv, 1) as $a) {
    if ($a === '--dry') {
        $dry = true;
    } elseif (preg_match('/^--([a-z-]+)=(.*)$/', $a, $m) === 1 && array_key_exists($m[1], $opts)) {
        $opts[$m[1]] = $m[2];
    } else {
        fwrite(STDERR, "Невідомий аргумент: $a\n");
        exit(2);
    }
}
$minPop = max(0, (int) $opts['min-pop']);

/** @var PDO $pdo */
$pdo = require dirname(__DIR__) . '/config/database.php';
$st = $pdo->prepare(
    "SELECT g.id, g.type FROM geo_places g
     WHERE (g.type IN ('region','country') OR (g.type = 'city' AND g.population >= :p))
       AND NOT EXISTS (SELECT 1 FROM geo_place_names n WHERE n.place_id = g.id AND n.lang = 'uk')
     ORDER BY g.id"
);
$st->execute([':p' => $minPop]);
$want = [];
foreach ($st->fetchAll(PDO::FETCH_NUM) as [$id, $type]) {
    $want[(int) $id] = (string) $type;
}
fwrite(STDERR, sprintf("Місць без uk-назви: %d\n", count($want)));

function gw_query(array $ids): array
{
    $values = implode(' ', array_map(static fn(int $i): string => '"' . $i . '"', $ids));
    $sparql = "SELECT ?gid ?label WHERE { VALUES ?gid { $values } ?item wdt:P1566 ?gid . ?item rdfs:label ?label . FILTER(LANG(?label) = \"uk\") }";
    for ($try = 1; $try <= 4; $try++) {
        $ch = curl_init('https://query.wikidata.org/sparql');
        curl_setopt_array($ch, [
            CURLOPT_POST => true,
            CURLOPT_POSTFIELDS => http_build_query(['query' => $sparql, 'format' => 'json']),
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT => 90,
            CURLOPT_HTTPHEADER => ['Accept: application/sparql-results+json', 'User-Agent: geo-names-batch/1.0 (GeoNames id to uk label lookup)'],
        ]);
        $body = curl_exec($ch);
        $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        if ($code === 200 && is_string($body)) {
            $j = json_decode($body, true);
            $out = [];
            foreach ($j['results']['bindings'] ?? [] as $b) {
                $out[] = [(int) $b['gid']['value'], (string) $b['label']['value']];
            }

            return $out;
        }
        fwrite(STDERR, "  HTTP $code, повтор $try\n");
        sleep(5 * $try);
    }
    throw new RuntimeException('Вікідані не відповідають');
}

$labels = [];   // gid => [label => count]
$ids = array_keys($want);
foreach (array_chunk($ids, 200) as $i => $chunk) {
    foreach (gw_query($chunk) as [$gid, $label]) {
        $label = trim(preg_replace('/\s+/u', ' ', $label) ?? '');
        if (isset($want[$gid]) && $want[$gid] === 'city') {
            // «Салем (Індія)» → «Салем»: уточнення не потрібне, країна й регіон є в підписі місця.
            $label = trim(preg_replace('/\s*\([^()]*\)$/u', '', $label) ?? $label);
        }
        if ($label !== '' && isset($want[$gid])) {
            $labels[$gid][$label] = ($labels[$gid][$label] ?? 0) + 1;
        }
    }
    fwrite(STDERR, sprintf("  пакет %d: усього знайдено %d\n", $i + 1, count($labels)));
    usleep(700000);
}

$adminWords = '/\b(район|громада|муніципалітет|округ|провінція|комуна|повіт|гміна|префектура)\b/iu';
$pick = [];
$skipped = 0;
foreach ($labels as $gid => $cands) {
    if ($want[$gid] === 'city') {
        $cands = array_filter($cands, static fn($c, $l) => preg_match($adminWords, (string) $l) !== 1, ARRAY_FILTER_USE_BOTH);
    }
    // Латиниця в «українській» мітці — зазвичай неперекладена назва; такі не беремо.
    $cands = array_filter($cands, static fn($c, $l) => preg_match('/\p{Cyrillic}/u', (string) $l) === 1 && preg_match('/[A-Za-z]/', (string) $l) !== 1, ARRAY_FILTER_USE_BOTH);
    if ($cands === []) {
        $skipped++;
        continue;
    }
    uksort($cands, static fn($a, $b) => [$cands[$b], mb_strlen((string) $a)] <=> [$cands[$a], mb_strlen((string) $b)]);
    $pick[$gid] = mb_substr((string) array_key_first($cands), 0, 200);
}
$byType = array_count_values(array_map(static fn($g) => $want[$g], array_keys($pick)));
fwrite(STDERR, sprintf("Назв для запису: %d (%s); без придатної мітки: %d; не знайдено у Вікіданих: %d\n",
    count($pick), json_encode($byType, JSON_UNESCAPED_UNICODE), $skipped, count($want) - count($labels)));

if ($dry) {
    $sample = array_slice($pick, 0, 40, true);
    foreach ($sample as $g => $l) {
        echo "$g\t{$want[$g]}\t$l\n";
    }
    exit(0);
}

$q = static fn(string $s): string => "'" . str_replace(['\\', "'"], ['\\\\', "\\'"], $s) . "'";
$rows = [];
foreach ($pick as $gid => $label) {
    $rows[] = sprintf('(%d,%s,%s,1)', $gid, "'uk'", $q($label));
}
if (!is_dir($opts['out'])) {
    mkdir($opts['out'], 0775, true);
}
$sql = "-- AI LAB HUB — геодовідник: українські назви з Вікіданих (CC0) для місць без uk у GeoNames, " . date('Y-m-d')
    . ".\n-- Регіони й країни — усі без uk; міста — населення >= $minPop. Лише INSERT IGNORE — повторний імпорт безпечний.\nSET NAMES utf8mb4;\n";
foreach (array_chunk($rows, 400) as $chunk) {
    $sql .= "INSERT IGNORE INTO geo_place_names (place_id, lang, name, is_primary) VALUES\n" . implode(",\n", $chunk) . ";\n";
}
$file = $opts['out'] . '/geo-uk-wikidata-01.sql';
file_put_contents($file, $sql);
printf("%s\t%s KB\n", basename($file), number_format(strlen($sql) / 1024, 0, '.', ' '));
