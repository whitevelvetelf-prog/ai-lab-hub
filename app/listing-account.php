<?php

declare(strict_types=1);

/**
 * AI LAB HUB — розділ-акордеон «Мої оголошення» в кабінеті (account.php): вакансії, курси, послуги власника.
 * Статус, перегляди й переходи за 30 днів, дії: редагувати (→ повторна модерація), продовжити, зняти; експорт CSV.
 * Дії — public/listing-action.php. Показується, коли розділ доступний (показано / співробітник) або вже є оголошення.
 */

require_once __DIR__ . '/listing.php';
require_once __DIR__ . '/mp-drafts.php';
require_once __DIR__ . '/mp-flow-i18n.php';

/**
 * Оголошення дошки користувача (той самий рядок mp_listings, що бачить модератор у «Модерації»).
 *
 * @return list<array<string,mixed>>
 */
function lst_account_board_rows(PDO $pdo, int $userId): array
{
    $st = $pdo->prepare(
        "SELECT l.id, l.status, l.created_at, l.expires_at, l.reject_reason, (l.expires_at IS NOT NULL AND l.expires_at <= NOW()) AS elapsed, t.title
         FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
         LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = l.source_lang
         WHERE s.user_id = :u AND l.post_form = 'ad'
         ORDER BY FIELD(l.status, 'pending', 'published', 'rejected', 'expired', 'draft', 'archived'), l.id DESC LIMIT 100"
    );
    $st->execute([':u' => $userId]);

    return $st->fetchAll(PDO::FETCH_ASSOC);
}

