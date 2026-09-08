/* AI LAB HUB — встановлення застосунку (PWA).
 *
 * Дає користувачу два шляхи встановити застосунок:
 *  1) автобанер знизу екрана — з'являється сам через SHOW_DELAY_MS;
 *  2) постійна кнопка «Додаток» у шапці сайту (вставляється JS-ін'єкцією,
 *     як перемикач мов) — працює без очікування банера.
 *
 * Обидва шляхи використовують одну логіку — triggerInstall():
 *  - Android / Desktop (Chrome, Edge): ловимо 'beforeinstallprompt', зберігаємо
 *    подію, по дії викликаємо нативний deferredPrompt.prompt().
 *  - iOS (Safari та будь-який браузер на iOS): 'beforeinstallprompt' не існує —
 *    показуємо банер-інструкцію «Поділитися → На початковий екран».
 *  - Якщо сайт уже відкрито як встановлений застосунок (standalone) — нічого.
 *
 * Видимість кнопки «Додаток» у шапці:
 *  - standalone            → ховаємо завжди;
 *  - iOS                   → показуємо одразу при завантаженні;
 *  - Android / Desktop     → ховаємо, поки не прийшла подія 'beforeinstallprompt'.
 *
 * Автобанер додатково: закриття хрестиком запам'ятовується в localStorage на
 * DISMISS_DAYS днів. На кнопку «Додаток» це обмеження не діє — вона явна дія.
 */
