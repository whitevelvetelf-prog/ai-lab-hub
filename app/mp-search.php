<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace, етап 6: розбір GET розширеного пошуку (marketplace.php) за білими списками.
 * Підключати після app/marketplace-board.php (він підключає app/mp-geo.php).
 */

require_once __DIR__ . '/mp-jobs.php';

/** Ключі GET розширеного пошуку (усе інше ігнорується). */
const MPB_SEARCH_KEYS = ['q', 'section', 'cat', 'price_type', 'price_min', 'price_max', 'country', 'place', 'radius', 'format',
    'listing_lang', 'with_photos', 'verified', 'sort', 'page',
    // Хвиля 1: фільтри блока (app/mp-jobs.php → MPJ_KEYS)
    'emp', 'sched', 'exp', 'fit', 'wf', 'sal', 'scur', 'sper', 'cf', 'ptype', 'stype', 'region'];
const MPB_SEARCH_SORTS = ['new', 'price_asc', 'price_desc', 'distance', 'salary_desc', 'salary_asc'];

/**
 * Нормалізовані фільтри пошуку з GET. Некоректні значення відкидаються мовчки (ніби параметра немає).
 * Синоніми старих посилань: min/max, remote=1 → format=online, city=<текст> → place
 * (перше місто з автопідказки), sort=cheap|expensive.
 * Налаштування відвідувача (mpg_prefs) підставляються, лише якщо в GET немає жодного параметра місця (country,
 * place, radius, format, city, remote) — інакше діє явний вибір.
 *
 * @return array<string,mixed> фільтри для mpb_search() + page, url (канонічні параметри для посилань), units, from_prefs
 */
