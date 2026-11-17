<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Правила Marketplace (п. 1.5: перегляд і подача оголошень означають згоду з ними).
 *
 * Текст — docs/marketplace_rules_uk.md (UA) і docs/marketplace_rules_en.md (EN, для інших мов інтерфейсу);
 * рендер — app/mpb-rules.php. Строки й email [MP_XXX] підставляються з констант config/marketplace.php,
 * дата редакції вгорі — MP_RULES_VERSION. Розділи мають якорі #section-N, пункти — #section-N-M.
 * Сторінка доступна завжди, коли відкрита публічна частина Marketplace (при public_enabled=false — лише employee/admin).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mpb-rules.php';

mp_public_or_staff_require();   // при public_enabled=false — лише employee/admin (публіка: 404)

$lang = current_lang();
$rules = mpb_rules_render(null, $lang);
if ($rules === null) {
    mp_not_found();   // файлу правил немає — сторінки немає (тексту в коді не тримаємо)
}
$title = $rules['title'] !== '' ? $rules['title'] : mpl_tr('rules_title');
$docLang = mpb_rules_file($lang) === MPB_RULES_FILE ? 'uk' : 'en';

mpb_open($title, false, 'rules');
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= mp_e($title) ?></h1>
        <p class="mp-note"><?= mp_e(mpl_tr('rules_version', mpb_rules_version_label($lang))) ?></p>
        <?php if ($docLang !== 'uk'): ?>
            <p class="mp-note"><?= mp_e(mpl_tr('rules_uk_prevails')) ?></p>
        <?php endif; ?>
        <?php if ($rules['toc'] !== []): ?>
            <nav class="mp-panel mp-rules-toc" aria-label="<?= mp_e(mpl_tr('rules_toc')) ?>">
                <strong><?= mp_e(mpl_tr('rules_toc')) ?></strong>
                <ol>
                    <?php foreach ($rules['toc'] as $item): ?>
                        <li><a href="#<?= mp_e($item['id']) ?>"><?= mp_e(preg_replace('/^\d+\.\s*/u', '', $item['title'])) ?></a></li>
                    <?php endforeach; ?>
                </ol>
            </nav>
        <?php endif; ?>
        <article class="mp-panel mp-rules" lang="<?= mp_e($docLang) ?>">
            <?= $rules['html'] /* усе екрановано в mpb_rules_render() */ ?>
        </article>
    </div>
<?php mpb_close(); ?>
