/* AI LAB HUB — банер «Встановити застосунок».
 *
 * Поведінка:
 *  - Якщо сайт уже відкрито як встановлений застосунок — банер не показуємо.
 *  - Android / Desktop (Chrome, Edge): ловимо 'beforeinstallprompt', зберігаємо
 *    подію, показуємо банер із кнопкою «Встановити», по кліку — нативний prompt().
 *  - iOS (Safari та будь-який браузер на iOS): 'beforeinstallprompt' не існує —
 *    показуємо банер з інструкцією «Поділитися → На початковий екран» і кнопкою
 *    «Зрозуміло» (просто закриває банер).
 *  - Банер з'являється не одразу, а через SHOW_DELAY_MS.
 *  - Закриття хрестиком запам'ятовується в localStorage на DISMISS_DAYS днів.
 */
(function () {
    'use strict';

    var SHOW_DELAY_MS = 9000;          // затримка перед показом (7–10 сек)
    var DISMISS_DAYS = 14;             // не показувати після закриття хрестиком
    var STORAGE_KEY = 'ailabhub_pwa_banner_dismissed_at';

    // 1. Уже встановлений застосунок — нічого не робимо.
    var isStandalone =
        (window.matchMedia && window.matchMedia('(display-mode: standalone)').matches) ||
        window.navigator.standalone === true;
    if (isStandalone) {
        return;
    }

    // 2. Нещодавно закрили банер — не показуємо повторно.
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

    if (recentlyDismissed()) {
        return;
    }

    var isIOS =
        /iphone|ipad|ipod/i.test(window.navigator.userAgent) ||
        (window.navigator.platform === 'MacIntel' && window.navigator.maxTouchPoints > 1);

    var deferredPrompt = null;
    var bannerEl = null;
    var timerFired = false;

    window.addEventListener('beforeinstallprompt', function (e) {
        e.preventDefault();
        deferredPrompt = e;
        // Якщо затримка вже минула, а банер ще не показаний — показуємо тепер.
        if (timerFired && !bannerEl) {
            showBanner('android');
        }
    });

    window.addEventListener('appinstalled', function () {
        removeBanner();
        rememberDismiss();
    });

    function removeBanner() {
        if (bannerEl && bannerEl.parentNode) {
            bannerEl.parentNode.removeChild(bannerEl);
        }
        bannerEl = null;
    }

    function showBanner(mode) {
        if (bannerEl || isStandalone || recentlyDismissed()) {
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
                if (!deferredPrompt) {
                    return;
                }
                deferredPrompt.prompt();
                deferredPrompt.userChoice.then(function () {
                    deferredPrompt = null;
                    removeBanner();
                });
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
