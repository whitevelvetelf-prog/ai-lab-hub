<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace, етап 6: географія оголошень, пошук за місцем, налаштування відвідувача.
 *
 *   * Довідник місць — geo_places / geo_place_names (GeoNames, CC BY 4.0; id місця = geonameid).
 *     Назви — мовою інтерфейсу, якщо є, інакше англійською (mpg_names()).
 *   * Оголошення: mp_listings.work_format (online|offline|hybrid), service_scope (local|country|worldwide),
 *     primary_place_id + копія country_code/lat/lon, service_radius_km, price_usd; додаткові місця —
 *     mp_listing_places (до MPG_MAX_EXTRA; міста з радіусом або країни). Географія НЕ залежить від мови
 *     інтерфейсу чи мови тексту оголошення.
 *   * Збіг за місцем (mpg_where()):
 *       online  — показується, якщо формат не «лише офлайн/змішано»; із охопленням «вибрані країни» —
 *                 лише для цих країн;
 *       offline / hybrid — відстань від основного чи будь-якого додаткового міста ≤ радіус пошуку + радіус
 *                 обслуговування оголошення; з охопленням «вся країна» — будь-яке місце тієї країни.
 *     Відстань: спершу прямокутник lat/lon (індекс), потім формула гаверсинуса в SQL.
 *   * Налаштування: залогінений — mp_user_prefs; гість — лише cookie mp_loc (place_id, httponly, 1 рік),
 *     яка ставиться тільки після явного вибору місця. Координати браузера («Поблизу») не зберігаються.
 *     Геолокація за IP не використовується.
 *
 * Підключати після app/marketplace.php (mp_config, mp_e) і app/translations.php.
 */

require_once __DIR__ . '/fx.php';

const MPG_FORMATS = ['online', 'offline', 'hybrid'];
const MPG_SCOPES = ['local', 'country', 'worldwide'];
const MPG_RADII = [5, 10, 25, 50, 100];
const MPG_DEFAULT_RADIUS = 25;
const MPG_MAX_EXTRA = 5;
const MPG_MAX_LISTING_RADIUS = 100;    // км; верхня межа радіуса обслуговування оголошення (для прямокутника пошуку)
const MPG_KM_PER_MI = 1.609344;
const MPG_EARTH_KM = 6371.0;
const MPG_COOKIE = 'mp_loc';
const MPG_LISTING_LANGS = ['uk', 'en'];
const MPG_SUGGEST_LIMIT = 10;
const MPG_FAR = 1000000000;            // «відстань» для онлайн-оголошень у сортуванні — у кінець

/** Чи застосовано міграції етапу 6 (таблиці довідника й нові колонки). Кеш на запит. */
function mpg_ready(PDO $pdo): bool
{
    static $ready = null;
    if ($ready === null) {
        try {
            $n = (int) $pdo->query(
                "SELECT (SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE()
                           AND TABLE_NAME IN ('geo_places', 'geo_place_names', 'mp_listing_places', 'mp_user_prefs'))
                      + (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE()
                           AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME IN ('work_format', 'price_usd'))"
            )->fetchColumn();
            $ready = $n === 6;
        } catch (Throwable $e) {
            $ready = false;
        }
    }

    return $ready;
}

/** Мова назв місць: мова інтерфейсу, якщо для неї є назви (uk/en), інакше en. */
function mpg_lang(string $lang): string
{
    return in_array($lang, ['uk', 'en'], true) ? $lang : 'en';
}

// --- Місця й назви ------------------------------------------------------------

/** @return array{id:int,type:string,country_code:string,parent_id:?int,lat:?float,lon:?float}|null */
function mpg_place(PDO $pdo, int $id): ?array
{
    if ($id <= 0) {
        return null;
    }
    $st = $pdo->prepare('SELECT id, type, country_code, parent_id, lat, lon FROM geo_places WHERE id = :id');
    $st->execute([':id' => $id]);
    $r = $st->fetch(PDO::FETCH_ASSOC);
    if ($r === false) {
        return null;
    }

    return [
        'id' => (int) $r['id'], 'type' => (string) $r['type'], 'country_code' => (string) $r['country_code'],
        'parent_id' => $r['parent_id'] !== null ? (int) $r['parent_id'] : null,
        'lat' => $r['lat'] !== null ? (float) $r['lat'] : null, 'lon' => $r['lon'] !== null ? (float) $r['lon'] : null,
    ];
}

/** id країни за кодом ISO (або null). */
function mpg_country_id(PDO $pdo, string $cc): ?int
{
    if (preg_match('/^[A-Z]{2}$/', $cc) !== 1) {
        return null;
    }
    $st = $pdo->prepare("SELECT id FROM geo_places WHERE country_code = :cc AND type = 'country' LIMIT 1");
    $st->execute([':cc' => $cc]);
    $id = $st->fetchColumn();

    return $id !== false ? (int) $id : null;
}

/**
 * Основні назви місць мовою $lang (запасна — en, потім будь-яка).
 *
 * @param list<int> $ids
 * @return array<int,string>
 */
