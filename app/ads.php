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

/**
 * Ad server (зони): оголошення для зони $zoneId.
 *
 * Пошук в ads/ad_campaigns (таблиці з increment_latest.sql): спершу серед
 * активних платних кампаній у межах start_date/end_date, якщо нема — серед
 * internal (fallback). Оголошення, прив'язане до тієї ж категорії/
 * підкатегорії, має пріоритет над універсальним (category_id/subcategory_id
 * IS NULL); якщо контекст не заданий — підходять лише універсальні.
 * Серед рівнозначних вибір випадковий.
 *
 * @return array{id:int,image_url:string,target_url:string}|null
 */
function getAdForZone(int $zoneId, ?int $categoryId = null, ?int $subcategoryId = null, ?PDO $pdo = null): ?array
{
    $pdo ??= require __DIR__ . '/../config/database.php';

    $sql = "SELECT a.id, a.image_url, a.target_url
            FROM ads a
            JOIN ad_campaigns c ON c.id = a.campaign_id
            WHERE a.zone_id = :zone
              AND a.status = 'active'
              AND c.campaign_type = :type
              AND c.status = 'active'
              AND c.start_date <= CURDATE()
              AND (c.end_date IS NULL OR c.end_date >= CURDATE())
              AND " . ($categoryId !== null
                ? '(a.category_id IS NULL OR a.category_id = :cat)'
                : 'a.category_id IS NULL') . "
              AND " . ($subcategoryId !== null
                ? '(a.subcategory_id IS NULL OR a.subcategory_id = :sub)'
                : 'a.subcategory_id IS NULL') . "
            ORDER BY (a.category_id IS NOT NULL) + (a.subcategory_id IS NOT NULL) DESC, RAND()
            LIMIT 1";
    $stmt = $pdo->prepare($sql);

    foreach (['paid', 'internal'] as $type) {
        $params = [':zone' => $zoneId, ':type' => $type];
        if ($categoryId !== null) {
            $params[':cat'] = $categoryId;
        }
        if ($subcategoryId !== null) {
            $params[':sub'] = $subcategoryId;
        }
        $stmt->execute($params);
        $ad = $stmt->fetch();
        if ($ad !== false) {
            return $ad;
        }
    }

    return null;
}
