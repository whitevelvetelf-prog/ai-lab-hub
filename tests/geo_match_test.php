<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести геолокації (2026-11-19) на ЛОКАЛЬНІЙ базі:
 *   1. ad_geo_match / ad_geo_check — таблиця випадків (немає цілей; include країна збіг/незбіг; include місто в радіусі
 *      й поза ним; exclude; кілька рядків; відома лише країна при цілі-місті в soft і strict; місце невідоме в soft і
 *      strict; країна відвідувача інша);
 *   2. відбір реклами promo_candidates + adgeo_filter_rows на тестових кампаніях — і при мові uk, і при en;
 *   3. оголошення: англійське оголошення в Canberra (AU) знаходиться пошуком country=AU, place=Canberra при
 *      інтерфейсі UA й EN; «Поблизу мене» для відвідувача з Canberra: офлайн у Львові — ні, онлайн — так;
 *      без «Поблизу» фільтра за місцем немає;
 *   4. згода й IP: без згоди (або з вимкненим config) geo_detect_country() не викликається; вибір відвідувача
 *      сильніший за IP;
 *   5. HTTP (http://ai-lab-hub.test): cookie geo_loc ставиться лише після явної дії (POST geo-location.php),
 *      HttpOnly, SameSite=Lax, 180 днів; «Львів» і «Lviv» у geo-suggest.php — те саме місце.
 *
 *   php tests/geo_match_test.php [http://ai-lab-hub.test]
 *
 * Тестові записи (кампанії «GEOTEST …», оголошення «GEO-TEST …») видаляються наприкінці за id (finally).
 * Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
$_SESSION = [];
require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-search.php';
require_once __DIR__ . '/../app/promo.php';
require_once __DIR__ . '/../app/ad-geo.php';
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);

$T = 0;
$F = 0;
function ok(bool $cond, string $name): void
{
    global $T, $F;
    $T++;
    if (!$cond) {
        $F++;
    }
    echo ($cond ? '  OK   ' : '  FAIL ') . $name . "\n";
}

if (!mpg_ready($pdo) || !adgeo_ready($pdo)) {
    fwrite(STDERR, "Міграції геодовідника (№ 15–17) або географії реклами (№ 24) не застосовано\n");
    exit(1);
}

const CANBERRA = 2172517;
const GORDON = 8348660;      // передмістя Канберри
const SYDNEY = 2147714;
const LVIV = 702550;
const KYIV = 703448;

$P = [];
foreach ([CANBERRA, GORDON, SYDNEY, LVIV, KYIV] as $id) {
    $P[$id] = mpg_place($pdo, $id) ?? throw new RuntimeException("немає місця $id у geo_places");
}
/** Відвідувач у місті / лише країна / невідомо. */
$atCity = static fn(int $id): array => ['country_code' => $P[$id]['country_code'], 'place_id' => $id, 'lat' => $P[$id]['lat'], 'lon' => $P[$id]['lon'], 'source' => 'user', 'known' => true];
$atCountry = static fn(string $cc): array => ['country_code' => $cc, 'place_id' => null, 'lat' => null, 'lon' => null, 'source' => 'user', 'known' => true];
$unknown = geo_unknown();
/** Правило як з adgeo_rules(). */
$city = static fn(string $mode, int $id, int $r = ADGEO_DEFAULT_RADIUS): array => ['mode' => $mode, 'place_id' => $id, 'type' => 'city',
    'country_code' => $P[$id]['country_code'], 'lat' => $P[$id]['lat'], 'lon' => $P[$id]['lon'], 'radius_km' => $r];
$country = static fn(string $mode, string $cc): array => ['mode' => $mode, 'place_id' => (int) mpg_country_id($pdo, $cc), 'type' => 'country',
    'country_code' => $cc, 'lat' => null, 'lon' => null, 'radius_km' => ADGEO_DEFAULT_RADIUS];

$dGordon = mpg_distance_km($P[CANBERRA]['lat'], $P[CANBERRA]['lon'], $P[GORDON]['lat'], $P[GORDON]['lon']);
$dSydney = mpg_distance_km($P[CANBERRA]['lat'], $P[CANBERRA]['lon'], $P[SYDNEY]['lat'], $P[SYDNEY]['lon']);

echo "1. ad_geo_match — таблиця випадків (Canberra→Gordon " . round($dGordon, 1) . " км, Canberra→Sydney " . round($dSydney) . " км)\n";
// [назва, правила, відвідувач, режим, очікування, очікувана причина]
$cases = [
    ['немає цілей, місце відоме', [], $atCity(LVIV), 'soft', true, 'no_rules'],
    ['немає цілей, місце невідоме, strict', [], $unknown, 'strict', true, 'no_rules'],
    ['include країна AU — відвідувач у Canberra', [$country('include', 'AU')], $atCity(CANBERRA), 'soft', true, 'included_country'],
    ['include країна AU — відвідувач у Львові', [$country('include', 'AU')], $atCity(LVIV), 'soft', false, 'outside'],
    ['include країна AU — відома лише країна UA', [$country('include', 'AU')], $atCountry('UA'), 'strict', false, 'other_country'],
    ['include місто Canberra +25 — відвідувач у Gordon (у радіусі)', [$city('include', CANBERRA)], $atCity(GORDON), 'strict', true, 'included_city'],
    ['include місто Canberra +25 — відвідувач у Sydney (поза радіусом)', [$city('include', CANBERRA)], $atCity(SYDNEY), 'soft', false, 'outside'],
    ['include місто Canberra +5 — Gordon поза малим радіусом', [$city('include', CANBERRA, 5)], $atCity(GORDON), 'soft', $dGordon <= 5, $dGordon <= 5 ? 'included_city' : 'outside'],
    ['exclude країна UA — відвідувач у Львові', [$country('exclude', 'UA')], $atCity(LVIV), 'soft', false, 'excluded_country'],
    ['exclude країна UA — відвідувач у Canberra', [$country('exclude', 'UA')], $atCity(CANBERRA), 'strict', true, 'not_excluded'],
    ['exclude місто Львів — відвідувач у Львові', [$city('exclude', LVIV)], $atCity(LVIV), 'soft', false, 'excluded_city'],
    ['exclude місто Львів — відвідувач у Києві', [$city('exclude', LVIV)], $atCity(KYIV), 'soft', true, 'not_excluded'],
    ['exclude місто Львів — відома лише країна UA (визначити не можна)', [$city('exclude', LVIV)], $atCountry('UA'), 'strict', true, 'not_excluded'],
    ['кілька рядків: include AU + Львів, exclude Sydney +50 — Canberra', [$country('include', 'AU'), $city('include', LVIV), $city('exclude', SYDNEY, 50)], $atCity(CANBERRA), 'soft', true, 'included_country'],
    ['кілька рядків — Sydney (виключено)', [$country('include', 'AU'), $city('include', LVIV), $city('exclude', SYDNEY, 50)], $atCity(SYDNEY), 'soft', false, 'excluded_city'],
    ['кілька рядків — Львів (місто з include)', [$country('include', 'AU'), $city('include', LVIV), $city('exclude', SYDNEY, 50)], $atCity(LVIV), 'strict', true, 'included_city'],
    ['кілька рядків — Київ (жодного збігу)', [$country('include', 'AU'), $city('include', LVIV), $city('exclude', SYDNEY, 50)], $atCity(KYIV), 'soft', false, 'outside'],
    ['відома лише країна AU, ціль місто Canberra — soft показує', [$city('include', CANBERRA)], $atCountry('AU'), 'soft', true, 'country_only_soft'],
    ['відома лише країна AU, ціль місто Canberra — strict ні', [$city('include', CANBERRA)], $atCountry('AU'), 'strict', false, 'country_only_strict'],
    ['місце невідоме, є include — soft показує', [$country('include', 'AU')], $unknown, 'soft', true, 'unknown_soft'],
    ['місце невідоме, є include — strict ні', [$country('include', 'AU')], $unknown, 'strict', false, 'unknown_strict'],
    ['місце невідоме, лише exclude — strict показує', [$country('exclude', 'UA')], $unknown, 'strict', true, 'unknown_exclude_only'],
    ['країна відвідувача інша (лише країна UA, ціль Canberra) — soft ні', [$city('include', CANBERRA)], $atCountry('UA'), 'soft', false, 'other_country'],
    ['відоме місто й країна різні від цілей (Львів vs Canberra) — soft ні', [$city('include', CANBERRA)], $atCity(LVIV), 'soft', false, 'outside'],
    ['відоме місто й країна різні від цілей — strict ні', [$city('include', CANBERRA)], $atCity(LVIV), 'strict', false, 'outside'],
];
foreach ($cases as [$name, $rules, $visitor, $mode, $want, $reason]) {
    [$got, $why] = ad_geo_check($rules, $visitor, $mode);
    ok($got === $want && $why === $reason && ad_geo_match($rules, $visitor, $mode) === $want, "$name [$mode] → " . ($got ? 'показ' : 'ні') . " ($why)");
}

$created = ['camp' => [], 'listing' => []];
$prevSwitch = $pdo->query("SELECT setting_value FROM site_settings WHERE setting_key = 'marketplace_public'")->fetchColumn();

try {
    // ------------------------------------------------------------------------------------------------
    echo "2. Відбір реклами: SQL за країною + радіус у PHP (мова uk і en)\n";
    $today = promo_today();
    $mkCamp = static function (string $name, array $inc, array $exc, ?string $mode) use ($pdo, $today, &$created): int {
        $pdo->prepare("INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, contact_email, objective, start_date, status, currency, advertiser_category)
                       VALUES ('internal', 'video', NULL, :n, 'GEOTEST', 'geo@example.test', 'awareness', :d, 'active', :c, 'ai_tools')")
            ->execute([':n' => $name, ':d' => $today, ':c' => PROMO_CURRENCY]);
        $id = (int) $pdo->lastInsertId();
        $created['camp'][] = $id;
        $pdo->prepare("INSERT INTO ad_creatives (campaign_id, title, description, cta_key, destination_url, video_type, youtube_id, status, creative_type, weight)
                       VALUES (:c, :t, 'geo test', 'learn_more', 'https://example.com/', 'youtube', 'dQw4w9WgXcQ', 'approved', 'video', 1)")
            ->execute([':c' => $id, ':t' => $name]);
        $pdo->prepare("INSERT INTO ad_targets (campaign_id, placement) VALUES (:c, 'popup')")->execute([':c' => $id]);
        if ($inc !== [] || $exc !== [] || $mode !== null) {
            adgeo_save($pdo, $id, $inc, $exc, $mode ?? adgeo_default_mode());
        }

        return $id;
    };
    $K0 = $mkCamp('GEOTEST без географії', [], [], null);
    $K1 = $mkCamp('GEOTEST AU', [['place_id' => (int) mpg_country_id($pdo, 'AU'), 'radius_km' => null]], [], 'soft');
    $K2 = $mkCamp('GEOTEST Canberra strict', [['place_id' => CANBERRA, 'radius_km' => null]], [], 'strict');
    $K3 = $mkCamp('GEOTEST крім UA', [], [['place_id' => (int) mpg_country_id($pdo, 'UA'), 'radius_km' => null]], 'soft');
    $K4 = $mkCamp('GEOTEST Canberra soft', [['place_id' => CANBERRA, 'radius_km' => 10]], [], 'soft');
    $mine = [$K0, $K1, $K2, $K3, $K4];
    $sel = static function (array $visitor, string $lang) use ($pdo, $mine): array {
        promo_cache_flush();
        $rows = promo_candidates($pdo, 'popup', [], [], $lang, 'desktop', [], !empty($visitor['known']) ? (string) $visitor['country_code'] : null);
        $rows = adgeo_filter_rows($pdo, $rows, $visitor);
        $ids = array_values(array_unique(array_intersect(array_map(static fn($r) => (int) $r['campaign_id'], $rows), $mine)));
        sort($ids);

        return $ids;
    };
    $rules = adgeo_rules($pdo, [$K2, $K4]);
    ok(($rules[$K2][0]['radius_km'] ?? 0) === 25 && ($rules[$K4][0]['radius_km'] ?? 0) === 10 && ($rules[$K2][0]['country_code'] ?? '') === 'AU',
        'adgeo_save: місто Canberra (AU), радіус NULL → 25 км, 10 км збережено');
    ok(adgeo_summary($pdo, $K4, 'en') === 'Canberra +10' . "\u{00A0}" . t('mpg_unit_km') . ', ' . t('adgeo_mode_short_soft'), 'підсумок для списку: ' . adgeo_summary($pdo, $K4, 'en'));
    $expect = [
        'Canberra (місто)' => [$atCity(CANBERRA), [$K0, $K1, $K2, $K3, $K4]],
        'Gordon (~20 км: у радіусі 25, поза 10)' => [$atCity(GORDON), $dGordon <= 10 ? [$K0, $K1, $K2, $K3, $K4] : [$K0, $K1, $K2, $K3]],
        'Sydney (поза радіусами)' => [$atCity(SYDNEY), [$K0, $K1, $K3]],
        'лише країна AU' => [$atCountry('AU'), [$K0, $K1, $K3, $K4]],
        'Львів (UA виключено)' => [$atCity(LVIV), [$K0]],
        'місце невідоме' => [$unknown, [$K0, $K1, $K3, $K4]],
    ];
    foreach ($expect as $label => [$v, $want]) {
        sort($want);
        $uk = $sel($v, 'uk');
        $en = $sel($v, 'en');
        ok($uk === $want && $en === $want, "$label → K[" . implode(',', array_map(static fn($i) => array_search($i, $mine, true), $uk)) . '] однаково для uk і en');
    }
    // Редагування не скидає статус і не змінює кампанію
    $before = $pdo->query("SELECT status, updated_at FROM ad_campaigns WHERE id = $K1")->fetch(PDO::FETCH_ASSOC);
    adgeo_save($pdo, $K1, [], [['place_id' => (int) mpg_country_id($pdo, 'UA'), 'radius_km' => null]], 'strict');
    $after = $pdo->query("SELECT status, updated_at FROM ad_campaigns WHERE id = $K1")->fetch(PDO::FETCH_ASSOC);
    ok($before === $after, 'збереження географії не змінює ad_campaigns (статус ' . $after['status'] . ')');
    $act = (int) $pdo->query("SELECT COUNT(*) FROM ad_campaign_geo WHERE campaign_id = $K1 AND is_active = 1")->fetchColumn();
    $all = (int) $pdo->query("SELECT COUNT(*) FROM ad_campaign_geo WHERE campaign_id = $K1")->fetchColumn();
    ok($act === 1 && $all === 2, "попереднє правило вимкнено (is_active=0), без DELETE: активних $act з $all");
    // SQL-план: EXISTS по індексу ad_campaign_geo
    [$sql, $params] = promo_candidates_sql($pdo, 'popup', [], [], 'uk', 'desktop', [], false, $today, true, 'AU');
    $ex = $pdo->prepare('EXPLAIN ' . $sql);
    $ex->execute($params);
    $keys = [];
    foreach ($ex->fetchAll(PDO::FETCH_ASSOC) as $r) {
        if ($r['table'] === 'g' || $r['table'] === 'g0') {
            $keys[] = (string) $r['key'];
        }
    }
    ok($keys !== [] && !in_array('', $keys, true), 'EXPLAIN: підзапити ad_campaign_geo за індексом (' . implode(', ', array_unique($keys)) . ')');

    // ------------------------------------------------------------------------------------------------
    echo "3. Оголошення за місцем (спільний шар mpg_where для всіх джерел mp_listings)\n";
    $pdo->exec("INSERT INTO site_settings (setting_key, setting_value) VALUES ('marketplace_public', '1') ON DUPLICATE KEY UPDATE setting_value = '1'");
    $mk = static function (string $title, string $lang, array $geo) use ($pdo, &$created): int {
        $pdo->prepare("INSERT INTO mp_listings (section, post_form, seller_id, status, pricing_model, price_type, delivery_type, source_lang,
                                  is_remote, published_at, expires_at, created_at, updated_at)
                       VALUES ('other', 'ad', 1, 'published', 'free', 'none', 'contact', :lang, 1, NOW(), NOW() + INTERVAL 30 DAY, NOW(), NOW())")
            ->execute([':lang' => $lang]);
        $id = (int) $pdo->lastInsertId();
        $created['listing'][] = $id;
        $pdo->prepare('INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, is_auto) VALUES (:id, :l, :t, :s, 0)')
            ->execute([':id' => $id, ':l' => $lang, ':t' => $title, ':s' => 'Geo test listing']);
        $errors = [];
        $g = mpg_validate($pdo, $geo + mpg_form_defaults(), $errors);
        if ($errors !== []) {
            throw new RuntimeException("validate $title: " . implode(',', $errors));
        }
        mpg_save_listing_geo($pdo, $id, $g);

        return $id;
    };
    $LA = $mk('GEO-TEST Canberra English workshop', 'en', ['work_format' => 'offline', 'place_id' => CANBERRA, 'local_scope' => 'local', 'radius_km' => 0]);
    $LB = $mk('GEO-TEST Львів офлайн', 'uk', ['work_format' => 'offline', 'place_id' => LVIV, 'local_scope' => 'local', 'radius_km' => 10]);
    $LC = $mk('GEO-TEST Online worldwide', 'en', ['work_format' => 'online', 'online_scope' => 'worldwide']);
    echo "  (створено оголошення $LA, $LB, $LC)\n";
    $find = static function (array $get, string $lang, ?array $visitor = null) use ($pdo, &$created): array {
        $_SESSION['lang'] = $lang;
        $f = mpb_search_filters($pdo, $get, $lang, ['saved' => false, 'units' => 'km'], $visitor);
        $f['q'] = 'GEO-TEST';
        $ids = [];
        for ($p = 1; $p <= 20; $p++) {
            $r = mpb_search($pdo, $lang, $f, $p);
            foreach ($r['rows'] as $row) {
                if (in_array((int) $row['id'], $created['listing'], true)) {
                    $ids[] = (int) $row['id'];
                }
            }
            if ($p >= $r['pages']) {
                break;
            }
        }
        sort($ids);

        return $ids;
    };
    foreach (['uk', 'en'] as $ui) {
        $ids = $find(['country' => 'AU', 'place' => (string) CANBERRA], $ui);
        ok(in_array($LA, $ids, true) && !in_array($LB, $ids, true) && in_array($LC, $ids, true),
            "інтерфейс $ui: country=AU&place=Canberra знаходить англійське оголошення в Canberra (і онлайн), без Львова");
        $ids = $find(['city' => 'Canberra'], $ui);
        ok(in_array($LA, $ids, true), "інтерфейс $ui: city=Canberra (текст) → те саме місце");
        $ids = $find(['nearby' => '1'], $ui, $atCity(CANBERRA));
        ok(in_array($LA, $ids, true) && !in_array($LB, $ids, true) && in_array($LC, $ids, true),
            "інтерфейс $ui: «Поблизу мене» з Canberra — офлайн у Львові не показано, онлайн показано");
        $all = $find(['q' => 'GEO-TEST'], $ui, $atCity(CANBERRA));
        ok($all === [$LA, $LB, $LC], "інтерфейс $ui: без «Поблизу» фільтра за місцем немає (усі 3), хоча місце відоме");
    }
    $_SESSION['lang'] = 'uk';
    $fAsk = mpb_search_filters($pdo, ['nearby' => '1'], 'uk', ['saved' => false, 'units' => 'km'], $unknown);
    ok($fAsk['nearby'] === false && $fAsk['nearby_ask'] === true && $fAsk['country'] === '', '«Поблизу мене» без відомого місця — не фільтрує, просить вибрати місце');
    $fR = mpb_search_filters($pdo, ['nearby' => '1', 'radius' => '200'], 'uk', ['saved' => false, 'units' => 'km'], $atCity(CANBERRA));
    ok($fR['radius'] === 200 && ($fR['url']['nearby'] ?? 0) === 1 && !isset($fR['url']['place']), 'радіус 200 приймається; у посиланнях nearby=1 без place');

    // ------------------------------------------------------------------------------------------------
    echo "4. Згода й країна за IP\n";
    $_SERVER['HTTP_X_GEO_TEST'] = 'DE';
    $_COOKIE = [];
    $GLOBALS['GEO_CONFIG_OVERRIDE'] = ['geo_ip_enabled' => true, 'geo_ip_header' => 'HTTP_X_GEO_TEST'];
    geo_config(true);
    $GLOBALS['GEO_DETECT_CALLS'] = 0;
    $v = geo_visitor($pdo, null, true);
    ok(!$v['known'] && $GLOBALS['GEO_DETECT_CALLS'] === 0, 'увімкнено в config, але без згоди: місце невідоме, geo_detect_country() не викликалась');
    $_COOKIE['alh_geo'] = '0';
    $v = geo_visitor($pdo, null, true);
    ok(!$v['known'] && $GLOBALS['GEO_DETECT_CALLS'] === 0, 'згоду відхилено (alh_geo=0): не викликалась');
    $_COOKIE['alh_geo'] = '1';
    $v = geo_visitor($pdo, null, true);
    ok($v['known'] && $v['country_code'] === 'DE' && $v['source'] === 'ip' && $GLOBALS['GEO_DETECT_CALLS'] === 1, 'зі згодою: країна DE з заголовка, source=ip');
    ok(($_SESSION['geo_ip_cc'] ?? null) === 'DE' && !isset($_SESSION['geo_ip']), 'у сесії лише код країни, IP не збережено');
    $_COOKIE[GEO_COOKIE] = (string) CANBERRA;
    $GLOBALS['GEO_DETECT_CALLS'] = 0;
    $v = geo_visitor($pdo, null, true);
    ok($v['country_code'] === 'AU' && $v['source'] === 'user' && $GLOBALS['GEO_DETECT_CALLS'] === 0, 'явний вибір (cookie geo_loc) сильніший за IP; IP навіть не аналізується');
    unset($_COOKIE[GEO_COOKIE]);
    $GLOBALS['GEO_CONFIG_OVERRIDE'] = ['geo_ip_enabled' => false, 'geo_ip_header' => 'HTTP_X_GEO_TEST'];
    geo_config(true);
    $GLOBALS['GEO_DETECT_CALLS'] = 0;
    $v = geo_visitor($pdo, null, true);
    ok(!$v['known'] && $GLOBALS['GEO_DETECT_CALLS'] === 0, 'config geo_ip_enabled=false (типово): навіть зі згодою не викликалась');
    unset($GLOBALS['GEO_CONFIG_OVERRIDE'], $_SERVER['HTTP_X_GEO_TEST']);
    $_COOKIE = [];
    $_SESSION = [];
    geo_config(true);
    geo_visitor($pdo, null, true);
    ok(geo_config()['geo_ip_enabled'] === false && geo_config()['ad_geo_default_mode'] === 'soft', 'config/geo.php: geo_ip_enabled=false, ad_geo_default_mode=soft');
    $_COOKIE['geo_loc'] = 'AU';
    $v = geo_visitor($pdo, null, true);
    ok($v['known'] && $v['country_code'] === 'AU' && $v['place_id'] === null && $v['lat'] === null, 'cookie geo_loc з кодом країни → відома лише країна');
    $_COOKIE = ['mp_loc' => (string) LVIV];
    $v = geo_visitor($pdo, null, true);
    ok($v['place_id'] === LVIV && $v['source'] === 'user', 'стара cookie mp_loc читається як запасна');
    $_COOKIE = [];
    geo_visitor($pdo, null, true);

    // ------------------------------------------------------------------------------------------------
    echo "5. HTTP: cookie geo_loc лише після явної дії; автопідказка\n";
    $jarCookies = [];   // cookie сесії — у пам'яті цього процесу (без файлів)
    $http = static function (string $path, ?array $post = null) use ($base, &$jarCookies): array {
        $ch = curl_init($base . '/' . ltrim($path, '/'));
        $cookie = implode('; ', array_map(static fn($k, $v) => $k . '=' . $v, array_keys($jarCookies), $jarCookies));
        curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_HEADER => true, CURLOPT_FOLLOWLOCATION => false,
            CURLOPT_TIMEOUT => 30, CURLOPT_USERAGENT => 'geo-test', CURLOPT_COOKIE => $cookie]);
        if ($post !== null) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
        }
        $raw = (string) curl_exec($ch);
        $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $hs = (int) curl_getinfo($ch, CURLINFO_HEADER_SIZE);
        curl_close($ch);
        $head = substr($raw, 0, $hs);
        if (preg_match_all('/^Set-Cookie: ([A-Za-z0-9_]+)=([^;\r\n]*)([^\r\n]*)/mi', $head, $mm, PREG_SET_ORDER)) {
            foreach ($mm as $c) {
                if ($c[2] === '' || $c[2] === 'deleted' || stripos($c[3], 'Max-Age=0') !== false) {
                    unset($jarCookies[$c[1]]);
                } else {
                    $jarCookies[$c[1]] = $c[2];
                }
            }
        }

        return ['code' => $code, 'head' => $head, 'body' => substr($raw, $hs)];
    };
    $r1 = $http('marketplace.php?q=GEO-TEST');
    $r2 = $http('geo-location.php?back=marketplace.php');
    ok($r1['code'] === 200 && $r2['code'] === 200 && !preg_match('/Set-Cookie: geo_loc=/i', $r1['head'] . $r2['head']), 'перегляд пошуку й форми місця — cookie geo_loc не ставиться');
    ok(str_contains($r1['body'], t('geo_nearby_chip')) && str_contains($r1['body'], 'mp-tab--place'), 'на сторінці пошуку є «Поблизу мене» і значок місця в навігації');
    preg_match('/name="csrf" value="([a-f0-9]+)"/', $r2['body'], $m);
    $csrf = $m[1] ?? '';
    $bad = $http('geo-location.php', ['action' => 'save', 'place' => (string) CANBERRA, 'csrf' => 'x', 'back' => 'marketplace.php']);
    ok(!preg_match('/Set-Cookie: geo_loc=/i', $bad['head']), 'POST без правильного CSRF — cookie немає');
    $r3 = $http('geo-location.php', ['action' => 'save', 'place' => (string) CANBERRA, 'csrf' => $csrf, 'back' => 'marketplace.php?nearby=1']);
    $setCookie = preg_match('/Set-Cookie: geo_loc=' . CANBERRA . ';([^\r\n]*)/i', $r3['head'], $cm) === 1 ? $cm[1] : '';
    $maxAge = preg_match('/Max-Age=(\d+)/i', $setCookie, $ma) === 1 ? (int) $ma[1] : 0;
    ok(in_array($r3['code'], [302, 303], true) && $setCookie !== '' && stripos($setCookie, 'HttpOnly') !== false && stripos($setCookie, 'SameSite=Lax') !== false
        && abs($maxAge - 180 * 86400) < 120, 'явне «Зберегти» → geo_loc=' . CANBERRA . ', HttpOnly, SameSite=Lax, Max-Age≈180 днів');
    ok(preg_match('#Location: [^\r\n]*marketplace\.php\?nearby=1#i', $r3['head']) === 1, 'повернення на відносну адресу (back)');
    $ext = $http('geo-location.php', ['action' => 'none', 'csrf' => $csrf, 'back' => 'https://other-site.example/']);
    ok(in_array($ext['code'], [302, 303], true) && !str_contains($ext['head'], 'other-site.example'), 'адреса повернення на інший сайт відкидається');
    // Картки за id (заголовок англійського оголошення в UA-інтерфейсі може бути автоперекладено).
    $r4 = $http('marketplace.php?nearby=1&q=GEO-TEST');
    preg_match_all('/marketplace-offer\.php\?id=(\d+)/', $r4['body'], $cards);
    $shown = array_values(array_unique(array_map('intval', $cards[1])));
    ok(in_array($LA, $shown, true) && !in_array($LB, $shown, true) && in_array($LC, $shown, true),
        'HTTP «Поблизу мене» з cookie Canberra: Canberra й онлайн є, Львова немає (картки: ' . implode(',', array_intersect($shown, $created['listing'])) . ')');
    ok(str_contains($r4['body'], 'noindex'), 'сторінка з фільтрами — noindex');
    $s1 = json_decode($http('geo-suggest.php?q=' . rawurlencode('Львів') . '&lang=uk&type=city')['body'], true);
    $s2 = json_decode($http('geo-suggest.php?q=Lviv&lang=en&type=city')['body'], true);
    ok(($s1['items'][0]['id'] ?? 0) === LVIV && ($s2['items'][0]['id'] ?? 0) === LVIV && ($s1['items'][0]['name'] ?? '') === 'Львів' && ($s2['items'][0]['name'] ?? '') === 'Lviv'
        && ($s2['items'][0]['country'] ?? '') === 'Ukraine', '«Львів» і «Lviv» → те саме місце; назва мовою інтерфейсу; є регіон і країна');
    $s3 = json_decode($http('geo-suggest.php?q=Austral&lang=uk&type=country')['body'], true);
    ok(($s3['items'][0]['country_code'] ?? '') === 'AU' && ($s3['items'][0]['type'] ?? '') === 'country', 'type=country: «Austral» → Австралія');
    $r5 = $http('geo-location.php', ['action' => 'clear', 'csrf' => $csrf, 'back' => 'marketplace.php']);
    ok(preg_match('/Set-Cookie: geo_loc=(deleted|);/i', $r5['head']) === 1, '«Очистити» видаляє cookie geo_loc');
} catch (Throwable $e) {
    ok(false, 'виняток: ' . $e->getMessage() . ' @' . basename($e->getFile()) . ':' . $e->getLine());
} finally {
    // Прибирання ЛИШЕ своїх записів за id
    if ($created['camp'] !== []) {
        $in = implode(',', array_map('intval', $created['camp']));
        $pdo->exec("DELETE FROM ad_campaign_geo WHERE campaign_id IN ($in)");
        $pdo->exec("DELETE FROM ad_campaign_geo_settings WHERE campaign_id IN ($in)");
        $pdo->exec("DELETE FROM ad_targets WHERE campaign_id IN ($in)");
        $pdo->exec("DELETE FROM ad_creatives WHERE campaign_id IN ($in)");
        $pdo->exec("DELETE FROM ad_campaigns WHERE id IN ($in)");
    }
    if ($created['listing'] !== []) {
        $in = implode(',', array_map('intval', $created['listing']));
        $pdo->exec("DELETE FROM mp_listing_places WHERE listing_id IN ($in)");
        $pdo->exec("DELETE FROM mp_listing_translations WHERE listing_id IN ($in)");
        $pdo->exec("DELETE FROM mp_listings WHERE id IN ($in)");
    }
    if ($prevSwitch === false) {
        $pdo->exec("DELETE FROM site_settings WHERE setting_key = 'marketplace_public'");
    } elseif ($prevSwitch !== '1') {
        $pdo->prepare("UPDATE site_settings SET setting_value = :v WHERE setting_key = 'marketplace_public'")->execute([':v' => $prevSwitch]);
    }
    promo_cache_flush();
    $left = (int) $pdo->query("SELECT (SELECT COUNT(*) FROM ad_campaigns WHERE advertiser_name = 'GEOTEST')
        + (SELECT COUNT(*) FROM mp_listing_translations WHERE title LIKE 'GEO-TEST %')")->fetchColumn();
    echo "Прибирання: кампаній " . count($created['camp']) . ', оголошень ' . count($created['listing']) . " видалено за id; залишилось тестових: $left\n";
}

echo "\nРазом: $T, провалено: $F\n";
exit($F > 0 ? 1 : 0);
