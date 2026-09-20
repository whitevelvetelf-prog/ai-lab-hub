<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM: редагування рекламної кампанії (ad server).
 *
 * Лише admin. Дві частини на одній сторінці (за аналогією з CRM продуктів
 * — форма + обробник POST у тому ж файлі):
 *   1. Поля кампанії (action=save_campaign).
 *   2. Оголошення кампанії: список із показами/кліками, вмикання/вимкнення
 *      (action=toggle_ad) і форма додавання (action=add_ad): зона,
 *      зображення (файл або URL), посилання, категорія/підкатегорія.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/crm-ads.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

crm_ads_require_admin();

$campaignId = (int) ($_GET['id'] ?? 0);

$campStmt = $pdo->prepare('SELECT * FROM ad_campaigns WHERE id = :id');
$campStmt->execute([':id' => $campaignId]);
$campaign = $campStmt->fetch();

if ($campaign === false) {
    header('Location: crm-ads-list.php');
    exit;
}

$zones = $pdo->query('SELECT id, name, page_type FROM ad_zones ORDER BY id')->fetchAll();
$zoneIds = array_map(static fn(array $z): int => (int) $z['id'], $zones);

$categories = $pdo->query('SELECT id, name FROM categories ORDER BY id')->fetchAll();
$subsByCategory = [];
foreach ($pdo->query('SELECT id, category_id, name FROM subcategories ORDER BY id')->fetchAll() as $s) {
    $subsByCategory[(int) $s['category_id']][] = $s;
}

