<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: збережені пошуки (кабінет), app/mp-saved.php.
 *
 *   GET                — список: назва, «Нових: N» (опубліковані після останнього відкриття), відкрити, перейменувати,
 *                        видалити, перемикач «Сповіщати поштою раз на день» (за замовчуванням вимкнений, явна згода).
 *   GET ?unsub=<токен> — відписка від листів без входу (HMAC-токен, hash_equals). Відповідь однакова для будь-якого
 *                        справжнього токена й не розкриває, чи існує акаунт; підроблений токен — 400.
 *   POST action=save (url — адреса сторінки пошуку) | open | rename | remove | notify — лише з CSRF; save — лише
 *                        залогінені з підтвердженою поштою, ліміт saved_search_max, IP-ліміт ip_limit_saved.
 * Поки public_enabled = false — лише employee/admin (решта 404), як інші сторінки Marketplace.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/mp-saved.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
header('Cache-Control: no-store');

// Відписка за токеном — без входу й незалежно від сесії.
if (is_string($_GET['unsub'] ?? null)) {
    header('X-Robots-Tag: noindex, nofollow');
    $ok = mpss_ready($pdo) && mpss_unsubscribe($pdo, (string) $_GET['unsub']);
    mpb_message_page(
        $ok ? 200 : 400,
        t($ok ? 'mpss_unsub_ok_title' : 'mpss_unsub_bad_title'),
        '<p class="mp-text">' . mp_e(t($ok ? 'mpss_unsub_ok' : 'mpss_unsub_bad')) . '</p>',
        'marketplace.php'
    );
}

mp_public_or_staff_require();
if (!mpss_ready($pdo)) {
    mp_not_found();
}
$lang = current_lang();
$userId = mpb_require_login();

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    mpb_require_post();   // CSRF
    $action = is_string($_POST['action'] ?? null) ? (string) $_POST['action'] : '';
    $sid = is_string($_POST['id'] ?? null) && ctype_digit((string) $_POST['id']) ? (int) $_POST['id'] : 0;
    if ($action === 'save') {
        $url = is_string($_POST['url'] ?? null) ? mb_substr((string) $_POST['url'], 0, 2000) : '';
        $back = preg_match('#^marketplace(?:-category)?\.php(\?[^\s<>"\'\\\\]*)?$#', $url) === 1 ? $url : 'marketplace.php';
        $back = str_replace('+', '%20', $back);   // mpb_redirect() пропускає лише %-кодування
        if (!mpv_is_verified($pdo, $userId)) {
            mpv_require_verified($pdo, $userId, $back);
        }
        if (!mpb_is_staff() && !mpb_ip_hit($pdo, 'saved', (int) mp_config()['ip_limit_saved'])) {
            mpb_flash('error', t('mpb_rate_limited'));
            mpb_redirect($back);
        }
        $r = mpss_create($pdo, $userId, $back, $lang);
        $msg = match ($r['status']) {
            'saved' => ['ok', t('mpss_saved')],
            'exists' => ['ok', t('mpss_exists')],
            'limit' => ['error', sprintf(t('mpss_limit'), mpss_max())],
            default => ['error', t('mpss_invalid')],
        };
        mpb_flash($msg[0], $msg[1]);
        mpb_redirect($r['status'] === 'saved' || $r['status'] === 'exists' ? 'mp-saved.php' : $back);
    }
    if ($action === 'open') {
        $to = mpss_open($pdo, $userId, $sid);
        mpb_redirect($to ?? 'mp-saved.php');
    }
    if ($action === 'rename') {
        $ok = mpss_rename($pdo, $userId, $sid, is_string($_POST['title'] ?? null) ? (string) $_POST['title'] : '');
        mpb_flash($ok ? 'ok' : 'error', t($ok ? 'mpss_renamed' : 'mpss_invalid'));
    } elseif ($action === 'remove') {
        $ok = mpss_remove($pdo, $userId, $sid);
        mpb_flash($ok ? 'ok' : 'error', t($ok ? 'mpss_removed' : 'mpss_invalid'));
    } elseif ($action === 'notify') {
        $on = ($_POST['notify'] ?? '') === '1';
        $ok = mpss_set_notify($pdo, $userId, $sid, $on);
        mpb_flash($ok ? 'ok' : 'error', t($ok ? ($on ? 'mpss_notify_on' : 'mpss_notify_off') : 'mpss_invalid'));
    }
    mpb_redirect('mp-saved.php');
}

