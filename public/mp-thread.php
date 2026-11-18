<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: розмова з автором оголошення.
 *
 *   mp-thread.php?id=N         — розмова (лише учасник: покупець, автор; для оголошень платформи — employee/admin)
 *   mp-thread.php?listing=N    — «Написати автору»: наявна розмова (редірект) або форма першого повідомлення
 *   mp-thread.php?seller=N     — «Написати автору» зі сторінки продавця: вибір оголошення
 *
 * POST (CSRF): start | send | block | unblock | report | hide | unhide | mute | unmute.
 * Надсилання — fetch (Accept: application/json) із запасним варіантом без JS (303 назад на розмову).
 * Нові повідомлення — опитування mp-messages-poll.php (кожні msg_poll_seconds, пауза на прихованій вкладці).
 * Чужа розмова → 404 (без підказки, що вона існує). Сторінка приватна: no-store, noindex, без реклами.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mp-messages.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
msg_require_enabled($pdo);
msg_private_headers();

$isPost = ($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'POST';
$json = str_contains((string) ($_SERVER['HTTP_ACCEPT'] ?? ''), 'application/json');

if (!auth_check()) {
    if ($isPost) {
        http_response_code(401);
        if ($json) {
            header('Content-Type: application/json; charset=utf-8');
            echo json_encode(['ok' => false, 'error' => 'login', 'message' => t('msg_login_to_write')], JSON_UNESCAPED_UNICODE);
        }
        exit;
    }
}
$uid = mpb_require_login();   // гість → «Увійдіть, щоб написати» з поверненням сюди
$isStaff = mp_is_staff();
$lang = current_lang();

/** JSON-відповідь і вихід. */
$out = static function (int $status, array $data): never {
    http_response_code($status);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit;
};

/** Потрібна підтверджена пошта для надсилання (staff — ні). */
$needVerified = static function (?string $next) use ($pdo, $uid, $isStaff, $json, $out): void {
    if ($isStaff || mpv_is_verified($pdo, $uid)) {
        return;
    }
    if ($json) {
        $out(403, ['ok' => false, 'error' => 'verify', 'message' => t('msg_verify_needed'), 'verify_url' => mpv_page_url($next)]);
    }
    mpv_require_verified($pdo, $uid, $next);
};

// =========================================================================
// POST
// =========================================================================
if ($isPost) {
    if (!mp_csrf_verify()) {
        if ($json) {
            $out(403, ['ok' => false, 'error' => 'csrf', 'message' => t('mpb_err_csrf')]);
        }
        msg_message_page(403, t('msg_title'), '<p class="mp-text">' . mp_e(t('mpb_err_csrf')) . '</p>');
    }
    $action = is_string($_POST['action'] ?? null) ? (string) $_POST['action'] : '';
    $body = is_string($_POST['body'] ?? null) ? (string) $_POST['body'] : '';

    if ($action === 'start') {
        $listingId = (int) ($_POST['listing'] ?? 0);
        $needVerified('mp-thread.php?listing=' . $listingId);
        $listing = msg_listing($pdo, $listingId, $lang);
        $res = $listing !== null ? msg_start($pdo, $uid, $listing, $body) : ['status' => 'msg_err_listing', 'conv_id' => null];
        if ($res['status'] === 'ok' && $res['conv_id'] !== null) {
            if ($json) {
                $out(200, ['ok' => true, 'redirect' => 'mp-thread.php?id=' . $res['conv_id']]);
            }
            mpb_redirect('mp-thread.php?id=' . $res['conv_id']);
        }
        if ($json) {
            $out(422, ['ok' => false, 'error' => $res['status'], 'message' => t($res['status'])]);
        }
        $_SESSION['msg_draft'] = mb_substr($body, 0, 4000);
        mpb_flash('error', t($res['status']));
        mpb_redirect('mp-thread.php?listing=' . $listingId);
    }

    $convId = (int) ($_POST['id'] ?? 0);
    $conv = $convId > 0 ? msg_conversation($pdo, $convId) : null;
    $role = $conv !== null ? msg_access($conv, $uid) : null;
    if ($role === null) {
        if ($json) {
            $out(404, ['ok' => false, 'error' => 'notfound', 'message' => t('msg_err_notfound')]);
        }
        mp_not_found();
    }
    $back = 'mp-thread.php?id=' . $convId;
    $stateUid = msg_state_uid($role, $uid);
    $other = msg_counterpart_id($conv, $role);

    switch ($action) {
        case 'send':
            if ($role !== 'platform') {
                $needVerified($back);
            }
            $res = msg_send_in_conv($pdo, $conv, $role, $uid, $body);
            if ($res['status'] === 'ok') {
                if ($json) {
                    $since = max(0, (int) ($_POST['since'] ?? 0));
                    $rows = msg_messages($pdo, $conv, $role, $uid, $since, MSG_POLL_MAX);
                    $out(200, ['ok' => true, 'messages' => $rows, 'last_id' => msg_last_id($pdo, $convId)]);
                }
                mpb_redirect($back);
            }
            if ($json) {
                $out(422, ['ok' => false, 'error' => $res['status'], 'message' => t($res['status'])]);
            }
            $_SESSION['msg_draft'] = mb_substr($body, 0, 4000);
            mpb_flash('error', t($res['status']));
            mpb_redirect($back);

        case 'block':
            if ($other !== null && $role !== 'platform' && !($role === 'buyer' && $conv['seller_user_id'] === null)) {
                msg_block($pdo, $uid, $other);
                mpb_flash('ok', t('msg_blocked_done'));
            }
            mpb_redirect($back);

        case 'unblock':
            if ($other !== null && $role !== 'platform') {
                msg_unblock($pdo, $uid, $other);
                mpb_flash('ok', t('msg_unblocked_done'));
            }
            mpb_redirect($back);

        case 'report':
            if ($role === 'platform') {
                mpb_redirect($back);
            }
            $reason = is_string($_POST['reason'] ?? null) ? (string) $_POST['reason'] : '';
            $note = is_string($_POST['note'] ?? null) ? (string) $_POST['note'] : '';
            $mid = (int) ($_POST['message_id'] ?? 0);
            $r = msg_report($pdo, $conv, $role, $uid, $reason, $note, $mid > 0 ? $mid : null);
            mpb_flash($r === 'ok' ? 'ok' : 'error', t('msg_report_' . $r));
            mpb_redirect($back);

        case 'hide':
            msg_state_set($pdo, $convId, $stateUid, 'hidden_up_to_message_id', msg_last_id($pdo, $convId));
            mpb_flash('ok', t('msg_hidden_done'));
            mpb_redirect($role === 'platform' ? 'mp-inbox-admin.php' : 'mp-messages.php');

        case 'unhide':
            msg_state_set($pdo, $convId, $stateUid, 'hidden_up_to_message_id', 0);
            mpb_redirect($back);

        case 'mute':
        case 'unmute':
            msg_state_set($pdo, $convId, $stateUid, 'is_muted', $action === 'mute' ? 1 : 0);
            unset($_SESSION['msg_unread_cache']);
            mpb_flash('ok', t($action === 'mute' ? 'msg_muted_done' : 'msg_unmuted_done'));
            mpb_redirect($back);
    }
    mpb_redirect($back);
}

// =========================================================================
// GET: вибір оголошення продавця
// =========================================================================
$draft = is_string($_SESSION['msg_draft'] ?? null) ? (string) $_SESSION['msg_draft'] : '';
unset($_SESSION['msg_draft']);
$maxLen = max(1, (int) msg_cfg('msg_max_len'));

$sellerId = (int) ($_GET['seller'] ?? 0);
if ($sellerId > 0) {
    $st = $pdo->prepare(
        "SELECT l.id FROM mp_listings l WHERE l.seller_id = :s AND l.status = 'published' AND (l.expires_at IS NULL OR l.expires_at > NOW())
         AND l.contact_mode <> 'contacts_only' AND " . msg_listing_scope_sql() . ' ORDER BY l.published_at DESC, l.id DESC LIMIT 50'
    );
    $st->execute([':s' => $sellerId]);
    $ids = array_map('intval', $st->fetchAll(PDO::FETCH_COLUMN));
    if (count($ids) === 1) {
        mpb_redirect('mp-thread.php?listing=' . $ids[0]);
    }
    if ($ids === []) {
        msg_message_page(404, t('msg_write_author'), '<p class="mp-text">' . mp_e(t('msg_seller_no_listings')) . '</p>', 'marketplace.php');
    }
    msg_open(t('msg_write_author'));
    echo '<div class="mp-page mp-page--narrow"><h1 class="mp-title">' . mp_e(t('msg_write_author')) . '</h1><p class="mp-text">' . mp_e(t('msg_pick_listing')) . '</p><ul class="msg-list">';
    foreach ($ids as $lid) {
        $l = msg_listing($pdo, $lid, $lang);
        if ($l === null) {
            continue;
        }
        echo '<li class="msg-item"><a class="msg-item__link" href="mp-thread.php?listing=' . $lid . '">'
            . ($l['thumb'] !== null ? '<img class="msg-thumb" src="' . mp_e($l['thumb']) . '" alt="" loading="lazy">' : '<span class="msg-thumb" aria-hidden="true">✉</span>')
            . '<span class="msg-item__main"><span class="msg-item__title">' . mp_e($l['title']) . '</span></span></a></li>';
    }
    echo '</ul></div>';
    mpb_close();
    exit;
}

// =========================================================================
// GET: перше повідомлення з оголошення
// =========================================================================
$listingParam = (int) ($_GET['listing'] ?? 0);
if ($listingParam > 0) {
    $existing = msg_find_conversation($pdo, $listingParam, $uid);
    if ($existing !== null) {
        mpb_redirect('mp-thread.php?id=' . $existing);
    }
    $listing = msg_listing($pdo, $listingParam, $lang);
    $err = msg_can_start($pdo, $uid, $listing);
    if ($err !== '') {
        msg_message_page($err === 'msg_err_listing' ? 404 : 403, t('msg_write_author'), '<p class="mp-text">' . mp_e(t($err)) . '</p>', $listing['url'] ?? 'marketplace.php');
    }
    $needVerified('mp-thread.php?listing=' . $listingParam);
    msg_open(t('msg_write_author'));
    ?>
    <div class="mp-page mp-page--narrow msg-thread">
        <?= mpb_flash_html() ?>
        <a class="msg-card" href="<?= mp_e($listing['url']) ?>">
            <?= $listing['thumb'] !== null ? '<img class="msg-thumb" src="' . mp_e($listing['thumb']) . '" alt="" loading="lazy">' : '<span class="msg-thumb" aria-hidden="true">✉</span>' ?>
            <span><span class="msg-card__title"><?= mp_e($listing['title']) ?></span>
                <span class="msg-card__meta"><?= mp_e($listing['is_platform'] ? t('msg_to_platform') : t('msg_to_author')) ?></span></span>
        </a>
        <p class="msg-safety" role="note"><?= mp_e(t('msg_safety')) ?></p>
        <p class="msg-note"><?= mp_e(t('msg_start_hint')) ?></p>
        <form class="msg-compose" method="post" action="mp-thread.php" id="msg-compose">
            <?= mp_csrf_field() ?>
            <input type="hidden" name="action" value="start">
            <input type="hidden" name="listing" value="<?= (int) $listing['id'] ?>">
            <div class="msg-compose__field">
                <label class="visually-hidden" for="msgBody"><?= mp_e(t('msg_placeholder')) ?></label>
                <textarea id="msgBody" name="body" rows="3" maxlength="<?= $maxLen ?>" required placeholder="<?= mp_e(t('msg_placeholder')) ?>"><?= mp_e($draft) ?></textarea>
            </div>
            <button class="mp-btn mp-btn--primary" type="submit"><?= mp_e(t('msg_send')) ?></button>
        </form>
    </div>
    <?php
    mpb_close();
    exit;
}

// =========================================================================
// GET: розмова
// =========================================================================
$convId = (int) ($_GET['id'] ?? 0);
$conv = $convId > 0 ? msg_conversation($pdo, $convId) : null;
$role = $conv !== null ? msg_access($conv, $uid) : null;
if ($role === null) {
    mp_not_found();   // чужа чи неіснуюча розмова — однаково 404
}
$listing = msg_listing($pdo, (int) $conv['listing_id'], $lang);
$readonly = msg_is_readonly($conv, $listing);
$stateUid = msg_state_uid($role, $uid);
$state = msg_state($pdo, $convId, $stateUid);
$messages = msg_messages($pdo, $conv, $role, $uid);
$lastId = $messages !== [] ? (int) end($messages)['id'] : 0;
msg_mark_read($pdo, $convId, $stateUid, $lastId);
$other = msg_counterpart_id($conv, $role);
$otherIsPlatform = $role === 'buyer' && $conv['seller_user_id'] === null;
$otherLabel = $otherIsPlatform ? MSG_PLATFORM_LABEL : msg_user_label($pdo, $other);
$iBlocked = $other !== null && $role !== 'platform' && msg_is_blocked_by($pdo, $uid, $other);
$canBlock = $other !== null && $role !== 'platform' && !$otherIsPlatform;
$hidden = $state['hidden_up_to_message_id'] > 0 && $state['hidden_up_to_message_id'] >= $lastId;
$lastOtherId = 0;
foreach ($messages as $m) {
    if (!$m['mine'] && !$m['system']) {
        $lastOtherId = $m['id'];
    }
}
$pollSec = max(5, (int) msg_cfg('msg_poll_seconds'));
$jsPath = __DIR__ . '/assets/js/mp-thread.js';

msg_open(t('msg_title'));
?>
    <div class="mp-page mp-page--narrow msg-thread">
        <p><a class="mp-back" href="<?= $role === 'platform' ? 'mp-inbox-admin.php' : 'mp-messages.php' ?>">← <?= mp_e($role === 'platform' ? t('msg_platform_inbox') : t('msg_title')) ?></a></p>
        <?= mpb_flash_html() ?>
        <?php if ($listing !== null): ?>
            <a class="msg-card" href="<?= mp_e($listing['url']) ?>">
                <?= $listing['thumb'] !== null ? '<img class="msg-thumb" src="' . mp_e($listing['thumb']) . '" alt="" loading="lazy">' : '<span class="msg-thumb" aria-hidden="true">✉</span>' ?>
                <span><span class="msg-card__title"><?= mp_e($listing['title']) ?></span>
                    <span class="msg-card__meta"><?= mp_e(t('msg_with')) ?> <?= mp_e($otherLabel) ?><?= $listing['live'] ? '' : ' · ' . mp_e(t('msg_listing_closed')) ?></span></span>
            </a>
        <?php else: ?>
            <p class="msg-card"><span class="msg-card__title"><?= mp_e(t('msg_listing_removed')) ?></span></p>
        <?php endif; ?>

        <p class="msg-safety" role="note"><?= mp_e(t('msg_safety')) ?></p>
        <?php if ($hidden): ?>
            <form class="mp-alert" method="post" action="mp-thread.php"><?= mp_csrf_field() ?><input type="hidden" name="action" value="unhide"><input type="hidden" name="id" value="<?= $convId ?>">
                <?= mp_e(t('msg_hidden_note')) ?> <button class="mp-btn" type="submit"><?= mp_e(t('msg_unhide')) ?></button></form>
        <?php endif; ?>

        <ol class="msg-log" id="msgLog" aria-live="polite" aria-label="<?= mp_e(t('msg_title')) ?>">
            <?php foreach ($messages as $m): ?>
                <li class="msg-row<?= $m['mine'] ? ' msg-row--mine' : '' ?><?= $m['system'] ? ' msg-row--system' : '' ?><?= $m['platform'] ? ' msg-row--platform' : '' ?>" data-id="<?= $m['id'] ?>">
                    <div class="msg-bubble"><?php if ($m['label'] !== ''): ?><span class="msg-bubble__label"><?= mp_e($m['label']) ?></span><?php endif; ?><?= $m['html'] ?><time class="msg-bubble__time" datetime="<?= mp_e($m['iso']) ?>"><?= mp_e($m['time']) ?></time></div>
                </li>
            <?php endforeach; ?>
        </ol>
        <span id="msg-end"></span>

        <?php if ($readonly): ?>
            <p class="mp-alert"><?= mp_e(t('msg_readonly')) ?></p>
        <?php elseif ($iBlocked): ?>
            <p class="mp-alert"><?= mp_e(t('msg_you_blocked')) ?></p>
        <?php else: ?>
            <form class="msg-compose" method="post" action="mp-thread.php" id="msg-compose"
                  data-poll="mp-messages-poll.php?c=<?= $convId ?>" data-interval="<?= $pollSec ?>" data-last="<?= $lastId ?>"
                  data-error="<?= mp_e(t('msg_err_network')) ?>" data-max="<?= $maxLen ?>">
                <?= mp_csrf_field() ?>
                <input type="hidden" name="action" value="send">
                <input type="hidden" name="id" value="<?= $convId ?>">
                <input type="hidden" name="since" value="<?= $lastId ?>">
                <div class="msg-compose__field">
                    <label class="visually-hidden" for="msgBody"><?= mp_e(t('msg_placeholder')) ?></label>
                    <textarea id="msgBody" name="body" rows="1" maxlength="<?= $maxLen ?>" required placeholder="<?= mp_e(t('msg_placeholder')) ?>"><?= mp_e($draft) ?></textarea>
                    <span class="msg-compose__error" id="msgError" role="alert" hidden></span>
                </div>
                <button class="mp-btn mp-btn--primary" type="submit" aria-label="<?= mp_e(t('msg_send')) ?>"><?= mp_e(t('msg_send')) ?></button>
            </form>
        <?php endif; ?>

        <div class="msg-tools">
            <form method="post" action="mp-thread.php"><?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $convId ?>">
                <input type="hidden" name="action" value="<?= $state['is_muted'] === 1 ? 'unmute' : 'mute' ?>">
                <button class="mp-btn" type="submit"><?= mp_e(t($state['is_muted'] === 1 ? 'msg_unmute' : 'msg_mute')) ?></button></form>
            <?php if (!$hidden): ?>
            <form method="post" action="mp-thread.php" data-confirm="<?= mp_e(t('msg_hide_confirm')) ?>"><?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $convId ?>">
                <input type="hidden" name="action" value="hide"><button class="mp-btn" type="submit"><?= mp_e(t('msg_hide')) ?></button></form>
            <?php endif; ?>
            <?php if ($canBlock): ?>
            <form method="post" action="mp-thread.php"<?= $iBlocked ? '' : ' data-confirm="' . mp_e(t('msg_block_confirm')) . '"' ?>><?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $convId ?>">
                <input type="hidden" name="action" value="<?= $iBlocked ? 'unblock' : 'block' ?>">
                <button class="mp-btn" type="submit"><?= mp_e(t($iBlocked ? 'msg_unblock' : 'msg_block')) ?></button></form>
            <?php endif; ?>
        </div>

        <?php if ($role !== 'platform'): ?>
        <details class="msg-details">
            <summary><?= mp_e(t('msg_report')) ?></summary>
            <form method="post" action="mp-thread.php" class="mp-panel">
                <?= mp_csrf_field() ?>
                <input type="hidden" name="action" value="report">
                <input type="hidden" name="id" value="<?= $convId ?>">
                <input type="hidden" name="message_id" value="<?= $lastOtherId ?>">
                <label class="mp-label" for="msgReason"><?= mp_e(t('msg_report_reason')) ?></label>
                <select class="mp-input" id="msgReason" name="reason" required>
                    <?php foreach (MSG_REPORT_REASONS as $r): ?><option value="<?= mp_e($r) ?>"><?= mp_e(t('msg_reason_' . $r)) ?></option><?php endforeach; ?>
                </select>
                <label class="mp-label" for="msgNote"><?= mp_e(t('msg_report_note')) ?></label>
                <textarea class="mp-input" id="msgNote" name="note" rows="3" maxlength="500"></textarea>
                <p class="mp-hint"><?= mp_e(t('msg_report_hint')) ?></p>
                <p class="mp-actions msg-actions"><button class="mp-btn mp-btn--primary" type="submit"><?= mp_e(t('msg_report_send')) ?></button></p>
            </form>
        </details>
        <?php endif; ?>
    </div>
    <script src="/assets/js/mp-thread.js?v=<?= is_file($jsPath) ? (int) filemtime($jsPath) : 0 ?>" defer></script>
<?php
mpb_close();
