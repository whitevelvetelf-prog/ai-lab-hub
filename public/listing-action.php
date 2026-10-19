<?php

declare(strict_types=1);

/**
 * AI LAB HUB — дії власника з оголошеннями компаній (кабінет, розділ «Мої оголошення»).
 *
 *   POST action=extend|remove, id=N (+CSRF)   — продовжити (поки безкоштовно) / зняти з публікації
 *   GET  export=csv                           — CSV: оголошення з переглядами й переходами за 30 днів (і по днях)
 * Лише власні оголошення; без персональних даних відвідувачів.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$uid = auth_user_id();
if ($uid === null) {
    header('Location: login.php', true, 303);
    exit;
}

if (($_GET['export'] ?? '') === 'csv') {
    $rows = lst_user_listings($pdo, $uid);
    $ids = array_map(static fn($r) => (int) $r['id'], $rows);
    $daily = [];
    if ($ids !== []) {
        $in = implode(',', array_fill(0, count($ids), '?'));
        $st = $pdo->prepare("SELECT listing_id, day, views, clicks FROM mp_listing_stats_daily WHERE listing_id IN ($in) AND day > (CURDATE() - INTERVAL 30 DAY) ORDER BY day");
        $st->execute($ids);
        foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $d) {
            $daily[(int) $d['listing_id']][] = $d;
        }
    }
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="my-listings-' . date('Y-m-d') . '.csv"');
    $out = fopen('php://output', 'w');
    fwrite($out, "\xEF\xBB\xBF");
    fputcsv($out, ['id', 'type', 'title', 'company', 'status', 'published_at', 'expires_at', 'day', 'views', 'clicks']);
    $safe = static fn(string $v): string => preg_match('/^[=+\-@\t\r]/', $v) === 1 ? "'" . $v : $v;   // захист від формул у таблицях
    foreach ($rows as $r) {
        $base = [(int) $r['id'], $r['section'], $safe((string) $r['title']), $safe((string) $r['company_name']), $r['status'], (string) $r['published_at'], (string) $r['expires_at']];
        $days = $daily[(int) $r['id']] ?? [];
        if ($days === []) {
            fputcsv($out, array_merge($base, ['', 0, 0]));
        }
        foreach ($days as $d) {
            fputcsv($out, array_merge($base, [$d['day'], (int) $d['views'], (int) $d['clicks']]));
        }
    }
    fclose($out);
    exit;
}

mpb_require_post();
$id = (int) ($_POST['id'] ?? 0);
$own = lst_own($pdo, $id, $uid);
if ($own === null) {
    mp_not_found();
}
$action = (string) ($_POST['action'] ?? '');
if ($action === 'extend') {
    $res = lst_extend($pdo, $own, $uid);
    mpb_flash($res === 'ok' ? 'ok' : 'error', $res === 'ok' ? lst_tr('extended') : lst_tr($res, LST_EXTEND_WINDOW_DAYS));
} elseif ($action === 'remove') {
    $ok = lst_remove($pdo, $id, $uid, 'знято власником');
    mpb_flash($ok ? 'ok' : 'error', lst_tr($ok ? 'removed' : 'action_failed'));
}
header('Location: account.php#acc-listings', true, 303);
exit;
