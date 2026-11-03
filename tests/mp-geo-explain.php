<?php

declare(strict_types=1);

/**
 * AI LAB HUB — EXPLAIN пошуку за місцем (етап 6) на згенерованих оголошеннях. ЛОКАЛЬНА база, лише CLI.
 *   php tests/mp-geo-explain.php [кількість=5000]
 * Створює N опублікованих тестових оголошень дошки (заголовок «MPG-LOAD …») у випадкових містах UA/PL/DE/AU/US,
 * показує EXPLAIN і час запитів, потім видаляє ЛИШЕ створені записи за id.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
$_SESSION = [];
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-search.php';
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$n = max(100, (int) ($argv[1] ?? 5000));

$cities = $pdo->query("SELECT id, country_code, lat, lon FROM geo_places WHERE type = 'city' AND country_code IN ('UA','PL','DE','AU','US') ORDER BY RAND() LIMIT 3000")->fetchAll(PDO::FETCH_ASSOC);
$countryIds = $pdo->query("SELECT country_code, id FROM geo_places WHERE type = 'country' AND country_code IN ('UA','PL','DE','AU','US')")->fetchAll(PDO::FETCH_KEY_PAIR);
$ids = [];
mt_srand(42);
try {
    $pdo->beginTransaction();
    $insL = $pdo->prepare(
        "INSERT INTO mp_listings (section, seller_id, status, pricing_model, price_type, price_amount, currency, price_usd, delivery_type, source_lang,
                                  is_remote, work_format, service_scope, primary_place_id, country_code, lat, lon, service_radius_km,
                                  published_at, expires_at, created_at, updated_at)
         VALUES ('board', 1, 'published', 'free', 'fixed', :pa, 'USD', :pa2, 'contact', 'en', :rem, :wf, :sc, :pp, :cc, :lat, :lon, :rad,
                 NOW() - INTERVAL :age MINUTE, NOW() + INTERVAL 30 DAY, NOW(), NOW())"
    );
    $insT = $pdo->prepare("INSERT INTO mp_listing_translations (listing_id, lang, title, is_auto) VALUES (:id, 'en', :t, 0)");
    $insP = $pdo->prepare('INSERT INTO mp_listing_places (listing_id, place_id, radius_km, sort_order) VALUES (:l, :p, :r, 0)');
    for ($i = 0; $i < $n; $i++) {
        $c = $cities[mt_rand(0, count($cities) - 1)];
        $roll = mt_rand(1, 100);
        $wf = $roll <= 30 ? 'online' : ($roll <= 85 ? 'offline' : 'hybrid');
        $sc = $wf === 'online' ? (mt_rand(1, 3) === 1 ? 'country' : 'worldwide') : (mt_rand(1, 10) === 1 ? 'country' : 'local');
        $price = (string) mt_rand(5, 500);
        $insL->execute([':pa' => $price, ':pa2' => $price, ':rem' => $wf === 'offline' ? 0 : 1, ':wf' => $wf, ':sc' => $sc,
            ':pp' => $wf === 'online' ? null : $c['id'], ':cc' => $wf === 'online' ? null : $c['country_code'],
            ':lat' => $wf === 'online' ? null : $c['lat'], ':lon' => $wf === 'online' ? null : $c['lon'],
            ':rad' => $wf !== 'online' && $sc === 'local' ? [null, 10, 25][mt_rand(0, 2)] : null, ':age' => $i]);
        $id = (int) $pdo->lastInsertId();
        $ids[] = $id;
        $insT->execute([':id' => $id, ':t' => 'MPG-LOAD listing ' . $i]);
        if ($wf === 'online' && $sc === 'country') {
            $insP->execute([':l' => $id, ':p' => $countryIds[$c['country_code']], ':r' => null]);
        } elseif ($wf !== 'online' && mt_rand(1, 5) === 1) {
            $e = $cities[mt_rand(0, count($cities) - 1)];
            $insP->execute([':l' => $id, ':p' => $e['id'], ':r' => 10]);
        }
    }
    $pdo->commit();
    $pdo->query('ANALYZE TABLE mp_listings, mp_listing_places, geo_places')->fetchAll();
    echo "Створено $n оголошень (id " . min($ids) . '–' . max($ids) . ")\n\n";

    $lviv = mpg_place($pdo, 702550);
    $cases = [
        'place=Lviv r=25' => ['format' => 'any', 'show_online' => true, 'country' => '', 'place' => $lviv, 'radius_km' => 25.0],
        'place=Lviv r=100 offline' => ['format' => 'offline', 'show_online' => true, 'country' => '', 'place' => $lviv, 'radius_km' => 100.0],
        'country=UA' => ['format' => 'any', 'show_online' => true, 'country' => 'UA', 'place' => null, 'radius_km' => 25.0],
    ];
    foreach ($cases as $name => $g) {
        $params = [];
        $where = array_merge([mpb_visible_sql()], mpg_where($g, $params));
        $join = mpg_candidates_join($g, $params);
        $dist = $g['place'] !== null ? mpg_distance_sql($g['place']) . ' AS d,' : '';
        $sql = "SELECT $dist l.id " . ($join ?: 'FROM mp_listings l') . " WHERE " . implode(' AND ', $where)
            . ($g['place'] !== null ? ' ORDER BY d LIMIT 12' : ' ORDER BY l.published_at DESC LIMIT 12');
        $t = microtime(true);
        $st = $pdo->prepare($sql);
        $st->execute($params);
        $cnt = count($st->fetchAll());
        $ms = (microtime(true) - $t) * 1000;
        $cs = $pdo->prepare('SELECT COUNT(*) ' . ($join ?: 'FROM mp_listings l') . ' WHERE ' . implode(' AND ', $where));
        $t = microtime(true);
        $cs->execute($params);
        $total = (int) $cs->fetchColumn();
        $msC = (microtime(true) - $t) * 1000;
        printf("== %s: збігів %d, сторінка %d рядків за %.1f мс, COUNT за %.1f мс\n", $name, $total, $cnt, $ms, $msC);
        $ex = $pdo->prepare('EXPLAIN ' . $sql);
        $ex->execute($params);
        foreach ($ex->fetchAll(PDO::FETCH_ASSOC) as $r) {
            printf("   %-18s %-6s %-8s key=%-24s rows=%-6s %s\n", $r['select_type'], $r['table'], $r['type'], (string) $r['key'], (string) $r['rows'], (string) $r['Extra']);
        }
        echo "\n";
    }
    // Повний mpb_search (з текстами й сортуванням за відстанню)
    $f = mpb_search_filters($pdo, ['place' => '702550', 'radius' => '50', 'sort' => 'distance'], 'en', ['saved' => false, 'units' => 'km']);
    $t = microtime(true);
    $r = mpb_search($pdo, 'en', $f, 1);
    printf("mpb_search place=Lviv r=50 sort=distance: %d знайдено, %.1f мс\n", $r['total'], (microtime(true) - $t) * 1000);
} finally {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    if ($ids !== []) {
        $deleted = 0;
        foreach (array_chunk($ids, 1000) as $chunk) {
            $in = implode(',', array_map('intval', $chunk));
            $pdo->exec("DELETE FROM mp_listing_places WHERE listing_id IN ($in)");
            $pdo->exec("DELETE FROM mp_listing_translations WHERE listing_id IN ($in)");
            $deleted += $pdo->exec("DELETE FROM mp_listings WHERE id IN ($in)");
        }
        echo "\nВидалено тестових оголошень: $deleted\n";
    }
}
