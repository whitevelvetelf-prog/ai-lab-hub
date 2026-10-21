/* AI LAB HUB — реклама спливаючим вікном (app/ad-popup.php → /ad-next.php).
 *
 *   * Правила з #ad-popup-config (сервер) + localStorage: вікно не раніше другої сторінки
 *     візиту й 30 с від його початку, не частіше ніж раз на interval с від закриття
 *     попереднього (час закриття — у localStorage і в сесії на сервері; береться пізніший).
 *     localStorage недоступний — лише серверна сесія.
 *   * Поки фокус у полі вводу або в полі є текст (пошук, чат Елі) — чекаємо.
 *   * Вікно: role="dialog", aria-modal, фокус усередині (Tab циклічно), фон затемнено й
 *     не прокручується (позиція прокрутки повертається після закриття). «Пропустити»
 *     недоступна skip с (10–15) зі зворотним відліком (aria-live polite); до кінця відліку
 *     вікно не закривається ні фоном, ні Esc. Після — «Пропустити» або Esc.
 *   * Клік по рекламі — /promo-click.php у новій вкладці; вікно лишається відкритим.
 *   * Відео стартує само. Зі звуком — лише якщо глядач уже взаємодіяв зі сторінкою
 *     (navigator.userActivation.hasBeenActive) і не вимикав звук раніше; браузер не дав —
 *     одразу без звуку (muted, playsinline) і підказка «Увімкнути звук» біля динаміка.
 *     Кнопка-динамік завжди є; вибір глядача — у localStorage (alh_ad_popup_sound: on|off),
 *     вимкнув — автоматично звук більше не вмикається. Звучить лише одне відео на сторінці.
 *     Коротше за відлік — повторюється. saveData / prefers-reduced-motion (або браузер не дав
 *     навіть без звуку) — постер і «▶»: ролик стартує без звуку лише на дію глядача.
 *   * Відлік «Пропустити» йде з події playing (зображення, картка, постер — одразу; відео не
 *     стартувало за 3 с — теж). У прихованій вкладці відлік і відео на паузі.
 *   * Оголошення без відео (зображення, картка) — вікно закривається саме через creative.display с (20)
 *     видимого часу.
 *   * Облік: impression — відео видно й воно грає ≥1 с (без відео — вікно видно ≥1 с);
 *     skip — «Пропустити»; close — закрилось саме; через sendBeacon.
 *   * Увесь текст із сервера — через textContent.
 */
