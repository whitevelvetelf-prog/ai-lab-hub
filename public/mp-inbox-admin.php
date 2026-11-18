<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM Marketplace: спільна скринька платформи (employee / admin).
 *
 * Розмови з оголошеннями платформи (продавець без user_id, напр. «Готові рішення»). Відповідь — на mp-thread.php?id=N
 * від імені «AI LAB HUB» (sender_id NULL); стан прочитання спільний для всіх співробітників (mp_conversation_state.user_id = 0).
 * Хто саме відповів — у mp_admin_access_log (action platform_reply), який бачить лише admin.
 *   mp-inbox-admin.php?tab=all|unread|archive[&page=N]
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

$tabs = ['all' => t('msg_tab_all'), 'unread' => t('msg_tab_unread'), 'archive' => t('msg_tab_archive')];
$tab = isset($tabs[$_GET['tab'] ?? '']) ? (string) $_GET['tab'] : 'all';
$page = max(1, (int) ($_GET['page'] ?? 1));
$rows = msg_inbox_platform($pdo, $tab, $page);
$hasMore = count($rows) > MSG_PAGE_SIZE;
$rows = array_slice($rows, 0, MSG_PAGE_SIZE);
$fmt = 'd.m.Y H:i';

msg_open(t('msg_platform_inbox'), '');
?>
    <div class="mp-page mp-page--narrow">
        <p><a class="mp-back" href="account.php#acc-crm">← CRM</a></p>
        <h1 class="mp-title"><?= mp_e(t('msg_platform_inbox')) ?></h1>
        <p class="msg-note"><?= mp_e(t('msg_platform_inbox_hint')) ?></p>
        <?= mpb_flash_html() ?>
        <nav class="msg-tabs">
            <?php foreach ($tabs as $k => $label): ?>
                <a class="mp-tab<?= $k === $tab ? ' is-active' : '' ?>" href="mp-inbox-admin.php?tab=<?= $k ?>"><?= mp_e($label) ?></a>
            <?php endforeach; ?>
            <a class="mp-tab" href="mp-message-reports.php"><?= mp_e(t('msg_reports_title')) ?></a>
        </nav>
        <?php if ($rows === []): ?>
            <p class="mp-text"><?= mp_e(t('msg_empty')) ?></p>
        <?php else: ?>
            <ul class="msg-list">
                <?php foreach ($rows as $r): $l = $r['listing']; ?>
                    <li class="msg-item<?= $r['unread'] > 0 ? ' msg-item--unread' : '' ?>">
                        <a class="msg-item__link" href="mp-thread.php?id=<?= (int) $r['id'] ?>">
                            <?= $l !== null && $l['thumb'] !== null ? '<img class="msg-thumb" src="' . mp_e($l['thumb']) . '" alt="" loading="lazy">' : '<span class="msg-thumb" aria-hidden="true">✉</span>' ?>
                            <span class="msg-item__main">
                                <span class="msg-item__title"><?= mp_e($l['title'] ?? t('msg_listing_removed')) ?></span>
                                <span class="msg-item__meta"><?= mp_e(t('msg_role_buyer')) ?>: <?= mp_e($r['counterpart']) ?></span>
                                <span class="msg-item__preview"><?= $r['last_mine'] ? 'AI LAB HUB: ' : '' ?><?= mp_e($r['preview']) ?></span>
                            </span>
                            <span class="msg-item__side"><?= mp_e(date($fmt, strtotime($r['time']) ?: time())) ?>
                                <?php if ($r['unread'] > 0): ?><br><span class="msg-badge"><?= $r['unread'] ?></span><?php endif; ?></span>
                        </a>
                    </li>
                <?php endforeach; ?>
            </ul>
            <p class="mp-actions">
                <?php if ($page > 1): ?><a class="mp-btn" href="mp-inbox-admin.php?tab=<?= $tab ?>&amp;page=<?= $page - 1 ?>">←</a><?php endif; ?>
                <?php if ($hasMore): ?><a class="mp-btn" href="mp-inbox-admin.php?tab=<?= $tab ?>&amp;page=<?= $page + 1 ?>">→</a><?php endif; ?>
            </p>
        <?php endif; ?>
    </div>
<?php
mpb_close();
