<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Перевірка таргетингу» (лише admin): які відеокампанії пройшли б географічний фільтр реклами
 * (app/ad-geo.php) для заданого місця відвідувача і чому інші відсіялися.
 *
 *   GET place=<id країни чи міста>  known=city|country|unknown  radius=0|5|…|200
 *     known=city    — відвідувач у вибраному місті (координати міста);
 *     known=country — відоме лише країна вибраного місця;
 *     known=unknown — місце невідоме (тоді вирішує режим кампанії).
 *     radius        — додатково позначити кампанії, чиє місто-ціль лише трохи далі: відстань ≤ радіус цілі + radius.
 * Перевіряється лише географія (бюджет, місця показу, мова, пристрій, ліміти частоти тут не враховуються).
 * Для кожної кампанії показано й результат SQL-попереднього відбору (має збігатися з PHP — інакше помилка).
 * Нічого не змінює.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/promo-admin.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-geo-form.php';
require_once __DIR__ . '/../app/ad-geo.php';

$userId = auth_user_id();
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
if (!promo_is_admin($pdo, $userId)) {
    header('Location: account.php');
    exit;
}
if (!adgeo_ready($pdo) || !mpg_ready($pdo)) {
    mpb_message_page(503, 'Перевірка таргетингу', '<p class="mp-text">Міграцію географії реклами (№ 24) або геодовідник ще не застосовано.</p>', 'account.php');
}
header('X-Robots-Tag: noindex');
$lang = current_lang();

$g = static fn(string $k): string => is_string($_GET[$k] ?? null) ? trim((string) $_GET[$k]) : '';
$placeRaw = $g('place');
$place = ctype_digit($placeRaw) && strlen($placeRaw) <= 10 ? mpg_place($pdo, (int) $placeRaw) : null;
if ($place !== null && !in_array($place['type'], ['country', 'city'], true)) {
    $place = null;
}
$known = in_array($g('known'), ['city', 'country', 'unknown'], true) ? $g('known') : 'city';
$radius = in_array((int) $g('radius'), ADGEO_RADII, true) ? (int) $g('radius') : 0;
$asked = $place !== null || $known === 'unknown';

// Об'єкт місця відвідувача, як його бачить відбір реклами.
$visitor = geo_unknown();
if ($known !== 'unknown' && $place !== null) {
    $visitor = ['country_code' => $place['country_code'], 'place_id' => $place['type'] === 'city' && $known === 'city' ? $place['id'] : null,
        'lat' => $place['type'] === 'city' && $known === 'city' ? $place['lat'] : null,
        'lon' => $place['type'] === 'city' && $known === 'city' ? $place['lon'] : null, 'source' => 'user', 'known' => true];
}

$why = [
    'no_rules' => 'Правил немає — показується всім',
    'unknown_exclude_only' => 'Місце невідоме, є лише «Виключити» — показується',
    'unknown_soft' => 'Місце невідоме, м\'який режим — показується',
    'unknown_strict' => 'Місце невідоме, суворий режим і є «Включити» — НЕ показується',
    'excluded_country' => 'Країна у «Виключити»',
    'excluded_city' => 'Відвідувач у радіусі міста з «Виключити»',
    'not_excluded' => 'Не виключено (лише «Виключити»)',
    'included_country' => 'Країна збігається з «Включити»',
    'included_city' => 'Відвідувач у радіусі міста з «Включити»',
    'country_only_soft' => 'Відома лише країна, ціль — місто цієї країни, м\'який режим — показується',
    'country_only_strict' => 'Відома лише країна, ціль — місто, суворий режим — НЕ показується',
    'outside' => 'Поза радіусом усіх міст і країн «Включити»',
    'other_country' => 'Країна не збігається з жодною ціллю',
];

$rows = [];
if ($asked) {
    $campaigns = $pdo->query(
        "SELECT id, name, status, campaign_type FROM ad_campaigns
         WHERE format = 'video' AND status IN ('active', 'paused', 'pending_review') ORDER BY status = 'active' DESC, id DESC LIMIT 500"
    )->fetchAll(PDO::FETCH_ASSOC);
    $ids = array_map(static fn($c) => (int) $c['id'], $campaigns);
    $rules = adgeo_rules($pdo, $ids);
    $modes = adgeo_modes($pdo, $ids);
    // SQL-попередній відбір тим самим кодом, що в promo_candidates_sql().
    $sqlPass = [];
    if ($ids !== []) {
        $params = [];
        $cond = adgeo_candidates_sql(!empty($visitor['known']) ? (string) $visitor['country_code'] : null, $params);
        $st = $pdo->prepare('SELECT c.id FROM ad_campaigns c WHERE c.id IN (' . implode(',', $ids) . ") $cond");
        $st->execute($params);
        $sqlPass = array_flip(array_map('intval', $st->fetchAll(PDO::FETCH_COLUMN)));
    }
    $pids = [];
    foreach ($rules as $list) {
        foreach ($list as $rule) {
            $pids[] = $rule['place_id'];
        }
    }
    $labels = mpg_labels($pdo, $pids, $lang);
    foreach ($campaigns as $c) {
        $cid = (int) $c['id'];
        $r = $rules[$cid] ?? [];
        $mode = $modes[$cid] ?? adgeo_default_mode();
        [$ok, $reason] = ad_geo_check($r, $visitor, $mode);
        $near = '';
        if (!$ok && $radius > 0 && $visitor['lat'] !== null) {
            foreach ($r as $rule) {
                if ($rule['mode'] === 'include' && $rule['type'] === 'city' && $rule['lat'] !== null) {
                    $d = mpg_distance_km((float) $visitor['lat'], (float) $visitor['lon'], $rule['lat'], $rule['lon']);
                    if ($d <= $rule['radius_km'] + $radius) {
                        $near = sprintf('місто-ціль %s за %d км (радіус цілі %d км)', $labels[$rule['place_id']]['name'] ?? '#' . $rule['place_id'], (int) round($d), $rule['radius_km']);
                        break;
                    }
                }
            }
        }
        // PHP рахує радіус лише для кампаній, що пройшли SQL; без правил SQL пропускає завжди.
        $sqlOk = isset($sqlPass[$cid]);
        $rows[] = ['c' => $c, 'ok' => $ok && $sqlOk, 'reason' => $why[$reason] ?? $reason, 'sql' => $sqlOk, 'mismatch' => $ok && !$sqlOk,
            'summary' => adgeo_summary($pdo, $cid, $lang, $r, $mode), 'near' => $near];
    }
}
$placeLabel = $place !== null ? (mpg_labels($pdo, [$place['id']], $lang)[$place['id']]['label'] ?? '') : '';

