<?php

declare(strict_types=1);

/**
 * AI LAB HUB — зустрічна заява автора на скаргу про порушення авторських прав.
 *
 *   copyright-counter.php?id=N   (N — номер скарги; лише власник оголошення, до строку counter_deadline)
 *
 * Після подачі статус скарги — counter_notice; рішення ухвалює адміністратор (ast_claim_decide), листи — обом.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/asset.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$userId = mpb_require_login();
$id = (int) ($_GET['id'] ?? $_POST['id'] ?? 0);
$claim = $id > 0 ? ast_claim($pdo, $id) : null;
if ($claim === null || (int) $claim['owner_user_id'] !== $userId) {
    mp_not_found();
}
$open = $claim['counter_at'] === null && in_array((string) $claim['status'], ['new', 'under_review', 'content_disabled'], true)
    && ($claim['counter_deadline'] === null || strtotime((string) $claim['counter_deadline']) >= time());
$done = false;
$error = null;
$text = '';
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST' && $open) {
    $text = is_string($_POST['text'] ?? null) ? mb_substr(trim(strip_tags((string) $_POST['text'])), 0, 5000) : '';
    if (!mp_csrf_verify()) {
        $error = t('mpb_err_csrf');
    } elseif (mb_strlen($text) < 20) {
        $error = ast_tr('claim_err');
    } elseif (ast_claim_counter($pdo, $id, $userId, $text)) {
        $done = true;
    } else {
        $error = ast_tr('counter_closed');
    }
}
$deadline = $claim['counter_deadline'] !== null ? date('d.m.Y', (int) strtotime((string) $claim['counter_deadline'])) : '—';
ast_open(ast_tr('counter_title'), '<meta name="robots" content="noindex, nofollow">', '');
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= ast_e(ast_tr('counter_title')) ?> — №<?= $id ?></h1>
        <dl class="mp-facts">
            <div class="mp-fact"><dt class="mp-fact__label"><?= ast_e(ast_tr('my_col_asset')) ?></dt><dd class="mp-fact__value"><a href="asset.php?id=<?= (int) $claim['listing_id'] ?>"><?= ast_e($claim['title'] ?? $claim['listing_ref']) ?></a></dd></div>
            <div class="mp-fact"><dt class="mp-fact__label"><?= ast_e(ast_tr('my_col_status')) ?></dt><dd class="mp-fact__value"><?= ast_e(ast_tr('cst_' . $claim['status'])) ?></dd></div>
        </dl>
        <div class="mp-block"><h2 class="mp-block__title"><?= ast_e(ast_tr('claim_what')) ?></h2><p class="mp-text mp-text--pre"><?= ast_e($claim['what_infringed']) ?></p></div>
        <?php if ($done): ?>
            <div class="mp-alert mp-alert--ok" role="status"><?= ast_e(ast_tr('counter_sent')) ?></div>
        <?php elseif (!$open): ?>
            <div class="mp-alert"><?= ast_e(ast_tr('counter_closed')) ?></div>
        <?php else: ?>
            <?php if ($error !== null): ?><div class="mp-alert mp-alert--error" role="alert"><?= ast_e($error) ?></div><?php endif; ?>
            <form class="mp-form mp-panel" method="post" action="copyright-counter.php">
                <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $id ?>">
                <p class="mp-text"><?= ast_e(ast_tr('counter_intro', $deadline)) ?></p>
                <div class="mp-field"><label class="mp-label" for="ct"><?= ast_e(ast_tr('counter_text')) ?></label>
                    <textarea class="mp-input" id="ct" name="text" rows="8" minlength="20" maxlength="5000" required><?= ast_e($text) ?></textarea></div>
                <p class="mp-actions"><button class="mp-btn mp-btn--primary" type="submit"><?= ast_e(ast_tr('counter_send')) ?></button></p>
            </form>
        <?php endif; ?>
    </div>
<?php mpb_close(); ?>
