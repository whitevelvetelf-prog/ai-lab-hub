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
 *
 * Глобальний перемикач ad_settings.enabled (app/promo.php → promo_enabled)
 * вимикає всю рекламу сайту, зокрема ці банери.
 */

require_once __DIR__ . '/promo.php';
require_once __DIR__ . '/marketplace.php';

/**
 * Кампанія для показу в заданому слоті: активна платна (у межах
 * starts_at/ends_at) має пріоритет; якщо такої нема — випадкова активна
 * internal-кампанія як заповнювач. Повертає null, якщо для слота взагалі
 * немає жодної активної кампанії.
 */
function ads_pick_campaign(PDO $pdo, string $placement): ?array
{
    // Глобальний перемикач реклами (ad_settings.enabled) вимикає й старі банери.
    if (!promo_enabled($pdo)) {
        return null;
    }

    // Поки Marketplace приховано (mp_public_enabled), банери з посиланням на нього не показуються.
    $mpSql = mp_public_enabled() ? '' : " AND target_url NOT LIKE '%marketplace%'";

    $paidStmt = $pdo->prepare(
        "SELECT * FROM campaigns
         WHERE placement = :placement" . $mpSql . "
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

    // Без ORDER BY RAND(): кілька рядків за індексом, випадковий вибір у PHP.
    $internalStmt = $pdo->prepare(
        "SELECT * FROM campaigns
         WHERE placement = :placement" . $mpSql . "
           AND campaign_type = 'internal'
           AND is_active = 1
         LIMIT 50"
    );
    $internalStmt->execute([':placement' => $placement]);
    $internal = $internalStmt->fetchAll();

    return $internal !== [] ? $internal[mt_rand(0, count($internal) - 1)] : null;
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
 * @return array{id:int,image_url:string,target_url:string,headline:?string,subtext:?string}|null
 */
function getAdForZone(int $zoneId, ?int $categoryId = null, ?int $subcategoryId = null, ?PDO $pdo = null): ?array
{
    $pdo ??= require __DIR__ . '/../config/database.php';

    if (!promo_enabled($pdo)) {
        return null;
    }
    if (promo_page_excluded($pdo, $categoryId !== null ? [$categoryId] : [], $subcategoryId !== null ? [$subcategoryId] : []) !== null) {
        return null; // сторінка «без реклами» (блок H)
    }

    $sql = "SELECT a.id, a.image_url, a.target_url, a.headline, a.subtext, a.category_id, a.subcategory_id
            FROM ads a
            JOIN ad_campaigns c ON c.id = a.campaign_id
            WHERE a.zone_id = :zone
              AND a.status = 'active'" . (mp_public_enabled() ? '' : " AND a.target_url NOT LIKE '%marketplace%'") . "
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
            LIMIT 200";
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
        $rows = $stmt->fetchAll();
        if ($rows !== []) {
            // Найточніший збіг (категорія + підкатегорія) має пріоритет; серед рівних — випадковий (без RAND() у SQL).
            $score = static fn(array $r): int => ($r['category_id'] !== null ? 1 : 0) + ($r['subcategory_id'] !== null ? 1 : 0);
            $best = max(array_map($score, $rows));
            $top = array_values(array_filter($rows, static fn(array $r): bool => $score($r) === $best));

            return $top[mt_rand(0, count($top) - 1)];
        }
    }

    return null;
}
