<?php

declare(strict_types=1);

/**
 * AI LAB HUB — відбір відеореклами для слота (app/promo.php → promo_pick).
 *
 * GET placement=catalog_card|product_page|blog_inline
 *     category=1,2  subcategory=5  (id сторінки, через кому; порожньо — без категорії)
 *     lang=uk|en  device=mobile|desktop  (необов'язкові; інакше — мова сесії / User-Agent)
 *
 * 200 + JSON {creative, labels} — один креатив; 204 — реклами немає
 * (система вимкнена, немає придатних кампанії, бот). Викликає sponsored.js.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/promo.php';

header('Cache-Control: no-store');
header('X-Robots-Tag: noindex');

$ids = static function (string $key): array {
    $raw = is_string($_GET[$key] ?? null) ? $_GET[$key] : '';
    $out = [];
    foreach (explode(',', $raw) as $part) {
        $id = (int) $part;
        if ($id > 0) {
            $out[] = $id;
        }
    }

    return array_slice(array_values(array_unique($out)), 0, 20);
};

$placement = is_string($_GET['placement'] ?? null) ? $_GET['placement'] : '';

if (promo_is_bot() || !in_array($placement, PROMO_PLACEMENTS, true)) {
    http_response_code(204);
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$creative = promo_pick(
    $pdo,
    $placement,
    $ids('category'),
    $ids('subcategory'),
    promo_lang(is_string($_GET['lang'] ?? null) ? $_GET['lang'] : null),
    promo_device(is_string($_GET['device'] ?? null) ? $_GET['device'] : null),
    analytics_session_hash()
);

if ($creative === null) {
    http_response_code(204);
    exit;
}

header('Content-Type: application/json; charset=utf-8');
echo json_encode(
    ['creative' => promo_public_payload($creative, $placement), 'labels' => promo_labels()],
    JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES
);
