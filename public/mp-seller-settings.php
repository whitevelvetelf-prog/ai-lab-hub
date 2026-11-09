<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: налаштування сторінки продавця (кабінет), app/mp-seller.php.
 *
 * Короткий опис (до 500 символів, простий текст без контактів), логотип (той самий конвеєр, що фото оголошень: перевірка,
 * GD-перекодування, один файл), сайт (https; на сторінці показується лише перевіреним), перемикач «Показувати мою
 * сторінку» (page_public; вимкнено — сторінка й посилання на неї зникають, оголошення лишаються).
 * Продавець з'являється після першого оголошення. POST — CSRF, PRG.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-seller.php';

mp_public_or_staff_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
header('Cache-Control: no-store');

$userId = mpb_require_login();
if (!mpsl_ready($pdo)) {
    mp_not_found();
}
$seller = mpsl_for_user($pdo, $userId);
$errors = [];

if ($seller !== null && ($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    mpb_require_post();
    $in = [
        'bio' => is_string($_POST['bio'] ?? null) ? mb_substr((string) $_POST['bio'], 0, 2000) : '',
        'website_url' => is_string($_POST['website_url'] ?? null) ? mb_substr((string) $_POST['website_url'], 0, 600) : '',
        'page_public' => ($_POST['page_public'] ?? '') === '1',
        'remove_logo' => ($_POST['remove_logo'] ?? '') === '1',
    ];
    $file = is_array($_FILES['logo'] ?? null) && !is_array($_FILES['logo']['name'] ?? null) ? $_FILES['logo'] : null;
    $errors = mpsl_save($pdo, $seller, $in, $file);
    if ($errors === []) {
        mpb_flash('ok', t('mpsl_saved'));
        mpb_redirect('mp-seller-settings.php');
    }
    $seller = ['bio' => $in['bio'], 'website_url' => $in['website_url'], 'page_public' => $in['page_public'] ? 1 : 0] + $seller;
}

mpb_open(t('mpsl_settings_title'), true, 'home');
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= mp_e(t('mpsl_settings_title')) ?></h1>
        <?= mpb_flash_html() ?>
        <?php if ($seller === null): ?>
            <p class="mp-text"><?= mp_e(t('mpsl_no_seller')) ?></p>
        <?php else: ?>
            <p class="mp-subtitle"><?= mp_e(t('mpsl_settings_lead')) ?>
                <?php if (mpsl_is_public($seller)): ?><a href="mp-seller.php?id=<?= (int) $seller['id'] ?>"><?= mp_e(t('mpsl_view_page')) ?></a><?php endif; ?></p>
            <?php if ($errors !== []): ?>
                <div class="mp-alert mp-alert--error" role="alert"><ul class="mp-alert__list"><?php foreach ($errors as $er): ?><li><?= mp_e(t($er)) ?></li><?php endforeach; ?></ul></div>
            <?php endif; ?>
            <form class="mp-form" method="post" action="mp-seller-settings.php" enctype="multipart/form-data">
                <?= mp_csrf_field() ?>
                <p class="mp-text"><strong><?= mp_e(t('mpsl_name_label')) ?>:</strong> <?= mp_e($seller['display_name']) ?></p>
                <div class="mp-field mp-field--check">
                    <input type="hidden" name="page_public" value="0">
                    <label class="mp-check"><input type="checkbox" name="page_public" value="1"<?= (int) $seller['page_public'] === 1 ? ' checked' : '' ?>> <span><?= mp_e(t('mpsl_f_public')) ?></span></label>
                    <p class="mp-hint"><?= mp_e(t('mpsl_f_public_hint')) ?></p>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="bio"><?= mp_e(t('mpsl_f_bio')) ?></label>
                    <textarea class="mp-input" id="bio" name="bio" rows="5" maxlength="<?= MPSL_BIO_MAX ?>"><?= mp_e($seller['bio'] ?? '') ?></textarea>
                    <p class="mp-hint"><?= mp_e(sprintf(t('mpsl_f_bio_hint'), MPSL_BIO_MAX)) ?></p>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="logo"><?= mp_e(t('mpsl_f_logo')) ?></label>
                    <?php if (($u = mpsl_logo_url($seller['logo'] ?? null)) !== null): ?>
                        <p><img class="mpsl-head__logo" src="<?= mp_e($u) ?>" alt="" width="96" height="96"></p>
                        <label class="mp-check"><input type="checkbox" name="remove_logo" value="1"> <span><?= mp_e(t('mpsl_f_logo_remove')) ?></span></label>
                    <?php endif; ?>
                    <input class="mp-input" type="file" id="logo" name="logo" accept="image/jpeg,image/png,image/webp">
                    <p class="mp-hint"><?= mp_e(t('mpsl_f_logo_hint')) ?></p>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="website_url"><?= mp_e(t('mpsl_f_site')) ?></label>
                    <input class="mp-input" type="url" id="website_url" name="website_url" maxlength="500" inputmode="url" placeholder="https://" value="<?= mp_e($seller['website_url'] ?? '') ?>">
                    <p class="mp-hint"><?= mp_e(t('mpsl_f_site_hint')) ?></p>
                </div>
                <div class="mp-actions">
                    <button class="mp-btn mp-btn--primary" type="submit"><?= mp_e(t('mpg_save_btn')) ?></button>
                    <a class="mp-btn" href="marketplace-my.php"><?= mp_e(t('mpb_my_title')) ?></a>
                </div>
            </form>
        <?php endif; ?>
    </div>
<?php mpb_close(); ?>
