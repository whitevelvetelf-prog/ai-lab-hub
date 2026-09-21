<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: Правила розміщення оголошень.
 * ЗАГЛУШКА: повний текст правил буде написано окремо (див. ключ mpb_rules_placeholder).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';

mp_public_require();

mpb_open(t('mpb_rules_title'), false);
?>
    <div class="mp-page mp-page--narrow">
        <a class="mp-back" href="marketplace.php"><?= mp_e(t('mp_back')) ?></a>
        <h1 class="mp-title"><?= mp_e(t('mpb_rules_title')) ?></h1>
        <section class="mp-panel">
            <p class="mp-text"><?= mp_e(t('mpb_rules_placeholder')) ?></p>
        </section>
    </div>
<?php mpb_close(); ?>
