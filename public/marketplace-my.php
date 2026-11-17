<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: мої оголошення (кабінет автора; будь-який залогінений користувач).
 *
 * Вкладки: На модерації / Активні / Потребують уваги (на доопрацюванні, приховані, зняті) / Завершені / Відхилені.
 * Статус і причина рішення (пункт Правил + пояснення) — біля кожного оголошення (п. 7.3).
 * Дії (POST + CSRF): «Продовжити» (+MP_LISTING_LIFETIME_DAYS днів, без повторної модерації), «Архівувати».
 * Дії застосовуються лише до власних оголошень (mpb_own_listing перевіряє власника).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-stats.php';
require_once __DIR__ . '/../app/mp-legal-ui.php';   // повідомлення, скарги правовласників, оскарження (Правила, п. 7.5, 10.3)

mp_public_or_staff_require();   // при public_enabled=false — лише employee/admin (публіка: 404)

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$userId = mpb_require_login();
$lang = current_lang();

/** Вкладка → умова SQL (alias l). «Завершені» включають published із минулим терміном (cron міг не встигнути). */
$tabs = [
    'pending'  => ["l.status IN ('pending', 'draft')", 'mpb_tab_pending'],
    'active'   => ["l.status = 'published' AND l.expires_at > NOW()", 'mpb_tab_active'],
    'attention' => ["l.status IN ('needs_changes', 'hidden', 'removed')", 'mpl:my_attention_tab'],
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
        if (mpl_posting_block($pdo, $userId) !== null) {
            mpb_flash('error', mpl_tr('ban_title'));
            mpb_redirect('marketplace-my.php?tab=' . $tab);
        }
        $res = mpb_extend($pdo, $own, $userId);
        mpb_flash($res === 'ok' ? 'ok' : 'error', t($res === 'ok' ? 'mpb_extended' : $res));
    } elseif ($action === 'archive') {
        $done = mpb_archive($pdo, $own, $userId);
        mpb_flash($done ? 'ok' : 'error', t($done ? 'mpb_archived' : 'mpb_err_archive'));
    }
    mpb_redirect('marketplace-my.php?tab=' . $tab);
}

// --- Лічильники вкладок ------------------------------------------------------------
$counts = [];
foreach ($tabs as $key => [$cond]) {
    $c = $pdo->prepare(
        "SELECT COUNT(*) FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
         WHERE s.user_id = :u AND l.post_form = 'ad' AND ($cond)"
    );
    $c->execute([':u' => $userId]);
    $counts[$key] = (int) $c->fetchColumn();
}

// --- Список вибраної вкладки ---------------------------------------------------------
$stmt = $pdo->prepare(
    mpb_select_sql() . " WHERE l.post_form = 'ad' AND s.user_id = :u AND (" . $tabs[$tab][0] . ')
     ORDER BY l.updated_at DESC, l.id DESC LIMIT 200'
);
$stmt->execute([':lang' => $lang, ':u' => $userId]);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Фото кожного оголошення — для перегляду в оверлеї (public/assets/js/mp-gallery.js) з мініатюри.
$photosBy = [];
if ($rows !== []) {
    $ids = implode(',', array_map(static fn(array $r): int => (int) $r['id'], $rows));
    foreach ($pdo->query("SELECT listing_id, file_name, thumb_name FROM mp_listing_photos WHERE listing_id IN ($ids) ORDER BY sort_order, id")->fetchAll(PDO::FETCH_ASSOC) as $ph) {
        $photosBy[(int) $ph['listing_id']][] = $ph;
    }
}

$views30 = mpst_views_30($pdo, array_map(static fn(array $r): int => (int) $r['id'], $rows));
$reveals = [];
if ($rows !== []) {
    $ids = implode(',', array_map(static fn(array $r): int => (int) $r['id'], $rows));
    foreach ($pdo->query("SELECT listing_id, COUNT(*) FROM mp_contact_reveals WHERE listing_id IN ($ids) GROUP BY listing_id")->fetchAll(PDO::FETCH_KEY_PAIR) as $lid => $n) {
        $reveals[(int) $lid] = (int) $n;
    }
}
$statusKey = ['pending' => 'mpb_st_pending', 'draft' => 'mpb_st_pending', 'published' => 'mpb_st_published', 'rejected' => 'mpb_st_rejected', 'archived' => 'mpb_st_archived', 'expired' => 'mpb_st_expired'];
// Код і причина рішення (міграція 2026-11-17) — окремим запитом, щоб до міграції сторінка працювала.
$decisions = [];
if ($rows !== []) {
    try {
        $ids = implode(',', array_map(static fn(array $r): int => (int) $r['id'], $rows));
        foreach ($pdo->query("SELECT id, reject_code FROM mp_listings WHERE id IN ($ids)")->fetchAll(PDO::FETCH_KEY_PAIR) as $did => $dcode) {
            $decisions[(int) $did] = $dcode;
        }
    } catch (Throwable) {
    }
}

$postingOpen = mpb_posting_open();

