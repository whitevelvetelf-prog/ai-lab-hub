<?php

declare(strict_types=1);

/**
 * AI LAB HUB — публічна форма «Повідомити про порушення авторських прав» (акаунт не потрібен).
 *
 *   copyright-report.php[?listing=N]
 *
 * Поля: посилання/номер оголошення, що саме порушено, докази, ім'я (як підпис), e-mail, інший контакт,
 * чекбокс добросовісності й точності заяви. Захист від спаму: CSRF, honeypot, мінімальний час заповнення,
 * ліміт заяв з одного IP за добу (хеш IP, не сам IP). Скарга на актив + copyright_auto_hide → оголошення
 * тимчасово приховано до розгляду, автору — лист із формою зустрічної заяви (ast_claim_create).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing.php';    // lst_form_stamp
require_once __DIR__ . '/../app/asset.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$v = ['ref' => (int) ($_GET['listing'] ?? 0) > 0 ? '#' . (int) $_GET['listing'] : '', 'what' => '', 'evidence' => '', 'name' => '', 'email' => '', 'contact' => ''];
$error = null;
$sent = null;
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    $str = static fn(string $k, int $max): string => is_string($_POST[$k] ?? null) ? mb_substr(trim(strip_tags((string) $_POST[$k])), 0, $max) : '';
    $v = ['ref' => $str('ref', 500), 'what' => $str('what', 5000), 'evidence' => $str('evidence', 5000), 'name' => $str('name', 150),
        'email' => $str('email', 190), 'contact' => $str('contact', 255)];
    if (!mp_csrf_verify()) {
        $error = t('mpb_err_csrf');
    } elseif ((string) ($_POST['website'] ?? '') !== '' || !lst_form_stamp_ok(is_string($_POST['ft'] ?? null) ? (string) $_POST['ft'] : '')) {
        $error = t('mpb_err_spam');
    } elseif ($v['ref'] === '' || mb_strlen($v['what']) < 20 || mb_strlen($v['name']) < 2
        || filter_var($v['email'], FILTER_VALIDATE_EMAIL) === false || ($_POST['good_faith'] ?? '') !== '1') {
        $error = ast_tr('claim_err');
    } elseif (!mp_is_staff() && !mpb_ip_hit($pdo, 'claim', 10)) {
        $error = ast_tr('rate_limited');
    } else {
        try {
            $sent = ast_claim_create($pdo, $v);
        } catch (Throwable $e) {
            error_log('[asset] claim create: ' . $e->getMessage());
            $error = ast_tr('err_save');
        }
    }
}

ast_open(ast_tr('claim_title'), '<meta name="robots" content="noindex, nofollow">', '');
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= ast_e(ast_tr('claim_title')) ?></h1>
        <p class="mp-subtitle"><?= ast_e(ast_tr('claim_intro')) ?> <a href="copyright-policy.php"><?= ast_e(ast_tr('policy_link')) ?></a></p>
        <?php if ($sent !== null): ?>
            <div class="mp-alert mp-alert--ok" role="status"><?= ast_e(ast_tr('claim_sent', $sent)) ?></div>
        <?php else: ?>
            <?php if ($error !== null): ?><div class="mp-alert mp-alert--error" role="alert"><?= ast_e($error) ?></div><?php endif; ?>
            <form class="mp-form mp-panel" method="post" action="copyright-report.php">
                <?= mp_csrf_field() ?>
                <input type="hidden" name="ft" value="<?= ast_e(lst_form_stamp()) ?>">
                <div class="mp-hp" aria-hidden="true"><label>Website <input type="text" name="website" tabindex="-1" autocomplete="off"></label></div>
                <div class="mp-field"><label class="mp-label" for="c_ref"><?= ast_e(ast_tr('claim_listing')) ?></label>
                    <input class="mp-input" type="text" id="c_ref" name="ref" maxlength="500" required value="<?= ast_e($v['ref']) ?>"></div>
                <div class="mp-field"><label class="mp-label" for="c_what"><?= ast_e(ast_tr('claim_what')) ?></label>
                    <textarea class="mp-input" id="c_what" name="what" rows="5" minlength="20" maxlength="5000" required><?= ast_e($v['what']) ?></textarea></div>
                <div class="mp-field"><label class="mp-label" for="c_ev"><?= ast_e(ast_tr('claim_evidence')) ?></label>
                    <textarea class="mp-input" id="c_ev" name="evidence" rows="4" maxlength="5000"><?= ast_e($v['evidence']) ?></textarea></div>
                <div class="mp-field"><label class="mp-label" for="c_name"><?= ast_e(ast_tr('claim_name')) ?></label>
                    <input class="mp-input" type="text" id="c_name" name="name" maxlength="150" required autocomplete="name" value="<?= ast_e($v['name']) ?>"></div>
                <div class="mp-field"><label class="mp-label" for="c_email"><?= ast_e(ast_tr('claim_email')) ?></label>
                    <input class="mp-input" type="email" id="c_email" name="email" maxlength="190" required autocomplete="email" value="<?= ast_e($v['email']) ?>"></div>
                <div class="mp-field"><label class="mp-label" for="c_contact"><?= ast_e(ast_tr('claim_contact')) ?></label>
                    <input class="mp-input" type="text" id="c_contact" name="contact" maxlength="255" value="<?= ast_e($v['contact']) ?>"></div>
                <label class="mp-check"><input type="checkbox" name="good_faith" value="1" required> <span><?= ast_e(ast_tr('claim_good_faith')) ?></span></label>
                <p class="mp-actions"><button class="mp-btn mp-btn--primary" type="submit"><?= ast_e(ast_tr('claim_send')) ?></button></p>
            </form>
        <?php endif; ?>
    </div>
<?php mpb_close(); ?>