function mpg_names(PDO $pdo, array $ids, string $lang): array
{
    $ids = array_values(array_unique(array_filter(array_map('intval', $ids), static fn(int $i): bool => $i > 0)));
    if ($ids === []) {
        return [];
    }
    $lang = mpg_lang($lang);
    $in = implode(',', $ids);   // лише цілі числа
    $rows = $pdo->query("SELECT place_id, lang, name, is_primary FROM geo_place_names WHERE place_id IN ($in)")->fetchAll(PDO::FETCH_ASSOC);
    $best = [];
    foreach ($rows as $r) {
        $rank = ($r['lang'] === $lang ? 0 : ($r['lang'] === 'en' ? 2 : 4)) + ((int) $r['is_primary'] === 1 ? 0 : 1);
        $pid = (int) $r['place_id'];
        if (!isset($best[$pid]) || $rank < $best[$pid][0]) {
            $best[$pid] = [$rank, (string) $r['name']];
        }
    }

    return array_map(static fn(array $b): string => $b[1], $best);
}

/** Країни для списку вибору, назви мовою інтерфейсу, за алфавітом. @return array<string,string> cc => назва */
function mpg_countries(PDO $pdo, string $lang): array
{
    static $cache = [];
    $lang = mpg_lang($lang);
    if (isset($cache[$lang])) {
        return $cache[$lang];
    }
    $rows = $pdo->query("SELECT id, country_code FROM geo_places WHERE type = 'country'")->fetchAll(PDO::FETCH_ASSOC);
    $names = mpg_names($pdo, array_map(static fn($r) => (int) $r['id'], $rows), $lang);
    $out = [];
    foreach ($rows as $r) {
        $out[(string) $r['country_code']] = $names[(int) $r['id']] ?? (string) $r['country_code'];
    }
    if (class_exists('Collator')) {
        $coll = new Collator($lang === 'uk' ? 'uk_UA' : 'en_US');
        uasort($out, static fn(string $a, string $b): int => (int) $coll->compare($a, $b));
    } else {
        asort($out, SORT_NATURAL | SORT_FLAG_CASE);
    }

    return $cache[$lang] = $out;
}

/**
 * Підписи місць: «Львів, Львівська область, Україна» (місто), «Україна» (країна).
 *
 * @param list<int> $ids
 * @return array<int,array{id:int,type:string,country_code:string,name:string,label:string,lat:?float,lon:?float}>
 */