function lst_account_render(PDO $pdo, array $user): void
{
    try {
        $rows = lst_user_listings($pdo, (int) $user['id']);
        $boardRows = lst_account_board_rows($pdo, (int) $user['id']);
    } catch (Throwable $e) {
        return;   // міграцію ще не застосовано
    }
    $drafts = mpd_list($pdo, (int) $user['id']);
    if ($rows === [] && $boardRows === [] && $drafts === [] && !mp_public_enabled() && !mp_is_staff()) {
        return;
    }
    $stats = lst_stats($pdo, array_map(static fn($r) => (int) $r['id'], $rows), 30);
    $flash = mpb_flash_html();
    $csrf = mp_csrf_field();
    ?>
            <div class="accordion" id="acc-listings">
                <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-listings-panel">
                    <?php $myTotal = count($rows) + count($boardRows) + count($drafts); ?>
                    <span class="accordion__title"><?= lst_e(lst_tr('my_title')) ?><?= $myTotal > 0 ? ' (' . $myTotal . ')' : '' ?></span>
                    <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                </button>
                <div class="accordion__panel" id="acc-listings-panel">
                    <div class="accordion__panel-inner pc">
                        <?= $flash ?>
                        <p class="lst-acc-actions">
                            <?php foreach (LST_TYPES as $t): ?>
                                <a class="pc-btn" href="listing-post.php?type=<?= $t ?>">+ <?= lst_e(lst_tr('post_' . $t)) ?></a>
                            <?php endforeach; ?>
                            <?php if ($rows !== []): ?><a class="pc-btn" href="listing-action.php?export=csv"><?= lst_e(lst_tr('my_csv')) ?></a><?php endif; ?>
                        </p>
                        <?php $free = lst_free_label($pdo); if ($free !== ''): ?><p class="pc-muted"><?= lst_e($free) ?></p><?php endif; ?>
                        <?php if ($drafts !== []): ?>
                            <ul class="lst-drafts">
                                <?php foreach ($drafts as $d): $dk = (string) $d['form_key']; ?>
                                    <li><span class="pc-badge pc-badge--draft"><?= lst_e(mpf_tr('draft_badge')) ?></span>
                                        <strong><?= lst_e($d['title'] !== '' ? $d['title'] : mpf_tr('draft_untitled')) ?></strong>
                                        <span class="pc-muted"> · <?= lst_e($dk === 'board' ? mpf_tr('draft_board') : lst_tr('type1_' . substr($dk, 8))) ?> · <?= lst_e(date('d.m.Y H:i', (int) strtotime((string) $d['updated_at']))) ?></span>
                                        <a class="pc-btn pc-btn--small" href="<?= lst_e(mpd_form_url($dk)) ?>"><?= lst_e(mpf_tr('draft_continue')) ?></a></li>
                                <?php endforeach; ?>
                            </ul>
                        <?php endif; ?>
                        <?php if ($boardRows !== []): ?>
                            <div class="pc-table-wrap">
                                <table class="pc-table">
                                    <thead><tr><th><?= lst_e(mpf_tr('draft_board')) ?></th><th><?= lst_e(lst_tr('my_col_status')) ?></th><th><?= lst_e(lst_tr('my_col_actions')) ?></th></tr></thead>
                                    <tbody>
                                    <?php foreach ($boardRows as $b):
                                        $bid = (int) $b['id'];
                                        $bst = (string) $b['status'] === 'published' && (int) $b['elapsed'] === 1 ? 'expired' : (string) $b['status']; ?>
                                        <tr>
                                            <td data-label="<?= lst_e(mpf_tr('draft_board')) ?>"><a href="marketplace-offer.php?id=<?= $bid ?>"><?= lst_e($b['title'] ?? '#' . $bid) ?></a>
                                                <?php if ($bst === 'rejected' && !empty($b['reject_reason'])): ?><br><span class="pc-warn-text"><?= lst_e($b['reject_reason']) ?></span><?php endif; ?></td>
                                            <td data-label="<?= lst_e(lst_tr('my_col_status')) ?>"><span class="pc-badge pc-badge--<?= lst_e($bst) ?>"><?= lst_e(lst_tr('st_' . $bst)) ?></span></td>
                                            <td data-label="<?= lst_e(lst_tr('my_col_actions')) ?>"><?php if ($bst !== 'archived'): ?><a class="pc-btn pc-btn--small" href="marketplace-post.php?id=<?= $bid ?>"><?= lst_e(lst_tr('my_edit')) ?></a><?php endif; ?>
                                                <a class="pc-btn pc-btn--small" href="marketplace-my.php"><?= lst_e(lst_tr('my_view')) ?></a></td>
                                        </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php endif; ?>
                        <?php if ($rows === [] && ($boardRows !== [] || $drafts !== [])): ?>
                        <?php elseif ($rows === []): ?>
                            <p class="pc-empty"><?= lst_e(lst_tr('my_empty')) ?></p>
                        <?php else: ?>
                        <div class="pc-table-wrap">
                            <table class="pc-table">
                                <thead><tr>
                                    <th><?= lst_e(lst_tr('my_col_listing')) ?></th><th><?= lst_e(lst_tr('my_col_status')) ?></th>
                                    <th><?= lst_e(lst_tr('my_col_stats')) ?></th><th><?= lst_e(lst_tr('my_col_until')) ?></th><th><?= lst_e(lst_tr('my_col_actions')) ?></th>
                                </tr></thead>
                                <tbody>
                                <?php foreach ($rows as $r):
                                    $id = (int) $r['id'];
                                    $status = (string) $r['status'] === 'published' && (int) $r['elapsed'] === 1 ? 'expired' : (string) $r['status'];
                                    $s = $stats[$id] ?? ['views' => 0, 'clicks' => 0];
                                    $canExtend = $status === 'expired' || ($status === 'published' && strtotime((string) $r['expires_at']) <= time() + LST_EXTEND_WINDOW_DAYS * 86400); ?>
                                    <tr>
                                        <td data-label="<?= lst_e(lst_tr('my_col_listing')) ?>">
                                            <a href="<?= lst_e(lst_url($r)) ?>"><?= lst_e($r['title'] ?? '#' . $id) ?></a><br>
                                            <span class="pc-muted"><?= lst_e(lst_tr('type1_' . $r['section'])) ?> · <?= lst_e($r['company_name']) ?></span>
                                            <?php if ($status === 'rejected' && !empty($r['reject_reason'])): ?><br><span class="pc-warn-text"><?= lst_e($r['reject_reason']) ?></span><?php endif; ?>
                                        </td>
                                        <td data-label="<?= lst_e(lst_tr('my_col_status')) ?>"><span class="pc-badge pc-badge--<?= lst_e($status) ?>"><?= lst_e(lst_tr('st_' . $status)) ?></span></td>
                                        <td data-label="<?= lst_e(lst_tr('my_col_stats')) ?>"><?= $s['views'] ?> / <?= $s['clicks'] ?></td>
                                        <td data-label="<?= lst_e(lst_tr('my_col_until')) ?>"><?= $status === 'published' ? lst_e(lst_date((string) $r['expires_at'])) : '—' ?></td>
                                        <td data-label="<?= lst_e(lst_tr('my_col_actions')) ?>" class="lst-acc-row-actions">
                                            <?php if ($status !== 'archived'): ?><a class="pc-btn pc-btn--small" href="listing-post.php?id=<?= $id ?>"><?= lst_e(lst_tr('my_edit')) ?></a><?php endif; ?>
                                            <?php if ($canExtend): ?>
                                                <form method="post" action="listing-action.php" class="pc-inline-form"><?= $csrf ?><input type="hidden" name="action" value="extend"><input type="hidden" name="id" value="<?= $id ?>"><button class="pc-btn pc-btn--small" type="submit"><?= lst_e(lst_tr('my_extend')) ?></button></form>
                                            <?php endif; ?>
                                            <?php if (in_array($status, ['pending', 'published', 'expired', 'rejected'], true)): ?>
                                                <form method="post" action="listing-action.php" class="pc-inline-form" data-pc-confirm="<?= lst_e(lst_tr('my_remove_confirm')) ?>"><?= $csrf ?><input type="hidden" name="action" value="remove"><input type="hidden" name="id" value="<?= $id ?>"><button class="pc-btn pc-btn--small pc-btn--danger" type="submit"><?= lst_e(lst_tr('my_remove')) ?></button></form>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                        <p class="pc-muted"><?= lst_e(lst_tr('my_stats_note')) ?></p>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
            <?= promo_cabinet_assets() ?>
    <?php
}
