/* AI LAB HUB — реклама (.sponsored-card): нативні картки в списках і блоки на сторінках.
 *
 *   * Нативні картки (app/ad-card.php, .sponsored-slot[data-native]) приходять готовими з
 *     сервера разом із JSON до 5 креативів; тут лише оживлюються. Інші слоти (app/promo.php
 *     → promo_slot) порожні й приховані: креативи питаються в /promo-serve.php; немає
 *     реклами (204) — слот лишається прихованим, порожнього місця немає.
 *   * Ротація: слот крутить свої креативи — відео змінюється після VIDEO_PLAYS відтворень
 *     (якщо глядач не ввімкнув звук), зображення й картки — кожні ROTATE_MS видимого часу.
 *     Креативи не повторюються на сторінці (exclude для наступних запитів).
 *   * Відео: muted + playsinline; src підставляється лише поблизу екрана (до того —
 *     постер). Автозапуск лише коли картка видима (≥50%), пауза поза екраном. Звук
 *     ніколи не вмикається сам — кнопка-динамік; звук грає лише в одному ролику, клік
 *     по кнопці не відкриває сторінку рекламодавця. saveData або prefers-reduced-motion —
 *     постер + «відтворити», без автозапуску.
 *   * YouTube: постер-заглушка, iframe youtube-nocookie.com вантажиться лише після
 *     натискання (без звуку). Для YouTube рахуються лише покази й кліки.
 *   * Облік: impression — ≥50% площі видно ≥1 с, один раз на креатив за завантаження
 *     сторінки; view — ≥3 с відтворення (лише власне відео). Події збираються в пакет і
 *     йдуть одним navigator.sendBeacon на /promo-event.php (раз на FLUSH_MS, а також коли
 *     вкладку ховають чи закривають); клік — тільки через /promo-click.php?t=ТОКЕН.
 *   * Слот вище видимої області — прокрутка компенсується на висоту картки (без стрибка).
 *   * data-preview="1" (адмін із ?promo_preview=1) — креатив тестової кампанії, події
 *     не надсилаються.
 *   * Увесь текст із сервера вставляється через textContent (без HTML).
 */