mpb_open('Перевірка таргетингу', true, null);
?>
    <div class="mp-page">
        <h1 class="mp-title">Перевірка таргетингу</h1>
        <p class="mp-subtitle">Лише географія показу (app/ad-geo.php). Бюджет, місця показу, мова, пристрій і ліміти частоти тут не перевіряються.</p>
        <form class="mp-form geo-loc-form" method="get" action="admin-ad-geo-check.php">
            <div class="mp-field">
                <label class="mp-label" for="chk_place">Країна чи місто відвідувача</label>
                <?= mpg_picker_html('place', $place !== null ? (string) $place['id'] : '', $placeLabel, 'any', $lang, 'chk_place', 'Країна чи місто відвідувача') ?>
            </div>
            <div class="mp-row">
                <div class="mp-field">
                    <label class="mp-label" for="chk_known">Що відомо про відвідувача</label>
                    <select class="mp-input" id="chk_known" name="known">
                        <option value="city"<?= $known === 'city' ? ' selected' : '' ?>>Місто (точка міста)</option>
                        <option value="country"<?= $known === 'country' ? ' selected' : '' ?>>Лише країна</option>
                        <option value="unknown"<?= $known === 'unknown' ? ' selected' : '' ?>>Місце невідоме</option>
                    </select>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="chk_radius">Позначити «майже» (+ км)</label>
                    <select class="mp-input" id="chk_radius" name="radius">
                        <option value="0">—</option>
                        <?php foreach (ADGEO_RADII as $rv): ?><option value="<?= $rv ?>"<?= $radius === $rv ? ' selected' : '' ?>>+<?= $rv ?> км</option><?php endforeach; ?>
                    </select>
                </div>
            </div>
            <div class="geo-loc-actions"><button class="mp-btn mp-btn--primary" type="submit">Перевірити</button>
                <a class="mp-btn" href="account.php?padm_tab=campaigns#acc-promo-admin">До кампаній</a></div>
        </form>
        <p class="mp-hint">Режим за замовчуванням (config/geo.php ad_geo_default_mode): <strong><?= mp_e(adgeo_default_mode()) ?></strong>.</p>

        <?php if ($asked): ?>
            <h2 class="mp-section-title">Відвідувач: <?= $visitor['known'] ? mp_e(geo_visitor_label($pdo, $visitor, $lang)) . ($visitor['lat'] === null ? ' (лише країна)' : '') : 'місце невідоме' ?></h2>
            <?php if ($rows === []): ?>
                <p class="mp-empty">Активних, призупинених чи очікуваних відеокампаній немає.</p>
            <?php else: ?>
                <div class="pc-table-wrap" style="overflow-x:auto">
                    <table class="mp-table" style="width:100%;border-collapse:collapse">
                        <thead><tr><th align="left">Кампанія</th><th align="left">Статус</th><th align="left">Географія</th><th align="left">Результат</th><th align="left">Причина</th></tr></thead>
                        <tbody>
                        <?php foreach ($rows as $r): $c = $r['c']; ?>
                            <tr style="border-top:1px solid rgba(255,255,255,.15)">
                                <td>#<?= (int) $c['id'] ?> <?= mp_e($c['name']) ?><?= $c['campaign_type'] === 'internal' ? ' <small>(власна)</small>' : '' ?></td>
                                <td><?= mp_e($c['status']) ?></td>
                                <td><?= mp_e($r['summary']) ?></td>
                                <td><strong><?= $r['ok'] ? 'у відборі' : 'відсіяно' ?></strong><?= $r['mismatch'] ? ' <span style="color:#ffb4b4">SQL≠PHP — помилка</span>' : '' ?></td>
                                <td><?= mp_e($r['reason']) ?><?= !$r['sql'] && !$r['ok'] ? ' <small>(SQL за країною)</small>' : '' ?><?= $r['near'] !== '' ? '<br><small>майже: ' . mp_e($r['near']) . '</small>' : '' ?></td>
                            </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            <?php endif; ?>
        <?php endif; ?>
        <script src="/assets/js/mp-geo.js?v=<?= (int) @filemtime(__DIR__ . '/assets/js/mp-geo.js') ?>" defer></script>
        <?= mpg_attribution_html() ?>
    </div>
<?php mpb_close(); ?>
