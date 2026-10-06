/* AI LAB HUB — кнопка «Додаток» (встановлення PWA).
 *
 * Лише ЯВНА дія користувача: жодних автоматичних банерів чи спливань.
 * Кнопка «Додаток» вставляється JS-ін'єкцією в кожну .site-header (як
 * перемикач мов): на мобільному — у меню (#siteNav, кнопка «Меню»), на
 * ширших екранах — перед кнопкою «Викликати Асистента».
 * Тексти — з window.PWA_I18N (app/footer.php, через t()), тож кнопка
 * перекладається разом з рештою інтерфейсу.
 *
 * Поведінка за кліком на «Додаток»:
 *  - Android / Desktop (Chrome, Edge): системний діалог встановлення через
 *    збережену подію 'beforeinstallprompt' (deferredPrompt.prompt()).
 *  - iOS (Safari та будь-який браузер на iOS): API нема — показуємо текстову
 *    інструкцію «Поділитися → На початковий екран» (лише після кліку).
 *  - інші браузери без 'beforeinstallprompt' — інструкція «меню браузера →
 *    Встановити застосунок / Додати на головний екран».
 *
 * Видимість кнопки:
 *  - сайт уже відкрито як встановлений застосунок (display-mode: standalone
 *    або navigator.standalone на iOS) — кнопку НЕ створюємо взагалі;
 *  - в усіх інших випадках — завжди: у мобільному меню («Встановити додаток»)
 *    і в шапці на ширших екранах («Додаток»). Без 'beforeinstallprompt'
 *    (браузер не дав системного діалогу) клік показує інструкцію;
 *  - після 'appinstalled' — ховаємо.
 */
