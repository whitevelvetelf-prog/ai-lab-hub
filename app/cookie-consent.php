<?php

declare(strict_types=1);

/**
 * AI LAB HUB — банер згоди на cookie (підключає app/footer.php на кожній сторінці з підвалом).
 *
 * Що потребує згоди: лише YouTube-відео у спливаючій рекламі (youtube-nocookie.com + IFrame API youtube.com
 * можуть зберігати свої дані). Без згоди public/assets/js/ad-popup.js показує мініатюру з «▶», і відео
 * вантажиться тільки після кліку глядача. Необхідні cookie/сховище (сесія входу й мови, mp_loc після
 * «Запам'ятати», частота реклами в localStorage, розмова з Елею в sessionStorage) працюють без згоди.
 *
 * Вибір — cookie alh_consent = 'all' | 'necessary' (1 рік, SameSite=Lax; не httponly — читає JS).
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
    .site-footer__links .cc-settings-link { cursor: pointer; }
    @media (max-width: 480px) {
        .cc-banner { left: 12px; right: 12px; padding: 12px 14px; font-size: .85rem; }
        .cc-banner__text { margin-bottom: 10px; }
        .cc-banner__btn { flex: 1 1 0; min-width: 0; padding: 8px 10px; }
    }
</style>
<section class="cc-banner" id="ccBanner" role="dialog" aria-modal="false" aria-labelledby="ccTitle"<?= $hidden ?>>
    <p class="cc-banner__title" id="ccTitle"><?= $e('cc_title') ?></p>
    <p class="cc-banner__text"><?= $e('cc_text') ?> <a href="privacy.php#cookies"><?= $e('cc_more') ?></a></p>
    <div class="cc-banner__actions">
        <button type="button" class="cc-banner__btn cc-banner__btn--primary" data-cc="all"><?= $e('cc_accept_all') ?></button>
        <button type="button" class="cc-banner__btn" data-cc="necessary"><?= $e('cc_necessary') ?></button>
    </div>
    <p class="cc-banner__status" id="ccStatus" aria-live="polite"></p>
</section>
<script>
    (function () {
        var NAME = <?= json_encode(COOKIE_CONSENT_NAME) ?>;
        var VALUES = ['all', 'necessary'];
        var labels = {
            all: <?= json_encode(t('cc_state_all'), JSON_UNESCAPED_UNICODE | JSON_HEX_TAG) ?>,
            necessary: <?= json_encode(t('cc_state_necessary'), JSON_UNESCAPED_UNICODE | JSON_HEX_TAG) ?>
        };
        function get() {
            var m = document.cookie.match(new RegExp('(?:^|; )' + NAME + '=([^;]*)'));
            return m && VALUES.indexOf(m[1]) !== -1 ? m[1] : null;
        }
        function set(v) {
            if (VALUES.indexOf(v) === -1) { return; }
            document.cookie = NAME + '=' + v + '; Max-Age=31536000; Path=/; SameSite=Lax' + (location.protocol === 'https:' ? '; Secure' : '');
            try { document.dispatchEvent(new CustomEvent('alh:consent', { detail: v })); } catch (e) { /* старий браузер */ }
        }
        window.alhConsent = { get: get, set: set };

        var banner = document.getElementById('ccBanner');
        var status = document.getElementById('ccStatus');
        if (!banner) { return; }
        banner.addEventListener('click', function (e) {
            var b = e.target.closest('[data-cc]');
            if (!b) { return; }
            set(b.getAttribute('data-cc'));
            banner.hidden = true;
        });
        // «Налаштування cookie» в підвалі: відкрити банер замість переходу на privacy.php#cookies.
        document.addEventListener('click', function (e) {
            var a = e.target.closest('[data-cc-open]');
            if (!a) { return; }
            e.preventDefault();
            var cur = get();
            status.textContent = cur ? labels[cur] : '';
            banner.hidden = false;
            var first = banner.querySelector('[data-cc="all"]');
            if (first) { first.focus(); }
        });
    })();
</script>
    <?php

    return (string) ob_get_clean();
}
