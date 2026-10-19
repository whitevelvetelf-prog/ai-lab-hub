<?php

declare(strict_types=1);

/**
 * AI LAB HUB — розділ-акордеон «Мої оголошення» в кабінеті (account.php): вакансії, курси, послуги власника.
 * Статус, перегляди й переходи за 30 днів, дії: редагувати (→ повторна модерація), продовжити, зняти; експорт CSV.
 * Дії — public/listing-action.php. Показується, коли розділ доступний (показано / співробітник) або вже є оголошення.
 */

require_once __DIR__ . '/listing.php';

function lst_account_render(PDO $pdo, array $user): void
{
    try {
        $rows = lst_user_listings($pdo, (int) $user['id']);
    } catch (Throwable $e) {
        return;   // міграцію ще не застосовано
    }
    if ($rows === [] && !mp_public_enabled() && !mp_is_staff()) {
        return;
    }
    $stats = lst_stats($pdo, array_map(static fn($r) => (int) $r['id'], $rows), 30);
    $flash = mpb_flash_html();
    $csrf = mp_csrf_field();
    ?>
            <div class="accordion" id="acc-listings">
                <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-listings-panel">
                    <span class="accordion__title"><?= lst_e(lst_tr('my_title')) ?><?= $rows !== [] ? ' (' . count($rows) . ')' : '' ?></span>
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
                        <?php if ($rows === []): ?>
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
