<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM Marketplace: модерація оголошень (лише employee / admin). Розділ 7 Правил Marketplace.
 *
 * Оголошення користувачів (post_form='ad') і компаній (вакансії/курси/послуги, post_form='').
 * Вкладки: «Черга» (status='pending'), «Старі скарги» (mp_reports до 2026-11-17; нові скарги — mp-legal-admin.php),
 * «Рішення (30 днів)» (needs_changes / rejected / hidden / removed). ?id=N — одне оголошення будь-якого статусу.
 * Дії (POST + CSRF, усе пишеться в mp_moderation_log, автор отримує повідомлення — app/mp-legal.php):
 *   approve        — pending → published (строк MP_LISTING_LIFETIME_DAYS);
 *   needs_changes / reject / remove — обов'язкові пункт Правил і пояснення (автор бачить обидва);
 *   move           — перенести оголошення користувача в іншу категорію (п. 4.2);
 *   hide           — приховати на час розгляду (hidden); restore — відновити публікацію;
 *   dismiss        — старі скарги безпідставні, оголошення лишається.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/listing.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

mp_require_staff();
$actorId = (int) auth_user_id();

$tabs = ['queue', 'reports', 'decided'];
$tab = in_array($_GET['tab'] ?? '', $tabs, true) ? (string) $_GET['tab'] : 'queue';
$onlyId = (int) ($_GET['id'] ?? 0);
$back = $onlyId > 0 ? 'mp-moderation.php?id=' . $onlyId : 'mp-moderation.php?tab=' . $tab;

// --- Дії ---------------------------------------------------------------------------
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!mp_csrf_verify()) {
        http_response_code(403);
        exit('Forbidden');
    }
    $id = (int) ($_POST['id'] ?? 0);
    $action = (string) ($_POST['action'] ?? '');
    $brief = mpl_listing_brief($pdo, $id);
    $isAd = $brief !== null && (string) $brief['post_form'] === 'ad';
    $code = is_string($_POST['code'] ?? null) && in_array($_POST['code'], MPL_RULE_POINTS, true) ? (string) $_POST['code'] : null;
    $reason = is_string($_POST['reason'] ?? null) ? trim((string) $_POST['reason']) : '';
    $ok = false;
    if ($brief === null) {
        $ok = false;
    } elseif ($action === 'approve') {
        $ok = $isAd ? mpb_approve($pdo, $id, $actorId) : lst_approve($pdo, $id, $actorId);
    } elseif ($action === 'decision' || $action === 'reject') {
        // 'reject' — коротка форма з черги кабінету (account.php), теж із пунктом Правил.
        $decision = $action === 'reject' ? 'reject' : (string) ($_POST['decision'] ?? '');
        if ($code === null || $reason === '') {
            mpb_flash('error', mpl_tr('a_err_reason'));
            mpb_redirect($back);
        }
        if ($decision === 'needs_changes') {
            $ok = mpl_set_status($pdo, $id, 'needs_changes', $actorId, ['pending', 'published'], $code, $reason);
        } elseif ($decision === 'reject') {
            $ok = mpl_set_status($pdo, $id, 'rejected', $actorId, ['pending', 'published', 'needs_changes'], $code, $reason);
            if ($ok && !$isAd) {
                lst_mail($pdo, $id, 'rejected', ['reason' => mpl_reason_text($code, $reason, 'uk')]);   // лист, як і раніше для компаній
            }
        } elseif ($decision === 'remove') {
            $ok = mpl_set_status($pdo, $id, 'removed', $actorId, ['pending', 'published', 'needs_changes', 'hidden', 'expired'], $code, $reason);
        }
    } elseif ($action === 'move' && $isAd) {
        $ok = mpl_move_category($pdo, $id, (int) ($_POST['category_id'] ?? 0), $actorId);
    } elseif ($action === 'hide') {
        $ok = mpl_set_status($pdo, $id, 'hidden', $actorId, ['published', 'pending'], $code, $reason !== '' ? $reason : null);
    } elseif ($action === 'restore') {
        $ok = mpl_set_status($pdo, $id, 'published', $actorId, ['hidden', 'removed', 'rejected', 'needs_changes'], null, $reason !== '' ? $reason : null, 'restored');
    } elseif ($action === 'dismiss') {
        $ok = mpb_dismiss_reports($pdo, $id, $actorId);
    }
    mpb_flash($ok ? 'ok' : 'error', mpl_tr($ok ? 'a_done' : 'a_failed', $id));
    // Дія з єдиної черги кабінету (account.php → «Маркетплейс: оголошення» → «Модерація») — повертаємося туди.
    if (($_POST['return'] ?? '') === 'account') {
        $msgs = (array) ($_SESSION['mpb_flash'] ?? []);
        unset($_SESSION['mpb_flash']);
        $last = end($msgs) ?: ['type' => 'ok', 'text' => ''];
        $_SESSION['ladm_flash'] = ['ok' => $last['type'] !== 'error', 'msgs' => array_column($msgs, 'text')];
        mpb_redirect('account.php?ladm_tab=mod');
    }
    mpb_redirect($back);
}

