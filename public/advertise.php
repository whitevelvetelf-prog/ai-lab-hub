<?php

declare(strict_types=1);

/**
 * AI LAB HUB — медіакіт «Реклама на AI LAB HUB» (UA/EN, тексти — app/promo-i18n.php).
 *
 * Що на сторінці: опис платформи, 4 кроки й кнопка «Створити кампанію», формати
 * (справжній компонент .sponsored-card з демонстраційним постером), технічні
 * вимоги (ліміти з ad_settings), ціни (з ad_rate_card; порожньо — «за запитом»),
 * аудиторія (лише реальні агрегати власної аналітики, app/promo-audience.php),
 * правила, FAQ, контакт.
 *
 * На цій сторінці реклама не показується (слотів немає).
 *
 * ?start=1 — кнопка «Створити кампанію»: увійшов → майстер у кабінеті; ні →
 * вхід (після входу/реєстрації — одразу в майстер, auth_after_login_url()).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/promo-advertiser.php';
require_once __DIR__ . '/../app/promo-audience.php';

const ADV_CONTACT = 'partners@ailabhub-directory.com';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$enabled = promo_enabled($pdo);

if (isset($_GET['start'])) {
    if (!$enabled) {
        header('Location: advertise.php#start', true, 303);
        exit;
    }
    if (auth_check()) {
        header('Location: account.php?promo_tab=create#acc-promo', true, 303);
        exit;
    }
    $_SESSION['after_login'] = 'promo_create';
    header('Location: login.php', true, 303);
    exit;
}

$lang = promo_lang();
$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
$tr = static fn(string $k, mixed ...$a): string => htmlspecialchars(promo_tr($k, ...$a), ENT_QUOTES);
$mail = '<a href="mailto:' . ADV_CONTACT . '">' . ADV_CONTACT . '</a>';

$maxMb = max(1, (int) promo_setting($pdo, 'max_video_mb', '30'));
$maxSec = max(1, (int) promo_setting($pdo, 'max_video_sec', '30'));
$rates = promo_rate_card($pdo);
$minTopup = promo_parse_money(promo_setting($pdo, 'min_topup', ''));
$moderationTime = trim(promo_setting($pdo, 'moderation_time_text_' . $lang, '')) ?: trim(promo_setting($pdo, 'moderation_time_text_uk', ''));

// Аудиторія: лише реальні агрегати; замало даних — «накопичується».
$audience = promo_audience_get($pdo);
$enough = $audience !== null && $audience['page_views'] >= PROMO_AUDIENCE_MIN_VIEWS;
$share = static function (array $parts, int $known): array {
    if ($known < PROMO_AUDIENCE_MIN_VIEWS) {
        return [];
    }
    $out = [];
    foreach ($parts as $k => $n) {
        $out[$k] = round($n / $known * 100);
    }

    return $out;
};
$langShares = $enough ? $share($audience['lang'], $audience['lang_known']) : [];
$deviceShares = $enough ? $share($audience['device'], $audience['device_known']) : [];
$topCats = [];
if ($enough && $audience['top_categories'] !== []) {
    $ids = implode(',', array_map('intval', array_keys($audience['top_categories'])));
    $names = [];
    foreach ($pdo->query("SELECT id, name, name_en FROM categories WHERE id IN ({$ids})") as $c) {
        $names[(int) $c['id']] = $lang === 'en' && !empty($c['name_en']) ? $c['name_en'] : $c['name'];
    }
    foreach ($audience['top_categories'] as $id => $n) {
        if (isset($names[$id])) {
            $topCats[] = [$names[$id], $n];
        }
    }
}
$num = static fn(int $n): string => number_format($n, 0, ',', ' ');

// Демонстраційний постер: нейтральний градієнт із підписом, без вигаданих брендів.
$posterSvg = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1280 720">'
    . '<defs><linearGradient id="g" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#2116ad"/><stop offset="1" stop-color="#00a3c4"/></linearGradient></defs>'
    . '<rect width="1280" height="720" fill="url(#g)"/>'
    . '<circle cx="640" cy="330" r="74" fill="rgba(255,255,255,0.18)"/><path d="M615 290 L615 370 L680 330 Z" fill="#fff"/>'
    . '<text x="640" y="480" text-anchor="middle" font-family="Segoe UI, Arial, sans-serif" font-size="48" fill="#ffffff">'
    . htmlspecialchars(promo_tr('adv_demo_poster'), ENT_XML1) . '</text></svg>';
$poster = 'data:image/svg+xml;base64,' . base64_encode($posterSvg);
$demoCard = static function () use ($tr, $e, $poster): string {
    return '<article class="sponsored-card adv-demo" aria-label="' . $tr('adv_demo_title') . '">'
        . '<span class="sponsored-card__label">' . $e(t('ad_label')) . '</span>'
        . '<div class="sponsored-card__media"><img src="' . $poster . '" alt="" width="1280" height="720" loading="lazy"></div>'
        . '<h3 class="sponsored-card__title">' . $tr('adv_demo_title') . '</h3>'
        . '<p class="sponsored-card__desc">' . $tr('adv_demo_desc') . '</p>'
        . '<div class="sponsored-card__footer"><span class="sponsored-card__cta">' . $e(t('promo_cta_learn_more')) . '</span>'
        . '<span class="sponsored-card__report">' . $e(t('promo_report')) . '</span></div>'
        . '</article>';
};
$ver = static fn(string $f): string => (string) (@filemtime(__DIR__ . '/assets/' . $f) ?: 1);
// Місця сайту — у «Форматах»; маркетплейс — окремим блоком (і до відкриття, якщо місця вже можна обрати).
$sitePlaces = array_values(array_filter(promo_placements_public($pdo), static fn($pl) => !promo_placement_is_marketplace($pdo, $pl)));
$mpPlaces = array_values(array_filter(array_keys(promo_placements($pdo)), static fn($pl) => promo_placement_is_marketplace($pdo, $pl) && promo_placement_selectable_now($pdo, $pl)));
$mpOpen = site_setting($pdo, 'marketplace_public', '0') === '1';
$canonical = 'https://ailabhub-directory.com/advertise.php';
?>
<!DOCTYPE html>
<html lang="<?= $e($lang) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= $tr('adv_title') ?></title>
    <meta name="description" content="<?= $tr('adv_meta') ?>">
    <link rel="canonical" href="<?= $e($canonical) ?>">
    <meta property="og:title" content="<?= $tr('adv_title') ?>">
    <meta property="og:description" content="<?= $tr('adv_meta') ?>">
    <meta property="og:url" content="<?= $e($canonical) ?>">
    <link rel="stylesheet" href="/assets/css/advertise.css?v=<?= $ver('css/advertise.css') ?>">
    <link rel="stylesheet" href="/assets/css/site-nav.css">
    <link rel="stylesheet" href="/assets/css/sponsored.css?v=<?= $ver('css/sponsored.css') ?>">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <main class="page">
        <h1 class="adv-title"><?= $tr('adv_title') ?></h1>
        <p class="adv-lead"><?= $tr('adv_intro') ?></p>
        <ul class="adv-list">
            <?php for ($i = 1; $i <= 5; $i++): ?>
            <li><?= $tr('adv_benefit_' . $i) ?></li>
            <?php endfor; ?>
        </ul>
        <p class="adv-muted"><?= $tr('adv_no_guarantee') ?></p>

        <h2 class="adv-h2" id="start"><?= $tr('adv_how_title') ?></h2>
        <ol class="adv-steps">
            <?php for ($i = 1; $i <= 4; $i++): ?>
            <li><strong><?= $tr('adv_step_' . $i) ?></strong><span><?= $tr('adv_step_' . $i . '_text') ?></span></li>
            <?php endfor; ?>
        </ol>
        <p><a href="advertise-guide.php"><?= $tr('adv_guide_link') ?></a></p>
        <?php if ($enabled): ?>
        <p><a class="adv-btn" href="advertise.php?start=1" rel="nofollow"><?= $tr('adv_cta') ?></a></p>
        <?php else: ?>
        <p class="adv-box"><?= $tr('adv_cta_closed') ?> <?= $mail ?></p>
        <?php endif; ?>

        <h2 class="adv-h2"><?= $tr('adv_formats_title') ?></h2>
        <p class="adv-muted"><?= $tr('adv_formats_note') ?></p>
        <div class="adv-formats">
            <?php foreach ($sitePlaces as $pl): ?>
            <section class="adv-format">
                <h3><?= $e(promo_placement_title($pdo, $pl, $lang)) ?></h3>
                <p><?= $e(promo_placement_description($pdo, $pl, $lang)) ?></p>
                <?= $demoCard() ?>
            </section>
            <?php endforeach; ?>
        </div>

        <?php if ($mpPlaces !== []): ?>
        <h2 class="adv-h2" id="marketplace"><?= $tr('adv_mp_title') ?></h2>
        <p><?= $tr('adv_mp_intro') ?></p>
        <?php if (!$mpOpen): ?>
        <p class="adv-box"><?= $tr('adv_mp_closed') ?></p>
        <?php endif; ?>
        <ul class="adv-list">
            <?php foreach ($mpPlaces as $pl): ?>
            <li><strong><?= $e(promo_placement_title($pdo, $pl, $lang)) ?></strong> — <?= $e(promo_placement_description($pdo, $pl, $lang)) ?></li>
            <?php endforeach; ?>
        </ul>
        <p class="adv-muted"><?= $tr('adv_mp_no_data') ?></p>
        <?php endif; ?>

        <h2 class="adv-h2"><?= $tr('adv_spec_title') ?></h2>
        <ul class="adv-list">
            <li><?= $tr('adv_spec_video', $maxMb, $maxSec) ?></li>
            <li><?= $tr('adv_spec_ratio') ?></li>
            <li><?= $tr('adv_spec_title_len') ?></li>
            <li><?= $tr('adv_spec_desc_len') ?></li>
            <li><?= $tr('adv_spec_poster') ?></li>
            <li><?= $tr('adv_spec_url') ?></li>
            <li><?= $tr('adv_spec_cta') ?></li>
        </ul>
        <div class="adv-grid-2" style="margin-top:16px">
            <div class="adv-box adv-good">
                <h3>✓ <?= $tr('adv_good_title') ?></h3>
                <ul class="adv-list"><?php for ($i = 1; $i <= 3; $i++): ?><li><?= $tr('adv_good_' . $i) ?></li><?php endfor; ?></ul>
            </div>
            <div class="adv-box adv-bad">
                <h3>✗ <?= $tr('adv_bad_title') ?></h3>
                <ul class="adv-list"><?php for ($i = 1; $i <= 3; $i++): ?><li><?= $tr('adv_bad_' . $i) ?></li><?php endfor; ?></ul>
            </div>
        </div>

        <h2 class="adv-h2"><?= $tr('adv_prices_title') ?></h2>
        <?php if ($rates === []): ?>
        <p class="adv-box"><?= sprintf($tr('adv_prices_on_request', '%s'), $mail) ?></p>
        <?php else: ?>
        <div class="adv-table-wrap">
            <table class="adv-table">
                <thead><tr><th><?= $tr('adv_col_placement') ?></th><th><?= $tr('adv_col_cpm') ?></th><th><?= $tr('adv_col_cpc') ?></th></tr></thead>
                <tbody>
                <?php foreach (array_merge($sitePlaces, $mpPlaces) as $pl): ?>
                <tr>
                    <td><?= $e(promo_placement_title($pdo, $pl, $lang)) ?></td>
                    <td><?= isset($rates[$pl]['cpm']) ? $e(promo_money($rates[$pl]['cpm'])) : '—' ?></td>
                    <td><?= isset($rates[$pl]['cpc']) ? $e(promo_money($rates[$pl]['cpc'])) : '—' ?></td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <p class="adv-muted"><?= $tr('adv_prices_note') ?><?php if ($minTopup): ?> <?= $tr('adv_min_topup', promo_money($minTopup)) ?><?php endif; ?></p>
        <?php endif; ?>

        <h2 class="adv-h2"><?= $tr('adv_audience_title') ?></h2>
        <?php if ($audience === null): ?>
        <p class="adv-box"><?= $tr('adv_audience_unavailable') ?></p>
        <?php elseif (!$enough): ?>
        <p class="adv-box"><?= $tr('adv_audience_collecting') ?></p>
        <?php else: ?>
        <div class="adv-stats">
            <div class="adv-box"><span class="adv-stat__value"><?= $e($num($audience['page_views'])) ?></span><span class="adv-stat__label"><?= $tr('adv_stat_views') ?></span></div>
            <div class="adv-box"><span class="adv-stat__value"><?= $e($num($audience['sessions'])) ?></span><span class="adv-stat__label"><?= $tr('adv_stat_sessions') ?></span></div>
            <div class="adv-box">
                <span class="adv-stat__label"><?= $tr('adv_stat_lang') ?></span>
                <?php if ($langShares === []): ?>
                <p class="adv-muted"><?= $tr('adv_stat_collecting_short') ?></p>
                <?php else: ?>
                <ul class="adv-list"><?php foreach ($langShares as $k => $pct): ?><li><?= isset(PROMO_I18N['adv_lang_' . $k]) ? $tr('adv_lang_' . $k) : $e($k) ?>:<?= (int) $pct ?>%</li><?php endforeach; ?></ul>
                <?php endif; ?>
            </div>
            <div class="adv-box">
                <span class="adv-stat__label"><?= $tr('adv_stat_device') ?></span>
                <?php if ($deviceShares === []): ?>
                <p class="adv-muted"><?= $tr('adv_stat_collecting_short') ?></p>
                <?php else: ?>
                <ul class="adv-list"><?php foreach ($deviceShares as $k => $pct): ?><li><?= $tr('adv_device_' . $k) ?>: <?= (int) $pct ?>%</li><?php endforeach; ?></ul>
                <?php endif; ?>
            </div>
        </div>
        <?php if ($topCats !== []): ?>
        <h3><?= $tr('adv_stat_top') ?></h3>
        <ol class="adv-list">
            <?php foreach ($topCats as [$name, $n]): ?>
            <li><?= $e($name) ?> — <?= $e($num($n)) ?></li>
            <?php endforeach; ?>
        </ol>
        <?php endif; ?>
        <?php endif; ?>
        <?php if ($audience !== null): ?>
        <p class="adv-muted"><?= $tr('adv_audience_period', $audience['period_from'], $audience['period_to'], promo_local_time($audience['computed_at'])) ?></p>
        <?php endif; ?>

        <h2 class="adv-h2"><?= $tr('adv_rules_title') ?></h2>
        <p class="adv-muted"><?= $tr('adv_rules_text') ?></p>
        <p class="adv-muted"><strong><?= $tr('adv_prohibited_title') ?>:</strong> <?= $tr('adv_prohibited_list') ?></p>
        <p class="adv-muted"><?= $tr('adv_sensitive') ?></p>
        <p class="adv-muted"><strong><?= $tr('adv_moderation_time') ?>:</strong> <?= $moderationTime !== '' ? $e($moderationTime) : $tr('adv_moderation_time_default') ?></p>
        <p><a href="promo-rules.php"><?= $tr('adv_rules_link') ?></a></p>

        <h2 class="adv-h2"><?= $tr('adv_faq_title') ?></h2>
        <div class="adv-faq">
            <details><summary><?= $tr('adv_faq_q1') ?></summary><p><?= $moderationTime !== '' ? $e($moderationTime) : $tr('adv_moderation_time_default') ?></p></details>
            <details><summary><?= $tr('adv_faq_q2') ?></summary><p><?= $tr('adv_faq_a2') ?></p></details>
            <details><summary><?= $tr('adv_faq_q3') ?></summary><p><?= sprintf($tr('adv_faq_a3', '%s'), $mail) ?></p></details>
            <details><summary><?= $tr('adv_faq_q4') ?></summary><p><?= $tr('adv_faq_a4') ?></p></details>
            <details><summary><?= $tr('adv_faq_q5') ?></summary><p><?= $tr('adv_faq_a5') ?></p></details>
        </div>

        <h2 class="adv-h2" id="custom"><?= $tr('adv_custom_title') ?></h2>
        <p><?= $tr('adv_custom_intro') ?></p>
        <h3><?= $tr('adv_custom_what') ?></h3>
        <ul class="adv-list">
            <?php for ($i = 1; $i <= 4; $i++): ?>
            <li><?= $tr('adv_custom_item_' . $i) ?></li>
            <?php endfor; ?>
        </ul>
        <h3><?= $tr('adv_custom_how') ?></h3>
        <ol class="adv-list">
            <?php for ($i = 1; $i <= 4; $i++): ?>
            <li><?= $tr('adv_custom_step_' . $i) ?></li>
            <?php endfor; ?>
        </ol>
        <p class="adv-muted"><?= $tr('adv_custom_req') ?></p>
        <p class="adv-box"><?= sprintf($tr('adv_custom_price', '%s'), $mail) ?></p>

        <h2 class="adv-h2"><?= $tr('adv_contact_title') ?></h2>
        <p><?= sprintf($tr('adv_contact_text', '%s'), $mail) ?></p>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
