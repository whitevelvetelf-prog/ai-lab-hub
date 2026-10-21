/* AI LAB HUB — відеореклама (.sponsored-card).
 *
 * Знаходить порожні слоти .sponsored-slot (app/promo.php → promo_slot), питає
 * креатив у /promo-serve.php і будує картку. Немає реклами (204) — слот лишається
 * прихованим, порожнього місця немає.
 *
 *   * Нативні картки в списках (app/ad-card.php, .sponsored-slot[data-native]) приходять
 *     готовими з сервера разом із JSON креативу; тут лише оживлюються (initNative).
 *   * Відео: muted + playsinline + loop; у нативній картці src підставляється лише поблизу
 *     екрана (до того — постер). Автозапуск лише коли картка видима (≥50%), пауза поза
 *     екраном. Звук ніколи не вмикається сам — кнопка-динамік; звук грає лише в одному
 *     ролику на сторінці, клік по кнопці не відкриває сторінку рекламодавця.
 *     Без автозапуску при saveData або prefers-reduced-motion: постер + «відтворити».
 *   * YouTube: постер-заглушка, iframe youtube-nocookie.com вантажиться лише після
 *     натискання (без звуку). Для YouTube рахуються лише покази й кліки CTA.
 *   * Облік: impression — ≥50% площі видно ≥1 с, одна подія за завантаження
 *     сторінки; view — ≥3 с відтворення (лише власне відео). Події — sendBeacon на
 *     /promo-event.php; клік — тільки через /promo-click.php?t=ТОКЕН.
 *   * Слоти сторінки заповнюються по черзі: кожен запит передає exclude — креативи,
 *     уже показані на сторінці, тож одна реклама не повторюється.
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

    function sendEvent(token, type) {
        var data = new FormData();
        data.append('t', token);
        data.append('type', type);
        if (navigator.sendBeacon && navigator.sendBeacon(EVENT, data)) {
            return;
        }
        fetch(EVENT, { method: 'POST', body: data, credentials: 'same-origin', keepalive: true }).catch(function () {});
    }

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
     * браузери блокують автозвук. $beforePlay — підвантажити відео, якщо ще не завантажене.
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

    function buildVideo(media, creative, labels, onStart) {
        var video = el('video');
        video.muted = true;
        video.defaultMuted = true;
        video.setAttribute('muted', '');
        video.setAttribute('playsinline', '');
        video.setAttribute('preload', allowAutoplay ? 'metadata' : 'none');
        video.setAttribute('loop', '');
        video.setAttribute('disablepictureinpicture', '');
        if (creative.poster) {
            video.poster = creative.poster;
        }
        video.src = creative.video;
        media.appendChild(video);
        media.appendChild(soundButton(video, labels));

        var play = null;
        function showPlay() {
            if (play) {
                return;
            }
            play = el('button', 'sponsored-card__play', '▶');
            play.type = 'button';
            play.setAttribute('aria-label', labels.play);
            play.addEventListener('click', function () {
                play.remove();
                play = null;
                video.play().catch(noop);
            });
            media.appendChild(play);
        }
        if (!allowAutoplay) {
            showPlay();
        }
        trackView(video, function () { onStart('view'); });

        return {
            visible: function (isVisible) {
                if (isVisible && allowAutoplay) {
                    video.play().catch(showPlay);
                } else if (!isVisible && !video.paused) {
                    video.pause();
                }
            }
        };
    }

    function buildYoutube(media, creative, labels) {
        var poster = el('img');
        poster.alt = '';
        poster.loading = 'lazy';
        poster.src = creative.poster || ('https://i.ytimg.com/vi/' + encodeURIComponent(creative.youtube) + '/hqdefault.jpg');
        media.appendChild(poster);

        var play = el('button', 'sponsored-card__play', '▶');
        play.type = 'button';
        play.setAttribute('aria-label', labels.play);
        play.addEventListener('click', function () {
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

        return { visible: function () {} };
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
                    .catch(function () {})
                    .then(function () {
                        form.remove();
                        btn.remove();
                        card.appendChild(el('p', 'sponsored-card__note', labels.reportThanks));
                    });
            });
            card.appendChild(form);
        });
    }

    function render(slot, payload) {
        var creative = payload.creative;
        var labels = payload.labels;

        var card = el('article', 'sponsored-card');
        card.setAttribute('aria-label', labels.label);
        card.appendChild(el('span', 'sponsored-card__label', labels.label));

        var media = el('div', 'sponsored-card__media');
        card.appendChild(media);

        var impressionSent = !!creative.preview;
        var player;
        if (creative.type === 'card') {
            // Картка без відео (власна реклама): градієнт бренду, без медіа.
            card.classList.add('sponsored-card--card', 'sponsored-card--' + (creative.layout === 'compact' ? 'compact' : 'wide'));
            media.remove();
            player = { visible: function () {} };
        } else if (creative.type === 'image') {
            var img = el('img');
            img.alt = '';
            img.loading = 'lazy';
            img.src = creative.poster || '';
            media.appendChild(img);
            player = { visible: function () {} };
        } else {
            player = creative.type === 'upload' && creative.video
                ? buildVideo(media, creative, labels, function (type) { if (!creative.preview) { sendEvent(creative.token, type); } })
                : buildYoutube(media, creative, labels);
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

        // Слот вище видимої області: зберігаємо положення читача (без стрибка вмісту).
        var above = slot.getBoundingClientRect().top < 0;
        var before = document.documentElement.scrollHeight;
        slot.appendChild(card);
        slot.hidden = false;
        if (above) {
            window.scrollBy(0, document.documentElement.scrollHeight - before);
        }

        if (!('IntersectionObserver' in window)) {
            return;
        }
        var timer = null;
        var observer = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                var visible = entry.isIntersecting && entry.intersectionRatio >= 0.5;
                player.visible(visible);
                if (impressionSent) {
                    return;
                }
                if (visible && timer === null && document.visibilityState === 'visible') {
                    timer = window.setTimeout(function () {
                        impressionSent = true;
                        sendEvent(creative.token, 'impression');
                    }, 1000);
                } else if (!visible && timer !== null) {
                    window.clearTimeout(timer);
                    timer = null;
                }
            });
        }, { threshold: [0, 0.5, 1] });
        observer.observe(card);
    }

    var shown = [];
    var houseShown = false;   // власна реклама — не більше одного блока на сторінку

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
                if (payload && payload.creative && payload.labels) {
                    if (!payload.creative.preview) {
                        shown.push(payload.creative.id);
                    }
                    if (payload.creative.house) {
                        houseShown = true;
                    }
                    render(slot, payload);
                }
            })
            .catch(function () {});
    }

    // --- Нативна картка в списку (app/ad-card.php) --------------------------
    // Розмітка картки вже з сервера; тут — ліниве відео, звук і облік показу.

    // Відео вантажиться заздалегідь, коли картка ближче за цю відстань до екрана.
    var NEAR_MARGIN = '300px 0px';

    /**
     * Відео нативної картки: src підставляється лише поблизу екрана (до того — постер),
     * старт сам без звуку, коли картка видима, пауза поза екраном. saveData /
     * prefers-reduced-motion — лише постер і кнопка «відтворити».
     */
    function wireNativeVideo(video, media, labels, onView) {
        var loaded = false;
        var play = null;
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
            stop: function () {
                video.pause();
                releaseSound(video);
            }
        };
    }

    function nativePlayer(card, creative, labels) {
        var media = card.querySelector('.sponsored-card__media');
        var video = media ? media.querySelector('video[data-src]') : null;
        if (video) {
            return wireNativeVideo(video, media, labels, function () {
                if (!creative.preview) {
                    sendEvent(creative.token, 'view');
                }
            });
        }
        if (media && creative.type === 'youtube' && creative.youtube) {
            media.textContent = '';
            return buildYoutube(media, creative, labels);
        }

        return { near: noop, visible: noop, stop: noop };
    }

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
        var creative = payload.creatives[0];
        if (!creative.preview) {
            shown.push(creative.id);
        }
        if (creative.house) {
            houseShown = true;
        }
        var player = nativePlayer(card, creative, payload.labels);
        var impressionSent = !!creative.preview;
        if (!('IntersectionObserver' in window)) {
            return;
        }
        new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) {
                    player.near();
                }
            });
        }, { rootMargin: NEAR_MARGIN }).observe(card);

        var timer = null;
        new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                var visible = entry.isIntersecting && entry.intersectionRatio >= 0.5;
                player.visible(visible);
                if (impressionSent) {
                    return;
                }
                if (visible && timer === null && document.visibilityState === 'visible') {
                    timer = window.setTimeout(function () {
                        impressionSent = true;
                        sendEvent(creative.token, 'impression');
                    }, 1000);
                } else if (!visible && timer !== null) {
                    window.clearTimeout(timer);
                    timer = null;
                }
            });
        }, { threshold: [0, 0.5, 1] }).observe(card);
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