// --- Вибірка -------------------------------------------------------------------------
$reportsSql = mpb_reports_sql();
$target = mpl_target_sql();
if ($onlyId > 0) {
    $whereSql = 'l.id = :one';
    $params = [':one' => $onlyId];
} elseif ($tab === 'reports') {
    $whereSql = "l.status IN ('published', 'pending') AND $reportsSql > 0";
    $params = [];
} elseif ($tab === 'decided') {
    $whereSql = "l.status IN ('needs_changes', 'rejected', 'hidden', 'removed') AND COALESCE(l.status_changed_at, l.moderated_at, l.updated_at) > NOW() - INTERVAL 30 DAY";
    $params = [];
} else {
    $whereSql = "l.status = 'pending'";
    $params = [];
}
$hasLegal = true;
try {
    $pdo->query('SELECT reject_code, status_changed_at FROM mp_listings LIMIT 0');
} catch (Throwable) {
    $hasLegal = false;   // міграцію ще не застосовано
    if ($tab === 'decided') {
        $whereSql = "l.status IN ('rejected') AND COALESCE(l.moderated_at, l.updated_at) > NOW() - INTERVAL 30 DAY";
    }
}
$legalCols = $hasLegal ? 'l.reject_code, l.status_changed_at,' : 'NULL AS reject_code, NULL AS status_changed_at,';
$stmt = $pdo->prepare(
    "SELECT l.id, l.status, l.section, l.post_form, l.slug, l.seller_id, l.price_type, l.price_amount, l.currency, l.is_remote, l.city, l.source_lang,
            l.created_at, l.updated_at, l.moderated_at, l.expires_at, l.reject_reason, $legalCols l.created_by, l.company_name,
            s.display_name AS seller_name, s.user_id AS owner_id, u.name AS author_name, u.email AS author_email,
            $reportsSql AS reports_count,
            COALESCE(NULLIF(tu.title, ''), ts.title) AS title,
            COALESCE(NULLIF(tu.short_desc, ''), ts.short_desc) AS short_desc,
            COALESCE(NULLIF(tu.full_desc, ''), ts.full_desc) AS full_desc,
            (SELECT GROUP_CONCAT(COALESCE(ct.name, c.slug) ORDER BY c.sort_order, c.id SEPARATOR ', ')
               FROM mp_listing_categories lc JOIN mp_categories c ON c.id = lc.category_id
               LEFT JOIN mp_category_translations ct ON ct.category_id = c.id AND ct.lang = 'uk'
              WHERE lc.listing_id = l.id) AS categories_list
     FROM mp_listings l
     LEFT JOIN mp_sellers s ON s.id = l.seller_id
     LEFT JOIN users u ON u.id = s.user_id
     LEFT JOIN mp_listing_translations tu ON tu.listing_id = l.id AND tu.lang = 'uk'
     LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang
     WHERE $target AND $whereSql
     ORDER BY l.updated_at ASC, l.id ASC
     LIMIT 100"
);
$stmt->execute($params);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$queueCount = (int) $pdo->query("SELECT COUNT(*) FROM mp_listings l WHERE $target AND l.status = 'pending'")->fetchColumn();
$reportsCount = (int) $pdo->query("SELECT COUNT(*) FROM mp_listings l WHERE $target AND l.status IN ('published', 'pending') AND $reportsSql > 0")->fetchColumn();
$moveCats = mpb_categories($pdo, 'uk');
$reasonLabels = ['fraud' => 'Шахрайство', 'prohibited' => 'Заборонений товар чи послуга', 'spam' => 'Спам', 'wrong_category' => 'Неправильна категорія', 'other' => 'Інше'];
$flash = '';
foreach ((array) ($_SESSION['mpb_flash'] ?? []) as $item) {
    $flash .= '<div class="notice notice--' . ($item['type'] === 'error' ? 'error' : 'success') . '"><p>' . mp_e($item['text']) . '</p></div>';
}
unset($_SESSION['mpb_flash']);

