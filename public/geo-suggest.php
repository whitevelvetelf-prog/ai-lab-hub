<?php

declare(strict_types=1);

/**
 * AI LAB HUB — автопідказка місць для всього сайту (JSON): вибір місця відвідувача (geo-location.php),
 * «Де надається» в оголошеннях, пошук Marketplace, «Географія показу» в кабінеті рекламодавця.
 * На відміну від mp-geo-suggest.php не залежить від того, чи відкрито Marketplace.
 *
 *   GET  ?q=Льв&lang=uk&type=any|city|country  → до 10 місць, у яких будь-яка назва (uk/en) починається з q.
 *        «Львів» і «Lviv» — те саме місце (один id). Відповідь: id, type, country_code, name (мовою lang, запасна
 *        англійська), label («місто, регіон, країна»), region, country.
 *   POST near=1, lat, lon, csrf                 → найближче місто в межах 100 км (кнопка «Поблизу»). Координати лише
 *        в тілі POST (не в адресі й журналах), ніде не зберігаються.
 *
 * Ліміт частоти з одного IP — mp_rate_limits (mpb_ip_hit, дія 'geo', хеш IP із сіллю; config ip_limit_geo_suggest
 * на добу), не для staff. Доступно гостям і залогіненим.
 */

// ?lang= на сайті — перемикач мови інтерфейсу з редіректом (app/translations.php). Тут це лише мова назв.
$reqLang = $_GET['lang'] ?? $_POST['lang'] ?? null;
unset($_GET['lang'], $_REQUEST['lang']);

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/geo.php';

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');
header('X-Robots-Tag: noindex');

/** @param array<string,mixed> $body */
$reply = static function (int $code, array $body): never {
    http_response_code($code);
    echo json_encode($body, JSON_UNESCAPED_UNICODE);
    exit;
};

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
if (!mpg_ready($pdo)) {
    $reply(503, ['error' => 'unavailable']);
}
$method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
$lang = is_string($reqLang) && in_array($reqLang, ['uk', 'en'], true) ? $reqLang : current_lang();
if (!in_array($lang, ['uk', 'en'], true)) {
    $lang = 'en';
}

if (!mp_is_staff() && !mpb_ip_hit($pdo, 'geo', (int) mp_config()['ip_limit_geo_suggest'])) {
    $reply(429, ['error' => 'rate_limited']);
}

/** Розширений рядок відповіді: + регіон і країна окремо. */
$item = static function (array $l): array {
    $parts = array_map('trim', explode(',', (string) $l['label']));
    $country = $l['type'] === 'country' ? $l['name'] : (string) end($parts);
    $region = $l['type'] === 'city' && count($parts) >= 3 ? $parts[count($parts) - 2] : '';

    return ['id' => (int) $l['id'], 'type' => $l['type'], 'country_code' => $l['country_code'], 'name' => $l['name'],
        'label' => $l['label'], 'region' => $region, 'country' => $country];
};

if ($method === 'POST') {
    if (($_POST['near'] ?? '') !== '1' || !mp_csrf_verify()) {
        $reply(400, ['error' => 'bad_request']);
    }
    $lat = filter_var($_POST['lat'] ?? null, FILTER_VALIDATE_FLOAT);
    $lon = filter_var($_POST['lon'] ?? null, FILTER_VALIDATE_FLOAT);
    if ($lat === false || $lon === false) {
        $reply(400, ['error' => 'bad_request']);
    }
    $id = mpg_nearest_city($pdo, (float) $lat, (float) $lon);
    unset($lat, $lon, $_POST['lat'], $_POST['lon']);
    $l = $id !== null ? (mpg_labels($pdo, [$id], $lang)[$id] ?? null) : null;
    $reply(200, ['place' => $l !== null ? $item($l) : null]);
}
if ($method !== 'GET') {
    $reply(405, ['error' => 'method']);
}

$q = is_string($_GET['q'] ?? null) ? (string) $_GET['q'] : '';
$type = is_string($_GET['type'] ?? null) ? (string) $_GET['type'] : 'any';
$types = match ($type) {
    'city' => ['city'],
    'country' => ['country'],
    default => ['city', 'country'],
};
$out = [];
foreach (mpg_suggest($pdo, $q, $lang, $types) as $s) {
    $out[] = $item($s);
}
$reply(200, ['items' => $out]);