$campaignErrors = [];
$adErrors = [];
$campaignValues = $campaign;
$adValues = ['zone_id' => $zones[0]['id'] ?? '', 'scope' => ''];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = (string) ($_POST['action'] ?? '');

    if ($action === 'save_campaign') {
        $campaignValues = $_POST;
        [$campaignErrors, $data] = crm_ads_parse_campaign($_POST, true);

        if ($campaignErrors === []) {
            try {
                $upd = $pdo->prepare(
                    "UPDATE ad_campaigns SET
                        campaign_type = :campaign_type, advertiser_name = :advertiser_name,
                        contact_email = :contact_email, payment_type = :payment_type,
                        paid_amount = :paid_amount, status = :status, start_date = :start_date,
                        end_date = :end_date, notes = :notes
                     WHERE id = :id"
                );
                $upd->execute([
                    ':campaign_type'   => $data['campaign_type'],
                    ':advertiser_name' => $data['advertiser_name'],
                    ':contact_email'   => $data['contact_email'],
                    ':payment_type'    => $data['payment_type'],
                    ':paid_amount'     => $data['paid_amount'],
                    ':status'          => $data['status'],
                    ':start_date'      => $data['start_date'],
                    ':end_date'        => $data['end_date'],
                    ':notes'           => $data['notes'],
                    ':id'              => $campaignId,
                ]);
                header('Location: crm-edit-campaign.php?id=' . $campaignId . '&saved=1');
                exit;
            } catch (Throwable $ex) {
                error_log('[crm-ads] ' . $ex->getMessage());
                $campaignErrors[] = 'Помилка збереження: ' . $ex->getMessage();
            }
        }
    } elseif ($action === 'toggle_ad') {
        $adId = (int) ($_POST['ad_id'] ?? 0);
        $pdo->prepare(
            "UPDATE ads SET status = IF(status = 'active', 'inactive', 'active')
             WHERE id = :id AND campaign_id = :cid"
        )->execute([':id' => $adId, ':cid' => $campaignId]);
        header('Location: crm-edit-campaign.php?id=' . $campaignId . '#ads');
        exit;
    } elseif ($action === 'add_ad') {
        $adValues = $_POST;

        $zoneId = (int) ($_POST['zone_id'] ?? 0);
        if (!in_array($zoneId, $zoneIds, true)) {
            $adErrors[] = 'Оберіть зону показу.';
        }

        $targetUrl = trim((string) ($_POST['target_url'] ?? ''));
        if (!crm_ads_is_safe_url($targetUrl)) {
            $adErrors[] = 'Посилання оголошення має починатись з http:// або https:// (або бути відносним шляхом).';
        }

        // Текст банера (необов'язковий): показується поверх зображення і
        // перекладається автоматично (ad_translations).
        $headline = trim((string) ($_POST['headline'] ?? ''));
        $subtext = trim((string) ($_POST['subtext'] ?? ''));
        if (mb_strlen($headline) > 255) {
            $adErrors[] = 'Заголовок задовгий (максимум 255 символів).';
        }
        if (mb_strlen($subtext) > 500) {
            $adErrors[] = 'Підпис задовгий (максимум 500 символів).';
        }

        // Категорія / підкатегорія: "" — усі, "c:ID" — категорія, "s:ID" — підкатегорія.
        $categoryId = null;
        $subcategoryId = null;
        $scope = (string) ($_POST['scope'] ?? '');
        if (preg_match('/^([cs]):(\d+)$/', $scope, $m) === 1) {
            if ($m[1] === 'c') {
                $chk = $pdo->prepare('SELECT id FROM categories WHERE id = :id');
                $chk->execute([':id' => (int) $m[2]]);
                if ($chk->fetchColumn() === false) {
                    $adErrors[] = 'Обрана категорія не існує.';
                } else {
                    $categoryId = (int) $m[2];
                }
            } else {
                $chk = $pdo->prepare('SELECT category_id FROM subcategories WHERE id = :id');
                $chk->execute([':id' => (int) $m[2]]);
                $parent = $chk->fetchColumn();
                if ($parent === false) {
                    $adErrors[] = 'Обрана підкатегорія не існує.';
                } else {
                    $categoryId = (int) $parent;
                    $subcategoryId = (int) $m[2];
                }
            }
        }

        // Зображення: завантажений файл має пріоритет над URL. Файл на диск
        // пишемо лише коли решта полів валідна (інакше лишились би «сироти»).
        $imageUrl = $adErrors === [] ? crm_ads_store_image($_FILES['image_file'] ?? [], $adErrors) : null;
        if ($imageUrl === null && $adErrors === []) {
            $typedUrl = trim((string) ($_POST['image_url'] ?? ''));
            if ($typedUrl !== '') {
                if (crm_ads_is_safe_url($typedUrl)) {
                    $imageUrl = $typedUrl;
                } else {
                    $adErrors[] = 'URL зображення має починатись з http:// або https:// (або бути відносним шляхом).';
                }
            } elseif ($adErrors === []) {
                $adErrors[] = 'Завантажте зображення або вкажіть його URL.';
            }
        }

        if ($adErrors === [] && $imageUrl !== null) {
            try {
                $ins = $pdo->prepare(
                    "INSERT INTO ads (campaign_id, zone_id, image_url, target_url, headline, subtext, category_id, subcategory_id, status)
                     VALUES (:cid, :zone, :image, :target, :headline, :subtext, :cat, :sub, 'active')"
                );
                $ins->execute([
                    ':cid'      => $campaignId,
                    ':zone'     => $zoneId,
                    ':image'    => $imageUrl,
                    ':target'   => $targetUrl,
                    ':headline' => $headline !== '' ? $headline : null,
                    ':subtext'  => $subtext !== '' ? $subtext : null,
                    ':cat'    => $categoryId,
                    ':sub'    => $subcategoryId,
                ]);
                header('Location: crm-edit-campaign.php?id=' . $campaignId . '&ad_added=1#ads');
                exit;
            } catch (Throwable $ex) {
                error_log('[crm-ads] ' . $ex->getMessage());
                $adErrors[] = 'Помилка збереження: ' . $ex->getMessage();
            }
        }
    }
}

// Оголошення кампанії з показами/кліками (підзапити — без множення рядків).
$adsStmt = $pdo->prepare(
    "SELECT a.id, a.image_url, a.target_url, a.headline, a.subtext, a.status, a.category_id, a.subcategory_id,
            z.name AS zone_name, c.name AS category_name, s.name AS subcategory_name,
            (SELECT COUNT(*) FROM ad_impressions i WHERE i.ad_id = a.id) AS impressions,
            (SELECT COUNT(*) FROM ad_clicks k WHERE k.ad_id = a.id) AS clicks
     FROM ads a
     JOIN ad_zones z ON z.id = a.zone_id
     LEFT JOIN categories c ON c.id = a.category_id
     LEFT JOIN subcategories s ON s.id = a.subcategory_id
     WHERE a.campaign_id = :cid
     ORDER BY a.id DESC"
);
$adsStmt->execute([':cid' => $campaignId]);
$ads = $adsStmt->fetchAll();

