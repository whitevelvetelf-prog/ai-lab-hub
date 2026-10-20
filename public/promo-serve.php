<?php

declare(strict_types=1);

/**
 * AI LAB HUB — відбір відеореклами для слота (app/promo.php → promo_pick).
 *
 * GET placement=category_page|subcategory_list|search_results|product_page|blog_list|blog_article|
 *              marketplace_home|marketplace_feed|marketplace_category|marketplace_search|marketplace_listing_page
 *     category=1,2  subcategory=5  (id сторінки, через кому; порожньо — без категорії)
 *     lang=uk|en  device=mobile|desktop  (необов'язкові; інакше — мова сесії / User-Agent)
 *     product=N | article=slug  (сторінка: перевірка no_promo і правил категорій реклами)
 *     mp=board,board:3  (розділи сторінки маркетплейсу — таргетинг за розділом)
 *     exclude=3,7  (креативи, уже показані на цій сторінці — одна реклама не повторюється)
 *     nohouse=1    (на сторінці вже є блок власної реклами — не більше одного)
 *     preview=1    (адмін із ?promo_preview=1: креатив тестової кампанії is_test, без обліку)
 *
 * 200 + JSON {creative, labels} — один креатив; 204 — реклами немає
 * (система вимкнена, сторінку виключено no_promo, немає придатних кампаній, бот). Викликає sponsored.js.
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

if (!in_array($placement, PROMO_PLACEMENTS, true) || (promo_is_bot() && ($_GET['preview'] ?? '') !== '1')) {
    http_response_code(204);
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);

// Адмін-перегляд місця: тестова кампанія, токен із позначкою перегляду (події не рахуються).
if (($_GET['preview'] ?? '') === '1') {
    $_GET['promo_preview'] = '1';
    $creative = promo_preview_active($pdo) ? promo_preview_creative($pdo) : null;
    if ($creative === null) {
        http_response_code(204);
        exit;
    }
    $payload = promo_public_payload($creative, $placement, true, $pdo);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(['creative' => $payload, 'labels' => promo_labels()], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

$page = [];
if ((int) ($_GET['product'] ?? 0) > 0) {
    $page['product'] = (int) $_GET['product'];
}
if (is_string($_GET['article'] ?? null) && preg_match('/^[a-z0-9-]{1,191}$/', $_GET['article'])) {
    $page['article'] = $_GET['article'];
}
if (($_GET['nohouse'] ?? '') === '1') {
    $page['no_house'] = true;   // на сторінці вже є власний блок — лише платна реклама
}
if (is_string($_GET['mp'] ?? null) && $_GET['mp'] !== '') {
    $page['mp'] = array_slice(array_values(array_filter(explode(',', $_GET['mp']), 'promo_mp_section_valid')), 0, 5);
}

$creative = promo_pick(
    $pdo,
    $placement,
    $ids('category'),
    $ids('subcategory'),
    promo_lang(is_string($_GET['lang'] ?? null) ? $_GET['lang'] : null),
    promo_device(is_string($_GET['device'] ?? null) ? $_GET['device'] : null),
    analytics_session_hash(),
    $page,
    $ids('exclude')
);

if ($creative === null) {
    http_response_code(204);
    exit;
}

header('Content-Type: application/json; charset=utf-8');
echo json_encode(
    ['creative' => promo_public_payload($creative, $placement, false, $pdo), 'labels' => promo_labels()],
    JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES
);