function mpg_labels(PDO $pdo, array $ids, string $lang): array
{
    $ids = array_values(array_unique(array_filter(array_map('intval', $ids), static fn(int $i): bool => $i > 0)));
    if ($ids === []) {
        return [];
    }
    $in = implode(',', $ids);
    $rows = $pdo->query("SELECT p.id, p.type, p.country_code, p.parent_id, p.lat, p.lon, c.id AS country_id
                         FROM geo_places p
                         LEFT JOIN geo_places c ON c.country_code = p.country_code AND c.type = 'country'
                         WHERE p.id IN ($in)")->fetchAll(PDO::FETCH_ASSOC);
    $need = [];
    foreach ($rows as $r) {
        $need[] = (int) $r['id'];
        if ($r['parent_id'] !== null) {
            $need[] = (int) $r['parent_id'];
        }
        if ($r['country_id'] !== null) {
            $need[] = (int) $r['country_id'];
        }
    }
    $names = mpg_names($pdo, $need, $lang);
    $out = [];
    foreach ($rows as $r) {
        $id = (int) $r['id'];
        $name = $names[$id] ?? (string) $r['country_code'];
        $parts = [$name];
        if ($r['type'] === 'city') {
            $parent = $r['parent_id'] !== null ? (int) $r['parent_id'] : 0;
            if ($parent > 0 && $parent !== (int) $r['country_id'] && isset($names[$parent]) && $names[$parent] !== $name) {
                $parts[] = $names[$parent];
            }
            if ($r['country_id'] !== null && isset($names[(int) $r['country_id']])) {
                $parts[] = $names[(int) $r['country_id']];
            }
        }
        $out[$id] = [
            'id' => $id, 'type' => (string) $r['type'], 'country_code' => (string) $r['country_code'], 'name' => $name,
            'label' => implode(', ', $parts),
            'lat' => $r['lat'] !== null ? (float) $r['lat'] : null, 'lon' => $r['lon'] !== null ? (float) $r['lon'] : null,
        ];
    }

    return $out;
}

/**
 * Автопідказка: місця, у яких БУДЬ-ЯКА назва (uk чи en) починається з $q. Одне місце — один рядок,
 * тож «Львів» і «Lviv» дають той самий id. Більші за населенням — вище; країни — перед містами.
 *
 * @param list<string> $types 'city' | 'country'
 * @return list<array{id:int,type:string,country_code:string,name:string,label:string}>
 */
function mpg_suggest(PDO $pdo, string $q, string $lang, array $types = ['city', 'country'], int $limit = MPG_SUGGEST_LIMIT): array
{
    $q = trim(preg_replace('/\s+/u', ' ', $q) ?? '');
    if (mb_strlen($q) < 2) {
        return [];
    }
    $q = mb_substr($q, 0, 60);
    $types = array_values(array_intersect($types, ['city', 'country']));
    if ($types === []) {
        return [];
    }
    $limit = max(1, min(MPG_SUGGEST_LIMIT, $limit));
    $typeSql = "'" . implode("','", $types) . "'";   // лише значення з білого списку
    // Внутрішній LIMIT обмежує роботу для коротких префіксів («Sa…» — тисячі назв).
    $st = $pdo->prepare(
        "SELECT p.id, p.type, p.population
         FROM (SELECT DISTINCT n.place_id FROM geo_place_names n WHERE n.name LIKE :q ESCAPE '\\\\' LIMIT 3000) m
         JOIN geo_places p ON p.id = m.place_id
         WHERE p.type IN ($typeSql)
         ORDER BY (p.type = 'country') DESC, p.population DESC, p.id
         LIMIT $limit"
    );
    $st->execute([':q' => addcslashes($q, '%_\\') . '%']);
    $ids = array_map(static fn($r) => (int) $r['id'], $st->fetchAll(PDO::FETCH_ASSOC));
    $labels = mpg_labels($pdo, $ids, $lang);
    $out = [];
    foreach ($ids as $id) {
        if (isset($labels[$id])) {
            $l = $labels[$id];
            $out[] = ['id' => $id, 'type' => $l['type'], 'country_code' => $l['country_code'], 'name' => $l['name'], 'label' => $l['label']];
        }
    }

    return $out;
}

/** Найближче місто до координат (координати ніде не зберігаються). */
function mpg_nearest_city(PDO $pdo, float $lat, float $lon): ?int
{
    if ($lat < -90 || $lat > 90 || $lon < -180 || $lon > 180) {
        return null;
    }
    foreach ([25, 100, 400] as $km) {
        [$box, $dist] = [mpg_bbox_sql('lat', 'lon', $lat, $lon, $km), mpg_haversine_sql('lat', 'lon', $lat, $lon)];
        $id = $pdo->query("SELECT id FROM geo_places WHERE type = 'city' AND $box ORDER BY $dist LIMIT 1")->fetchColumn();
        if ($id !== false) {
            return (int) $id;
        }
    }

    return null;
}

// --- Відстань (SQL) -------------------------------------------------------------

/** Число для вставки в SQL (лише float, обчислений на сервері). */
function mpg_num(float $v): string
{
    return sprintf('%.6F', $v);
}

/** Відстань у км від точки ($lat, $lon) до колонок $latCol/$lonCol — формула гаверсинуса. */
function mpg_haversine_sql(string $latCol, string $lonCol, float $lat, float $lon): string
{
    $la = mpg_num($lat);
    $lo = mpg_num($lon);

    return '(' . mpg_num(2 * MPG_EARTH_KM) . " * ASIN(LEAST(1, SQRT(POWER(SIN(RADIANS($latCol - $la) / 2), 2)"
        . " + COS(RADIANS($la)) * COS(RADIANS($latCol)) * POWER(SIN(RADIANS($lonCol - $lo) / 2), 2)))))";
}

/** Прямокутник довкола точки радіусом $km (для індексу). Біля полюсів / через 180° — лише широта. */
function mpg_bbox_sql(string $latCol, string $lonCol, float $lat, float $lon, float $km): string
{
    $dLat = $km / 111.0;
    $sql = "$latCol BETWEEN " . mpg_num(max(-90, $lat - $dLat)) . ' AND ' . mpg_num(min(90, $lat + $dLat));
    $cos = cos(deg2rad($lat));
    if ($cos > 0.01) {
        $dLon = $km / (111.32 * $cos);
        if ($lon - $dLon >= -180 && $lon + $dLon <= 180) {
            $sql .= " AND $lonCol BETWEEN " . mpg_num($lon - $dLon) . ' AND ' . mpg_num($lon + $dLon);
        }
    }

    return $sql;
}

/** Відстань між двома точками, км (PHP — для тестів і підписів). */
function mpg_distance_km(float $lat1, float $lon1, float $lat2, float $lon2): float
{
    $a = sin(deg2rad($lat2 - $lat1) / 2) ** 2 + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * sin(deg2rad($lon2 - $lon1) / 2) ** 2;

    return 2 * MPG_EARTH_KM * asin(min(1, sqrt($a)));
}

// --- Пошук за місцем --------------------------------------------------------------

/**
 * Умови WHERE для географії (alias l). $g — нормалізовані фільтри:
 *   format any|online|offline|hybrid, show_online bool, country ''|CC, place ?array (mpg_place), radius_km float.
 * Числа (координати, радіуси) вставляються як літерали, обчислені на сервері; код країни — параметр.
 *
 * @param array<string,mixed> $params доповнюється
 * @return list<string>
 */
function mpg_where(array $g, array &$params): array
{
    $where = [];
    $format = (string) ($g['format'] ?? 'any');
    if (in_array($format, MPG_FORMATS, true)) {
        $where[] = 'l.work_format = :g_wf';
        $params[':g_wf'] = $format;
    } elseif (empty($g['show_online'])) {
        $where[] = "l.work_format <> 'online'";
    }

    $place = $g['place'] ?? null;
    $cc = (string) ($g['country'] ?? '');
    if ($place !== null && $place['type'] === 'city' && $place['lat'] !== null) {
        $cc = $place['country_code'];
    }
    if ($cc === '') {
        return $where;
    }
    $params[':g_cc1'] = $cc;
    $params[':g_cc2'] = $cc;
    $params[':g_cc3'] = $cc;

    $online = "(l.work_format = 'online' AND (l.service_scope <> 'country' OR EXISTS (
                  SELECT 1 FROM mp_listing_places lp JOIN geo_places gp ON gp.id = lp.place_id
                  WHERE lp.listing_id = l.id AND gp.type = 'country' AND gp.country_code = :g_cc1)))";

    if ($place !== null && $place['type'] === 'city' && $place['lat'] !== null) {
        $r = (float) $g['radius_km'];
        $box = $r + MPG_MAX_LISTING_RADIUS;
        $near = mpg_bbox_sql('l.lat', 'l.lon', $place['lat'], $place['lon'], $box) . ' AND '
            . mpg_haversine_sql('l.lat', 'l.lon', $place['lat'], $place['lon']) . ' <= ' . mpg_num($r) . ' + COALESCE(l.service_radius_km, 0)';
        $nearExtra = mpg_bbox_sql('gp.lat', 'gp.lon', $place['lat'], $place['lon'], $box) . ' AND '
            . mpg_haversine_sql('gp.lat', 'gp.lon', $place['lat'], $place['lon']) . ' <= ' . mpg_num($r) . ' + COALESCE(lp.radius_km, 0)';
        $offline = "(l.work_format IN ('offline', 'hybrid') AND (
                        (l.service_scope = 'country' AND l.country_code = :g_cc2)
                     OR ($near)
                     OR EXISTS (SELECT 1 FROM mp_listing_places lp JOIN geo_places gp ON gp.id = lp.place_id
                                WHERE lp.listing_id = l.id
                                  AND ((gp.type = 'country' AND gp.country_code = :g_cc3) OR (gp.type = 'city' AND $nearExtra)))))";
    } else {
        // Лише країна: офлайн/змішані, що працюють у цій країні (основне чи будь-яке додаткове місце).
        $offline = "(l.work_format IN ('offline', 'hybrid') AND (l.country_code = :g_cc2 OR EXISTS (
                        SELECT 1 FROM mp_listing_places lp JOIN geo_places gp ON gp.id = lp.place_id
                        WHERE lp.listing_id = l.id AND gp.country_code = :g_cc3)))";
    }
    $where[] = "($online OR $offline)";

    return $where;
}

