<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM Marketplace: модерація оголошень дошки (лише employee / admin).
 *
 * Вкладки: «Черга» (status='pending': нові й відредаговані оголошення, а також повернуті через скарги) і
 * «Зі скаргами» (живі/на модерації оголошення, на які є скарги після останньої модерації).
 * ?id=N — перегляд одного оголошення будь-якого статусу (з mp-list.php).
 * Дії (POST + CSRF, усе пишеться в mp_moderation_log):
 *   approve — pending → published, published_at = зараз, expires_at = +30 днів, moderated_by/at;
 *   reject  — обов'язкова причина, статус rejected (причину бачить автор);
 *   dismiss — скарги розглянуто, оголошення лишається (скидає лічильник скарг).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

mp_require_staff();
$actorId = (int) auth_user_id();

$tab = ($_GET['tab'] ?? '') === 'reports' ? 'reports' : 'queue';
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
    if ($action === 'approve') {
        $ok = mpb_approve($pdo, $id, $actorId);
        mpb_flash($ok ? 'ok' : 'error', 'Оголошення №' . $id . ': ' . ($ok ? 'схвалено й опубліковано.' : 'не схвалено (статус уже змінився).'));
    } elseif ($action === 'reject') {
        $reason = is_string($_POST['reason'] ?? null) ? trim((string) $_POST['reason']) : '';
        if ($reason === '') {
            mpb_flash('error', "Вкажіть причину відхилення — вона обов'язкова.");
        } else {
            $ok = mpb_reject($pdo, $id, $actorId, $reason);
            mpb_flash($ok ? 'ok' : 'error', 'Оголошення №' . $id . ': ' . ($ok ? 'відхилено, причину збережено.' : 'не відхилено (статус уже змінився).'));
        }
    } elseif ($action === 'dismiss') {
        $ok = mpb_dismiss_reports($pdo, $id, $actorId);
        mpb_flash($ok ? 'ok' : 'error', 'Оголошення №' . $id . ': ' . ($ok ? 'скарги розглянуто, оголошення залишено.' : 'не виконано (статус уже змінився).'));
    }
    mpb_redirect($back);
}

