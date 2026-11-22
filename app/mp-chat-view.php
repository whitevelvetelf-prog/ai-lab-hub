<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: панель відкритої розмови для чату «Повідомлення» (public/mp-messages.php?c=N).
 *
 * Права колонка на комп'ютері, окрема «сторінка» з кнопкою «Назад» на телефоні. Доступ перевіряє викликач (msg_access).
 * Надсилання: форма POST на mp-thread.php (CSRF, multipart для вкладення); з JS — fetch (assets/js/mp-thread.js),
 * Enter — надіслати, Shift+Enter — новий рядок. Нові повідомлення — опитування mp-messages-poll.php.
 */

require_once __DIR__ . '/mp-messages.php';

/**
 * @param array<string,mixed> $conv
 * @param string $back  адреса «Назад» (список)
 */
function msg_chat_pane(PDO $pdo, array $conv, string $role, int $uid, string $back): void
{
    $lang = current_lang();
    $convId = (int) $conv['id'];
    $listing = msg_listing($pdo, (int) $conv['listing_id'], $lang);
    $readonly = msg_is_readonly($conv, $listing);
    $stateUid = msg_state_uid($role, $uid);
    $state = msg_state($pdo, $convId, $stateUid);
    $messages = msg_messages($pdo, $conv, $role, $uid);
    $lastId = $messages !== [] ? (int) end($messages)['id'] : 0;
    msg_mark_read($pdo, $convId, $stateUid, $lastId);
    $peerRead = msg_peer_read_id($pdo, $conv, $role);
    $other = msg_counterpart_id($conv, $role);
    $otherIsPlatform = $role === 'buyer' && $conv['seller_user_id'] === null;
    $otherLabel = $otherIsPlatform ? MSG_PLATFORM_LABEL : msg_user_label($pdo, $other);
    $iBlocked = $other !== null && $role !== 'platform' && msg_is_blocked_by($pdo, $uid, $other);
    $blockedMe = $other !== null && $role !== 'platform' && !$otherIsPlatform && msg_is_blocked_by($pdo, $other, $uid);
    $canBlock = $other !== null && $role !== 'platform' && !$otherIsPlatform;
    $hidden = $state['hidden_up_to_message_id'] > 0 && $state['hidden_up_to_message_id'] >= $lastId;
    $lastOtherId = 0;
    foreach ($messages as $m) {
        if (!$m['mine'] && !$m['system']) {
            $lastOtherId = $m['id'];
        }
    }
    $pollSec = max(4, (int) msg_cfg('msg_poll_seconds'));
    $maxLen = max(1, (int) msg_cfg('msg_max_len'));
    $attachOn = msg_chat_ready($pdo);
    $draft = is_string($_SESSION['msg_draft'] ?? null) ? (string) $_SESSION['msg_draft'] : '';
    unset($_SESSION['msg_draft']);
    $h = static fn(string $k): string => mp_e(t($k));
    ?>
        <section class="msg-pane" aria-label="<?= mp_e(t('msg_with') . ' ' . $otherLabel) ?>">
            <header class="msg-pane__head">
                <a class="msg-pane__back" href="<?= mp_e($back) ?>" aria-label="<?= $h('msg_back') ?>">←<span class="msg-pane__back-text"> <?= $h('msg_back') ?></span></a>
                <?php if ($listing !== null): ?>
                    <a class="msg-pane__listing" href="<?= mp_e($listing['url']) ?>">
                        <?= $listing['thumb'] !== null ? '<img class="msg-thumb msg-thumb--sm" src="' . mp_e($listing['thumb']) . '" alt="" loading="lazy">' : '<span class="msg-thumb msg-thumb--sm" aria-hidden="true">✉</span>' ?>
                        <span class="msg-pane__titles"><span class="msg-pane__title"><?= mp_e($listing['title']) ?></span>
                            <span class="msg-pane__meta"><?= $h('msg_with') ?> <?= mp_e($otherLabel) ?><?= $listing['live'] ? '' : ' · ' . $h('msg_listing_closed') ?></span></span>
                    </a>
                <?php else: ?>
                    <span class="msg-pane__listing"><span class="msg-pane__titles"><span class="msg-pane__title"><?= $h('msg_listing_removed') ?></span>
                        <span class="msg-pane__meta"><?= $h('msg_with') ?> <?= mp_e($otherLabel) ?></span></span></span>
                <?php endif; ?>
                <details class="msg-menu">
                    <summary class="msg-menu__btn" aria-label="<?= $h('msg_actions') ?>">⋯</summary>
                    <div class="msg-menu__list">
                        <form method="post" action="mp-thread.php"><?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $convId ?>">
                            <input type="hidden" name="action" value="<?= $state['is_muted'] === 1 ? 'unmute' : 'mute' ?>">
                            <button class="msg-menu__item" type="submit"><?= $h($state['is_muted'] === 1 ? 'msg_unmute' : 'msg_mute') ?></button></form>
                        <?php if (!$hidden): ?>
                        <form method="post" action="mp-thread.php" data-confirm="<?= $h('msg_hide_confirm') ?>"><?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $convId ?>">
                            <input type="hidden" name="action" value="hide"><button class="msg-menu__item" type="submit"><?= $h('msg_hide') ?></button></form>
                        <?php endif; ?>
                        <?php if ($canBlock): ?>
                        <form method="post" action="mp-thread.php"<?= $iBlocked ? '' : ' data-confirm="' . $h('msg_block_confirm') . '"' ?>><?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $convId ?>">
                            <input type="hidden" name="action" value="<?= $iBlocked ? 'unblock' : 'block' ?>">
                            <button class="msg-menu__item" type="submit"><?= $h($iBlocked ? 'msg_unblock' : 'msg_block') ?></button></form>
                        <?php endif; ?>
                        <?php if ($role !== 'platform'): ?>
                        <a class="msg-menu__item" href="#msgReport" data-open-report><?= $h('msg_report') ?></a>
                        <?php endif; ?>
                    </div>
                </details>
            </header>

            <?= mpb_flash_html() ?>
            <?php if ($hidden): ?>
                <form class="mp-alert" method="post" action="mp-thread.php"><?= mp_csrf_field() ?><input type="hidden" name="action" value="unhide"><input type="hidden" name="id" value="<?= $convId ?>">
                    <?= $h('msg_hidden_note') ?> <button class="mp-btn" type="submit"><?= $h('msg_unhide') ?></button></form>
            <?php endif; ?>

            <div class="msg-pane__scroll" id="msgScroll">
                <p class="msg-safety" role="note"><?= $h('msg_safety') ?></p>
                <ol class="msg-log" id="msgLog" aria-live="polite" aria-label="<?= $h('msg_title') ?>" data-peer-read="<?= $peerRead ?>">
                    <?php foreach ($messages as $m): ?>
                        <?= msg_row_html($m, $peerRead) ?>
                    <?php endforeach; ?>
                </ol>
                <span id="msg-end"></span>
            </div>

            <?php if ($readonly): ?>
                <p class="mp-alert msg-pane__notice"><?= $h('msg_readonly') ?></p>
            <?php elseif ($iBlocked): ?>
                <p class="mp-alert msg-pane__notice"><?= $h('msg_you_blocked') ?></p>
            <?php elseif ($blockedMe): ?>
                <p class="mp-alert msg-pane__notice"><?= $h('msg_err_not_accepting') ?></p>
            <?php else: ?>
                <form class="msg-compose" method="post" action="mp-thread.php" id="msg-compose" enctype="multipart/form-data" autocomplete="off"
                      data-poll="mp-messages-poll.php?c=<?= $convId ?>" data-interval="<?= $pollSec ?>" data-last="<?= $lastId ?>"
                      data-error="<?= $h('msg_err_network') ?>" data-max="<?= $maxLen ?>" data-max-file="<?= MSG_ATTACH_MAX_BYTES ?>"
                      data-err-size="<?= $h('msg_err_file_size') ?>" data-err-type="<?= $h('msg_err_file_type') ?>">
                    <?= mp_csrf_field() ?>
                    <input type="hidden" name="action" value="send">
                    <input type="hidden" name="id" value="<?= $convId ?>">
                    <input type="hidden" name="since" value="<?= $lastId ?>">
                    <?php if ($attachOn): ?>
                        <label class="msg-compose__attach" title="<?= $h('msg_attach_hint') ?>">
                            <input class="visually-hidden" type="file" name="attachment" id="msgFile" accept="image/jpeg,image/png,image/webp,application/pdf,.jpg,.jpeg,.png,.webp,.pdf">
                            <span aria-hidden="true">📎</span><span class="visually-hidden"><?= $h('msg_attach') ?></span>
                        </label>
                    <?php endif; ?>
                    <div class="msg-compose__field">
                        <label class="visually-hidden" for="msgBody"><?= $h('msg_placeholder') ?></label>
                        <span class="msg-compose__file" id="msgFileChip" hidden><span id="msgFileName"></span>
                            <button type="button" class="msg-compose__file-x" id="msgFileClear" aria-label="<?= $h('msg_attach_remove') ?>">×</button></span>
                        <textarea id="msgBody" name="body" rows="1" maxlength="<?= $maxLen ?>" autocomplete="off" autocorrect="on" spellcheck="true"
                                  enterkeyhint="send" placeholder="<?= $h('msg_placeholder_chat') ?>" data-placeholder-touch="<?= $h('msg_placeholder') ?>"><?= mp_e($draft) ?></textarea>
                        <span class="msg-compose__error" id="msgError" role="alert" hidden></span>
                    </div>
                    <button class="mp-btn mp-btn--primary msg-compose__send" type="submit" aria-label="<?= $h('msg_send') ?>"><span class="msg-compose__send-text"><?= $h('msg_send') ?></span><span class="msg-compose__send-icon" aria-hidden="true">➤</span></button>
                </form>
            <?php endif; ?>

            <?php if ($role !== 'platform'): ?>
            <details class="msg-details" id="msgReport">
                <summary><?= $h('msg_report') ?></summary>
                <form method="post" action="mp-thread.php" class="mp-panel">
                    <?= mp_csrf_field() ?>
                    <input type="hidden" name="action" value="report">
                    <input type="hidden" name="id" value="<?= $convId ?>">
                    <input type="hidden" name="message_id" value="<?= $lastOtherId ?>">
                    <label class="mp-label" for="msgReason"><?= $h('msg_report_reason') ?></label>
                    <select class="mp-input" id="msgReason" name="reason" required>
                        <?php foreach (MSG_REPORT_REASONS as $r): ?><option value="<?= mp_e($r) ?>"><?= $h('msg_reason_' . $r) ?></option><?php endforeach; ?>
                    </select>
                    <label class="mp-label" for="msgNote"><?= $h('msg_report_note') ?></label>
                    <textarea class="mp-input" id="msgNote" name="note" rows="3" maxlength="500" autocomplete="off"></textarea>
                    <p class="mp-hint"><?= $h('msg_report_hint') ?></p>
                    <p class="mp-actions msg-actions"><button class="mp-btn mp-btn--primary" type="submit"><?= $h('msg_report_send') ?></button></p>
                </form>
            </details>
            <?php endif; ?>
        </section>
    <?php
}