/**
 * Джерело FROM з кандидатами для пошуку за місцем / країною: UNION індексованих гілок (формат+країна, прямокутник lat/lon,
 * додаткові місця), щоб MySQL не перебирав усі опубліковані оголошення через OR у mpg_where(). Точні умови
 * (гаверсинус, охоплення) лишаються в mpg_where(). Порожній рядок — місця не вибрано.
 *
 * @param array<string,mixed> $params доповнюється
 */
function mpg_candidates_join(array $g, array &$params): string
{
    $place = $g['place'] ?? null;
    $isPlace = $place !== null && $place['type'] === 'city' && $place['lat'] !== null;
    $cc = $isPlace ? $place['country_code'] : (string) ($g['country'] ?? '');
    if ($cc === '') {
        return '';
    }
    $params[':gc_cc1'] = $cc;
    $params[':gc_cc2'] = $cc;
    $format = (string) ($g['format'] ?? 'any');
    $wantOnline = in_array($format, ['any', 'online'], true) && ($format === 'online' || !empty($g['show_online']));
    $wantLocal = $format !== 'online';
    $parts = [];
    if ($wantOnline) {
        // онлайн (точну умову країн перевіряє mpg_where)
        $parts[] = "SELECT id FROM mp_listings WHERE work_format = 'online'";
    }
    if ($wantLocal) {
        // офлайн / змішані: основне місце в країні (і «вся країна», і місцеві — для варіанта «лише країна»)
        $parts[] = "SELECT id FROM mp_listings WHERE work_format IN ('offline', 'hybrid') AND country_code = :gc_cc1";
        if ($isPlace) {
            $box = (float) $g['radius_km'] + MPG_MAX_LISTING_RADIUS;
            // Місцеві з іншої країни біля кордону — за прямокутником координат.
            $parts[] = "SELECT id FROM mp_listings WHERE " . mpg_bbox_sql('lat', 'lon', $place['lat'], $place['lon'], $box);
            $parts[] = "SELECT lp.listing_id FROM geo_places gp JOIN mp_listing_places lp ON lp.place_id = gp.id
                        WHERE gp.type = 'city' AND " . mpg_bbox_sql('gp.lat', 'gp.lon', $place['lat'], $place['lon'], $box);
        }
        $parts[] = "SELECT lp.listing_id FROM geo_places gp JOIN mp_listing_places lp ON lp.place_id = gp.id WHERE gp.country_code = :gc_cc2";
    } else {
        unset($params[':gc_cc1'], $params[':gc_cc2']);
    }

    // Підставляється замість «FROM mp_listings l»: спершу кандидати (STRAIGHT_JOIN — саме в такому порядку).
    return 'FROM (' . implode(' UNION ', $parts) . ') gc STRAIGHT_JOIN mp_listings l ON l.id = gc.id';
}

