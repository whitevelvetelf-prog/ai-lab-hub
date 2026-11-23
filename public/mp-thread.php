<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: розмова з автором оголошення.
 *
 *   mp-thread.php?id=N         — розмова: покупець і автор → чат mp-messages.php?c=N (302); скринька платформи
 *                                (employee/admin, оголошення платформи) — тут, та сама панель app/mp-chat-view.php
 *   mp-thread.php?listing=N    — «Написати автору»: наявна розмова (редірект) або форма першого повідомлення
 *   mp-thread.php?seller=N     — «Написати автору» зі сторінки продавця: вибір оголошення
 *
 * POST (CSRF): start | send | block | unblock | report | hide | unhide | mute | unmute. start і send приймають вкладення
 * (поле attachment: jpg/png/webp/pdf ≤ 5 МБ, перевірка за вмістом — msg_attach_inspect).
 * Надсилання — fetch (Accept: application/json) із запасним варіантом без JS (303 назад на розмову).
 * Нові повідомлення — опитування mp-messages-poll.php (кожні msg_poll_seconds, пауза на прихованій вкладці).
 * Чужа розмова → 404 (без підказки, що вона існує). Сторінка приватна: no-store, noindex, без реклами.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mp-messages.php';
require_once __DIR__ . '/../app/mp-chat-view.php';

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
    // Вкладення: лише для start/send; помилка перевірки — одразу відповідь (повідомлення не надсилається).
    $attach = in_array($action, ['start', 'send'], true) ? msg_attach_from_request($pdo) : null;
    $attachErr = is_string($attach) ? $attach : null;
    $attach = is_array($attach) ? $attach : null;

    if ($action === 'start') {
        $listingId = (int) ($_POST['listing'] ?? 0);
        $needVerified('mp-thread.php?listing=' . $listingId);
        $listing = msg_listing($pdo, $listingId, $lang);
        $res = $attachErr !== null ? ['status' => $attachErr, 'conv_id' => null]
            : ($listing !== null ? msg_start($pdo, $uid, $listing, $body, $attach) : ['status' => 'msg_err_listing', 'conv_id' => null]);
        if ($res['status'] === 'ok' && $res['conv_id'] !== null) {
            if ($json) {
                $out(200, ['ok' => true, 'redirect' => 'mp-messages.php?c=' . $res['conv_id']]);
            }
            mpb_redirect('mp-messages.php?c=' . $res['conv_id']);
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
    $back = $role === 'platform' ? 'mp-thread.php?id=' . $convId : 'mp-messages.php?c=' . $convId;
    $stateUid = msg_state_uid($role, $uid);
    $other = msg_counterpart_id($conv, $role);

    switch ($action) {
        case 'send':
            if ($role !== 'platform') {
                $needVerified($back);
            }
            $res = $attachErr !== null ? ['status' => $attachErr, 'conv_id' => $convId] : msg_send_in_conv($pdo, $conv, $role, $uid, $body, $attach);
            if ($res['status'] === 'ok') {
                if ($json) {
                    $since = max(0, (int) ($_POST['since'] ?? 0));
                    $peer = msg_peer_read_id($pdo, $conv, $role);
                    $rows = array_map(static fn(array $m): array => $m + ['row_html' => msg_row_html($m, $peer)], msg_messages($pdo, $conv, $role, $uid, $since, MSG_POLL_MAX));
                    $out(200, ['ok' => true, 'messages' => $rows, 'last_id' => msg_last_id($pdo, $convId), 'peer_read' => $peer]);
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
        mpb_redirect('mp-messages.php?c=' . $existing);
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
        <form class="msg-compose msg-compose--start" method="post" action="mp-thread.php" id="msg-compose" enctype="multipart/form-data" autocomplete="off"
              data-max-file="<?= MSG_ATTACH_MAX_BYTES ?>" data-err-size="<?= mp_e(t('msg_err_file_size')) ?>" data-err-type="<?= mp_e(t('msg_err_file_type')) ?>"<?= msg_emoji_attr() ?>>
            <?= mp_csrf_field() ?>
            <input type="hidden" name="action" value="start">
            <input type="hidden" name="listing" value="<?= (int) $listing['id'] ?>">
            <?php if (msg_chat_ready($pdo)): ?>
                <label class="msg-compose__attach" title="<?= mp_e(t('msg_attach_hint')) ?>">
                    <input class="visually-hidden" type="file" name="attachment" id="msgFile" accept="image/jpeg,image/png,image/webp,application/pdf,.jpg,.jpeg,.png,.webp,.pdf">
                    <span aria-hidden="true">📎</span><span class="visually-hidden"><?= mp_e(t('msg_attach')) ?></span>
                </label>
            <?php endif; ?>
            <div class="msg-compose__field">
                <label class="visually-hidden" for="msgBody"><?= mp_e(t('msg_placeholder')) ?></label>
                <span class="msg-compose__file" id="msgFileChip" hidden><span id="msgFileName"></span>
                    <button type="button" class="msg-compose__file-x" id="msgFileClear" aria-label="<?= mp_e(t('msg_attach_remove')) ?>">×</button></span>
                <textarea id="msgBody" name="body" rows="3" maxlength="<?= $maxLen ?>" autocomplete="off" enterkeyhint="send" placeholder="<?= mp_e(t('msg_placeholder_chat')) ?>" data-placeholder-touch="<?= mp_e(t('msg_placeholder')) ?>"><?= mp_e($draft) ?></textarea>
                <span class="msg-compose__error" id="msgError" role="alert" hidden></span>
            </div>
            <button class="mp-btn mp-btn--primary" type="submit"><?= mp_e(t('msg_send')) ?></button>
        </form>
    </div>
    <script src="/assets/js/mp-thread.js?v=<?= is_file(__DIR__ . '/assets/js/mp-thread.js') ? (int) filemtime(__DIR__ . '/assets/js/mp-thread.js') : 0 ?>" defer></script>
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
if ($role !== 'platform') {
    mpb_redirect('mp-messages.php?c=' . $convId);   // покупець / автор — чат у кабінеті (посилання з листів ведуть сюди)
}
$jsPath = __DIR__ . '/assets/js/mp-thread.js';

msg_open(t('msg_platform_inbox'), '');
?>
    <div class="msg-chat msg-chat--open msg-chat--single">
        <div class="msg-chat__main">
            <?php msg_chat_pane($pdo, $conv, $role, $uid, 'mp-inbox-admin.php'); ?>
        </div>
    </div>
    <script src="/assets/js/mp-thread.js?v=<?= is_file($jsPath) ? (int) filemtime($jsPath) : 0 ?>" defer></script>
<?php
mpb_close();
