<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: мої оголошення (кабінет автора; будь-який залогінений користувач).
 *
 * Вкладки: На модерації / Активні / Завершені / Відхилені. Дії (POST + CSRF): «Продовжити» (+30 днів), «Архівувати».
 * Дії застосовуються лише до власних оголошень (mpb_own_listing перевіряє власника).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$userId = mpb_require_login();
$lang = current_lang();

/** Вкладка → умова SQL (alias l). «Завершені» включають published із минулим терміном (cron міг не встигнути). */
$tabs = [
    'pending'  => ["l.status IN ('pending', 'draft')", 'mpb_tab_pending'],
    'active'   => ["l.status = 'published' AND l.expires_at > NOW()", 'mpb_tab_active'],
    'finished' => ["(l.status IN ('expired', 'archived') OR (l.status = 'published' AND l.expires_at <= NOW()))", 'mpb_tab_finished'],
    'rejected' => ["l.status = 'rejected'", 'mpb_tab_rejected'],
];
$tab = is_string($_GET['tab'] ?? null) && isset($tabs[$_GET['tab']]) ? (string) $_GET['tab'] : 'active';

// --- Дії ------------------------------------------------------------------------
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    mpb_require_post();
    $action = (string) ($_POST['action'] ?? '');
    $own = mpb_own_listing($pdo, (int) ($_POST['id'] ?? 0), $userId);
    if ($own === null) {
        mp_not_found();
    }
    if ($action === 'extend') {
        $res = mpb_extend($pdo, $own, $userId);
        mpb_flash($res === 'ok' ? 'ok' : 'error', t($res === 'ok' ? 'mpb_extended' : $res));
    } elseif ($action === 'archive') {
        $done = mpb_archive($pdo, $own, $userId);
        mpb_flash($done ? 'ok' : 'error', t($done ? 'mpb_archived' : 'mpb_err_archive'));
    }
    mpb_redirect('mp-my.php?tab=' . $tab);
}

// --- Лічильники вкладок ------------------------------------------------------------
$counts = [];
foreach ($tabs as $key => [$cond]) {
    $c = $pdo->prepare(
        "SELECT COUNT(*) FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
         WHERE s.user_id = :u AND l.section = 'board' AND ($cond)"
    );
    $c->execute([':u' => $userId]);
    $counts[$key] = (int) $c->fetchColumn();
}

// --- Список вибраної вкладки ---------------------------------------------------------
$stmt = $pdo->prepare(
    mpb_select_sql() . " WHERE l.section = 'board' AND s.user_id = :u AND (" . $tabs[$tab][0] . ')
     ORDER BY l.updated_at DESC, l.id DESC LIMIT 200'
);
$stmt->execute([':lang' => $lang, ':u' => $userId]);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

$statusKey = ['pending' => 'mpb_st_pending', 'draft' => 'mpb_st_pending', 'published' => 'mpb_st_published', 'rejected' => 'mpb_st_rejected', 'archived' => 'mpb_st_archived', 'expired' => 'mpb_st_expired'];