/** SQL відстані до найближчого місця оголошення (км) або MPG_FAR — для сортування й підпису. */
function mpg_distance_sql(array $place): string
{
    $d1 = mpg_haversine_sql('l.lat', 'l.lon', $place['lat'], $place['lon']);
    $d2 = mpg_haversine_sql('gp.lat', 'gp.lon', $place['lat'], $place['lon']);

    return "(CASE WHEN l.work_format = 'online' THEN " . MPG_FAR . " ELSE LEAST(
                COALESCE($d1, " . MPG_FAR . "),
                COALESCE((SELECT MIN($d2) FROM mp_listing_places lp JOIN geo_places gp ON gp.id = lp.place_id
                          WHERE lp.listing_id = l.id AND gp.type = 'city'), " . MPG_FAR . ')) END)';
}

// --- Ціна в USD ----------------------------------------------------------------

/**
 * Курс: одиниць валюти за 1 USD (рядок DECIMAL) або null. USD → 1; UAH — fx_usd_rate() (НБУ, той самий кеш,
 * що в поповненнях реклами); EUR — крос-курс НБУ (UAH/USD ÷ UAH/EUR), кеш у fx_rates ('EUR', source 'NBU-cross').
 */
function mpg_usd_rate(PDO $pdo, string $currency): ?string
{
    if ($currency === 'USD') {
        return '1.000000';
    }
    if ($currency === 'UAH') {
        return fx_usd_rate($pdo, 'UAH')['rate'] ?? null;
    }
    if ($currency !== 'EUR') {
        return null;
    }
    try {
        $st = $pdo->prepare("SELECT rate, TIMESTAMPDIFF(SECOND, fetched_at, NOW()) AS age FROM fx_rates WHERE currency = 'EUR'");
        $st->execute();
        $cached = $st->fetch(PDO::FETCH_ASSOC) ?: null;
    } catch (Throwable $e) {
        return null;
    }
    if ($cached !== null && (int) $cached['age'] < FX_CACHE_SECONDS) {
        return (string) $cached['rate'];
    }
    $uah = fx_usd_rate($pdo, 'UAH');
    $fetch = $GLOBALS['mpg_fx_fetch_eur'] ?? 'mpg_fetch_nbu_eur';   // тести підміняють джерело
    $eur = $uah !== null ? $fetch() : null;   // гривень за 1 EUR
    if ($uah !== null && $eur !== null && fx_rate_micro($eur['rate']) > 0) {
        $micro = intdiv($uah['micro'] * 1000000, fx_rate_micro($eur['rate']));   // євро за 1 долар
        if ($micro > 0) {
            $rate = fx_rate_string($micro);
            $pdo->prepare(
                "INSERT INTO fx_rates (currency, rate, rate_date, source, fetched_at) VALUES ('EUR', :r, :d, 'NBU-cross', NOW())
                 ON DUPLICATE KEY UPDATE rate = VALUES(rate), rate_date = VALUES(rate_date), source = VALUES(source), fetched_at = VALUES(fetched_at)"
            )->execute([':r' => $rate, ':d' => $eur['date']]);

            return $rate;
        }
    }
    if ($cached !== null && (int) $cached['age'] < FX_MAX_AGE_SECONDS) {
        return (string) $cached['rate'];
    }

    return null;
}

/** Офіційний курс НБУ гривні до євро. @return array{rate:string,date:string}|null */
function mpg_fetch_nbu_eur(): ?array
{
    if (!function_exists('curl_init')) {
        return null;
    }
    $ch = curl_init('https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?valcode=EUR&json');
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_TIMEOUT => 6, CURLOPT_CONNECTTIMEOUT => 4,
        CURLOPT_USERAGENT => 'AI LAB HUB fx', CURLOPT_FOLLOWLOCATION => false]);
    $body = curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    if (!is_string($body) || $code !== 200 || !preg_match('/"cc"\s*:\s*"EUR"/', $body)
        || !preg_match('/"rate"\s*:\s*(\d{1,6}(?:\.\d{1,6})?)\b/', $body, $r)
        || !preg_match('/"exchangedate"\s*:\s*"(\d{2})\.(\d{2})\.(\d{4})"/', $body, $d)) {
        return null;
    }

    return ['rate' => $r[1], 'date' => $d[3] . '-' . $d[2] . '-' . $d[1]];
}

/** Ціна в USD (рядок з 2 знаками) або null, якщо ціни чи курсу немає. */
function mpg_price_usd(PDO $pdo, ?string $amount, ?string $currency): ?string
{
    if ($amount === null || $currency === null || !is_numeric($amount)) {
        return null;
    }
    $rate = mpg_usd_rate($pdo, $currency);
    $micro = $rate !== null ? fx_rate_micro($rate) : 0;
    if ($micro <= 0) {
        return null;
    }
    // Копійки × 10^6 / курс у мільйонних → центи, округлення до найближчого.
    $minor = (int) round((float) $amount * 100);
    $cents = intdiv($minor * 1000000 + intdiv($micro, 2), $micro);

    return intdiv($cents, 100) . '.' . sprintf('%02d', $cents % 100);
}

/** Перерахунок price_usd живих оголошень за поточним курсом (cron). Повертає кількість оновлених. */
function mpg_refresh_price_usd(PDO $pdo): int
{
    if (!mpg_ready($pdo)) {
        return 0;
    }
    $n = 0;
    foreach (['USD', 'UAH', 'EUR'] as $cur) {
        $rate = mpg_usd_rate($pdo, $cur);
        if ($rate === null) {
            continue;
        }
        $st = $pdo->prepare(
            "UPDATE mp_listings SET price_usd = ROUND(price_amount / :r, 2)
             WHERE currency = :c AND price_amount IS NOT NULL AND status IN ('published', 'pending')"
        );
        $st->execute([':r' => $rate, ':c' => $cur]);
        $n += $st->rowCount();
    }

    return $n;
}

// --- Форма «Де надається» -------------------------------------------------------------

/** Порожній стан блоку (нове оголошення). */
function mpg_form_defaults(): array
{
    return ['work_format' => 'online', 'online_scope' => 'worldwide', 'local_scope' => 'local', 'place_id' => 0,
        'radius_km' => MPG_DEFAULT_RADIUS, 'countries' => [], 'extra' => []];
}

