<?php

declare(strict_types=1);

/**
 * AI LAB HUB — банер згоди на cookie (підключає app/footer.php на кожній сторінці з підвалом).
 *
 * Що потребує згоди: лише YouTube-відео у спливаючій рекламі (youtube-nocookie.com + IFrame API youtube.com
 * можуть зберігати свої дані). Без згоди public/assets/js/ad-popup.js показує мініатюру з «▶», і відео
 * вантажиться тільки після кліку глядача. Необхідні cookie/сховище (сесія входу й мови, geo_loc — місце відвідувача після
 * «Запам'ятати», частота реклами в localStorage, розмова з Елею в sessionStorage) працюють без згоди.
 *
 * Вибір — cookie alh_consent = 'all' | 'necessary' (1 рік, SameSite=Lax; не httponly — читає JS).
 * Окрема категорія (з 2026-11-19) «Місцеві оголошення й реклама за IP» — cookie alh_geo = '1' | '0' (1 рік), за
 * замовчуванням вимкнена. Лише з '1' (і config/geo.php geo_ip_enabled = true) сервер може визначити країну за IP
 * (app/geo.php → geo_detect_country); без згоди IP не аналізується. «Прийняти всі» вмикає обидві категорії,
 * «Лише необхідні» — вимикає обидві, «Зберегти вибір» — за прапорцями в «Налаштувати».
 * Банер показується, доки вибору немає; посилання «Налаштування cookie» в підвалі відкриває його знову
 * (без JS веде на privacy.php#cookies). API для інших скриптів: window.alhConsent.get() / .set(v).
 */

require_once __DIR__ . '/translations.php';

const COOKIE_CONSENT_NAME = 'alh_consent';
const COOKIE_CONSENT_VALUES = ['all', 'necessary'];

/** Поточний вибір відвідувача: 'all', 'necessary' або null (ще не обирав). */
function cookie_consent_value(): ?string
{
    $v = $_COOKIE[COOKIE_CONSENT_NAME] ?? null;

    return is_string($v) && in_array($v, COOKIE_CONSENT_VALUES, true) ? $v : null;
}

