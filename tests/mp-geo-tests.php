<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести етапу 6 Marketplace (географія, розширений пошук, підказки, налаштування) на ЛОКАЛЬНІЙ базі.
 *
 *   php tests/mp-geo-tests.php [http://ai-lab-hub.test]
 *
 * Створює власні тестові оголошення (заголовки «MPG-TEST …»), на час HTTP-перевірок вмикає локальний
 * site_settings.marketplace_public = 1 і наприкінці (finally) повертає попереднє значення, видаляє ЛИШЕ свої
 * записи за id (оголошення, тексти, місця, налаштування тестового користувача, рядок IP-ліміту тестової IP).
 * Потрібні міграції 2026-11-03 (№ 15–17) і дані geo-data-NN.sql. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
$_SESSION = [];
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-search.php';
require_once __DIR__ . '/../app/mp-geo-form.php';
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

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

if (!mpg_ready($pdo)) {
    fwrite(STDERR, "Міграції етапу 6 не застосовано\n");
    exit(1);
}

const CANBERRA = 2172517;
const GORDON = 8348660;      // передмістя Канберри
const LVIV = 702550;
const TEST_USER = 999999001; // неіснуючий user_id — mp_user_prefs без FK; рядок видаляється наприкінці
const TEST_IP = '203.0.113.77';

$created = [];
$prevSwitch = $pdo->query("SELECT setting_value FROM site_settings WHERE setting_key = 'marketplace_public'")->fetchColumn();

/** Тестове оголошення користувача (блок «Інше», post_form=ad; опубліковане) + текст мовою $lang + географія через mpg_save_listing_geo(). */
$mk = static function (string $title, string $lang, array $geo, ?string $price = null, string $cur = 'USD', int $seller = 1) use ($pdo, &$created): int {
    $pdo->prepare(
        "INSERT INTO mp_listings (section, post_form, seller_id, status, pricing_model, price_type, price_amount, currency, delivery_type, source_lang,
                                  is_remote, published_at, expires_at, created_at, updated_at)
         VALUES ('other', 'ad', :s, 'published', 'free', :pt, :pa, :cur, 'contact', :lang, 1, NOW(), NOW() + INTERVAL 30 DAY, NOW(), NOW())"
    )->execute([':s' => $seller, ':pt' => $price !== null ? 'fixed' : 'none', ':pa' => $price, ':cur' => $price !== null ? $cur : null, ':lang' => $lang]);
    $id = (int) $pdo->lastInsertId();
    $created[] = $id;
    $pdo->prepare('INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, is_auto) VALUES (:id, :l, :t, :s, 0)')
        ->execute([':id' => $id, ':l' => $lang, ':t' => $title, ':s' => 'Test listing for stage 6']);
    $errors = [];
    $g = mpg_validate($pdo, $geo + mpg_form_defaults(), $errors);
    if ($errors !== []) {
        throw new RuntimeException("validate $title: " . implode(',', $errors));
    }
    mpg_save_listing_geo($pdo, $id, $g);
    mpg_save_price_usd($pdo, $id, $price, $price !== null ? $cur : null);

    return $id;
};

/** id знайдених оголошень (лише тестові) для фільтрів GET. */
$find = static function (array $get, string $lang = 'uk', array $prefs = ['saved' => false], ?array $visitor = null) use ($pdo, &$created): array {
    $f = mpb_search_filters($pdo, $get, $lang, $prefs + ['units' => 'km'], $visitor);
    $f['q'] = 'MPG-TEST';
    $ids = [];
    $order = [];
    for ($p = 1; $p <= 20; $p++) {
        $r = mpb_search($pdo, $lang, $f, $p);
        foreach ($r['rows'] as $row) {
            if (in_array((int) $row['id'], $created, true)) {
                $ids[] = (int) $row['id'];
            }
        }
        if ($p >= $r['pages']) {
            break;
        }
    }

    return $ids;
};

