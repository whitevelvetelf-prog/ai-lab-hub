<?php

declare(strict_types=1);

/**
 * AI LAB HUB — форма публікації «Цифрового матеріалу» (зображення, ілюстрація, персонаж).
 *
 *   asset-post.php          — новий матеріал
 *   asset-post.php?id=N     — редагування власного (→ повторна модерація; файл можна лишити)
 *
 * Обов'язково: файл (PNG/JPG/WebP до assets_max_mb, MIME за вмістом), назва, alt-текст, вид, походження
 * (з підказкою про обмежений захист AI-зображень), ліцензія, декларація прав (дата + користувач), правила.
 * Доступ: розділ показано або співробітник; вхід; підтверджений e-mail. Без GD — відмова з поясненням.
 * Захист: CSRF, honeypot, мінімальний час заповнення, ≤ AST_MAX_PENDING на модерації, ліміт за IP,
 * блок після copyright_strikes_limit підтверджених порушень.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing.php';        // lst_form_stamp, lst_plain
require_once __DIR__ . '/../app/asset.php';
require_once __DIR__ . '/../app/marketplace-email.php';

mp_public_or_staff_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$userId = mpb_require_login();
$user = auth_current_user($pdo);
if ($user === null) {
    header('Location: login.php');
    exit;
}
mpv_require_verified($pdo, $userId);

$lang = current_lang();
$isStaff = mp_is_staff();
$s = ast_settings($pdo);
$caps = ast_capabilities();
$licenses = ast_licenses($pdo);
if (!$caps['ok']) {
    error_log('[asset] publishing disabled: ' . $caps['message']);
    mpb_message_page(503, ast_tr('form_title_new'), '<p class="mp-text">' . ast_e(ast_tr('err_no_gd')) . '</p>', 'assets.php');
}
if (!$isStaff && ast_posting_blocked($pdo, $userId)) {
    mpb_message_page(403, ast_tr('form_title_new'), '<p class="mp-text">' . ast_e(ast_tr('err_blocked')) . '</p>', 'assets.php');
}

$id = (int) ($_GET['id'] ?? 0);
$existing = null;
if ($id > 0) {
    $existing = ast_own($pdo, $id, $userId);
    if ($existing === null || in_array((string) $existing['status'], ['disabled'], true)) {
        mp_not_found();
    }
}

$v = ['kind' => 'image', 'title' => '', 'alt' => '', 'desc' => '', 'tags' => '', 'char_name' => '', 'char_desc' => '', 'char_terms' => '',
    'license' => 'view_only', 'license_custom' => '', 'allow_download' => true, 'origin' => '', 'density' => 'normal', 'noimageindex' => true,
    'contact_email' => '', 'contact_telegram' => '', 'ownership' => false, 'rules' => false];
if ($existing !== null) {
    $tx = $pdo->prepare('SELECT title, full_desc FROM mp_listing_translations WHERE listing_id = :id AND lang = :lang');
    $tx->execute([':id' => $id, ':lang' => (string) $existing['source_lang']]);
    $t0 = $tx->fetch(PDO::FETCH_ASSOC) ?: ['title' => '', 'full_desc' => ''];
    $v = array_merge($v, [
        'kind' => (string) $existing['asset_kind'], 'title' => (string) $t0['title'], 'alt' => (string) $existing['alt_text'], 'desc' => (string) ($t0['full_desc'] ?? ''),
        'tags' => (string) $existing['tags'], 'char_name' => (string) $existing['character_name'], 'char_desc' => (string) $existing['character_desc'],
        'char_terms' => (string) $existing['character_terms'], 'license' => (string) $existing['license_code'], 'license_custom' => (string) $existing['license_custom'],
        'allow_download' => (int) $existing['allow_download'] === 1, 'origin' => (string) $existing['origin'], 'density' => (string) $existing['watermark_density'],
        'noimageindex' => (int) $existing['noimageindex'] === 1, 'contact_email' => (string) $existing['contact_email'], 'contact_telegram' => (string) $existing['contact_telegram'],
    ]);
}

$errors = [];
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST' && $_POST === [] && (int) ($_SERVER['CONTENT_LENGTH'] ?? 0) > 0) {
    $errors[] = ['err_file_size', (int) $s['max_mb']];   // перевищено post_max_size — PHP відкинув тіло запиту
} elseif (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!mp_csrf_verify()) {
        mpb_message_page(403, t('mpb_err_csrf_title'), '<p class="mp-text">' . mp_e(t('mpb_err_csrf')) . '</p>', 'assets.php');
    }
    if ((string) ($_POST['website'] ?? '') !== '') {
        error_log('[asset] honeypot triggered, user ' . $userId);
        mpb_message_page(400, t('mpb_err_generic_title'), '<p class="mp-text">' . mp_e(t('mpb_err_spam')) . '</p>', 'assets.php');
    }
    $str = static fn(string $k, int $max): string => is_string($_POST[$k] ?? null) ? mb_substr(lst_plain(trim((string) $_POST[$k])), 0, $max) : '';
    $v = array_merge($v, [
        'kind' => $str('kind', 20), 'title' => $str('title', 300), 'alt' => $str('alt', 400), 'desc' => $str('desc', 4000), 'tags' => $str('tags', 300),
        'char_name' => $str('char_name', 200), 'char_desc' => $str('char_desc', 600), 'char_terms' => $str('char_terms', 3000),
        'license' => $str('license', 30), 'license_custom' => $str('license_custom', 3500), 'allow_download' => ($_POST['allow_download'] ?? '') === '1',
        'origin' => $str('origin', 20), 'density' => ($_POST['density'] ?? '') === 'high' ? 'high' : 'normal', 'noimageindex' => ($_POST['noimageindex'] ?? '') === '1',
        'contact_email' => $str('contact_email', 190), 'contact_telegram' => ltrim($str('contact_telegram', 80), '@'),
        'ownership' => ($_POST['ownership'] ?? '') === '1', 'rules' => ($_POST['rules'] ?? '') === '1',
    ]);
    // Теги: до 15, кожен до 30 символів, без дублів.
    $v['tags'] = implode(', ', array_slice(array_values(array_unique(array_filter(array_map(static fn($t) => mb_substr(trim($t), 0, 30), explode(',', $v['tags']))))), 0, 15));

    if (!$isStaff && !lst_form_stamp_ok(is_string($_POST['ft'] ?? null) ? (string) $_POST['ft'] : '')) {
        $errors[] = 'err_too_fast';
    }
    if (!in_array($v['kind'], AST_KINDS, true)) {
        $errors[] = 'err_kind';
    }
    $len = mb_strlen($v['title']);
    if ($len < 3 || $len > AST_TITLE_MAX) {
        $errors[] = ['err_title', AST_TITLE_MAX];
    }
    $len = mb_strlen($v['alt']);
    if ($len < 5 || $len > 300) {
        $errors[] = 'err_alt';
    }
    if (mb_strlen($v['desc']) > AST_DESC_MAX) {
        $errors[] = ['err_desc', AST_DESC_MAX];
    }
    if ($v['kind'] === 'character' && ($v['char_name'] === '' || mb_strlen($v['char_name']) > 120)) {
        $errors[] = 'err_char';
    }
    if (!in_array($v['origin'], AST_ORIGINS, true)) {
        $errors[] = 'err_origin';
    }
    if (!isset($licenses[$v['license']])) {
        $errors[] = 'err_license';
    } elseif ($v['license'] === 'custom' && (mb_strlen($v['license_custom']) < 20 || mb_strlen($v['license_custom']) > 3000)) {
        $errors[] = 'err_license_custom';
    }
    if ($v['contact_email'] !== '' && filter_var($v['contact_email'], FILTER_VALIDATE_EMAIL) === false) {
        $v['contact_email'] = '';
    }
    if ($v['contact_telegram'] !== '' && preg_match('/^[A-Za-z0-9_]{5,32}$/', $v['contact_telegram']) !== 1) {
        $v['contact_telegram'] = '';
    }
    if (!$v['ownership']) {
        $errors[] = 'err_ownership';
    }
    if (!$v['rules']) {
        $errors[] = 'err_rules';
    }
    if (mpb_stop_word($v['title'], $v['desc'], $v['alt'], $v['tags']) !== null) {
        $errors[] = 'err_stopword';
    }
    if (!$isStaff && ast_pending_count($pdo, $userId, $id) >= AST_MAX_PENDING) {
        $errors[] = ['err_pending_limit', AST_MAX_PENDING];
    }

    $file = null;
    $upload = $_FILES['file'] ?? null;
    $hasUpload = is_array($upload) && (int) ($upload['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE;
    if ($hasUpload || $existing === null) {
        $inspect = is_array($upload) ? ast_inspect_upload($upload, (int) $s['max_mb'] * 1048576) : 'err_file_required';
        if (is_string($inspect)) {
            $errors[] = match ($inspect) {
                'err_file_size' => ['err_file_size', (int) $s['max_mb']],
                'err_file_dims' => ['err_file_dims', AST_MAX_MEGAPIXELS],
                default => $inspect,
            };
        } else {
            $file = $inspect;
        }
    }
    $errors = array_values(array_unique($errors, SORT_REGULAR));
    if ($errors === [] && $existing === null && !$isStaff && !mpb_ip_hit($pdo, 'apost', (int) mp_config()['ip_limit_post'])) {
        $errors[] = 'rate_limited';
    }

    if ($errors === []) {
        try {
            $sellerId = $existing !== null ? (int) $existing['seller_id'] : mpb_seller_for_user($pdo, $userId, (string) $user['name']);
            $savedId = ast_save($pdo, [
                'title' => $v['title'], 'desc' => $v['desc'], 'kind' => $v['kind'], 'origin' => $v['origin'], 'license' => $v['license'],
                'license_custom' => $v['license_custom'],
                'allow_download' => $v['allow_download'] && !in_array($v['license'], ['view_only', 'commercial_paid'], true),
                'alt' => $v['alt'], 'tags' => $v['tags'], 'char_name' => $v['char_name'], 'char_desc' => $v['char_desc'], 'char_terms' => $v['char_terms'],
                'density' => $v['density'], 'noimageindex' => $v['noimageindex'], 'contact_email' => $v['contact_email'], 'contact_telegram' => $v['contact_telegram'],
            ], $existing, $userId, $sellerId, $lang, $file);
            ast_mail($pdo, $savedId, 'asset_received');
            mpb_flash('ok', ast_tr('saved'));
            header('Location: account.php#acc-assets', true, 303);
            exit;
        } catch (Throwable $e) {
            error_log('[asset] save failed: ' . $e->getMessage());
            $errors[] = 'err_save';
        }
    }
}

$errText = static fn($e): string => is_array($e) ? ast_tr($e[0], ...array_slice($e, 1)) : ast_tr($e);
$checked = static fn(bool $b): string => $b ? ' checked' : '';
ast_open($existing ? ast_tr('form_title_edit') : ast_tr('form_title_new'), '<meta name="robots" content="noindex, nofollow">');
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= ast_e($existing ? ast_tr('form_title_edit') : ast_tr('form_title_new')) ?></h1>
        <p class="mp-subtitle"><?= ast_e(ast_tr('form_intro')) ?></p>
        <details class="mp-note mp-note--box">
            <summary><?= ast_e(ast_tr('protection_title')) ?></summary>
            <p class="mp-text"><?= ast_e(ast_tr('protection_text')) ?></p>
        </details>

        <?php if ($errors !== []): ?>
            <div class="mp-alert mp-alert--error" role="alert"><ul><?php foreach ($errors as $e): ?><li><?= ast_e($errText($e)) ?></li><?php endforeach; ?></ul></div>
        <?php endif; ?>

        <form class="mp-form mp-panel" method="post" enctype="multipart/form-data" action="asset-post.php<?= $existing ? '?id=' . $id : '' ?>">
            <?= mp_csrf_field() ?>
            <input type="hidden" name="ft" value="<?= ast_e(lst_form_stamp()) ?>">
            <input type="hidden" name="MAX_FILE_SIZE" value="<?= (int) $s['max_mb'] * 1048576 ?>">
            <div class="mp-hp" aria-hidden="true"><label>Website <input type="text" name="website" tabindex="-1" autocomplete="off"></label></div>

            <div class="mp-field">
                <label class="mp-label" for="a_kind"><?= ast_e(ast_tr('f_kind')) ?></label>
                <select class="mp-input" id="a_kind" name="kind" required>
                    <?php foreach (AST_KINDS as $k): ?><option value="<?= $k ?>"<?= $v['kind'] === $k ? ' selected' : '' ?>><?= ast_e(ast_tr('kind_' . $k)) ?></option><?php endforeach; ?>
                </select>
            </div>
            <div class="mp-field">
                <label class="mp-label" for="a_file"><?= ast_e(ast_tr('f_file', (int) $s['max_mb'])) ?></label>
                <input class="mp-input" type="file" id="a_file" name="file" accept="image/png,image/jpeg,image/webp"<?= $existing ? '' : ' required' ?>>
                <?php if ($existing): ?><p class="mp-hint"><?= ast_e(ast_tr('f_file_keep')) ?></p><?php endif; ?>
            </div>
            <div class="mp-field">
                <label class="mp-label" for="a_title"><?= ast_e(ast_tr('f_title')) ?></label>
                <input class="mp-input" type="text" id="a_title" name="title" maxlength="<?= AST_TITLE_MAX ?>" required value="<?= ast_e($v['title']) ?>">
            </div>
            <div class="mp-field">
                <label class="mp-label" for="a_alt"><?= ast_e(ast_tr('f_alt')) ?></label>
                <input class="mp-input" type="text" id="a_alt" name="alt" maxlength="300" required value="<?= ast_e($v['alt']) ?>" aria-describedby="a_alt_hint">
                <p class="mp-hint" id="a_alt_hint"><?= ast_e(ast_tr('f_alt_hint')) ?></p>
            </div>
            <div class="mp-field">
                <label class="mp-label" for="a_desc"><?= ast_e(ast_tr('f_desc')) ?></label>
                <textarea class="mp-input" id="a_desc" name="desc" rows="5" maxlength="<?= AST_DESC_MAX ?>"><?= ast_e($v['desc']) ?></textarea>
            </div>
            <div class="mp-field">
                <label class="mp-label" for="a_tags"><?= ast_e(ast_tr('f_tags')) ?></label>
                <input class="mp-input" type="text" id="a_tags" name="tags" maxlength="300" value="<?= ast_e($v['tags']) ?>">
            </div>
            <fieldset class="mp-field ast-char" data-ast-char>
                <legend class="mp-label"><?= ast_e(ast_tr('kind_character')) ?></legend>
                <label class="mp-label" for="a_cn"><?= ast_e(ast_tr('f_char_name')) ?></label>
                <input class="mp-input" type="text" id="a_cn" name="char_name" maxlength="120" value="<?= ast_e($v['char_name']) ?>">
                <label class="mp-label" for="a_cd"><?= ast_e(ast_tr('f_char_desc')) ?></label>
                <input class="mp-input" type="text" id="a_cd" name="char_desc" maxlength="500" value="<?= ast_e($v['char_desc']) ?>">
                <label class="mp-label" for="a_ct"><?= ast_e(ast_tr('f_char_terms')) ?></label>
                <textarea class="mp-input" id="a_ct" name="char_terms" rows="3" maxlength="3000"><?= ast_e($v['char_terms']) ?></textarea>
            </fieldset>

            <fieldset class="mp-field">
                <legend class="mp-label"><?= ast_e(ast_tr('f_origin')) ?></legend>
                <?php foreach (AST_ORIGINS as $o): ?>
                    <label class="mp-check"><input type="radio" name="origin" value="<?= $o ?>"<?= $checked($v['origin'] === $o) ?> required> <span><?= ast_e(ast_tr('origin_' . $o)) ?></span></label>
                <?php endforeach; ?>
                <p class="mp-hint"><?= ast_e(ast_tr('f_origin_hint')) ?></p>
            </fieldset>

            <fieldset class="mp-field">
                <legend class="mp-label"><?= ast_e(ast_tr('f_license')) ?></legend>
                <?php foreach ($licenses as $code => $lic): ?>
                    <label class="mp-check ast-lic-opt"><input type="radio" name="license" value="<?= ast_e($code) ?>"<?= $checked($v['license'] === $code) ?> required>
                        <span><strong><?= ast_e($lic['icon'] . ' ' . ast_license_title($lic, $lang)) ?></strong> — <?= ast_e($lang === 'en' ? $lic['summary_en'] : $lic['summary_uk']) ?></span></label>
                <?php endforeach; ?>
                <p class="mp-alert" data-ast-ccby hidden><?= ast_e(ast_tr('f_ccby_warning')) ?></p>
                <label class="mp-label" for="a_lc"><?= ast_e(ast_tr('f_license_custom')) ?></label>
                <textarea class="mp-input" id="a_lc" name="license_custom" rows="4" maxlength="3000"><?= ast_e($v['license_custom']) ?></textarea>
                <label class="mp-check"><input type="checkbox" name="allow_download" value="1"<?= $checked($v['allow_download']) ?>> <span><?= ast_e(ast_tr('f_allow_download')) ?></span></label>
                <p class="mp-hint"><?= ast_e(ast_tr('f_allow_download_hint')) ?></p>
            </fieldset>

            <fieldset class="mp-field">
                <legend class="mp-label"><?= ast_e(ast_tr('f_watermark')) ?></legend>
                <label class="mp-check"><input type="radio" name="density" value="normal"<?= $checked($v['density'] !== 'high') ?>> <span><?= ast_e(ast_tr('wm_normal')) ?></span></label>
                <label class="mp-check"><input type="radio" name="density" value="high"<?= $checked($v['density'] === 'high') ?>> <span><?= ast_e(ast_tr('wm_high')) ?></span></label>
                <p class="mp-hint"><?= ast_e(ast_tr('f_preview_wm')) ?></p>
                <div class="ast-wm-demo">
                    <img src="<?= ast_e(ast_watermark_demo('normal')) ?>" alt="<?= ast_e(ast_tr('wm_normal')) ?>" width="480" height="270" data-ast-wm="normal"<?= $v['density'] === 'high' ? ' hidden' : '' ?>>
                    <img src="<?= ast_e(ast_watermark_demo('high')) ?>" alt="<?= ast_e(ast_tr('wm_high')) ?>" width="480" height="270" data-ast-wm="high"<?= $v['density'] === 'high' ? '' : ' hidden' ?>>
                </div>
                <label class="mp-check"><input type="checkbox" name="noimageindex" value="1"<?= $checked($v['noimageindex']) ?>> <span><?= ast_e(ast_tr('f_noimageindex')) ?></span></label>
            </fieldset>

            <fieldset class="mp-field">
                <legend class="mp-label"><?= ast_e(ast_tr('download_contact')) ?></legend>
                <label class="mp-label" for="a_ce">Email</label>
                <input class="mp-input" type="email" id="a_ce" name="contact_email" maxlength="190" value="<?= ast_e($v['contact_email']) ?>">
                <label class="mp-label" for="a_tg">Telegram</label>
                <input class="mp-input" type="text" id="a_tg" name="contact_telegram" maxlength="33" value="<?= ast_e($v['contact_telegram']) ?>">
            </fieldset>

            <label class="mp-check"><input type="checkbox" name="ownership" value="1" required> <span><?= ast_e(ast_tr('f_ownership')) ?></span></label>
            <label class="mp-check"><input type="checkbox" name="rules" value="1" required> <span><?= ast_e(ast_tr('f_rules')) ?> <a href="marketplace-rules.php" target="_blank" rel="noopener"><?= mp_e(t('mp_nav_rules')) ?></a> · <a href="copyright-policy.php" target="_blank" rel="noopener"><?= ast_e(ast_tr('policy_link')) ?></a></span></label>

            <p class="mp-actions"><button class="mp-btn mp-btn--primary mp-btn--lg" type="submit"><?= ast_e(ast_tr('f_submit')) ?></button></p>
        </form>
    </div>
    <script>
    (function () {
        var form = document.querySelector('form.mp-form');
        var kind = document.getElementById('a_kind'), charBox = document.querySelector('[data-ast-char]'), ccby = document.querySelector('[data-ast-ccby]');
        function sync() {
            charBox.hidden = kind.value !== 'character';
            var lic = form.querySelector('input[name="license"]:checked');
            ccby.hidden = !lic || lic.value !== 'cc_by';
            var d = form.querySelector('input[name="density"]:checked');
            form.querySelectorAll('[data-ast-wm]').forEach(function (img) { img.hidden = !d || img.getAttribute('data-ast-wm') !== d.value; });
        }
        form.addEventListener('change', sync);
        sync();
    })();
    </script>
<?php mpb_close(); ?>
