<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: налаштування пошуку відвідувача (етап 6).
 *
 *   Залогінений — mp_user_prefs: країна, місто, радіус, одиниці (км/милі), мови оголошень, «показувати онлайн».
 *   Гість — лише місто в cookie geo_loc (place_id або код країни, httponly, 180 днів; app/geo.php); cookie ставиться
 *   тільки після явного вибору (кнопка «Зберегти» тут або «Запам'ятати …» на сторінці пошуку). Стара mp_loc —
 *   лише читається як запасна. Місце саме НЕ фільтрує пошук — його використовує «Поблизу мене» (nearby=1) і реклама.
 *   «Поблизу» — геолокація браузера лише після натискання; координати не зберігаються (geo-suggest.php).
 *   Країна за IP — лише app/geo.php за згодою (типово вимкнено).
 *
 * POST action: save | remember (з пошуку: place_id, radius_km, back) | forget. CSRF — mp_csrf_verify().
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-geo-form.php';

mp_public_or_staff_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
if (!mpg_ready($pdo)) {
    mp_not_found();
}
$lang = current_lang();
$userId = auth_user_id();

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!mp_csrf_verify()) {
        mpb_message_page(403, t('mpb_err_csrf_title'), '<p class="mp-text">' . mp_e(t('mpb_err_csrf')) . '</p>', 'mp-settings.php');
    }
    $action = is_string($_POST['action'] ?? null) ? (string) $_POST['action'] : '';
    $str = static fn(string $k): string => is_string($_POST[$k] ?? null) ? trim((string) $_POST[$k]) : '';
    $current = mpg_prefs($pdo, $userId);
    if ($action === 'forget') {
        mpg_prefs_save($pdo, $userId, ['place_id' => 0, 'country_code' => '', 'radius_km' => MPG_DEFAULT_RADIUS,
            'units' => $current['units'], 'listing_langs' => $current['listing_langs'], 'show_online' => $current['show_online']]);
        mpb_flash('ok', t('mpg_settings_forgot'));
        mpb_redirect('mp-settings.php');
    }
    if ($action === 'remember') {
        // З пошуку: лише місто й радіус; решта налаштувань лишається.
        mpg_prefs_save($pdo, $userId, ['place_id' => ctype_digit($str('place_id')) ? (int) $str('place_id') : 0,
            'country_code' => '', 'radius_km' => ctype_digit($str('radius_km')) ? (int) $str('radius_km') : MPG_DEFAULT_RADIUS,
            'units' => $current['units'], 'listing_langs' => $current['listing_langs'], 'show_online' => $current['show_online']]);
        mpb_flash('ok', t('mpg_settings_saved'));
        $back = $str('back');
        // Повернення лише на сторінку пошуку цього сайту.
        mpb_redirect(preg_match('#^marketplace\.php(\?[^\s<>"\'\\\\]*)?$#', $back) === 1 ? $back : 'marketplace.php');
    }
    if ($action === 'save') {
        $langs = is_array($_POST['listing_langs'] ?? null) ? array_filter($_POST['listing_langs'], 'is_string') : [];
        $cc = strtoupper($str('country_code'));
        mpg_prefs_save($pdo, $userId, [
            'place_id' => ctype_digit($str('place_id')) ? (int) $str('place_id') : 0,
            'country_code' => preg_match('/^[A-Z]{2}$/', $cc) === 1 ? $cc : '',
            'radius_km' => ctype_digit($str('radius_km')) ? (int) $str('radius_km') : MPG_DEFAULT_RADIUS,
            'units' => $str('units') === 'mi' ? 'mi' : 'km',
            'listing_langs' => array_values($langs),
            'show_online' => $str('show_online') === '1',
        ]);
        mpb_flash('ok', t('mpg_settings_saved'));
        mpb_redirect('mp-settings.php');
    }
    mpb_redirect('mp-settings.php');
}

$prefs = mpg_prefs($pdo, $userId);
$placeLabel = $prefs['place_id'] > 0 ? (mpg_labels($pdo, [$prefs['place_id']], $lang)[$prefs['place_id']]['label'] ?? '') : '';
$countries = mpg_countries($pdo, $lang);
$isGuest = $userId === null;

