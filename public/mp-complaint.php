<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: скарга на оголошення (розділи 10–11 Правил).
 *
 * GET ?id=N — окрема сторінка з формою (запасний варіант; зазвичай форма вбудована в сторінку оголошення).
 * POST (CSRF, multipart) — подання: від зареєстрованого користувача або гостя з обов'язковим email.
 * «Порушення авторських прав» вимагає поля п. 10.1 (ім'я/організація, контакти, що порушено, посилання або файл
 * доказів, підтвердження добросовісності). Ліміт — 10 скарг на добу з акаунта чи IP. Помилки → форма зі значеннями.
 * Логіка — mpl_complaint_submit() (app/mp-legal.php).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-legal-ui.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$userId = auth_user_id();
$id = (int) ($_REQUEST['id'] ?? 0);
$brief = $id > 0 ? mpl_listing_brief($pdo, $id) : null;
$backUrl = $brief !== null ? mpl_listing_url($brief) : 'marketplace.php';
$values = [];
$errors = [];

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if ($_POST === [] && (int) ($_SERVER['CONTENT_LENGTH'] ?? 0) > 0) {
        $errors = ['c_err_cr_file'];   // перевищено post_max_size
    } else {
        mpb_require_post();   // CSRF
        if ((string) ($_POST['website'] ?? '') !== '') {
            mpb_message_page(400, t('mpb_err_generic_title'), '<p class="mp-text">' . mp_e(t('mpb_err_spam')) . '</p>', 'marketplace.php');
        }
        $values = array_map(static fn($x): string => is_string($x) ? $x : '', $_POST);
        $res = mpl_complaint_submit($pdo, $_POST, is_array($_FILES['evidence_file'] ?? null) ? $_FILES['evidence_file'] : null, $userId);
        if ($res['status'] === 'ok') {
            $msg = ($values['reason'] ?? '') === 'copyright' ? mpl_tr('c_ok', (int) MP_IP_REVIEW_DAYS) : mpl_tr('c_ok_simple');
            mpb_flash('ok', $msg);
            mpb_redirect(preg_match('~^[A-Za-z0-9_\-]+\.php\?[A-Za-z0-9_=&%\-\.]*$~', $backUrl) === 1 ? $backUrl : 'marketplace.php');
        }
        $errors = $res['errors'];
        if (in_array($res['status'], ['notfound', 'own'], true)) {
            mpb_message_page(404, mpl_tr('c_title'), '<p class="mp-text">' . mp_e(mpl_tr($errors[0] ?? 'c_err_notfound')) . '</p>', 'marketplace.php');
        }
        http_response_code(422);
    }
}

if ($brief === null || (string) $brief['status'] !== 'published') {
    mp_not_found();
}

mpb_open(mpl_tr('c_title'), true, '');
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= mp_e(mpl_tr('c_title')) ?></h1>
        <p class="mp-text"><a href="<?= mp_e($backUrl) ?>"><?= mp_e((string) $brief['title']) ?></a></p>
        <?= mpl_complaint_form_html($id, $userId, $values, $errors, true) ?>
    </div>
<?php mpb_close(); ?>
