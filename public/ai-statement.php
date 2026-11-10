<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Як ми використовуємо АІ». Текст — docs/ai_statement_uk.md (app/ai-statement.php).
 *
 * Поки у файлі є маркери «[ПІДТВЕРДИТИ…]» — 404 для гостя й звичайного користувача; admin і employee бачать сторінку
 * з попередженням і числом маркерів (noindex).
 * Без маркерів — 200 для всіх; посилання в спільному підвалі з'являється автоматично.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mpb-rules.php';
require_once __DIR__ . '/../app/ai-statement.php';

$markers = ais_marker_count();
$isStaff = in_array(mp_live_role(), ['admin', 'employee'], true);   // роль з БД, не з сесії
if ($markers < 0 || ($markers > 0 && !$isStaff)) {
    mp_not_found();
}
$doc = mpb_rules_render(AIS_FILE);
if ($doc === null) {
    mp_not_found();
}
$title = $doc['title'] !== '' ? $doc['title'] : t('ais_title');
if ($markers > 0) {
    header('X-Robots-Tag: noindex, nofollow');
}

mpb_open($title, $markers > 0, '');
?>
    <div class="mp-page mp-page--narrow">
        <?php if ($markers > 0): ?>
            <div class="mp-alert mp-alert--error" role="alert"><?= mp_e(sprintf(t('ais_admin_warning'), $markers)) ?></div>
        <?php endif; ?>
        <h1 class="mp-title"><?= mp_e($title) ?></h1>
        <?php if (current_lang() !== 'uk'): ?>
            <p class="mp-note"><?= mp_e(sprintf(t('mp_original_lang'), 'UA')) ?></p>
        <?php endif; ?>
        <article class="mp-panel mp-rules" lang="uk">
            <?= $doc['html'] /* усе екрановано в mpb_rules_render() */ ?>
        </article>
    </div>
<?php mpb_close(); ?>
