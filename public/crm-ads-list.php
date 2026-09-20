<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM: список рекламних кампаній (ad server).
 *
 * Доступ лише для admin. Колонки: статус, тип, рекламодавець, дати,
 * сума оплати (для внутрішніх — «—»), покази, кліки (сума по всіх
 * оголошеннях кампанії), «Редагувати».
 * Форми: crm-add-campaign.php, crm-edit-campaign.php.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/crm-ads.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

crm_ads_require_admin();

// Покази/кліки — підзапитами з JOIN по campaign_id (так рядки кампанії
// не множаться, коли в неї кілька оголошень).
$campaigns = $pdo->query(
    "SELECT
        c.id,
        c.campaign_type,
        c.advertiser_name,
        c.status,
        c.start_date,
        c.end_date,
        c.paid_amount,
        (SELECT COUNT(*) FROM ads a WHERE a.campaign_id = c.id) AS ads_count,
        (SELECT COUNT(*) FROM ad_impressions i
           JOIN ads a ON a.id = i.ad_id
          WHERE a.campaign_id = c.id) AS impressions,
        (SELECT COUNT(*) FROM ad_clicks k
           JOIN ads a ON a.id = k.ad_id
          WHERE a.campaign_id = c.id) AS clicks
     FROM ad_campaigns c
     ORDER BY c.id DESC"
)->fetchAll();

$totalImpressions = 0;
$totalClicks = 0;
$counts = ['active' => 0, 'paused' => 0, 'expired' => 0];
foreach ($campaigns as $row) {
    $totalImpressions += (int) $row['impressions'];
    $totalClicks += (int) $row['clicks'];
    $counts[crm_ads_effective_status($row)]++;
}

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — CRM: рекламні кампанії</title>
    <link rel="stylesheet" href="/assets/css/crm-ads.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="/logo.png" alt="AI LAB HUB">
        </a>
    </header>

    <div class="page">
        <a class="back-link" href="account.php">← До кабінету</a>

        <h1 class="page__title">CRM — реклама</h1>
        <p class="page__subtitle">Рекламні кампанії ad server: платні мають пріоритет над внутрішніми.</p>

        <div class="toolbar">
            <a class="btn btn--primary btn--sm" href="crm-add-campaign.php">+ Додати кампанію</a>
        </div>

        <div class="summary">
            <span>Кампаній: <strong><?= count($campaigns) ?></strong></span>
            <span>Активних: <strong><?= (int) $counts['active'] ?></strong></span>
            <span>На паузі: <strong><?= (int) $counts['paused'] ?></strong></span>
            <span>Завершених: <strong><?= (int) $counts['expired'] ?></strong></span>
            <span>Показів: <strong><?= number_format($totalImpressions, 0, '', ' ') ?></strong></span>
            <span>Кліків: <strong><?= number_format($totalClicks, 0, '', ' ') ?></strong></span>
        </div>

        <div class="table-wrap">
            <table class="table">
                <thead>
                    <tr>
                        <th>Статус</th>
                        <th>Тип</th>
                        <th>Рекламодавець</th>
                        <th>Дата початку</th>
                        <th>Дата завершення</th>
                        <th class="table__num">Сума оплати</th>
                        <th class="table__num">Показів</th>
                        <th class="table__num">Кліків</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <?php if ($campaigns === []): ?>
                        <tr>
                            <td class="empty-state" colspan="9">
                                Ще немає жодної кампанії.
                                <a href="crm-add-campaign.php">Додати першу</a>.
                            </td>
                        </tr>
                    <?php else: ?>
                        <?php foreach ($campaigns as $row): ?>
                            <?php
                            $cid = (int) $row['id'];
                            $effective = crm_ads_effective_status($row);
                            $isInternal = $row['campaign_type'] === 'internal';
                            ?>
                            <tr>
                                <td>
                                    <span class="badge badge--<?= crm_ads_e($effective) ?>"<?= $effective === 'expired' && $row['status'] === 'active' ? ' title="Дата завершення минула — кампанія більше не показується"' : '' ?>><?= crm_ads_e(crm_ads_status_label($effective)) ?></span>
                                </td>
                                <td>
                                    <span class="badge badge--<?= crm_ads_e($row['campaign_type']) ?>"><?= crm_ads_e(crm_ads_type_label((string) $row['campaign_type'])) ?></span>
                                </td>
                                <td class="table__nowrap">
                                    <a class="table__name" href="crm-edit-campaign.php?id=<?= $cid ?>"><?= crm_ads_e($row['advertiser_name']) ?></a>
                                    <span class="table__id">#<?= $cid ?></span>
                                    <br>
                                    <span class="table__muted">оголошень: <?= (int) $row['ads_count'] ?></span>
                                </td>
                                <td class="table__nowrap"><?= crm_ads_e(crm_ads_date_cell($row['start_date'])) ?></td>
                                <td class="table__nowrap"><?= crm_ads_e(crm_ads_date_cell($row['end_date'])) ?></td>
                                <td class="table__num table__nowrap">
                                    <?php if ($isInternal || $row['paid_amount'] === null): ?>
                                        <span class="table__muted">—</span>
                                    <?php else: ?>
                                        <?= crm_ads_e(number_format((float) $row['paid_amount'], 2, '.', ' ')) ?>
                                    <?php endif; ?>
                                </td>
                                <td class="table__num"><?= number_format((int) $row['impressions'], 0, '', ' ') ?></td>
                                <td class="table__num"><?= number_format((int) $row['clicks'], 0, '', ' ') ?></td>
                                <td class="table__nowrap">
                                    <a class="btn btn--ghost btn--sm" href="crm-edit-campaign.php?id=<?= $cid ?>">Редагувати</a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