// --- Вибірка -------------------------------------------------------------------------
$reportsSql = mpb_reports_sql();
if ($onlyId > 0) {
    $whereSql = 'l.id = :one';
    $params = [':one' => $onlyId];
} elseif ($tab === 'reports') {
    $whereSql = "l.status IN ('published', 'pending') AND $reportsSql > 0";
    $params = [];
} else {
    $whereSql = "l.status = 'pending'";
    $params = [];
}
$stmt = $pdo->prepare(
    "SELECT l.id, l.status, l.seller_id, l.price_type, l.price_amount, l.currency, l.is_remote, l.city, l.source_lang,
            l.created_at, l.updated_at, l.moderated_at, l.expires_at, l.reject_reason, l.created_by,
            s.display_name AS seller_name, u.name AS author_name, u.email AS author_email,
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
     LEFT JOIN users u ON u.id = l.created_by
     LEFT JOIN mp_listing_translations tu ON tu.listing_id = l.id AND tu.lang = 'uk'
     LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang
     WHERE l.section = 'board' AND $whereSql
     ORDER BY l.updated_at ASC, l.id ASC
     LIMIT 100"
);
$stmt->execute($params);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$queueCount = (int) $pdo->query("SELECT COUNT(*) FROM mp_listings WHERE section = 'board' AND status = 'pending'")->fetchColumn();
$reportsCount = (int) $pdo->query(
    "SELECT COUNT(*) FROM mp_listings l WHERE l.section = 'board' AND l.status IN ('published', 'pending') AND $reportsSql > 0"
)->fetchColumn();
$statusLabels = mp_status_labels();
$reasonLabels = ['fraud' => 'Шахрайство', 'prohibited' => 'Заборонений товар чи послуга', 'spam' => 'Спам', 'wrong_category' => 'Неправильна категорія', 'other' => 'Інше'];
$flash = '';
foreach ((array) ($_SESSION['mpb_flash'] ?? []) as $item) {
    $flash .= '<div class="notice notice--' . ($item['type'] === 'error' ? 'error' : 'success') . '"><p>' . mp_e($item['text']) . '</p></div>';
}
unset($_SESSION['mpb_flash']);
?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>AI LAB HUB — Marketplace: модерація</title>
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
        .mod-tabs { display: flex; gap: 8px; margin: 0 0 20px; flex-wrap: wrap; }
    </style>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php"><img class="site-header__logo" src="/logo.png" alt="AI LAB HUB"></a>
    </header>

    <div class="page page--wide">
        <a class="back-link" href="mp-list.php">← До списку пропозицій</a>
        <h1 class="page__title">Marketplace — модерація оголошень</h1>
        <p class="page__subtitle">Оголошення користувачів: нові, відредаговані та зі скаргами. Схвалення дає 30 днів на дошці.</p>

        <?= $flash ?>

        <?php if ($onlyId === 0): ?>
        <div class="mod-tabs">
            <a class="btn btn--sm <?= $tab === 'queue' ? 'btn--primary' : 'btn--ghost' ?>" href="mp-moderation.php">Черга (<?= $queueCount ?>)</a>
            <a class="btn btn--sm <?= $tab === 'reports' ? 'btn--primary' : 'btn--ghost' ?>" href="mp-moderation.php?tab=reports">Зі скаргами (<?= $reportsCount ?>)</a>
        </div>
        <?php else: ?>
            <p><a class="btn btn--ghost btn--sm" href="mp-moderation.php">Уся черга</a></p>
        <?php endif; ?>

        <?php if ($rows === []): ?>
            <p class="empty-state"><?= $onlyId > 0 ? 'Оголошення не знайдено (або воно не з дошки оголошень).' : ($tab === 'reports' ? 'Оголошень зі скаргами немає.' : 'Черга порожня.') ?></p>
        <?php endif; ?>

        <?php foreach ($rows as $r): ?>
            <?php
            $rid = (int) $r['id'];
            $st = (string) $r['status'];
            $photos = mpb_photos($pdo, $rid);
            $contacts = mpb_contacts($pdo, $rid);
            $reports = $pdo->prepare('SELECT reporter_id, reason, note, created_at FROM mp_reports WHERE listing_id = :l ORDER BY id DESC LIMIT 50');
            $reports->execute([':l' => $rid]);
            $reports = $reports->fetchAll(PDO::FETCH_ASSOC);
            $log = $pdo->prepare('SELECT action, note, created_at, actor_id FROM mp_moderation_log WHERE listing_id = :l ORDER BY id DESC LIMIT 6');
            $log->execute([':l' => $rid]);
            $log = $log->fetchAll(PDO::FETCH_ASSOC);
            $loc = mpb_location_label(['city' => $r['city'], 'is_remote' => $r['is_remote']]);
            ?>
            <article class="mod-card" id="l<?= $rid ?>">
                <h2><?= mp_e($r['title'] ?? '(без назви)') ?> <span class="table__id">#<?= $rid ?></span>
                    <span class="badge badge--<?= mp_e($st) ?>"><?= mp_e($statusLabels[$st] ?? $st) ?></span></h2>
                <div class="mod-meta">
                    <span>Ціна: <strong><?= mp_e(mpb_price_label($r)) ?></strong></span>
                    <?php if ($loc !== ''): ?><span>Місце: <?= mp_e($loc) ?></span><?php endif; ?>
                    <span>Категорії: <?= mp_e($r['categories_list'] ?? '—') ?></span>
                    <span>Автор: <?= mp_e($r['author_name'] ?? '—') ?> <?= $r['author_email'] ? '(' . mp_e($r['author_email']) . ')' : '' ?> · продавець: <?= mp_e($r['seller_name'] ?? '—') ?></span>
                    <span>Мова оригіналу: <?= mp_e($r['source_lang']) ?></span>
                    <span>Створено: <?= mp_e(date('d.m.Y H:i', (int) strtotime((string) $r['created_at']))) ?></span>
                    <span>Оновлено: <?= mp_e(date('d.m.Y H:i', (int) strtotime((string) $r['updated_at']))) ?></span>
                    <?php if ($r['expires_at'] !== null): ?><span>Діє до: <?= mp_e(date('d.m.Y H:i', (int) strtotime((string) $r['expires_at']))) ?></span><?php endif; ?>
                </div>

                <?php if ($photos !== []): ?>
                    <div class="mod-photos">
                        <?php foreach ($photos as $p): ?>
                            <a href="<?= mp_e(mpb_photo_url($p['file_name']) ?? '') ?>" target="_blank" rel="noopener"><img src="<?= mp_e(mpb_photo_url($p['thumb_name']) ?? '') ?>" alt=""></a>
                        <?php endforeach; ?>
                    </div>
                <?php else: ?>
                    <p class="table__muted">Без фото.</p>
                <?php endif; ?>

                <p class="mod-text"><strong><?= mp_e($r['short_desc'] ?? '') ?></strong></p>
                <?php if (!empty($r['full_desc'])): ?><p class="mod-text"><?= mp_e($r['full_desc']) ?></p><?php endif; ?>

                <div class="mod-box">
                    <strong>Контакти (бачать лише модератори до кліку користувача):</strong>
                    <?php if ($contacts === []): ?> —
                    <?php else: foreach ($contacts as $c): ?>
                        <div><?= mp_e($c['label']) ?>: <?= mp_e($c['value']) ?></div>
                    <?php endforeach; endif; ?>
                </div>

                <?php if ($st === 'rejected' && !empty($r['reject_reason'])): ?>
                    <div class="mod-box mod-box--warn"><strong>Причина відхилення:</strong> <?= mp_e($r['reject_reason']) ?></div>
                <?php endif; ?>

                <?php if ($reports !== []): ?>
                    <div class="mod-box mod-box--warn">
                        <strong>Скарги (після останньої модерації: <?= (int) $r['reports_count'] ?>, усього: <?= count($reports) ?>):</strong>
                        <?php foreach ($reports as $rp): ?>
                            <div>• <?= mp_e($reasonLabels[$rp['reason']] ?? $rp['reason']) ?> — користувач №<?= (int) $rp['reporter_id'] ?>, <?= mp_e(date('d.m.Y H:i', (int) strtotime((string) $rp['created_at']))) ?><?= $rp['note'] ? ': «' . mp_e($rp['note']) . '»' : '' ?></div>
                        <?php endforeach; ?>
                    </div>
                <?php endif; ?>

                <?php if ($log !== []): ?>
                    <details><summary class="table__muted">Журнал модерації (останні <?= count($log) ?>)</summary>
                        <?php foreach ($log as $lg): ?>
                            <div class="table__muted"><?= mp_e(date('d.m.Y H:i', (int) strtotime((string) $lg['created_at']))) ?> · <?= mp_e($lg['action']) ?><?= $lg['note'] ? ' — ' . mp_e($lg['note']) : '' ?> · <?= $lg['actor_id'] ? 'користувач №' . (int) $lg['actor_id'] : 'система' ?></div>
                        <?php endforeach; ?>
                    </details>
                <?php endif; ?>

                <?php if (in_array($st, ['pending', 'published'], true)): ?>
                <div class="mod-actions">
                    <?php if ($st === 'pending'): ?>
                        <form method="post" action="<?= mp_e($back) ?>">
                            <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $rid ?>"><input type="hidden" name="action" value="approve">
                            <button class="btn btn--primary btn--sm" type="submit">Схвалити</button>
                        </form>
                    <?php endif; ?>
                    <?php if ((int) $r['reports_count'] > 0): ?>
                        <form method="post" action="<?= mp_e($back) ?>">
                            <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $rid ?>"><input type="hidden" name="action" value="dismiss">
                            <button class="btn btn--ghost btn--sm" type="submit">Скарги безпідставні — залишити</button>
                        </form>
                    <?php endif; ?>
                    <form method="post" action="<?= mp_e($back) ?>">
                        <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= $rid ?>"><input type="hidden" name="action" value="reject">
                        <textarea class="textarea" name="reason" rows="2" maxlength="500" required placeholder="Причина відхилення (обов'язково; її побачить автор)"></textarea>
                        <button class="btn btn--ghost btn--sm" type="submit">Відхилити</button>
                    </form>
                </div>
                <?php endif; ?>
            </article>
        <?php endforeach; ?>
    </div>
</body>
</html>
