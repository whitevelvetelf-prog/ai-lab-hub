/* AI LAB HUB — єдиний перегляд фото оголошень Marketplace (сторінка оголошення, кабінет автора, модерація в CRM).
 *
 * Без бібліотек. Розмітка:
 *   <div data-mp-gallery>
 *     <a href="/mp-photo.php?f=…" data-mp-gallery-main>…</a>   — необов'язково: велике фото, відкриває поточне
 *     <a href="/mp-photo.php?f=…" data-mp-photo><img alt="Фото 1" src="…_t.jpg"></a> …
 *   </div>
 * href лишається запасним варіантом без JS; клік перехоплюється й відкриває оверлей поверх сторінки — без переходу.
 * Якщо в контейнері немає [data-mp-photo], набором є саме головне посилання.
 *
 * Історія: при відкритті — один запис pushState (та сама адреса, без hash); «Назад» / жест «назад» закриває перегляд
 * (popstate), закриття кнопкою ✕, тапом на фон, Esc чи свайпом униз робить history.back() цього ж запису — без дублів.
 * Прокрутка body блокується (position:fixed) і відновлюється на ту саму позицію; фокус повертається на мініатюру.
 * Перегортання: свайп, стрілки клавіатури, кнопки ‹ ›; масштаб: два пальці, подвійний тап, колесо з Ctrl.
 * Тап на темне тло навколо фото закриває перегляд (pointer-події — на iOS click по нейтральних елементах ненадійний):
 *   лише тап (рух < 10 px, < 500 мс), не свайп/масштаб/панорамування; збільшене фото — тап на тло спершу повертає масштаб;
 *   перші 300 мс після відкриття закриття ігнорується (ghost click); click, що прилітає після закриття, гаситься.
 *   Тап на фото, ✕-окрім-закриття, стрілки, лічильник, підпис — не закриває.
 * Відсутній файл: mp-photo.php віддає SVG-заглушку; якщо зображення не завантажилось взагалі — заглушка в брендових кольорах.
 */