function mpb_search_filters(PDO $pdo, array $get, string $lang, array $prefs): array
{
    $s = static fn(string $k, int $max = 100): string => is_string($get[$k] ?? null) ? mb_substr(trim((string) $get[$k]), 0, $max) : '';
    $int = static fn(string $k): int => preg_match('/^\d{1,9}$/', $s($k, 10)) === 1 ? (int) $s($k, 10) : 0;
    $num = static function (string $k) use ($s): ?float {
        $raw = str_replace([' ', ','], ['', '.'], $s($k, 14));

        return preg_match('/^\d{1,9}(\.\d{1,2})?$/', $raw) === 1 ? (float) $raw : null;
    };
    // Блок дерева (section) і підкатегорія (cat). Старі адреси (category=…, section=board|solutions, sub) —
    // 301 у marketplace.php ще до цього розбору.
    $section = in_array($s('section', 20), MPT_SECTIONS, true) ? $s('section', 20) : '';
    $cat = $int('cat');
    if ($cat > 0) {
        $node = mpt_node(mpt_tree($pdo, $lang), $cat);
        if ($node === null || ($section !== '' && $node['block']['section'] !== $section)) {
            $cat = 0;
        } else {
            $section = $node['block']['section'];
        }
    }

    $priceMin = $num('price_min') ?? $num('min');
    $priceMax = $num('price_max') ?? $num('max');
    $sort = $s('sort', 12);
    $sort = ['cheap' => 'price_asc', 'expensive' => 'price_desc'][$sort] ?? $sort;
    $sort = in_array($sort, MPB_SEARCH_SORTS, true) ? $sort : 'new';

    // Місце: явний вибір у GET → інакше налаштування відвідувача
    $hasGeoParam = false;
    foreach (['country', 'place', 'radius', 'format', 'city', 'remote'] as $k) {
        if (array_key_exists($k, $get)) {
            $hasGeoParam = true;
        }
    }
    $units = ($prefs['units'] ?? 'km') === 'mi' ? 'mi' : 'km';
    $format = in_array($s('format', 10), array_merge(['any'], MPG_FORMATS), true) ? $s('format', 10) : 'any';
    if ($format === 'any' && $s('remote', 2) === '1') {
        $format = 'online';
    }
    $radius = in_array($int('radius'), MPG_RADII, true) ? $int('radius') : MPG_DEFAULT_RADIUS;
    $cc = strtoupper($s('country', 10));   // без обрізання: «AU' OR …» не стає «AU»
    $country = preg_match('/^[A-Z]{2}$/', $cc) === 1 ? $cc : '';
    $place = null;
    if ($int('place') > 0) {
        $place = mpg_place($pdo, $int('place'));
    } elseif ($s('city', 120) !== '') {
        $first = mpg_suggest($pdo, $s('city', 120), $lang, ['city'], 1)[0] ?? null;
        $place = $first !== null ? mpg_place($pdo, (int) $first['id']) : null;
    }
    if ($place !== null && $place['type'] !== 'city') {
        $country = $country ?: $place['country_code'];
        $place = null;
    }
    $fromPrefs = false;
    $showOnline = true;
    if (!$hasGeoParam && !empty($prefs['saved'])) {
        $fromPrefs = true;
        $place = (int) $prefs['place_id'] > 0 ? mpg_place($pdo, (int) $prefs['place_id']) : null;
        $country = $place['country_code'] ?? (string) $prefs['country_code'];
        $radius = (int) $prefs['radius_km'];
        $showOnline = (bool) $prefs['show_online'];
    }
    if ($country !== '' && mpg_country_id($pdo, $country) === null) {
        $country = '';
    }
    if ($place !== null) {
        $country = $place['country_code'];
    }
    $radiusKm = $units === 'mi' ? $radius * MPG_KM_PER_MI : (float) $radius;

    $ll = in_array($s('listing_lang', 5), MPG_LISTING_LANGS, true) ? $s('listing_lang', 5) : '';
    $langs = $ll !== '' ? [$ll] : (array_key_exists('listing_lang', $get) ? [] : (array) ($prefs['listing_langs'] ?? []));
    $sort = $sort === 'distance' && $place === null ? 'new' : $sort;
    // Сортування за зарплатою — лише у вакансіях.
    $sort = in_array($sort, ['salary_desc', 'salary_asc'], true) && $section !== 'job' ? 'new' : $sort;
    $jf = mpj_parse($get, $section);

    $f = [
        'q' => $s('q'), 'section' => $section, 'cat' => $cat,
        'price_type' => in_array($s('price_type', 20), MPB_PRICE_TYPES, true) ? $s('price_type', 20) : '',
        'price_min' => $priceMin, 'price_max' => $priceMax,
        'listing_langs' => array_values(array_intersect($langs, MPG_LISTING_LANGS)), 'listing_lang' => $ll,
        'with_photos' => $s('with_photos', 1) === '1', 'verified' => $s('verified', 1) === '1',
        'geo' => ['format' => $format, 'show_online' => $showOnline, 'country' => $country, 'place' => $place, 'radius_km' => $radiusKm],
        'country' => $country, 'place_id' => $place['id'] ?? 0, 'radius' => $radius, 'format' => $format,
        'sort' => $sort, 'page' => max(1, min(10000, $int('page') ?: 1)), 'jf' => $jf,
        'units' => $units, 'from_prefs' => $fromPrefs,
    ];
    // Канонічні параметри для посилань (пагінація) — лише непорожні.
    $f['url'] = array_filter([
        'q' => $f['q'], 'section' => $section, 'cat' => $cat ?: null, 'price_type' => $f['price_type'],
        'price_min' => $priceMin, 'price_max' => $priceMax, 'country' => $country !== '' && $place === null ? $country : null,
        'place' => $place['id'] ?? null, 'radius' => $place !== null ? $radius : null,
        'format' => $format !== 'any' ? $format : null, 'listing_lang' => $ll,
        'with_photos' => $f['with_photos'] ? 1 : null, 'verified' => $f['verified'] ? 1 : null,
        'sort' => $sort !== 'new' ? $sort : null,
    ] + mpj_url_params($jf), static fn($x): bool => $x !== null && $x !== '');

    return $f;
}

/** Чи задано хоч один фільтр (для тексту «нічого не знайдено» й кнопки «Скинути»). */
function mpb_search_has_filters(array $f): bool
{
    return $f['q'] !== '' || $f['section'] !== '' || $f['cat'] > 0 || $f['price_type'] !== '' || $f['price_min'] !== null
        || $f['price_max'] !== null || $f['country'] !== '' || $f['format'] !== 'any' || $f['listing_langs'] !== []
        || $f['with_photos'] || $f['verified'] || mpj_has_filters($f['jf'] ?? []);
}
