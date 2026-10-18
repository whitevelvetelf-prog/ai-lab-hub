<?php

declare(strict_types=1);

/**
 * AI LAB HUB — покрокова інструкція рекламодавця (UA/EN, тексти — app/promo-i18n.php, guide_*).
 *
 * Як замовити (акаунт → майстер із 5 кроків), вартість (ціни з ad_rate_card,
 * приклад розрахунку лише коли задано і прайс, і min_topup), оплата (заявка +
 * призначення AILABHUB-PROMO-<id>), модерація й статуси, налаштування показу,
 * статистика, типові помилки. Ліміти відео, мінімальне поповнення й строк
 * модерації — з ad_settings, тож сторінка не розходиться з кабінетом.
 *
 * На цій сторінці реклама не показується (слотів немає).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/promo-advertiser.php';

const ADV_CONTACT = 'partners@ailabhub-directory.com';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$enabled = promo_enabled($pdo);
$lang = promo_lang();
$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
$tr = static fn(string $k, mixed ...$a): string => htmlspecialchars(promo_tr($k, ...$a), ENT_QUOTES);
// Назва вкладки/розділу кабінету як «плашка» в тексті.
$path = static fn(string $k): string => '<span class="adv-path">' . htmlspecialchars(promo_tr($k), ENT_QUOTES) . '</span>';
$mail = '<a href="mailto:' . ADV_CONTACT . '">' . ADV_CONTACT . '</a>';

$maxMb = max(1, (int) promo_setting($pdo, 'max_video_mb', '30'));
$maxSec = max(1, (int) promo_setting($pdo, 'max_video_sec', '30'));
$rates = promo_rate_card($pdo);
$minTopup = promo_parse_money(promo_setting($pdo, 'min_topup', ''));
$moderationTime = trim(promo_setting($pdo, 'moderation_time_text_' . $lang, '')) ?: trim(promo_setting($pdo, 'moderation_time_text_uk', ''));
$num = static fn(int|float $n): string => number_format((float) $n, 0, ',', ' ');

// Приклад розрахунку: мінімальне поповнення на першому розміщенні з ціною CPM.
$example = null;
if ($minTopup) {
    foreach (promo_placements_public($pdo) as $pl) {
        if (!empty($rates[$pl]['cpm'])) {
            $example = [
                'placement' => $pl,
                'impressions' => floor($minTopup / $rates[$pl]['cpm'] * 1000),
                'clicks' => !empty($rates[$pl]['cpc']) ? floor($minTopup / $rates[$pl]['cpc']) : null,
            ];
            break;
        }
    }
}

$sections = ['prepare', 'account', 'create', 'cost', 'pay', 'review', 'delivery', 'stats', 'errors'];
$h2 = static function (string $s) use ($sections, $tr): string {
    $n = array_search($s, $sections, true) + 1;

    return '<h2 class="adv-h2" id="' . $s . '">' . $n . '. ' . $tr('guide_s_' . $s) . '</h2>';
};
$ver = static fn(string $f): string => (string) (@filemtime(__DIR__ . '/assets/' . $f) ?: 1);
$canonical = 'https://ailabhub-directory.com/advertise-guide.php';
?>
<!DOCTYPE html>
<html lang="<?= $e($lang) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= $tr('guide_title') ?> — AI LAB HUB</title>
    <meta name="description" content="<?= $tr('guide_meta') ?>">
    <link rel="canonical" href="<?= $e($canonical) ?>">
    <meta property="og:title" content="<?= $tr('guide_title') ?>">
    <meta property="og:description" content="<?= $tr('guide_meta') ?>">
    <meta property="og:url" content="<?= $e($canonical) ?>">
    <link rel="stylesheet" href="/assets/css/advertise.css?v=<?= $ver('css/advertise.css') ?>">
    <link rel="stylesheet" href="/assets/css/site-nav.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <main class="page">
        <h1 class="adv-title"><?= $tr('guide_title') ?></h1>
        <p class="adv-lead"><?= $tr('guide_lead') ?></p>

        <nav aria-label="<?= $tr('guide_toc') ?>">
            <ol class="adv-toc">
                <?php foreach ($sections as $s): ?>
                <li><a href="#<?= $s ?>"><?= $tr('guide_s_' . $s) ?></a></li>
                <?php endforeach; ?>
            </ol>
        </nav>

        <?php if (!$enabled): ?>
        <p class="adv-note adv-note--warn"><?= $tr('adv_cta_closed') ?> <?= $mail ?></p>
        <?php endif; ?>

        <?= $h2('prepare') ?>
        <ul class="adv-list">
            <li><?= $tr('guide_prep_1', $maxMb, $maxSec) ?></li>
            <?php for ($i = 2; $i <= 5; $i++): ?>
            <li><?= $tr('guide_prep_' . $i) ?></li>
            <?php endfor; ?>
        </ul>
        <p class="adv-muted"><a href="advertise.php"><?= $tr('guide_prep_more') ?></a></p>

        <?= $h2('account') ?>
        <ol class="adv-list">
            <li><?= $tr('guide_acc_1') ?></li>
            <li><?= sprintf($tr('guide_acc_2', '%s', '%s', '%s', '%s', '%s'), $path('section_title'), $path('tab_campaigns'), $path('tab_create'), $path('tab_balance'), $path('tab_stats')) ?></li>
        </ol>
        <?php if ($enabled): ?>
        <p class="adv-muted"><?= $tr('guide_acc_3') ?></p>
        <p><a class="adv-btn" href="advertise.php?start=1" rel="nofollow"><?= $tr('adv_cta') ?></a></p>
        <?php endif; ?>

        <?= $h2('create') ?>
        <p class="adv-muted"><?= sprintf($tr('guide_create_intro', '%s'), $path('tab_create')) ?></p>
        <div class="adv-guide-step">
            <h3>1. <?= $tr('step1_title') ?></h3>
            <ul class="adv-list"><?php for ($i = 1; $i <= 3; $i++): ?><li><?= $tr('guide_c1_' . $i) ?></li><?php endfor; ?></ul>
        </div>
        <div class="adv-guide-step">
            <h3>2. <?= $tr('step2_title') ?></h3>
            <ul class="adv-list"><?php for ($i = 1; $i <= 3; $i++): ?><li><?= $tr('guide_c2_' . $i) ?></li><?php endfor; ?></ul>
        </div>
        <div class="adv-guide-step">
            <h3>3. <?= $tr('step3_title') ?></h3>
            <p class="adv-muted"><?= sprintf($tr('guide_c3_1', '%s'), '<a href="#delivery">' . $tr('guide_s_delivery') . '</a>') ?></p>
        </div>
        <div class="adv-guide-step">
            <h3>4. <?= $tr('step4_title') ?></h3>
            <ul class="adv-list"><?php for ($i = 1; $i <= 4; $i++): ?><li><?= $tr('guide_c4_' . $i) ?></li><?php endfor; ?></ul>
        </div>
        <div class="adv-guide-step">
            <h3>5. <?= $tr('step5_title') ?></h3>
            <p class="adv-muted"><?= $tr('guide_c5_1') ?> <a href="promo-rules.php"><?= $tr('adv_rules_link') ?></a></p>
        </div>

        <?= $h2('cost') ?>
        <p class="adv-muted"><?= $tr('guide_cost_intro') ?></p>
        <h3><?= $tr('guide_cost_prices') ?></h3>
        <?php if ($rates === []): ?>
        <p class="adv-box"><?= sprintf($tr('adv_prices_on_request', '%s'), $mail) ?></p>
        <?php else: ?>
        <div class="adv-table-wrap">
            <table class="adv-table">
                <thead><tr><th><?= $tr('adv_col_placement') ?></th><th><?= $tr('adv_col_cpm') ?></th><th><?= $tr('adv_col_cpc') ?></th></tr></thead>
                <tbody>
                <?php foreach (promo_placements_public($pdo) as $pl): ?>
                <tr>
                    <td><?= $e(promo_placement_title($pdo, $pl, $lang)) ?></td>
                    <td><?= isset($rates[$pl]['cpm']) ? $e(promo_money($rates[$pl]['cpm'])) : '—' ?></td>
                    <td><?= isset($rates[$pl]['cpc']) ? $e(promo_money($rates[$pl]['cpc'])) : '—' ?></td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <?php endif; ?>
        <h3><?= $tr('guide_cost_formula_title') ?></h3>
        <ul class="adv-list">
            <li class="adv-formula"><?= $tr('guide_cost_formula_cpm') ?></li>
            <li class="adv-formula"><?= $tr('guide_cost_formula_cpc') ?></li>
        </ul>
        <?php if ($example !== null): ?>
        <p class="adv-note">
            <?= $tr('guide_cost_example_cpm', promo_money($minTopup), promo_placement_title($pdo, $example['placement'], $lang), $num($example['impressions'])) ?>
            <?php if ($example['clicks'] !== null): ?> <?= $tr('guide_cost_example_cpc', $num($example['clicks'])) ?><?php endif; ?>
        </p>
        <?php endif; ?>
        <p class="adv-muted"><?= $tr('guide_cost_fixed') ?></p>
        <p class="adv-muted"><strong><?= $tr('guide_cost_counted') ?>:</strong> <?= $tr('adv_faq_a5') ?></p>

        <?= $h2('pay') ?>
        <p class="adv-muted"><?= $tr('guide_pay_intro') ?></p>
        <ol class="adv-list">
            <li><?= sprintf($tr('guide_pay_1', '%s'), $path('tab_balance')) ?><?php if ($minTopup): ?> <?= $tr('guide_pay_min', promo_money($minTopup)) ?><?php endif; ?></li>
            <li><?= sprintf($tr('guide_pay_2', '%s'), '<code>AILABHUB-PROMO-123</code>') ?></li>
            <li><?= $tr('guide_pay_3') ?></li>
            <li><?= $tr('guide_pay_4') ?></li>
        </ol>
        <p class="adv-note"><?= $tr('guide_pay_order') ?></p>
        <p class="adv-note adv-note--warn"><?= $tr('guide_pay_low') ?></p>
        <p class="adv-muted"><?= $tr('guide_pay_safe') ?> <?= sprintf($tr('guide_pay_refund', '%s'), $mail) ?></p>

        <?= $h2('review') ?>
        <ul class="adv-list">
            <li><?= $tr('guide_rev_1') ?></li>
            <li><strong><?= $tr('guide_rev_time') ?></strong> <?= $moderationTime !== '' ? $e($moderationTime) : $tr('adv_moderation_time_default') ?></li>
            <li><?= $tr('guide_rev_2') ?></li>
            <li><?= $tr('guide_rev_3') ?></li>
        </ul>
        <h3><?= $tr('guide_rev_statuses') ?></h3>
        <ul class="adv-list">
            <?php foreach (['draft', 'pending_review', 'active', 'paused', 'rejected', 'completed'] as $st): ?>
            <li><strong><?= $tr('status_' . $st) ?></strong> — <?= $tr('guide_st_' . $st) ?></li>
            <?php endforeach; ?>
        </ul>

        <?= $h2('delivery') ?>
        <p class="adv-muted"><?= $tr('guide_dl_intro', promo_tr('step3_title')) ?></p>
        <div class="adv-guide-step">
            <h3><?= $tr('guide_dl_where') ?></h3>
            <ul class="adv-list">
                <?php foreach (promo_placements_public($pdo) as $pl): ?>
                <li><strong><?= $e(promo_placement_title($pdo, $pl, $lang)) ?></strong> — <?= $e(promo_placement_description($pdo, $pl, $lang)) ?></li>
                <?php endforeach; ?>
            </ul>
        </div>
        <div class="adv-guide-step">
            <h3><?= $tr('guide_dl_audience') ?></h3>
            <ul class="adv-list">
                <li><?= $tr('guide_dl_lang') ?></li>
                <li><?= $tr('guide_dl_device') ?></li>
                <li><?= $tr('guide_dl_cats') ?></li>
            </ul>
        </div>
        <p class="adv-muted"><?= $tr('guide_dl_limits') ?></p>
        <div class="adv-guide-step">
            <h3><?= sprintf($tr('guide_dl_manage', '%s'), $path('tab_campaigns')) ?></h3>
            <ul class="adv-list">
                <?php foreach (['pause', 'edit', 'dup', 'end', 'daily'] as $k): ?>
                <li><?= $tr('guide_dl_' . $k) ?></li>
                <?php endforeach; ?>
            </ul>
        </div>

        <?= $h2('stats') ?>
        <p class="adv-muted"><?= sprintf($tr('guide_stats_1', '%s'), $path('tab_stats')) ?></p>
        <p class="adv-muted"><?= $tr('guide_stats_2') ?></p>

        <?= $h2('errors') ?>
        <ul class="adv-list">
            <?php for ($i = 1; $i <= 5; $i++): ?>
            <li><?= $tr('guide_err_' . $i) ?></li>
            <?php endfor; ?>
        </ul>

        <p class="adv-box" style="margin-top:32px"><?= sprintf($tr('guide_help', '%s'), $mail) ?></p>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