// --- HTTP-помічники (curl, власний cookie jar) ---
$jar = tempnam(sys_get_temp_dir(), 'mpg');
$http = static function (string $path, array $post = null, bool $follow = true) use ($base, $jar): array {
    $ch = curl_init($base . '/' . ltrim($path, '/'));
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_HEADER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar,
        CURLOPT_FOLLOWLOCATION => $follow, CURLOPT_TIMEOUT => 30, CURLOPT_USERAGENT => 'Mozilla/5.0 mpg-test']);
    if ($post !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
    }
    $raw = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $hs = (int) curl_getinfo($ch, CURLINFO_HEADER_SIZE);
    curl_close($ch);

    return ['code' => $code, 'head' => substr($raw, 0, $hs), 'body' => substr($raw, $hs)];
};

try {
    $pdo->exec("INSERT INTO site_settings (setting_key, setting_value) VALUES ('marketplace_public', '1')
                ON DUPLICATE KEY UPDATE setting_value = '1'");

    echo "1. Тестові оголошення\n";
    $A = $mk('MPG-TEST Canberra AI tutoring', 'en', ['work_format' => 'offline', 'place_id' => CANBERRA, 'local_scope' => 'local', 'radius_km' => 0], '40', 'USD');
    $B = $mk('MPG-TEST Львів офлайн-курс', 'uk', ['work_format' => 'offline', 'place_id' => LVIV, 'local_scope' => 'local', 'radius_km' => 10], '1000', 'UAH');
    $C = $mk('MPG-TEST Online worldwide', 'en', ['work_format' => 'online', 'online_scope' => 'worldwide']);
    $D = $mk('MPG-TEST Online AU only', 'en', ['work_format' => 'online', 'online_scope' => 'country', 'countries' => ['AU']], '15', 'EUR');
    $E = $mk('MPG-TEST Online UA only', 'uk', ['work_format' => 'online', 'online_scope' => 'country', 'countries' => ['UA']]);
    $G = $mk('MPG-TEST Gordon hybrid', 'en', ['work_format' => 'hybrid', 'place_id' => GORDON, 'local_scope' => 'local', 'radius_km' => 0], null, 'USD', 50);
    $H = $mk('MPG-TEST Lviv whole country', 'uk', ['work_format' => 'offline', 'place_id' => LVIV, 'local_scope' => 'country']);
    $X = $mk('MPG-TEST Lviv + Canberra extra', 'uk', ['work_format' => 'offline', 'place_id' => LVIV, 'local_scope' => 'local',
        'extra' => [['place_id' => CANBERRA, 'radius_km' => 0]]]);
    ok(count($created) === 8, 'створено 8 тестових оголошень: ' . implode(',', $created));
    $row = $pdo->query("SELECT work_format, service_scope, country_code, lat, lon, is_remote, city, price_usd FROM mp_listings WHERE id = $A")->fetch(PDO::FETCH_ASSOC);
    ok($row['country_code'] === 'AU' && abs((float) $row['lat'] + 35.28346) < 0.0001 && (int) $row['is_remote'] === 0 && $row['city'] === 'Canberra',
        'A: координати й країна скопійовані з місця, is_remote=0, city=Canberra');
    ok($row['price_usd'] === '40.00', 'A: price_usd = 40.00 (USD як є)');
    $usdB = $pdo->query("SELECT price_usd FROM mp_listings WHERE id = $B")->fetchColumn();
    $rateUah = mpg_usd_rate($pdo, 'UAH');
    ok($rateUah === null ? $usdB === null : abs((float) $usdB - 1000 / (float) $rateUah) < 0.01, "B: price_usd з UAH за курсом НБУ ($usdB при курсі " . ($rateUah ?? 'null') . ')');
    $usdD = $pdo->query("SELECT price_usd FROM mp_listings WHERE id = $D")->fetchColumn();
    ok($usdD === null || (float) $usdD > 15, "D: price_usd з EUR (крос-курс) = " . var_export($usdD, true));
    $nullPrice = mpg_price_usd($pdo, '100', 'GBP');
    ok($nullPrice === null, 'невідома валюта (GBP) → price_usd NULL');

    // Перевірка форми: офлайн без міста — помилка; онлайн «вибрані країни» без країн — помилка.
    $e1 = [];
    mpg_validate($pdo, ['work_format' => 'offline', 'place_id' => 0] + mpg_form_defaults(), $e1);
    ok($e1 === ['mpg_err_city'], 'офлайн без міста → mpg_err_city');
    $e2 = [];
    mpg_validate($pdo, ['work_format' => 'hybrid', 'place_id' => 690791] + mpg_form_defaults(), $e2);
    ok($e2 === ['mpg_err_city'], 'змішано з країною замість міста → mpg_err_city');
    $e3 = [];
    mpg_validate($pdo, ['work_format' => 'online', 'online_scope' => 'country', 'countries' => ['ZZ']] + mpg_form_defaults(), $e3);
    ok($e3 === ['mpg_err_countries'], 'онлайн «вибрані країни» з неіснуючою країною → mpg_err_countries');
    $e4 = [];
    $g4 = mpg_validate($pdo, ['work_format' => 'offline', 'place_id' => LVIV, 'extra' => array_fill(0, 7, ['place_id' => CANBERRA, 'radius_km' => 0])] + mpg_form_defaults(), $e4);
    ok(count($g4['places']) === 1, 'дублікати додаткових місць відкидаються');

    echo "2. Пошук за країною й місцем\n";
    $au = $find(['country' => 'AU']);
    sort($au);
    $expAu = [$A, $C, $D, $G, $X];
    sort($expAu);
    ok($au === $expAu, 'country=AU → A, C (онлайн світ), D (онлайн AU), G, X (додаткове місце Canberra); без B, E, H — ' . implode(',', $au));
    $cb = $find(['place' => (string) CANBERRA, 'radius' => '25']);
    ok(in_array($A, $cb, true) && in_array($G, $cb, true) && in_array($X, $cb, true), 'place=Canberra r=25 → A, G (≈20 км), X');
    ok(!in_array($B, $cb, true) && !in_array($H, $cb, true), 'офлайн у Львові (B, H «вся країна UA») не показується для Canberra');
    ok(in_array($C, $cb, true) && in_array($D, $cb, true) && !in_array($E, $cb, true), 'онлайн: світ (C) і AU (D) — так, лише UA (E) — ні');
    $cbOff = $find(['place' => (string) CANBERRA, 'radius' => '25', 'format' => 'offline']);
    ok(!in_array($C, $cbOff, true) && !in_array($D, $cbOff, true) && in_array($A, $cbOff, true) && !in_array($G, $cbOff, true),
        'format=offline → онлайн і змішані приховані, A лишається');
    $ua = $find(['country' => 'UA']);
    ok(in_array($B, $ua, true) && in_array($H, $ua, true) && in_array($E, $ua, true) && !in_array($D, $ua, true) && !in_array($A, $ua, true),
        'country=UA → B, H, E; без D (лише AU) і A');
    $lviv = $find(['place' => (string) LVIV, 'radius' => '5']);
    ok(in_array($B, $lviv, true) && in_array($H, $lviv, true) && in_array($X, $lviv, true) && !in_array($A, $lviv, true), 'place=Lviv r=5 → B, H, X; без A');

    echo "3. Радіус на межі (відстань ≤ радіус пошуку + радіус оголошення)\n";
    $cbP = mpg_place($pdo, CANBERRA);
    $gP = mpg_place($pdo, GORDON);
    $sqlD = (float) $pdo->query('SELECT ' . mpg_haversine_sql('lat', 'lon', $cbP['lat'], $cbP['lon']) . ' FROM geo_places WHERE id = ' . GORDON)->fetchColumn();
    $phpD = mpg_distance_km($cbP['lat'], $cbP['lon'], $gP['lat'], $gP['lon']);
    ok(abs($sqlD - $phpD) < 0.001, sprintf('відстань Canberra–Gordon: SQL %.3f км = PHP %.3f км', $sqlD, $phpD));
    $r10 = $find(['place' => (string) CANBERRA, 'radius' => '10']);
    ok(!in_array($G, $r10, true), sprintf('r=10 < %.1f км → G немає', $sqlD));
    // Радіус обслуговування G: найменше ціле, за якого 10 + r ≥ d → є; на 1 менше → немає.
    $need = (int) ceil($sqlD - 10);
    $pdo->exec("UPDATE mp_listings SET service_radius_km = " . ($need - 1) . " WHERE id = $G");
    ok(!in_array($G, $find(['place' => (string) CANBERRA, 'radius' => '10']), true), "G з радіусом " . ($need - 1) . " км: 10 + " . ($need - 1) . " < d → немає");
    $pdo->exec("UPDATE mp_listings SET service_radius_km = $need WHERE id = $G");
    ok(in_array($G, $find(['place' => (string) CANBERRA, 'radius' => '10']), true), "G з радіусом $need км: 10 + $need ≥ d → є");
    $pdo->exec("UPDATE mp_listings SET service_radius_km = NULL WHERE id = $G");

    echo "4. Сортування за відстанню\n";
    $fs = mpb_search_filters($pdo, ['place' => (string) CANBERRA, 'radius' => '25', 'sort' => 'distance'], 'en', ['saved' => false, 'units' => 'km']);
    $fs['q'] = 'MPG-TEST';
    $rows = mpb_search($pdo, 'en', $fs, 1)['rows'];
    $ord = array_values(array_filter(array_map(static fn($r) => (int) $r['id'], $rows), static fn($i) => in_array($i, $created, true)));
    $posA = array_search($A, $ord, true);
    $posG = array_search($G, $ord, true);
    $posC = array_search($C, $ord, true);
    ok($posA !== false && $posG !== false && $posC !== false && $posA < $posG && $posG < $posC, 'distance: A (0 км), X, потім G (≈20 км), онлайн у кінці — ' . implode(',', $ord));
    $dists = array_map(static fn($r) => (float) $r['distance_km'], $rows);
    $sorted = $dists;
    sort($sorted);
    ok($dists === $sorted, 'distance_km неспадає');
    $fn = mpb_search_filters($pdo, ['sort' => 'distance'], 'uk', ['saved' => false]);
    ok($fn['sort'] === 'new', 'sort=distance без місця → new');

    echo "5. Ціна в USD і інші фільтри\n";
    $p = $find(['country' => 'AU', 'price_min' => '30', 'price_max' => '50']);
    ok($p === [$A], 'price 30–50 USD у AU → лише A (40 USD); без ціни/без курсу — не в діапазоні');
    ok(count($find(['country' => 'AU'])) === 5, 'без фільтра ціни оголошення без price_usd показуються');
    ok($find(['country' => 'AU', 'verified' => '1']) !== [] && !in_array($G, $find(['country' => 'AU', 'verified' => '1']), true), 'verified=1 → без G (продавець не перевірений)');
    $en = $find(['country' => 'AU', 'listing_lang' => 'en']);
    ok(!in_array($X, $en, true) && in_array($A, $en, true), 'listing_lang=en → X (текст uk) прихований, A є');
    ok($find(['country' => 'AU', 'with_photos' => '1']) === [], 'with_photos=1 → тестових без фото немає');

    echo "6. Некоректні значення й SQL-ін'єкції ігноруються\n";
    $bad = mpb_search_filters($pdo, [
        'country' => "AU' OR 1=1 --", 'place' => '1 OR 1=1', 'radius' => '1e9', 'format' => "online'; DROP TABLE x;--",
        'sort' => 'id;DELETE', 'price_min' => '-5', 'price_max' => '1e3', 'listing_lang' => "en' --", 'section' => 'x', 'cat' => "1'",
        'page' => '-3', 'with_photos' => 'yes', 'q' => ['arr'], 'evil' => '1',
    ], 'uk', ['saved' => false]);
    ok($bad['country'] === '' && $bad['place_id'] === 0 && $bad['radius'] === MPG_DEFAULT_RADIUS && $bad['format'] === 'any' && $bad['sort'] === 'new'
        && $bad['price_min'] === null && $bad['price_max'] === null && $bad['listing_lang'] === '' && $bad['section'] === '' && $bad['cat'] === 0
        && $bad['page'] === 1 && $bad['with_photos'] === false && $bad['q'] === '', 'усі некоректні значення → значення за замовчуванням');
    ok(!isset($bad['evil']) && !isset($bad['url']['evil']), 'невідомі параметри не потрапляють у фільтри й посилання');
    ok(mpb_search_filters($pdo, ['place' => '99999999'], 'uk', ['saved' => false])['place_id'] === 0, 'неіснуючий place → без місця');
    ok(mpb_search_filters($pdo, ['place' => '690791'], 'uk', ['saved' => false])['country'] === 'UA', 'place = країна → country');
    $legacy = mpb_search_filters($pdo, ['city' => 'Lviv', 'remote' => '1', 'sort' => 'cheap', 'min' => '5'], 'uk', ['saved' => false]);
    ok($legacy['place_id'] === LVIV && $legacy['format'] === 'online' && $legacy['sort'] === 'price_asc' && $legacy['price_min'] === 5.0, 'старі city/remote/sort/min → place/format/sort/price_min');

    echo "7. Автопідказка\n";
    $s1 = mpg_suggest($pdo, 'Львів', 'uk', ['city']);
    $s2 = mpg_suggest($pdo, 'Lviv', 'uk', ['city']);
    ok(($s1[0]['id'] ?? 0) === LVIV && ($s2[0]['id'] ?? 0) === LVIV, '«Львів» і «Lviv» → те саме місце ' . LVIV);
    ok(($s2[0]['name'] ?? '') === 'Львів' && (mpg_suggest($pdo, 'Львів', 'en', ['city'])[0]['name'] ?? '') === 'Lviv', 'назва мовою інтерфейсу: uk «Львів», en «Lviv»');
    ok(count(mpg_suggest($pdo, 'Sa', 'en')) === MPG_SUGGEST_LIMIT, 'короткий префікс → рівно ' . MPG_SUGGEST_LIMIT . ' результатів');
    ok(mpg_suggest($pdo, 'L', 'en') === [] && mpg_suggest($pdo, "%' OR 1=1 --", 'en') === [] && mpg_suggest($pdo, '%%', 'en') === [], '1 символ, ін\'єкція й «%%» → порожньо');
    ok((mpg_suggest($pdo, 'Канберр', 'uk')[0]['id'] ?? 0) === CANBERRA, '«Канберр» → Canberra');
    $nearest = mpg_nearest_city($pdo, -35.29, 149.13);
    ok(in_array($nearest, [CANBERRA, 8347865, 8347868, 2172618], true), "найближче місто до (-35.29, 149.13): $nearest");
    // IP-ліміт підказок (mp_rate_limits) — тестова IP, ліміт 3
    $_SERVER['REMOTE_ADDR'] = TEST_IP;
    $hits = [mpb_ip_hit($pdo, 'geo', 3), mpb_ip_hit($pdo, 'geo', 3), mpb_ip_hit($pdo, 'geo', 3), mpb_ip_hit($pdo, 'geo', 3)];
    ok($hits === [true, true, true, false], 'IP-ліміт: 4-й запит понад ліміт 3 відхилено');

    echo "8. Налаштування: залогінений (mp_user_prefs)\n";
    mpg_prefs_save($pdo, TEST_USER, ['place_id' => CANBERRA, 'radius_km' => 50, 'units' => 'mi', 'listing_langs' => ['en', 'xx'], 'show_online' => false]);
    $pr = mpg_prefs($pdo, TEST_USER);
    ok($pr['place_id'] === CANBERRA && $pr['country_code'] === 'AU' && $pr['radius_km'] === 50 && $pr['units'] === 'mi' && $pr['listing_langs'] === ['en'] && $pr['show_online'] === false,
        'збережено: Canberra, AU, 50, mi, [en], без онлайн');
    // З 2026-11-19: збережене місце саме НЕ фільтрує; лише «Поблизу мене» (nearby=1) з місцем відвідувача (app/geo.php).
    $vis = geo_visitor($pdo, TEST_USER, true);
    $fp = mpb_search_filters($pdo, [], 'uk', $pr, $vis);
    ok(!$fp['from_prefs'] && $fp['place_id'] === 0 && $fp['country'] === '', 'без параметрів місця — фільтра за місцем немає, хоча місце збережено');
    ok($vis['source'] === 'profile' && $vis['place_id'] === CANBERRA, 'місце відвідувача з профілю (mp_user_prefs): Canberra');
    $fp = mpb_search_filters($pdo, ['nearby' => '1'], 'uk', $pr, $vis);
    ok($fp['nearby'] && $fp['place_id'] === CANBERRA && abs($fp['geo']['radius_km'] - 50 * MPG_KM_PER_MI) < 0.001, '«Поблизу мене»: місто з профілю, радіус 50 миль = 80.47 км');
    $withPrefs = $find(['nearby' => '1'], 'uk', $pr, $vis);
    ok(in_array($A, $withPrefs, true) && in_array($C, $withPrefs, true) && !in_array($X, $withPrefs, true), '«Поблизу мене» показує й онлайн; listing_langs=en → без X');
    ok(mpb_search_filters($pdo, ['country' => ''], 'uk', $pr)['from_prefs'] === false, '?country= (явне «будь-де») переважає збережене');

    echo "9. HTTP: сторінка пошуку UA/EN, ін'єкції, підказки, cookie гостя\n";
    $http('index.php?lang=uk');
    $r = $http('marketplace.php?country=AU&place=' . CANBERRA . '&q=MPG-TEST');
    // В інтерфейсі UA англійський заголовок автоперекладається (mp_auto_translate) — перевіряємо за посиланням на id.
    ok($r['code'] === 200 && str_contains($r['body'], 'marketplace-offer.php?id=' . $A . '"') && !str_contains($r['body'], 'marketplace-offer.php?id=' . $B . '"')
        && str_contains($r['body'], '<html lang="uk"'), 'UA: Canberra-оголошення (текст англійською) знайдено, львівського немає');
    ok(str_contains($r['body'], 'Geo data:') && str_contains($r['body'], 'GeoNames') && str_contains($r['body'], 'CC BY 4.0'), 'рядок «Geo data: GeoNames (CC BY 4.0)» є');
    ok(str_contains($r['body'], 'Канберра'), 'UA: назва місця «Канберра»');
    $http('index.php?lang=en');
    $r = $http('marketplace.php?country=AU&place=' . CANBERRA . '&q=MPG-TEST');
    ok($r['code'] === 200 && str_contains($r['body'], 'marketplace-offer.php?id=' . $A . '"') && str_contains($r['body'], 'MPG-TEST Canberra AI tutoring')
        && str_contains($r['body'], 'Canberra, Australian Capital Territory, Australia') && !str_contains($r['body'], 'marketplace-offer.php?id=' . $B . '"'), 'EN: те саме оголошення, місце англійською');
    $r = $http('marketplace.php?' . http_build_query(['country' => "AU' OR '1'='1", 'place' => '1 UNION SELECT 1', 'radius' => '<script>', 'sort' => "1;DROP TABLE mp_listings", 'format' => '"><svg onload=alert(1)>', 'price_min' => "0' OR 1=1"]));
    ok($r['code'] === 200 && !preg_match('/SQLSTATE|Fatal error|Warning:|<svg onload/i', $r['body']), 'ін\'єкції в GET: 200, без помилок SQL і без відображення шкідливого HTML');
    ok((int) $pdo->query("SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings'")->fetchColumn() === 1, 'таблиця mp_listings на місці');
    $r = $http('mp-geo-suggest.php?q=' . rawurlencode('Львів') . '&lang=uk', null, false);
    $j1 = json_decode($r['body'], true);
    $r2 = $http('mp-geo-suggest.php?q=Lviv&lang=en', null, false);
    $j2 = json_decode($r2['body'], true);
    ok($r['code'] === 200 && ($j1['items'][0]['id'] ?? 0) === LVIV && ($j2['items'][0]['id'] ?? 0) === LVIV && ($j2['items'][0]['name'] ?? '') === 'Lviv', 'HTTP-підказка: Львів (uk) і Lviv (en) — один id, без редіректу мови');
    $r3 = $http('mp-geo-suggest.php?q=Sa&lang=en', null, false);
    ok(count(json_decode($r3['body'], true)['items'] ?? []) <= 10, 'HTTP-підказка: не більше 10');
    // Мова сесії не змінилася через ?lang= у підказці
    $r = $http('marketplace.php?country=AU&q=MPG-TEST');
    ok(str_contains($r['body'], '<html lang="en"'), 'параметр lang підказки не перемикає мову сесії');

    $r = $http('marketplace-offer.php?id=' . $X);
    ok($r['code'] === 200 && str_contains($r['body'], 'Where it is provided') && str_contains($r['body'], 'Lviv') && str_contains($r['body'], 'also: Canberra'),
        'сторінка оголошення (EN): «Where it is provided: In person · Lviv… · also: Canberra»');

    // Гість: cookie ставиться лише після явного вибору
    ok(!preg_match('/(mp|geo)_loc=/', $r['head']), 'гість: без вибору cookie geo_loc / mp_loc немає');
    preg_match('/name="csrf" value="([0-9a-f]+)"/', $http('mp-settings.php')['body'], $m);
    $csrf = $m[1] ?? '';
    $r = $http('mp-settings.php', ['csrf' => $csrf, 'action' => 'remember', 'place_id' => (string) CANBERRA, 'radius_km' => '25', 'back' => 'marketplace.php?q=MPG-TEST'], false);
    ok(in_array($r['code'], [302, 303], true) && preg_match('/Set-Cookie: geo_loc=' . CANBERRA . ';[^\r\n]*HttpOnly/i', $r['head']) === 1
        && preg_match('/Set-Cookie: geo_loc=[^\r\n]*Max-Age=(\d+)/i', $r['head'], $mx) === 1 && abs((int) $mx[1] - 180 * 86400) < 120,
        'гість: «Запам\'ятати» → cookie geo_loc=' . CANBERRA . ', HttpOnly, 180 днів');
    ok(preg_match('/Location: marketplace\.php\?q=MPG-TEST/', $r['head']) === 1, 'повернення на сторінку пошуку');
    $r = $http('mp-settings.php', ['csrf' => $csrf, 'action' => 'remember', 'place_id' => (string) CANBERRA, 'back' => 'https://evil.example/'], false);
    ok(preg_match('#Location: marketplace\.php\r?\n#', $r['head']) === 1, 'чужа адреса повернення → marketplace.php');
    $r = $http('marketplace.php?q=MPG-TEST');
    ok(str_contains($r['body'], 'marketplace-offer.php?id=' . $A . '"') && str_contains($r['body'], 'marketplace-offer.php?id=' . $H . '"'),
        'гість: без параметрів — фільтра за місцем немає (і Canberra, і Львів)');
    $r = $http('marketplace.php?nearby=1&q=MPG-TEST');
    ok(str_contains($r['body'], 'Near: Canberra') && str_contains($r['body'], 'marketplace-offer.php?id=' . $A . '"') && !str_contains($r['body'], 'marketplace-offer.php?id=' . $H . '"'),
        'гість: «Near me» — збережене місце Canberra застосовано');
    $r = $http('mp-settings.php', ['csrf' => 'bad', 'action' => 'forget'], false);
    ok($r['code'] === 403, 'POST без правильного CSRF → 403');
    $r = $http('mp-settings.php', ['csrf' => $csrf, 'action' => 'forget'], false);
    ok(preg_match('/Set-Cookie: geo_loc=(deleted|);/i', $r['head']) === 1, 'гість: «Забути місце» видаляє cookie geo_loc');

    echo "10. Форма оголошення: блок «Де надається» і збереження через mpb_save_listing()\n";
    $html = mpg_form_html($pdo, mpg_form_defaults(), 'uk');
    ok(str_contains($html, 'name="work_format" value="online"') && str_contains($html, 'name="place_id"') && str_contains($html, 'name="countries[]"')
        && str_contains($html, 'name="extra_place[4]"') && !str_contains($html, 'name="extra_place[5]"') && str_contains($html, 'data-geo-show="offline hybrid" hidden'),
        'блок: формат, місто з підказки, країни, до 5 додаткових місць; офлайн-секція схована для «Онлайн»');
    $post = ['work_format' => 'hybrid', 'place_id' => (string) LVIV, 'local_scope' => 'local', 'service_radius' => '25',
        'extra_place' => ['0' => (string) CANBERRA, '1' => '690791', '2' => 'abc'], 'extra_radius' => ['0' => '10', '1' => '0', '2' => '5']];
    $errs = [];
    $geo = mpg_validate($pdo, mpg_form_from_post($post), $errs);
    ok($errs === [] && $geo['service_scope'] === 'local' && $geo['radius_km'] === 25 && count($geo['places']) === 2 && $geo['places'][1]['radius_km'] === null,
        'POST: змішано, Львів +25, додатково Canberra +10 і країна UA (без радіуса); «abc» відкинуто');
    $sid = $pdo->query("SELECT id FROM mp_sellers WHERE user_id = 3")->fetchColumn();
    $saved = mpb_save_listing($pdo, ['title' => 'MPG-TEST form save', 'short_desc' => 'x', 'full_desc' => '', 'categories' => [],
        'price_type' => 'fixed', 'price_amount' => '25.50', 'currency' => 'USD', 'is_remote' => true, 'city' => null,
        'contact' => ['name' => 'T', 'phone' => '', 'telegram' => '', 'email' => 'mpg-test@example.test'],
        'geo' => $geo + ['price_usd' => mpg_price_usd($pdo, '25.50', 'USD')]], null, 3, (int) $sid, 'uk', [], [], []);
    $created[] = $saved;
    $row = $pdo->query("SELECT work_format, service_scope, primary_place_id, country_code, service_radius_km, is_remote, price_usd FROM mp_listings WHERE id = $saved")->fetch(PDO::FETCH_ASSOC);
    $np = (int) $pdo->query("SELECT COUNT(*) FROM mp_listing_places WHERE listing_id = $saved")->fetchColumn();
    ok($row['work_format'] === 'hybrid' && (int) $row['primary_place_id'] === LVIV && $row['country_code'] === 'UA' && (int) $row['service_radius_km'] === 25
        && (int) $row['is_remote'] === 1 && $row['price_usd'] === '25.50' && $np === 2, "збережено (id $saved): hybrid, Львів, UA, 25 км, is_remote=1, 25.50 USD, 2 додаткові місця");
    $back = mpg_form_from_listing($pdo, $pdo->query("SELECT * FROM mp_listings WHERE id = $saved")->fetch(PDO::FETCH_ASSOC));
    ok($back['work_format'] === 'hybrid' && $back['place_id'] === LVIV && $back['radius_km'] === 25 && count($back['extra']) === 2, 'редагування: блок відновлюється з оголошення');
    $txt = mpg_coverage_text($pdo, ['id' => $saved] + $row, 'uk');
    ok(str_contains($txt, 'Змішано') && str_contains($txt, 'Львів') && str_contains($txt, '+25') && str_contains($txt, 'Канберра'), "сторінка оголошення: «{$txt}»");
} finally {
    echo "Прибирання\n";
    if ($created !== []) {
        $in = implode(',', array_map('intval', $created));
        $n1 = $pdo->exec("DELETE FROM mp_listing_places WHERE listing_id IN ($in)");
        $n2 = $pdo->exec("DELETE FROM mp_listing_translations WHERE listing_id IN ($in)");
        $pdo->exec("DELETE FROM mp_moderation_log WHERE listing_id IN ($in)");   // запис «created» від mpb_save_listing()
        $n3 = $pdo->exec("DELETE FROM mp_listings WHERE id IN ($in)");
        echo "  оголошень: $n3, текстів: $n2, місць: $n1 (id $in)\n";
    }
    $pdo->exec('DELETE FROM mp_user_prefs WHERE user_id = ' . TEST_USER);
    $pdo->prepare("DELETE FROM mp_rate_limits WHERE key_hash = :k AND action = 'geo'")->execute([':k' => mpb_ip_key(TEST_IP)]);
    if ($prevSwitch === false) {
        $pdo->exec("DELETE FROM site_settings WHERE setting_key = 'marketplace_public'");
    } else {
        $pdo->prepare("UPDATE site_settings SET setting_value = :v WHERE setting_key = 'marketplace_public'")->execute([':v' => $prevSwitch]);
    }
    echo '  marketplace_public повернуто: ' . var_export($prevSwitch, true) . "\n";
    @unlink($jar);
}
echo "\nРазом: $T, помилок: $F\n";
exit($F === 0 ? 0 : 1);