/** Стан блоку з наявного оголошення. */
function mpg_form_from_listing(PDO $pdo, array $row): array
{
    $v = mpg_form_defaults();
    if (!mpg_ready($pdo) || !isset($row['work_format'])) {
        return $v;
    }
    $v['work_format'] = in_array($row['work_format'], MPG_FORMATS, true) ? (string) $row['work_format'] : 'online';
    $v['place_id'] = (int) ($row['primary_place_id'] ?? 0);
    $v['radius_km'] = $row['service_radius_km'] !== null ? (int) $row['service_radius_km'] : 0;
    $scope = (string) ($row['service_scope'] ?? 'local');
    $st = $pdo->prepare('SELECT lp.place_id, lp.radius_km, gp.type, gp.country_code FROM mp_listing_places lp
                         JOIN geo_places gp ON gp.id = lp.place_id WHERE lp.listing_id = :id ORDER BY lp.sort_order, lp.id');
    $st->execute([':id' => (int) $row['id']]);
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $p) {
        if ($v['work_format'] === 'online') {
            if ($p['type'] === 'country') {
                $v['countries'][] = (string) $p['country_code'];
            }
        } else {
            $v['extra'][] = ['place_id' => (int) $p['place_id'], 'radius_km' => $p['radius_km'] !== null ? (int) $p['radius_km'] : 0];
        }
    }
    if ($v['work_format'] === 'online') {
        $v['online_scope'] = $scope === 'country' && $v['countries'] !== [] ? 'country' : 'worldwide';
    } else {
        $v['local_scope'] = $scope === 'country' ? 'country' : 'local';
    }

    return $v;
}

/** Стан блоку з POST (сирий, без перевірки). */
function mpg_form_from_post(array $post): array
{
    $v = mpg_form_defaults();
    $str = static fn(string $k): string => is_string($post[$k] ?? null) ? trim((string) $post[$k]) : '';
    $v['work_format'] = in_array($str('work_format'), MPG_FORMATS, true) ? $str('work_format') : 'online';
    $v['online_scope'] = $str('online_scope') === 'country' ? 'country' : 'worldwide';
    $v['local_scope'] = $str('local_scope') === 'country' ? 'country' : 'local';
    $v['place_id'] = ctype_digit($str('place_id')) ? (int) $str('place_id') : 0;
    $rad = $str('service_radius');
    $v['radius_km'] = ctype_digit($rad) ? (int) $rad : 0;
    $cc = $post['countries'] ?? [];
    foreach (is_array($cc) ? $cc : [] as $c) {
        if (is_string($c) && preg_match('/^[A-Z]{2}$/', $c) === 1 && !in_array($c, $v['countries'], true)) {
            $v['countries'][] = $c;
        }
    }
    $ep = $post['extra_place'] ?? [];
    $er = $post['extra_radius'] ?? [];
    foreach (is_array($ep) ? $ep : [] as $i => $pid) {
        if (is_string($pid) && ctype_digit($pid) && (int) $pid > 0) {
            $r = is_array($er) && is_string($er[$i] ?? null) && ctype_digit($er[$i]) ? (int) $er[$i] : 0;
            $v['extra'][] = ['place_id' => (int) $pid, 'radius_km' => $r];
        }
    }

    return $v;
}

/**
 * Перевірка блоку. Повертає нормалізовані дані для mpg_save_listing_geo() і доповнює $errors ключами t().
 *
 * @return array{work_format:string,service_scope:string,place:?array,radius_km:?int,places:list<array{place_id:int,radius_km:?int}>}
 */
function mpg_validate(PDO $pdo, array $v, array &$errors): array
{
    $out = ['work_format' => $v['work_format'], 'service_scope' => 'worldwide', 'place' => null, 'radius_km' => null, 'places' => []];
    if (!mpg_ready($pdo)) {
        return $out;
    }
    $radius = static fn(int $r): ?int => $r > 0 ? min(MPG_MAX_LISTING_RADIUS, $r) : null;

    if ($v['work_format'] === 'online') {
        if ($v['online_scope'] === 'country') {
            $countries = array_slice($v['countries'], 0, MPG_MAX_EXTRA);
            foreach ($countries as $cc) {
                $cid = mpg_country_id($pdo, $cc);
                if ($cid !== null) {
                    $out['places'][] = ['place_id' => $cid, 'radius_km' => null];
                }
            }
            if ($out['places'] === []) {
                $errors[] = 'mpg_err_countries';
            }
            $out['service_scope'] = 'country';
        }
        // Онлайн: місто необов'язкове — якщо вибране, зберігаємо як основне (для підпису).
        $p = mpg_place($pdo, (int) $v['place_id']);
        if ($p !== null && $p['type'] === 'city') {
            $out['place'] = $p;
        }

        return $out;
    }

    $p = mpg_place($pdo, (int) $v['place_id']);
    if ($p === null || $p['type'] !== 'city') {
        $errors[] = 'mpg_err_city';
    } else {
        $out['place'] = $p;
    }
    $out['service_scope'] = $v['local_scope'] === 'country' ? 'country' : 'local';
    $out['radius_km'] = $out['service_scope'] === 'local' ? $radius((int) $v['radius_km']) : null;
    $seen = $p !== null ? [$p['id'] => true] : [];
    foreach ($v['extra'] as $e) {
        if (count($out['places']) >= MPG_MAX_EXTRA) {
            $errors[] = 'mpg_err_extra_max';
            break;
        }
        $ep = mpg_place($pdo, (int) $e['place_id']);
        if ($ep === null || !in_array($ep['type'], ['city', 'country'], true) || isset($seen[$ep['id']])) {
            continue;
        }
        $seen[$ep['id']] = true;
        $out['places'][] = ['place_id' => $ep['id'], 'radius_km' => $ep['type'] === 'city' ? $radius((int) $e['radius_km']) : null];
    }

    return $out;
}