mpb_open(t('mpg_settings_title'), true, 'home');
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= mp_e(t('mpg_settings_title')) ?></h1>
        <p class="mp-subtitle"><?= mp_e(t($isGuest ? 'mpg_settings_guest_note' : 'mpg_settings_note')) ?></p>
        <?= mpb_flash_html() ?>

        <form class="mp-form" method="post" action="mp-settings.php">
            <?= mp_csrf_field() ?>
            <input type="hidden" name="action" value="save">
            <div class="mp-field">
                <label class="mp-label" for="s_place"><?= mp_e(t('mpg_f_place')) ?></label>
                <div class="mp-geo-loc" id="s_place_wrap">
                    <?= mpg_picker_html('place_id', $prefs['place_id'] > 0 ? (string) $prefs['place_id'] : '', $placeLabel, 'city', $lang, 's_place', t('mpg_f_place')) ?>
                    <button class="mp-btn" type="button" data-geo-near="s_place_wrap" data-csrf="<?= mp_e(mp_csrf_token()) ?>"
                            data-msg-wait="<?= mp_e(t('mpg_near_wait')) ?>" data-msg-fail="<?= mp_e(t('mpg_near_fail')) ?>" data-msg-denied="<?= mp_e(t('mpg_near_denied')) ?>"><?= mp_e(t('mpg_near_btn')) ?></button>
                    <span class="mp-geo-status" data-geo-status aria-live="polite"></span>
                </div>
                <p class="mp-hint"><?= mp_e(t('mpg_near_hint')) ?></p>
            </div>
            <?php if (!$isGuest): ?>
                <div class="mp-row">
                    <div class="mp-field">
                        <label class="mp-label" for="s_country"><?= mp_e(t('mpg_f_country')) ?></label>
                        <select class="mp-input" id="s_country" name="country_code">
                            <option value=""><?= mp_e(t('mpg_anywhere')) ?></option>
                            <?php foreach ($countries as $code => $name): ?>
                                <option value="<?= mp_e($code) ?>"<?= $prefs['country_code'] === $code ? ' selected' : '' ?>><?= mp_e($name) ?></option>
                            <?php endforeach; ?>
                        </select>
                        <p class="mp-hint"><?= mp_e(t('mpg_country_hint')) ?></p>
                    </div>
                    <div class="mp-field">
                        <label class="mp-label" for="s_radius"><?= mp_e(t('mpg_f_radius')) ?></label>
                        <select class="mp-input mp-input--short" id="s_radius" name="radius_km">
                            <?php foreach (MPG_RADII as $r): ?>
                                <option value="<?= $r ?>"<?= $prefs['radius_km'] === $r ? ' selected' : '' ?>><?= $r ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="mp-field">
                        <span class="mp-label"><?= mp_e(t('mpg_f_units')) ?></span>
                        <label class="mp-check"><input type="radio" name="units" value="km"<?= $prefs['units'] === 'km' ? ' checked' : '' ?>> <span><?= mp_e(t('mpg_unit_km')) ?></span></label>
                        <label class="mp-check"><input type="radio" name="units" value="mi"<?= $prefs['units'] === 'mi' ? ' checked' : '' ?>> <span><?= mp_e(t('mpg_unit_mi')) ?></span></label>
                    </div>
                </div>
                <fieldset class="mp-field mp-fieldset">
                    <legend class="mp-label"><?= mp_e(t('mpg_f_listing_langs')) ?></legend>
                    <?php foreach (MPG_LISTING_LANGS as $ll): ?>
                        <label class="mp-check"><input type="checkbox" name="listing_langs[]" value="<?= $ll ?>"<?= in_array($ll, $prefs['listing_langs'], true) ? ' checked' : '' ?>> <span><?= mp_e(t('mpg_lang_' . $ll)) ?></span></label>
                    <?php endforeach; ?>
                    <p class="mp-hint"><?= mp_e(t('mpg_langs_hint')) ?></p>
                </fieldset>
                <div class="mp-field mp-field--check">
                    <input type="hidden" name="show_online" value="0">
                    <label class="mp-check"><input type="checkbox" name="show_online" value="1"<?= $prefs['show_online'] ? ' checked' : '' ?>> <span><?= mp_e(t('mpg_f_show_online')) ?></span></label>
                </div>
            <?php endif; ?>
            <div class="mp-actions">
                <button class="mp-btn mp-btn--primary" type="submit"><?= mp_e(t('mpg_save_btn')) ?></button>
                <a class="mp-btn" href="marketplace.php"><?= mp_e(t('mpg_back_to_search')) ?></a>
            </div>
        </form>
        <?php if ($prefs['saved']): ?>
            <form method="post" action="mp-settings.php">
                <?= mp_csrf_field() ?>
                <input type="hidden" name="action" value="forget">
                <button class="mp-btn" type="submit"><?= mp_e(t('mpg_forget_btn')) ?></button>
            </form>
        <?php endif; ?>
        <script src="/assets/js/mp-geo.js?v=<?= (int) @filemtime(__DIR__ . '/assets/js/mp-geo.js') ?>" defer></script>
        <?= mpg_attribution_html() ?>
    </div>
<?php mpb_close(); ?>
