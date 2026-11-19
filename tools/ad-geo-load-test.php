<?php

declare(strict_types=1);

/**
 * AI LAB HUB — навантажувальний тест географії реклами (app/ad-geo.php у app/promo-select.php).
 *
 *   php tools/ad-geo-load-test.php [кількість кампаній, за замовчуванням 5000]
 *
 * Тимчасово створює N активних відеокампаній (власна реклама, без білінгу; advertiser_name 'GEOLOAD'), кожна з
 * креативом і таргетом popup. ~60% мають географію: include країни (UA/PL/DE/US/AU/CA/GB), include міста з радіусом,
 * exclude країни / міста, режим soft або strict. Міряє для відвідувачів «місто Київ», «лише країна AU», «невідомо»:
 *   * promo_candidates без кешу (SQL із відбором за країною) і з кешем;
 *   * adgeo_filter_rows (радіус у PHP над кампаніями з правилами);
 *   * promo_pick_set повністю (як ad-next.php);
 * і друкує EXPLAIN запиту кандидатів. Після вимірів видаляє ЛИШЕ створені рядки за id (finally) і повертає
 * налаштування реклами. Лише локально / на тестовій базі.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/promo.php';
require_once __DIR__ . '/../app/promo-admin.php';
require_once __DIR__ . '/../app/ad-geo.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);
if (!adgeo_ready($pdo) || !mpg_ready($pdo)) {
    fwrite(STDERR, "Міграцію № 24 або геодовідник не застосовано\n");
    exit(1);
}

$n = max(100, (int) ($argv[1] ?? 5000));
$runs = 20;
$marker = 'GEOLOAD';
$ids = [];
$oldEnabled = promo_setting($pdo, 'enabled', '0');

$stats = static function (array $ms): string {
    sort($ms);
    $p = static fn(float $q): float => $ms[min(count($ms) - 1, (int) floor($q * (count($ms) - 1)))];

    return sprintf('медіана %7.2f мс · p95 %7.2f мс · макс %7.2f мс', $p(0.5), $p(0.95), max($ms));
};

try {
    promo_admin_set_setting($pdo, 'enabled', '1');
    promo_settings($pdo, true);

    $countries = ['UA', 'PL', 'DE', 'US', 'AU', 'CA', 'GB'];
    $cid = [];
    foreach ($countries as $cc) {
        $cid[$cc] = (int) mpg_country_id($pdo, $cc);
    }
    // До 40 найбільших міст кожної країни — цілі для include / exclude.
    $cities = [];
    foreach ($countries as $cc) {
        $st = $pdo->prepare("SELECT id FROM geo_places WHERE type = 'city' AND country_code = :c ORDER BY population DESC LIMIT 40");
        $st->execute([':c' => $cc]);
        $cities[$cc] = array_map('intval', $st->fetchAll(PDO::FETCH_COLUMN));
    }
    $place = static function (int $id) use ($pdo): array {
        return mpg_place($pdo, $id) ?? throw new RuntimeException("немає місця $id");
    };

    // --- Генерація -------------------------------------------------------------
    $t0 = microtime(true);
    mt_srand(42);
    $today = promo_today();
    $withGeo = 0;
    $geoRows = 0;
    $pdo->beginTransaction();
    for ($done = 0; $done < $n; $done += 500) {
        $batch = min(500, $n - $done);
        $rows = [];
        for ($i = 0; $i < $batch; $i++) {
            $rows[] = sprintf("('internal','video',NULL,%s,%s,'geoload@example.test','awareness',%s,'active',%s,'ai_tools')",
                $pdo->quote($marker . '-' . ($done + $i)), $pdo->quote($marker), $pdo->quote($today), $pdo->quote(PROMO_CURRENCY));
        }
        $pdo->exec('INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, contact_email, objective, start_date, status, currency, advertiser_category) VALUES ' . implode(',', $rows));
        $first = (int) $pdo->lastInsertId();
        $cr = [];
        $tg = [];
        $geo = [];
        $set = [];
        for ($i = 0; $i < $batch; $i++) {
            $c = $first + $i;
            $ids[] = $c;
            $tg[] = sprintf("(%d,'popup')", $c);
            $cr[] = sprintf("(%d,%s,'geo load','learn_more','https://example.com/','youtube','dQw4w9WgXcQ','approved','video',1)", $c, $pdo->quote($marker . ' ' . $c));
            if (mt_rand(1, 100) > 60) {
                continue;
            }
            $withGeo++;
            $cc = $countries[array_rand($countries)];
            $r = mt_rand(1, 100);
            $mk = static function (string $mode, int $pid) use ($place, &$geo, &$geoRows, $c): void {
                $p = $place($pid);
                $radius = $p['type'] === 'city' ? [5, 10, 25, 50, 100, 200][mt_rand(0, 5)] : null;
                $geo[] = sprintf("(%d,'%s',%d,'%s','%s',%s,1)", $c, $mode, $p['id'], $p['type'], $p['country_code'], $radius === null ? 'NULL' : (string) $radius);
                $geoRows++;
            };
            if ($r <= 40) {
                $mk('include', $cid[$cc]);                                     // країна
            } elseif ($r <= 80) {
                $mk('include', $cities[$cc][array_rand($cities[$cc])]);       // місто з радіусом
                if (mt_rand(0, 1)) {
                    $cc2 = $countries[array_rand($countries)];
                    $pid = $cities[$cc2][array_rand($cities[$cc2])];
                    if ($pid !== $cities[$cc][0]) {
                        $mk('include', $pid);
                    }
                }
            } else {
                $mk('exclude', $cid[$cc]);                                     // країна-виняток
            }
            if (mt_rand(1, 100) <= 15) {
                $ccx = $countries[array_rand($countries)];
                $mk('exclude', $cities[$ccx][array_rand($cities[$ccx])]);
            }
            $set[] = sprintf("(%d,'%s')", $c, mt_rand(1, 100) <= 30 ? 'strict' : 'soft');
        }
        $pdo->exec('INSERT INTO ad_creatives (campaign_id, title, description, cta_key, destination_url, video_type, youtube_id, status, creative_type, weight) VALUES ' . implode(',', $cr));
        $pdo->exec('INSERT INTO ad_targets (campaign_id, placement) VALUES ' . implode(',', $tg));
        if ($geo !== []) {
            $pdo->exec('INSERT IGNORE INTO ad_campaign_geo (campaign_id, mode, place_id, place_type, country_code, radius_km, is_active) VALUES ' . implode(',', $geo));
        }
        if ($set !== []) {
            $pdo->exec('INSERT INTO ad_campaign_geo_settings (campaign_id, match_mode) VALUES ' . implode(',', $set));
        }
    }
    $pdo->commit();
    $pdo->query('ANALYZE TABLE ad_campaign_geo, ad_campaign_geo_settings')->fetchAll();   // результат треба прочитати
    printf("Створено: %d кампаній (з географією: %d, правил: %d) за %.1f с\n", count($ids), $withGeo, $geoRows, microtime(true) - $t0);
    printf("Кеш: %s\n\n", promo_cache_apcu() ? 'APCu' : 'файли storage/cache/promo (APCu немає)');

    $kyiv = $place(703448);
    $visitors = [
        'місто Київ (UA)' => ['country_code' => 'UA', 'place_id' => 703448, 'lat' => $kyiv['lat'], 'lon' => $kyiv['lon'], 'source' => 'user', 'known' => true],
        'лише країна AU' => ['country_code' => 'AU', 'place_id' => null, 'lat' => null, 'lon' => null, 'source' => 'user', 'known' => true],
        'місце невідоме' => geo_unknown(),
    ];

    [$sql, $params] = promo_candidates_sql($pdo, 'popup', [], [], 'uk', 'desktop', [], false, $today, true, 'UA');
    $ex = $pdo->prepare('EXPLAIN ' . $sql);
    $ex->execute($params);
    echo "EXPLAIN запиту кандидатів (відвідувач з UA):\n";
    foreach ($ex->fetchAll(PDO::FETCH_ASSOC) as $r) {
        printf("  %-20s %-6s %-7s key=%-34s rows=%-6s %s\n", (string) $r['select_type'], (string) $r['table'], (string) $r['type'], (string) ($r['key'] ?? '—'), (string) $r['rows'], (string) ($r['Extra'] ?? ''));
    }
    echo "\n";

    // Сирий SQL кандидатів (без кешу): як до географії та з географією — ціна EXISTS-підзапитів.
    foreach (['без географії (як до 2026-11-19)' => [false, null], 'з географією, відвідувач UA' => [true, 'UA'], 'з географією, місце невідоме' => [true, null]] as $label => [$on, $cc]) {
        [$sqlX, $paramsX] = promo_candidates_sql($pdo, 'popup', [], [], 'uk', 'desktop', [], false, $today, $on, $cc);
        $ms = [];
        $cnt = 0;
        for ($i = 0; $i < $runs; $i++) {
            $t = hrtime(true);
            $st = $pdo->prepare($sqlX);
            $st->execute($paramsX);
            $cnt = count($st->fetchAll(PDO::FETCH_ASSOC));
            $ms[] = (hrtime(true) - $t) / 1e6;
        }
        printf("SQL кандидатів %-34s %5d рядків · %s\n", $label . ':', $cnt, $stats($ms));
    }
    echo "\n";

    $mine = array_flip($ids);
    foreach ($visitors as $label => $v) {
        $cold = [];
        $warm = [];
        $php = [];
        $pick = [];
        $nCand = 0;
        $nPass = 0;
        $cc = !empty($v['known']) ? (string) $v['country_code'] : null;
        for ($i = 0; $i < $runs; $i++) {
            promo_cache_flush();
            $t = hrtime(true);
            $rows = promo_candidates($pdo, 'popup', [], [], 'uk', 'desktop', [], $cc);
            $cold[] = (hrtime(true) - $t) / 1e6;
            $t = hrtime(true);
            promo_candidates($pdo, 'popup', [], [], 'uk', 'desktop', [], $cc);
            $warm[] = (hrtime(true) - $t) / 1e6;
            $t = hrtime(true);
            $pass = adgeo_filter_rows($pdo, $rows, $v);
            $php[] = (hrtime(true) - $t) / 1e6;
            $nCand = count(array_filter($rows, static fn($r) => isset($mine[$r['campaign_id']])));
            $nPass = count(array_filter($pass, static fn($r) => isset($mine[$r['campaign_id']])));
            $t = hrtime(true);
            promo_pick_set($pdo, 'popup', [], [], 'uk', 'desktop', hash('sha256', 'geoload' . $i . $label), ['geo' => $v], [], 1);
            $pick[] = (hrtime(true) - $t) / 1e6;
        }
        printf("%s — після SQL: %d кандидатів, після радіуса/режиму: %d (%d вимірів)\n", $label, $nCand, $nPass, $runs);
        printf("  кандидати без кешу (SQL):     %s\n", $stats($cold));
        printf("  кандидати з кешем (60 с):     %s\n", $stats($warm));
        printf("  радіус і режим у PHP:         %s\n", $stats($php));
        printf("  вибір 1 (як ad-next), з кешем: %s\n\n", $stats($pick));
    }
} catch (Throwable $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    echo 'ПОМИЛКА: ' . $e->getMessage() . ' @' . basename($e->getFile()) . ':' . $e->getLine() . "\n";
} finally {
    // Спершу повернути налаштування, потім прибрати ЛИШЕ створені рядки за id
    promo_admin_set_setting($pdo, 'enabled', $oldEnabled);
    $removed = 0;
    foreach (array_chunk($ids, 500) as $chunk) {
        $in = implode(',', array_map('intval', $chunk));
        $pdo->exec("DELETE FROM ad_campaign_geo WHERE campaign_id IN ($in)");
        $pdo->exec("DELETE FROM ad_campaign_geo_settings WHERE campaign_id IN ($in)");
        $pdo->exec("DELETE FROM ad_stats_daily WHERE campaign_id IN ($in)");
        $pdo->exec("DELETE FROM ad_targets WHERE campaign_id IN ($in)");
        $pdo->exec("DELETE FROM ad_creatives WHERE campaign_id IN ($in)");
        $removed += (int) $pdo->exec("DELETE FROM ad_campaigns WHERE id IN ($in) AND advertiser_name = " . $pdo->quote($marker));
    }
    promo_cache_flush();
    promo_cache_gc();
    $left = (int) $pdo->query('SELECT COUNT(*) FROM ad_campaigns WHERE advertiser_name = ' . $pdo->quote($marker))->fetchColumn();
    printf("Прибирання: видалено %d тестових кампаній за id (з креативами, таргетами, географією), залишилось %d.\n", $removed, $left);
}
