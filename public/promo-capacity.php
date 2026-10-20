<?php

declare(strict_types=1);

/**
 * AI LAB HUB — орієнтовна ємність місць показу для майстра кампанії (promo-cabinet.js).
 *
 * GET cats=1,2  subs=5  mp=job,board:3 (розділи маркетплейсу)  language=all|uk|en  device=all|mobile|desktop
 * 200 + JSON {placement_key: N | null} — людські перегляди відповідних сторінок за
 * останні 30 днів у межах таргетингу, без сторінок no_promo (app/promo-placements.php →
 * promo_placement_capacity). null — для місця немає даних. Лише для авторизованих.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/promo.php';

header('Cache-Control: private, max-age=300');
header('X-Robots-Tag: noindex');

if (auth_user_id() === null) {
    http_response_code(403);
    exit;
}

$ids = static function (string $key): array {
    $raw = is_string($_GET[$key] ?? null) ? $_GET[$key] : '';
    $out = [];
    foreach (explode(',', $raw) as $part) {
        if ((int) $part > 0) {
            $out[] = (int) $part;
        }
    }

    return array_slice(array_values(array_unique($out)), 0, 300);
};
$lang = in_array($_GET['language'] ?? '', ['uk', 'en'], true) ? $_GET['language'] : null;
$device = in_array($_GET['device'] ?? '', ['mobile', 'desktop'], true) ? $_GET['device'] : null;

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$mp = is_string($_GET['mp'] ?? null) ? array_slice(array_values(array_filter(explode(',', $_GET['mp']), 'promo_mp_section_valid')), 0, 50) : [];

$out = [];
foreach (array_keys(promo_placements($pdo)) as $key) {
    // Маркетплейс ще не відкрито — переглядів немає (майстер пише «ще немає»).
    $out[$key] = promo_placement_pending($pdo, $key) ? null : promo_placement_capacity($pdo, $key, $ids('cats'), $ids('subs'), $lang, $device, $mp);
}

header('Content-Type: application/json; charset=utf-8');
echo json_encode($out);
