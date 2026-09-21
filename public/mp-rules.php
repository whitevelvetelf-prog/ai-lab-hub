<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: Правила розміщення оголошень.
 *
 * Текст — docs/marketplace_rules_uk.md (рендерить app/mpb-rules.php); дата редакції — config 'rules_version'.
 * [Місця для підстановки] у тексті виводяться видимим маркером. Доступна лише при public_enabled = true.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mpb-rules.php';

mp_public_require();

$rules = mpb_rules_render();
$title = $rules !== null && $rules['title'] !== '' ? $rules['title'] : t('mpb_rules_title');

mpb_open($title, false);
?>
    <div class="mp-page mp-page--narrow">
        <a class="mp-back" href="marketplace.php"><?= mp_e(t('mp_back')) ?></a>
        <h1 class="mp-title"><?= mp_e($title) ?></h1>
        <?php if (current_lang() !== 'uk'): ?>
            <p class="mp-note"><?= mp_e(t('mpb_rules_uk_only')) ?></p>
        <?php endif; ?>
        <article class="mp-panel mp-rules" lang="uk">
            <?php if ($rules !== null): ?>
                <?= $rules['html'] /* усе екрановано в mpb_rules_render() */ ?>
            <?php else: ?>
                <p class="mp-text"><?= mp_e(t('mpb_rules_placeholder')) ?></p>
            <?php endif; ?>
        </article>
    </div>
<?php mpb_close(); ?>
