<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: вибране (лише залогінені). Показує лише живі оголошення
 * (published і expires_at > NOW()); записи про закінчені лишаються в mp_favorites.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$userId = mpb_require_login();
$lang = current_lang();

$stmt = $pdo->prepare(
    mpb_select_sql() . ' WHERE ' . mpb_visible_sql() . '
       AND l.id IN (SELECT f.listing_id FROM mp_favorites f WHERE f.user_id = :u1)
     ORDER BY (SELECT f2.created_at FROM mp_favorites f2 WHERE f2.listing_id = l.id AND f2.user_id = :u2) DESC, l.id DESC
     LIMIT 100'
);
$stmt->execute([':lang' => $lang, ':u1' => $userId, ':u2' => $userId]);
$rows = mp_attach_categories($pdo, $stmt->fetchAll(PDO::FETCH_ASSOC), $lang);

mpb_open(t('mpb_fav_title'));
?>
    <div class="mp-page">
        <h1 class="mp-title"><?= mp_e(t('mpb_fav_title')) ?></h1>
        <div class="mp-actions">
            <a class="mp-btn" href="marketplace.php"><?= mp_e(t('mp_heading')) ?></a>
            <a class="mp-btn" href="mp-my.php"><?= mp_e(t('mpb_my_link')) ?></a>
        </div>

        <?= mpb_flash_html() ?>

        <?php if ($rows === []): ?>
            <p class="mp-empty"><?= mp_e(t('mpb_fav_empty')) ?></p>
        <?php else: ?>
            <div class="mp-grid">
                <?php foreach ($rows as $card): ?>
                    <div class="mp-card-wrap">
                        <?php include __DIR__ . '/../app/mpb-card.php'; ?>
                        <form method="post" action="mp-favorite.php" class="mp-card-wrap__form">
                            <?= mp_csrf_field() ?><input type="hidden" name="id" value="<?= (int) $card['id'] ?>"><input type="hidden" name="back" value="fav">
                            <button class="mp-btn" type="submit"><?= mp_e(t('mpb_fav_remove')) ?></button>
                        </form>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>
<?php mpb_close(); ?>
