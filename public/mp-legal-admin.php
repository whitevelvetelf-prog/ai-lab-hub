<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM Marketplace: скарги на оголошення (розділи 10–11 Правил). Лише employee / admin.
 *
 * Вкладка «Скарги»: фільтр за статусом (new | in_review | resolved_removed | resolved_kept); дії (POST + CSRF):
 *   in_review — взяти в роботу; hide — приховати оголошення на час розгляду (статус оголошення 'hidden');
 *   resolved_removed — зняти оголошення ('removed', автор отримує повідомлення з коментарем);
 *   resolved_kept — залишити (приховане відновлюється).
 * Дані заявника бачить лише модератор; автору показується тільки суть претензії (app/mp-legal-ui.php).
 *
 * Вкладка «Оскарження» (п. 7.5): відкриті й розглянуті; «Відновити оголошення» (→ published) або «Залишити рішення»
 * (коментар обов'язковий); «Внести оскарження з листа» на MP_ABUSE_EMAIL — № оголошення + текст.
 *
 * Вкладка «Користувачі» (п. 7.3–7.4, 10.5): пошук за email або №; картка — попередження, заборона подачі на N днів
 * (0 — безстроково), блокування акаунта, зняття обмежень; журнал mp_user_sanctions. Співробітників не обмежуємо.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

mp_require_staff();
$actorId = (int) auth_user_id();

$tabs = ['complaints', 'appeals', 'users'];
$tab = in_array($_GET['tab'] ?? '', $tabs, true) ? (string) $_GET['tab'] : 'complaints';
$cstatus = in_array($_GET['status'] ?? '', MPL_COMPLAINT_STATUSES, true) ? (string) $_GET['status'] : '';
$back = 'mp-legal-admin.php?tab=' . $tab . ($cstatus !== '' ? '&status=' . $cstatus : '');

// --- Дії ---------------------------------------------------------------------------
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!mp_csrf_verify()) {
        http_response_code(403);
        exit('Forbidden');
    }
    $action = (string) ($_POST['action'] ?? '');
    $note = is_string($_POST['note'] ?? null) ? (string) $_POST['note'] : '';
    if (in_array($action, ['in_review', 'hide', 'resolved_removed', 'resolved_kept'], true)) {
        $cid = (int) ($_POST['complaint_id'] ?? 0);
        $ok = mpl_complaint_action($pdo, $cid, $action, $note, $actorId);
        mpb_flash($ok ? 'ok' : 'error', mpl_tr($ok ? 'a_c_done' : 'a_c_failed', $cid));
    } elseif ($action === 'appeal_restore' || $action === 'appeal_uphold') {
        $aid = (int) ($_POST['appeal_id'] ?? 0);
        $ok = mpl_appeal_resolve($pdo, $aid, $action === 'appeal_restore', $note, $actorId);
        mpb_flash($ok ? 'ok' : 'error', $ok ? mpl_tr('a_ap_done', $aid) : mpl_tr('a_ap_failed'));
    } elseif ($action === 'appeal_add') {
        $res = mpl_appeal_create($pdo, (int) ($_POST['listing_id'] ?? 0), 0, is_string($_POST['text'] ?? null) ? (string) $_POST['text'] : '', 'email', $actorId);
        mpb_flash($res === 'ok' ? 'ok' : 'error', mpl_tr($res === 'ok' ? 'a_ap_added' : 'a_ap_add_failed'));
    }
    if (in_array($action, ['warn', 'ban', 'block', 'unblock'], true)) {
        $uid = (int) ($_POST['user_id'] ?? 0);
        $role = $pdo->prepare('SELECT role FROM users WHERE id = :u');
        $role->execute([':u' => $uid]);
        $r = $role->fetchColumn();
        $ok = $r !== false && !in_array((string) $r, ['employee', 'admin'], true)
            && mpl_sanction($pdo, $uid, $action, max(0, min(3650, (int) ($_POST['days'] ?? 0))), $note, $actorId);
        mpb_flash($ok ? 'ok' : 'error', $ok ? mpl_tr('a_u_done', $uid) : mpl_tr($r !== false && in_array((string) $r, ['employee', 'admin'], true) ? 'a_u_staff' : 'a_u_failed'));
        mpb_redirect('mp-legal-admin.php?tab=users&q=' . $uid);
    }
    mpb_redirect($back);
}