/**
 * Зберігає географію оголошення: колонки mp_listings + набір mp_listing_places (замінюється повністю, як і
 * категорії). is_remote синхронізується для старого коду (онлайн/змішано → 1). Викликати в транзакції збереження.
 */
function mpg_save_listing_geo(PDO $pdo, int $listingId, array $g): void
{
    if (!mpg_ready($pdo)) {
        return;
    }
    $p = $g['place'];
    $cityName = null;
    if ($p !== null) {
        $cityName = mpg_names($pdo, [$p['id']], 'en')[$p['id']] ?? null;
    }
    $pdo->prepare(
        'UPDATE mp_listings SET work_format = :wf, service_scope = :sc, primary_place_id = :pp, country_code = :cc,
                lat = :lat, lon = :lon, service_radius_km = :rad, is_remote = :rem, city = :city WHERE id = :id'
    )->execute([
        ':wf' => $g['work_format'], ':sc' => $g['service_scope'], ':pp' => $p['id'] ?? null, ':cc' => $p['country_code'] ?? null,
        ':lat' => $p !== null ? mpg_num((float) $p['lat']) : null, ':lon' => $p !== null ? mpg_num((float) $p['lon']) : null,
        ':rad' => $g['radius_km'], ':rem' => $g['work_format'] === 'offline' ? 0 : 1,
        ':city' => $cityName !== null ? mb_substr($cityName, 0, 120) : null, ':id' => $listingId,
    ]);
    $pdo->prepare('DELETE FROM mp_listing_places WHERE listing_id = :id')->execute([':id' => $listingId]);
    $ins = $pdo->prepare('INSERT INTO mp_listing_places (listing_id, place_id, radius_km, sort_order) VALUES (:l, :p, :r, :s)');
    foreach (array_values($g['places']) as $i => $e) {
        $ins->execute([':l' => $listingId, ':p' => $e['place_id'], ':r' => $e['radius_km'], ':s' => $i]);
    }
}

/** Оновлює price_usd оголошення. */
function mpg_save_price_usd(PDO $pdo, int $listingId, ?string $amount, ?string $currency): void
{
    if (!mpg_ready($pdo)) {
        return;
    }
    $pdo->prepare('UPDATE mp_listings SET price_usd = :u WHERE id = :id')
        ->execute([':u' => mpg_price_usd($pdo, $amount, $currency), ':id' => $listingId]);
}

/** Підпис місця для картки / сторінки оголошення. */
function mpg_location_label(PDO $pdo, array $row, string $lang, ?float $distanceKm = null, string $units = 'km'): string
{
    $wf = (string) ($row['work_format'] ?? '');
    $parts = [];
    if (!empty($row['primary_place_id'])) {
        $l = mpg_labels($pdo, [(int) $row['primary_place_id']], $lang)[(int) $row['primary_place_id']] ?? null;
        if ($l !== null) {
            $parts[] = $l['name'];
        }
    } elseif (!empty($row['city'])) {
        $parts[] = (string) $row['city'];
    }
    if ($wf === 'online') {
        $parts[] = t('mpg_fmt_online');
    } elseif ($wf === 'hybrid') {
        $parts[] = t('mpg_fmt_hybrid');
    } elseif ($wf === '' && (int) ($row['is_remote'] ?? 0) === 1) {
        $parts[] = t('mpb_remote');
    }
    if ($distanceKm !== null && $distanceKm < MPG_FAR) {
        $parts[] = mpg_distance_text($distanceKm, $units);
    }

    return implode(' · ', $parts);
}

/** «Офлайн · Львів, Львівська область, Україна (+25 км) · також: Київ, Польща» — для сторінки оголошення. */
function mpg_coverage_text(PDO $pdo, array $row, string $lang): string
{
    $wf = in_array($row['work_format'] ?? '', MPG_FORMATS, true) ? (string) $row['work_format'] : 'online';
    $parts = [t('mpg_fmt_' . $wf)];
    $st = $pdo->prepare('SELECT place_id, radius_km FROM mp_listing_places WHERE listing_id = :id ORDER BY sort_order, id');
    $st->execute([':id' => (int) $row['id']]);
    $extra = $st->fetchAll(PDO::FETCH_ASSOC);
    $ids = array_map(static fn($e) => (int) $e['place_id'], $extra);
    $main = (int) ($row['primary_place_id'] ?? 0);
    $labels = mpg_labels($pdo, array_merge($ids, [$main]), $lang);
    if ($main > 0 && isset($labels[$main])) {
        $txt = $labels[$main]['label'];
        if ($wf !== 'online') {
            if (($row['service_scope'] ?? '') === 'country') {
                $txt .= ' (' . t('mpg_scope_country') . ')';
            } elseif (!empty($row['service_radius_km'])) {
                $txt .= ' (+' . (int) $row['service_radius_km'] . "\u{00A0}" . t('mpg_unit_km') . ')';
            }
        }
        $parts[] = $txt;
    }
    if ($wf === 'online') {
        $parts[] = ($row['service_scope'] ?? '') === 'country' && $ids !== []
            ? implode(', ', array_map(static fn($i) => $labels[$i]['name'] ?? '', $ids))
            : t('mpg_scope_worldwide');
    } elseif ($extra !== []) {
        $names = [];
        foreach ($extra as $e) {
            $n = $labels[(int) $e['place_id']]['name'] ?? '';
            $names[] = $n . (!empty($e['radius_km']) ? ' (+' . (int) $e['radius_km'] . "\u{00A0}" . t('mpg_unit_km') . ')' : '');
        }
        $parts[] = t('mpg_also') . ' ' . implode(', ', $names);
    }

    return implode(' · ', array_filter($parts, static fn($p) => $p !== ''));
}

