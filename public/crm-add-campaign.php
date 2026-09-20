<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM: нова рекламна кампанія (ad server).
 *
 * Лише admin. Тип «Внутрішня»: без суми, email і дати завершення
 * необов'язкові, статус одразу 'active'. Після збереження — перехід на
 * crm-edit-campaign.php, де додаються оголошення (зображення + посилання).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/crm-ads.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

crm_ads_require_admin();

$errors = [];
$values = ['campaign_type' => 'paid', 'start_date' => date('Y-m-d')];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $values = $_POST;
    [$errors, $data] = crm_ads_parse_campaign($_POST, false);

    if ($errors === []) {
        try {
            $stmt = $pdo->prepare(
                "INSERT INTO ad_campaigns
                    (campaign_type, advertiser_name, contact_email, payment_type, paid_amount,
                     status, start_date, end_date, notes)
                 VALUES
                    (:campaign_type, :advertiser_name, :contact_email, :payment_type, :paid_amount,
                     'active', :start_date, :end_date, :notes)"
            );
            $stmt->execute([
                ':campaign_type'   => $data['campaign_type'],
                ':advertiser_name' => $data['advertiser_name'],
                ':contact_email'   => $data['contact_email'],
                ':payment_type'    => $data['payment_type'],
                ':paid_amount'     => $data['paid_amount'],
                ':start_date'      => $data['start_date'],
                ':end_date'        => $data['end_date'],
                ':notes'           => $data['notes'],
            ]);
            header('Location: crm-edit-campaign.php?id=' . (int) $pdo->lastInsertId() . '&created=1');
            exit;
        } catch (Throwable $ex) {
            error_log('[crm-ads] ' . $ex->getMessage());
            $errors[] = 'Помилка збереження: ' . $ex->getMessage();
        }
    }
}

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — CRM: нова рекламна кампанія</title>
    <link rel="stylesheet" href="/assets/css/crm-ads.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="/logo.png" alt="AI LAB HUB">
        </a>
    </header>

    <div class="page page--narrow">
        <a class="back-link" href="crm-ads-list.php">← До кампаній</a>

        <h1 class="page__title">Нова рекламна кампанія</h1>
        <p class="page__subtitle">Спочатку створіть кампанію, потім додайте до неї оголошення.</p>

        <?php if ($errors !== []): ?>
            <div class="notice notice--error">
                <p class="notice__title">Виправте помилки:</p>
                <ul>
                    <?php foreach ($errors as $error): ?>
                        <li><?= crm_ads_e($error) ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <form class="form" method="post" action="crm-add-campaign.php">
            <?php crm_ads_campaign_fields($values, false); ?>

            <div class="form-actions">
                <button type="submit" class="btn btn--primary">Створити кампанію</button>
                <a class="btn btn--ghost" href="crm-ads-list.php">Скасувати</a>
            </div>
        </form>
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