(function () {
    'use strict';

    var cfgNode = document.getElementById('ad-popup-config');
    if (!cfgNode || !window.fetch) {
        return;
    }
    var cfg;
    try {
        cfg = JSON.parse(cfgNode.textContent);
    } catch (e) {
        return;
    }

    var NEXT = '/ad-next.php';
    var EVENT = '/promo-event.php';
    var CLICK = '/promo-click.php';
    var LS_KEY = 'alh_ad_popup_closed';
    var LS_SOUND = 'alh_ad_popup_sound';
    var START_FALLBACK_MS = 3000;   // відео не стартувало — відлік однаково йде

    var reduceMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var saveData = !!(navigator.connection && navigator.connection.saveData);
    var allowAutoplay = !reduceMotion && !saveData;

    function noop() {}

    function el(tag, className, text) {
        var node = document.createElement(tag);
        if (className) {
            node.className = className;
        }
        if (text !== undefined && text !== null) {
            node.textContent = text;
        }
        return node;
    }

    function lsGet() {
        try {
            return parseInt(window.localStorage.getItem(LS_KEY) || '0', 10) || 0;
        } catch (e) {
            return 0;
        }
    }

    function lsSet(ts) {
        try {
            window.localStorage.setItem(LS_KEY, String(ts));
        } catch (e) {
            // без localStorage працює лише серверна сесія
        }
    }

    /** Вибір глядача щодо звуку: 'on', 'off' або '' (ще не обирав). */
    function soundPref() {
        try {
            return window.localStorage.getItem(LS_SOUND) || '';
        } catch (e) {
            return '';
        }
    }

    function soundPrefSet(value) {
        try {
            window.localStorage.setItem(LS_SOUND, value);
        } catch (e) {
            // вибір діє лише в цьому вікні
        }
    }

    function sendEvents(list) {
        var data = new FormData();
        data.append('events', JSON.stringify(list));
        if (!(navigator.sendBeacon && navigator.sendBeacon(EVENT, data))) {
            fetch(EVENT, { method: 'POST', body: data, credentials: 'same-origin', keepalive: true }).catch(noop);
        }
    }

    // --- Коли можна показати ---------------------------------------------------

    // Годинник сервера проти клієнта: різниця, щоб порівнювати з часом сесії.
    var skew = Math.floor(Date.now() / 1000) - cfg.now;

    function nowSrv() {
        return Math.floor(Date.now() / 1000) - skew;
    }

    function secondsToWait() {
        var lastClose = Math.max(cfg.lastClose || 0, lsGet() - skew);
        var afterLast = lastClose > 0 ? lastClose + cfg.interval : 0;
        var afterVisit = cfg.visitStart + cfg.visitDelay;
        return Math.max(0, Math.max(afterLast, afterVisit) - nowSrv());
    }

    function typing() {
        var a = document.activeElement;
        if (a && (a.tagName === 'INPUT' || a.tagName === 'TEXTAREA' || a.isContentEditable)
            && !/^(button|submit|checkbox|radio|range|color|file|reset|image|hidden)$/i.test(a.type || '')) {
            return true;
        }
        var fields = document.querySelectorAll('input[type="search"], input[type="text"], input:not([type]), textarea');
        for (var i = 0; i < fields.length; i++) {
            if (fields[i].value && fields[i].value.trim() !== '' && fields[i].offsetParent !== null) {
                return true;
            }
        }
        return false;
    }

    var shown = false;

    function attempt() {
        if (shown) {
            return;
        }
        var wait = secondsToWait();
        if (wait > 0) {
            window.setTimeout(attempt, wait * 1000 + 250);
            return;
        }
        if (typing() || document.visibilityState !== 'visible' || document.querySelector('dialog[open], [aria-modal="true"]')) {
            window.setTimeout(attempt, 2000);
            return;
        }
        shown = true;
        var params = new URLSearchParams({
            category: (cfg.cats || []).join(','),
            subcategory: (cfg.subs || []).join(','),
            lang: cfg.lang || '',
            device: window.matchMedia && window.matchMedia('(max-width: 768px), (pointer: coarse)').matches ? 'mobile' : 'desktop',
            page: (location.pathname.split('/').pop() || 'index.php')
        });
        fetch(NEXT + '?' + params.toString(), { credentials: 'same-origin' })
            .then(function (res) { return res.status === 200 ? res.json() : null; })
            .then(function (payload) {
                if (payload && payload.creative && payload.labels) {
                    open(payload.creative, payload.labels);
                }
            })
            .catch(noop);
    }

    // --- Вікно -----------------------------------------------------------------

    var ICON_MUTED = '<svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true" focusable="false">'
        + '<path fill="currentColor" d="M3 9v6h4l5 5V4L7 9H3z"/>'
        + '<path d="M16 9l5 6M21 9l-5 6" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>';
    var ICON_SOUND = '<svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true" focusable="false">'
        + '<path fill="currentColor" d="M3 9v6h4l5 5V4L7 9H3z"/>'
        + '<path d="M15.5 8.5a5 5 0 0 1 0 7M18.5 5.5a9 9 0 0 1 0 13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>';

    function lockScroll() {
        var y = window.scrollY || window.pageYOffset || 0;
        var body = document.body;
        var saved = { position: body.style.position, top: body.style.top, width: body.style.width, overflow: body.style.overflow };
        body.style.position = 'fixed';
        body.style.top = (-y) + 'px';
        body.style.width = '100%';
        body.style.overflow = 'hidden';
        return function () {
            body.style.position = saved.position;
            body.style.top = saved.top;
            body.style.width = saved.width;
            body.style.overflow = saved.overflow;
            window.scrollTo(0, y);
        };
    }

    function open(creative, labels) {
        var href = CLICK + '?t=' + encodeURIComponent(creative.token);
        var skipDelay = Math.max(10, Math.min(15, parseInt(creative.skip, 10) || 12));
        var opener = document.activeElement;

        var overlay = el('div', 'adp-overlay' + (reduceMotion ? ' adp-overlay--still' : ''));
        var dialog = el('div', 'adp-dialog' + (creative.type === 'card' ? ' adp-dialog--card' : ''));
        dialog.setAttribute('role', 'dialog');
        dialog.setAttribute('aria-modal', 'true');
        dialog.setAttribute('aria-labelledby', 'adp-title');
        dialog.setAttribute('aria-describedby', 'adp-desc');
        dialog.tabIndex = -1;
        overlay.appendChild(dialog);

        dialog.appendChild(el('span', 'adp-label', labels.label));

        // Медіа: зображення / відео / постер YouTube; уся область — посилання на рекламодавця.
        var video = null;
        if (creative.type !== 'card') {
            var media = el('div', 'adp-media');
            var mediaLink = el('a', 'adp-media__link');
            mediaLink.href = href;
            mediaLink.target = '_blank';
            mediaLink.rel = 'noopener sponsored';
            mediaLink.tabIndex = -1;
            mediaLink.setAttribute('aria-hidden', 'true');
            if (creative.type === 'upload' && creative.video) {
                video = el('video');
                video.muted = true;
                video.defaultMuted = true;
                video.setAttribute('muted', '');
                video.setAttribute('playsinline', '');
                video.setAttribute('disablepictureinpicture', '');
                video.preload = allowAutoplay ? 'auto' : 'none';
                if (creative.poster) {
                    video.poster = creative.poster;
                }
                if (allowAutoplay) {
                    video.src = creative.video;
                }
                mediaLink.appendChild(video);
            } else {
                var src = creative.poster || (creative.youtube ? 'https://i.ytimg.com/vi/' + encodeURIComponent(creative.youtube) + '/hqdefault.jpg' : '');
                if (src) {
                    var img = el('img');
                    img.alt = '';
                    img.src = src;
                    mediaLink.appendChild(img);
                }
            }
            media.appendChild(mediaLink);
            // YouTube: мініатюра + «відтворити» — програвач youtube-nocookie без звуку вантажиться лише на дію глядача.
            if (creative.type === 'youtube' && creative.youtube) {
                var play = el('button', 'adp-play', '▶');
                play.type = 'button';
                play.setAttribute('aria-label', labels.play);
                play.addEventListener('click', function (e) {
                    e.preventDefault();
                    e.stopPropagation();   // не відкривати рекламодавця
                    var frame = el('iframe');
                    frame.src = 'https://www.youtube-nocookie.com/embed/' + encodeURIComponent(creative.youtube)
                        + '?autoplay=1&mute=1&playsinline=1&rel=0&modestbranding=1';
                    frame.title = creative.title || labels.label;
                    frame.allow = 'autoplay; encrypted-media; picture-in-picture';
                    frame.referrerPolicy = 'strict-origin-when-cross-origin';
                    media.textContent = '';
                    media.appendChild(frame);
                    (dialog.querySelector('.adp-cta') || dialog).focus();
                });
                media.appendChild(play);
            }
            if (video) {
                var sound = el('button', 'adp-sound');
                sound.type = 'button';
                var syncSound = function () {
                    var on = !video.muted;
                    sound.innerHTML = on ? ICON_SOUND : ICON_MUTED;
                    sound.setAttribute('aria-pressed', on ? 'true' : 'false');
                    sound.setAttribute('aria-label', on ? labels.soundOff : labels.soundOn);
                    sound.title = on ? labels.soundOff : labels.soundOn;
                };
                sound.addEventListener('click', function (e) {
                    e.preventDefault();
                    e.stopPropagation();   // не відкривати рекламодавця
                    hideSoundHint();
                    if (!video.getAttribute('src')) {
                        video.src = creative.video;
                    }
                    video.muted = !video.muted;
                    soundPrefSet(video.muted ? 'off' : 'on');
                    if (!video.muted) {
                        silenceOthers();
                        if (video.paused) {
                            video.play().catch(noop);
                        }
                    }
                    syncSound();
                });
                video.addEventListener('volumechange', syncSound);
                syncSound();
                media.appendChild(sound);

                // Підказка «Увімкнути звук», коли браузер не дав стартувати зі звуком.
                var soundHint = null;
                var hideSoundHint = function () {
                    if (soundHint) {
                        soundHint.remove();
                        soundHint = null;
                    }
                };
                var showSoundHint = function () {
                    if (soundHint || !video.muted) {
                        return;
                    }
                    soundHint = el('span', 'adp-sound-hint', labels.soundOn);
                    soundHint.setAttribute('aria-hidden', 'true');   // читачам екрана — aria-label кнопки
                    media.appendChild(soundHint);
                    window.setTimeout(hideSoundHint, 6000);
                };

                // «Відтворити»: коли автостарт вимкнено (saveData, reduced-motion) або його заблокував
                // браузер. Запускає ролик без звуку й не відкриває рекламодавця.
                var videoPlay = null;
                var showVideoPlay = function () {
                    if (videoPlay || !video.paused) {
                        return;
                    }
                    videoPlay = el('button', 'adp-play', '▶');
                    videoPlay.type = 'button';
                    videoPlay.setAttribute('aria-label', labels.play);
                    videoPlay.addEventListener('click', function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                        if (!video.getAttribute('src')) {
                            video.src = creative.video;
                        }
                        video.muted = true;
                        video.play().catch(noop);
                        videoPlay.remove();
                        videoPlay = null;
                        sound.focus();
                    });
                    media.appendChild(videoPlay);
                };
                video.addEventListener('play', function () {
                    if (videoPlay) {
                        videoPlay.remove();
                        videoPlay = null;
                    }
                });
            }
            dialog.appendChild(media);
        }

        var title = el('h2', 'adp-title');
        title.id = 'adp-title';
        var titleLink = el('a', null, creative.title);
        titleLink.href = href;
        titleLink.target = '_blank';
        titleLink.rel = 'noopener sponsored';
        title.appendChild(titleLink);
        dialog.appendChild(title);
        var desc = el('p', 'adp-desc', creative.description || '');
        desc.id = 'adp-desc';
        dialog.appendChild(desc);

        var actions = el('div', 'adp-actions');
        var cta = el('a', 'adp-cta', creative.cta);
        cta.href = href;
        cta.target = '_blank';
        cta.rel = 'noopener sponsored';
        actions.appendChild(cta);
        var skip = el('button', 'adp-skip');
        skip.type = 'button';
        skip.disabled = true;
        skip.setAttribute('aria-disabled', 'true');
        actions.appendChild(skip);
        dialog.appendChild(actions);
        var live = el('p', 'adp-sr');
        live.setAttribute('aria-live', 'polite');
        dialog.appendChild(live);

        var restoreScroll = lockScroll();
        document.body.appendChild(overlay);
        dialog.focus();

        // Відлік «Пропустити»: стартує з відтворенням медіа, рахує лише видимий час вкладки.
        var left = skipDelay;
        var leftMs = skipDelay * 1000;
        var ready = false;
        var started = false;
        var shownMs = 0;          // видимий час від старту відліку (автозакриття без відео)
        var impressionMs = 0;     // видимий час відтворення (без відео — видимий час вікна)
        var impressionSent = false;
        // 'video' — показ рахується, поки ролик грає; 'still' — поки вікно видно.
        var impressionMode = video && allowAutoplay ? 'video' : 'still';
        function renderSkip() {
            skip.textContent = ready ? labels.skip : labels.skipIn.replace('%d', String(left));
        }
        renderSkip();
        live.textContent = labels.skipIn.replace('%d', String(left));
        function startCountdown() {
            started = true;
        }
        var lastTick = Date.now();
        var timer = window.setInterval(function () {
            var now = Date.now();
            var dt = now - lastTick;
            lastTick = now;
            if (document.visibilityState !== 'visible') {
                return;
            }
            if (!impressionSent) {
                var playingNow = video && !video.paused && !video.ended && video.readyState > 2;
                if (impressionMode === 'still' || playingNow) {
                    impressionMs += dt;
                    if (impressionMs >= 1000) {
                        impressionSent = true;
                        sendEvents([{ t: creative.token, type: 'impression' }]);
                    }
                }
            }
            if (!started) {
                return;
            }
            if (!ready) {
                leftMs -= dt;
                var sec = Math.max(0, Math.ceil(leftMs / 1000));
                if (sec !== left) {
                    left = sec;
                    if (left <= 0) {
                        ready = true;
                        skip.disabled = false;
                        skip.removeAttribute('aria-disabled');
                        live.textContent = labels.skipReady;
                    } else if (left === 5) {
                        live.textContent = labels.skipIn.replace('%d', String(left));
                    }
                    renderSkip();
                }
            }
            // Без відео (зображення, картка): вікно закривається саме через creative.display с.
            shownMs += dt;
            if (ready && creative.display && shownMs >= creative.display * 1000) {
                close(true);
            }
        }, 250);

        // Прихована вкладка: відео на паузі (відлік стоїть сам), повернулись — грає далі.
        var pausedByHide = false;
        function onVisibility() {
            lastTick = Date.now();
            if (!video) {
                return;
            }
            if (document.visibilityState !== 'visible') {
                if (!video.paused) {
                    pausedByHide = true;
                    video.pause();
                }
            } else if (pausedByHide) {
                pausedByHide = false;
                video.play().catch(noop);
            }
        }
        document.addEventListener('visibilitychange', onVisibility);

        // Звучить лише одне відео: інші медіа зі звуком — на паузу; почало звучати інше — наше без звуку.
        function silenceOthers() {
            Array.prototype.forEach.call(document.querySelectorAll('video, audio'), function (m) {
                if (m !== video && !m.paused && !m.muted) {
                    m.pause();
                }
            });
        }
        function onOtherPlay(e) {
            var m = e.target;
            if (video && m !== video && !m.muted && !video.muted) {
                video.muted = true;
            }
        }
        document.addEventListener('play', onOtherPlay, true);

        if (video) {
            // Коротше за відлік — повторюється; після відліку — дограє й зупиняється.
            video.addEventListener('ended', function () {
                if (!ready) {
                    video.currentTime = 0;
                    video.play().catch(noop);
                }
            });
            video.addEventListener('playing', startCountdown);
            if (allowAutoplay) {
                window.setTimeout(function () {
                    if (!started) {
                        startCountdown();
                        showVideoPlay();   // так і не стартувало — глядач може запустити сам
                    }
                }, START_FALLBACK_MS);
                var failed = function () {
                    // Не дали навіть без звуку — постер і «▶»; показ і відлік — як для зображення.
                    impressionMode = 'still';
                    startCountdown();
                    showVideoPlay();
                };
                var playMuted = function () {
                    video.muted = true;
                    return video.play();
                };
                var activated = !!(navigator.userActivation && navigator.userActivation.hasBeenActive);
                if (activated && soundPref() !== 'off') {
                    video.muted = false;
                    silenceOthers();
                    video.play().catch(function () {
                        playMuted().then(showSoundHint, failed);
                    });
                } else {
                    playMuted().catch(failed);
                }
            } else {
                showVideoPlay();
                startCountdown();
            }
        } else {
            startCountdown();
        }

        function close(auto) {
            if (!ready) {
                return;
            }
            window.clearInterval(timer);
            sendEvents([{ t: creative.token, type: auto === true ? 'close' : 'skip' }]);
            lsSet(Math.floor(Date.now() / 1000));
            if (video) {
                video.pause();
            }
            document.removeEventListener('visibilitychange', onVisibility);
            document.removeEventListener('play', onOtherPlay, true);
            document.removeEventListener('keydown', onKey, true);
            overlay.remove();
            restoreScroll();
            if (opener && opener.focus && document.contains(opener)) {
                opener.focus();
            }
        }

        function onKey(e) {
            if (e.key === 'Escape') {
                e.preventDefault();
                close();   // до кінця відліку нічого не робить
                return;
            }
            if (e.key !== 'Tab') {
                return;
            }
            // Фокус не виходить за межі вікна.
            var f = Array.prototype.filter.call(dialog.querySelectorAll('a[href], button:not([disabled])'), function (n) {
                return n.tabIndex !== -1 && n.offsetParent !== null;
            });
            if (!f.length) {
                e.preventDefault();
                dialog.focus();
                return;
            }
            var first = f[0];
            var last = f[f.length - 1];
            if (e.shiftKey && (document.activeElement === first || document.activeElement === dialog)) {
                e.preventDefault();
                last.focus();
            } else if (!e.shiftKey && document.activeElement === last) {
                e.preventDefault();
                first.focus();
            } else if (!dialog.contains(document.activeElement)) {
                e.preventDefault();
                first.focus();
            }
        }
        document.addEventListener('keydown', onKey, true);
        skip.addEventListener('click', close);
        // Клік по фону вікно не закриває (і до, і після відліку — лише «Пропустити»).
        overlay.addEventListener('click', function (e) {
            if (e.target === overlay) {
                dialog.focus();
            }
        });
    }

    // Перша сторінка візиту — вікна немає взагалі (наступна сторінка почне знову).
    if (cfg.wait === null || cfg.wait === undefined) {
        return;
    }
    if (document.readyState === 'complete') {
        attempt();
    } else {
        window.addEventListener('load', attempt);
    }
})();