(function () {
    'use strict';
    if (window.mpGallery) {
        return;
    }

    var en = (document.documentElement.lang || '').slice(0, 2) === 'en';
    var L = en
        ? { title: 'Photo viewer', close: 'Close', prev: 'Previous photo', next: 'Next photo', missing: 'Photo unavailable' }
        : { title: 'Перегляд фото', close: 'Закрити', prev: 'Попереднє фото', next: 'Наступне фото', missing: 'Фото недоступне' };

    var CSS = ''
        + '.mpg{position:fixed;inset:0;z-index:2147483000;display:flex;flex-direction:column;background:#00032c;color:#fff;'
        + '-webkit-tap-highlight-color:transparent;overscroll-behavior:contain}'
        + '.mpg[hidden]{display:none}'
        + '.mpg__bar{position:absolute;top:0;left:0;right:0;z-index:2;display:flex;align-items:center;justify-content:space-between;gap:12px;'
        + 'padding:max(10px,env(safe-area-inset-top)) max(10px,env(safe-area-inset-right)) 10px max(14px,env(safe-area-inset-left));pointer-events:none}'
        + '.mpg__count{pointer-events:auto;font:600 15px/1.2 system-ui,-apple-system,sans-serif;padding:6px 12px;border-radius:999px;background:rgba(33,22,173,.85)}'
        + '.mpg__count:empty{visibility:hidden}'
        + '.mpg__btn{pointer-events:auto;display:inline-flex;align-items:center;justify-content:center;min-width:48px;min-height:48px;margin:0;padding:0;'
        + 'border:2px solid rgba(255,255,255,.85);border-radius:50%;background:#2116ad;color:#fff;font:400 26px/1 system-ui,-apple-system,sans-serif;cursor:pointer;'
        + 'box-shadow:0 2px 10px rgba(0,0,0,.45)}'
        + '.mpg__btn:hover{background:#3326d6}.mpg__btn:focus-visible{outline:3px solid #fff;outline-offset:2px}'
        + '.mpg__stage{position:relative;flex:1;display:flex;align-items:center;justify-content:center;overflow:hidden;touch-action:none;cursor:pointer;'
        + 'padding:calc(68px + env(safe-area-inset-top)) 8px calc(16px + env(safe-area-inset-bottom))}'
        // Мобільний портрет: поля ≥12% з кожного боку — є куди торкнутись, щоб закрити (на високих фото — зверху й знизу).
        + '@media (max-width:768px) and (orientation:portrait){.mpg__stage{'
        + 'padding:max(12vh,calc(64px + env(safe-area-inset-top))) max(12vw,env(safe-area-inset-right)) max(12vh,calc(16px + env(safe-area-inset-bottom))) max(12vw,env(safe-area-inset-left))}}'
        + '@media (min-width:769px),(orientation:landscape){.mpg__stage{padding-left:max(64px,6vw);padding-right:max(64px,6vw)}}'
        + '.mpg__cap{position:absolute;left:0;right:0;bottom:0;z-index:2;margin:0;padding:8px max(16px,env(safe-area-inset-right)) max(10px,env(safe-area-inset-bottom)) max(16px,env(safe-area-inset-left));'
        + 'text-align:center;font:400 14px/1.35 system-ui,-apple-system,sans-serif;color:#dfe3ff;cursor:auto}'
        + '.mpg__cap:empty,.mpg__cap[hidden]{display:none}'
        + '.mpg__img{max-width:100%;max-height:100%;object-fit:contain;user-select:none;-webkit-user-select:none;-webkit-user-drag:none;'
        + 'transform-origin:center center;will-change:transform;border-radius:6px;cursor:zoom-in}'
        + '.mpg.is-zoomed .mpg__img{cursor:grab}'
        + '.mpg__img.is-anim{transition:transform .2s ease,opacity .2s ease}'
        + '.mpg__ph{display:flex;flex-direction:column;align-items:center;justify-content:center;gap:12px;width:min(92vw,640px);aspect-ratio:16/9;'
        + 'border-radius:12px;background:linear-gradient(135deg,#00032c,#2116ad);color:#fff;font:600 15px/1.3 system-ui,-apple-system,sans-serif}'
        + '.mpg__ph[hidden]{display:none}'
        + '.mpg__nav{position:absolute;top:50%;z-index:2;transform:translateY(-50%)}'
        + '.mpg__nav--prev{left:max(8px,env(safe-area-inset-left))}.mpg__nav--next{right:max(8px,env(safe-area-inset-right))}'
        + '.mpg__nav[hidden]{display:none}'
        + '@media (prefers-reduced-motion:reduce){.mpg__img.is-anim{transition:none}}';

    var PH_ICON = '<svg width="56" height="56" viewBox="0 0 24 24" fill="none" stroke="#5b8cff" stroke-width="1.6" stroke-linecap="round" '
        + 'stroke-linejoin="round" aria-hidden="true"><rect x="3" y="3" width="18" height="18" rx="2"/><circle cx="9" cy="9" r="2"/>'
        + '<path d="m21 15-3.1-3.1a2 2 0 0 0-2.8 0L6 21"/></svg>';

    var ov, stage, img, ph, counter, cap, btnClose, btnPrev, btnNext;
    var TAP_MOVE = 10;     // px: більший рух — жест, не тап
    var TAP_TIME = 500;    // мс: довше — не тап (утримання)
    var OPEN_GUARD = 300;  // мс після відкриття, коли закриття тапом ігнорується (ghost click)
    var openedAt = 0;
    var swallowUntil = 0;  // до цього часу click після закриття гаситься (щоб не влучив у сторінку під оверлеєм)
    var items = [];        // [{src, alt}]
    var idx = 0;
    var gallery = null;    // контейнер, з якого відкрито
    var trigger = null;    // елемент, на який повертається фокус
    var isOpen = false;
    var pushed = false;    // чи наш запис історії зараз поточний
    var savedY = 0;
    var savedBody = null;
    var savedRestoration = null;
    var closeTimer = 0;    // запасне закриття, якщо popstate після history.back() не прийшов
    var z = { s: 1, x: 0, y: 0 };

    function el(tag, cls, attrs) {
        var e = document.createElement(tag);
        if (cls) { e.className = cls; }
        Object.keys(attrs || {}).forEach(function (k) { e.setAttribute(k, attrs[k]); });
        return e;
    }

    function build() {
        var st = el('style');
        st.textContent = CSS;
        document.head.appendChild(st);

        ov = el('div', 'mpg', { role: 'dialog', 'aria-modal': 'true', 'aria-label': L.title });
        ov.hidden = true;
        var bar = el('div', 'mpg__bar');
        counter = el('span', 'mpg__count', { 'aria-live': 'polite' });
        btnClose = el('button', 'mpg__btn mpg__close', { type: 'button', 'aria-label': L.close, title: L.close });
        btnClose.textContent = '✕';
        bar.appendChild(counter);
        bar.appendChild(btnClose);
        stage = el('div', 'mpg__stage');
        img = el('img', 'mpg__img', { alt: '', draggable: 'false' });
        ph = el('div', 'mpg__ph', { role: 'img', 'aria-label': L.missing });
        ph.innerHTML = PH_ICON + '<span>' + L.missing + '</span>';
        ph.hidden = true;
        stage.appendChild(img);
        stage.appendChild(ph);
        btnPrev = el('button', 'mpg__btn mpg__nav mpg__nav--prev', { type: 'button', 'aria-label': L.prev, title: L.prev });
        btnPrev.textContent = '‹';
        btnNext = el('button', 'mpg__btn mpg__nav mpg__nav--next', { type: 'button', 'aria-label': L.next, title: L.next });
        btnNext.textContent = '›';
        ov.appendChild(stage);
        ov.appendChild(btnPrev);
        ov.appendChild(btnNext);
        cap = el('p', 'mpg__cap');
        ov.appendChild(cap);
        ov.appendChild(bar);
        document.body.appendChild(ov);

        btnClose.addEventListener('click', function () { if (Date.now() - openedAt >= OPEN_GUARD) { requestClose(); } });
        btnPrev.addEventListener('click', function () { go(-1); });
        btnNext.addEventListener('click', function () { go(1); });
        img.addEventListener('error', function () {
            if (!img.getAttribute('src')) { return; }
            img.hidden = true;
            ph.hidden = false;
        });
        img.addEventListener('load', function () { img.hidden = false; ph.hidden = true; });
        ov.addEventListener('keydown', onKey);
        stage.addEventListener('wheel', onWheel, { passive: false });
        stage.addEventListener('dblclick', function (e) { toggleZoom(e.clientX, e.clientY); });
        bindPointers();
    }

    // ---- відкриття / закриття ---------------------------------------------------------------------------------

    function collect(container) {
        var links = container.querySelectorAll('a[data-mp-photo]');
        if (!links.length) {
            links = container.querySelectorAll('a[data-mp-gallery-main]');
        }
        return Array.prototype.map.call(links, function (a) {
            var im = a.querySelector('img');
            return { src: a.getAttribute('href'), alt: a.getAttribute('data-alt') || (im ? im.getAttribute('alt') : '') || '',
                cap: a.getAttribute('data-caption') || '', link: a };
        }).filter(function (it) { return it.src; });
    }

    function open(container, index, from) {
        if (isOpen || closeTimer) { return; }   // попередній перегляд ще закривається
        items = collect(container);
        if (!items.length) { return; }
        if (!ov) { build(); }
        gallery = container;
        trigger = from || null;
        idx = Math.max(0, Math.min(index || 0, items.length - 1));
        isOpen = true;
        openedAt = Date.now();

        // Один запис історії: «Назад» закриває перегляд. Та сама адреса — без hash і без прокрутки до якоря.
        try {
            savedRestoration = 'scrollRestoration' in history ? history.scrollRestoration : null;
            if (savedRestoration !== null) { history.scrollRestoration = 'manual'; }
            history.pushState({ mpGallery: 1 }, '');
            pushed = true;
        } catch (e) {
            pushed = false;
        }
        lockScroll();
        ov.hidden = false;
        show();
        btnClose.focus({ preventScroll: true });
    }

    /** Закриття з інтерфейсу (✕, фон, Esc, свайп): прибираємо свій запис історії; teardown — у popstate. */
    function requestClose() {
        if (!isOpen) { return; }
        if (pushed && history.state && history.state.mpGallery) {
            history.back();
            // Запасний варіант, якщо popstate не прийде (напр., історію змінив хтось інший).
            if (!closeTimer) {
                closeTimer = setTimeout(function () { closeTimer = 0; pushed = false; teardown(); }, 600);
            }
        } else {
            teardown();
        }
    }

    function teardown() {
        if (!isOpen) { return; }
        isOpen = false;
        pushed = false;
        ov.hidden = true;
        resetZoom(false);
        img.removeAttribute('src');
        unlockScroll();
        if (savedRestoration !== null) {
            try { history.scrollRestoration = savedRestoration; } catch (e) { /* ignore */ }
            savedRestoration = null;
        }
        syncMain();
        var back = trigger && document.contains(trigger) ? trigger : (items[idx] && items[idx].link);
        if (back && back.focus) { back.focus({ preventScroll: true }); }
        trigger = null;
        gallery = null;
    }

    /** На сторінці оголошення велике фото показує останнє переглянуте. */
    function syncMain() {
        if (!gallery || !items[idx]) { return; }
        var main = gallery.querySelector('a[data-mp-gallery-main]');
        if (!main || !gallery.querySelector('a[data-mp-photo]')) { return; }
        var mi = main.querySelector('img');
        main.setAttribute('href', items[idx].src);
        main.setAttribute('data-index', String(idx));
        if (mi && mi.getAttribute('src') !== items[idx].src) { mi.setAttribute('src', items[idx].src); }
    }

    window.addEventListener('popstate', function () {
        if (closeTimer) { clearTimeout(closeTimer); closeTimer = 0; }
        if (isOpen) {
            pushed = false;
            teardown();
        }
    });
    // Перезавантаження з відкритим переглядом лишає наш стан у записі — прибираємо прапорець.
    try {
        if (history.state && history.state.mpGallery) { history.replaceState(null, ''); }
    } catch (e) { /* ignore */ }
    window.addEventListener('pagehide', function () { if (isOpen) { pushed = false; teardown(); } });
    window.addEventListener('pageshow', function (e) { if (e.persisted && isOpen) { pushed = false; teardown(); } });

    // ---- блокування прокрутки ------------------------------------------------------------------------------------

    function lockScroll() {
        var b = document.body;
        savedY = window.pageYOffset || document.documentElement.scrollTop || 0;
        savedBody = { position: b.style.position, top: b.style.top, left: b.style.left, right: b.style.right, width: b.style.width, overflow: b.style.overflow };
        b.style.position = 'fixed';
        b.style.top = (-savedY) + 'px';
        b.style.left = '0';
        b.style.right = '0';
        b.style.width = '100%';
        b.style.overflow = 'hidden';
        document.documentElement.classList.add('mpg-open');
    }

    function unlockScroll() {
        var b = document.body;
        if (savedBody) {
            Object.keys(savedBody).forEach(function (k) { b.style[k] = savedBody[k]; });
            savedBody = null;
        }
        document.documentElement.classList.remove('mpg-open');
        window.scrollTo(0, savedY);
        // Деякі браузери відновлюють прокрутку запису історії вже після popstate — повторюємо в наступному кадрі.
        var y = savedY;
        requestAnimationFrame(function () { if (!isOpen && Math.abs((window.pageYOffset || 0) - y) > 1) { window.scrollTo(0, y); } });
    }

    // ---- показ і перегортання ------------------------------------------------------------------------------------

    function show() {
        var it = items[idx];
        resetZoom(false);
        img.style.opacity = '';
        img.hidden = false;
        ph.hidden = true;
        img.setAttribute('alt', it.alt);
        img.setAttribute('src', it.src);
        var many = items.length > 1;
        counter.textContent = many ? (idx + 1) + ' / ' + items.length : '';
        cap.textContent = it.cap;
        btnPrev.hidden = !many;
        btnNext.hidden = !many;
        // Попереднє завантаження сусідніх фото.
        if (many) {
            [idx + 1, idx - 1].forEach(function (j) {
                var n = items[(j + items.length) % items.length];
                if (n) { (new Image()).src = n.src; }
            });
        }
    }

    function go(step) {
        if (items.length < 2) { return; }
        idx = (idx + step + items.length) % items.length;
        show();
    }

    function onKey(e) {
        if (e.key === 'Escape' || e.key === 'Esc') { e.preventDefault(); requestClose(); return; }
        if (e.key === 'ArrowLeft') { e.preventDefault(); go(-1); return; }
        if (e.key === 'ArrowRight') { e.preventDefault(); go(1); return; }
        if (e.key === 'Tab') {   // фокус лишається в діалозі
            var f = [btnClose, btnPrev, btnNext].filter(function (b) { return !b.hidden; });
            var i = f.indexOf(document.activeElement);
            e.preventDefault();
            f[(i + (e.shiftKey ? -1 : 1) + f.length) % f.length].focus();
        }
    }

    // ---- масштаб і жести -----------------------------------------------------------------------------------------

    function applyZoom(anim) {
        img.classList.toggle('is-anim', !!anim);
        img.style.transform = 'translate(' + z.x + 'px,' + z.y + 'px) scale(' + z.s + ')';
        if (ov) { ov.classList.toggle('is-zoomed', z.s > 1); }
    }

    function resetZoom(anim) {
        z = { s: 1, x: 0, y: 0 };
        applyZoom(anim);
    }

    function clampPan() {
        var r = img.getBoundingClientRect();
        var w = r.width / z.s, h = r.height / z.s;   // розмір без масштабу
        var mx = Math.max(0, (w * z.s - stage.clientWidth) / 2 + 20);
        var my = Math.max(0, (h * z.s - stage.clientHeight) / 2 + 20);
        z.x = Math.max(-mx, Math.min(mx, z.x));
        z.y = Math.max(-my, Math.min(my, z.y));
    }

    function zoomAt(ns, cx, cy) {
        ns = Math.max(1, Math.min(4, ns));
        var r = stage.getBoundingClientRect();
        var ox = cx - (r.left + r.width / 2), oy = cy - (r.top + r.height / 2);
        z.x = ox - (ox - z.x) * (ns / z.s);
        z.y = oy - (oy - z.y) * (ns / z.s);
        z.s = ns;
        if (z.s <= 1.01) { z = { s: 1, x: 0, y: 0 }; } else { clampPan(); }
    }

    function toggleZoom(cx, cy) {
        if (z.s > 1) { resetZoom(true); } else { zoomAt(2.5, cx, cy); applyZoom(true); }
    }

    function onWheel(e) {
        if (!e.ctrlKey) { return; }
        e.preventDefault();
        zoomAt(z.s * (e.deltaY < 0 ? 1.15 : 1 / 1.15), e.clientX, e.clientY);
        applyZoom(false);
    }

    function bindPointers() {
        var pts = {};          // pointerId -> {x,y}
        var start = null;      // жест одним пальцем
        var pinch = null;      // жест двома пальцями
        var lastTap = 0;
        var moved = false;

        function count() { return Object.keys(pts).length; }
        function two() {
            var k = Object.keys(pts);
            var a = pts[k[0]], b = pts[k[1]];
            return { d: Math.hypot(a.x - b.x, a.y - b.y) || 1, cx: (a.x + b.x) / 2, cy: (a.y + b.y) / 2 };
        }

        stage.addEventListener('pointerdown', function (e) {
            if (e.pointerType === 'mouse' && e.button !== 0) { return; }
            try { stage.setPointerCapture(e.pointerId); } catch (err) { /* ignore */ }
            pts[e.pointerId] = { x: e.clientX, y: e.clientY };
            if (count() === 1) {
                start = { x: e.clientX, y: e.clientY, zx: z.x, zy: z.y, t: Date.now(), target: e.target };
                moved = false;
            } else if (count() === 2) {
                var t = two();
                pinch = { d: t.d, s: z.s, cx: t.cx, cy: t.cy, zx: z.x, zy: z.y };
                start = null;
                moved = true;
            }
        });

        stage.addEventListener('pointermove', function (e) {
            if (!pts[e.pointerId]) { return; }
            pts[e.pointerId] = { x: e.clientX, y: e.clientY };
            if (pinch && count() >= 2) {
                var t = two();
                z.s = pinch.s; z.x = pinch.zx + (t.cx - pinch.cx); z.y = pinch.zy + (t.cy - pinch.cy);
                zoomAt(pinch.s * (t.d / pinch.d), t.cx, t.cy);
                applyZoom(false);
                return;
            }
            if (!start) { return; }
            var dx = e.clientX - start.x, dy = e.clientY - start.y;
            if (Math.hypot(dx, dy) >= TAP_MOVE) { moved = true; }
            if (z.s > 1) {         // панорамування збільшеного фото
                z.x = start.zx + dx; z.y = start.zy + dy;
                clampPan();
                applyZoom(false);
            } else if (moved) {    // попередній показ свайпу
                if (Math.abs(dy) > Math.abs(dx) && dy > 0) {
                    img.style.transform = 'translateY(' + dy + 'px)';
                    img.style.opacity = String(Math.max(0.35, 1 - dy / 400));
                } else if (items.length > 1) {
                    img.style.transform = 'translateX(' + dx + 'px)';
                }
            }
        });

        function end(e) {
            if (!pts[e.pointerId]) { return; }
            delete pts[e.pointerId];
            if (pinch) {
                if (count() < 2) {
                    pinch = null;
                    if (z.s <= 1.05) { resetZoom(true); }
                    // Палець, що лишився, продовжує як панорамування.
                    var k = Object.keys(pts)[0];
                    start = k ? { x: pts[k].x, y: pts[k].y, zx: z.x, zy: z.y, t: Date.now(), target: null, multi: true } : null;
                }
                return;
            }
            if (!start || count() > 0) { return; }
            var dx = e.clientX - start.x, dy = e.clientY - start.y;
            var s = start;
            start = null;
            if (e.type === 'pointercancel') { if (z.s === 1) { resetZoom(true); img.style.opacity = ''; } return; }
            if (moved) {
                if (z.s > 1) { return; }   // це було панорамування збільшеного фото
                img.style.opacity = '';
                if (dy > 90 && Math.abs(dy) > Math.abs(dx)) { swallowUntil = Date.now() + 500; requestClose(); return; }
                if (Math.abs(dx) > 50 && Math.abs(dx) > Math.abs(dy) && items.length > 1) { go(dx < 0 ? 1 : -1); return; }
                resetZoom(true);
                return;
            }
            if (s.multi || Date.now() - s.t > TAP_TIME || Math.hypot(dx, dy) >= TAP_MOVE) { return; }   // не тап
            // Тап на фон: збільшене фото — повернути масштаб; інакше закрити (крім перших мс після відкриття).
            var onPhoto = s.target === img || (s.target && ph.contains(s.target));
            if (!onPhoto) {
                if (z.s > 1) { resetZoom(true); return; }
                if (Date.now() - openedAt < OPEN_GUARD || s.t - openedAt < OPEN_GUARD) { return; }
                swallowUntil = Date.now() + 500;
                requestClose();
                return;
            }
            // Подвійний тап по фото — масштаб.
            var now = Date.now();
            if (e.pointerType !== 'mouse' && now - lastTap < 300) { toggleZoom(e.clientX, e.clientY); lastTap = 0; } else { lastTap = now; }
        }
        stage.addEventListener('pointerup', end);
        stage.addEventListener('pointercancel', end);
    }

    // ---- перехоплення кліків -------------------------------------------------------------------------------------

    // Click, що прилітає слідом за тапом/свайпом, яким закрито перегляд, не повинен натиснути щось на сторінці під ним.
    document.addEventListener('click', function (e) {
        if (Date.now() < swallowUntil) { e.preventDefault(); e.stopPropagation(); swallowUntil = 0; }
    }, true);

    document.addEventListener('click', function (e) {
        if (e.defaultPrevented || e.button !== 0 || e.metaKey || e.ctrlKey || e.shiftKey || e.altKey) { return; }
        var a = e.target.closest ? e.target.closest('a[data-mp-photo], a[data-mp-gallery-main]') : null;
        if (!a) { return; }
        var container = a.closest('[data-mp-gallery]');
        if (!container) { return; }
        e.preventDefault();
        var index;
        if (a.hasAttribute('data-mp-gallery-main')) {
            index = parseInt(a.getAttribute('data-index') || '0', 10) || 0;
        } else {
            index = Array.prototype.indexOf.call(container.querySelectorAll('a[data-mp-photo]'), a);
        }
        open(container, index, a);
    });

    window.mpGallery = { open: open, close: requestClose };
})();