$flash = '';
foreach ((array) ($_SESSION['mpb_flash'] ?? []) as $item) {
    $flash .= '<div class="notice notice--' . ($item['type'] === 'error' ? 'error' : 'success') . '"><p>' . mp_e($item['text']) . '</p></div>';
}
unset($_SESSION['mpb_flash']);

$ready = true;
try {
    $pdo->query('SELECT 1 FROM mp_complaints LIMIT 0');
} catch (Throwable) {
    $ready = false;   // міграцію database/marketplace_legal_migration.sql ще не застосовано
}

$counts = [];
$complaints = [];
if ($ready) {
    foreach ($pdo->query('SELECT status, COUNT(*) FROM mp_complaints GROUP BY status')->fetchAll(PDO::FETCH_KEY_PAIR) as $k => $n) {
        $counts[(string) $k] = (int) $n;
    }
    $st = $pdo->prepare(
        'SELECT c.*, u.email AS reporter_account_email, l.status AS listing_status
         FROM mp_complaints c LEFT JOIN users u ON u.id = c.reporter_id LEFT JOIN mp_listings l ON l.id = c.listing_id
         ' . ($cstatus !== '' ? 'WHERE c.status = :s' : '') . ' ORDER BY FIELD(c.status, \'new\', \'in_review\', \'resolved_removed\', \'resolved_kept\'), c.id DESC LIMIT 200'
    );
    $st->execute($cstatus !== '' ? [':s' => $cstatus] : []);
    $complaints = $st->fetchAll(PDO::FETCH_ASSOC);
}
$appeals = [];
$openAppeals = 0;
if ($ready) {
    $openAppeals = (int) $pdo->query("SELECT COUNT(*) FROM mp_appeals WHERE status = 'open'")->fetchColumn();
    if ($tab === 'appeals') {
        $appeals = $pdo->query(
            "SELECT a.*, u.email AS user_email FROM mp_appeals a LEFT JOIN users u ON u.id = a.user_id
             ORDER BY (a.status = 'open') DESC, a.id DESC LIMIT 200"
        )->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>
<!DOCTYPE html>
<html lang="<?= mp_e(mpl_lang()) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>AI LAB HUB — <?= mp_e(mpl_tr('a_title_legal')) ?></title>
    <link rel="stylesheet" href="/assets/css/crm-ads.css">
    <link rel="stylesheet" href="/assets/css/mp-crm.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
    <style>
        .lg-card { margin: 0 0 18px; padding: 16px 18px; border: 1px solid rgba(255,255,255,.2); border-radius: 14px; background: rgba(255,255,255,.05); }
        .lg-card h2 { margin: 0 0 6px; font-size: 1.1rem; }
        .lg-meta { display: flex; flex-wrap: wrap; gap: 4px 14px; margin: 0 0 10px; font-size: .9rem; color: rgba(255,255,255,.75); }
        .lg-text { white-space: pre-line; overflow-wrap: anywhere; margin: 6px 0; }
        .lg-box { margin: 10px 0; padding: 10px 12px; border-radius: 10px; background: rgba(255,255,255,.06); }
        .lg-actions { display: flex; flex-wrap: wrap; gap: 8px; align-items: flex-start; margin-top: 10px; }
        .lg-actions form { display: flex; flex-wrap: wrap; gap: 8px; align-items: flex-start; }
        .lg-tabs { display: flex; gap: 8px; margin: 0 0 16px; flex-wrap: wrap; }
        .lg-actions textarea, .lg-actions input[type=text] { min-width: 240px; }
        @media (max-width: 600px) { .lg-actions textarea, .lg-actions input[type=text] { min-width: 0; width: 100%; } }
    </style>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php"><img class="site-header__logo" src="/logo.png" alt="AI LAB HUB"></a>
    </header>
    <div class="page page--wide">
        <a class="back-link" href="mp-moderation.php"><?= mp_e(mpl_tr('a_back')) ?></a>
        <h1 class="page__title"><?= mp_e(mpl_tr('a_title_legal')) ?></h1>
        <p class="page__subtitle"><a href="marketplace-rules.php#section-10" target="_blank" rel="noopener"><?= mp_e(mpl_tr('rules_link')) ?></a> · <?= mp_e(MP_ABUSE_EMAIL) ?></p>
        <?= $flash ?>

        <div class="lg-tabs">
            <a class="btn btn--sm <?= $tab === 'complaints' ? 'btn--primary' : 'btn--ghost' ?>" href="mp-legal-admin.php?tab=complaints"><?= mp_e(mpl_tr('a_tab_complaints')) ?> (<?= (int) ($counts['new'] ?? 0) + (int) ($counts['in_review'] ?? 0) ?>)</a>
            <a class="btn btn--sm <?= $tab === 'appeals' ? 'btn--primary' : 'btn--ghost' ?>" href="mp-legal-admin.php?tab=appeals"><?= mp_e(mpl_tr('a_tab_appeals')) ?> (<?= $openAppeals ?>)</a>
            <a class="btn btn--sm <?= $tab === 'users' ? 'btn--primary' : 'btn--ghost' ?>" href="mp-legal-admin.php?tab=users"><?= mp_e(mpl_tr('a_tab_users')) ?></a>
        </div>

        <?php if (!$ready): ?>
            <p class="notice notice--error">database/marketplace_legal_migration.sql</p>
        <?php elseif ($tab === 'complaints'): ?>
            <div class="lg-tabs">
                <a class="btn btn--sm <?= $cstatus === '' ? 'btn--primary' : 'btn--ghost' ?>" href="mp-legal-admin.php?tab=complaints"><?= mp_e(mpl_tr('a_filter_all')) ?></a>
                <?php foreach (MPL_COMPLAINT_STATUSES as $cs): ?>
                    <a class="btn btn--sm <?= $cstatus === $cs ? 'btn--primary' : 'btn--ghost' ?>" href="mp-legal-admin.php?tab=complaints&amp;status=<?= $cs ?>"><?= mp_e(mpl_tr('a_cs_' . $cs)) ?> (<?= (int) ($counts[$cs] ?? 0) ?>)</a>
                <?php endforeach; ?>
            </div>
            <?php if ($complaints === []): ?><p class="empty-state"><?= mp_e(mpl_tr('a_empty')) ?></p><?php endif; ?>
            <?php foreach ($complaints as $c): ?>
                <?php
                $cid = (int) $c['id'];
                $b = mpl_listing_brief($pdo, (int) $c['listing_id']);
                $open = in_array((string) $c['status'], ['new', 'in_review'], true);
                ?>
                <article class="lg-card" id="c<?= $cid ?>">
                    <h2>№<?= $cid ?> · <?= mp_e(mpl_tr('c_reason_' . $c['reason'])) ?> <span class="badge badge--<?= mp_e($c['status']) ?>"><?= mp_e(mpl_tr('a_cs_' . $c['status'])) ?></span></h2>
                    <div class="lg-meta">
                        <span><?= mp_e(mpl_tr('a_c_listing')) ?>: <?php if ($b !== null): ?><a href="<?= mp_e(mpl_listing_url($b)) ?>" target="_blank" rel="noopener"><?= mp_e($b['title'] ?? '#' . $c['listing_id']) ?></a> (<?= mp_e(mpl_status_label((string) $b['status'])) ?>) · <a href="mp-moderation.php?id=<?= (int) $c['listing_id'] ?>">#<?= (int) $c['listing_id'] ?></a><?php else: ?>#<?= (int) $c['listing_id'] ?><?php endif; ?></span>
                        <span><?= mp_e(mpl_tr('a_c_from')) ?>: <?= $c['reporter_id'] !== null ? '№' . (int) $c['reporter_id'] . ' ' . mp_e((string) $c['reporter_account_email']) : mp_e(mpl_tr('a_c_guest')) . ' ' . mp_e((string) $c['reporter_email']) ?></span>
                        <span><?= mp_e(date('d.m.Y H:i', (int) strtotime((string) $c['created_at']))) ?></span>
                    </div>
                    <?php if (!empty($c['note'])): ?><p class="lg-text"><?= mp_e($c['note']) ?></p><?php endif; ?>
                    <?php if ((string) $c['reason'] === 'copyright'): ?>
                        <div class="lg-box">
                            <div><strong><?= mp_e(mpl_tr('c_cr_name')) ?>:</strong> <?= mp_e((string) $c['claimant_name']) ?></div>
                            <div><strong><?= mp_e(mpl_tr('c_cr_contact')) ?>:</strong> <?= mp_e((string) $c['claimant_contact']) ?></div>
                            <div class="lg-text"><strong><?= mp_e(mpl_tr('c_cr_work')) ?>:</strong> <?= mp_e((string) $c['infringed_work']) ?></div>
                            <div><strong><?= mp_e(mpl_tr('a_c_evidence')) ?>:</strong>
                                <?php if (!empty($c['evidence_url']) && mp_is_http_url((string) $c['evidence_url'])): ?><a href="<?= mp_e($c['evidence_url']) ?>" target="_blank" rel="noopener noreferrer nofollow"><?= mp_e($c['evidence_url']) ?></a><?php endif; ?>
                                <?php if (!empty($c['evidence_file'])): ?> · <a href="mp-evidence.php?id=<?= $cid ?>" target="_blank" rel="noopener"><?= mp_e(mpl_tr('a_c_file')) ?></a><?php endif; ?>
                            </div>
                            <div><?= (int) $c['good_faith'] === 1 ? '✓ ' . mp_e(mpl_tr('c_cr_good_faith')) : '' ?></div>
                        </div>
                        <div class="lg-box">
                            <?php if ($c['counter_at'] !== null): ?>
                                <strong><?= mp_e(mpl_tr('a_c_counter')) ?> (<?= mp_e(date('d.m.Y', (int) strtotime((string) $c['counter_at']))) ?>):</strong>
                                <p class="lg-text"><?= mp_e((string) $c['counter_text']) ?></p>
                                <?php if (mp_is_http_url((string) $c['counter_evidence_url'])): ?><a href="<?= mp_e($c['counter_evidence_url']) ?>" target="_blank" rel="noopener noreferrer nofollow"><?= mp_e($c['counter_evidence_url']) ?></a><?php endif; ?>
                            <?php else: ?>
                                <?= mp_e(mpl_tr('a_c_counter_until', date('d.m.Y', (int) strtotime(mpl_counter_deadline((string) $c['created_at']))))) ?>
                            <?php endif; ?>
                        </div>
                    <?php endif; ?>
                    <?php if (!empty($c['admin_note'])): ?><p class="table__muted"><?= mp_e($c['admin_note']) ?></p><?php endif; ?>
                    <?php if ($open): ?>
                        <form method="post" action="<?= mp_e($back) ?>" class="lg-actions">
                            <?= mp_csrf_field() ?><input type="hidden" name="complaint_id" value="<?= $cid ?>">
                            <input class="input" type="text" name="note" maxlength="1000" placeholder="<?= mp_e(mpl_tr('a_c_note_ph')) ?>">
                            <?php if ((string) $c['status'] === 'new'): ?><button class="btn btn--ghost btn--sm" type="submit" name="action" value="in_review"><?= mp_e(mpl_tr('a_c_in_review')) ?></button><?php endif; ?>
                            <?php if ($b !== null && (string) $b['status'] === 'published'): ?><button class="btn btn--ghost btn--sm" type="submit" name="action" value="hide"><?= mp_e(mpl_tr('a_c_hide')) ?></button><?php endif; ?>
                            <button class="btn btn--primary btn--sm" type="submit" name="action" value="resolved_removed"><?= mp_e(mpl_tr('a_c_remove')) ?></button>
                            <button class="btn btn--ghost btn--sm" type="submit" name="action" value="resolved_kept"><?= mp_e(mpl_tr('a_c_keep')) ?></button>
                        </form>
                    <?php endif; ?>
                </article>
            <?php endforeach; ?>
        <?php elseif ($tab === 'users'): ?>
            <?php
            $q = trim(is_string($_GET['q'] ?? null) ? (string) $_GET['q'] : '');
            $u = null;
            if ($q !== '') {
                $us = $pdo->prepare('SELECT id, name, email, role, created_at, warnings_count, posting_banned_until, blocked_at FROM users WHERE ' . (ctype_digit($q) ? 'id = :q' : 'email = :q') . ' LIMIT 1');
                $us->execute([':q' => ctype_digit($q) ? (int) $q : mb_strtolower($q)]);
                $u = $us->fetch(PDO::FETCH_ASSOC) ?: null;
            }
            ?>
            <form method="get" action="mp-legal-admin.php" class="lg-actions">
                <input type="hidden" name="tab" value="users">
                <input class="input" type="text" name="q" value="<?= mp_e($q) ?>" placeholder="<?= mp_e(mpl_tr('a_u_search')) ?>" aria-label="<?= mp_e(mpl_tr('a_u_search')) ?>">
                <button class="btn btn--primary btn--sm" type="submit"><?= mp_e(mpl_tr('a_u_find')) ?></button>
            </form>
            <?php if ($q !== '' && $u === null): ?><p class="empty-state"><?= mp_e(mpl_tr('a_u_notfound')) ?></p><?php endif; ?>
            <?php if ($u !== null): ?>
                <?php
                $uidCard = (int) $u['id'];
                $lc = $pdo->prepare('SELECT l.status, COUNT(*) FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id WHERE s.user_id = :u AND ' . mpl_target_sql() . ' GROUP BY l.status');
                $lc->execute([':u' => $uidCard]);
                $byStatus = $lc->fetchAll(PDO::FETCH_KEY_PAIR);
                $hist = $pdo->prepare('SELECT action, days, note, actor_id, created_at FROM mp_user_sanctions WHERE user_id = :u ORDER BY id DESC LIMIT 30');
                $hist->execute([':u' => $uidCard]);
                $hist = $hist->fetchAll(PDO::FETCH_ASSOC);
                $isStaffCard = in_array((string) $u['role'], ['employee', 'admin'], true);
                ?>
                <article class="lg-card">
                    <h2>№<?= $uidCard ?> · <?= mp_e((string) $u['name']) ?> · <?= mp_e((string) $u['email']) ?> <span class="badge"><?= mp_e((string) $u['role']) ?></span></h2>
                    <div class="lg-meta">
                        <span><?= mp_e(mpl_tr('a_u_warnings')) ?>: <strong><?= (int) $u['warnings_count'] ?></strong></span>
                        <span><?= mp_e(mpl_tr('a_u_banned_until')) ?>: <strong><?= $u['posting_banned_until'] !== null ? mp_e(str_starts_with((string) $u['posting_banned_until'], '9999') ? mpl_tr('forever') : date('d.m.Y H:i', (int) strtotime((string) $u['posting_banned_until']))) : mp_e(mpl_tr('a_u_none')) ?></strong></span>
                        <span><?= mp_e(mpl_tr('a_u_blocked')) ?>: <strong><?= $u['blocked_at'] !== null ? mp_e(date('d.m.Y H:i', (int) strtotime((string) $u['blocked_at']))) : mp_e(mpl_tr('a_u_none')) ?></strong></span>
                        <span><?= mp_e(mpl_tr('a_u_listings')) ?>: <?php foreach ($byStatus as $bs => $bn): ?><?= mp_e(mpl_status_label((string) $bs)) ?> — <?= (int) $bn ?>; <?php endforeach; ?><?= $byStatus === [] ? '0' : '' ?></span>
                    </div>
                    <?php if ($isStaffCard): ?>
                        <p class="table__muted"><?= mp_e(mpl_tr('a_u_staff')) ?></p>
                    <?php else: ?>
                        <form method="post" action="mp-legal-admin.php?tab=users&amp;q=<?= $uidCard ?>" class="lg-actions">
                            <?= mp_csrf_field() ?><input type="hidden" name="user_id" value="<?= $uidCard ?>">
                            <input class="input" type="text" name="note" maxlength="1000" placeholder="<?= mp_e(mpl_tr('a_u_note_ph')) ?>" aria-label="<?= mp_e(mpl_tr('a_u_note_ph')) ?>">
                            <button class="btn btn--ghost btn--sm" type="submit" name="action" value="warn"><?= mp_e(mpl_tr('a_u_warn')) ?></button>
                            <input class="input" type="number" name="days" min="0" max="3650" value="30" style="width:7em" aria-label="<?= mp_e(mpl_tr('a_u_ban')) ?>" title="<?= mp_e(mpl_tr('a_u_ban')) ?>">
                            <button class="btn btn--ghost btn--sm" type="submit" name="action" value="ban"><?= mp_e(mpl_tr('a_u_ban_btn')) ?></button>
                            <button class="btn btn--primary btn--sm" type="submit" name="action" value="block"><?= mp_e(mpl_tr('a_u_block')) ?></button>
                            <?php if ($u['blocked_at'] !== null || $u['posting_banned_until'] !== null): ?>
                                <button class="btn btn--ghost btn--sm" type="submit" name="action" value="unblock"><?= mp_e(mpl_tr('a_u_unblock')) ?></button>
                            <?php endif; ?>
                        </form>
                    <?php endif; ?>
                    <?php if ($hist !== []): ?>
                        <details><summary class="table__muted"><?= mp_e(mpl_tr('a_u_history')) ?> (<?= count($hist) ?>)</summary>
                            <?php foreach ($hist as $hs): ?>
                                <div class="table__muted"><?= mp_e(date('d.m.Y H:i', (int) strtotime((string) $hs['created_at']))) ?> · <?= mp_e((string) $hs['action']) ?><?= $hs['days'] !== null ? ' ' . (int) $hs['days'] : '' ?><?= $hs['note'] ? ' — ' . mp_e((string) $hs['note']) : '' ?> · №<?= (int) $hs['actor_id'] ?></div>
                            <?php endforeach; ?>
                        </details>
                    <?php endif; ?>
                </article>
            <?php endif; ?>
        <?php elseif ($tab === 'appeals'): ?>
            <details class="lg-card">
                <summary><strong><?= mp_e(mpl_tr('a_ap_add')) ?></strong> (<?= mp_e(MP_ABUSE_EMAIL) ?>)</summary>
                <form method="post" action="<?= mp_e($back) ?>" class="lg-actions">
                    <?= mp_csrf_field() ?><input type="hidden" name="action" value="appeal_add">
                    <input class="input" type="number" name="listing_id" min="1" required placeholder="<?= mp_e(mpl_tr('a_ap_listing_id')) ?>" aria-label="<?= mp_e(mpl_tr('a_ap_listing_id')) ?>">
                    <textarea class="textarea" name="text" rows="3" maxlength="3000" required placeholder="<?= mp_e(mpl_tr('a_ap_text')) ?>"></textarea>
                    <button class="btn btn--primary btn--sm" type="submit"><?= mp_e(mpl_tr('a_ap_add_btn')) ?></button>
                </form>
            </details>
            <?php if ($appeals === []): ?><p class="empty-state"><?= mp_e(mpl_tr('a_empty')) ?></p><?php endif; ?>
            <?php foreach ($appeals as $a): ?>
                <?php $aid = (int) $a['id']; $b = mpl_listing_brief($pdo, (int) $a['listing_id']); ?>
                <article class="lg-card" id="a<?= $aid ?>">
                    <h2>№<?= $aid ?> · <?= mp_e(mpl_tr('a_ap_status_' . $a['status'])) ?></h2>
                    <div class="lg-meta">
                        <span><?= mp_e(mpl_tr('a_c_listing')) ?>: <?php if ($b !== null): ?><a href="<?= mp_e(mpl_listing_url($b)) ?>" target="_blank" rel="noopener"><?= mp_e($b['title'] ?? '#' . $a['listing_id']) ?></a> (<?= mp_e(mpl_status_label((string) $b['status'])) ?>) · <a href="mp-moderation.php?id=<?= (int) $a['listing_id'] ?>">#<?= (int) $a['listing_id'] ?></a><?php else: ?>#<?= (int) $a['listing_id'] ?><?php endif; ?></span>
                        <span><?= mp_e(mpl_tr('a_ap_decision')) ?>: <?= mp_e(mpl_status_label((string) $a['decision_status'])) ?><?= $b !== null ? ' — ' . mp_e(mpl_reason_text($b['reject_code'], $b['reject_reason'])) : '' ?></span>
                        <span>№<?= (int) $a['user_id'] ?> <?= mp_e((string) $a['user_email']) ?> · <?= mp_e(mpl_tr('a_ap_source_' . ($a['source'] === 'email' ? 'email' : 'cabinet'))) ?></span>
                        <span><?= mp_e(date('d.m.Y H:i', (int) strtotime((string) $a['created_at']))) ?></span>
                    </div>
                    <p class="lg-text"><?= mp_e((string) $a['text']) ?></p>
                    <?php if (!empty($a['admin_comment'])): ?><p class="table__muted"><?= mp_e((string) $a['admin_comment']) ?></p><?php endif; ?>
                    <?php if ((string) $a['status'] === 'open'): ?>
                        <form method="post" action="<?= mp_e($back) ?>" class="lg-actions">
                            <?= mp_csrf_field() ?><input type="hidden" name="appeal_id" value="<?= $aid ?>">
                            <textarea class="textarea" name="note" rows="2" maxlength="1000" placeholder="<?= mp_e(mpl_tr('a_ap_comment_ph')) ?>"></textarea>
                            <button class="btn btn--primary btn--sm" type="submit" name="action" value="appeal_restore"><?= mp_e(mpl_tr('a_ap_restore')) ?></button>
                            <button class="btn btn--ghost btn--sm" type="submit" name="action" value="appeal_uphold"><?= mp_e(mpl_tr('a_ap_uphold')) ?></button>
                        </form>
                    <?php endif; ?>
                </article>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
</body>
</html>