mpb_open(t('mpb_my_title'));
?>
    <div class="mp-page">
        <h1 class="mp-title"><?= mp_e(t('mpb_my_title')) ?></h1>
        <div class="mp-actions">
            <a class="mp-btn mp-btn--primary" href="mp-post.php"><?= mp_e(t('mpb_post_btn')) ?></a>
            <a class="mp-btn" href="mp-favorites.php"><?= mp_e(t('mpb_fav_title')) ?></a>
            <a class="mp-btn" href="marketplace.php"><?= mp_e(t('mp_heading')) ?></a>
        </div>

        <?= mpb_flash_html() ?>

        <nav class="mp-tabs" aria-label="<?= mp_e(t('mpb_my_title')) ?>">
            <?php foreach ($tabs as $key => [, $labelKey]): ?>
                <a class="mp-tab<?= $key === $tab ? ' is-active' : '' ?>" href="mp-my.php?tab=<?= mp_e($key) ?>"><?= mp_e(t($labelKey)) ?> <span class="mp-chip__count"><?= (int) $counts[$key] ?></span></a>
            <?php endforeach; ?>
        </nav>

        <?php if ($rows === []): ?>
            <p class="mp-empty"><?= mp_e(t('mpb_my_empty')) ?></p>
        <?php else: ?>
            <ul class="mp-my-list">
                <?php foreach ($rows as $r): ?>
                    <?php
                    $rid = (int) $r['id'];
                    $thumb = !empty($r['cover_thumb']) ? mpb_photo_url((string) $r['cover_thumb']) : null;
                    $st = (string) $r['status'];
                    $live = mpb_row_is_live($r);
                    $canExtend = $st === 'expired' || $st === 'published';
                    ?>
                    <li class="mp-my-item">
                        <?php if ($thumb !== null): ?><img class="mp-my-item__thumb" src="<?= mp_e($thumb) ?>" alt="" loading="lazy"><?php else: ?><span class="mp-my-item__thumb mp-my-item__thumb--empty"></span><?php endif; ?>
                        <div class="mp-my-item__body">
                            <h2 class="mp-my-item__title">
                                <?php if ($live): ?><a href="offer.php?id=<?= $rid ?>"><?= mp_e($r['title']) ?></a><?php else: ?><?= mp_e($r['title']) ?><?php endif; ?>
                            </h2>
                            <p class="mp-my-item__meta">
                                <span class="mp-status mp-status--<?= mp_e($st) ?>"><?= mp_e(t($statusKey[$st] ?? 'mpb_st_pending')) ?></span>
                                <span><?= mp_e(mpb_price_label($r)) ?></span>
                                <?php if ($r['expires_at'] !== null && in_array($st, ['published', 'expired'], true)): ?>
                                    <span><?= mp_e(t($live ? 'mpb_until' : 'mpb_ended')) ?> <?= mp_e(date('d.m.Y', (int) strtotime((string) $r['expires_at']))) ?></span>
                                <?php endif; ?>
                                <span><?= mp_e(t('mpb_views')) ?>: <?= (int) $r['views_count'] ?></span>
                            </p>
                            <?php if ($st === 'rejected' && !empty($r['reject_reason'])): ?>
                                <p class="mp-alert mp-alert--error mp-alert--inline"><strong><?= mp_e(t('mpb_reject_reason')) ?>:</strong> <?= mp_e($r['reject_reason']) ?></p>
                            <?php endif; ?>
                            <div class="mp-my-item__actions">
                                <a class="mp-btn" href="mp-post.php?id=<?= $rid ?>"><?= mp_e(t('mpb_edit_btn')) ?></a>
                                <?php if ($canExtend): ?>
                                    <form method="post" action="mp-my.php?tab=<?= mp_e($tab) ?>" class="mp-inline-form">
                                        <?= mp_csrf_field() ?><input type="hidden" name="action" value="extend"><input type="hidden" name="id" value="<?= $rid ?>">
                                        <button class="mp-btn" type="submit"><?= mp_e(t('mpb_extend_btn')) ?></button>
                                    </form>
                                <?php endif; ?>
                                <?php if ($st !== 'archived'): ?>
                                    <form method="post" action="mp-my.php?tab=<?= mp_e($tab) ?>" class="mp-inline-form">
                                        <?= mp_csrf_field() ?><input type="hidden" name="action" value="archive"><input type="hidden" name="id" value="<?= $rid ?>">
                                        <button class="mp-btn" type="submit"><?= mp_e(t('mpb_archive_btn')) ?></button>
                                    </form>
                                <?php endif; ?>
                            </div>
                        </div>
                    </li>
                <?php endforeach; ?>
            </ul>
        <?php endif; ?>
    </div>
<?php mpb_close(); ?>
