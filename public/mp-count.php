<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: кількість результатів для кнопки «Показати N результатів» (public/assets/js/mp-filters.js).
 *
 *   GET mp-count.php?p=cat&id=N&<фільтри сторінки блока>  → {"total": N}
 *   GET mp-count.php?p=search&<фільтри marketplace.php>    → {"total": N}
 * Розбір — ті самі функції з білими списками, що й на сторінках (mpj_block_filters, mpb_search_filters); лише читання.
 * Ліміт частоти — mp_rate_limits (ip_limit_count на добу з одного IP; staff — без ліміту). Поки public_enabled=false — 404.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/mp-search.php';

mp_public_require();

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');
header('X-Robots-Tag: noindex, nofollow');

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'GET') {
    http_response_code(405);
    echo json_encode(['ok' => false]);
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$lang = current_lang();
$userId = auth_user_id();
session_write_close();

if (!mpb_is_staff() && !mpb_ip_hit($pdo, 'count', (int) mp_config()['ip_limit_count'])) {
    http_response_code(429);
    echo json_encode(['ok' => false, 'error' => 'rate']);
    exit;
}

$p = is_string($_GET['p'] ?? null) ? (string) $_GET['p'] : '';
try {
    if ($p === 'cat') {
        $id = is_string($_GET['id'] ?? null) && ctype_digit((string) $_GET['id']) ? (int) $_GET['id'] : 0;
        $node = $id > 0 ? mpt_node(mpt_tree($pdo, $lang), $id) : null;
        if ($node === null) {
            http_response_code(404);
            echo json_encode(['ok' => false]);
            exit;
        }
        $bf = mpj_block_filters($pdo, $node['block'], $node['sub'], $_GET);
        $total = mpt_search($pdo, $lang, $bf['f'], 1, 1)['total'];
    } elseif ($p === 'search') {
        $prefs = mpg_ready($pdo) ? mpg_prefs($pdo, $userId) : ['saved' => false, 'units' => 'km'];
        $f = mpb_search_filters($pdo, $_GET, $lang, $prefs);
        $total = mpb_search($pdo, $lang, $f, 1)['total'];
    } else {
        http_response_code(400);
        echo json_encode(['ok' => false]);
        exit;
    }
    echo json_encode(['ok' => true, 'total' => (int) $total]);
} catch (Throwable $e) {
    error_log('[mp-count] ' . $e->getMessage());
    http_response_code(500);
    echo json_encode(['ok' => false]);
}
