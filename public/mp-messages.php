<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: «Повідомлення» — чат у кабінеті (список розмов + відкрита розмова).
 *
 *   mp-messages.php?tab=all|unread|archive[&page=N][&c=ID]
 *
 * Ліва колонка — розмови користувача (назва оголошення, співрозмовник, останнє повідомлення, час, непрочитані), за
 * останньою активністю. Права — відкрита розмова ?c=ID (app/mp-chat-view.php): поле вводу, Enter — надіслати,
 * Shift+Enter — новий рядок, вкладення. На телефоні — дві «сторінки»: список → розмова з кнопкою «Назад».
 * Список оновлюється без перезавантаження (assets/js/msg-unread.js, кожні msg_unread_poll_seconds), відкрита розмова —
 * кожні msg_poll_seconds (assets/js/mp-thread.js). Лише свої розмови; чужа ?c → 404. Приватна сторінка.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mp-messages.php';
require_once __DIR__ . '/../app/mp-chat-view.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
msg_require_enabled($pdo);
msg_private_headers();
$uid = mpb_require_login();

$tabs = ['all' => t('msg_tab_all'), 'unread' => t('msg_tab_unread'), 'archive' => t('msg_tab_archive')];
$tab = isset($tabs[$_GET['tab'] ?? '']) ? (string) $_GET['tab'] : 'all';
$page = max(1, (int) ($_GET['page'] ?? 1));

$convId = (int) ($_GET['c'] ?? 0);
$conv = $convId > 0 ? msg_conversation($pdo, $convId) : null;
$role = $conv !== null ? msg_access($conv, $uid) : null;
if ($convId > 0 && $role === null) {
    mp_not_found();   // чужа чи неіснуюча розмова — однаково 404
}
if ($role === 'platform') {
    mpb_redirect('mp-thread.php?id=' . $convId);   // скринька платформи (employee/admin) — окрема сторінка
}

$rows = msg_inbox($pdo, $uid, $tab, $page);
$hasMore = count($rows) > MSG_PAGE_SIZE;
$rows = array_slice($rows, 0, MSG_PAGE_SIZE);
$dayFmt = current_lang() === 'uk' ? 'd.m.y' : 'y-m-d';   // сьогодні — лише час
$today = date('Y-m-d');
$base = 'mp-messages.php?tab=' . $tab . ($page > 1 ? '&page=' . $page : '');
$jsPath = __DIR__ . '/assets/js/mp-thread.js';

msg_open(t('msg_title'), '');
?>
    <div class="msg-chat<?= $conv !== null ? ' msg-chat--open' : '' ?>" id="msgChat" data-list-poll="1">
        <aside class="msg-chat__list" aria-label="<?= mp_e(t('msg_conversations')) ?>">
            <div class="msg-chat__list-head">
                <h1 class="msg-chat__h1"><?= mp_e(t('msg_title')) ?></h1>
                <a class="msg-chat__settings" href="mp-notify-settings.php" title="<?= mp_e(t('msg_settings')) ?>" aria-label="<?= mp_e(t('msg_settings')) ?>">⚙</a>
            </div>
            <?= $conv === null ? mpb_flash_html() : '' ?>
            <nav class="msg-tabs" aria-label="<?= mp_e(t('msg_conversations')) ?>">
                <?php foreach ($tabs as $k => $label): ?>
                    <a class="mp-tab<?= $k === $tab ? ' is-active' : '' ?>" href="mp-messages.php?tab=<?= $k ?>"<?= $k === $tab ? ' aria-current="page"' : '' ?>><?= mp_e($label) ?></a>
                <?php endforeach; ?>
            </nav>
            <p class="msg-chat__fresh" id="msgListFresh" hidden><a href="<?= mp_e($base . ($conv !== null ? '&c=' . $convId : '')) ?>"><?= mp_e(t('msg_list_new')) ?></a></p>

            <?php if ($rows === []): ?>
                <p class="mp-text msg-chat__empty"><?= mp_e(t($tab === 'archive' ? 'msg_empty_archive' : ($tab === 'unread' ? 'msg_empty_unread' : 'msg_empty'))) ?></p>
            <?php else: ?>
                <ul class="msg-list" id="msgList">
                    <?php foreach ($rows as $r): $l = $r['listing']; $ts = strtotime($r['time']) ?: time(); ?>
                        <li class="msg-item<?= $r['unread'] > 0 ? ' msg-item--unread' : '' ?><?= $r['id'] === $convId ? ' is-current' : '' ?>" data-conv="<?= (int) $r['id'] ?>" data-last="<?= (int) $r['last_message_id'] ?>">
                            <a class="msg-item__link" href="<?= mp_e($base . '&c=' . (int) $r['id']) ?>"<?= $r['id'] === $convId ? ' aria-current="true"' : '' ?>>
                                <?= $l !== null && $l['thumb'] !== null ? '<img class="msg-thumb" src="' . mp_e($l['thumb']) . '" alt="" loading="lazy">' : '<span class="msg-thumb" aria-hidden="true">✉</span>' ?>
                                <span class="msg-item__main">
                                    <span class="msg-item__title"><?= mp_e($l['title'] ?? t('msg_listing_removed')) ?></span>
                                    <span class="msg-item__meta"><?= mp_e($r['counterpart']) ?><?= $r['muted'] ? ' · ' . mp_e(t('msg_muted_short')) : '' ?></span>
                                    <span class="msg-item__preview" data-preview><?= $r['last_mine'] ? mp_e(t('msg_you')) . ': ' : '' ?><?= mp_e($r['preview']) ?></span>
                                </span>
                                <span class="msg-item__side">
                                    <time data-time datetime="<?= mp_e(date('c', $ts)) ?>"><?= mp_e(date(date('Y-m-d', $ts) === $today ? 'H:i' : $dayFmt, $ts)) ?></time>
                                    <span class="msg-badge" data-unread aria-label="<?= mp_e(sprintf(t('msg_unread_aria'), $r['unread'])) ?>"<?= $r['unread'] > 0 ? '' : ' hidden' ?>><?= $r['unread'] > 99 ? '99+' : $r['unread'] ?></span>
                                </span>
                            </a>
                        </li>
                    <?php endforeach; ?>
                </ul>
                <p class="mp-actions">
                    <?php if ($page > 1): ?><a class="mp-btn" href="mp-messages.php?tab=<?= $tab ?>&amp;page=<?= $page - 1 ?>">← <?= mp_e(t('msg_prev')) ?></a><?php endif; ?>
                    <?php if ($hasMore): ?><a class="mp-btn" href="mp-messages.php?tab=<?= $tab ?>&amp;page=<?= $page + 1 ?>"><?= mp_e(t('msg_next')) ?> →</a><?php endif; ?>
                </p>
            <?php endif; ?>
            <p class="msg-note"><?= mp_e(t('msg_privacy_note')) ?></p>
        </aside>

        <div class="msg-chat__main">
            <?php if ($conv !== null): ?>
                <?php msg_chat_pane($pdo, $conv, $role, $uid, $base); ?>
            <?php else: ?>
                <div class="msg-chat__placeholder">
                    <p class="msg-chat__placeholder-icon" aria-hidden="true">✉</p>
                    <p><?= mp_e(t($rows === [] ? 'msg_start_from_listing' : 'msg_pick_conversation')) ?></p>
                </div>
            <?php endif; ?>
        </div>
    </div>
    <?php if ($conv !== null): ?>
    <script src="/assets/js/mp-thread.js?v=<?= is_file($jsPath) ? (int) filemtime($jsPath) : 0 ?>" defer></script>
    <?php endif; ?>
<?php
mpb_close();