$ruleSelect = static fn(): string => mpl_rule_select_html('select');
?>
<!DOCTYPE html>
<html lang="<?= mp_e(mpl_lang()) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>AI LAB HUB — <?= mp_e(mpl_tr('a_title_mod')) ?></title>
    <link rel="stylesheet" href="/assets/css/crm-ads.css">
    <link rel="stylesheet" href="/assets/css/mp-crm.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
    <style>
        .mod-card { margin: 0 0 24px; padding: 20px; border: 1px solid rgba(255,255,255,.2); border-radius: 14px; background: rgba(255,255,255,.05); }
        .mod-card h2 { margin: 0 0 6px; font-size: 1.25rem; }
        .mod-meta { display: flex; flex-wrap: wrap; gap: 6px 16px; margin: 0 0 12px; font-size: .9rem; color: rgba(255,255,255,.75); }
        .mod-photos { display: flex; flex-wrap: wrap; gap: 8px; margin: 12px 0; }
        .mod-photos img { height: 110px; width: auto; border-radius: 8px; border: 1px solid rgba(255,255,255,.25); }
        .mod-text { white-space: pre-line; margin: 6px 0 12px; overflow-wrap: anywhere; }
        .mod-box { margin: 12px 0; padding: 10px 14px; border-radius: 10px; background: rgba(255,255,255,.06); }
        .mod-box--warn { background: rgba(251,191,36,.12); border: 1px solid rgba(251,191,36,.5); }
        .mod-actions { display: flex; flex-wrap: wrap; gap: 12px; align-items: flex-start; margin-top: 14px; }
        .mod-actions form { display: flex; flex-wrap: wrap; gap: 8px; align-items: flex-start; }
        .mod-actions textarea { min-width: 280px; }
        .mod-actions fieldset { border: 1px solid rgba(255,255,255,.2); border-radius: 10px; padding: 8px 10px; display: flex; flex-wrap: wrap; gap: 8px; }
        .mod-tabs { display: flex; gap: 8px; margin: 0 0 20px; flex-wrap: wrap; }
        @media (max-width: 600px) { .mod-actions textarea, .mod-actions select { min-width: 0; width: 100%; } }
    </style>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php"><img class="site-header__logo" src="/logo.png" alt="AI LAB HUB"></a>
    </header>

    <div class="page page--wide">
        <a class="back-link" href="mp-list.php"><?= mp_e(mpl_tr('a_back')) ?></a>
        <h1 class="page__title"><?= mp_e(mpl_tr('a_title_mod')) ?></h1>
        <p class="page__subtitle"><?= mp_e(mpl_tr('a_sub_mod', (int) MP_LISTING_LIFETIME_DAYS)) ?> · <a href="mp-legal-admin.php"><?= mp_e(mpl_tr('a_legal_link')) ?></a> · <a href="marketplace-rules.php" target="_blank" rel="noopener"><?= mp_e(mpl_tr('rules_link')) ?></a></p>

        <?= $flash ?>

        <?php if ($onlyId === 0): ?>
        <div class="mod-tabs">
            <a class="btn btn--sm <?= $tab === 'queue' ? 'btn--primary' : 'btn--ghost' ?>" href="mp-moderation.php"><?= mp_e(mpl_tr('a_tab_queue')) ?> (<?= $queueCount ?>)</a>
            <a class="btn btn--sm <?= $tab === 'reports' ? 'btn--primary' : 'btn--ghost' ?>" href="mp-moderation.php?tab=reports"><?= mp_e(mpl_tr('a_tab_reports')) ?> (<?= $reportsCount ?>)</a>
            <a class="btn btn--sm <?= $tab === 'decided' ? 'btn--primary' : 'btn--ghost' ?>" href="mp-moderation.php?tab=decided"><?= mp_e(mpl_tr('a_tab_decided')) ?></a>
        </div>
        <?php else: ?>
            <p><a class="btn btn--ghost btn--sm" href="mp-moderation.php"><?= mp_e(mpl_tr('a_tab_queue')) ?></a></p>
        <?php endif; ?>

        <?php if ($rows === []): ?>
            <p class="empty-state"><?= mp_e(mpl_tr($tab === 'queue' && $onlyId === 0 ? 'a_empty_queue' : 'a_empty')) ?></p>
        <?php endif; ?>

        <?php foreach ($rows as $r): ?>
            <?php
            $rid = (int) $r['id'];
            $st = (string) $r['status'];
            $isAd = (string) $r['post_form'] === 'ad';
            $photos = $isAd ? mpb_photos($pdo, $rid) : [];
            $contacts = $isAd ? mpb_contacts($pdo, $rid) : [];
            $reports = $pdo->prepare('SELECT reporter_id, reason, note, created_at FROM mp_reports WHERE listing_id = :l ORDER BY id DESC LIMIT 50');
            $reports->execute([':l' => $rid]);
            $reports = $reports->fetchAll(PDO::FETCH_ASSOC);
            $log = $pdo->prepare('SELECT action, note, created_at, actor_id FROM mp_moderation_log WHERE listing_id = :l ORDER BY id DESC LIMIT 8');
            $log->execute([':l' => $rid]);
            $log = $log->fetchAll(PDO::FETCH_ASSOC);
            $loc = mpb_location_label(['city' => $r['city'], 'is_remote' => $r['is_remote']]);
            $reasonShown = mpl_reason_text($r['reject_code'], $r['reject_reason']);
            ?>
            <article class="mod-card" id="l<?= $rid ?>">
                <h2><?= mp_e($r['title'] ?? '—') ?> <span class="table__id">#<?= $rid ?></span>
                    <span class="badge badge--<?= mp_e($st) ?>"><?= mp_e(mpl_status_label($st)) ?></span></h2>
                <div class="mod-meta">
                    <span><?= mp_e(mpl_tr($isAd ? 'a_kind_ad' : 'a_kind_lst')) ?> · <?= mp_e((string) $r['section']) ?><?= !$isAd && !empty($r['company_name']) ? ' · ' . mp_e($r['company_name']) : '' ?></span>
                    <span><a href="<?= mp_e(mpl_listing_url($r)) ?>" target="_blank" rel="noopener"><?= mp_e(mpl_tr('a_open')) ?></a></span>
                    <?php if ($isAd): ?><span><?= mp_e(mpb_price_label($r) ?: t('mpb_pt_none')) ?></span><?php endif; ?>
                    <?php if ($loc !== ''): ?><span><?= mp_e($loc) ?></span><?php endif; ?>
                    <span><?= mp_e($r['categories_list'] ?? '—') ?></span>
                    <span><?= mp_e($r['author_name'] ?? '—') ?> <?= $r['author_email'] ? '(' . mp_e($r['author_email']) . ')' : '' ?>
                        <?php if ($r['owner_id'] !== null): ?> · <a href="mp-legal-admin.php?tab=users&amp;q=<?= (int) $r['owner_id'] ?>"><?= mp_e(mpl_tr('a_author_card')) ?></a><?php endif; ?></span>
                    <span><?= mp_e($r['source_lang']) ?></span>
                    <?php if (mp_config()['messaging_enabled'] === true): // режим звʼязку (внутрішні повідомлення) ?>
                        <span><?= mp_e(t('msg_mode_title')) ?>: <?= mp_e(t('msg_mode_' . mp_contact_mode_of($pdo, $rid))) ?></span>
                    <?php endif; ?>
                    <span><?= mp_e(date('d.m.Y H:i', (int) strtotime((string) $r['updated_at']))) ?></span>
                    <?php if ($r['expires_at'] !== null): ?><span>→ <?= mp_e(date('d.m.Y', (int) strtotime((string) $r['expires_at']))) ?></span><?php endif; ?>
                </div>

                <?php if ($photos !== []): ?>
                    <div class="mod-photos" data-mp-gallery>
                        <?php foreach ($photos as $pi => $p): ?>
                            <a href="<?= mp_e(mpb_photo_url($p['file_name']) ?? '') ?>" data-mp-photo><img src="<?= mp_e(mpb_photo_url($p['thumb_name']) ?? '') ?>" alt="<?= mp_e('#' . ($pi + 1)) ?>"></a>
                        <?php endforeach; ?>
                    </div>
                <?php endif; ?>

                <p class="mod-text"><strong><?= mp_e($r['short_desc'] ?? '') ?></strong></p>
                <?php if (!empty($r['full_desc'])): ?><p class="mod-text"><?= mp_e($r['full_desc']) ?></p><?php endif; ?>

                <?php if ($contacts !== []): ?>
                <div class="mod-box">
                    <?php foreach ($contacts as $c): ?><div><?= mp_e($c['label']) ?>: <?= mp_e($c['value']) ?></div><?php endforeach; ?>
                </div>
                <?php endif; ?>

                <?php if ($reasonShown !== '' && in_array($st, ['rejected', 'needs_changes', 'hidden', 'removed'], true)): ?>
                    <div class="mod-box mod-box--warn"><strong><?= mp_e(mpl_tr('my_reason')) ?>:</strong> <?= mp_e($reasonShown) ?></div>
                <?php endif; ?>

                <?php if ($reports !== []): ?>
                    <div class="mod-box mod-box--warn">
                        <strong><?= mp_e(mpl_tr('a_tab_reports')) ?> (<?= (int) $r['reports_count'] ?> / <?= count($reports) ?>):</strong>
                        <?php foreach ($reports as $rp): ?>
                            <div>• <?= mp_e($reasonLabels[$rp['reason']] ?? $rp['reason']) ?> — №<?= (int) $rp['reporter_id'] ?>, <?= mp_e(date('d.m.Y H:i', (int) strtotime((string) $rp['created_at']))) ?><?= $rp['note'] ? ': «' . mp_e($rp['note']) . '»' : '' ?></div>
                        <?php endforeach; ?>
                    </div>
                <?php endif; ?>

                <?php if ($log !== []): ?>
                    <details><summary class="table__muted">mp_moderation_log (<?= count($log) ?>)</summary>
                        <?php foreach ($log as $lg): ?>
                            <div class="table__muted"><?= mp_e(date('d.m.Y H:i', (int) strtotime((string) $lg['created_at']))) ?> · <?= mp_e($lg['action']) ?><?= $lg['note'] ? ' — ' . mp_e($lg['note']) : '' ?> · <?= $lg['actor_id'] ? '№' . (int) $lg['actor_id'] : 'cron' ?></div>
                        <?php endforeach; ?>
                    </details>
                <?php endif; ?>

                <div class="mod-actions">
                    <?php if ($st === 'pending'): ?>
                        <form method="post" action="<?= mp_e($back) ?>">
                            <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $rid ?>"><input type="hidden" name="action" value="approve">
                            <button class="btn btn--primary btn--sm" type="submit"><?= mp_e(mpl_tr('a_approve')) ?></button>
                        </form>
                    <?php endif; ?>
                    <?php if (in_array($st, ['pending', 'published', 'needs_changes', 'hidden', 'expired'], true)): ?>
                        <form method="post" action="<?= mp_e($back) ?>">
                            <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $rid ?>"><input type="hidden" name="action" value="decision">
                            <fieldset>
                                <legend><?= mp_e(mpl_tr('a_decision')) ?></legend>
                                <select class="select" name="decision" aria-label="<?= mp_e(mpl_tr('a_decision')) ?>">
                                    <?php if (in_array($st, ['pending', 'published'], true)): ?><option value="needs_changes"><?= mp_e(mpl_tr('a_dec_needs_changes')) ?></option><?php endif; ?>
                                    <?php if (in_array($st, ['pending', 'published', 'needs_changes'], true)): ?><option value="reject"><?= mp_e(mpl_tr('a_dec_reject')) ?></option><?php endif; ?>
                                    <option value="remove"><?= mp_e(mpl_tr('a_dec_remove')) ?></option>
                                </select>
                                <?= $ruleSelect() ?>
                                <textarea class="textarea" name="reason" rows="2" maxlength="500" required placeholder="<?= mp_e(mpl_tr('a_reason_ph')) ?>"></textarea>
                                <button class="btn btn--ghost btn--sm" type="submit"><?= mp_e(mpl_tr('a_apply')) ?></button>
                            </fieldset>
                        </form>
                    <?php endif; ?>
                    <?php if ($isAd && $moveCats !== [] && !in_array($st, ['removed', 'archived'], true)): ?>
                        <form method="post" action="<?= mp_e($back) ?>">
                            <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $rid ?>"><input type="hidden" name="action" value="move">
                            <select class="select" name="category_id" aria-label="<?= mp_e(mpl_tr('a_move')) ?>" required>
                                <option value=""><?= mp_e(mpl_tr('a_move')) ?></option>
                                <?php foreach ($moveCats as $mc): ?><option value="<?= (int) $mc['id'] ?>"><?= mp_e($mc['name']) ?></option><?php endforeach; ?>
                            </select>
                            <button class="btn btn--ghost btn--sm" type="submit"><?= mp_e(mpl_tr('a_move_btn')) ?></button>
                        </form>
                    <?php endif; ?>
                    <?php if ($st === 'published'): ?>
                        <form method="post" action="<?= mp_e($back) ?>">
                            <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $rid ?>"><input type="hidden" name="action" value="hide">
                            <button class="btn btn--ghost btn--sm" type="submit"><?= mp_e(mpl_tr('a_hide')) ?></button>
                        </form>
                    <?php endif; ?>
                    <?php if (in_array($st, ['hidden', 'removed', 'rejected', 'needs_changes'], true)): ?>
                        <form method="post" action="<?= mp_e($back) ?>">
                            <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $rid ?>"><input type="hidden" name="action" value="restore">
                            <button class="btn btn--ghost btn--sm" type="submit"><?= mp_e(mpl_tr('a_restore')) ?></button>
                        </form>
                    <?php endif; ?>
                    <?php if ((int) $r['reports_count'] > 0 && in_array($st, ['pending', 'published'], true)): ?>
                        <form method="post" action="<?= mp_e($back) ?>">
                            <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $rid ?>"><input type="hidden" name="action" value="dismiss">
                            <button class="btn btn--ghost btn--sm" type="submit"><?= mp_e(mpl_tr('a_c_keep')) ?></button>
                        </form>
                    <?php endif; ?>
                </div>
            </article>
        <?php endforeach; ?>
    </div>
<script src="/assets/js/mp-gallery.js?v=<?= (int) @filemtime(__DIR__ . '/assets/js/mp-gallery.js') ?>"></script>
</body>
</html>
