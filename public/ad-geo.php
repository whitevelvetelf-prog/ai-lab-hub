<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Географія показу» відеокампанії (app/ad-geo.php): країни й міста «Включити» / «Виключити»
 * з автопідказкою (geo-suggest.php) і радіусом, режим м'який / суворий.
 *
 *   GET  ?campaign=N            — форма. Доступ: власник платної кампанії або admin (будь-яка відеокампанія, зокрема
 *                                 власна реклама campaign_type='internal').
 *   POST campaign=N, csrf, geo_inc[], geo_inc_r[], geo_exc[], geo_exc_r[], geo_mode — збереження.
 * Зміна географії НЕ змінює статус кампанії й не надсилає її на повторну модерацію (таблиці ad_campaigns не
 * торкається); скидає кеш кандидатів реклами. CSRF — promo_csrf_verify().
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/promo-admin.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/ad-geo.php';

$userId = auth_user_id();
if ($userId === null) {
    header('Location: login.php');
    exit;
}
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
if (!adgeo_ready($pdo) || !mpg_ready($pdo)) {
    mp_not_found();
}
header('X-Robots-Tag: noindex');
$lang = current_lang();
$isAdmin = promo_is_admin($pdo, $userId);
$raw = $_POST['campaign'] ?? $_GET['campaign'] ?? '';
$cid = is_string($raw) && ctype_digit($raw) && strlen($raw) <= 10 ? (int) $raw : 0;
$st = $pdo->prepare("SELECT id, user_id, name, status, campaign_type FROM ad_campaigns WHERE id = :id AND format = 'video'");
$st->execute([':id' => $cid]);
$campaign = $st->fetch(PDO::FETCH_ASSOC) ?: null;
if ($campaign === null || (!$isAdmin && ((int) $campaign['user_id'] !== $userId || $campaign['campaign_type'] !== 'paid'))) {
    mp_not_found();
}
$backUrl = $campaign['campaign_type'] === 'internal' ? 'account.php?padm_tab=house#acc-promo-admin'
    : ((int) $campaign['user_id'] === $userId ? 'account.php?promo_tab=campaigns#acc-promo' : 'account.php?padm_tab=campaigns#acc-promo-admin');
$self = 'ad-geo.php?campaign=' . $cid;

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!promo_csrf_verify()) {
        mpb_flash('error', t('mpb_err_csrf'));
        mpb_redirect($self);
    }
    $in = adgeo_from_post($pdo, $_POST);
    $ok = adgeo_save($pdo, $cid, $in['include'], $in['exclude'], $in['mode']);
    foreach ($in['errors'] as $err) {
        mpb_flash('error', t($err));
    }
    mpb_flash($ok ? 'ok' : 'error', t($ok ? 'adgeo_saved' : 'adgeo_err_save'));
    mpb_redirect($self);
}

$name = (string) ($campaign['name'] ?: '#' . $cid);
mpb_open(sprintf(t('adgeo_page_title'), $name), true, null);
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= mp_e(sprintf(t('adgeo_page_title'), $name)) ?></h1>
        <p class="mp-subtitle"><?= mp_e(t('adgeo_page_note')) ?></p>
        <?= mpb_flash_html() ?>
        <p class="mp-text"><?= mp_e(t('adgeo_col')) ?>: <strong><?= mp_e(adgeo_summary($pdo, $cid, $lang)) ?></strong></p>
        <form class="mp-form" method="post" action="ad-geo.php">
            <?= promo_csrf_field() ?>
            <input type="hidden" name="campaign" value="<?= $cid ?>">
            <?= adgeo_form_html($pdo, $cid, $lang) ?>
            <div class="geo-loc-actions">
                <button class="mp-btn mp-btn--primary" type="submit"><?= mp_e(t('adgeo_save')) ?></button>
                <a class="mp-btn" href="<?= mp_e($backUrl) ?>"><?= mp_e(t('geo_back')) ?></a>
            </div>
        </form>
    </div>
<?php mpb_close(); ?>