function mpg_distance_text(float $km, string $units): string
{
    $v = $units === 'mi' ? $km / MPG_KM_PER_MI : $km;

    return ($v < 10 ? number_format($v, 1, '.', '') : (string) (int) round($v)) . "\u{00A0}" . t($units === 'mi' ? 'mpg_unit_mi' : 'mpg_unit_km');
}

// --- Налаштування відвідувача ------------------------------------------------------------

/** @return array{country_code:string,place_id:int,radius_km:int,units:string,listing_langs:list<string>,show_online:bool,saved:bool} */
function mpg_prefs(PDO $pdo, ?int $userId): array
{
    $p = ['country_code' => '', 'place_id' => 0, 'radius_km' => MPG_DEFAULT_RADIUS, 'units' => 'km', 'listing_langs' => [], 'show_online' => true, 'saved' => false];
    if (!mpg_ready($pdo)) {
        return $p;
    }
    if ($userId !== null) {
        $st = $pdo->prepare('SELECT * FROM mp_user_prefs WHERE user_id = :u');
        $st->execute([':u' => $userId]);
        $r = $st->fetch(PDO::FETCH_ASSOC);
        if ($r !== false) {
            return [
                'country_code' => (string) ($r['country_code'] ?? ''), 'place_id' => (int) ($r['place_id'] ?? 0),
                'radius_km' => in_array((int) $r['radius_km'], MPG_RADII, true) ? (int) $r['radius_km'] : MPG_DEFAULT_RADIUS,
                'units' => $r['units'] === 'mi' ? 'mi' : 'km',
                'listing_langs' => array_values(array_intersect(explode(',', (string) $r['listing_langs']), MPG_LISTING_LANGS)),
                'show_online' => (int) $r['show_online'] === 1, 'saved' => true,
            ];
        }

        return $p;
    }
    $c = $_COOKIE[MPG_COOKIE] ?? '';
    if (is_string($c) && ctype_digit($c) && strlen($c) <= 10) {
        $place = mpg_place($pdo, (int) $c);
        if ($place !== null && $place['type'] === 'city') {
            $p['place_id'] = $place['id'];
            $p['country_code'] = $place['country_code'];
            $p['saved'] = true;
        }
    }

    return $p;
}

/**
 * Зберігає налаштування: залогінений — mp_user_prefs (усі поля); гість — лише cookie mp_loc (place_id).
 * $placeId = 0 у гостя — cookie видаляється.
 */
function mpg_prefs_save(PDO $pdo, ?int $userId, array $in): void
{
    $place = mpg_place($pdo, (int) ($in['place_id'] ?? 0));
    if ($place !== null && $place['type'] !== 'city') {
        $place = null;
    }
    if ($userId === null) {
        $secure = (($_SERVER['HTTPS'] ?? '') !== '' && $_SERVER['HTTPS'] !== 'off');
        if (!headers_sent()) {
            setcookie(MPG_COOKIE, $place !== null ? (string) $place['id'] : '', [
                'expires' => $place !== null ? time() + 365 * 86400 : time() - 3600,
                'path' => '/', 'secure' => $secure, 'httponly' => true, 'samesite' => 'Lax',
            ]);
        }
        if ($place !== null) {
            $_COOKIE[MPG_COOKIE] = (string) $place['id'];
        } else {
            unset($_COOKIE[MPG_COOKIE]);
        }

        return;
    }
    $cc = (string) ($in['country_code'] ?? '');
    if ($place !== null) {
        $cc = $place['country_code'];
    } elseif (mpg_country_id($pdo, $cc) === null) {
        $cc = '';
    }
    $radius = (int) ($in['radius_km'] ?? MPG_DEFAULT_RADIUS);
    $langs = array_values(array_intersect((array) ($in['listing_langs'] ?? []), MPG_LISTING_LANGS));
    $pdo->prepare(
        'INSERT INTO mp_user_prefs (user_id, country_code, place_id, radius_km, units, listing_langs, show_online)
         VALUES (:u, :cc, :p, :r, :un, :ll, :so)
         ON DUPLICATE KEY UPDATE country_code = VALUES(country_code), place_id = VALUES(place_id), radius_km = VALUES(radius_km),
                                 units = VALUES(units), listing_langs = VALUES(listing_langs), show_online = VALUES(show_online)'
    )->execute([
        ':u' => $userId, ':cc' => $cc !== '' ? $cc : null, ':p' => $place['id'] ?? null,
        ':r' => in_array($radius, MPG_RADII, true) ? $radius : MPG_DEFAULT_RADIUS,
        ':un' => ($in['units'] ?? 'km') === 'mi' ? 'mi' : 'km',
        ':ll' => $langs !== [] ? implode(',', $langs) : null,
        ':so' => !empty($in['show_online']) ? 1 : 0,
    ]);
}

// --- Вивід ------------------------------------------------------------------------

/** Підпис атрибуції GeoNames (CC BY 4.0) — дрібний рядок на сторінці пошуку. */
function mpg_attribution_html(): string
{
    return '<p class="mp-geo-credit">Geo data: <a href="https://www.geonames.org/" rel="noopener" target="_blank">GeoNames</a>'
        . ' (<a href="https://creativecommons.org/licenses/by/4.0/" rel="noopener license" target="_blank">CC BY 4.0</a>)</p>';
}