(function () {
    'use strict';

    var SHOW_DELAY_MS = 9000;          // затримка перед показом автобанера (7–10 с)
    var DISMISS_DAYS = 14;             // не показувати автобанер після закриття хрестиком
    var STORAGE_KEY = 'ailabhub_pwa_banner_dismissed_at';

    var isStandalone =
        (window.matchMedia && window.matchMedia('(display-mode: standalone)').matches) ||
        window.navigator.standalone === true;

    // Уже встановлений застосунок — ні банера, ні кнопки, ні обробників.
    if (isStandalone) {
        return;
    }

    var isIOS =
        /iphone|ipad|ipod/i.test(window.navigator.userAgent) ||
        (window.navigator.platform === 'MacIntel' && window.navigator.maxTouchPoints > 1);

    var deferredPrompt = null;
    var bannerEl = null;
    var appBtn = null;
    var timerFired = false;

    function recentlyDismissed() {
        try {
            var ts = parseInt(window.localStorage.getItem(STORAGE_KEY), 10);
            if (!ts) {
                return false;
            }
            return (Date.now() - ts) < DISMISS_DAYS * 24 * 60 * 60 * 1000;
        } catch (e) {
            return false;
        }
    }

    function rememberDismiss() {
        try {
            window.localStorage.setItem(STORAGE_KEY, String(Date.now()));
        } catch (e) {}
    }

    window.addEventListener('beforeinstallprompt', function (e) {
        e.preventDefault();
        deferredPrompt = e;
        updateAppButton();
        // Якщо затримка вже минула, а банер ще не показаний — показуємо тепер.
        if (timerFired && !bannerEl) {
            showBanner('android');
        }
    });

    window.addEventListener('appinstalled', function () {
        deferredPrompt = null;
        removeBanner();
        rememberDismiss();
        updateAppButton();
    });

    function removeBanner() {
        if (bannerEl && bannerEl.parentNode) {
            bannerEl.parentNode.removeChild(bannerEl);
        }
        bannerEl = null;
    }

    /* Єдина точка запуску встановлення — і для автобанера, і для кнопки в шапці.
     * force === true (кнопка «Додаток») ігнорує 14-денне «закрито хрестиком». */
    function triggerInstall(force) {
        if (isStandalone) {
            return;
        }
        if (deferredPrompt) {
            deferredPrompt.prompt();
            deferredPrompt.userChoice.then(function () {
                deferredPrompt = null;
                removeBanner();
                updateAppButton();
            });
            return;
        }
        if (isIOS) {
            showBanner('ios', force === true);
        }
    }

    // Публічний виклик для кнопки «Додаток» у шапці (див. injectAppButton).
    window.aiLabHubInstall = function () {
        triggerInstall(true);
    };

    function showBanner(mode, force) {
        if (bannerEl || isStandalone || (!force && recentlyDismissed())) {
            return;
        }

        bannerEl = document.createElement('div');
        bannerEl.className = 'pwa-install-banner';
        bannerEl.setAttribute('role', 'dialog');
        bannerEl.setAttribute('aria-live', 'polite');

        var icon = document.createElement('img');
        icon.className = 'pwa-install-banner__icon';
        icon.src = '/icons/icon-72.png';
        icon.alt = '';
        bannerEl.appendChild(icon);

        var text = document.createElement('div');
        text.className = 'pwa-install-banner__text';

        var action = document.createElement('button');
        action.type = 'button';
        action.className = 'pwa-install-banner__action';

        if (mode === 'ios') {
            text.textContent =
                'Встановіть AI LAB HUB як застосунок: Поділитися → На початковий екран';
            action.textContent = 'Зрозуміло';
            action.addEventListener('click', function () {
                removeBanner();
            });
        } else {
            text.textContent = 'Встановіть AI LAB HUB як застосунок на свій пристрій';
            action.textContent = 'Встановити';
            action.addEventListener('click', function () {
                triggerInstall(false);
            });
        }

        bannerEl.appendChild(text);
        bannerEl.appendChild(action);

        var close = document.createElement('button');
        close.type = 'button';
        close.className = 'pwa-install-banner__close';
        close.setAttribute('aria-label', 'Закрити');
        close.textContent = '×';
        close.addEventListener('click', function () {
            rememberDismiss();
            removeBanner();
        });
        bannerEl.appendChild(close);

        document.body.appendChild(bannerEl);
        // Вмикаємо анімацію виїзду наступного кадру; setTimeout — запасний
        // варіант, якщо requestAnimationFrame «спить» (вкладка у фоні).
        var reveal = function () {
            if (bannerEl) {
                bannerEl.classList.add('is-visible');
            }
        };
        window.requestAnimationFrame(function () {
            window.requestAnimationFrame(reveal);
        });
        window.setTimeout(reveal, 60);
    }

    /* Кнопка «Додаток» у шапці. Вставляємо JS-ін'єкцією в кожну .site-header
     * (як перемикач мов), перед кнопкою «Викликати Асистента» — щоб не правити
     * розмітку десятків сторінок. */
    function injectAppButton() {
        if (isStandalone) {
            return;
        }
        var header = document.querySelector('.site-header');
        if (!header || header.querySelector('.site-header__app-cta')) {
            return;
        }

        appBtn = document.createElement('button');
        appBtn.type = 'button';
        appBtn.className = 'site-nav__link site-header__app-cta';
        appBtn.setAttribute('aria-label', 'Встановити застосунок AI LAB HUB');
        appBtn.innerHTML =
            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" ' +
            'stroke="currentColor" stroke-width="2" stroke-linecap="round" ' +
            'stroke-linejoin="round"><path d="M12 3v12"/><path d="m8 11 4 4 4-4"/>' +
            '<path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-2"/></svg>' +
            '<span>Додаток</span>';
        appBtn.addEventListener('click', function () {
            triggerInstall(true);
        });

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
        appBtn.hidden = isStandalone || !(isIOS || deferredPrompt);
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', injectAppButton);
    } else {
        injectAppButton();
    }

    window.setTimeout(function () {
        timerFired = true;
        if (deferredPrompt) {
            showBanner('android');
        } else if (isIOS) {
            showBanner('ios');
        }
        // Інакше чекаємо на можливий 'beforeinstallprompt' (обробник вище).
    }, SHOW_DELAY_MS);
})();