(function () {
    'use strict';

    var SERVE = '/promo-serve.php';
    var EVENT = '/promo-event.php';
    var CLICK = '/promo-click.php';
    var REPORT = '/promo-report.php';

    /** Зображення й картки змінюються кожні ROTATE_MS видимого часу. */
    var ROTATE_MS = 15000;
    /** Відео змінюється після стількох відтворень (перше + повтор). */
    var VIDEO_PLAYS = 2;
    /** Відео вантажиться заздалегідь, коли картка ближче за цю відстань до екрана. */
    var NEAR_MARGIN = '300px 0px';
    /** Пакет подій відправляється не рідше ніж раз на FLUSH_MS (і при закритті вкладки). */
    var FLUSH_MS = 3000;
    var BATCH_MAX = 20;

    var reduceMotion = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var saveData = !!(navigator.connection && navigator.connection.saveData);
    var allowAutoplay = !reduceMotion && !saveData;

    function noop() {}

    function deviceType() {
        var mobile = window.matchMedia && (window.matchMedia('(max-width: 768px)').matches || window.matchMedia('(pointer: coarse)').matches);
        return mobile ? 'mobile' : 'desktop';
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

    // --- Події: пакет через sendBeacon ---------------------------------------

    var queue = [];
    var flushTimer = null;

    function flush() {
        if (flushTimer !== null) {
            window.clearTimeout(flushTimer);
            flushTimer = null;
        }
        while (queue.length) {
            var data = new FormData();
            data.append('events', JSON.stringify(queue.splice(0, BATCH_MAX)));
            if (!(navigator.sendBeacon && navigator.sendBeacon(EVENT, data))) {
                fetch(EVENT, { method: 'POST', body: data, credentials: 'same-origin', keepalive: true }).catch(noop);
            }
        }
    }

    function sendEvent(token, type) {
        queue.push({ t: token, type: type });
        if (queue.length >= BATCH_MAX) {
            flush();
        } else if (flushTimer === null) {
            flushTimer = window.setTimeout(flush, FLUSH_MS);
        }
    }

    document.addEventListener('visibilitychange', function () {
        if (document.visibilityState === 'hidden') {
            flush();
        }
    });
    window.addEventListener('pagehide', flush);

    // --- Звук: лише один ролик на сторінці грає зі звуком -----------------

    var ICON_MUTED = '<svg viewBox="0 0 24 24" width="20" height="20" aria-hidden="true" focusable="false">'
        + '<path fill="currentColor" d="M3 9v6h4l5 5V4L7 9H3z"/>'
        + '<path d="M16 9l5 6M21 9l-5 6" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>';
    var ICON_SOUND = '<svg viewBox="0 0 24 24" width="20" height="20" aria-hidden="true" focusable="false">'
        + '<path fill="currentColor" d="M3 9v6h4l5 5V4L7 9H3z"/>'
        + '<path d="M15.5 8.5a5 5 0 0 1 0 7M18.5 5.5a9 9 0 0 1 0 13" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>';

    var soundOwner = null;   // відео, яке зараз зі звуком

    function releaseSound(video) {
        if (soundOwner === video) {
            soundOwner = null;
        }
        if (!video.muted) {
            video.muted = true;
        }
    }

    /**
     * Кнопка-динамік: клік вмикає звук (і вимикає його в іншому ролику), повторний —
     * вимикає. Клік не відкриває сторінку рекламодавця. Звук сам не вмикається ніколи —
     * браузери блокують автозвук. beforePlay — підвантажити відео, якщо ще не завантажене.
     */
    function soundButton(video, labels, beforePlay) {
        var btn = el('button', 'sponsored-card__sound');
        btn.type = 'button';
        function sync() {
            var on = !video.muted;
            btn.innerHTML = on ? ICON_SOUND : ICON_MUTED;
            btn.setAttribute('aria-pressed', on ? 'true' : 'false');
            btn.setAttribute('aria-label', on ? labels.soundOff : labels.soundOn);
            btn.title = on ? labels.soundOff : labels.soundOn;
        }
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            e.stopPropagation();
            if (video.muted) {
                if (soundOwner && soundOwner !== video) {
                    soundOwner.muted = true;
                }
                soundOwner = video;
                if (beforePlay) {
                    beforePlay();
                }
                video.muted = false;
                if (video.paused) {
                    video.play().catch(noop);
                }
            } else {
                releaseSound(video);
            }
            sync();
        });
        video.addEventListener('volumechange', sync);
        sync();

        return btn;
    }

    // ≥3 с реального відтворення → одна подія view.
    function trackView(video, onView) {
        var played = 0;
        var last = null;
        var viewSent = false;
        video.addEventListener('timeupdate', function () {
            if (viewSent || video.paused || video.seeking) {
                last = video.currentTime;
                return;
            }
            if (last !== null) {
                var delta = video.currentTime - last;
                if (delta > 0 && delta < 1.5) {
                    played += delta;
                }
            }
            last = video.currentTime;
            if (played >= 3) {
                viewSent = true;
                onView();
            }
        });
        video.addEventListener('seeking', function () { last = null; });
    }

    // --- Медіа ----------------------------------------------------------------

    /**
     * Відео: src лише поблизу екрана (near) або при діях глядача, до того — постер; старт
     * без звуку, коли картка видима; пауза поза екраном. Кілька креативів у слоті — після
     * VIDEO_PLAYS відтворень onDone() (ротація), якщо глядач не ввімкнув звук.
     */
    function wireVideo(video, media, labels, rotating, onView, onDone) {
        var loaded = false;
        var play = null;
        var plays = 0;
        function load() {
            if (!loaded) {
                loaded = true;
                video.preload = 'metadata';
                video.src = video.getAttribute('data-src');
            }
        }
        function showPlay() {
            if (play) {
                return;
            }
            play = el('button', 'sponsored-card__play', '▶');
            play.type = 'button';
            play.setAttribute('aria-label', labels.play);
            play.addEventListener('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                play.remove();
                play = null;
                load();
                video.play().catch(noop);
            });
            media.appendChild(play);
        }
        video.muted = true;
        video.defaultMuted = true;
        video.setAttribute('muted', '');
        video.setAttribute('playsinline', '');
        if (rotating) {
            video.removeAttribute('loop');
            video.addEventListener('ended', function () {
                plays++;
                if (plays >= VIDEO_PLAYS && video.muted) {
                    onDone();
                } else {
                    video.currentTime = 0;
                    video.play().catch(noop);
                }
            });
        } else {
            video.setAttribute('loop', '');
        }
        media.appendChild(soundButton(video, labels, load));
        if (!allowAutoplay) {
            showPlay();
        }
        trackView(video, onView);

        return {
            near: function () {
                if (allowAutoplay) {
                    load();
                }
            },
            visible: function (isVisible) {
                if (isVisible && allowAutoplay) {
                    load();
                    // Браузер заборонив автозапуск (енергозбереження) — кнопка «відтворити».
                    video.play().catch(showPlay);
                } else if (!isVisible && !video.paused) {
                    video.pause();
                }
            },
            // Відео, що грає, саме керує ротацією; на паузі (без автозапуску) — як зображення.
            timed: function () {
                return video.paused;
            },
            stop: function () {
                video.pause();
                releaseSound(video);
                video.removeAttribute('src');
                video.load();
            }
        };
    }

    function buildYoutube(media, creative, labels) {
        var poster = el('img');
        poster.alt = '';
        poster.loading = 'lazy';
        poster.src = creative.poster || ('https://i.ytimg.com/vi/' + encodeURIComponent(creative.youtube) + '/hqdefault.jpg');
        media.appendChild(poster);

        var opened = false;
        var play = el('button', 'sponsored-card__play', '▶');
        play.type = 'button';
        play.setAttribute('aria-label', labels.play);
        play.addEventListener('click', function (e) {
            e.preventDefault();
            e.stopPropagation();
            opened = true;
            var frame = el('iframe');
            frame.src = 'https://www.youtube-nocookie.com/embed/' + encodeURIComponent(creative.youtube)
                + '?autoplay=1&mute=1&playsinline=1&rel=0&modestbranding=1';
            frame.title = creative.title || labels.label;
            frame.allow = 'autoplay; encrypted-media; picture-in-picture';
            frame.setAttribute('allowfullscreen', '');
            frame.referrerPolicy = 'strict-origin-when-cross-origin';
            media.textContent = '';
            media.appendChild(frame);
        });
        media.appendChild(play);

        return {
            near: noop,
            visible: noop,
            // Глядач відкрив програвач — картку більше не змінюємо.
            timed: function () { return !opened; },
            stop: noop
        };
    }

    var STATIC_PLAYER = { near: noop, visible: noop, timed: function () { return true; }, stop: noop };

    /** Плеєр для медіа картки: відео, YouTube або статичне (зображення / картка). */
    function mediaPlayer(card, creative, labels, rotating, onDone) {
        var media = card.querySelector('.sponsored-card__media');
        var video = media ? media.querySelector('video[data-src]') : null;
        if (video) {
            return wireVideo(video, media, labels, rotating, function () {
                if (!creative.preview) {
                    sendEvent(creative.token, 'view');
                }
            }, onDone);
        }
        if (media && creative.type === 'youtube' && creative.youtube) {
            media.textContent = '';
            return buildYoutube(media, creative, labels);
        }

        return STATIC_PLAYER;
    }

    function buildMedia(creative) {
        if (creative.type === 'upload' && creative.video) {
            var video = el('video');
            video.setAttribute('preload', 'none');
            video.setAttribute('disablepictureinpicture', '');
            if (creative.poster) {
                video.poster = creative.poster;
            }
            video.setAttribute('data-src', creative.video);
            return video;
        }
        var src = creative.poster
            || (creative.type === 'youtube' && creative.youtube ? 'https://i.ytimg.com/vi/' + encodeURIComponent(creative.youtube) + '/hqdefault.jpg' : '');
        if (!src) {
            return null;
        }
        var img = el('img');
        img.alt = '';
        img.loading = 'lazy';
        img.src = src;
        return img;
    }

    // --- Картки ----------------------------------------------------------------

    /** Нативна картка (та сама розмітка, що й ad_card_html в app/ad-card.php). */
    function buildNativeCard(creative, labels) {
        var card = el('article', 'sponsored-card sponsored-card--native');
        card.setAttribute('data-id', String(creative.id));
        card.appendChild(el('span', 'sponsored-card__label', labels.label));
        var m = buildMedia(creative);
        if (m) {
            var media = el('div', 'sponsored-card__media');
            media.appendChild(m);
            card.appendChild(media);
        } else {
            card.classList.add('sponsored-card--card');
        }
        var title = el('h3', 'sponsored-card__title');
        var link = el('a', 'sponsored-card__link', creative.title);
        link.href = CLICK + '?t=' + encodeURIComponent(creative.token);
        link.target = '_blank';
        link.rel = 'sponsored noopener noreferrer';
        title.appendChild(link);
        card.appendChild(title);
        if (creative.description) {
            card.appendChild(el('p', 'sponsored-card__desc', creative.description));
        }
        var footer = el('div', 'sponsored-card__footer');
        footer.appendChild(el('span', 'sponsored-card__cta', creative.cta));
        card.appendChild(footer);
        return card;
    }

    function buildReport(card, footer, creative, labels) {
        var btn = el('button', 'sponsored-card__report', labels.report);
        btn.type = 'button';
        footer.appendChild(btn);

        btn.addEventListener('click', function () {
            if (card.querySelector('.sponsored-card__report-form')) {
                return;
            }
            var form = el('form', 'sponsored-card__report-form');
            var select = el('select');
            select.setAttribute('aria-label', labels.report);
            Object.keys(labels.reasons).forEach(function (key) {
                var opt = el('option', null, labels.reasons[key]);
                opt.value = key;
                select.appendChild(opt);
            });
            var send = el('button', null, labels.reportSend);
            send.type = 'submit';
            var cancel = el('button', null, labels.reportCancel);
            cancel.type = 'button';
            cancel.addEventListener('click', function () { form.remove(); });
            form.appendChild(select);
            form.appendChild(send);
            form.appendChild(cancel);
            form.addEventListener('submit', function (e) {
                e.preventDefault();
                var data = new FormData();
                data.append('t', creative.token);
                data.append('reason', select.value);
                fetch(REPORT, { method: 'POST', body: data, credentials: 'same-origin' })
                    .catch(noop)
                    .then(function () {
                        form.remove();
                        btn.remove();
                        card.appendChild(el('p', 'sponsored-card__note', labels.reportThanks));
                    });
            });
            card.appendChild(form);
        });
    }

    /** Блок на сторінці (продукт, блог, маркетплейс): медіа, текст, кнопка, скарга. */
    function buildWideCard(creative, labels) {
        var card = el('article', 'sponsored-card');
        card.setAttribute('aria-label', labels.label);
        card.appendChild(el('span', 'sponsored-card__label', labels.label));
        if (creative.type === 'card') {
            // Картка без відео (власна реклама): градієнт бренду, без медіа.
            card.classList.add('sponsored-card--card', 'sponsored-card--' + (creative.layout === 'compact' ? 'compact' : 'wide'));
        } else {
            var m = buildMedia(creative);
            if (m) {
                var media = el('div', 'sponsored-card__media');
                media.appendChild(m);
                card.appendChild(media);
            }
        }
        if (creative.title) {
            card.appendChild(el('h3', 'sponsored-card__title', creative.title));
        }
        if (creative.description) {
            card.appendChild(el('p', 'sponsored-card__desc', creative.description));
        }
        var footer = el('div', 'sponsored-card__footer');
        var cta = el('a', 'sponsored-card__cta', creative.cta);
        cta.href = CLICK + '?t=' + encodeURIComponent(creative.token);
        cta.target = '_blank';
        cta.rel = 'sponsored noopener noreferrer';
        footer.appendChild(cta);
        buildReport(card, footer, creative, labels);
        card.appendChild(footer);
        return card;
    }

    // --- Слот: облік показів і ротація ------------------------------------------

    /**
     * Оживити слот: card — уже вставлена картка першого креативу; build(creative) — нова
     * картка для наступного. Показ кожного креативу рахується один раз, коли ≥50% картки
     * видно ≥1 с; ротація йде лише поки картку видно й вкладка активна.
     */
    function runSlot(slot, card, creatives, labels, build) {
        var rotating = creatives.length > 1;
        var idx = 0;
        var player = null;
        var visible = false;
        var impressed = {};
        var imprTimer = null;
        var elapsed = 0;

        function creative() {
            return creatives[idx];
        }

        function next() {
            if (!rotating) {
                return;
            }
            player.stop();
            idx = (idx + 1) % creatives.length;
            var fresh = build(creative());
            observers.forEach(function (o) { o.unobserve(card); });
            slot.replaceChild(fresh, card);
            card = fresh;
            mount();
        }

        function armImpression() {
            var c = creative();
            if (c.preview || impressed[c.id] || imprTimer !== null || !visible || document.visibilityState !== 'visible') {
                return;
            }
            imprTimer = window.setTimeout(function () {
                imprTimer = null;
                if (visible && creative() === c && !impressed[c.id]) {
                    impressed[c.id] = true;
                    sendEvent(c.token, 'impression');
                }
            }, 1000);
        }

        function mount() {
            elapsed = 0;
            if (imprTimer !== null) {
                window.clearTimeout(imprTimer);
                imprTimer = null;
            }
            player = mediaPlayer(card, creative(), labels, rotating, next);
            observers.forEach(function (o) { o.observe(card); });
        }

        var observers = [];
        if ('IntersectionObserver' in window) {
            observers.push(new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    if (entry.isIntersecting) {
                        player.near();
                    }
                });
            }, { rootMargin: NEAR_MARGIN }));
            observers.push(new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    if (entry.target !== card) {
                        return;
                    }
                    visible = entry.isIntersecting && entry.intersectionRatio >= 0.5;
                    player.visible(visible);
                    if (visible) {
                        armImpression();
                    } else if (imprTimer !== null) {
                        window.clearTimeout(imprTimer);
                        imprTimer = null;
                    }
                });
            }, { threshold: [0, 0.5, 1] }));
        }
        mount();

        if (rotating && observers.length) {
            window.setInterval(function () {
                if (!visible || document.visibilityState !== 'visible' || !player.timed()) {
                    return;
                }
                elapsed += 1000;
                if (elapsed >= ROTATE_MS) {
                    next();
                }
            }, 1000);
        }
        document.addEventListener('visibilitychange', function () {
            if (document.visibilityState === 'visible') {
                armImpression();
            }
        });
    }

    var shown = [];
    var houseShown = false;   // власна реклама — не більше одного блока на сторінку

    function remember(creatives) {
        creatives.forEach(function (c) {
            if (!c.preview) {
                shown.push(c.id);
            }
            if (c.house) {
                houseShown = true;
            }
        });
    }

    // Нативна картка в списку (app/ad-card.php): розмітка вже з сервера.
    function initNative(slot) {
        var dataNode = slot.querySelector('.sponsored-slot__data');
        var card = slot.querySelector('.sponsored-card');
        var payload = null;
        try {
            payload = dataNode ? JSON.parse(dataNode.textContent) : null;
        } catch (e) {
            payload = null;
        }
        if (!card || !payload || !payload.creatives || !payload.creatives.length) {
            return;
        }
        remember(payload.creatives);
        // Скарга на рекламу — кнопка в підвалі картки (над посиланням картки).
        var withReport = function (node, c) {
            var footer = node.querySelector('.sponsored-card__footer');
            if (footer && !c.preview) {
                buildReport(node, footer, c, payload.labels);
            }
            return node;
        };
        withReport(card, payload.creatives[0]);
        runSlot(slot, card, payload.creatives, payload.labels, function (c) {
            return withReport(buildNativeCard(c, payload.labels), c);
        });
    }

    function fill(slot) {
        var params = new URLSearchParams({
            placement: slot.dataset.placement || '',
            category: slot.dataset.category || '',
            subcategory: slot.dataset.subcategory || '',
            lang: slot.dataset.lang || '',
            device: deviceType()
        });
        if (slot.dataset.product) {
            params.set('product', slot.dataset.product);
        }
        if (slot.dataset.article) {
            params.set('article', slot.dataset.article);
        }
        if (slot.dataset.mp) {
            params.set('mp', slot.dataset.mp);
        }
        if (shown.length) {
            params.set('exclude', shown.join(','));
        }
        if (houseShown) {
            params.set('nohouse', '1');
        }
        if (slot.dataset.preview === '1') {
            params.set('preview', '1');
        }
        return fetch(SERVE + '?' + params.toString(), { credentials: 'same-origin' })
            .then(function (res) {
                return res.status === 200 ? res.json() : null;
            })
            .then(function (payload) {
                if (!payload || !payload.creative || !payload.labels) {
                    return;
                }
                var creatives = payload.creatives && payload.creatives.length ? payload.creatives : [payload.creative];
                remember(creatives);
                var build = function (c) { return buildWideCard(c, payload.labels); };
                var card = build(creatives[0]);
                // Слот вище видимої області: зберігаємо положення читача (без стрибка вмісту).
                var above = slot.getBoundingClientRect().top < 0;
                var before = document.documentElement.scrollHeight;
                slot.appendChild(card);
                slot.hidden = false;
                if (above) {
                    window.scrollBy(0, document.documentElement.scrollHeight - before);
                }
                runSlot(slot, card, creatives, payload.labels, build);
            })
            .catch(noop);
    }

    function init() {
        Array.prototype.forEach.call(document.querySelectorAll('.sponsored-slot[data-native]'), initNative);
        // По черзі: наступний слот знає, що вже показано (exclude).
        Array.prototype.reduce.call(document.querySelectorAll('.sponsored-slot[data-placement]:not([data-native])'), function (chain, slot) {
            return chain.then(function () { return fill(slot); });
        }, Promise.resolve());
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