mpb_open(t('mpb_my_title'), true, 'my');
?>
    <div class="mp-page">
        <h1 class="mp-title"><?= mp_e(t('mpb_my_title')) ?></h1>
        <p class="mp-actions mp-actions--tight"><a class="mp-btn" href="mp-seller-settings.php"><?= mp_e(t('mpsl_settings_title')) ?></a> <a class="mp-btn" href="mp-saved.php"><?= mp_e(t('mpss_page_title')) ?></a></p>
        <?= mpb_flash_html() ?>

        <?php if (!$postingOpen): ?>
            <div class="mp-alert mp-alert--error"><?= mp_e(t('mpb_posting_closed')) ?></div>
        <?php endif; ?>
        <?php $block = mpl_posting_block($pdo, $userId); ?>
        <?php if ($block !== null): ?>
            <div class="mp-alert mp-alert--error"><?= mpl_posting_block_html($block) /* екрановано всередині */ ?></div>
        <?php endif; ?>

        <?= mpl_cabinet_html($pdo, $userId) ?>

        <nav class="mp-tabs" aria-label="<?= mp_e(t('mpb_my_title')) ?>">
            <?php foreach ($tabs as $key => [, $labelKey]): ?>
                <a class="mp-tab<?= $key === $tab ? ' is-active' : '' ?>" href="marketplace-my.php?tab=<?= mp_e($key) ?>"><?= mp_e(str_starts_with($labelKey, 'mpl:') ? mpl_tr(substr($labelKey, 4)) : t($labelKey)) ?> <span class="mp-chip__count"><?= (int) $counts[$key] ?></span></a>
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
                        <?php if ($thumb !== null && !empty($photosBy[$rid])): ?>
                            <div class="mp-my-item__gallery" data-mp-gallery>
                                <?php foreach ($photosBy[$rid] as $pi => $ph): ?>
                                    <a href="<?= mp_e(mpb_photo_url((string) $ph['file_name']) ?? '') ?>" data-mp-photo data-alt="<?= mp_e($r['title'] . ' — ' . sprintf(t('mpb_photo_n'), $pi + 1)) ?>"<?= $pi > 0 ? ' hidden' : '' ?>><?php if ($pi === 0): ?><img class="mp-my-item__thumb" src="<?= mp_e($thumb) ?>" alt="<?= mp_e(sprintf(t('mpb_photo_n'), 1)) ?>" loading="lazy"><?php endif; ?></a>
                                <?php endforeach; ?>
                            </div>
                        <?php elseif ($thumb !== null): ?><img class="mp-my-item__thumb" src="<?= mp_e($thumb) ?>" alt="" loading="lazy"><?php else: ?><span class="mp-my-item__thumb mp-my-item__thumb--empty"></span><?php endif; ?>
                        <div class="mp-my-item__body">
                            <h2 class="mp-my-item__title">
                                <?php if ($live): ?><a href="marketplace-offer.php?id=<?= $rid ?>"><?= mp_e($r['title']) ?></a><?php else: ?><?= mp_e($r['title']) ?><?php endif; ?>
                            </h2>
                            <p class="mp-my-item__meta">
                                <span class="mp-status mp-status--<?= mp_e($st) ?>"><?= mp_e(isset($statusKey[$st]) ? t($statusKey[$st]) : mpl_status_label($st)) ?></span>
                                <span><?= mp_e(mpb_price_label($r) ?: t('mpb_pt_none')) ?></span>
                                <?php if ($r['expires_at'] !== null && in_array($st, ['published', 'expired'], true)): ?>
                                    <span><?= mp_e(t($live ? 'mpb_until' : 'mpb_ended')) ?> <?= mp_e(date('d.m.Y', (int) strtotime((string) $r['expires_at']))) ?></span>
                                <?php endif; ?>
                                <span><?= mp_e(t('mpb_views')) ?>: <?= (int) $r['views_count'] ?></span>
                                <span><?= mp_e(sprintf(t('mpst_views_30'), (int) ($views30[$rid] ?? 0))) ?></span>
                                <span><?= mp_e(mpl_tr('my_contact_views', (int) ($reveals[$rid] ?? 0))) ?></span>
                            </p>
                            <?php $why = mpl_reason_text($decisions[$rid] ?? null, $r['reject_reason'] ?? null); ?>
                            <?php if (in_array($st, ['rejected', 'needs_changes', 'hidden', 'removed'], true) && $why !== ''): ?>
                                <p class="mp-alert mp-alert--error mp-alert--inline"><strong><?= mp_e(mpl_tr('my_reason')) ?>:</strong> <?= mp_e($why) ?></p>
                            <?php endif; ?>
                            <div class="mp-my-item__actions">
                                <a class="mp-btn" href="mp-stats.php?id=<?= $rid ?>"><?= mp_e(t('mpst_link')) ?></a>
                                <?php if ($postingOpen && !in_array($st, ['hidden', 'removed'], true)): ?><a class="mp-btn" href="marketplace-post.php?id=<?= $rid ?>"><?= mp_e(t('mpb_edit_btn')) ?></a><?php endif; ?>
                                <?php if ($canExtend && $postingOpen): ?>
                                    <form method="post" action="marketplace-my.php?tab=<?= mp_e($tab) ?>" class="mp-inline-form">
                                        <?= mp_csrf_field() ?><input type="hidden" name="action" value="extend"><input type="hidden" name="id" value="<?= $rid ?>">
                                        <button class="mp-btn" type="submit"><?= mp_e(t('mpb_extend_btn')) ?></button>
                                    </form>
                                <?php endif; ?>
                                <?php if (!in_array($st, ['archived', 'removed'], true)): ?>
                                    <form method="post" action="marketplace-my.php?tab=<?= mp_e($tab) ?>" class="mp-inline-form" data-confirm="">
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
<script src="/assets/js/mp-gallery.js?v=<?= (int) @filemtime(__DIR__ . '/assets/js/mp-gallery.js') ?>"></script>
<?php mpb_close(); ?>
