<?php

declare(strict_types=1);

/**
 * AI LAB HUB — вибір місця відвідувача (app/geo.php): для «Поблизу мене» в Marketplace і географії реклами.
 *
 *   GET  ?back=<відносна адреса>  — форма: «Країна й місто» (автопідказка geo-suggest.php), «Поблизу» (геолокація
 *        браузера лише після натискання; координати йдуть POST-ом на geo-suggest.php, сервер повертає найближче місто
 *        в межах 100 км і нічого не зберігає), «Зберегти», «Не вказувати», «Очистити».
 *   POST action=save  place=<id місця>  src=user|browser  — cookie geo_loc (лише id місця або код країни, 180 днів;
 *                     залогіненому — ще й mp_user_prefs); action=none — у цьому сеансі місце не визначається й за IP;
 *                     action=clear — видаляє cookie і місце з профілю. CSRF — mp_csrf_verify(). Повернення — лише на
 *                     відносну адресу цього сайту (geo_safe_back()).
 * Працює для гостей і залогінених незалежно від того, чи відкрито Marketplace (місце потрібне й рекламі).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-geo-form.php';
require_once __DIR__ . '/../app/geo.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
if (!mpg_ready($pdo)) {
    mp_not_found();
}
header('X-Robots-Tag: noindex');
$lang = current_lang();
$userId = auth_user_id();
$str = static fn(array $src, string $k, int $max = 600): string => is_string($src[$k] ?? null) ? mb_substr(trim((string) $src[$k]), 0, $max) : '';
$back = geo_safe_back($str($_POST, 'back') ?: $str($_GET, 'back'), mp_public_enabled() ? 'marketplace.php' : 'index.php');

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!mp_csrf_verify()) {
        mpb_message_page(403, t('mpb_err_csrf_title'), '<p class="mp-text">' . mp_e(t('mpb_err_csrf')) . '</p>', 'geo-location.php');
    }
    $action = $str($_POST, 'action', 10);
    if ($action === 'save') {
        $value = $str($_POST, 'place', 12);
        $v = $value !== '' ? geo_from_value($pdo, $value, 'user') : null;
        if ($v === null) {
            mpb_flash('error', t('geo_loc_err'));
            mpb_redirect('geo-location.php?' . http_build_query(['back' => $back]));
        }
        // У cookie — місто (id) або країна (код); регіон зберігається як країна.
        $cookie = $v['lat'] !== null ? (string) $v['place_id'] : (string) $v['country_code'];
        geo_cookie_set($cookie, $str($_POST, 'src', 10) === 'browser' ? 'browser' : 'user');
        if ($userId !== null) {
            geo_profile_save($pdo, $userId, $cookie);
        }
        mpb_flash('ok', t('geo_loc_saved'));
        mpb_redirect($back);
    }
    if ($action === 'none') {
        $_SESSION['geo_none'] = 1;
        unset($_SESSION['geo_ip_cc']);
        mpb_redirect($back);
    }
    if ($action === 'clear') {
        geo_cookie_clear();
        if ($userId !== null) {
            geo_profile_save($pdo, $userId, '');
        }
        unset($_SESSION['geo_ip_cc']);
        mpb_flash('ok', t('geo_loc_cleared'));
        mpb_redirect('geo-location.php?' . http_build_query(['back' => $back]));
    }
    mpb_redirect('geo-location.php?' . http_build_query(['back' => $back]));
}

$v = geo_visitor($pdo, $userId);
$label = geo_visitor_label($pdo, $v, $lang);
$pickId = $v['known'] ? (string) ($v['place_id'] ?? mpg_country_id($pdo, (string) $v['country_code']) ?? '') : '';
$ipState = !geo_config()['geo_ip_enabled'] ? 'geo_loc_ip_off' : (geo_ip_consent() ? 'geo_loc_ip_consented' : 'geo_loc_ip_no_consent');

mpb_open(t('geo_place_title'), true, mp_public_enabled() ? 'place' : null);
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= mp_e(t('geo_place_title')) ?></h1>
        <p class="mp-subtitle"><?= mp_e(t('geo_loc_intro')) ?></p>
        <?= mpb_flash_html() ?>
        <p class="mp-text">
            <?php if ($v['known']): ?>
                <?= mp_e(sprintf(t('geo_loc_current'), $label)) ?> <span class="mp-hint">(<?= mp_e(t('geo_src_' . $v['source'])) ?>)</span>
            <?php else: ?>
                <?= mp_e(t('geo_loc_unknown')) ?>
            <?php endif; ?>
        </p>

        <form class="mp-form geo-loc-form" method="post" action="geo-location.php">
            <?= mp_csrf_field() ?>
            <input type="hidden" name="back" value="<?= mp_e($back) ?>">
            <input type="hidden" name="src" value="user" data-geo-src>
            <div class="mp-field">
                <label class="mp-label" for="g_place"><?= mp_e(t('geo_loc_field')) ?></label>
                <div class="mp-geo-loc" id="g_place_wrap">
                    <?= mpg_picker_html('place', $pickId, $v['known'] && $v['source'] !== 'ip' ? $label : '', 'any', $lang, 'g_place', t('geo_loc_field')) ?>
                    <button class="mp-btn" type="button" data-geo-near="g_place_wrap" data-csrf="<?= mp_e(mp_csrf_token()) ?>"
                            data-msg-wait="<?= mp_e(t('mpg_near_wait')) ?>" data-msg-fail="<?= mp_e(t('geo_near_fail')) ?>" data-msg-denied="<?= mp_e(t('mpg_near_denied')) ?>"><?= mp_e(t('mpg_near_btn')) ?></button>
                    <span class="mp-geo-status" data-geo-status aria-live="polite"></span>
                </div>
                <p class="mp-hint"><?= mp_e(t('geo_loc_near_hint')) ?></p>
            </div>
            <div class="geo-loc-actions">
                <button class="mp-btn mp-btn--primary" type="submit" name="action" value="save"><?= mp_e(t('geo_loc_save')) ?></button>
                <button class="mp-btn" type="submit" name="action" value="none" formnovalidate><?= mp_e(t('geo_loc_none')) ?></button>
                <?php if ($v['known'] && $v['source'] !== 'ip'): ?>
                    <button class="mp-btn" type="submit" name="action" value="clear" formnovalidate><?= mp_e(t('geo_loc_clear')) ?></button>
                <?php endif; ?>
                <a class="mp-btn" href="<?= mp_e($back) ?>"><?= mp_e(t('geo_back')) ?></a>
            </div>
        </form>

        <p class="mp-hint"><?= mp_e(t('geo_loc_privacy')) ?></p>
        <p class="mp-hint"><?= mp_e(t($ipState)) ?> <a href="privacy.php#cookies" data-cc-open><?= mp_e(t('geo_cookie_settings')) ?></a></p>
        <?php if ($userId !== null && mp_public_enabled()): ?>
            <p class="mp-hint"><a href="mp-settings.php"><?= mp_e(t('mpg_settings_link')) ?></a></p>
        <?php endif; ?>
        <script src="/assets/js/mp-geo.js?v=<?= (int) @filemtime(__DIR__ . '/assets/js/mp-geo.js') ?>" defer></script>
        <?= mpg_attribution_html() ?>
    </div>
<?php mpb_close(); ?>
