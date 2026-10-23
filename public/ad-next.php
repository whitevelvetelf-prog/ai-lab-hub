<?php

declare(strict_types=1);

/**
 * AI LAB HUB — наступне оголошення для спливаючого вікна (public/assets/js/ad-popup.js).
 *
 * GET category=1,2  subcategory=5  lang=uk|en  device=mobile|desktop  page=<ім'я файлу сторінки>
 *
 * Серверна частина правил (app/ad-popup.php): система й місце 'popup' ввімкнені, не бот,
 * сторінка не в списку виключень, уже друга сторінка візиту й минуло 30 с від його початку,
 * минув мінімальний проміжок від закриття (чи видачі) попереднього вікна, не діє тиша після
 * автентифікації (app/promo-quiet.php). Інакше — 204
 * (заголовок X-Popup-Wait: скільки секунд чекати; -1 — не на цій сторінці).
 *
 * 200 + JSON {creative, labels}: одне оголошення (promo_pick_set: спершу платні за вагою,
 * вільне місце — власна реклама; не те саме, що минулого разу; нещодавно показані — нижче).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/ad-popup.php';

header('Cache-Control: no-store');
header('X-Robots-Tag: noindex');

$ids = static function (string $key): array {
    $raw = is_string($_GET[$key] ?? null) ? $_GET[$key] : '';

    return array_slice(array_values(array_unique(array_filter(array_map('intval', explode(',', $raw)), static fn($v) => $v > 0))), 0, 20);
};

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);

$page = is_string($_GET['page'] ?? null) ? $_GET['page'] : '';
if (!ad_popup_available($pdo) || ($page !== '' && ad_popup_page_excluded($pdo, $page))) {
    http_response_code(204);
    exit;
}
// Сторінка автентифікації (-1) або тиша після входу / реєстрації / виходу (секунд до кінця) — app/promo-quiet.php.
$quietUntil = promo_suppress_until($pdo);
if (($page !== '' && promo_is_auth_page($page)) || $quietUntil > 0) {
    header('X-Popup-Wait: ' . ($quietUntil > 0 && !promo_is_auth_page($page) ? max(1, $quietUntil - time()) : -1));
    http_response_code(204);
    exit;
}
$wait = ad_popup_wait_seconds($pdo);
if ($wait === null || $wait > 0) {
    header('X-Popup-Wait: ' . ($wait ?? -1));
    http_response_code(204);
    exit;
}

$st = &ad_popup_state();
$last = (int) ($st['last_creative'] ?? 0);
$args = [$pdo, AD_POPUP_PLACEMENT, $ids('category'), $ids('subcategory'),
    promo_lang(is_string($_GET['lang'] ?? null) ? $_GET['lang'] : null),
    promo_device(is_string($_GET['device'] ?? null) ? $_GET['device'] : null),
    analytics_session_hash(), []];
// Наступний показ — інше оголошення; якщо інших немає зовсім, те саме краще, ніж нічого.
$set = promo_pick_set(...[...$args, $last > 0 ? [$last] : [], 1]);
if ($set === [] && $last > 0) {
    $set = promo_pick_set(...[...$args, [], 1]);
}
if ($set === []) {
    http_response_code(204);
    exit;
}

$creative = $set[0];
$payload = promo_public_payload($creative, AD_POPUP_PLACEMENT, false, $pdo);
$payload['skip'] = ad_popup_skip_delay($pdo, $creative);
// Без відео (зображення, картка) — вікно закривається саме через ad_popup_static_display_seconds.
$payload['display'] = in_array($payload['type'], ['image', 'card'], true)
    ? max($payload['skip'], ad_popup_int($pdo, 'ad_popup_static_display_seconds')) : null;
$st['last_creative'] = (int) $creative['id'];
ad_popup_mark_served();

header('Content-Type: application/json; charset=utf-8');
echo json_encode(['creative' => $payload, 'labels' => promo_labels() + [
    'skipIn' => t('ad_popup_skip_in'),
    'skip' => t('ad_popup_skip'),
    'skipReady' => t('ad_popup_skip_ready'),
    'dialog' => t('ad_popup_dialog'),
]], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
