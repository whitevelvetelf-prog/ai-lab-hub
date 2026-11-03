<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: автопідказка місць (JSON).
 *
 *   GET  ?q=Льв&lang=uk[&type=city|country|any]  → до 10 місць, у яких будь-яка назва (uk/en) починається з q.
 *        «Львів» і «Lviv» — те саме місце (один id). Назви — мовою lang (uk|en), інакше англійською.
 *   POST near=1, lat, lon, csrf                    → найближче місто (кнопка «Поблизу»). Координати лише в
 *        тілі POST (не в адресі й журналах), ніде не зберігаються.
 *
 * Ліміт з одного IP — mp_rate_limits (mpb_ip_hit, дія 'geo'; config ip_limit_geo_suggest на добу), не для staff.
 */

// ?lang= на сайті — перемикач мови інтерфейсу з редіректом (app/translations.php). Тут це лише мова назв:
// забираємо параметр ДО підключення translations.php, щоб підказка не міняла мову сесії.
$reqLang = $_GET['lang'] ?? $_POST['lang'] ?? null;
unset($_GET['lang'], $_REQUEST['lang']);

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-geo.php';

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');
header('X-Robots-Tag: noindex');

/** @param array<string,mixed> $body */
$reply = static function (int $code, array $body): never {
    http_response_code($code);
    echo json_encode($body, JSON_UNESCAPED_UNICODE);
    exit;
};

if (!mp_public_enabled() && !mp_is_staff()) {
    $reply(404, ['error' => 'not_found']);
}
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
    unset($lat, $lon);
    $l = $id !== null ? (mpg_labels($pdo, [$id], $lang)[$id] ?? null) : null;
    $reply(200, ['place' => $l !== null ? ['id' => $l['id'], 'type' => $l['type'], 'country_code' => $l['country_code'], 'name' => $l['name'], 'label' => $l['label']] : null]);
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
$reply(200, ['items' => mpg_suggest($pdo, $q, $lang, $types)]);