$rows = mpss_list($pdo, $userId);
$verified = mpv_is_verified($pdo, $userId);
$emailOn = !empty(mp_config()['saved_search_email_enabled']);
$csrf = mp_csrf_field();

mpb_open(t('mpss_page_title'), true, 'home');
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= mp_e(t('mpss_page_title')) ?></h1>
        <p class="mp-subtitle"><?= mp_e(sprintf(t('mpss_page_lead'), count($rows), mpss_max())) ?></p>
        <?= mpb_flash_html() ?>
        <?php if (!$verified): ?>
            <div class="mp-alert"><?= mpv_block_html('mp-saved.php') ?></div>
        <?php endif; ?>

        <?php if ($rows === []): ?>
            <p class="mp-empty"><?= mp_e(t('mpss_empty')) ?> <a href="marketplace.php"><?= mp_e(t('mp_heading')) ?></a></p>
        <?php else: ?>
            <ul class="mpss-list">
                <?php foreach ($rows as $r): $rid = (int) $r['id']; $new = mpss_new_count($pdo, $r, $lang); ?>
                    <li class="mpss-item">
                        <div class="mpss-item__head">
                            <h2 class="mpss-item__title"><?= mp_e($r['title']) ?></h2>
                            <span class="mpss-new<?= $new > 0 ? ' mpss-new--yes' : '' ?>"><?= mp_e(sprintf(t('mpss_new_n'), $new)) ?></span>
                        </div>
                        <div class="mpss-item__actions">
                            <form method="post" action="mp-saved.php" class="mp-inline-form"><?= $csrf ?><input type="hidden" name="action" value="open"><input type="hidden" name="id" value="<?= $rid ?>"><button class="mp-btn mp-btn--primary" type="submit"><?= mp_e(t('mpss_open')) ?></button></form>
                            <form method="post" action="mp-saved.php" class="mp-inline-form" data-confirm="<?= mp_e(t('mpss_remove_confirm')) ?>"><?= $csrf ?><input type="hidden" name="action" value="remove"><input type="hidden" name="id" value="<?= $rid ?>"><button class="mp-btn" type="submit"><?= mp_e(t('mpss_remove')) ?></button></form>
                        </div>
                        <details class="mpss-item__more">
                            <summary><?= mp_e(t('mpss_rename')) ?></summary>
                            <form method="post" action="mp-saved.php" class="mp-inline mpss-rename"><?= $csrf ?>
                                <input type="hidden" name="action" value="rename"><input type="hidden" name="id" value="<?= $rid ?>">
                                <label class="mp-visually-hidden" for="t<?= $rid ?>"><?= mp_e(t('mpss_rename')) ?></label>
                                <input class="mp-input" type="text" id="t<?= $rid ?>" name="title" maxlength="<?= MPSS_TITLE_MAX ?>" value="<?= mp_e($r['title']) ?>" required>
                                <button class="mp-btn" type="submit"><?= mp_e(t('mpss_rename_save')) ?></button>
                            </form>
                        </details>
                        <form method="post" action="mp-saved.php" class="mpss-notify"><?= $csrf ?>
                            <input type="hidden" name="action" value="notify"><input type="hidden" name="id" value="<?= $rid ?>">
                            <input type="hidden" name="notify" value="<?= (int) $r['notify_email'] === 1 ? '0' : '1' ?>">
                            <button class="mp-switch" type="submit" role="switch" aria-checked="<?= (int) $r['notify_email'] === 1 ? 'true' : 'false' ?>"<?= $verified ? '' : ' disabled' ?>>
                                <span class="mp-switch__track" aria-hidden="true"><span class="mp-switch__thumb"></span></span>
                                <span><?= mp_e(t('mpss_notify_label')) ?></span>
                            </button>
                        </form>
                    </li>
                <?php endforeach; ?>
            </ul>
        <?php endif; ?>
        <p class="mp-hint"><?= mp_e(t($emailOn ? 'mpss_notify_hint' : 'mpss_notify_hint_off')) ?></p>
    </div>
    <script>
    document.querySelectorAll('form[data-confirm]').forEach(function (f) {
        f.addEventListener('submit', function (e) { if (!window.confirm(f.getAttribute('data-confirm'))) { e.preventDefault(); } });
    });
    </script>
<?php mpb_close(); ?>
