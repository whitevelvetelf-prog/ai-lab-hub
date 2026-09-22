<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: Правила розміщення оголошень.
 *
 * Текст — docs/marketplace_rules_uk.md (рендерить app/mpb-rules.php); дата редакції — config 'rules_version'.
 * [Місця для підстановки] у тексті виводяться видимим маркером. Доступна лише при public_enabled = true;
 * поки posting_enabled = false — тільки employee/admin (решта — 404).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mpb-rules.php';

mp_public_or_staff_require();   // при public_enabled=false — лише employee/admin (публіка: 404)

// Поетапний запуск: поки подачу закрито, Правила бачать лише employee/admin (посилання в галочці форми); решті — 404.
if (!mpb_posting_open()) {
    mp_not_found();
}

$rules = mpb_rules_render();
if ($rules === null) {
    mp_not_found();   // файлу правил немає — сторінки немає (тексту в коді/рядках інтерфейсу не тримаємо)
}
$title = $rules['title'] !== '' ? $rules['title'] : t('mpb_f_rules_link');

mpb_open($title, false);
?>
    <div class="mp-page mp-page--narrow">
        <a class="mp-back" href="marketplace.php"><?= mp_e(t('mp_back')) ?></a>
        <h1 class="mp-title"><?= mp_e($title) ?></h1>
        <?php if (current_lang() !== 'uk'): ?>
            <p class="mp-note"><?= mp_e(t('mpb_rules_uk_only')) ?></p>
        <?php endif; ?>
        <article class="mp-panel mp-rules" lang="uk">
            <?= $rules['html'] /* усе екрановано в mpb_rules_render() */ ?>
        </article>
    </div>
<?php mpb_close(); ?>
