<?php

declare(strict_types=1);

/**
 * AI LAB HUB — розділ-акордеон «Мої цифрові матеріали» в кабінеті (account.php): статус, перегляди, завантаження,
 * скарги (з посиланням на зустрічну заяву), дії: редагувати (→ повторна модерація), продовжити, зняти,
 * «Підтвердження публікації». Дії — public/asset-action.php. Показується, коли розділ доступний або вже є матеріали.
 */

require_once __DIR__ . '/asset.php';

function ast_account_render(PDO $pdo, array $user): void
{
    try {
        $rows = ast_user_assets($pdo, (int) $user['id']);
    } catch (Throwable $e) {
        return;   // міграцію ще не застосовано
    }
    if ($rows === [] && !mp_public_enabled() && !mp_is_staff()) {
        return;
    }
    $csrf = mp_csrf_field();
    $strikes = ast_strikes($pdo, (int) $user['id']);
    ?>
            <div class="accordion" id="acc-assets">
                <button type="button" class="accordion__header" aria-expanded="false" aria-controls="acc-assets-panel">
                    <span class="accordion__title"><?= ast_e(ast_tr('my_title')) ?><?= $rows !== [] ? ' (' . count($rows) . ')' : '' ?></span>
                    <span class="accordion__chevron" aria-hidden="true">&#9662;</span>
                </button>
                <div class="accordion__panel" id="acc-assets-panel">
                    <div class="accordion__panel-inner pc">
                        <p class="lst-acc-actions"><a class="pc-btn" href="asset-post.php">+ <?= ast_e(ast_tr('post_btn')) ?></a> <a class="pc-btn" href="assets.php"><?= ast_e(ast_tr('nav')) ?></a></p>
                        <?php if ($strikes > 0): ?><p class="pc-note pc-note--warn"><?= ast_e(ast_tr('err_blocked')) ?> (<?= $strikes ?>/<?= (int) ast_settings($pdo)['strikes_limit'] ?>)</p><?php endif; ?>
                        <?php if ($rows === []): ?>
                            <p class="pc-empty"><?= ast_e(ast_tr('my_empty')) ?></p>
                        <?php else: ?>
                        <div class="pc-table-wrap">
                            <table class="pc-table">
                                <thead><tr>
                                    <th><?= ast_e(ast_tr('my_col_asset')) ?></th><th><?= ast_e(ast_tr('my_col_status')) ?></th>
                                    <th><?= ast_e(ast_tr('my_col_stats')) ?></th><th><?= ast_e(ast_tr('my_col_claims')) ?></th><th><?= ast_e(ast_tr('my_col_actions')) ?></th>
                                </tr></thead>
                                <tbody>
                                <?php foreach ($rows as $r):
                                    $id = (int) $r['id'];
                                    $status = (string) $r['status'];
                                    if ($status === 'published' && $r['expires_at'] !== null && strtotime((string) $r['expires_at']) <= time()) {
                                        $status = 'expired';
                                    } ?>
                                    <tr>
                                        <td data-label="<?= ast_e(ast_tr('my_col_asset')) ?>"><a href="asset.php?id=<?= $id ?>"><?= ast_e($r['title'] ?? '#' . $id) ?></a><br>
                                            <span class="pc-muted"><?= ast_e(ast_tr('kind_' . $r['asset_kind'])) ?> · <?= ast_e($r['license_code']) ?></span></td>
                                        <td data-label="<?= ast_e(ast_tr('my_col_status')) ?>"><span class="pc-badge pc-badge--<?= ast_e($status) ?>"><?= ast_e(ast_tr('st_' . $status)) ?></span>
                                            <?php if ($status === 'rejected' && !empty($r['reject_reason'])): ?><span class="pc-reason"><?= ast_e($r['reject_reason']) ?></span><?php endif; ?></td>
                                        <td data-label="<?= ast_e(ast_tr('my_col_stats')) ?>"><?= (int) $r['views_count'] ?> / <?= (int) $r['downloads'] ?></td>
                                        <td data-label="<?= ast_e(ast_tr('my_col_claims')) ?>"><?= (int) $r['claims'] ?>
                                            <?php if (!empty($r['open_claim'])): ?><br><a href="copyright-counter.php?id=<?= (int) $r['open_claim'] ?>"><?= ast_e(ast_tr('my_counter')) ?></a><?php endif; ?></td>
                                        <td data-label="<?= ast_e(ast_tr('my_col_actions')) ?>">
                                            <?php if ($status !== 'disabled'): ?><a class="pc-btn pc-btn--small" href="asset-post.php?id=<?= $id ?>"><?= ast_e(ast_tr('my_edit')) ?></a><?php endif; ?>
                                            <a class="pc-btn pc-btn--small" href="asset-proof.php?id=<?= $id ?>"><?= ast_e(ast_tr('my_proof')) ?></a>
                                            <?php if (in_array($status, ['published', 'expired'], true)): ?>
                                                <form method="post" action="asset-action.php" class="pc-inline-form"><?= $csrf ?><input type="hidden" name="id" value="<?= $id ?>">
                                                    <button class="pc-btn pc-btn--small" type="submit" name="action" value="extend"><?= ast_e(ast_tr('my_extend')) ?></button></form>
                                            <?php endif; ?>
                                            <?php if (in_array($status, ['pending', 'published', 'rejected', 'expired'], true)): ?>
                                                <form method="post" action="asset-action.php" class="pc-inline-form"><?= $csrf ?><input type="hidden" name="id" value="<?= $id ?>">
                                                    <button class="pc-btn pc-btn--small" type="submit" name="action" value="remove"><?= ast_e(ast_tr('my_remove')) ?></button></form>
                                            <?php endif; ?>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
    <?php
}
