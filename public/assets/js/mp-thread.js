/*
 * AI LAB HUB — Marketplace: відкрита розмова в чаті (mp-messages.php?c=N, mp-thread.php) і форма першого повідомлення.
 *  - надсилання через fetch (POST multipart + CSRF, Accept: application/json); без JS форма працює звичайним POST;
 *  - Enter — надіслати, Shift+Enter — новий рядок (на сенсорних екранах без фізичної клавіатури Enter — новий рядок,
 *    надсилання — кнопкою ➤); під час набору IME (isComposing) Enter не надсилає;
 *  - вкладення: одне зображення (jpg/png/webp) або PDF до 5 МБ; попередня перевірка тут, остаточна — на сервері за вмістом;
 *  - опитування mp-messages-poll.php кожні data-interval секунд (5) лише на видимій вкладці; прихована — пауза, при
 *    поверненні — одразу; помилка — повтор через 60 с; ETag / If-None-Match → 304 без тіла; лише нові (since = останній id);
 *  - «Прочитано»: сервер повертає peer_read — останнє прочитане співрозмовником; позначки оновлюються без перезавантаження.
 * HTML повідомлень (row_html) будує сервер (msg_row_html, усе екрановано) — вставляється як є.
 */
(function () {
    'use strict';
    var form = document.getElementById('msg-compose');
    if (!form) {
        return;
    }
    var log = document.getElementById('msgLog');
    var scroller = document.getElementById('msgScroll');
    var textarea = form.querySelector('textarea');
    var errorBox = document.getElementById('msgError');
    var button = form.querySelector('button[type="submit"]');
    var sinceInput = form.querySelector('input[name="since"]');
    var fileInput = document.getElementById('msgFile');
    var fileChip = document.getElementById('msgFileChip');
    var fileName = document.getElementById('msgFileName');
    var fileClear = document.getElementById('msgFileClear');
    var polling = !!(form.dataset.poll && log);
    var lastId = parseInt(form.dataset.last || '0', 10) || 0;
    var interval = Math.max(4, parseInt(form.dataset.interval || '5', 10)) * 1000;
    var maxFile = parseInt(form.dataset.maxFile || '5242880', 10);
    var okTypes = ['image/jpeg', 'image/png', 'image/webp', 'application/pdf'];
    var etag = null;
    var timer = null;
    var busy = false;
    var sending = false;
    var touchOnly = window.matchMedia && window.matchMedia('(hover: none) and (pointer: coarse)').matches;
    if (touchOnly && textarea.dataset.placeholderTouch) {   // на телефоні Enter — новий рядок: коротка підказка без «Enter — надіслати»
        textarea.placeholder = textarea.dataset.placeholderTouch;
        textarea.setAttribute('enterkeyhint', 'enter');
    }

    function innerScroll() {
        return scroller && scroller.scrollHeight > scroller.clientHeight + 2 && getComputedStyle(scroller).overflowY !== 'visible';
    }
    function nearEnd() {
        if (innerScroll()) {
            return scroller.scrollTop + scroller.clientHeight >= scroller.scrollHeight - 160;
        }
        return (window.innerHeight + window.scrollY) >= (document.body.scrollHeight - 220);
    }
    function scrollToEnd() {
        if (innerScroll()) {
            scroller.scrollTop = scroller.scrollHeight;
            return;
        }
        var end = document.getElementById('msg-end');
        if (end) { end.scrollIntoView({ block: 'end' }); }
    }

    function markRead(peer) {
        if (!log || !peer) { return; }
        log.setAttribute('data-peer-read', String(peer));
        log.querySelectorAll('.msg-row--mine').forEach(function (li) {
            var id = parseInt(li.getAttribute('data-id') || '0', 10);
            var badge = li.querySelector('.msg-read');
            if (badge && id <= peer && !badge.classList.contains('is-read')) {
                badge.classList.add('is-read');
                badge.textContent = badge.getAttribute('data-read-label') || badge.textContent;
            }
        });
    }

    function append(messages) {
        if (!log) { return; }
        messages.forEach(function (m) {
            if (m.id <= lastId || log.querySelector('[data-id="' + m.id + '"]')) { return; }
            var tpl = document.createElement('template');
            tpl.innerHTML = m.row_html;   // екранує сервер (msg_row_html)
            if (tpl.content.firstElementChild) { log.appendChild(tpl.content.firstElementChild); }
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
        if (!polling || document.visibilityState !== 'visible') { return; }   // прихована вкладка — пауза
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
                if (r.status === 429) { return { retry: true }; }
                if (!r.ok) { throw new Error('poll ' + r.status); }
                etag = r.headers.get('ETag');
                return r.json();
            })
            .then(function (j) {
                busy = false;
                if (j && j.ok) {
                    if (j.messages && j.messages.length) {
                        var stick = nearEnd();
                        append(j.messages);
                        if (stick) { scrollToEnd(); }
                    }
                    markRead(j.peer_read);
                    if (j.readonly) { form.hidden = true; return; }
                }
                schedule(interval);
            })
            .catch(function () {
                busy = false;
                schedule(60000);   // помилка — повтор через 60 с
            });
    }

    // --- Вкладення ---------------------------------------------------------------------------------
    function clearFile() {
        if (!fileInput) { return; }
        fileInput.value = '';
        if (fileChip) { fileChip.hidden = true; }
    }
    if (fileInput) {
        fileInput.addEventListener('change', function () {
            showError('');
            var f = fileInput.files && fileInput.files[0];
            if (!f) { clearFile(); return; }
            if (f.size > maxFile) { clearFile(); showError(form.dataset.errSize); return; }
            if (f.type && okTypes.indexOf(f.type) === -1) { clearFile(); showError(form.dataset.errType); return; }
            if (fileName) { fileName.textContent = f.name; }
            if (fileChip) { fileChip.hidden = false; }
            textarea.focus();
        });
    }
    if (fileClear) { fileClear.addEventListener('click', clearFile); }
    function hasFile() {
        return !!(fileInput && fileInput.files && fileInput.files.length);
    }

    // --- Надсилання ----------------------------------------------------------------------------------
    form.addEventListener('submit', function (e) {
        if (!window.fetch || !window.FormData) { return; }   // без fetch — звичайний POST
        e.preventDefault();
        if (sending) { return; }
        var body = textarea.value.trim();
        if (!body && !hasFile()) { textarea.focus(); return; }
        sending = true;
        button.disabled = true;
        showError('');
        var data = new FormData(form);
        if (sinceInput) { data.set('since', String(lastId)); }
        fetch(form.getAttribute('action'), { method: 'POST', body: data, credentials: 'same-origin', headers: { 'Accept': 'application/json' } })
            .then(function (r) { return r.json().catch(function () { return { ok: false }; }); })
            .then(function (j) {
                sending = false;
                button.disabled = false;
                if (j && j.ok && j.redirect) { window.location.href = j.redirect; return; }
                if (j && j.ok) {
                    textarea.value = '';
                    clearFile();
                    resize();
                    append(j.messages || []);
                    markRead(j.peer_read);
                    scrollToEnd();
                    etag = null;
                    schedule(interval);
                    textarea.focus();
                } else if (j && j.verify_url) {
                    window.location.href = j.verify_url;
                } else {
                    showError((j && j.message) || form.dataset.error);
                }
            })
            .catch(function () {
                sending = false;
                button.disabled = false;
                showError(form.dataset.error);
            });
    });

    // Enter — надіслати; Shift+Enter — новий рядок.
    textarea.addEventListener('keydown', function (e) {
        if (e.key !== 'Enter' || e.isComposing || e.keyCode === 229) { return; }
        if (e.shiftKey || (touchOnly && !e.ctrlKey && !e.metaKey)) { return; }
        e.preventDefault();
        if (typeof form.requestSubmit === 'function') { form.requestSubmit(); } else { button.click(); }
    });

    function resize() {
        textarea.style.height = 'auto';
        textarea.style.height = Math.min(textarea.scrollHeight, Math.round(window.innerHeight * 0.35)) + 'px';
    }
    textarea.addEventListener('input', resize);
    textarea.addEventListener('focus', function () { if (!innerScroll()) { setTimeout(scrollToEnd, 300); } });

    // Панель емодзі (кнопка 😊 ліворуч від поля). Емодзі — звичайні символи в тексті; «Нещодавні» — у localStorage.
    (function emojiPanel() {
        var labels;
        try { labels = JSON.parse(form.dataset.emoji || 'null'); } catch (e) { labels = null; }
        var field = form.querySelector('.msg-compose__field');
        if (!labels || !field) { return; }
        var SETS = {
            smileys: '😀 😃 😄 😁 😆 😅 😂 🤣 😊 🙂 😉 😍 🥰 😘 😋 😎 🤓 🤩 🥳 😇 🤗 🤭 🤫 🤔 🤨 😐 😏 🙄 😬 😌 😴 😮 😲 😳 🥺 😢 😭 😤 😡 🤯 😱 🤒 🤧 😷',
            gestures: '👍 👎 👌 ✌️ 🤞 🤝 👏 🙌 👐 🙏 💪 👋 ✋ 🤙 👉 👈 👆 👇 ☝️ ✍️ 🫶 🤷 🙋 🙅 🙆 🤦',
            hearts: '❤️ 🧡 💛 💚 💙 💜 🖤 🤍 🤎 💔 💕 💞 💖 💗 💯 ✨ 🔥 ⭐ 🌟 💫 🎉 🎊 🎁 🎂 🌹 🌸 🌻 ☀️ 🌈 ☕ 🍕 🍰',
            work: '✅ ❌ ⚠️ ❗ ❓ 💬 📩 📧 📞 📱 💻 🖥️ 📦 🚚 📍 📅 ⏰ ⏳ 💰 💵 💳 🧾 📄 📎 📌 📊 📈 🔗 🔒 🔑 🛠️ ⚙️ 🤖 🧪 💡 📝 📷 🎬 🎨 🎵 🏠 🇺🇦',
            symbols: '👀 🙈 💤 🆗 🆕 🆓 🔝 ➡️ ⬅️ ⬆️ ⬇️ 🔄 ✔️ ☑️ ➕ ➖ ✖️ 💲 ⭕ 🚫 ⛔ 🟢 🟡 🔴 ⚪ ⚫ 🔵 🟣'
        };
        var LS = 'alh_emoji_recent';
        var order = ['recent', 'smileys', 'gestures', 'hearts', 'work', 'symbols'];
        var icons = { recent: '🕘', smileys: '😊', gestures: '👍', hearts: '❤️', work: '💼', symbols: '✔️' };
        var recent = [];
        try { recent = JSON.parse(window.localStorage.getItem(LS) || '[]'); } catch (e) { recent = []; }
        if (!Array.isArray(recent)) { recent = []; }
        recent = recent.filter(function (s) { return typeof s === 'string' && s.length <= 16; }).slice(0, 24);

        var btn = document.createElement('button');
        btn.type = 'button';
        btn.className = 'msg-compose__emoji';
        btn.setAttribute('aria-label', labels.button);
        btn.title = labels.button;
        btn.setAttribute('aria-expanded', 'false');
        btn.setAttribute('aria-controls', 'msgEmojiPanel');
        btn.textContent = '😊';
        field.parentNode.insertBefore(btn, field);

        var panel = document.createElement('div');
        panel.className = 'msg-emoji';
        panel.id = 'msgEmojiPanel';
        panel.setAttribute('role', 'dialog');
        panel.setAttribute('aria-label', labels.button);
        panel.hidden = true;
        var tabs = document.createElement('div');
        tabs.className = 'msg-emoji__tabs';
        tabs.setAttribute('role', 'tablist');
        var grid = document.createElement('div');
        grid.className = 'msg-emoji__grid';
        grid.setAttribute('role', 'tabpanel');
        panel.appendChild(tabs);
        panel.appendChild(grid);
        form.appendChild(panel);
        var current = recent.length ? 'recent' : 'smileys';
        var caret = null;   // позиція курсора в полі (на телефоні поле втрачає фокус, коли тиснуть на панель)
        ['keyup', 'click', 'select', 'input'].forEach(function (ev) {
            textarea.addEventListener(ev, function () { caret = [textarea.selectionStart, textarea.selectionEnd]; });
        });

        function list(id) { return id === 'recent' ? recent : SETS[id].split(' '); }
        function render() {
            tabs.textContent = '';
            order.forEach(function (id) {
                if (id === 'recent' && !recent.length) { return; }
                var t = document.createElement('button');
                t.type = 'button';
                t.className = 'msg-emoji__tab' + (id === current ? ' is-active' : '');
                t.setAttribute('role', 'tab');
                t.setAttribute('aria-selected', id === current ? 'true' : 'false');
                t.setAttribute('aria-label', labels[id]);
                t.title = labels[id];
                t.textContent = icons[id];
                t.dataset.set = id;
                tabs.appendChild(t);
            });
            grid.textContent = '';
            grid.setAttribute('aria-label', labels[current]);
            list(current).forEach(function (em) {
                var b = document.createElement('button');
                b.type = 'button';
                b.className = 'msg-emoji__item';
                b.textContent = em;
                b.dataset.emoji = em;
                grid.appendChild(b);
            });
            grid.scrollTop = 0;
        }
        function open() {
            render();
            panel.hidden = false;
            btn.setAttribute('aria-expanded', 'true');
            document.addEventListener('pointerdown', outside, true);
        }
        function close(focusBtn) {
            if (panel.hidden) { return; }
            panel.hidden = true;
            btn.setAttribute('aria-expanded', 'false');
            document.removeEventListener('pointerdown', outside, true);
            if (focusBtn) { btn.focus(); }
        }
        function outside(e) { if (!panel.contains(e.target) && e.target !== btn) { close(false); } }
        function insert(em) {
            var max = parseInt(textarea.getAttribute('maxlength') || '0', 10);
            if (max > 0 && textarea.value.length + em.length > max) { return; }
            var len = textarea.value.length;
            var s = caret ? Math.min(caret[0], len) : len;   // поле ще не чіпали — в кінець тексту
            var e = caret ? Math.min(caret[1], len) : len;
            textarea.setRangeText(em, s, e, 'end');
            caret = [textarea.selectionStart, textarea.selectionEnd];
            textarea.dispatchEvent(new Event('input', { bubbles: true }));
            if (!touchOnly) { textarea.focus(); }   // на телефоні не відкриваємо клавіатуру — панель лишається видимою
            recent = [em].concat(recent.filter(function (x) { return x !== em; })).slice(0, 24);
            try { window.localStorage.setItem(LS, JSON.stringify(recent)); } catch (err) { /* без «Нещодавніх» */ }
        }

        btn.addEventListener('click', function () { if (panel.hidden) { open(); } else { close(false); } });
        tabs.addEventListener('click', function (e) {
            var t = e.target.closest('[data-set]');
            if (!t) { return; }
            current = t.dataset.set;
            render();
            var active = tabs.querySelector('.is-active');
            if (active) { active.focus(); }
        });
        grid.addEventListener('click', function (e) {
            var b = e.target.closest('[data-emoji]');
            if (b) { insert(b.dataset.emoji); }
        });
        panel.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') { e.preventDefault(); close(true); }
        });
        textarea.addEventListener('keydown', function (e) { if (e.key === 'Escape') { close(false); } });
        form.addEventListener('submit', function () { close(false); });
    })();

    // Меню «⋯» → «Поскаржитися»: відкрити форму скарги.
    document.querySelectorAll('[data-open-report]').forEach(function (a) {
        a.addEventListener('click', function (e) {
            var rep = document.getElementById('msgReport');
            if (!rep) { return; }
            e.preventDefault();
            var menu = a.closest('details');
            if (menu) { menu.open = false; }
            rep.open = true;
            rep.scrollIntoView({ block: 'nearest' });
            var sel = rep.querySelector('select');
            if (sel) { sel.focus(); }
        });
    });
    document.addEventListener('click', function (e) {   // клік поза меню — закрити
        document.querySelectorAll('details.msg-menu[open]').forEach(function (d) {
            if (!d.contains(e.target)) { d.open = false; }
        });
    });

    // Екранна клавіатура iPhone: якщо поле вводу «липке» (телефон), піднімаємо його на висоту клавіатури.
    if (window.visualViewport) {
        var vv = window.visualViewport;
        var onViewport = function () {
            if (getComputedStyle(form).position !== 'sticky') { form.style.transform = ''; return; }
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
    if (log) { scrollToEnd(); }
    schedule(interval);
})();
