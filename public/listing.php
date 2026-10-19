<?php

declare(strict_types=1);

/**
 * AI LAB HUB — сторінка оголошення компанії: вакансія, курс або послуга (блок M1).
 *
 *   listing.php?id=N[&s=slug]   — ідентифікатор — id; slug лише для читабельності (невідповідний → 301 на канонічну адресу).
 *
 * Видимість: опубліковане й не прострочене — усім (коли розділ показано); інші статуси — лише власнику й
 * співробітникам (попередній перегляд, noindex). Прострочене — 410 + noindex, без розмітки й кнопки переходу.
 * Кнопка «Перейти» веде через listing-go.php (облік переходів). JSON-LD JobPosting / Course — лише з повними даними.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing.php';

mp_public_or_staff_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$id = (int) ($_GET['id'] ?? 0);
$lang = current_lang();
$row = $id > 0 ? lst_listing($pdo, $id, $lang) : null;
if ($row === null) {
    mp_not_found();
}
$uid = auth_user_id();
$isOwner = $uid !== null && $row['seller_user_id'] !== null && (int) $row['seller_user_id'] === $uid;
$isStaff = mp_is_staff();
$live = (int) $row['is_live'] === 1;
$expired = in_array((string) $row['status'], ['expired', 'published'], true) && !$live;
if (!$live && !$expired && !$isOwner && !$isStaff) {
    mp_not_found();
}
// Канонічна адреса з актуальним slug.
$slug = is_string($_GET['s'] ?? null) ? (string) $_GET['s'] : '';
if ($live && (string) $row['slug'] !== '' && $slug !== (string) $row['slug'] && ($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'GET') {
    header('Location: ' . lst_url($row), true, 301);
    exit;
}

if ($live) {
    lst_count_view($pdo, $id, $row['seller_user_id'] !== null ? (int) $row['seller_user_id'] : null);
} elseif ($expired) {
    http_response_code(410);
}

$ld = lst_jsonld($row);
$type = (string) $row['section'];
$facts = lst_facts($row);
$autoText = (int) $row['text_is_auto'] === 1;
$textLangAttr = (string) $row['text_lang'] !== $lang ? ' lang="' . lst_e($row['text_lang']) . '"' : '';
$freeLabel = $live && !empty($row['free_until']) && (string) $row['free_until'] >= date('Y-m-d') ? lst_tr('free_until', lst_date((string) $row['free_until'])) : '';
$host = lst_host((string) $row['delivery_url']);
$reportMsg = $_SESSION['lst_report_msg'] ?? null;
unset($_SESSION['lst_report_msg']);

// Індексуються лише живі оголошення, коли розділ показано відвідувачам.
$head = '<link rel="canonical" href="' . lst_e(lst_site_url() . '/' . lst_url($row)) . '">';
if ($ld !== null) {
    $head .= "
" . '<script type="application/ld+json">' . json_encode($ld, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_HEX_TAG) . '</script>';
}
lst_open((string) $row['title'], !($live && mp_public_enabled()), $head, 'lst_' . $type);
?>
    <div class="mp-page mp-page--narrow">
        <p><a class="mp-back" href="listings.php?type=<?= lst_e($type) ?>"><?= lst_e(lst_tr('back_list')) ?></a></p>
        <?= mpb_flash_html() ?>
        <?php if (!$live && !$expired): ?>
            <div class="mp-alert"><?= lst_e(lst_tr('preview_notice', lst_tr('st_' . $row['status']))) ?></div>
            <?php if ((string) $row['status'] === 'rejected' && !empty($row['reject_reason'])): ?>
                <div class="mp-alert mp-alert--error"><strong><?= lst_e(lst_tr('reject_reason')) ?>:</strong> <?= lst_e($row['reject_reason']) ?></div>
            <?php endif; ?>
        <?php elseif ($expired): ?>
            <div class="mp-alert mp-alert--error"><?= lst_e(lst_tr('expired_notice')) ?></div>
        <?php endif; ?>

        <article class="mp-panel lst-item">
            <p class="mp-card__tag"><?= lst_e(lst_tr('type1_' . $type)) ?> · <?= lst_e($row['company_name']) ?></p>
            <h1 class="mp-title"<?= $textLangAttr ?>><?= lst_e($row['title']) ?></h1>
            <?php if (!empty($row['short_desc'])): ?><p class="mp-offer__lead"<?= $textLangAttr ?>><?= lst_e($row['short_desc']) ?></p><?php endif; ?>
            <?php if (!empty($row['categories'])): ?>
                <p class="lst-card__tags"><?php foreach ($row['categories'] as $c): ?><span class="mp-badge"><?= lst_e($c['name']) ?></span> <?php endforeach; ?></p>
            <?php endif; ?>

            <dl class="mp-facts">
                <?php foreach ($facts as [$label, $value]): ?>
                    <div class="mp-fact"><dt class="mp-fact__label"><?= lst_e($label) ?></dt><dd class="mp-fact__value"><?= lst_e($value) ?></dd></div>
                <?php endforeach; ?>
                <?php if (!empty($row['published_at'])): ?>
                    <div class="mp-fact"><dt class="mp-fact__label"><?= lst_e(lst_tr('posted')) ?></dt><dd class="mp-fact__value"><?= lst_e(lst_date((string) $row['published_at'])) ?></dd></div>
                <?php endif; ?>
                <?php if ($live && !empty($row['expires_at'])): ?>
                    <div class="mp-fact"><dt class="mp-fact__label"><?= lst_e(lst_tr('valid_until')) ?></dt><dd class="mp-fact__value"><?= lst_e(lst_date((string) $row['expires_at'])) ?></dd></div>
                <?php endif; ?>
            </dl>

            <?php if (trim((string) $row['full_desc']) !== ''): ?>
                <div class="mp-block">
                    <div class="mp-text mp-text--pre"<?= $textLangAttr ?>><?= lst_e($row['full_desc']) ?></div>
                </div>
            <?php endif; ?>
            <?php if ($autoText): ?><p class="mp-hint"><?= lst_e(lst_tr('text_auto')) ?></p><?php endif; ?>

            <?php if (!$expired): ?>
                <p class="mp-offer__actions">
                    <a class="mp-btn mp-btn--primary mp-btn--lg" href="listing-go.php?id=<?= $id ?>" rel="nofollow noopener" target="_blank"><?= lst_e(lst_tr('go')) ?></a>
                </p>
                <p class="mp-offer__hint"><?= lst_e(lst_tr('go_hint', $host)) ?></p>
            <?php endif; ?>
            <?php if ($freeLabel !== ''): ?><p class="mp-hint lst-free-inline"><?= lst_e($freeLabel) ?></p><?php endif; ?>
        </article>

        <?php if ($live && !$isOwner): ?>
            <details class="mp-report"<?= is_array($reportMsg) ? ' open' : '' ?>>
                <summary><?= mp_e(t('mpb_report_btn')) ?></summary>
                <?php if (is_array($reportMsg)): ?>
                    <p class="mp-alert<?= ($reportMsg['ok'] ?? false) ? '' : ' mp-alert--error' ?>" role="status"><?= lst_e($reportMsg['text'] ?? '') ?></p>
                <?php endif; ?>
                <?php if ($uid === null): ?>
                    <p class="mp-text"><?= mp_e(t('mpb_report_login')) ?> <a href="login.php"><?= mp_e(t('nav_login')) ?></a></p>
                <?php else: ?>
                    <form method="post" action="listing-report.php" class="mp-form">
                        <?= mp_csrf_field() ?>
                        <input type="hidden" name="id" value="<?= $id ?>">
                        <div class="mp-field">
                            <label class="mp-label" for="r_reason"><?= mp_e(t('mpb_report_reason')) ?></label>
                            <select class="mp-input" id="r_reason" name="reason" required>
                                <?php foreach (MPB_REPORT_REASONS as $rr): ?><option value="<?= $rr ?>"><?= mp_e(t('mpb_reason_' . $rr)) ?></option><?php endforeach; ?>
                            </select>
                        </div>
                        <div class="mp-field">
                            <label class="mp-label" for="r_note"><?= mp_e(t('mpb_report_note')) ?></label>
                            <textarea class="mp-input" id="r_note" name="note" rows="3" maxlength="500"></textarea>
                        </div>
                        <button class="mp-btn" type="submit"><?= mp_e(t('mpb_report_send')) ?></button>
                    </form>
                <?php endif; ?>
            </details>
        <?php endif; ?>
        <?php if ($isOwner): ?>
            <p class="mp-actions"><a class="mp-btn" href="listing-post.php?id=<?= $id ?>"><?= lst_e(lst_tr('my_edit')) ?></a> <a class="mp-btn" href="account.php#acc-listings"><?= lst_e(lst_tr('my_title')) ?></a></p>
        <?php endif; ?>

        <p class="mp-note"><?= lst_e(lst_tr('disclaimer')) ?> <a href="terms.php"><?= lst_e(lst_tr('terms_link')) ?></a></p>
    </div>
<?php mpb_close(); ?>
