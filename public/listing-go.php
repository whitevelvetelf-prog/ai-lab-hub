<?php

declare(strict_types=1);

/**
 * AI LAB HUB — проміжний перехід «Перейти на сторінку» оголошення компанії (як go.php для продуктів).
 *
 * GET ?id=N — лише живе оголошення (власник і співробітники — будь-яке, без обліку); рахує перехід у
 * mp_listing_stats_daily (без персональних даних, без ботів, 1 раз на 30 хв у сесії) і редиректить (302)
 * на https-адресу оголошення. Невідоме / неживе → 404. Нічого не рендерить.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$id = (int) ($_GET['id'] ?? 0);
$st = $pdo->prepare(
    "SELECT l.delivery_url, s.user_id AS owner, (l.status = 'published' AND l.expires_at > NOW()) AS live
     FROM mp_listings l LEFT JOIN mp_sellers s ON s.id = l.seller_id
     WHERE l.id = :id AND l.section IN ('job', 'course', 'service')"
);
$st->execute([':id' => $id]);
$row = $st->fetch(PDO::FETCH_ASSOC);
$uid = auth_user_id();
$isOwner = $row !== false && $row['owner'] !== null && (int) $row['owner'] === $uid;
if ($row === false || !lst_url_valid((string) $row['delivery_url'])
    || ((int) $row['live'] !== 1 && !$isOwner && !mp_is_staff())
    || ((int) $row['live'] === 1 && !mp_public_enabled() && !mp_is_staff())) {
    mp_not_found();
}
if ((int) $row['live'] === 1) {
    lst_count_click($pdo, $id, $row['owner'] !== null ? (int) $row['owner'] : null);
}
header('X-Robots-Tag: noindex, nofollow');
header('Referrer-Policy: origin');
header('Location: ' . (string) $row['delivery_url'], true, 302);
exit;