$flashCreated = isset($_GET['created']);
$flashSaved = isset($_GET['saved']);
$flashAdAdded = isset($_GET['ad_added']);

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — CRM: кампанія «<?= crm_ads_e($campaign['advertiser_name']) ?>»</title>
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

        <h1 class="page__title">Кампанія «<?= crm_ads_e($campaign['advertiser_name']) ?>» <span class="table__id">#<?= $campaignId ?></span></h1>
        <p class="page__subtitle">
            <?= crm_ads_e(crm_ads_type_label((string) $campaign['campaign_type'])) ?> ·
            <?= crm_ads_e(crm_ads_status_label(crm_ads_effective_status($campaign))) ?>
        </p>

        <?php if ($flashCreated): ?>
            <div class="notice notice--success"><p>Кампанію створено. Додайте до неї оголошення нижче — без оголошень вона нічого не показує.</p></div>
        <?php elseif ($flashSaved): ?>
            <div class="notice notice--success"><p>Зміни кампанії збережено.</p></div>
        <?php endif; ?>

        <?php if ($campaignErrors !== []): ?>
            <div class="notice notice--error">
                <p class="notice__title">Виправте помилки:</p>
                <ul>
                    <?php foreach ($campaignErrors as $error): ?>
                        <li><?= crm_ads_e($error) ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <form class="form" method="post" action="crm-edit-campaign.php?id=<?= $campaignId ?>">
            <input type="hidden" name="action" value="save_campaign">
            <?php crm_ads_campaign_fields($campaignValues, true); ?>

            <div class="form-actions">
                <button type="submit" class="btn btn--primary">Зберегти кампанію</button>
                <a class="btn btn--ghost" href="crm-ads-list.php">До списку</a>
            </div>
        </form>

        <h2 class="section-title" id="ads">Оголошення кампанії</h2>

        <?php if ($flashAdAdded): ?>
            <div class="notice notice--success"><p>Оголошення додано.</p></div>
        <?php endif; ?>

        <div class="table-wrap">
            <table class="table" style="min-width: 600px;">
                <thead>
                    <tr>
                        <th>Банер</th>
                        <th>Зона · де показується</th>
                        <th>Статус</th>
                        <th class="table__num">Показів</th>
                        <th class="table__num">Кліків</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <?php if ($ads === []): ?>
                        <tr><td class="empty-state" colspan="6">У цієї кампанії ще немає оголошень.</td></tr>
                    <?php else: ?>
                        <?php foreach ($ads as $ad): ?>
                            <?php
                            $where = $ad['subcategory_name'] !== null
                                ? $ad['category_name'] . ' → ' . $ad['subcategory_name']
                                : ($ad['category_name'] !== null ? 'Категорія: ' . $ad['category_name'] : 'Усі сторінки зони');
                            ?>
                            <tr>
                                <td>
                                    <a href="<?= crm_ads_e($ad['target_url']) ?>" target="_blank" rel="noopener noreferrer" title="<?= crm_ads_e($ad['target_url']) ?>">
                                        <img class="table__thumb" src="<?= crm_ads_e($ad['image_url']) ?>" alt="">
                                    </a>
                                    <?php if ((string) $ad['headline'] !== ''): ?>
                                        <span class="table__muted" title="<?= crm_ads_e($ad['subtext']) ?>"><?= crm_ads_e($ad['headline']) ?></span>
                                    <?php endif; ?>
                                </td>
                                <td>
                                    <?= crm_ads_e($ad['zone_name']) ?><br>
                                    <span class="table__muted"><?= crm_ads_e($where) ?></span>
                                </td>
                                <td><span class="badge badge--<?= crm_ads_e($ad['status']) ?>"><?= $ad['status'] === 'active' ? 'Активне' : 'Вимкнене' ?></span></td>
                                <td class="table__num"><?= number_format((int) $ad['impressions'], 0, '', ' ') ?></td>
                                <td class="table__num"><?= number_format((int) $ad['clicks'], 0, '', ' ') ?></td>
                                <td class="table__nowrap">
                                    <form method="post" action="crm-edit-campaign.php?id=<?= $campaignId ?>" style="margin:0;">
                                        <input type="hidden" name="action" value="toggle_ad">
                                        <input type="hidden" name="ad_id" value="<?= (int) $ad['id'] ?>">
                                        <button type="submit" class="btn btn--ghost btn--sm"><?= $ad['status'] === 'active' ? 'Вимкнути' : 'Увімкнути' ?></button>
                                    </form>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>

        <h2 class="section-title">Додати оголошення</h2>

        <?php if ($adErrors !== []): ?>
            <div class="notice notice--error">
                <p class="notice__title">Виправте помилки:</p>
                <ul>
                    <?php foreach ($adErrors as $error): ?>
                        <li><?= crm_ads_e($error) ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <?php if ($zones === []): ?>
            <div class="notice"><p>Немає жодної зони показу (таблиця ad_zones порожня) — спершу застосуйте database/increment_latest.sql.</p></div>
        <?php else: ?>
        <form class="form" method="post" enctype="multipart/form-data" action="crm-edit-campaign.php?id=<?= $campaignId ?>">
            <input type="hidden" name="action" value="add_ad">

            <div class="field">
                <label class="field__label" for="zone_id">Зона показу <span class="req">*</span></label>
                <select class="select" id="zone_id" name="zone_id">
                    <?php foreach ($zones as $z): ?>
                        <option value="<?= (int) $z['id'] ?>"<?= (int) ($adValues['zone_id'] ?? 0) === (int) $z['id'] ? ' selected' : '' ?>><?= crm_ads_e($z['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="field">
                <label class="field__label" for="scope">Категорія / підкатегорія</label>
                <select class="select" id="scope" name="scope">
                    <option value="">Усі сторінки зони (без прив'язки)</option>
                    <?php foreach ($categories as $cat): ?>
                        <optgroup label="<?= crm_ads_e($cat['name']) ?>">
                            <option value="c:<?= (int) $cat['id'] ?>"<?= ($adValues['scope'] ?? '') === 'c:' . $cat['id'] ? ' selected' : '' ?>>Уся категорія «<?= crm_ads_e($cat['name']) ?>»</option>
                            <?php foreach ($subsByCategory[(int) $cat['id']] ?? [] as $sub): ?>
                                <option value="s:<?= (int) $sub['id'] ?>"<?= ($adValues['scope'] ?? '') === 's:' . $sub['id'] ? ' selected' : '' ?>>— <?= crm_ads_e($sub['name']) ?></option>
                            <?php endforeach; ?>
                        </optgroup>
                    <?php endforeach; ?>
                </select>
                <p class="field__hint">Оголошення з прив'язкою має пріоритет над універсальним на відповідній сторінці.</p>
            </div>

            <div class="field">
                <label class="field__label" for="image_file">Зображення банера <span class="req">*</span></label>
                <input class="input" type="file" id="image_file" name="image_file" accept=".png,.jpg,.jpeg,.webp,.gif,.svg">
                <p class="field__hint">PNG, JPG, WEBP, GIF або SVG до 2 МБ. Це фон банера (без тексту всередині) — текст додається полями «Заголовок» і «Підпис». Рекомендований формат — широкий банер (напр. 970×150).</p>
            </div>

            <div class="field">
                <label class="field__label" for="image_url">…або URL зображення</label>
                <input class="input" type="text" id="image_url" name="image_url" maxlength="500" value="<?= crm_ads_e($adValues['image_url'] ?? '') ?>" placeholder="https://…">
                <p class="field__hint">Використовується, лише якщо файл не обрано.</p>
            </div>

            <div class="field">
                <label class="field__label" for="headline">Заголовок</label>
                <input class="input" type="text" id="headline" name="headline" maxlength="255" value="<?= crm_ads_e($adValues['headline'] ?? '') ?>">
                <p class="field__hint">Виводиться текстом поверх зображення і перекладається на EN автоматично. Порожньо — банер покаже лише картинку.</p>
            </div>

            <div class="field">
                <label class="field__label" for="subtext">Підпис</label>
                <input class="input" type="text" id="subtext" name="subtext" maxlength="500" value="<?= crm_ads_e($adValues['subtext'] ?? '') ?>">
            </div>

            <div class="field">
                <label class="field__label" for="target_url">Посилання (куди веде клік) <span class="req">*</span></label>
                <input class="input" type="text" id="target_url" name="target_url" maxlength="500" value="<?= crm_ads_e($adValues['target_url'] ?? '') ?>" placeholder="https://…" required>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn--primary">Додати оголошення</button>
            </div>
        </form>
        <?php endif; ?>
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
