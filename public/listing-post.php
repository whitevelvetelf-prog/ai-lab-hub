<?php

declare(strict_types=1);

/**
 * AI LAB HUB — форма публікації оголошення компанії: вакансія, курс або послуга (блок M1).
 *
 *   listing-post.php?type=job|course|service   — нове оголошення
 *   listing-post.php?id=N                      — редагування власного (чуже/неіснуюче → 404)
 *
 * Будь-яке збереження → status='pending' (модерація), зокрема редагування схваленого оголошення.
 * Доступ: розділ показано (marketplace_public) або співробітник; вхід; підтверджений email (staff звільнені).
 * Захист: CSRF, honeypot, мінімальний час заповнення, ≤3 на модерації, ліміт за добу (акаунт) і за IP,
 * ліміт посилань, стоп-слова, перевірка посилання (SSRF, редиректи, чорний список, Safe Browsing за наявності ключа).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/mp-drafts.php';

mp_public_or_staff_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

header('Cache-Control: no-store');
// Порядок: гість → вхід/реєстрація з поверненням сюди; пошта не підтверджена → екран «Підтвердьте пошту»
// (з поверненням сюди) ДО показу форми, а не після заповнення.
$userId = mpb_require_login();
$user = auth_current_user($pdo);
if ($user === null) {
    header('Location: ' . auth_login_url(auth_current_next()));
    exit;
}
mpv_require_verified($pdo, $userId);

$cfg = mp_config();
$lang = current_lang();
$isStaff = mp_is_staff();
$settings = lst_settings($pdo);
$focusTags = lst_focus_tags($pdo);
$focusIds = array_column($focusTags, 'id');

// Після відправлення (PRG): «Оголошення на модерації, відповімо протягом N год» + «Мої оголошення».
$sentId = (int) ($_GET['sent'] ?? 0);
if ($sentId > 0 && ($sent = lst_own($pdo, $sentId, $userId)) !== null) {
    $isPending = (string) $sent['status'] === 'pending';
    mpb_message_page(
        200,
        $isPending ? mpf_tr('sent_title') : lst_tr('saved'),
        ($isPending ? '<p class="mp-text">' . mp_e(mpf_tr('sent_text', (int) $settings['review_hours'])) . '</p>' : '')
        . '<p class="mp-actions"><a class="mp-btn mp-btn--primary" href="account.php#acc-listings">' . mp_e(mpf_tr('sent_my')) . '</a>'
        . '<a class="mp-btn" href="' . mp_e(mpt_url((int) (mpt_block(mpt_tree($pdo, $lang), (string) $sent['section'])['id'] ?? 0))) . '">' . mp_e(lst_tr('type_' . $sent['section'])) . '</a></p>',
        null
    );
}

$id = (int) ($_GET['id'] ?? 0);
$existing = null;
if ($id > 0) {
    $existing = lst_own($pdo, $id, $userId);
    if ($existing === null) {
        mp_not_found();
    }
}
$type = $existing !== null ? (string) $existing['section'] : (string) ($_GET['type'] ?? $_POST['type'] ?? '');
if (!lst_type_valid($type)) {
    header('Location: marketplace-post.php', true, 303);   // крок 1 — вибір блока
    exit;
}
// Підкатегорії блока (дерево app/mp-tree.php): обов'язково 1–3, лише свого блока. Тематичні (focus) — необов'язково, до 3.
$lstBlock = mpt_block(mpt_tree($pdo, $lang), $type);
$subCats = $lstBlock['children'] ?? [];
$subIds = array_column($subCats, 'id');

$v = [
    'title' => '', 'company_name' => '', 'short_desc' => '', 'full_desc' => '', 'url' => '', 'country' => '', 'offer_lang' => '',
    'is_remote' => $type !== 'course', 'cats' => [], 'focus' => [], 'd' => [], 'rules' => false,
    'wf' => '', 'fit' => [],
    'ai_media' => false,   // п. 4.5 Правил: AI-медіа, що можуть сприйматися як реальні
];
$fitValues = mpj_suitable_values();
if ($existing !== null) {
    $tx = $pdo->prepare('SELECT title, short_desc, full_desc FROM mp_listing_translations WHERE listing_id = :id AND lang = :lang');
    $tx->execute([':id' => $id, ':lang' => (string) $existing['source_lang']]);
    $t0 = $tx->fetch(PDO::FETCH_ASSOC) ?: ['title' => '', 'short_desc' => '', 'full_desc' => ''];
    $cs = $pdo->prepare('SELECT category_id FROM mp_listing_categories WHERE listing_id = :id');
    $cs->execute([':id' => $id]);
    $v = [
        'title' => (string) $t0['title'], 'company_name' => (string) $existing['company_name'], 'short_desc' => (string) ($t0['short_desc'] ?? ''),
        'full_desc' => (string) ($t0['full_desc'] ?? ''), 'url' => (string) $existing['delivery_url'], 'country' => (string) $existing['country'],
        'offer_lang' => (string) $existing['offer_lang'], 'is_remote' => (int) $existing['is_remote'] === 1,
        'focus' => array_map('intval', $cs->fetchAll(PDO::FETCH_COLUMN)), 'cats' => [],
        'd' => array_map('strval', lst_details($existing)), 'rules' => false,
        'ai_media' => (int) ($existing['ai_generated_media'] ?? 0) === 1,
        'wf' => in_array((string) ($existing['work_format'] ?? ''), MPJ_WORK_FORMATS, true) ? (string) $existing['work_format'] : ((int) $existing['is_remote'] === 1 ? 'online' : 'offline'),
        'fit' => mpj_tags($pdo, [$id])[$id] ?? [],
    ];
    $v['cats'] = array_values(array_intersect($v['focus'], $subIds));
    $v['focus'] = array_values(array_intersect($v['focus'], $focusIds));
}

$errors = [];   // ключ lst_tr або [ключ, аргументи...]
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!mp_csrf_verify()) {
        mpb_message_page(403, t('mpb_err_csrf_title'), '<p class="mp-text">' . mp_e(t('mpb_err_csrf')) . '</p>', 'listings.php?type=' . $type);
    }
    if ((string) ($_POST['website'] ?? '') !== '') {
        error_log('[listing] honeypot triggered, user ' . $userId);
        mpb_message_page(400, t('mpb_err_generic_title'), '<p class="mp-text">' . mp_e(lst_tr('err_spam')) . '</p>', 'listings.php?type=' . $type);
    }
    $str = static fn(string $k): string => is_string($_POST[$k] ?? null) ? trim((string) $_POST[$k]) : '';

    $v['title'] = mb_substr(lst_plain($str('title')), 0, 400);
    $v['company_name'] = mb_substr(lst_plain($str('company_name')), 0, 400);
    $v['short_desc'] = mb_substr(lst_plain($str('short_desc')), 0, 1000);
    $v['full_desc'] = mb_substr(lst_plain($str('full_desc')), 0, 8000);
    $v['url'] = mb_substr($str('url'), 0, 600);
    $v['country'] = strtoupper($str('country'));
    $v['offer_lang'] = $str('offer_lang');
    $v['is_remote'] = ($_POST['is_remote'] ?? '') === '1';
    $v['focus'] = array_values(array_intersect(array_unique(array_map('intval', is_array($_POST['focus'] ?? null) ? $_POST['focus'] : [])), $focusIds));
    $v['cats'] = array_values(array_intersect(array_unique(array_map('intval', is_array($_POST['cats'] ?? null) ? $_POST['cats'] : [])), $subIds));
    $v['d'] = is_array($_POST['d'] ?? null) ? array_map(static fn($x): string => is_string($x) ? $x : '', $_POST['d']) : [];
    $v['rules'] = ($_POST['rules'] ?? '') === '1';
    $v['ai_media'] = ($_POST['ai_media'] ?? '') === '1';
    if ($type === 'job') {
        // Формат роботи (офіс / онлайн / змішано) замість галочки «віддалено»; is_remote — лише «онлайн».
        $v['wf'] = in_array($str('wf'), MPJ_WORK_FORMATS, true) ? $str('wf') : '';
        $v['is_remote'] = $v['wf'] === 'online';
        // «Підходить»: лише значення з config 'suitable_for' (вікові та інші — відкидаються на сервері).
        $rawFit = is_array($_POST['fit'] ?? null) ? array_filter($_POST['fit'], 'is_string') : [];
        if (array_diff($rawFit, $fitValues) !== []) {
            error_log('[listing] rejected suitable_for values from user ' . $userId);
        }
        $v['fit'] = array_values(array_intersect($fitValues, $rawFit));
    }

    if (!$isStaff && !lst_form_stamp_ok($str('ft'))) {
        $errors[] = 'err_too_fast';
    }
    $len = mb_strlen($v['title']);
    if ($len < 3 || $len > LST_TITLE_MAX) {
        $errors[] = ['err_title', LST_TITLE_MAX];
    }
    $len = mb_strlen($v['company_name']);
    if ($len < 2 || $len > LST_COMPANY_MAX) {
        $errors[] = ['err_company', LST_COMPANY_MAX];
    }
    $len = mb_strlen($v['short_desc']);
    if ($len < 10 || $len > LST_SHORT_MAX) {
        $errors[] = ['err_short', LST_SHORT_MAX];
    }
    if (mb_strlen($v['full_desc']) > LST_DESC_MAX) {
        $errors[] = ['err_desc', LST_DESC_MAX];
    }
    if ($type === 'job' && mb_strlen($v['full_desc']) < 50) {
        $errors[] = 'err_desc_job';
    }
    if (!lst_url_valid($v['url'])) {
        $errors[] = 'err_url';
    }
    if (!isset(LST_COUNTRIES[$v['country']])) {
        $errors[] = 'err_country';
    }
    if (!in_array($v['offer_lang'], LST_LANGS, true)) {
        $errors[] = 'err_lang';
    }
    if ($subIds !== [] && ($v['cats'] === [] || count($v['cats']) > MPT_MAX_CATS)) {
        $errors[] = 'err_subcats';
    }
    if (count($v['focus']) > 3) {
        $errors[] = 'err_focus';
    }
    $details = lst_details_normalize($type, $v['d'], $errors);
    if ($type === 'job' && $v['wf'] === '') {
        $errors[] = 'err_work_format';
    }
    if ($type === 'job' && !$v['is_remote'] && empty($details['city'])) {
        $errors[] = 'err_job_location';
    }
    // Курс офлайн чи змішаний — місто обов'язкове (п. 6.5 Правил).
    if ($type === 'course' && in_array((string) ($details['format'] ?? ''), ['offline', 'hybrid'], true) && empty($details['city'])) {
        $errors[] = 'err_course_location';
    }
    if (!$v['rules']) {
        $errors[] = 'err_rules';
    }
    $maxLinks = (int) $cfg['max_links_in_desc'];
    if (mpb_count_links($v['title'] . "\n" . $v['short_desc'] . "\n" . $v['full_desc']) > $maxLinks) {
        $errors[] = ['err_links', $maxLinks];
    }
    if (mpb_stop_word($v['title'], $v['short_desc'], $v['full_desc'], $v['company_name']) !== null) {
        $errors[] = 'err_stopword';
    }
    $errors = array_values(array_unique($errors, SORT_REGULAR));

    // Ліміти — під блокуванням користувача (паралельні запити не обходять ліміт).
    $lock = 'lst_post_' . $userId;
    if (mpb_lock($pdo, $lock)) {
        register_shutdown_function(static function () use ($pdo, $lock): void {
            try {
                mpb_unlock($pdo, $lock);
            } catch (Throwable) {
            }
        });
    } else {
        $errors[] = 'err_save';
    }
    if (!$isStaff) {
        if (lst_pending_count($pdo, $userId, $id) >= LST_MAX_PENDING) {
            $errors[] = ['err_pending_limit', LST_MAX_PENDING];
        }
        if ($existing === null && lst_new_today_count($pdo, $userId) >= (int) $cfg['max_new_per_day']) {
            $errors[] = ['err_day_limit', (int) $cfg['max_new_per_day']];
        }
    }

    // Перевірка посилання — лише коли решта форми вже коректна (мережевий запит).
    $check = null;
    if ($errors === []) {
        $check = lst_link_check($pdo, $v['url']);
        if (($hard = lst_link_hard_fail($check)) !== null) {
            $errors[] = $hard;
        }
    }
    if ($errors === [] && $existing === null && !$isStaff && !mpb_ip_hit($pdo, 'lpost', (int) $cfg['ip_limit_post'])) {
        $errors[] = 'err_rate';
    }

    if ($errors === []) {
        try {
            $sellerId = $existing !== null ? (int) $existing['seller_id'] : mpb_seller_for_user($pdo, $userId, (string) $user['name']);
            $savedId = lst_save($pdo, [
                'type' => $type, 'title' => $v['title'], 'short_desc' => $v['short_desc'], 'full_desc' => $v['full_desc'],
                'company_name' => $v['company_name'], 'url' => $v['url'], 'country' => $v['country'], 'offer_lang' => $v['offer_lang'],
                'is_remote' => $v['is_remote'], 'details' => $details, 'cats' => $v['cats'], 'focus' => $v['focus'], 'check' => $check,
            ], $existing, $userId, $sellerId, $lang);
            mpj_after_save($pdo, $savedId, $type, $details, $type === 'job' ? $v['wf'] : '', $v['fit'], $v['country']);
            mpl_save_listing_extras($pdo, $savedId, $v['ai_media']);
            lst_mail($pdo, $savedId, 'received');
            // Оголошення за запрошенням аутрічу (marketplace-join.php) → лід «Розмістили».
            $joinLead = (int) ($_SESSION['outreach_join_lead'] ?? 0);
            if ($existing === null && $joinLead > 0 && is_file(__DIR__ . '/../app/outreach-mail.php')) {
                require_once __DIR__ . '/../app/outreach-mail.php';
                omail_join_listed($pdo, $joinLead, $savedId);
                unset($_SESSION['outreach_join_lead']);
            }
            if ($existing === null) {
                mpd_delete($pdo, $userId, 'listing:' . $type);   // чернетку подано — більше не потрібна
            }
            header('Location: listing-post.php?sent=' . $savedId, true, 303);
            exit;
        } catch (Throwable $e) {
            error_log('[listing] save failed: ' . $e->getMessage());
            $errors[] = 'err_save';
        }
    }
}

$pageTitle = $existing === null ? lst_tr('form_new', lst_tr('type1_' . $type)) : lst_tr('form_edit');
$freeLabel = lst_free_label($pdo);
$emailDomain = (string) substr((string) strrchr((string) $user['email'], '@'), 1);
$dv = static fn(string $k): string => (string) ($v['d'][$k] ?? '');
$select = static function (string $name, array $options, string $current, bool $withAny = true): string {
    $h = '<select class="mp-input" id="d_' . lst_e($name) . '" name="d[' . lst_e($name) . ']">';
    if ($withAny) {
        $h .= '<option value="">' . lst_e(lst_tr('f_any')) . '</option>';
    }
    foreach ($options as $o) {
        $h .= '<option value="' . lst_e($o) . '"' . ($current === $o ? ' selected' : '') . '>' . lst_e(lst_v($o)) . '</option>';
    }

    return $h . '</select>';
};
$currency = static function (string $name, string $current): string {
    $h = '<select class="mp-input mp-input--short" name="d[' . lst_e($name) . ']" aria-label="Currency">';
    foreach (LST_CURRENCIES as $c) {
        $h .= '<option value="' . $c . '"' . ($current === $c ? ' selected' : '') . '>' . $c . '</option>';
    }

    return $h . '</select>';
};

// Помилки біля полів: ключ помилки → поле форми. Решта (ліміти, спам, збереження) — у загальному блоці вгорі.
const LP_ERR_FIELD = [
    'err_title' => 'title', 'err_company' => 'company_name', 'err_short' => 'short_desc', 'err_desc' => 'full_desc',
    'err_desc_job' => 'full_desc', 'err_links' => 'full_desc', 'err_url' => 'url', 'err_link_blocked' => 'url',
    'err_country' => 'country', 'err_lang' => 'offer_lang', 'err_focus' => 'focus', 'err_subcats' => 'cats', 'err_job_location' => 'city', 'err_course_location' => 'city',
    'err_rules' => 'rules', 'err_work_format' => 'wf', 'err_number' => 'number', 'err_date' => 'date', 'err_apply_past' => 'date', 'err_salary_range' => 'salary',
];
$byField = [];
$generalErrors = [];
foreach ($errors as $err) {
    $k = is_array($err) ? $err[0] : $err;
    $msg = is_array($err) ? lst_tr($err[0], ...array_slice($err, 1)) : lst_tr($err);
    if (isset(LP_ERR_FIELD[$k])) {
        $byField[LP_ERR_FIELD[$k]][] = $msg;
    } else {
        $generalErrors[] = $msg;
    }
}
$fieldErr = static fn(string $f): string => isset($byField[$f])
    ? '<p class="mpf-error" id="err_' . lst_e($f) . '">' . lst_e(implode(' ', $byField[$f])) . '</p>' : '';
$invalid = static fn(string $f): string => isset($byField[$f]) ? ' aria-invalid="true" aria-describedby="err_' . lst_e($f) . '"' : '';
// Автозбереження чернетки (лише нове оголошення); відновлення — коли форма відкрита вперше (не POST з помилками).
$draft = $existing === null
    ? mpd_form_bits($pdo, $userId, 'listing:' . $type, ($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST')
    : ['attrs' => '', 'html' => ''];

mpb_open($pageTitle, true, 'post');
?>
    <div class="mp-page mp-page--narrow">
        <?= $existing === null ? lst_type_nav($type, 'listing-post.php') : '' ?>
        <h1 class="mp-title"><?= lst_e($pageTitle) ?></h1>
        <p class="mp-subtitle"><?= lst_e(lst_tr('form_lead', $settings['days'])) ?></p>
        <?php if ($freeLabel !== ''): ?>
            <p class="mp-callout lst-free"><?= lst_e($freeLabel) ?></p>
        <?php endif; ?>
        <?php if ($existing !== null && in_array((string) $existing['status'], ['published', 'expired'], true)): ?>
            <div class="mp-alert"><?= lst_e(lst_tr('form_edit_note')) ?></div>
        <?php endif; ?>
        <?php if ($existing !== null && (string) $existing['status'] === 'rejected' && !empty($existing['reject_reason'])): ?>
            <div class="mp-alert mp-alert--error"><strong><?= lst_e(lst_tr('reject_reason')) ?>:</strong> <?= lst_e($existing['reject_reason']) ?></div>
        <?php endif; ?>
        <?php if ($errors !== []): ?>
            <div class="mp-alert mp-alert--error" role="alert">
                <p><strong><?= lst_e(mpf_tr('errors_below')) ?></strong></p>
                <?php if ($generalErrors !== []): ?><ul class="mp-alert__list">
                    <?php foreach ($generalErrors as $msg): ?><li><?= lst_e($msg) ?></li><?php endforeach; ?>
                </ul><?php endif; ?>
            </div>
        <?php endif; ?>
        <?= $draft['html'] ?>

        <form class="mp-form mpf-form" method="post" action="listing-post.php<?= $existing !== null ? '?id=' . $id : '?type=' . $type ?>" novalidate<?= $draft['attrs'] ?>>
            <?= mp_csrf_field() ?>
            <input type="hidden" name="ft" value="<?= lst_e(lst_form_stamp()) ?>">
            <input type="hidden" name="type" value="<?= lst_e($type) ?>">
            <div class="mp-hp" aria-hidden="true"><label>Website <input type="text" name="website" value="" tabindex="-1" autocomplete="off"></label></div>
            <p class="mp-hint"><?= lst_e(mpf_tr('required_note')) ?></p>

            <?php // 1. Розділ і категорія ?>
            <fieldset class="mpf-block<?= ($fieldErr('cats') . $fieldErr('focus')) !== '' ? ' mpf-block--error' : '' ?>" id="blk-section">
                <legend class="mpf-block__title"><?= lst_e(mpf_tr('blk_section')) ?></legend>
                <p class="mp-text mpf-type"><?= lst_e(t('mpt_block_label')) ?>: <strong><?= lst_e($lstBlock['name'] ?? lst_tr('type1_' . $type)) ?></strong>
                    <?php if ($existing === null): ?> · <a href="marketplace-post.php"><?= lst_e(t('mpt_change_block')) ?></a><?php endif; ?></p>
                <?php if ($subCats !== []): ?>
                <span class="mp-label" id="lbl_cats"><?= lst_e(t('mpt_subcategories')) ?> <span class="mpf-req">*</span></span>
                <div class="mp-checks" role="group" aria-labelledby="lbl_cats">
                    <?php foreach ($subCats as $sc): ?>
                        <label class="mp-check"><input type="checkbox" name="cats[]" value="<?= (int) $sc['id'] ?>"<?= in_array($sc['id'], $v['cats'], true) ? ' checked' : '' ?>> <span><?= lst_e($sc['name']) ?></span></label>
                    <?php endforeach; ?>
                </div>
                <p class="mp-hint"><?= lst_e(t('mpb_f_categories_hint')) ?></p>
                <?= $fieldErr('cats') ?>
                <?php endif; ?>
                <details class="mpt-focus"<?= $v['focus'] !== [] ? ' open' : '' ?>>
                    <summary><?= lst_e(lst_tr('f_focus')) ?> (<?= lst_e(t('mpt_optional')) ?>)</summary>
                    <div class="mp-checks" role="group" aria-label="<?= lst_e(lst_tr('f_focus')) ?>">
                        <?php foreach ($focusTags as $tg): ?>
                            <label class="mp-check"><input type="checkbox" name="focus[]" value="<?= (int) $tg['id'] ?>"<?= in_array($tg['id'], $v['focus'], true) ? ' checked' : '' ?>> <span><?= lst_e($tg['name']) ?></span></label>
                        <?php endforeach; ?>
                    </div>
                    <p class="mp-hint"><?= lst_e(lst_tr('f_focus_hint')) ?></p>
                </details>
                <?= $fieldErr('focus') ?>
            </fieldset>

            <?php // 2. Основне ?>
            <fieldset class="mpf-block" id="blk-main">
                <legend class="mpf-block__title"><?= lst_e(mpf_tr('blk_main')) ?></legend>
                <div class="mp-field">
                    <label class="mp-label" for="title"><?= lst_e(lst_tr('f_title')) ?> <span class="mpf-req">*</span></label>
                    <input class="mp-input" type="text" id="title" name="title" maxlength="<?= LST_TITLE_MAX ?>" required value="<?= lst_e($v['title']) ?>"<?= $invalid('title') ?>>
                    <p class="mp-hint"><?= lst_e(lst_tr($type === 'job' ? 'f_title_hint_job' : 'f_title_hint', LST_TITLE_MAX)) ?></p>
                    <?= $fieldErr('title') ?>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="company_name"><?= lst_e(lst_tr('f_company')) ?> <span class="mpf-req">*</span></label>
                    <input class="mp-input" type="text" id="company_name" name="company_name" maxlength="<?= LST_COMPANY_MAX ?>" required value="<?= lst_e($v['company_name']) ?>"<?= $invalid('company_name') ?>>
                    <p class="mp-hint"><?= lst_e(lst_tr('f_company_hint')) ?></p>
                    <?= $fieldErr('company_name') ?>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="short_desc"><?= lst_e(lst_tr('f_short')) ?> <span class="mpf-req">*</span></label>
                    <textarea class="mp-input" id="short_desc" name="short_desc" rows="3" maxlength="<?= LST_SHORT_MAX ?>" required<?= $invalid('short_desc') ?>><?= lst_e($v['short_desc']) ?></textarea>
                    <p class="mp-hint"><?= lst_e(lst_tr('f_short_hint', LST_SHORT_MAX)) ?></p>
                    <?= $fieldErr('short_desc') ?>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="full_desc"><?= lst_e(lst_tr('f_desc')) ?><?= $type === 'job' ? ' <span class="mpf-req">*</span>' : '' ?></label>
                    <textarea class="mp-input" id="full_desc" name="full_desc" rows="9" maxlength="<?= LST_DESC_MAX ?>"<?= $type === 'job' ? ' required' : '' ?><?= $invalid('full_desc') ?>><?= lst_e($v['full_desc']) ?></textarea>
                    <p class="mp-hint"><?= lst_e(lst_tr($type === 'job' ? 'f_desc_hint_job' : 'f_desc_hint', LST_DESC_MAX, (int) $cfg['max_links_in_desc'])) ?></p>
                    <?= $fieldErr('full_desc') ?>
                </div>
            </fieldset>

            <?php // 3. Місце й формат (+ деталі типу) ?>
            <fieldset class="mpf-block" id="blk-place">
                <legend class="mpf-block__title"><?= lst_e(mpf_tr('blk_place')) ?></legend>
                <div class="mp-row">
                    <div class="mp-field">
                        <label class="mp-label" for="country"><?= lst_e(lst_tr('f_country')) ?> <span class="mpf-req">*</span></label>
                        <select class="mp-input" id="country" name="country" required<?= $invalid('country') ?>>
                            <option value=""><?= lst_e(lst_tr('f_any')) ?></option>
                            <?php foreach (array_keys(LST_COUNTRIES) as $cc): ?>
                                <option value="<?= $cc ?>"<?= $v['country'] === $cc ? ' selected' : '' ?>><?= lst_e(lst_country_name($cc)) ?></option>
                            <?php endforeach; ?>
                        </select>
                        <?php if ($type === 'job'): ?><p class="mp-hint"><?= lst_e(lst_tr('f_country_hint_job')) ?></p><?php endif; ?>
                        <?= $fieldErr('country') ?>
                    </div>
                    <div class="mp-field">
                        <label class="mp-label" for="offer_lang"><?= lst_e(lst_tr('f_lang')) ?> <span class="mpf-req">*</span></label>
                        <select class="mp-input" id="offer_lang" name="offer_lang" required<?= $invalid('offer_lang') ?>>
                            <option value=""><?= lst_e(lst_tr('f_any')) ?></option>
                            <?php foreach (LST_LANGS as $l): ?>
                                <option value="<?= $l ?>"<?= $v['offer_lang'] === $l ? ' selected' : '' ?>><?= lst_e(lst_tr('lang_' . $l)) ?></option>
                            <?php endforeach; ?>
                        </select>
                        <?= $fieldErr('offer_lang') ?>
                    </div>
                </div>
                <?php if ($type === 'job'): ?>
                <div class="mp-field">
                    <label class="mp-label" for="wf"><?= lst_e(t('mpj_f_work_format')) ?> <span class="mpf-req">*</span></label>
                    <select class="mp-input" id="wf" name="wf" required<?= $invalid('wf') ?>>
                        <option value=""><?= lst_e(lst_tr('f_any')) ?></option>
                        <?php foreach (MPJ_WORK_FORMATS as $wfo): ?>
                            <option value="<?= $wfo ?>"<?= $v['wf'] === $wfo ? ' selected' : '' ?>><?= lst_e(t('mpj_wf_' . $wfo)) ?></option>
                        <?php endforeach; ?>
                    </select>
                    <?= $fieldErr('wf') ?>
                </div>
                <?php else: ?>
                <div class="mp-field mp-field--check">
                    <label class="mp-check"><input type="checkbox" name="is_remote" value="1"<?= $v['is_remote'] ? ' checked' : '' ?>> <span><?= lst_e(lst_tr($type === 'job' ? 'f_remote_job' : 'f_remote')) ?></span></label>
                </div>
                <?php endif; ?>

                <h3 class="mpf-sub"><?= lst_e(lst_tr('f_details')) ?></h3>
                <?php if ($type === 'job'): ?>
                    <div class="mp-row">
                        <div class="mp-field"><label class="mp-label" for="d_employment"><?= lst_e(lst_tr('d_employment')) ?></label><?= $select('employment', LST_DETAILS['job']['employment'], $dv('employment')) ?></div>
                        <div class="mp-field"><label class="mp-label" for="d_schedule"><?= lst_e(lst_tr('d_schedule')) ?></label><?= $select('schedule', LST_DETAILS['job']['schedule'], $dv('schedule')) ?></div>
                    </div>
                    <div class="mp-row">
                        <div class="mp-field"><label class="mp-label" for="d_level"><?= lst_e(t('mpj_f_experience')) ?></label><?= $select('level', LST_DETAILS['job']['level'], $dv('level')) ?></div>
                    </div>
                    <div class="mp-field">
                        <span class="mp-label"><?= lst_e(lst_tr('d_salary')) ?></span>
                        <div class="mp-inline lst-salary">
                            <input class="mp-input mp-input--num" type="text" inputmode="numeric" name="d[salary_min]" maxlength="9" placeholder="<?= lst_e(lst_tr('d_salary_min')) ?>" aria-label="<?= lst_e(lst_tr('d_salary_min')) ?>" value="<?= lst_e($dv('salary_min')) ?>">
                            <input class="mp-input mp-input--num" type="text" inputmode="numeric" name="d[salary_max]" maxlength="9" placeholder="<?= lst_e(lst_tr('d_salary_max')) ?>" aria-label="<?= lst_e(lst_tr('d_salary_max')) ?>" value="<?= lst_e($dv('salary_max')) ?>">
                            <?= $currency('salary_currency', $dv('salary_currency') ?: 'USD') ?>
                            <select class="mp-input mp-input--short" name="d[salary_period]" aria-label="<?= lst_e(lst_tr('d_salary_period')) ?>">
                                <?php foreach (LST_DETAILS['job']['salary_period'] as $p): ?>
                                    <?php if ($p === 'YEAR' && $dv('salary_period') !== 'YEAR') { continue; } ?>
                                    <option value="<?= $p ?>"<?= ($dv('salary_period') ?: 'MONTH') === $p ? ' selected' : '' ?>><?= lst_e(lst_tr('per', lst_v($p))) ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <p class="mp-hint"><?= lst_e(t('mpj_form_salary_hint')) ?></p>
                        <?= $fieldErr('salary') ?>
                    </div>
                    <?php if ($fitValues !== []): ?>
                    <fieldset class="mp-field mpf-group">
                        <legend class="mp-label"><?= lst_e(t('mpj_f_fit')) ?> (<?= lst_e(t('mpt_optional')) ?>)</legend>
                        <div class="mp-checks">
                            <?php foreach ($fitValues as $fv): ?>
                                <label class="mp-check"><input type="checkbox" name="fit[]" value="<?= lst_e($fv) ?>"<?= in_array($fv, $v['fit'], true) ? ' checked' : '' ?>> <span><?= lst_e(mpj_fit_label($fv)) ?></span></label>
                            <?php endforeach; ?>
                        </div>
                        <p class="mp-hint"><?= lst_e(t('mpj_form_fit_hint')) ?></p>
                    </fieldset>
                    <?php endif; ?>
                    <div class="mp-row">
                        <div class="mp-field"><label class="mp-label" for="d_city"><?= lst_e(lst_tr('d_city')) ?></label><input class="mp-input" type="text" id="d_city" name="d[city]" maxlength="120" value="<?= lst_e($dv('city')) ?>"<?= $invalid('city') ?>><?= $fieldErr('city') ?></div>
                        <div class="mp-field"><label class="mp-label" for="d_apply_until"><?= lst_e(lst_tr('d_apply_until')) ?></label><input class="mp-input" type="date" id="d_apply_until" name="d[apply_until]" min="<?= date('Y-m-d') ?>" value="<?= lst_e($dv('apply_until')) ?>"<?= $invalid('date') ?>><?= $fieldErr('date') ?></div>
                    </div>
                <?php elseif ($type === 'course'): ?>
                    <div class="mp-row">
                        <div class="mp-field"><label class="mp-label" for="d_format"><?= lst_e(lst_tr('d_format')) ?></label><?= $select('format', LST_DETAILS['course']['format'], $dv('format')) ?></div>
                        <div class="mp-field"><label class="mp-label" for="d_level"><?= lst_e(lst_tr('d_level')) ?></label><?= $select('level', LST_DETAILS['course']['level'], $dv('level')) ?></div>
                    </div>
                    <div class="mp-row">
                        <div class="mp-field"><label class="mp-label" for="d_duration"><?= lst_e(lst_tr('d_duration')) ?></label><input class="mp-input" type="text" id="d_duration" name="d[duration]" maxlength="60" placeholder="<?= lst_e(lst_tr('d_duration_ph')) ?>" value="<?= lst_e($dv('duration')) ?>"></div>
                        <div class="mp-field"><label class="mp-label" for="d_start_date"><?= lst_e(lst_tr('d_start_date')) ?></label><input class="mp-input" type="date" id="d_start_date" name="d[start_date]" value="<?= lst_e($dv('start_date')) ?>"<?= $invalid('date') ?>><?= $fieldErr('date') ?></div>
                    </div>
                    <div class="mp-field mp-field--check"><label class="mp-check"><input type="checkbox" name="d[is_free]" value="1" id="d_is_free"<?= $dv('is_free') === '1' ? ' checked' : '' ?>> <span><?= lst_e(lst_tr('d_is_free')) ?></span></label></div>
                    <div class="mp-field" id="coursePrice">
                        <label class="mp-label" for="d_price"><?= lst_e(lst_tr('d_price')) ?></label>
                        <div class="mp-inline"><input class="mp-input mp-input--num" type="text" inputmode="numeric" id="d_price" name="d[price]" maxlength="9" value="<?= lst_e($dv('price')) ?>"<?= $invalid('number') ?>><?= $currency('currency', $dv('currency') ?: 'USD') ?></div>
                        <?= $fieldErr('number') ?>
                    </div>
                    <div class="mp-field"><label class="mp-label" for="d_city"><?= lst_e(lst_tr('d_city')) ?></label><input class="mp-input" type="text" id="d_city" name="d[city]" maxlength="120" value="<?= lst_e($dv('city')) ?>"<?= $invalid('city') ?>><p class="mp-hint"><?= lst_e(lst_tr('d_city_course_hint')) ?></p><?= $fieldErr('city') ?></div>
                <?php else: ?>
                    <div class="mp-row">
                        <div class="mp-field"><label class="mp-label" for="d_service_type"><?= lst_e(lst_tr('d_service_type')) ?></label><?= $select('service_type', LST_DETAILS['service']['service_type'], $dv('service_type')) ?></div>
                        <div class="mp-field"><label class="mp-label" for="d_delivery_time"><?= lst_e(lst_tr('d_delivery_time')) ?></label><input class="mp-input" type="text" id="d_delivery_time" name="d[delivery_time]" maxlength="60" placeholder="<?= lst_e(lst_tr('d_delivery_ph')) ?>" value="<?= lst_e($dv('delivery_time')) ?>"></div>
                    </div>
                    <div class="mp-field">
                        <label class="mp-label" for="d_price_from"><?= lst_e(lst_tr('d_price_from')) ?></label>
                        <div class="mp-inline"><input class="mp-input mp-input--num" type="text" inputmode="numeric" id="d_price_from" name="d[price_from]" maxlength="9" value="<?= lst_e($dv('price_from')) ?>"<?= $invalid('number') ?>><?= $currency('currency', $dv('currency') ?: 'USD') ?></div>
                        <?= $fieldErr('number') ?>
                    </div>
                <?php endif; ?>
            </fieldset>

            <?php // 4. Контакти й посилання ?>
            <fieldset class="mpf-block" id="blk-contacts">
                <legend class="mpf-block__title"><?= lst_e(mpf_tr('blk_contacts')) ?></legend>
                <div class="mp-field">
                    <label class="mp-label" for="url"><?= lst_e(lst_tr('f_url')) ?> <span class="mpf-req">*</span></label>
                    <input class="mp-input" type="url" id="url" name="url" maxlength="500" required placeholder="https://" inputmode="url" value="<?= lst_e($v['url']) ?>"<?= $invalid('url') ?>>
                    <p class="mp-hint"><?= lst_e(lst_tr('f_url_hint_' . $type)) ?></p>
                    <p class="mp-hint"><?= lst_e(lst_tr('f_domain_hint', $emailDomain)) ?></p>
                    <?= $fieldErr('url') ?>
                </div>
            </fieldset>

            <?php // Правила й відправлення ?>
            <fieldset class="mpf-block" id="blk-rules">
                <legend class="mpf-block__title"><?= lst_e(mpf_tr('blk_rules')) ?></legend>
                <?= lst_rules_html() ?>
                <div class="mp-field">
                    <label class="mp-check mp-check--block">
                        <input type="checkbox" name="ai_media" value="1"<?= $v['ai_media'] ? ' checked' : '' ?>>
                        <span><?= lst_e(mpl_tr('ai_media_label')) ?></span>
                    </label>
                    <p class="mp-hint"><?= lst_e(mpl_tr('ai_media_hint')) ?></p>
                </div>
                <div class="mp-field">
                    <label class="mp-check mp-check--block">
                        <input type="checkbox" name="rules" value="1" required<?= $v['rules'] ? ' checked' : '' ?><?= $invalid('rules') ?>>
                        <span><?= lst_e(lst_tr('f_rules')) ?> <a href="marketplace-rules.php" target="_blank" rel="noopener"><?= lst_e(lst_tr('f_rules_link')) ?></a> <span class="mpf-req">*</span></span>
                    </label>
                    <?= $fieldErr('rules') ?>
                </div>
                <p class="mp-note"><?= lst_e(lst_tr('disclaimer')) ?></p>
                <div class="mp-actions">
                    <button class="mp-btn mp-btn--primary mp-btn--lg" type="submit"><?= lst_e(lst_tr($existing === null ? 'f_submit_new' : 'f_submit_save')) ?></button>
                    <a class="mp-btn" href="account.php#acc-listings"><?= lst_e(lst_tr('f_cancel')) ?></a>
                </div>
            </fieldset>
        </form>
    </div>
    <script src="/assets/js/mp-draft.js?v=<?= (int) @filemtime(__DIR__ . '/assets/js/mp-draft.js') ?>" defer></script>
    <script>
    (function () {
        // Згода з Правилами (п. 1.5): перевірка й на клієнті (форма novalidate; сервер перевіряє завжди).
        var form = document.querySelector('form.mpf-form'), rules = form && form.querySelector('input[name="rules"]');
        if (!form || !rules) { return; }
        form.addEventListener('submit', function (e) {
            if (rules.checked) { return; }
            e.preventDefault();
            rules.setCustomValidity(<?= json_encode(mpl_tr('consent_err'), JSON_UNESCAPED_UNICODE | JSON_HEX_TAG) ?>);
            rules.reportValidity();
            rules.focus();
        });
        rules.addEventListener('change', function () { rules.setCustomValidity(''); });
    })();
    </script>
    <?php if ($type === 'course'): ?>
    <script>
    (function () {
        var cb = document.getElementById('d_is_free'), box = document.getElementById('coursePrice');
        function sync() { box.style.display = cb.checked ? 'none' : ''; }
        cb.addEventListener('change', sync); sync();
    })();
    </script>
    <?php endif; ?>
<?php mpb_close(); ?>
