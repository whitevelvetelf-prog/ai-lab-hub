<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM Marketplace: «Скарги на повідомлення» (employee / admin).
 *
 * Вкладки:
 *   new | reviewed   — скарги зі знімком до 30 останніх повідомлень на момент скарги (текст лише екранується, посилання
 *                      не клікабельні). Дії (POST + CSRF): «Закрито», «Попередити автора» (mpl_sanction warn),
 *                      «Обмежити надсилання повідомлень» (mp_user_flags msg_restricted на N днів, 0 — безстроково),
 *                      «Заблокувати акаунт» (mpl_sanction block). Співробітників не обмежуємо.
 *   suspicious       — активні автопрапори «Підозріла активність» (тимчасово без нових розмов) і обмеження надсилання;
 *                      «Зняти» (is_active = 0).
 *   log              — журнал повного перегляду розмов (mp_admin_access_log). ЛИШЕ admin.
 * Повний перегляд розмови — тільки кнопкою з обов'язковою причиною: запис у журнал, доступ на 10 хв у сесії.
 * Вкладення (міграція № 30) — посилання на mp-attachment.php (admin/employee: лише розмови зі скаргою або з записаною причиною).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mp-messages.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
msg_require_enabled($pdo);
msg_private_headers();
mpb_require_login();
mp_require_staff();
$actorId = (int) auth_user_id();
$isAdmin = mp_live_role() === 'admin';

$tabs = ['new' => t('msg_rep_tab_new'), 'reviewed' => t('msg_rep_tab_reviewed'), 'suspicious' => t('msg_rep_tab_susp')];
if ($isAdmin) {
    $tabs['log'] = t('msg_rep_tab_log');
}
$tab = isset($tabs[$_GET['tab'] ?? '']) ? (string) $_GET['tab'] : 'new';

/** Звинувачений у скарзі: співрозмовник автора скарги. */
$accused = static function (array $rep): ?int {
    $snap = json_decode((string) ($rep['snapshot'] ?? ''), true);
    $buyer = (int) ($rep['buyer_id'] ?? ($snap['buyer_id'] ?? 0));
    $seller = $rep['seller_user_id'] ?? ($snap['seller_user_id'] ?? null);
    if ((int) $rep['reporter_id'] === $buyer) {
        return $seller !== null ? (int) $seller : null;
    }

    return $buyer > 0 ? $buyer : null;
};
$isStaffUser = static function (int $userId) use ($pdo): bool {
    $st = $pdo->prepare('SELECT role FROM users WHERE id = :u');
    $st->execute([':u' => $userId]);

    return in_array((string) $st->fetchColumn(), ['employee', 'admin'], true);
};

// --- Дії ---------------------------------------------------------------------------------------
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!mp_csrf_verify()) {
        http_response_code(403);
        exit('Forbidden');
    }
    $action = (string) ($_POST['action'] ?? '');
    $rid = (int) ($_POST['report_id'] ?? 0);
    $note = mb_substr(trim(is_string($_POST['note'] ?? null) ? (string) $_POST['note'] : ''), 0, 300);

    if ($action === 'flag_clear') {
        msg_flag_clear($pdo, (int) ($_POST['flag_id'] ?? 0));
        mpb_flash('ok', t('msg_rep_done'));
        mpb_redirect('mp-message-reports.php?tab=suspicious');
    }
    if ($action === 'view') {
        $cid = (int) ($_POST['conversation_id'] ?? 0);
        $reason = mb_substr(trim(is_string($_POST['reason'] ?? null) ? (string) $_POST['reason'] : ''), 0, 300);
        if ($cid <= 0 || mb_strlen($reason) < 5 || msg_conversation($pdo, $cid) === null) {
            mpb_flash('error', t('msg_rep_view_reason_needed'));
            mpb_redirect('mp-message-reports.php?tab=' . $tab);
        }
        msg_access_log($pdo, $actorId, $cid, 'view_full', $reason);
        $_SESSION['msg_admin_view'][$cid] = time() + 600;
        mpb_redirect('mp-message-reports.php?view=' . $cid);
    }

    $st = $pdo->prepare('SELECT r.*, c.buyer_id, c.seller_user_id FROM mp_message_reports r LEFT JOIN mp_conversations c ON c.id = r.conversation_id WHERE r.id = :id');
    $st->execute([':id' => $rid]);
    $rep = $st->fetch(PDO::FETCH_ASSOC);
    if ($rep === false) {
        mpb_flash('error', t('msg_rep_failed'));
        mpb_redirect('mp-message-reports.php');
    }
    $target = $accused($rep);
    $ok = true;
    if (in_array($action, ['warn', 'restrict', 'block'], true)) {
        if ($target === null || $isStaffUser($target)) {
            $ok = false;
        } elseif ($action === 'warn') {
            $ok = mpl_sanction($pdo, $target, 'warn', 0, $note !== '' ? $note : t('msg_rep_warn_default'), $actorId);
        } elseif ($action === 'restrict') {
            $days = max(0, min(3650, (int) ($_POST['days'] ?? 7)));
            msg_flag_set($pdo, $target, MSG_FLAG_RESTRICT, $days > 0 ? $days * 24 : null, 'report #' . $rid . ($note !== '' ? ': ' . $note : ''), $actorId);
        } else {
            $ok = mpl_sanction($pdo, $target, 'block', 0, $note !== '' ? $note : t('msg_rep_block_default'), $actorId);
        }
    } elseif ($action !== 'close') {
        $ok = false;
    }
    if ($ok) {
        $pdo->prepare("UPDATE mp_message_reports SET status = 'reviewed', handled_by = :a WHERE id = :id")->execute([':a' => $actorId, ':id' => $rid]);
    }
    mpb_flash($ok ? 'ok' : 'error', t($ok ? 'msg_rep_done' : 'msg_rep_failed'));
    mpb_redirect('mp-message-reports.php?tab=' . ($rep['status'] === 'new' ? 'new' : 'reviewed'));
}

