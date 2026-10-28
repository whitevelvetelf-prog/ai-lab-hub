/* AI LAB HUB — реклама спливаючим вікном (app/ad-popup.php → /ad-next.php).
 *
 *   * Правила з #ad-popup-config (сервер) + localStorage: вікно не раніше другої сторінки
 *     візиту й 5 хв від його початку, не частіше ніж раз на interval с від закриття
 *     попереднього (час закриття — у localStorage і в сесії на сервері; береться пізніший).
 *     localStorage недоступний — лише серверна сесія.
 *   * Поки фокус у полі вводу або в полі є текст (пошук, чат Елі) — чекаємо. На сторінці з видимим
 *     полем пароля, після надсилання форми і поки body[data-promo-suppress] (сторінки входу,
 *     тиша після входу / реєстрації / виходу — app/promo-quiet.php) — вікна немає зовсім.
 *   * Вікно: role="dialog", aria-modal, фокус усередині (Tab циклічно), фон затемнено й
 *     не прокручується (позиція прокрутки повертається після закриття). Угорі — бейдж
 *     «Реклама» і «Пропустити» (правий кут): недоступна skip с (5–15) зі зворотним відліком
 *     (aria-live polite); до кінця відліку вікно не закривається ні фоном, ні Esc. Після —
 *     «Пропустити» або Esc. Поява й зникнення — CSS-анімація (reduced-motion — без неї).
 *   * Власна реклама (картка) — без зображення з текстом: блок оформлення (градієнт теми
 *     creative.theme sky|mint|sun + inline SVG, іконка creative.icon megaphone|bag).
 *   * Клік по рекламі — /promo-click.php у новій вкладці; вікно лишається відкритим.
 *   * Відео стартує само. Зі звуком — лише якщо глядач уже взаємодіяв зі сторінкою
 *     (navigator.userActivation.hasBeenActive) і не вимикав звук раніше; браузер не дав —
 *     одразу без звуку (muted, playsinline) і підказка «Увімкнути звук» біля динаміка.
 *     Кнопка-динамік завжди є; вибір глядача — у localStorage (alh_ad_popup_sound: on|off),
 *     вимкнув — автоматично звук більше не вмикається. Звучить лише одне відео на сторінці.
 *     Ролик грає ОДИН раз (без циклу й без повторного автозапуску): після завершення — кінцева
 *     картка поверх кадру («Реклама», кнопка рекламодавця, «Переглянути ще раз» — лише кліком і без
 *     звуку; повтор не рахується ні як показ, ні як перегляд). YouTube після завершення прибирається,
 *     щоб не показувати чужі рекомендовані відео. Відлік «Пропустити» йде своїм ходом.
 *     prefers-reduced-motion — відео однаково стартує само, але завжди без звуку.
 *     saveData (або браузер не дав навіть без звуку) — постер і «▶»: ролик стартує без звуку лише
 *     на дію глядача.
 *   * YouTube: плеєр через IFrame Player API (хост youtube-nocookie.com, скрипт API вантажиться лише
 *     коли відкривається вікно з YouTube), стартує сам БЕЗ звуку; звук — лише кнопкою-динаміком.
 *     Браузер заблокував автозапуск / скрипт YouTube заблоковано / saveData —
 *     мініатюра й «▶». Помилка відео (2, 5, 100, 101, 150 — приватне, видалене, вбудовування
 *     заборонене) — лише мініатюра, вікно працює як із зображенням.
 *   * Відлік «Пропустити» йде з початку відтворення (зображення, картка, постер — одразу; відео не
 *     стартувало за 3–5 с — теж). У прихованій вкладці відлік і відео на паузі.
 *   * Адмін з ?promo_debug=1 (cfg.debug) бачить у консолі стан плеєра, події й помилки.
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
    var YT_HOST = 'https://www.youtube-nocookie.com';
    var YT_START_FALLBACK_MS = 5000;   // YouTube: API ще вантажиться — відлік однаково йде
    var YT_BLOCKED_MS = 2500;          // плеєр готовий, але не заграв — автозапуск заблоковано
    var YT_BUFFER_MAX_MS = 8000;       // …якщо ще буферизується — чекаємо до стількох

    var reduceMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var saveData = !!(navigator.connection && navigator.connection.saveData);
    // reduced-motion не вимикає автозапуск (у Windows його вмикає вимкнена анімація системи, часто заради
    // швидкодії): відео стартує, але лише без звуку; вимикається тільки анімація вікна.
    var allowAutoplay = !saveData;

    function noop() {}

    function debug() {
        if (cfg && cfg.debug && window.console) {
            console.log.apply(console, ['[ad-popup]'].concat(Array.prototype.slice.call(arguments)));
        }
    }

    // YouTube IFrame Player API — один раз на сторінку й лише коли потрібен.
    var ytApi = null;
    function loadYouTubeApi() {
        if (ytApi) {
            return ytApi;
        }
        ytApi = new Promise(function (resolve, reject) {
            if (window.YT && window.YT.Player) {
                resolve(window.YT);
                return;
            }
            var prev = window.onYouTubeIframeAPIReady;
            window.onYouTubeIframeAPIReady = function () {
                if (typeof prev === 'function') {
                    prev();
                }
                resolve(window.YT);
            };
            var s = document.createElement('script');
            s.src = 'https://www.youtube.com/iframe_api';
            s.async = true;
            s.onerror = function () {
                reject(new Error('YouTube API не завантажився'));
            };
            document.head.appendChild(s);
            window.setTimeout(function () {
                reject(new Error('YouTube API: тайм-аут'));
            }, 8000);
        });
        ytApi.catch(function () {
            ytApi = null;   // наступне вікно спробує ще раз
        });
        return ytApi;
    }

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
        var fields = document.querySelectorAll('input[type="search"], input[type="text"], input[type="email"], input[type="tel"], input[type="url"], input:not([type]), textarea');
        for (var i = 0; i < fields.length; i++) {
            if (fields[i].value && fields[i].value.trim() !== '' && fields[i].offsetParent !== null) {
                return true;
            }
        }
        return false;
    }

    var shown = false;
    var submitting = false;
    // Форму надсилають — сторінка от-от зміниться, вікно не потрібне (вхід, реєстрація, будь-яка форма).
    document.addEventListener('submit', function () { submitting = true; }, true);

    function suppressed() {
        if (submitting || (document.body && document.body.hasAttribute('data-promo-suppress'))) {
            return true;
        }
        var pw = document.querySelectorAll('input[type="password"]');
        for (var i = 0; i < pw.length; i++) {
            if (pw[i].offsetParent !== null) {
                return true;
            }
        }
        return false;
    }

    function attempt() {
        if (shown || suppressed()) {
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
                if (payload && payload.creative && payload.labels && !suppressed() && !typing()) {
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
    var THEMES = ['sky', 'mint', 'sun'];
    var HERO_ICONS = {
        megaphone: '<path d="M3 11l18-5v12L3 14v-3z"/><path d="M11.6 16.8a3 3 0 1 1-5.8-1.6"/>',
        bag: '<path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><path d="M3 6h18"/><path d="M16 10a4 4 0 0 1-8 0"/>'
    };

    /** Зірочка-іскра з центром (x, y) і «радіусом» r. */
    function sparkle(x, y, r, fill, opacity) {
        return '<path fill="' + fill + '" opacity="' + opacity + '" d="M' + x + ' ' + (y - r) + 'Q' + x + ' ' + y + ' ' + (x + r) + ' ' + y
            + 'Q' + x + ' ' + y + ' ' + x + ' ' + (y + r) + 'Q' + x + ' ' + y + ' ' + (x - r) + ' ' + y + 'Q' + x + ' ' + y + ' ' + x + ' ' + (y - r) + 'Z"/>';
    }

    /** Блок оформлення картки: м'які кола й зірочки (без тексту) та іконка, що повільно «пливе». */
    function heroBlock(theme, icon) {
        var star = theme === 'sun' ? '#ffffff' : '#ffc83d';
        var hero = el('div', 'adp-hero');
        hero.innerHTML = '<svg class="adp-hero__decor" viewBox="0 0 480 148" preserveAspectRatio="xMidYMid slice" focusable="false">'
            + '<circle cx="54" cy="136" r="92" fill="#fff" opacity=".22"/>'
            + '<circle cx="438" cy="6" r="84" fill="#fff" opacity=".2"/>'
            + '<circle cx="392" cy="128" r="36" fill="#fff" opacity=".18"/>'
            + '<circle cx="158" cy="24" r="18" fill="#fff" opacity=".24"/>'
            + sparkle(112, 62, 11, star, '.95') + sparkle(340, 46, 9, '#fff', '.9')
            + sparkle(306, 114, 6, star, '.85') + sparkle(196, 116, 5, '#fff', '.8')
            + '</svg>'
            + '<span class="adp-hero__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" '
            + 'stroke-linecap="round" stroke-linejoin="round" focusable="false">' + (HERO_ICONS[icon] || HERO_ICONS.megaphone) + '</svg></span>';
        return hero;
    }

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
        var skipDelay = Math.max(5, Math.min(15, parseInt(creative.skip, 10) || 5));
        var opener = document.activeElement;

        var overlay = el('div', 'adp-overlay');
        var theme = THEMES.indexOf(creative.theme) >= 0 ? creative.theme : THEMES[(parseInt(creative.id, 10) || 0) % THEMES.length];
        var dialog = el('div', 'adp-dialog' + (creative.type === 'card' ? ' adp-dialog--card adp-theme--' + theme : ''));
        dialog.setAttribute('role', 'dialog');
        dialog.setAttribute('aria-modal', 'true');
        dialog.setAttribute('aria-labelledby', 'adp-title');
        dialog.setAttribute('aria-describedby', 'adp-desc');
        dialog.tabIndex = -1;
        overlay.appendChild(dialog);

        // Угорі: бейдж «Реклама» ліворуч, «Пропустити» в правому куті (видно завжди).
        var head = el('div', 'adp-head');
        head.appendChild(el('span', 'adp-label', labels.label));
        var skip = el('button', 'adp-skip');
        skip.type = 'button';
        skip.disabled = true;
        skip.setAttribute('aria-disabled', 'true');
        head.appendChild(skip);
        dialog.appendChild(head);

        // Власна реклама: блок оформлення без тексту; клік по ньому — як по рекламі.
        if (creative.type === 'card') {
            var heroLink = el('a', 'adp-hero-link');
            heroLink.href = href;
            heroLink.target = '_blank';
            heroLink.rel = 'noopener sponsored';
            heroLink.tabIndex = -1;
            heroLink.setAttribute('aria-hidden', 'true');
            heroLink.appendChild(heroBlock(theme, creative.icon));
            dialog.appendChild(heroLink);
        }

        // Медіа: зображення / відео / постер YouTube; уся область — посилання на рекламодавця.
        var video = null;
        var ytBox = null;
        var media = null;
        if (creative.type !== 'card') {
            media = el('div', 'adp-media');
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
            // YouTube: поки що мініатюра; плеєр (нижче, після відліку) кладеться поверх неї.
            if (creative.type === 'youtube' && creative.youtube) {
                ytBox = media;
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

                // «Відтворити»: коли автостарт вимкнено (saveData) або його заблокував
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
        dialog.appendChild(actions);
        var live = el('p', 'adp-sr');
        live.setAttribute('aria-live', 'polite');
        dialog.appendChild(live);

        // Кінцева картка після завершення ролика (і для файлу, і для YouTube).
        var endCard = null;
        function showEndCard(onReplay) {
            if (endCard || !media) {
                return;
            }
            endCard = el('div', 'adp-end');
            endCard.appendChild(el('span', 'adp-end__label', labels.label));
            var endCta = el('a', 'adp-end__cta', creative.cta);
            endCta.href = href;
            endCta.target = '_blank';
            endCta.rel = 'noopener sponsored';
            endCard.appendChild(endCta);
            var replay = el('button', 'adp-end__replay', labels.replay || '↻');
            replay.type = 'button';
            replay.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();   // не відкривати рекламодавця
                hideEndCard();
                onReplay();
            });
            endCard.appendChild(replay);
            media.appendChild(endCard);
            debug('відео завершено — кінцева картка');
        }
        function hideEndCard() {
            if (endCard) {
                endCard.remove();
                endCard = null;
            }
        }

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
        var impressionMode = (video || ytBox) && allowAutoplay ? 'video' : 'still';
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
                var playingNow = (video && !video.paused && !video.ended && video.readyState > 2) || ytPlaying;
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
            if (yt && yt.pauseVideo) {
                if (document.visibilityState !== 'visible') {
                    if (ytPlaying) {
                        pausedByHide = true;
                        yt.pauseVideo();
                    }
                } else if (pausedByHide) {
                    pausedByHide = false;
                    yt.playVideo();
                }
                return;
            }
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
            if (yt && yt.isMuted && !m.muted && !yt.isMuted()) {
                yt.mute();
                ytSyncSound();
            }
        }
        document.addEventListener('play', onOtherPlay, true);

        // --- YouTube (IFrame Player API) --------------------------------------------
        var yt = null;
        var ytPlaying = false;
        var ytFrame = null;
        var ytPlayBtn = null;
        var ytSound = null;
        var ytApiFailed = false;
        var ytBlockedTimer = 0;
        var ytState = -1;
        var ytReadyAt = 0;

        function ytSyncSound() {
            if (!ytSound || !yt || !yt.isMuted) {
                return;
            }
            var on = !yt.isMuted();
            ytSound.innerHTML = on ? ICON_SOUND : ICON_MUTED;
            ytSound.setAttribute('aria-pressed', on ? 'true' : 'false');
            ytSound.setAttribute('aria-label', on ? labels.soundOff : labels.soundOn);
            ytSound.title = on ? labels.soundOff : labels.soundOn;
        }
        function ytEnsureSound() {
            if (ytSound) {
                return;
            }
            ytSound = el('button', 'adp-sound');
            ytSound.type = 'button';
            ytSound.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                if (!yt || !yt.isMuted) {
                    return;
                }
                if (yt.isMuted()) {
                    silenceOthers();
                    yt.unMute();
                    soundPrefSet('on');
                } else {
                    yt.mute();
                    soundPrefSet('off');
                }
                window.setTimeout(ytSyncSound, 150);
            });
            ytBox.appendChild(ytSound);
            ytSyncSound();
        }
        function ytPlainFrame() {
            // Скрипт YouTube заблоковано: простий програвач без звуку (як раніше), лише на дію глядача.
            var frame = el('iframe', 'adp-yt');
            frame.src = YT_HOST + '/embed/' + encodeURIComponent(creative.youtube) + '?autoplay=1&mute=1&playsinline=1&rel=0&modestbranding=1';
            frame.title = creative.title || labels.label;
            frame.allow = 'autoplay; encrypted-media; picture-in-picture; fullscreen';
            frame.referrerPolicy = 'strict-origin-when-cross-origin';
            ytBox.appendChild(frame);
        }
        function ytShowPlay() {
            if (ytPlayBtn || ytPlaying) {
                return;
            }
            ytPlayBtn = el('button', 'adp-play', '▶');
            ytPlayBtn.type = 'button';
            ytPlayBtn.setAttribute('aria-label', labels.play);
            ytPlayBtn.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();   // не відкривати рекламодавця
                ytPlayBtn.remove();
                ytPlayBtn = null;
                if (yt && yt.playVideo) {
                    yt.mute();
                    yt.playVideo();
                } else if (ytApiFailed) {
                    ytPlainFrame();
                } else {
                    ytStart();
                }
            });
            ytBox.appendChild(ytPlayBtn);
        }
        function ytRemove() {
            window.clearTimeout(ytBlockedTimer);
            try {
                if (yt && yt.destroy) {
                    yt.destroy();
                }
            } catch (e) {
                // плеєр уже непридатний
            }
            if (ytFrame && ytFrame.parentNode) {
                ytFrame.remove();
            }
            yt = null;
            ytFrame = null;
            ytPlaying = false;
            ytState = -1;
            if (ytSound) {
                ytSound.remove();
                ytSound = null;
            }
        }
        function ytFail(reason, canPlay) {
            debug('YouTube: без плеєра —', reason);
            window.clearTimeout(ytBlockedTimer);
            try {
                if (yt && yt.destroy) {
                    yt.destroy();
                }
            } catch (e) {
                // плеєр і так непридатний
            }
            if (ytFrame && ytFrame.parentNode) {
                ytFrame.remove();
            }
            yt = null;
            ytFrame = null;
            ytPlaying = false;
            if (ytSound) {
                ytSound.remove();
                ytSound = null;
            }
            impressionMode = 'still';
            startCountdown();
            if (canPlay) {
                ytShowPlay();
            }
        }
        function ytStart() {
            loadYouTubeApi().then(function (YT) {
                if (closing || yt) {
                    return;
                }
                debug('YouTube API готовий, відео', creative.youtube);
                ytFrame = el('iframe', 'adp-yt');
                ytFrame.src = YT_HOST + '/embed/' + encodeURIComponent(creative.youtube) + '?' + new URLSearchParams({
                    autoplay: '0', mute: '1', playsinline: '1', controls: '1', rel: '0', modestbranding: '1',
                    iv_load_policy: '3', fs: '1', enablejsapi: '1', origin: window.location.origin
                }).toString();
                ytFrame.title = creative.title || labels.label;
                ytFrame.allow = 'autoplay; encrypted-media; picture-in-picture; fullscreen';
                ytFrame.referrerPolicy = 'strict-origin-when-cross-origin';
                ytFrame.setAttribute('allowfullscreen', '');
                ytBox.appendChild(ytFrame);
                yt = new YT.Player(ytFrame, {
                    events: {
                        onReady: function () {
                            debug('YouTube: onReady, запуск без звуку');
                            if (cfg.debug) {
                                window.__adpYt = yt;   // діагностика адміна: керувати плеєром з консолі
                            }
                            yt.mute();
                            yt.playVideo();
                            ytReadyAt = Date.now();
                            var checkBlocked = function () {
                                if (ytPlaying) {
                                    return;
                                }
                                // Буферизується (повільна мережа) — це не блокування, чекаємо ще.
                                if (ytState === YT.PlayerState.BUFFERING && Date.now() - ytReadyAt < YT_BUFFER_MAX_MS) {
                                    ytBlockedTimer = window.setTimeout(checkBlocked, 500);
                                    return;
                                }
                                debug('YouTube: не заграв (стан', ytState, ') — автозапуск заблоковано');
                                impressionMode = 'still';
                                startCountdown();
                                ytShowPlay();
                            };
                            ytBlockedTimer = window.setTimeout(checkBlocked, YT_BLOCKED_MS);
                        },
                        onStateChange: function (ev) {
                            debug('YouTube: стан', ev.data);
                            ytState = ev.data;
                            ytPlaying = ev.data === YT.PlayerState.PLAYING;
                            if (ytPlaying) {
                                window.clearTimeout(ytBlockedTimer);
                                impressionMode = 'video';
                                if (ytPlayBtn) {
                                    ytPlayBtn.remove();
                                    ytPlayBtn = null;
                                }
                                startCountdown();
                                ytEnsureSound();
                            } else if (ev.data === YT.PlayerState.ENDED) {
                                // Один раз: плеєр прибираємо (без рекомендацій YouTube), лишається мініатюра.
                                ytRemove();
                                showEndCard(function () {
                                    ytStart();   // лише кліком, без звуку
                                });
                            }
                        },
                        onAutoplayBlocked: function () {
                            debug('YouTube: onAutoplayBlocked');
                            window.clearTimeout(ytBlockedTimer);
                            impressionMode = 'still';
                            startCountdown();
                            ytShowPlay();
                        },
                        onError: function (ev) {
                            // 2 — некоректний ID, 5 — помилка HTML5-плеєра, 100 — видалене / приватне,
                            // 101 / 150 — автор заборонив вбудовування.
                            ytFail('помилка плеєра ' + ev.data, ev.data === 5);
                        }
                    }
                });
            }, function (err) {
                ytApiFailed = true;
                ytFail(err && err.message ? err.message : 'API', true);
            });
        }

        if (ytBox) {
            if (allowAutoplay) {
                window.setTimeout(function () {
                    if (!started) {
                        debug('YouTube: не стартував за', YT_START_FALLBACK_MS, 'мс — відлік іде');
                        impressionMode = 'still';
                        startCountdown();
                    }
                }, YT_START_FALLBACK_MS);
                ytStart();
            } else {
                // saveData — плеєр лише на дію глядача.
                ytShowPlay();
                startCountdown();
            }
        } else if (video) {
            // Один раз: після завершення — кінцева картка, жодного автоматичного повтору.
            video.addEventListener('ended', function () {
                hideSoundHint();
                showEndCard(function () {
                    video.muted = true;   // повтор без звуку; звук — динаміком
                    video.currentTime = 0;
                    video.play().catch(noop);
                });
            });
            video.addEventListener('play', hideEndCard);
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
                if (activated && soundPref() !== 'off' && !reduceMotion) {
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

        var closing = false;
        function close(auto) {
            if (!ready || closing) {
                return;
            }
            closing = true;
            window.clearInterval(timer);
            sendEvents([{ t: creative.token, type: auto === true ? 'close' : 'skip' }]);
            lsSet(Math.floor(Date.now() / 1000));
            if (video) {
                video.pause();
            }
            window.clearTimeout(ytBlockedTimer);
            if (yt && yt.pauseVideo) {
                yt.pauseVideo();
            }
            document.removeEventListener('visibilitychange', onVisibility);
            document.removeEventListener('play', onOtherPlay, true);
            document.removeEventListener('keydown', onKey, true);
            var finish = function () {
                if (!overlay.parentNode) {
                    return;
                }
                overlay.remove();
                restoreScroll();
                if (opener && opener.focus && document.contains(opener)) {
                    opener.focus();
                }
            };
            if (reduceMotion) {
                finish();
                return;
            }
            // Зникнення 150 мс (CSS); запасний таймер — якщо animationend не прийде.
            overlay.classList.add('adp-overlay--out');
            overlay.addEventListener('animationend', function (e) {
                if (e.target === overlay) {
                    finish();
                }
            });
            window.setTimeout(finish, 200);
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
