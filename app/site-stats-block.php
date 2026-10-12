<?php

declare(strict_types=1);

/**
 * AI LAB HUB — блок «Перегляди сайту» на public/admin-stats.php (лише admin).
 * Очікує: $pv (site_stats_summary() або null), $excludeStaff, $statsFlash,
 * $_SESSION['stats_csrf'], e(). Стилі — public/assets/css/site-stats.css.
 * Іконки — Lucide (trophy, arrow-up, arrow-down, minus), ISC.
 */

$pvT = static fn (string $pvKey, array $vars = []): string => strtr(t($pvKey), $vars);
$pvIcon = static function (string $name): string {
    $paths = [
        'trophy' => '<path d="M10 14.66v1.626a2 2 0 0 1-.976 1.696A5 5 0 0 0 7 21.978"/><path d="M14 14.66v1.626a2 2 0 0 0 .976 1.696A5 5 0 0 1 17 21.978"/><path d="M18 9h1.5a1 1 0 0 0 0-5H18"/><path d="M4 22h16"/><path d="M6 9a6 6 0 0 0 12 0V3a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1z"/><path d="M6 9H4.5a1 1 0 0 1 0-5H6"/>',
        'up' => '<path d="m5 12 7-7 7 7"/><path d="M12 19V5"/>',
        'down' => '<path d="M12 5v14"/><path d="m19 12-7 7-7-7"/>',
        'flat' => '<path d="M5 12h14"/>',
    ];

    return '<svg class="pv-icon pv-icon--' . $name . '" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false">' . $paths[$name] . '</svg>';
};
/** Зміна відносно попереднього періоду: стрілка, різниця, відсоток. */
$pvDelta = static function (?array $d) use ($pvIcon): string {
    if ($d === null) {
        return '';
    }
    $dir = $d['diff'] > 0 ? 'up' : ($d['diff'] < 0 ? 'down' : 'flat');
    $txt = ($d['diff'] > 0 ? '+' : ($d['diff'] < 0 ? '−' : '')) . site_stats_num(abs($d['diff']));
    if ($d['pct'] !== null) {
        $txt .= ' (' . ($d['pct'] > 0 ? '+' : ($d['pct'] < 0 ? '−' : '')) . abs($d['pct']) . '%)';
    }

    return '<span class="pv-delta pv-delta--' . $dir . '">' . $pvIcon($dir) . e($txt) . '</span>';
};
?>
<section class="section pv" aria-labelledby="pv-title">
    <h2 class="section__title" id="pv-title"><?= e(t('pv_block_title')) ?></h2>
    <p class="pv__note"><?= e(t('pv_block_note')) ?></p>

    <?php if ($pv === null): ?>
        <p class="pv-empty"><?= e(t('pv_migration_needed')) ?></p>
    <?php else: ?>
        <?php
        $pvRd = $pv['record_day'];
        $pvRw = $pv['record_week'];
        $pvRm = $pv['record_month'];
        ?>
        <div class="pv-record">
            <span class="pv-record__icon"><?= $pvIcon('trophy') ?></span>
            <div class="pv-record__body">
                <p class="pv-record__title"><?= e(t('pv_record_title')) ?></p>
                <div class="pv-record__items">
                    <div class="pv-record__item">
                        <p class="pv-record__label"><?= e(t('pv_record_day')) ?></p>
                        <?php if ($pvRd === null): ?>
                            <p class="pv-record__value pv-record__value--none"><?= e(t('pv_no_data')) ?></p>
                        <?php else: ?>
                            <p class="pv-record__value"><?= site_stats_num($pvRd['views']) ?></p>
                            <p class="pv-record__meta"><?= e(site_stats_date($pvRd['day'])) ?> · <?= e($pvT('pv_record_sessions', ['{n}' => site_stats_num($pvRd['sessions'])])) ?></p>
                            <?php if ($pv['few_day']): ?><p class="pv-few"><?= e(t('pv_few_data')) ?></p><?php endif; ?>
                        <?php endif; ?>
                    </div>
                    <div class="pv-record__item">
                        <p class="pv-record__label"><?= e(t('pv_record_week')) ?></p>
                        <?php if ($pvRw === null): ?>
                            <p class="pv-record__value pv-record__value--none"><?= e(t('pv_no_data')) ?></p>
                        <?php else: ?>
                            <p class="pv-record__value"><?= site_stats_num($pvRw['views']) ?></p>
                            <p class="pv-record__meta"><?= e(site_stats_date($pvRw['from'], true)) ?>–<?= e(site_stats_date($pvRw['to'])) ?></p>
                            <?php if ($pv['few_week']): ?><p class="pv-few"><?= e(t('pv_few_data')) ?></p><?php endif; ?>
                        <?php endif; ?>
                    </div>
                    <div class="pv-record__item">
                        <p class="pv-record__label"><?= e(t('pv_record_month')) ?></p>
                        <?php if ($pvRm === null): ?>
                            <p class="pv-record__value pv-record__value--none"><?= e(t('pv_no_data')) ?></p>
                        <?php else: ?>
                            <p class="pv-record__value"><?= site_stats_num($pvRm['views']) ?></p>
                            <p class="pv-record__meta"><?= e(substr($pvRm['month'], 5, 2) . '.' . substr($pvRm['month'], 0, 4)) ?></p>
                            <?php if ($pv['few_month']): ?><p class="pv-few"><?= e(t('pv_few_data')) ?></p><?php endif; ?>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>

        <div class="pv-cards">
            <?php
            $pvCards = [
                ['today', 'pv_card_today', $pvT('pv_period_today', ['{date}' => site_stats_date($pv['today']['from'])]), 'pv_vs_yesterday'],
                ['week', 'pv_card_week', $pvT('pv_period_days', ['{n}' => '7', '{from}' => site_stats_date($pv['week']['from'], true), '{to}' => site_stats_date($pv['week']['to'], true)]), 'pv_vs_prev7'],
                ['month', 'pv_card_month', $pvT('pv_period_days', ['{n}' => '30', '{from}' => site_stats_date($pv['month']['from'], true), '{to}' => site_stats_date($pv['month']['to'], true)]), 'pv_vs_prev30'],
            ];
            ?>
            <?php foreach ($pvCards as [$pvKey, $pvLabel, $pvPeriod, $pvVs]): ?>
                <?php $pvC = $pv[$pvKey]; ?>
                <div class="pv-card<?= $pvC['new_record'] ? ' pv-card--record' : '' ?>">
                    <div class="pv-card__head">
                        <p class="pv-card__label"><?= e(t($pvLabel)) ?></p>
                        <?php if ($pvC['new_record']): ?>
                            <span class="pv-badge"><?= e(t('pv_new_record')) ?></span>
                        <?php endif; ?>
                    </div>
                    <p class="pv-card__period"><?= e($pvPeriod) ?></p>
                    <p class="pv-card__value"><?= site_stats_num($pvC['views']) ?> <span class="pv-card__unit"><?= e(t('pv_views')) ?></span></p>
                    <p class="pv-card__sessions"><?= site_stats_num($pvC['sessions']) ?> <?= e(t('pv_sessions')) ?></p>

                    <?php if ($pvC['delta_views'] === null): ?>
                        <p class="pv-card__compare pv-card__compare--none"><?= e(t('pv_no_compare')) ?></p>
                    <?php else: ?>
                        <p class="pv-card__compare">
                            <span class="pv-card__compare-line"><?= $pvDelta($pvC['delta_views']) ?> <?= e(t('pv_views')) ?></span>
                            <?php if ($pvC['delta_sessions'] !== null): ?>
                                <span class="pv-card__compare-line"><?= $pvDelta($pvC['delta_sessions']) ?> <?= e(t('pv_sessions')) ?></span>
                            <?php endif; ?>
                            <span class="pv-card__vs"><?= e(t($pvVs)) ?></span>
                        </p>
                    <?php endif; ?>

                    <?php if ($pvC['share'] !== null): ?>
                        <div class="pv-progress" role="img" aria-label="<?= e($pvT('pv_of_record', ['{pct}' => (string) $pvC['share']])) ?>">
                            <span class="pv-progress__bar" style="width: <?= min(100, max(0, $pvC['share'])) ?>%"></span>
                        </div>
                        <p class="pv-card__share"><?= e($pvT('pv_of_record', ['{pct}' => (string) $pvC['share']])) ?></p>
                    <?php endif; ?>
                </div>
            <?php endforeach; ?>
        </div>

        <?php
        $pvChart = $pv['chart'];
        $pvChartMax = max(1, max(array_column($pvChart, 'views')));
        $pvChartN = count($pvChart);
        $pvBarW = 300 / $pvChartN;
        ?>
        <div class="pv-chart">
            <p class="pv-chart__title"><?= e(t('pv_chart_title')) ?>
                <?php if ($pvRd !== null && $pvRd['day'] >= $pvChart[0]['day']): ?>
                    <span class="pv-chart__legend"><span class="pv-chart__swatch"></span><?= e(t('pv_chart_record')) ?></span>
                <?php endif; ?>
            </p>
            <svg class="pv-chart__svg" viewBox="0 0 300 100" preserveAspectRatio="none" role="img" aria-label="<?= e(t('pv_chart_title')) ?>">
                <?php foreach ($pvChart as $pvI => $pvBar): ?>
                    <?php
                    $pvH = $pvBar['views'] > 0 ? max(1.5, $pvBar['views'] / $pvChartMax * 96) : 0;
                    $pvIsRecord = $pvRd !== null && $pvBar['day'] === $pvRd['day'];
                    ?>
                    <rect class="pv-chart__bar<?= $pvIsRecord ? ' pv-chart__bar--record' : '' ?>" x="<?= round($pvI * $pvBarW + $pvBarW * 0.15, 2) ?>" y="<?= round(100 - $pvH, 2) ?>" width="<?= round($pvBarW * 0.7, 2) ?>" height="<?= round($pvH, 2) ?>"><title><?= e(site_stats_date($pvBar['day']) . ': ' . site_stats_num($pvBar['views'])) ?></title></rect>
                <?php endforeach; ?>
            </svg>
            <div class="pv-chart__axis">
                <span><?= e(site_stats_date($pvChart[0]['day'], true)) ?></span>
                <span><?= e(site_stats_date($pvChart[intdiv($pvChartN, 2)]['day'], true)) ?></span>
                <span><?= e(site_stats_date($pvChart[$pvChartN - 1]['day'], true)) ?></span>
            </div>
        </div>
    <?php endif; ?>

    <form class="pv-settings" id="pv-settings" method="post" action="admin-stats.php">
        <input type="hidden" name="csrf" value="<?= e($_SESSION['stats_csrf']) ?>">
        <p class="pv-settings__title"><?= e(t('pv_settings_title')) ?></p>
        <label class="pv-settings__toggle">
            <input type="checkbox" name="exclude_staff" value="1"<?= $excludeStaff ? ' checked' : '' ?>>
            <span><?= e(t('pv_exclude_staff')) ?></span>
        </label>
        <p class="pv-settings__hint"><?= e(t('pv_exclude_staff_hint')) ?></p>
        <button type="submit" class="pv-settings__btn"><?= e(t('pv_save')) ?></button>
        <?php if ($statsFlash !== null): ?>
            <span class="pv-settings__flash<?= $statsFlash ? '' : ' pv-settings__flash--error' ?>" role="status"><?= e(t($statsFlash ? 'pv_saved' : 'pv_save_failed')) ?></span>
        <?php endif; ?>
    </form>
</section>