/** Рядок знімка/розмови для показу адміністрації: лише екранований текст (посилання не клікабельні). */
$renderMsg = static function (array $m, ?int $buyer, ?int $seller) use ($pdo): string {
    $sid = $m['sender_id'] ?? null;
    if ((int) ($m['is_system'] ?? 0) === 1) {
        $who = t('msg_system_note');
    } elseif ($sid === null) {
        $who = MSG_PLATFORM_LABEL;
    } else {
        $who = msg_user_label($pdo, (int) $sid) . ' (#' . (int) $sid . ', ' . ((int) $sid === $buyer ? t('msg_role_buyer') : ((int) $sid === $seller ? t('msg_role_author') : '?')) . ')';
    }

    return '<li class="msg-row"><div class="msg-bubble"><span class="msg-bubble__label">' . mp_e($who) . ' · ' . mp_e((string) $m['created_at']) . '</span>'
        . (!empty($m['attachment_name']) ? '<a class="msg-att msg-att--file" href="mp-attachment.php?m=' . (int) $m['id'] . '" target="_blank" rel="noopener">'
            . '<span class="msg-att__icon" aria-hidden="true">' . ((string) ($m['attachment_mime'] ?? '') === 'application/pdf' ? 'PDF' : 'IMG') . '</span>'
            . '<span class="msg-att__name">' . mp_e((string) $m['attachment_name']) . '</span></a>' : '')
        . nl2br(htmlspecialchars((string) $m['body'], ENT_QUOTES | ENT_SUBSTITUTE), false) . '</div></li>';
};

// --- Повний перегляд розмови (після причини) ---------------------------------------------------
$viewId = (int) ($_GET['view'] ?? 0);
if ($viewId > 0) {
    $allowed = (int) ($_SESSION['msg_admin_view'][$viewId] ?? 0) > time();
    $conv = msg_conversation($pdo, $viewId);
    if (!$allowed || $conv === null) {
        mpb_flash('error', t('msg_rep_view_reason_needed'));
        mpb_redirect('mp-message-reports.php');
    }
    $listing = msg_listing($pdo, (int) $conv['listing_id']);
    $st = $pdo->prepare('SELECT id, sender_id, sender_label, body, is_system, created_at' . (msg_chat_ready($pdo) ? ', attachment_name, attachment_mime' : '')
        . ' FROM mp_messages WHERE conversation_id = :c ORDER BY id LIMIT 2000');
    $st->execute([':c' => $viewId]);
    msg_open(t('msg_rep_view_title'), '');
    echo '<div class="mp-page mp-page--narrow"><p><a class="mp-back" href="mp-message-reports.php">← ' . mp_e(t('msg_reports_title')) . '</a></p>'
        . '<h1 class="mp-title">' . mp_e(t('msg_rep_view_title')) . ' #' . $viewId . '</h1>'
        . '<p class="mp-alert">' . mp_e(t('msg_rep_view_logged')) . '</p>'
        . '<p class="msg-note">' . mp_e(($listing['title'] ?? t('msg_listing_removed'))) . ' · ' . mp_e(t('msg_role_buyer')) . ': ' . mp_e(msg_user_label($pdo, (int) $conv['buyer_id']))
        . ' · ' . mp_e(t('msg_role_author')) . ': ' . mp_e($conv['seller_user_id'] === null ? MSG_PLATFORM_LABEL : msg_user_label($pdo, (int) $conv['seller_user_id'])) . '</p><ol class="msg-log">';
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $m) {
        echo $renderMsg($m, (int) $conv['buyer_id'], $conv['seller_user_id'] !== null ? (int) $conv['seller_user_id'] : null);
    }
    echo '</ol></div>';
    mpb_close();
    exit;
}