(function () {
    'use strict';

    var i18n = window.PWA_I18N || {};

    var standaloneQuery = window.matchMedia ? window.matchMedia('(display-mode: standalone)') : null;
    // Межа мобільної шапки — та сама, що в app/footer.php (@media max-width: 768px).
    var mobileQuery = window.matchMedia ? window.matchMedia('(max-width: 768px)') : null;

    function isStandalone() {
        return (standaloneQuery && standaloneQuery.matches) || window.navigator.standalone === true;
    }

    // Уже встановлений застосунок — ні кнопки, ні обробників.
    if (isStandalone()) {
        return;
    }

    var isIOS =
        /iphone|ipad|ipod/i.test(window.navigator.userAgent) ||
        (window.navigator.platform === 'MacIntel' && window.navigator.maxTouchPoints > 1);

    var deferredPrompt = null;
    var hintEl = null;
    var appBtn = null;
    var installed = false;
    var label = null;

    window.addEventListener('beforeinstallprompt', function (e) {
        // Забороняємо браузеру власний міні-банер — встановлення лише з кнопки.
        e.preventDefault();
        deferredPrompt = e;
        updateAppButton();
    });

    window.addEventListener('appinstalled', function () {
        deferredPrompt = null;
        installed = true;
        removeHint();
        updateAppButton();
    });

    function removeHint() {
        if (hintEl && hintEl.parentNode) {
            hintEl.parentNode.removeChild(hintEl);
        }
        hintEl = null;
    }

    function onAppClick() {
        if (isStandalone()) {
            return;
        }
        if (deferredPrompt) {
            deferredPrompt.prompt();
            deferredPrompt.userChoice.then(function () {
                deferredPrompt = null;
                updateAppButton();
            });
            return;
        }
        // Системного діалогу немає (iOS, Samsung Internet, Firefox, вбудовані
        // браузери соцмереж, Chrome до виконання умов встановлення) — інструкція.
        if (hintEl) {
            removeHint();
        } else {
            showHint(isIOS ? i18n.iosHint : i18n.otherHint);
        }
    }

    /* Інструкція встановлення — показується ЛИШЕ після кліку на «Додаток». */
    function showHint(message) {
        hintEl = document.createElement('div');
        hintEl.className = 'pwa-install-banner';
        hintEl.setAttribute('role', 'dialog');
        hintEl.setAttribute('aria-live', 'polite');

        var icon = document.createElement('img');
        icon.className = 'pwa-install-banner__icon';
        icon.src = '/icons/icon-72.png';
        icon.alt = '';
        hintEl.appendChild(icon);

        var text = document.createElement('div');
        text.className = 'pwa-install-banner__text';
        text.textContent = message || '';
        hintEl.appendChild(text);

        var ok = document.createElement('button');
        ok.type = 'button';
        ok.className = 'pwa-install-banner__action';
        ok.textContent = i18n.iosOk || 'OK';
        ok.addEventListener('click', removeHint);
        hintEl.appendChild(ok);

        var close = document.createElement('button');
        close.type = 'button';
        close.className = 'pwa-install-banner__close';
        close.setAttribute('aria-label', i18n.close || '×');
        close.textContent = '×';
        close.addEventListener('click', removeHint);
        hintEl.appendChild(close);

        document.body.appendChild(hintEl);
        // Анімація виїзду наступного кадру; setTimeout — запас, якщо rAF «спить».
        var reveal = function () {
            if (hintEl) {
                hintEl.classList.add('is-visible');
            }
        };
        window.requestAnimationFrame(function () {
            window.requestAnimationFrame(reveal);
        });
        window.setTimeout(reveal, 60);
    }

    function injectAppButton() {
        var header = document.querySelector('.site-header');
        if (!header || header.querySelector('.site-header__app-cta')) {
            return;
        }

        appBtn = document.createElement('button');
        appBtn.type = 'button';
        appBtn.className = 'site-nav__link site-header__app-cta';
        appBtn.setAttribute('aria-label', i18n.aria || '');
        appBtn.innerHTML =
            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" ' +
            'stroke="currentColor" stroke-width="2" stroke-linecap="round" ' +
            'stroke-linejoin="round" aria-hidden="true"><path d="M12 3v12"/><path d="m8 11 4 4 4-4"/>' +
            '<path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-2"/></svg>';
        label = document.createElement('span');
        appBtn.appendChild(label);
        appBtn.addEventListener('click', onAppClick);

        placeAppButton();
        if (mobileQuery && mobileQuery.addEventListener) {
            mobileQuery.addEventListener('change', placeAppButton);
        }

        updateAppButton();
    }

    /* Місце кнопки: на мобільному (≤ 768px, де #siteNav згорнуто під кнопку
     * «Меню») — останнім пунктом меню; на ширших екранах — у шапці перед
     * кнопкою «Викликати Асистента». */
    function placeAppButton() {
        var header = appBtn && appBtn.ownerDocument.querySelector('.site-header');
        if (!header) {
            return;
        }
        var nav = header.querySelector('#siteNav');
        if (nav && mobileQuery && mobileQuery.matches) {
            nav.appendChild(appBtn);
            updateAppButton();
            return;
        }
        var cta = header.querySelector('.site-header__cta');
        if (cta) {
            header.insertBefore(appBtn, cta);
        } else {
            header.appendChild(appBtn);
        }
        updateAppButton();
    }

    function updateAppButton() {
        if (!appBtn) {
            return;
        }
        var inMenu = !!(mobileQuery && mobileQuery.matches);
        label.textContent = (inMenu ? i18n.menuLabel : i18n.button) || i18n.button || '';
        // Видно завжди, крім уже встановленого застосунку: по кліку — системний
        // діалог, якщо браузер його дав, інакше інструкція.
        appBtn.hidden = isStandalone() || installed;
    }

    // Якщо сторінку перевели в standalone (рідко, але можливо) — ховаємо кнопку.
    if (standaloneQuery && standaloneQuery.addEventListener) {
        standaloneQuery.addEventListener('change', function () {
            removeHint();
            updateAppButton();
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', injectAppButton);
    } else {
        injectAppButton();
    }
})();
