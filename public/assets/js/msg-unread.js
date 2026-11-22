/*
 * AI LAB HUB — Marketplace: значок непрочитаних повідомлень у шапці (пункт «Повідомлення» біля «Кабінет») і живий
 * список розмов на mp-messages.php. Підключає app/site-header.php лише залогіненим, коли повідомлення ввімкнено.
 *  - опитування mp-messages-unread.php кожні data-interval секунд (30), лише на видимій вкладці; прихована — пауза,
 *    повернення — одразу; 401/404 — зупинка; помилка чи 429 — повтор через 2 хв;
 *  - на сторінці чату (#msgChat) — ?list=1: оновлює лічильники, фрагмент і час розмов, піднімає нові вгору; розмову,
 *    якої ще немає у списку, показує посиланням «Є нові розмови — оновити».
 * Текст фрагментів вставляється лише як textContent.
 */
(function () {
    'use strict';
    var me = document.currentScript;
    var url = me && me.getAttribute('data-url');
    if (!url || !window.fetch) {
        return;
    }
    var interval = Math.max(15, parseInt(me.getAttribute('data-interval') || '30', 10)) * 1000;
    var aria = me.getAttribute('data-aria') || '%d';
    var chat = document.getElementById('msgChat');
    var list = document.getElementById('msgList');
    var timer = null;
    var stopped = false;

    function fmt(n) { return n > 99 ? '99+' : String(n); }

    function setHeader(total) {
        document.querySelectorAll('.site-nav__link--msg').forEach(function (link) {
            var badge = link.querySelector('.msg-badge');
            if (total > 0) {
                if (!badge) {
                    badge = document.createElement('span');
                    badge.className = 'msg-badge';
                    link.appendChild(document.createTextNode(' '));
                    link.appendChild(badge);
                }
                badge.textContent = fmt(total);
                badge.setAttribute('aria-label', aria.replace('%d', String(total)));
            } else if (badge) {
                badge.remove();
            }
        });
    }

    function setList(convs) {
        if (!list || !convs) { return; }
        var fresh = false;
        var current = new URLSearchParams(window.location.search).get('c');
        convs.slice().reverse().forEach(function (c) {
            var li = list.querySelector('[data-conv="' + c.id + '"]');
            if (!li) { fresh = true; return; }
            var changed = parseInt(li.getAttribute('data-last') || '0', 10) !== c.last;
            var badge = li.querySelector('[data-unread]');
            var unread = String(c.id) === current ? 0 : c.unread;   // відкриту розмову читає mp-thread.js
            if (badge) {
                badge.hidden = unread <= 0;
                badge.textContent = fmt(unread);
                badge.setAttribute('aria-label', aria.replace('%d', String(unread)));
            }
            li.classList.toggle('msg-item--unread', unread > 0);
            if (changed) {
                var p = li.querySelector('[data-preview]');
                var t = li.querySelector('[data-time]');
                if (p) { p.textContent = c.preview; }
                if (t) { t.textContent = c.time; }
                li.setAttribute('data-last', String(c.last));
                list.insertBefore(li, list.firstElementChild);   // остання активність — угорі
            }
        });
        var note = document.getElementById('msgListFresh');
        if (note && fresh) { note.hidden = false; }
    }

    function schedule(delay) {
        clearTimeout(timer);
        if (stopped || document.visibilityState !== 'visible') { return; }
        timer = setTimeout(tick, delay);
    }

    function tick() {
        if (document.visibilityState !== 'visible') { return; }
        fetch(url + (chat ? '?list=1' : ''), { credentials: 'same-origin', headers: { 'Accept': 'application/json' }, cache: 'no-store' })
            .then(function (r) {
                if (r.status === 401 || r.status === 404) { stopped = true; return null; }
                if (!r.ok) { throw new Error('unread ' + r.status); }
                return r.json();
            })
            .then(function (j) {
                if (j && j.ok) {
                    setHeader(j.total || 0);
                    setList(j.convs);
                }
                schedule(interval);
            })
            .catch(function () { schedule(120000); });
    }

    document.addEventListener('visibilitychange', function () {
        if (document.visibilityState === 'visible') { schedule(1000); } else { clearTimeout(timer); }
    });
    schedule(interval);
})();