msg_open(t('msg_reports_title'), '');
?>
    <div class="mp-page">
        <p><a class="mp-back" href="account.php#acc-crm">← CRM</a></p>
        <h1 class="mp-title"><?= mp_e(t('msg_reports_title')) ?></h1>
        <?= mpb_flash_html() ?>
        <nav class="msg-tabs">
            <?php foreach ($tabs as $k => $label): ?>
                <a class="mp-tab<?= $k === $tab ? ' is-active' : '' ?>" href="mp-message-reports.php?tab=<?= $k ?>"><?= mp_e($label) ?></a>
            <?php endforeach; ?>
            <a class="mp-tab" href="mp-inbox-admin.php"><?= mp_e(t('msg_platform_inbox')) ?></a>
        </nav>

<?php if ($tab === 'new' || $tab === 'reviewed'):
    $st = $pdo->prepare('SELECT r.*, c.buyer_id, c.seller_user_id, c.listing_id FROM mp_message_reports r LEFT JOIN mp_conversations c ON c.id = r.conversation_id
                         WHERE r.status = :s ORDER BY r.id DESC LIMIT 100');
    $st->execute([':s' => $tab]);
    $reports = $st->fetchAll(PDO::FETCH_ASSOC);
    if ($reports === []): ?>
        <p class="mp-text"><?= mp_e(t('msg_rep_empty')) ?></p>
    <?php endif;
    foreach ($reports as $rep):
        $snap = json_decode((string) $rep['snapshot'], true);
        $buyer = (int) ($rep['buyer_id'] ?? ($snap['buyer_id'] ?? 0));
        $seller = $rep['seller_user_id'] ?? ($snap['seller_user_id'] ?? null);
        $target = $accused($rep); ?>
        <section class="mp-panel">
            <h2 class="mp-panel__title">#<?= (int) $rep['id'] ?> · <?= mp_e(t('msg_reason_' . $rep['reason'])) ?> · <?= mp_e((string) $rep['created_at']) ?></h2>
            <p class="msg-note"><?= mp_e(t('msg_rep_reporter')) ?>: <?= mp_e(msg_user_label($pdo, (int) $rep['reporter_id'])) ?> (#<?= (int) $rep['reporter_id'] ?>)
                · <?= mp_e(t('msg_rep_accused')) ?>: <?= $target !== null ? mp_e(msg_user_label($pdo, $target)) . ' (#' . $target . ')' : mp_e(MSG_PLATFORM_LABEL) ?>
                · <?= mp_e(t('msg_rep_conv')) ?> #<?= (int) $rep['conversation_id'] ?></p>
            <?php if (!empty($rep['note'])): ?><p class="mp-text"><strong><?= mp_e(t('msg_report_note')) ?>:</strong> <?= mp_e((string) $rep['note']) ?></p><?php endif; ?>
            <?php if (is_array($snap) && !empty($snap['messages'])): ?>
                <details class="msg-details" open><summary><?= mp_e(t('msg_rep_snapshot')) ?> (<?= count($snap['messages']) ?>)</summary>
                    <ol class="msg-log msg-snapshot"><?php foreach ($snap['messages'] as $m) { echo $renderMsg($m, $buyer, $seller !== null ? (int) $seller : null); } ?></ol>
                </details>
            <?php else: ?>
                <p class="msg-note"><?= mp_e(t('msg_rep_no_snapshot')) ?></p>
            <?php endif; ?>
            <?php if ($tab === 'new'): ?>
            <form method="post" action="mp-message-reports.php" class="msg-tools">
                <?= mp_csrf_field() ?><input type="hidden" name="report_id" value="<?= (int) $rep['id'] ?>">
                <input class="mp-input" type="text" name="note" maxlength="300" placeholder="<?= mp_e(t('msg_rep_note_ph')) ?>" aria-label="<?= mp_e(t('msg_rep_note_ph')) ?>">
                <button class="mp-btn" type="submit" name="action" value="close"><?= mp_e(t('msg_rep_close')) ?></button>
                <?php if ($target !== null): ?>
                    <button class="mp-btn" type="submit" name="action" value="warn"><?= mp_e(t('msg_rep_warn')) ?></button>
                    <label class="msg-note"><?= mp_e(t('msg_rep_days')) ?> <input class="mp-input mp-input--short" type="number" name="days" min="0" max="3650" value="7"></label>
                    <button class="mp-btn" type="submit" name="action" value="restrict"><?= mp_e(t('msg_rep_restrict')) ?></button>
                    <button class="mp-btn" type="submit" name="action" value="block" data-confirm="<?= mp_e(t('msg_rep_block_confirm')) ?>"><?= mp_e(t('msg_rep_block')) ?></button>
                <?php endif; ?>
            </form>
            <?php endif; ?>
            <?php if ($rep['buyer_id'] !== null): ?>
            <details class="msg-details"><summary><?= mp_e(t('msg_rep_view_full')) ?></summary>
                <form method="post" action="mp-message-reports.php?tab=<?= $tab ?>" class="msg-tools">
                    <?= mp_csrf_field() ?><input type="hidden" name="action" value="view"><input type="hidden" name="conversation_id" value="<?= (int) $rep['conversation_id'] ?>">
                    <input class="mp-input" type="text" name="reason" required minlength="5" maxlength="300" placeholder="<?= mp_e(t('msg_rep_view_reason')) ?>" aria-label="<?= mp_e(t('msg_rep_view_reason')) ?>">
                    <button class="mp-btn" type="submit"><?= mp_e(t('msg_rep_view_open')) ?></button>
                </form>
            </details>
            <?php endif; ?>
        </section>
    <?php endforeach; ?>

<?php elseif ($tab === 'suspicious'):
    $st = $pdo->query("SELECT f.* FROM mp_user_flags f WHERE f.is_active = 1 AND (f.until_at IS NULL OR f.until_at > NOW()) ORDER BY f.id DESC LIMIT 200");
    $flags = $st->fetchAll(PDO::FETCH_ASSOC); ?>
        <p class="msg-note"><?= mp_e(t('msg_rep_susp_hint')) ?></p>
        <?php if ($flags === []): ?><p class="mp-text"><?= mp_e(t('msg_rep_empty')) ?></p><?php else: ?>
        <div class="msg-table-wrap"><table class="msg-table">
            <tr><th><?= mp_e(t('msg_user')) ?></th><th><?= mp_e(t('msg_rep_flag')) ?></th><th><?= mp_e(t('msg_rep_until')) ?></th><th><?= mp_e(t('msg_report_note')) ?></th><th></th></tr>
            <?php foreach ($flags as $f): ?>
                <tr><td><?= mp_e(msg_user_label($pdo, (int) $f['user_id'])) ?> (#<?= (int) $f['user_id'] ?>)</td>
                    <td><?= mp_e(t($f['flag'] === MSG_FLAG_RESTRICT ? 'msg_rep_flag_restrict' : 'msg_rep_flag_newconv')) ?></td>
                    <td><?= mp_e((string) ($f['until_at'] ?? '∞')) ?></td><td><?= mp_e((string) $f['note']) ?></td>
                    <td><form method="post" action="mp-message-reports.php"><?= mp_csrf_field() ?><input type="hidden" name="action" value="flag_clear"><input type="hidden" name="flag_id" value="<?= (int) $f['id'] ?>">
                        <button class="mp-btn" type="submit"><?= mp_e(t('msg_rep_flag_clear')) ?></button></form></td></tr>
            <?php endforeach; ?>
        </table></div>
        <?php endif; ?>

<?php elseif ($tab === 'log' && $isAdmin):
    $rows = $pdo->query('SELECT l.*, u.name AS admin_name FROM mp_admin_access_log l LEFT JOIN users u ON u.id = l.admin_id ORDER BY l.id DESC LIMIT 300')->fetchAll(PDO::FETCH_ASSOC); ?>
        <p class="msg-note"><?= mp_e(t('msg_rep_log_hint')) ?></p>
        <div class="msg-table-wrap"><table class="msg-table">
            <tr><th><?= mp_e(t('msg_rep_when')) ?></th><th><?= mp_e(t('msg_rep_who')) ?></th><th><?= mp_e(t('msg_rep_conv')) ?></th><th><?= mp_e(t('msg_rep_action')) ?></th><th><?= mp_e(t('msg_rep_view_reason')) ?></th></tr>
            <?php foreach ($rows as $r): ?>
                <tr><td><?= mp_e((string) $r['created_at']) ?></td><td><?= mp_e((string) ($r['admin_name'] ?? '#' . $r['admin_id'])) ?></td>
                    <td>#<?= (int) $r['conversation_id'] ?></td><td><?= mp_e((string) $r['action']) ?></td><td><?= mp_e((string) $r['reason']) ?></td></tr>
            <?php endforeach; ?>
        </table></div>
<?php endif; ?>
    </div>
<?php
mpb_close();
