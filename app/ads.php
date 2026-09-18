<?php

declare(strict_types=1);

/**
 * AI LAB HUB — вибір рекламної кампанії для слота (app/ad-banner.php).
 *
 * Кампанії керуються вручну через SQL (таблиця campaigns,
 * database/migration-2026-09-18-monetization-foundation.sql) — адмінки
 * поки немає, це окрема майбутня задача.
 *
 * Підключати перед app/ad-banner.php:
 *   require_once __DIR__ . '/../app/ads.php';
 */

/**
 * Кампанія для показу в заданому слоті: активна платна (у межах
 * starts_at/ends_at) має пріоритет; якщо такої нема — випадкова активна
 * internal-кампанія як заповнювач. Повертає null, якщо для слота взагалі
 * немає жодної активної кампанії.
 */
function ads_pick_campaign(PDO $pdo, string $placement): ?array
{
    $paidStmt = $pdo->prepare(
        "SELECT * FROM campaigns
         WHERE placement = :placement
           AND campaign_type = 'paid'
           AND is_active = 1
           AND (starts_at IS NULL OR starts_at <= NOW())
           AND (ends_at IS NULL OR ends_at >= NOW())
         ORDER BY starts_at DESC
         LIMIT 1"
    );
    $paidStmt->execute([':placement' => $placement]);
    $paid = $paidStmt->fetch();
    if ($paid !== false) {
        return $paid;
    }

    $internalStmt = $pdo->prepare(
        "SELECT * FROM campaigns
         WHERE placement = :placement
           AND campaign_type = 'internal'
           AND is_active = 1
         ORDER BY RAND()
         LIMIT 1"
    );
    $internalStmt->execute([':placement' => $placement]);
    $internal = $internalStmt->fetch();

    return $internal !== false ? $internal : null;
}
