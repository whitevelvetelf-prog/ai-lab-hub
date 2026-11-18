/*
 * AI LAB HUB — Marketplace: сторінка розмови (mp-thread.php).
 *  - надсилання через fetch (POST + CSRF, Accept: application/json); без JS форма працює звичайним POST;
 *  - опитування mp-messages-poll.php кожні data-interval секунд, лише коли вкладка видима; пауза на прихованій,
 *    одразу при поверненні; після помилки — затримка 60 с; ETag / If-None-Match → 304 без тіла;
 *  - iPhone: поле вводу над екранною клавіатурою (visualViewport), автозбільшення висоти, прокрутка донизу.
 * HTML повідомлень приходить із сервера вже екранованим (msg_body_html) — вставляється як є.
 */
(function () {
    'use strict';
    var form = document.getElementById('msg-compose');
    var log = document.getElementById('msgLog');
    if (!form || !log || !form.dataset.poll) {
        return;
    }
    var textarea = form.querySelector('textarea');
    var errorBox = document.getElementById('msgError');
    var button = form.querySelector('button[type="submit"]');
    var sinceInput = form.querySelector('input[name="since"]');
    var lastId = parseInt(form.dataset.last || '0', 10) || 0;
    var interval = Math.max(5, parseInt(form.dataset.interval || '20', 10)) * 1000;
    var etag = null;
    var timer = null;
    var busy = false;

    function scrollToEnd() {
        var end = document.getElementById('msg-end');
        if (end) { end.scrollIntoView({ block: 'end' }); }
    }

    function append(messages) {
        messages.forEach(function (m) {
            if (m.id <= lastId || log.querySelector('[data-id="' + m.id + '"]')) { return; }
            var li = document.createElement('li');
            li.className = 'msg-row' + (m.mine ? ' msg-row--mine' : '') + (m.system ? ' msg-row--system' : '') + (m.platform ? ' msg-row--platform' : '');
            li.setAttribute('data-id', String(m.id));
            var bubble = document.createElement('div');
            bubble.className = 'msg-bubble';
            if (m.label) {
                var label = document.createElement('span');
                label.className = 'msg-bubble__label';
                label.textContent = m.label;
                bubble.appendChild(label);
            }
            var text = document.createElement('span');
            text.innerHTML = m.html;   // екранує сервер (msg_body_html)
            bubble.appendChild(text);
            var time = document.createElement('time');
            time.className = 'msg-bubble__time';
            time.setAttribute('datetime', m.iso);
            time.textContent = m.time;
            bubble.appendChild(time);
            li.appendChild(bubble);
            log.appendChild(li);
            lastId = Math.max(lastId, m.id);
        });
        if (sinceInput) { sinceInput.value = String(lastId); }
    }

    function showError(text) {
        if (!errorBox) { return; }
        errorBox.textContent = text || '';
        errorBox.hidden = !text;
    }

    function schedule(delay) {
        clearTimeout(timer);
        if (document.visibilityState !== 'visible') { return; }   // прихована вкладка — пауза
        timer = setTimeout(poll, delay);
    }

    function poll() {
        if (busy || document.visibilityState !== 'visible') { return; }
        busy = true;
        var headers = { 'Accept': 'application/json' };
        if (etag) { headers['If-None-Match'] = etag; }
        fetch(form.dataset.poll + '&since=' + lastId, { credentials: 'same-origin', headers: headers, cache: 'no-store' })
            .then(function (r) {
                if (r.status === 304) { return null; }
                if (!r.ok) { throw new Error('poll ' + r.status); }
                etag = r.headers.get('ETag');
                return r.json();
            })
            .then(function (j) {
                busy = false;
                if (j && j.ok && j.messages && j.messages.length) {
                    var nearEnd = (window.innerHeight + window.scrollY) >= (document.body.scrollHeight - 200);
                    append(j.messages);
                    if (nearEnd) { scrollToEnd(); }
                }
                if (j && j.readonly) { form.hidden = true; return; }
                schedule(interval);
            })
            .catch(function () {
                busy = false;
                schedule(60000);   // помилка — повтор через 60 с
            });
    }

    form.addEventListener('submit', function (e) {
        if (!window.fetch || !window.FormData) { return; }   // без fetch — звичайний POST
        e.preventDefault();
        var body = textarea.value.trim();
        if (!body) { return; }
        button.disabled = true;
        showError('');
        var data = new FormData(form);
        data.set('since', String(lastId));
        fetch(form.getAttribute('action'), { method: 'POST', body: data, credentials: 'same-origin', headers: { 'Accept': 'application/json' } })
            .then(function (r) { return r.json().catch(function () { return { ok: false }; }); })
            .then(function (j) {
                button.disabled = false;
                if (j && j.ok) {
                    textarea.value = '';
                    resize();
                    append(j.messages || []);
                    scrollToEnd();
                    etag = null;
                    schedule(interval);
                } else {
                    showError((j && j.message) || form.dataset.error);
                }
            })
            .catch(function () {
                button.disabled = false;
                showError(form.dataset.error);
            });
    });

    // Enter — новий рядок; Ctrl/Cmd+Enter — надіслати (на телефоні — кнопка).
    textarea.addEventListener('keydown', function (e) {
        if (e.key === 'Enter' && (e.ctrlKey || e.metaKey)) {
            e.preventDefault();
            if (typeof form.requestSubmit === 'function') { form.requestSubmit(); } else { button.click(); }
        }
    });

    function resize() {
        textarea.style.height = 'auto';
        textarea.style.height = Math.min(textarea.scrollHeight, Math.round(window.innerHeight * 0.4)) + 'px';
    }
    textarea.addEventListener('input', resize);
    textarea.addEventListener('focus', function () { setTimeout(scrollToEnd, 300); });

    // Екранна клавіатура iPhone: піднімаємо поле вводу на висоту клавіатури.
    if (window.visualViewport) {
        var vv = window.visualViewport;
        var onViewport = function () {
            var covered = window.innerHeight - vv.height - vv.offsetTop;
            form.style.transform = covered > 0 ? 'translateY(' + (-covered) + 'px)' : '';
        };
        vv.addEventListener('resize', onViewport);
        vv.addEventListener('scroll', onViewport);
    }

    document.addEventListener('visibilitychange', function () {
        if (document.visibilityState === 'visible') { schedule(0); } else { clearTimeout(timer); }
    });

    resize();
    scrollToEnd();
    schedule(interval);
})();