function cookie_consent_html(): string
{
    static $done = false;
    if ($done) {
        return '';
    }
    $done = true;
    $e = static fn(string $k): string => htmlspecialchars(t($k), ENT_QUOTES);
    $hidden = cookie_consent_value() !== null ? ' hidden' : '';
    $ytOn = cookie_consent_value() === 'all' ? ' checked' : '';
    $geoOn = ($_COOKIE['alh_geo'] ?? '') === '1' ? ' checked' : '';

    ob_start();
    ?>
<style>
    .cc-banner {
        position: fixed; z-index: 990; left: 16px; right: 16px;
        bottom: calc(var(--footer-h, 0px) + 12px);
        max-width: 560px; box-sizing: border-box; padding: 16px 18px;
        background: #10155a; color: #fff; border: 1px solid rgba(255, 255, 255, .25); border-radius: 14px;
        box-shadow: 0 10px 32px rgba(0, 0, 0, .45);
        font: 0.9rem/1.5 "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    }
    .cc-banner[hidden] { display: none; }
    .cc-banner__title { margin: 0 0 6px; font-size: 1rem; font-weight: 700; }
    .cc-banner__text { margin: 0 0 12px; color: rgba(255, 255, 255, .85); }
    .cc-banner__text a { color: #bcd0ff; }
    .cc-banner__actions { display: flex; flex-wrap: wrap; gap: 8px; }
    .cc-banner__btn {
        flex: 1 1 auto; min-height: 40px; padding: 8px 16px; border-radius: 999px; cursor: pointer;
        font: inherit; font-weight: 600; border: 1px solid rgba(255, 255, 255, .45); background: transparent; color: #fff;
    }
    .cc-banner__btn--primary { background: linear-gradient(135deg, #5b8cff, #7aa2ff); border-color: transparent; color: #00032c; }
    .cc-banner__btn:focus-visible { outline: 2px solid #bcd0ff; outline-offset: 2px; }
    .cc-banner__status { margin: 8px 0 0; font-size: .8rem; color: rgba(255, 255, 255, .7); }
    .cc-banner__status:empty { display: none; }
    .cc-banner__more { margin: 0 0 12px; }
    .cc-banner__more > summary { cursor: pointer; min-height: 44px; display: flex; align-items: center; color: #bcd0ff; }
    .cc-banner__opt { display: flex; gap: 10px; align-items: flex-start; margin: 8px 0 0; }
    .cc-banner__opt input { width: 22px; height: 22px; margin: 2px 0 0; flex: 0 0 auto; }
    .cc-banner__opt small { display: block; color: rgba(255, 255, 255, .75); }
    .site-footer__links .cc-settings-link { cursor: pointer; }
    @media (max-width: 480px) {
        .cc-banner { left: 12px; right: 12px; padding: 12px 14px; font-size: .85rem; }
        .cc-banner__text { margin-bottom: 10px; }
        .cc-banner__btn { flex: 1 1 0; min-width: 0; padding: 8px 10px; min-height: 44px; }
        .cc-banner__btn--save { flex-basis: 100%; }
    }
</style>
<section class="cc-banner" id="ccBanner" role="dialog" aria-modal="false" aria-labelledby="ccTitle"<?= $hidden ?>>
    <p class="cc-banner__title" id="ccTitle"><?= $e('cc_title') ?></p>
    <p class="cc-banner__text"><?= $e('cc_text') ?> <a href="privacy.php#cookies"><?= $e('cc_more') ?></a></p>
    <details class="cc-banner__more" id="ccMore">
        <summary><?= $e('cc_customize') ?></summary>
        <label class="cc-banner__opt"><input type="checkbox" id="ccYt"<?= $ytOn ?>> <span><?= $e('cc_yt_title') ?><small><?= $e('cc_yt_text') ?></small></span></label>
        <label class="cc-banner__opt"><input type="checkbox" id="ccGeo"<?= $geoOn ?>> <span><?= $e('cc_geo_title') ?><small><?= $e('cc_geo_text') ?></small></span></label>
    </details>
    <div class="cc-banner__actions">
        <button type="button" class="cc-banner__btn cc-banner__btn--primary" data-cc="all"><?= $e('cc_accept_all') ?></button>
        <button type="button" class="cc-banner__btn" data-cc="necessary"><?= $e('cc_necessary') ?></button>
        <button type="button" class="cc-banner__btn cc-banner__btn--save" data-cc="custom" hidden><?= $e('cc_save_choice') ?></button>
    </div>
    <p class="cc-banner__status" id="ccStatus" aria-live="polite"></p>
</section>
<script>
    (function () {
        var NAME = <?= json_encode(COOKIE_CONSENT_NAME) ?>;
        var GEO = 'alh_geo';
        var VALUES = ['all', 'necessary'];
        var labels = {
            all: <?= json_encode(t('cc_state_all'), JSON_UNESCAPED_UNICODE | JSON_HEX_TAG) ?>,
            necessary: <?= json_encode(t('cc_state_necessary'), JSON_UNESCAPED_UNICODE | JSON_HEX_TAG) ?>
        };
        function get() {
            var m = document.cookie.match(new RegExp('(?:^|; )' + NAME + '=([^;]*)'));
            return m && VALUES.indexOf(m[1]) !== -1 ? m[1] : null;
        }
        function write(name, v) {
            document.cookie = name + '=' + v + '; Max-Age=31536000; Path=/; SameSite=Lax' + (location.protocol === 'https:' ? '; Secure' : '');
        }
        function set(v) {
            if (VALUES.indexOf(v) === -1) { return; }
            write(NAME, v);
            try { document.dispatchEvent(new CustomEvent('alh:consent', { detail: v })); } catch (e) { /* старий браузер */ }
        }
        // Категорія «Місцеві оголошення й реклама за IP»: true / false (за замовчуванням вимкнена).
        function getGeo() {
            return /(?:^|; )alh_geo=1(?:;|$)/.test(document.cookie);
        }
        function setGeo(on) { write(GEO, on ? '1' : '0'); }
        window.alhConsent = { get: get, set: set, geo: getGeo, setGeo: setGeo };

        var banner = document.getElementById('ccBanner');
        var status = document.getElementById('ccStatus');
        if (!banner) { return; }
        var more = document.getElementById('ccMore');
        var yt = document.getElementById('ccYt');
        var geo = document.getElementById('ccGeo');
        var save = banner.querySelector('[data-cc="custom"]');
        if (more && save) {
            more.addEventListener('toggle', function () { save.hidden = !more.open; });
        }
        banner.addEventListener('click', function (e) {
            var b = e.target.closest('[data-cc]');
            if (!b) { return; }
            var v = b.getAttribute('data-cc');
            if (v === 'custom') {
                set(yt && yt.checked ? 'all' : 'necessary');
                setGeo(!!(geo && geo.checked));
            } else {
                set(v);
                setGeo(v === 'all');
            }
            banner.hidden = true;
        });
        // «Налаштування cookie» в підвалі: відкрити банер замість переходу на privacy.php#cookies.
        document.addEventListener('click', function (e) {
            var a = e.target.closest('[data-cc-open]');
            if (!a) { return; }
            e.preventDefault();
            var cur = get();
            status.textContent = cur ? labels[cur] : '';
            if (yt) { yt.checked = cur === 'all'; }
            if (geo) { geo.checked = getGeo(); }
            banner.hidden = false;
            var first = banner.querySelector('[data-cc="all"]');
            if (first) { first.focus(); }
        });
    })();
</script>
    <?php

    return (string) ob_get_clean();
}
