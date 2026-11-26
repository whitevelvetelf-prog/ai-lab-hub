/* AI LAB HUB — «Багвіль»: сторінки гри (крок 3).
 *
 * Шапка: «Назад» (history.back на тому ж сайті, інакше резервна адреса) і «Поділитися» (navigator.share або копія
 * посилання; без кнопок соцмереж — у грі немає зовнішніх посилань).
 * Місія (#bv-game): state → start → сцена; hint → підказка; check → результат, розбір, чарівне слово, нагорода.
 * Відповідей у браузері немає: сервер дає лише сцену з одноразовими id і після перевірки — розбір.
 * Тексти сервера вставляються лише через textContent. Нічого не пишеться в localStorage; у sessionStorage — лише те,
 * що гість закрив пропозицію «зберегти» (до кінця сеансу, MAIN_TASK розділ 8).
 *
 * Інтерактивні сцени Розділу 1 (window.BVScene, нижче): спільний шар — майстер Гайка (SVG, моргання, антена,
 * act('wave'|'jump'|'cheer')), штамп «Знайдено», сплив, колекція поломок як міні-звіт (ввели → сталося → мало бути),
 * журнал спроб, фінал із зірками й карткою чарівного слова, звук (вимкнено, вмикається кнопкою; Web Audio, без файлів).
 * Сцена «Автомат» (input_machine): кожне «Купити» — запит scene_act; що сталося і чи це поломка, вирішує лише сервер.
 */
(function () {
    'use strict';

    function el(tag, cls, text) {
        var n = document.createElement(tag);
        if (cls) { n.className = cls; }
        if (text !== undefined && text !== null) { n.textContent = String(text); }
        return n;
    }
    function svgEl(markup) {
        var t = document.createElement('template');
        t.innerHTML = markup.trim();   // лише власні сталі розмітки з цього файлу, без даних сервера
        return t.content.firstChild;
    }
    /** Текст сервера з <b>…</b>: усе екрануємо, дозволяємо лише b. */
    function setRich(node, text) {
        var safe = String(text).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
            .replace(/&lt;(\/?)b&gt;/g, '<$1b>');
        node.innerHTML = safe;
    }
    var reduced = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    // ---------- Звук: вимкнено, поки гравець не ввімкне ----------
    var Sound = {
        on: false, ctx: null,
        tone: function (f, d, type, delay) {
            if (!Sound.on) { return; }
            try {
                Sound.ctx = Sound.ctx || new (window.AudioContext || window.webkitAudioContext)();
                var o = Sound.ctx.createOscillator(), g = Sound.ctx.createGain(), t = Sound.ctx.currentTime + (delay || 0);
                o.type = type || 'sine'; o.frequency.value = f;
                g.gain.setValueAtTime(0.12, t); g.gain.exponentialRampToValueAtTime(0.001, t + d);
                o.connect(g); g.connect(Sound.ctx.destination); o.start(t); o.stop(t + d);
            } catch (e) { /* без звуку */ }
        },
        button: function () {
            var b = el('button', 'bvs-chip__btn', 'Звук: вимк.');
            b.type = 'button';
            b.setAttribute('aria-pressed', 'false');
            b.addEventListener('click', function () {
                Sound.on = !Sound.on;
                b.textContent = 'Звук: ' + (Sound.on ? 'увімк.' : 'вимк.');
                b.setAttribute('aria-pressed', String(Sound.on));
                Sound.tone(660, 0.12);
            });
            return b;
        }
    };

    // ---------- Майстер Гайка (оригінальний SVG із затвердженого прототипу) ----------
    var MENTOR_SVG = '<svg class="bvs-mentor__svg" viewBox="0 0 120 124" aria-hidden="true" focusable="false"><g class="hero">'
        + '<g class="ant"><line x1="60" y1="16" x2="60" y2="30" stroke="#f2f5ff" stroke-width="4"/><circle cx="60" cy="12" r="7" fill="#ffd23f"/></g>'
        + '<g class="armL"><line x1="26" y1="88" x2="16" y2="68" stroke="#3a2a00" stroke-width="3" stroke-linecap="round"/><circle cx="15" cy="64" r="8" fill="#ff6b5b" stroke="#3a2a00" stroke-width="2"/></g>'
        + '<g class="armR"><line x1="94" y1="88" x2="104" y2="68" stroke="#3a2a00" stroke-width="3" stroke-linecap="round"/><circle cx="105" cy="64" r="8" fill="#ff6b5b" stroke="#3a2a00" stroke-width="2"/></g>'
        + '<rect x="24" y="30" width="72" height="62" rx="20" fill="#ffd23f" stroke="#3a2a00" stroke-width="3"/>'
        + '<rect x="42" y="92" width="36" height="24" rx="8" fill="#ff6b5b" stroke="#3a2a00" stroke-width="3"/>'
        + '<g class="eyes"><circle cx="46" cy="56" r="9" fill="#fff"/><circle cx="74" cy="56" r="9" fill="#fff"/>'
        + '<circle cx="48" cy="58" r="4.5" fill="#1b2559"/><circle cx="76" cy="58" r="4.5" fill="#1b2559"/></g>'
        + '<path class="mouth" d="M46 74 Q60 88 74 74" fill="none" stroke="#3a2a00" stroke-width="4" stroke-linecap="round"/></g></svg>';
    var MOODS = { happy: 'M46 74 Q60 88 74 74', neutral: 'M48 78 H72', wow: 'M52 76 Q60 94 68 76 Q60 68 52 76 Z' };

    function Mentor() {
        this.svg = svgEl(MENTOR_SVG);
        this.bubble = el('p', 'bvs-say');
        this.timer = null;
    }
    Mentor.prototype.say = function (text, mood) {
        setRich(this.bubble, text);
        var m = this.svg.querySelector('.mouth');
        m.setAttribute('d', MOODS[mood || 'happy']);
        m.setAttribute('fill', mood === 'wow' ? '#3a2a00' : 'none');
    };
    Mentor.prototype.act = function (kind, ms) {
        var s = this.svg;
        s.classList.remove('jump', 'wave', 'cheer');
        void s.getBoundingClientRect();
        s.classList.add(kind);
        clearTimeout(this.timer);
        this.timer = setTimeout(function () { s.classList.remove(kind); }, ms || 1200);
    };

    // ---------- Ефекти: штамп і сплив ----------
    function stamp(stage, text) {
        var d = el('div', 'bvs-stamp', text);
        d.setAttribute('aria-hidden', 'true');
        stage.appendChild(d);
        setTimeout(function () { if (d.parentNode) { d.parentNode.removeChild(d); } }, 1450);
    }
    function pop(stage, anchor, text) {
        var r = anchor.getBoundingClientRect(), p = stage.getBoundingClientRect();
        var d = el('div', 'bvs-pop', text);
        d.setAttribute('aria-hidden', 'true');
        d.style.left = Math.max(0, r.left - p.left + r.width / 2 - 30) + 'px';
        d.style.top = (r.top - p.top) + 'px';
        stage.appendChild(d);
        setTimeout(function () { if (d.parentNode) { d.parentNode.removeChild(d); } }, 1300);
    }

    // ---------- Колекція знайдених поломок (міні-звіт) ----------
    function Collection(total) {
        this.total = total;
        this.cards = [];
        this.list = el('ul', 'bvs-slots');
        this.count = el('span', null, '0');
        this.render();
    }
    Collection.prototype.add = function (card) {
        this.cards.push(card);
        this.render();
    };
    Collection.prototype.render = function () {
        var ul = this.list;
        while (ul.firstChild) { ul.removeChild(ul.firstChild); }
        for (var i = 0; i < this.total; i++) {
            var c = this.cards[i];
            if (!c) { ul.appendChild(el('li', 'bvs-slot', '? невідома поломка')); continue; }
            var li = el('li', 'bvs-slot is-found');
            li.appendChild(el('h4', null, '✓ ' + c.title));
            var dl = el('dl');
            [['Ввели', c.inp], ['Сталося', c.got], ['Мало бути', c.exp]].forEach(function (p) {
                dl.appendChild(el('dt', null, p[0]));
                dl.appendChild(el('dd', null, p[1]));
            });
            li.appendChild(dl);
            ul.appendChild(li);
        }
        this.count.textContent = String(this.cards.length);
    };

    // ---------- Журнал спроб ----------
    function Log() {
        this.items = [];
        this.list = el('ul', 'bvs-log');
        this.render();
    }
    Log.prototype.add = function (input, text, isBug) {
        this.items.unshift({ v: input === '' ? '—' : input, t: text, bug: isBug });
        this.render();
    };
    Log.prototype.render = function () {
        var ul = this.list;
        while (ul.firstChild) { ul.removeChild(ul.firstChild); }
        if (!this.items.length) { ul.appendChild(el('li', null, 'Поки порожньо. Спробуйте щось ввести.')); return; }
        this.items.slice(0, 12).forEach(function (e) {
            var li = el('li', e.bug === true ? 'is-bug' : '');
            li.appendChild(el('code', null, e.v));   // ввід гравця — лише textContent
            li.appendChild(el('span', null, (e.bug === true ? '⚠ ' : (e.bug === false ? '✓ ' : '')) + e.t));   // null — без оцінки
            ul.appendChild(li);
        });
    };

    // ---------- Фінал: зірки, нагорода, картка чарівного слова ----------
    var STAR = '<svg class="bvs-star" viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="M12 2l3 6.5 7 .9-5.2 4.8 1.4 7L12 17.8 5.8 21.2l1.4-7L2 9.4l7-.9z" fill="#ffd23f" stroke="#3a2a00" stroke-width="1.2" stroke-linejoin="round"/></svg>';

    /** o: {title, stars, chips: [text], word: {word, say, meaning}|null, note, extra(node), actions: [{text, href|onClick, primary}]} */
    function finale(o) {
        var ov = el('div', 'bvs-overlay');
        ov.setAttribute('role', 'dialog');
        ov.setAttribute('aria-modal', 'true');
        ov.setAttribute('aria-labelledby', 'bvs-rt');
        var box = el('div', 'bvs-result');
        var h = el('h2', null, o.title);
        h.id = 'bvs-rt';
        h.tabIndex = -1;
        box.appendChild(h);
        var row = el('div', 'bvs-starrow');
        row.setAttribute('role', 'img');
        row.setAttribute('aria-label', 'Зірок: ' + o.stars + ' з 3');
        for (var i = 1; i <= 3; i++) {
            var s = svgEl(STAR);
            if (i > o.stars) { s.classList.add('is-off'); }
            row.appendChild(s);
        }
        box.appendChild(row);
        var chips = el('div', 'bvs-reward');
        (o.chips || []).forEach(function (t) { chips.appendChild(el('span', 'bvs-chip', t)); });
        box.appendChild(chips);
        if (o.word && o.word.word) {
            var flip = el('button', 'bvs-flip');
            flip.type = 'button';
            flip.setAttribute('aria-pressed', 'false');
            flip.setAttribute('aria-label', 'Перевернути картку чарівного слова');
            var inner = el('span', 'bvs-flip__in');
            inner.appendChild(el('span', 'bvs-face bvs-face--f', 'Натисніть, щоб відкрити чарівне слово'));
            var back = el('span', 'bvs-face bvs-face--b');
            var w = el('strong', null, o.word.word);
            w.setAttribute('lang', 'en');
            back.appendChild(w);
            back.appendChild(el('em', null, o.word.meaning));
            back.appendChild(el('small', null, '[' + o.word.say + ']'));
            if (o.word.example) {
                flip.classList.add('has-example');
                var ex = el('small', 'bvs-face__ex', '«' + o.word.example + '»');
                ex.setAttribute('lang', 'en');
                back.appendChild(ex);
                if (o.word.example_tr) { back.appendChild(el('small', 'bvs-face__tr', o.word.example_tr)); }
            }
            var more = el('a', 'bvs-face__book', '📖 Книга чарівних слів');
            more.href = 'bugville-words.php';
            inner.appendChild(back);
            flip.appendChild(inner);
            flip.addEventListener('click', function () {
                var on = flip.classList.toggle('is-on');
                flip.setAttribute('aria-pressed', String(on));
                flip.setAttribute('aria-label', on ? 'Чарівне слово: ' + o.word.word + ' — ' + o.word.meaning : 'Перевернути картку чарівного слова');
            });
            box.appendChild(flip);
            box.appendChild(more);   // посилання на Книгу — під карткою слова
        }
        if (o.note) { box.appendChild(el('p', 'bvs-note', o.note)); }
        if (o.extra) { o.extra(box); }
        var act = el('p', 'bvs-actions');
        (o.actions || []).forEach(function (a) {
            var b = a.href ? el('a', 'bvs-btn' + (a.primary ? '' : ' bvs-btn--ghost'), a.text) : el('button', 'bvs-btn' + (a.primary ? '' : ' bvs-btn--ghost'), a.text);
            if (a.href) { b.href = a.href; } else { b.type = 'button'; b.addEventListener('click', function () { close(); a.onClick(); }); }
            act.appendChild(b);
        });
        box.appendChild(act);
        ov.appendChild(box);
        document.body.appendChild(ov);
        var prev = document.activeElement;
        function close() {
            document.removeEventListener('keydown', onKey);
            if (ov.parentNode) { ov.parentNode.removeChild(ov); }
            if (prev && prev.focus) { prev.focus(); }
        }
        function onKey(e) {   // фокус лишається всередині вікна
            if (e.key !== 'Tab') { return; }
            var f = box.querySelectorAll('button, a[href]');
            if (!f.length) { return; }
            var first = f[0], last = f[f.length - 1];
            if (e.shiftKey && document.activeElement === first) { e.preventDefault(); last.focus(); }
            else if (!e.shiftKey && document.activeElement === last) { e.preventDefault(); first.focus(); }
        }
        document.addEventListener('keydown', onKey);
        Sound.tone(523, 0.15); Sound.tone(659, 0.15, 'sine', 0.15); Sound.tone(784, 0.3, 'sine', 0.3);
        h.focus();
        return { close: close, box: box };
    }

    // ---------- Сцена «Автомат» ----------
    var BOTTLE_COLORS = ['#ffd23f', '#9be15d', '#ff9f43'];
    function bottle(c) {
        return svgEl('<svg viewBox="0 0 24 48" width="22" height="44" aria-hidden="true" focusable="false"><rect x="8" y="1" width="8" height="6" rx="2" fill="#e8ecff"/>'
            + '<path d="M8 7h8l3 9v28a3 3 0 0 1-3 3H8a3 3 0 0 1-3-3V16z" fill="' + c + '"/><rect x="5" y="22" width="14" height="12" fill="#fff" opacity=".85"/>'
            + '<circle cx="12" cy="28" r="3" fill="' + c + '"/><path d="M8 18v24" stroke="#fff" stroke-opacity=".5" stroke-width="2"/></svg>');
    }
    function coin() {
        return svgEl('<svg viewBox="0 0 24 24" width="22" height="22" aria-hidden="true" focusable="false"><circle cx="12" cy="12" r="10" fill="#ffd23f" stroke="#a87a00" stroke-width="2"/><circle cx="12" cy="12" r="5.5" fill="none" stroke="#a87a00" stroke-width="1.5"/></svg>');
    }
    var BACKDROP = '<div class="bvs-backdrop" aria-hidden="true">'
        + '<svg class="bvs-stars" viewBox="0 0 400 200" preserveAspectRatio="none" focusable="false"><g fill="#fff" opacity=".9"><circle cx="30" cy="30" r="1.6"/><circle cx="90" cy="70" r="1.2"/><circle cx="150" cy="22" r="1.8"/><circle cx="240" cy="55" r="1.3"/><circle cx="310" cy="25" r="1.7"/><circle cx="370" cy="75" r="1.2"/><circle cx="200" cy="100" r="1"/><circle cx="60" cy="120" r="1.1"/></g></svg>'
        + '<svg class="bvs-houses" viewBox="0 0 400 90" preserveAspectRatio="none" focusable="false"><g fill="#1b2a6e"><path d="M0 90V50l30-22 30 22v40z"/><path d="M70 90V40h46v50z"/><path d="M290 90V46l34-24 34 24v44z"/><path d="M360 90V58h40v32z"/></g><g fill="#ffd23f"><rect x="22" y="56" width="10" height="12"/><rect x="80" y="50" width="10" height="12"/><rect x="98" y="50" width="10" height="12"/><rect x="316" y="52" width="10" height="12"/></g></svg></div>';

    /**
     * o: {host, scene, token, api(action, data) → Promise, word, onRestart(), nextUrl, reward(node, r), setWho(r), toast(msg), err(code)}
     */
    function machine(o) {
        var sc = o.scene;
        var busy = false;
        var done = false;
        var hints = null;
        var hintN = 0;
        var host = o.host;
        while (host.firstChild) { host.removeChild(host.firstChild); }
        host.setAttribute('aria-busy', 'false');

        var root = el('div', 'bvs');
        // верхній рядок: гаманець сцени (іграшковий) і звук
        var top = el('div', 'bvs-top');
        var stats = el('div', 'bvs-stats');
        var walletNum = el('span', null, String(sc.wallet || 0));
        if (!sc.claim) {
            var chipW = el('div', 'bvs-chip');
            chipW.title = 'Іграшкові монети автомата (не монети гри)';
            chipW.appendChild(el('i', null, '●'));
            chipW.appendChild(walletNum);
            chipW.appendChild(document.createTextNode(' у гаманці'));
            var refill = el('button', 'bvs-chip__btn', '+');
            refill.type = 'button';
            refill.setAttribute('aria-label', 'Поповнити гаманець');
            refill.addEventListener('click', function () { send('refill', ''); });
            chipW.appendChild(refill);
            stats.appendChild(chipW);
        }
        var chipS = el('div', 'bvs-chip');
        chipS.appendChild(Sound.button());
        stats.appendChild(chipS);
        top.appendChild(stats);
        root.appendChild(top);

        var grid = el('div', 'bvs-grid');
        // ----- сцена -----
        var stage = el('section', 'bvs-scene');
        stage.setAttribute('aria-label', 'Автомат: ' + sc.good);
        stage.appendChild(svgEl(BACKDROP));
        var mach = el('div', 'bvs-machine');
        var sign = el('div', 'bvs-sign', sc.sign);
        sign.appendChild(el('small', null, sc.sign_sub));
        mach.appendChild(sign);
        var body = el('div', 'bvs-mbody');
        var win = el('div', 'bvs-window');
        win.setAttribute('role', 'img');
        win.setAttribute('aria-label', 'У вітрині ' + sc.shelf + ' пляшок');
        var n = Math.min(12, sc.shelf || 0), k = 0;
        for (var r = 0; r < 3; r++) {
            var shelf = el('div', 'bvs-shelf');
            for (var i = 0; i < 4; i++) {
                if (k < n) { shelf.appendChild(bottle(BOTTLE_COLORS[(r + i) % 3])); } else { shelf.appendChild(el('span', 'bvs-gap')); }
                k++;
            }
            win.appendChild(shelf);
        }
        body.appendChild(win);
        var pad = el('div', 'bvs-pad');
        var lcdw = el('div', 'bvs-lcdwrap');
        var lab = el('label', null, sc.label);
        lab.htmlFor = 'bvs-qty';
        var lcd = el('input', 'bvs-lcd');
        lcd.id = 'bvs-qty';
        lcd.type = 'text';
        lcd.autocomplete = 'off';
        lcd.spellcheck = false;
        lcd.placeholder = sc.placeholder;
        lcd.maxLength = sc.max_input || 30;
        lcdw.appendChild(lab);
        lcdw.appendChild(lcd);
        pad.appendChild(lcdw);
        var msg = el('div', 'bvs-msg', sc.claim ? 'Внесіть суму: впишіть число або натисніть купюру.' : 'Введіть, скільки пляшок хочете.');
        msg.setAttribute('aria-live', 'polite');
        msg.setAttribute('role', 'status');
        pad.appendChild(msg);
        var keys = el('div', 'bvs-keys');
        if (sc.keys) {
            sc.keys.forEach(function (kk) {
                var b = el('button', null, kk === '-' ? '−' : kk);
                b.type = 'button';
                b.setAttribute('data-k', kk);
                if (kk === '-') { b.setAttribute('aria-label', 'мінус'); }
                if (kk === '.') { b.setAttribute('aria-label', 'крапка'); }
                keys.appendChild(b);
            });
            if (sc.letters) {
                var lt = el('button', 'is-wide', 'літери');
                lt.type = 'button';
                lt.setAttribute('data-k', 'abc');
                keys.appendChild(lt);
            }
            var cb = el('button', null, 'C');
            cb.type = 'button';
            cb.setAttribute('data-k', 'C');
            cb.setAttribute('aria-label', 'стерти');
            keys.appendChild(cb);
        } else if (sc.notes) {
            keys.classList.add('is-notes');
            sc.notes.forEach(function (nt) {
                var b = el('button', null, nt + ' грн');
                b.type = 'button';
                b.setAttribute('data-set', String(nt));
                keys.appendChild(b);
            });
        }
        keys.addEventListener('click', function (e) {
            var b = e.target.closest('button');
            if (!b) { return; }
            var kk = b.getAttribute('data-k');
            var set = b.getAttribute('data-set');
            if (set !== null) { lcd.value = set; }
            else if (kk === 'C') { lcd.value = ''; }
            else if (lcd.value.length + kk.length <= lcd.maxLength) { lcd.value += kk; }
            Sound.tone(440, 0.05, 'square');
        });
        pad.appendChild(keys);
        var buy = el('button', 'bvs-buy', sc.buy);
        buy.type = 'button';
        buy.addEventListener('click', function () { send('buy', lcd.value); });
        pad.appendChild(buy);
        var claim = null;
        if (sc.claim) {
            claim = el('button', 'bvs-claim', 'Решта неправильна');
            claim.type = 'button';
            claim.addEventListener('click', function () { send('claim', lcd.value); });
            pad.appendChild(claim);
        }
        lcd.addEventListener('keydown', function (e) { if (e.key === 'Enter') { e.preventDefault(); send('buy', lcd.value); } });
        body.appendChild(pad);
        var stk = el('div', 'bvs-sticker');
        stk.appendChild(document.createTextNode(sc.sticker[0]));
        stk.appendChild(el('span', null, sc.sticker[1]));
        stk.appendChild(document.createTextNode(sc.sticker[2]));
        body.appendChild(stk);
        mach.appendChild(body);
        var tray = el('div', 'bvs-tray');
        tray.setAttribute('aria-label', 'Лоток автомата');
        tray.setAttribute('role', 'img');
        mach.appendChild(tray);
        stage.appendChild(mach);
        stage.appendChild(el('div', 'bvs-ground'));
        grid.appendChild(stage);

        // ----- бічна колонка (спільна для всіх сцен) -----
        var P = sidePanel(o, sc, {
            title: sc.good.charAt(0).toUpperCase() + sc.good.slice(1) + ': автомат перевірено!',
            again: 'Пройти ще раз (новий автомат)',
            busy: function () { return busy; },
            say: function (t) { msg.textContent = t; }
        });
        grid.appendChild(P.side);
        root.appendChild(grid);
        host.appendChild(root);
        var mentor = P.mentor, coll = P.coll, log = P.log;
        var found = 0;
        function updateSubmit(can) { P.update(found, can); }

        function drop(goods, change) {
            while (tray.firstChild) { tray.removeChild(tray.firstChild); }
            var items = [];
            for (var j = 0; j < Math.min(goods, 8); j++) { items.push(bottle(BOTTLE_COLORS[j % 3])); }
            if (change !== null && change !== undefined) {
                for (var c = 0; c < Math.min(4, Math.max(1, Math.round(change / 20))); c++) { items.push(coin()); }
                var lbl = el('span', 'bvs-tray__sum', 'решта ' + change + ' грн');
                items.push(lbl);
            }
            items.forEach(function (it, idx) {
                var d = el('div', 'bvs-drop');
                d.style.animationDelay = (idx * 0.12) + 's';
                d.appendChild(it);
                tray.appendChild(d);
                if (it.tagName && it.tagName.toLowerCase() === 'svg') { Sound.tone(300 + idx * 60, 0.1, 'triangle', idx * 0.12); }
            });
            tray.setAttribute('aria-label', 'Лоток: ' + (goods ? goods + ' шт.' : 'порожньо') + (change !== null && change !== undefined ? ', решта ' + change + ' грн' : ''));
        }
        function shake() {
            if (reduced) { return; }
            mach.classList.remove('is-shake');
            void mach.offsetWidth;
            mach.classList.add('is-shake');
        }

        function send(op, input, retry) {
            if (busy || P.done()) { return; }
            busy = true;
            buy.disabled = true;
            o.api('scene_act', { token: o.token, op: op, input: input }).then(function (r) {
                busy = false;
                buy.disabled = false;
                if (!r.ok) {
                    if (r.error === 'conflict' && !retry) { send(op, input, true); return; }
                    if (r.error === 'expired') { o.err('expired'); return; }
                    var t = { too_long: 'Задовге значення: не більше ' + (sc.max_input || 30) + ' символів.',
                        too_many_actions: 'Дій у цій спробі вже ' + sc.max_actions + '. Здайте роботу або почніть заново.',
                        already_checked: 'Роботу вже здано.', rate_limited: 'Забагато натискань за хвилину. Зачекайте трохи.' }[r.error];
                    msg.textContent = t || 'Автомат не відповідає. Спробуйте ще раз.';
                    msg.className = 'bvs-msg is-bad';
                    return;
                }
                var x = r.reaction;
                msg.textContent = (x.tone === 'bad' ? '⚠ ' : '') + x.text;
                msg.className = 'bvs-msg' + (x.tone === 'bad' ? ' is-bad' : '');
                if (x.wallet !== null && x.wallet !== undefined) { walletNum.textContent = String(x.wallet); }
                if (op !== 'refill' && x.result !== 'info') { drop(x.goods || 0, x.change); }
                if (x.result === 'info') {
                    found = r.found;
                    updateSubmit(r.can_submit);
                    return;
                }
                var shown = op === 'claim' ? 'решта ' + (input === '' ? '?' : input) : input;
                if (x.result === 'bug') {
                    shake();
                    Sound.tone(160, 0.35, 'sawtooth');
                    if (x.bug) {
                        log.add(shown, x.bug.title, true);
                        coll.add(x.bug);
                        stamp(stage, 'Знайдено поломку!');
                        pop(stage, lcd, '+1 поломка');
                        if (!reduced) { mentor.act('cheer', 1600); }
                        Sound.tone(660, 0.12, 'sine', 0.25); Sound.tone(880, 0.2, 'sine', 0.4);
                        mentor.say('Оце так! <b>' + x.bug.title + '</b>. ' + (x.bug.say || '') + ' Я записав це в колекцію.', 'wow');
                    } else {
                        log.add(shown, x.bug_title || 'поломка', true);
                        mentor.say('Цю поломку ви вже знайшли. Спробуйте щось інше.', 'neutral');
                    }
                } else if (x.result === 'useless') {
                    log.add(shown, 'майстер не погодився', null);
                    mentor.say(x.text, 'neutral');
                } else {
                    Sound.tone(520, 0.1);
                    if (!reduced) { mentor.act('jump', 600); }
                    // 1.1: правильна й поломана решта виглядають однаково — у журналі лише факт, без оцінки
                    log.add(shown, sc.claim && x.change !== null && x.change !== undefined ? 'решта ' + x.change + ' грн'
                        : (sc.claim ? 'гроші повернуто' : 'працює правильно'), sc.claim ? null : false);
                    mentor.say(sc.claim ? 'Порахуйте решту самі. Якщо автомат схибив, впишіть правильну суму й натисніть <b>«Решта неправильна»</b>.'
                        : 'Тут усе працює як на наліпці. Це теж корисно знати: так видно, де автомат на місці.', 'happy');
                }
                found = r.found;
                updateSubmit(r.can_submit);
            });
        }

        lcd.focus({ preventScroll: true });
    }

    /**
     * Спільна бічна колонка сцени: майстер Гайка з підказками, колекція, журнал, «Здати роботу» → фінал.
     * cfg: {title — заголовок фіналу, again — підпис повтору, busy() — сцена чекає сервера, say(text) — повідомлення сцени}.
     */
    function sidePanel(o, sc, cfg) {
        var done = false;
        var finishing = false;
        var hints = null;
        var hintN = 0;
        var side = el('aside', 'bvs-side');
        var mentor = new Mentor();
        var mc = el('section', 'bvs-card');
        mc.appendChild(el('h3', null, 'Майстер Гайка'));
        var mm = el('div', 'bvs-mentor');
        mm.appendChild(mentor.svg);
        var bub = el('div', 'bvs-bubble');
        bub.setAttribute('aria-live', 'polite');
        bub.appendChild(mentor.bubble);
        var hintBtn = el('button', 'bvs-hintbtn', 'Підказка (мінус одна зірка)');
        hintBtn.type = 'button';
        bub.appendChild(hintBtn);
        mm.appendChild(bub);
        mc.appendChild(mm);
        side.appendChild(mc);

        var coll = new Collection(sc.total);
        var cc = el('section', 'bvs-card');
        // «2 / 5», не «2 з 5»: у верхньому регістрі Rubik літера «З» схожа на цифру 3
        var ch = el('h3', null, 'Зібрані поломки: ');
        ch.appendChild(coll.count);
        ch.appendChild(document.createTextNode(' / ' + sc.total));
        cc.appendChild(ch);
        cc.appendChild(coll.list);
        side.appendChild(cc);

        var log = new Log();
        var lc = el('section', 'bvs-card');
        lc.appendChild(el('h3', null, 'Що ви вводили'));
        lc.appendChild(log.list);
        side.appendChild(lc);

        var submit = el('button', 'bvs-submit');
        submit.type = 'button';
        side.appendChild(submit);
        function update(found, can) {
            submit.disabled = !can;
            submit.textContent = can ? 'Здати роботу майстру (знайдено ' + found + ' з ' + sc.total + ')'
                : 'Здати роботу майстру (потрібно знайти ' + sc.min_found + ')';
        }
        update(0, false);
        mentor.say(sc.intro, 'happy');
        if (!reduced) { mentor.act('wave', 1900); }

        hintBtn.addEventListener('click', function () {
            if (hints) {
                mentor.say(hints[hintN % hints.length], 'happy');
                hintN++;
                if (!reduced) { mentor.act('wave', 1900); }
                return;
            }
            hintBtn.disabled = true;
            o.api('hint', { token: o.token }).then(function (r) {
                hintBtn.disabled = false;
                if (!r.ok) { o.toast('Підказка недоступна'); return; }
                hints = (r.hints && r.hints.length) ? r.hints : [r.hint];
                hintBtn.textContent = 'Ще підказка (безкоштовно)';
                mentor.say(hints[0], 'happy');
                hintN = 1;
                if (!reduced) { mentor.act('wave', 1900); }
            });
        });

        submit.addEventListener('click', function () {
            if (cfg.busy() || done || finishing) { return; }
            finishing = true;
            submit.disabled = true;
            o.api('scene_finish', { token: o.token }).then(function (r) {
                finishing = false;
                if (!r.ok) {
                    if (r.error === 'not_enough') { update(0, false); cfg.say('Щоб здати роботу, знайдіть поломок: щонайменше ' + r.min_found + '.'); return; }
                    if (r.error === 'expired') { o.err('expired'); return; }
                    submit.disabled = false;
                    o.toast('Не вдалося здати роботу. Спробуйте ще раз.');
                    return;
                }
                done = true;
                o.setWho(r);
                var s = r.summary || {};
                var chips = ['Поломок: ' + s.found + ' з ' + s.total];
                var e = r.earned || (r.daily ? null : r.would_earn);   // гостю Поломки дня XP не обіцяємо
                if (e && e.xp > 0) { chips.unshift('+' + e.xp + ' XP'); }
                if (r.earned && r.earned.coins > 0) { chips.push('+' + r.earned.coins + (r.earned.coins % 10 >= 2 && r.earned.coins % 10 <= 4 && (r.earned.coins % 100 < 12 || r.earned.coins % 100 > 14) ? ' монети' : (r.earned.coins % 10 === 1 && r.earned.coins % 100 !== 11 ? ' монета' : ' монет'))); }
                finale({
                    title: o.daily ? o.daily.title + ': роботу здано!' : cfg.title, stars: r.stars || 0, chips: chips, word: o.word,
                    note: (r.explain || '') + (r.hint_used ? ' Підказку використано.' : '') + (r.daily ? ' Завтра буде нова поломка.' : ''),
                    extra: function (b) { o.reward(b, r); },
                    actions: [o.nextUrl ? { text: 'Наступна місія', href: o.nextUrl, primary: true } : null,
                        { text: o.daily ? 'Зіграти ще раз' : cfg.again, onClick: o.onRestart, primary: !o.nextUrl },
                        { text: 'До карти', href: 'bugville.php' }].filter(Boolean)
                });
            });
        });

        return { side: side, mentor: mentor, coll: coll, log: log, update: update, done: function () { return done || finishing; } };
    }

    /** Знахідка(и) від сервера: штамп, сплив, колекція, реакція майстра. Спільне для сцен. */
    function showBugs(P, stage, anchor, x, shownInput) {
        var list = x.bugs || (x.bug ? [x.bug] : []);
        Sound.tone(160, 0.35, 'sawtooth');
        if (list.length) {
            list.forEach(function (b) { P.log.add(shownInput, b.title, true); P.coll.add(b); });
            stamp(stage, list.length > 1 ? 'Знайдено ' + list.length + ' поломки!' : 'Знайдено поломку!');
            pop(stage, anchor, '+' + list.length + ' поломка');
            if (!reduced) { P.mentor.act('cheer', 1600); }
            Sound.tone(660, 0.12, 'sine', 0.25); Sound.tone(880, 0.2, 'sine', 0.4);
            P.mentor.say('Оце так! <b>' + list[0].title + '</b>. ' + (list[0].say || '') + ' Я записав це в колекцію.', 'wow');
        } else {
            P.log.add(shownInput, x.bug_title || 'поломка', true);
            P.mentor.say('Цю поломку ви вже знайшли. Спробуйте щось інше.', 'neutral');
        }
    }

    // ---------- Сцена «Пошта» (form_scene) ----------
    var POST_SVG = '<svg class="bvs-post__svg" viewBox="0 0 120 70" aria-hidden="true" focusable="false">'
        + '<rect x="6" y="22" width="108" height="46" rx="4" fill="#1b2a6e" stroke="#3a4a9a" stroke-width="2"/>'
        + '<path d="M2 24 L60 2 L118 24 Z" fill="#ff6b5b" stroke="#3a2a00" stroke-width="2" stroke-linejoin="round"/>'
        + '<rect x="24" y="30" width="72" height="12" rx="3" fill="#ffd23f"/><text x="60" y="39.5" text-anchor="middle" font-size="8" font-weight="800" fill="#3a2a00" font-family="system-ui">ПОШТА</text>'
        + '<rect x="50" y="46" width="20" height="22" rx="2" fill="#0f1a3d"/><rect x="14" y="48" width="14" height="10" fill="#ffd23f"/><rect x="92" y="48" width="14" height="10" fill="#ffd23f"/></svg>';
    var ENVELOPE = '<svg viewBox="0 0 28 20" width="28" height="20" aria-hidden="true" focusable="false"><rect x="1" y="1" width="26" height="18" rx="2" fill="#fffbe0" stroke="#3a2a00" stroke-width="1.5"/><path d="M1 2 L14 12 L27 2" fill="none" stroke="#3a2a00" stroke-width="1.5"/></svg>';

    function form(o) {
        var sc = o.scene;
        var busy = false;
        var host = o.host;
        while (host.firstChild) { host.removeChild(host.firstChild); }
        host.setAttribute('aria-busy', 'false');
        var root = el('div', 'bvs');
        var top = el('div', 'bvs-top');
        var stats = el('div', 'bvs-stats');
        var chipS = el('div', 'bvs-chip');
        chipS.appendChild(Sound.button());
        stats.appendChild(chipS);
        top.appendChild(stats);
        root.appendChild(top);

        var grid = el('div', 'bvs-grid');
        var stage = el('section', 'bvs-scene bvs-post');
        stage.setAttribute('aria-label', 'Пошта Багвіля: бланк «' + sc.title + '»');
        stage.appendChild(svgEl(BACKDROP));
        var office = el('div', 'bvs-post__office');
        office.appendChild(svgEl(POST_SVG));
        stage.appendChild(office);

        var paper = el('form', 'bvs-paper');
        paper.noValidate = true;
        paper.setAttribute('autocomplete', 'off');
        var head = el('div', 'bvs-paper__head');
        head.appendChild(el('span', 'bvs-paper__org', 'Пошта Багвіля'));
        head.appendChild(el('h3', 'bvs-paper__title', sc.title));
        paper.appendChild(head);
        paper.appendChild(el('p', 'bvs-paper__note', sc.note));
        var inputs = {};
        var errs = {};
        var initial = {};
        sc.fields.forEach(function (f, i) {
            var row = el('div', 'bvs-field');
            var id = 'bvs-f' + i;
            var lab = el('label', null, f.label + (f.req ? ' *' : ''));
            lab.htmlFor = id;
            row.appendChild(lab);
            var inp = el('input', 'bvs-field__input');
            inp.id = id;
            inp.type = 'text';
            inp.value = f.value;
            inp.maxLength = sc.max_input || 30;
            inp.spellcheck = false;
            inp.setAttribute('autocomplete', 'off');
            inp.setAttribute('autocapitalize', 'off');
            if (f.input !== 'text') { inp.inputMode = f.input === 'numeric' ? 'numeric' : f.input; }
            if (f.req) { inp.setAttribute('aria-required', 'true'); }
            row.appendChild(inp);
            var meta = el('div', 'bvs-field__meta');
            var note = el('span', 'bvs-field__note', f.note || '');
            note.id = id + '-n';
            meta.appendChild(note);
            if (f.max) {
                var cnt = el('span', 'bvs-field__count');
                cnt.setAttribute('aria-hidden', 'true');
                var upd = function () { var n = inp.value.trim().length; cnt.textContent = n + ' / ' + f.max; cnt.classList.toggle('is-over', n > f.max); };
                inp.addEventListener('input', upd);
                upd();
                meta.appendChild(cnt);
            }
            row.appendChild(meta);
            var er = el('p', 'bvs-field__err');
            er.id = id + '-e';
            er.hidden = true;
            row.appendChild(er);
            inp.setAttribute('aria-describedby', note.id + ' ' + er.id);
            paper.appendChild(row);
            inputs[f.key] = inp;
            errs[f.key] = er;
            initial[f.key] = f.value;
        });
        var send = el('button', 'bvs-buy', 'Надіслати');
        send.type = 'submit';
        paper.appendChild(send);
        var msg = el('div', 'bvs-msg', 'Змініть бланк як завгодно й натисніть «Надіслати».');
        msg.setAttribute('aria-live', 'polite');
        msg.setAttribute('role', 'status');
        paper.appendChild(msg);
        stage.appendChild(paper);

        var jour = el('div', 'bvs-journal');
        jour.appendChild(el('h3', null, 'Журнал пошти'));
        var jl = el('ul', 'bvs-journal__list');
        jl.appendChild(el('li', 'bvs-journal__empty', 'Поки що жодного запису.'));
        jour.appendChild(jl);
        stage.appendChild(jour);
        stage.appendChild(el('div', 'bvs-ground'));
        grid.appendChild(stage);

        var P = sidePanel(o, sc, { title: '«' + sc.title + '»: бланк перевірено!', again: 'Пройти ще раз (новий бланк)',
            busy: function () { return busy; }, say: function (t) { msg.textContent = t; } });
        grid.appendChild(P.side);
        root.appendChild(grid);
        host.appendChild(root);

        function changed(vals) {
            var parts = [];
            sc.fields.forEach(function (f) {
                if (vals[f.key] !== initial[f.key]) {
                    var v = vals[f.key];
                    parts.push(f.label + ': ' + (v === '' ? '(порожньо)' : (v.trim() === '' ? '(пробіли)' : v)));
                }
            });
            return parts.length ? parts.join('; ') : 'без змін';
        }
        function record(rec) {
            var empty = jl.querySelector('.bvs-journal__empty');
            if (empty) { jl.removeChild(empty); }
            var li = el('li', 'bvs-drop');
            li.appendChild(svgEl(ENVELOPE));
            li.appendChild(el('b', null, '№ ' + rec.no));
            li.appendChild(el('span', null, rec.text));
            jl.insertBefore(li, jl.firstChild);
            Sound.tone(520, 0.08, 'triangle');
        }

        paper.addEventListener('submit', function (e) {
            e.preventDefault();
            go(false);
        });
        function go(retry) {
            if (busy || P.done()) { return; }
            var vals = {};
            Object.keys(inputs).forEach(function (k) { vals[k] = inputs[k].value; });
            busy = true;
            send.disabled = true;
            o.api('scene_act', { token: o.token, op: 'submit', input: vals }).then(function (r) {
                busy = false;
                send.disabled = false;
                if (!r.ok) {
                    if (r.error === 'conflict' && !retry) { busy = false; go(true); return; }
                    if (r.error === 'expired') { o.err('expired'); return; }
                    var t = { too_long: 'Задовге значення: не більше ' + (sc.max_input || 30) + ' символів у полі.',
                        too_many_actions: 'Дій у цій спробі вже ' + sc.max_actions + '. Здайте роботу або почніть заново.',
                        already_checked: 'Роботу вже здано.', rate_limited: 'Забагато натискань за хвилину. Зачекайте трохи.' }[r.error];
                    msg.textContent = t || 'Пошта не відповідає. Спробуйте ще раз.';
                    msg.className = 'bvs-msg is-bad';
                    return;
                }
                var x = r.reaction;
                Object.keys(errs).forEach(function (k) { errs[k].hidden = true; errs[k].textContent = ''; inputs[k].removeAttribute('aria-invalid'); });
                var fe = x.field_errors || {};
                Object.keys(fe).forEach(function (k) {
                    if (!errs[k]) { return; }
                    errs[k].textContent = '✗ ' + fe[k];
                    errs[k].hidden = false;
                    inputs[k].setAttribute('aria-invalid', 'true');
                });
                msg.textContent = (x.tone === 'bad' ? '⚠ ' : (x.accepted ? '✓ ' : '✗ ')) + x.text;
                msg.className = 'bvs-msg' + (x.tone === 'bad' ? ' is-bad' : (x.accepted ? '' : ' is-refused'));
                if (x.record) { record(x.record); }
                var shown = changed(vals);
                if (x.result === 'bug') {
                    if (!reduced) { paper.classList.remove('is-shake'); void paper.offsetWidth; paper.classList.add('is-shake'); }
                    showBugs(P, stage, send, x, shown);
                } else if (x.result === 'ok') {
                    if (!reduced) { P.mentor.act('jump', 600); }
                    P.log.add(shown, x.accepted ? 'прийнято, усе правильно' : 'пошта правильно відхилила', false);
                    P.mentor.say(x.accepted ? 'Бланк правильний, і пошта його прийняла. Тепер спробуйте щось зіпсувати.'
                        : 'Пошта помітила проблему й не пропустила бланк. Тут вона працює правильно.', 'happy');
                }
                P.update(r.found, r.can_submit);
            });
        }
        var first = inputs[sc.fields[0].key];
        if (first) { first.focus({ preventScroll: true }); }
    }

    // ---------- Сцена «Бібліотека» (table_scene) ----------
    var SHELF_SVG = '<svg class="bvs-lib__svg" viewBox="0 0 160 54" aria-hidden="true" focusable="false">'
        + '<rect x="2" y="48" width="156" height="5" rx="2" fill="#8a5a00"/><rect x="2" y="2" width="156" height="5" rx="2" fill="#8a5a00"/>'
        + '<g stroke="#3a2a00" stroke-width="1.5"><rect x="10" y="12" width="12" height="36" fill="#ff6b5b"/><rect x="23" y="16" width="10" height="32" fill="#ffd23f"/>'
        + '<rect x="34" y="10" width="14" height="38" fill="#4fe0b6"/><rect x="49" y="14" width="10" height="34" fill="#9be15d"/><rect x="60" y="12" width="12" height="36" fill="#ff9f43"/>'
        + '<rect x="88" y="16" width="12" height="32" fill="#ffd23f"/><rect x="101" y="11" width="14" height="37" fill="#ff6b5b"/><rect x="116" y="14" width="10" height="34" fill="#4fe0b6"/>'
        + '<rect x="127" y="12" width="12" height="36" fill="#9be15d"/><rect x="140" y="16" width="10" height="32" fill="#ff9f43"/></g>'
        + '<path d="M74 48 L86 20 L90 22 L79 48 Z" fill="#fffbe0" stroke="#3a2a00" stroke-width="1.5"/></svg>';

    function table(o) {
        var sc = o.scene;
        var busy = false;
        var locked = false;
        var host = o.host;
        while (host.firstChild) { host.removeChild(host.firstChild); }
        host.setAttribute('aria-busy', 'false');
        var root = el('div', 'bvs');
        var top = el('div', 'bvs-top');
        var stats = el('div', 'bvs-stats');
        var chipS = el('div', 'bvs-chip');
        chipS.appendChild(Sound.button());
        stats.appendChild(chipS);
        top.appendChild(stats);
        root.appendChild(top);

        var grid = el('div', 'bvs-grid');
        var stage = el('section', 'bvs-scene bvs-lib');
        stage.setAttribute('aria-label', 'Бібліотека Багвіля: таблиця');
        stage.appendChild(svgEl(BACKDROP));
        var shelfBox = el('div', 'bvs-lib__shelf');
        shelfBox.appendChild(svgEl(SHELF_SVG));
        stage.appendChild(shelfBox);
        var book = el('div', 'bvs-ledger');
        book.appendChild(el('span', 'bvs-paper__org', 'Бібліотека Багвіля'));
        book.appendChild(el('p', 'bvs-ledger__cap', sc.caption));
        var wrap = el('div', 'bvs-ledger__wrap');
        var tbl = el('table', 'bvs-ledger__table');
        var thead = el('thead');
        var hr = el('tr');
        sc.cols.forEach(function (c) { var th = el('th', null, c); th.scope = 'col'; hr.appendChild(th); });
        thead.appendChild(hr);
        tbl.appendChild(thead);
        var tbody = el('tbody');
        var cells = {};
        var marked = [];
        sc.rows.forEach(function (row, ri) {
            var tr = el('tr');
            row.forEach(function (v, ci) {
                var td = el('td');
                if (sc.mode === 'mark') {
                    var b = el('button', 'bvs-cell', v === '' ? ' ' : v);
                    b.type = 'button';
                    b.setAttribute('aria-pressed', 'false');
                    b.setAttribute('aria-label', sc.cols[ci] + ', рядок ' + (ri + 1) + ': ' + (v === '' ? 'порожньо' : v));
                    b.addEventListener('click', function () { toggle(ri, ci); });
                    cells[ri + ':' + ci] = b;
                    td.appendChild(b);
                } else {
                    td.textContent = v;
                }
                tr.appendChild(td);
            });
            tbody.appendChild(tr);
        });
        tbl.appendChild(tbody);
        wrap.appendChild(tbl);
        book.appendChild(wrap);

        var msg = el('div', 'bvs-msg', sc.mode === 'mark' ? 'Позначте до ' + sc.max_marks + ' клітинок, які здаються неправильними.' : 'Запишіть звіт для майстра.');
        msg.setAttribute('aria-live', 'polite');
        msg.setAttribute('role', 'status');
        var act = el('div', 'bvs-ledger__act');
        var go;
        var rep = {};
        if (sc.mode === 'mark') {
            go = el('button', 'bvs-buy', 'Перевірити позначене');
            go.type = 'button';
            go.addEventListener('click', function () { send('check', marked.slice()); });
            var clr = el('button', 'bvs-btn bvs-btn--ghost bvs-ledger__clear', 'Зняти позначки');
            clr.type = 'button';
            clr.addEventListener('click', function () { marked.slice().forEach(function (m) { toggle(m[0], m[1]); }); });
            act.appendChild(go);
            act.appendChild(clr);
        } else {
            var rf = el('form', 'bvs-report');
            rf.noValidate = true;
            [['expected', 'Очікувано'], ['actual', 'Фактично']].forEach(function (p, i) {
                var row = el('div', 'bvs-field');
                var lab = el('label', null, p[1] + ':');
                lab.htmlFor = 'bvs-rep' + i;
                var inp = el('input', 'bvs-field__input');
                inp.id = 'bvs-rep' + i;
                inp.type = 'text';
                inp.maxLength = sc.max_input || 30;
                inp.setAttribute('autocomplete', 'off');
                row.appendChild(lab);
                row.appendChild(inp);
                rf.appendChild(row);
                rep[p[0]] = inp;
            });
            go = el('button', 'bvs-buy', 'Записати звіт');
            go.type = 'submit';
            rf.appendChild(go);
            rf.addEventListener('submit', function (e) { e.preventDefault(); send('report', { expected: rep.expected.value, actual: rep.actual.value }); });
            act.appendChild(rf);
        }
        book.appendChild(act);
        book.appendChild(msg);
        stage.appendChild(book);
        stage.appendChild(el('div', 'bvs-ground'));
        grid.appendChild(stage);

        var P = sidePanel(o, sc, { title: 'Таблицю бібліотеки перевірено!', again: 'Пройти ще раз (нова таблиця)',
            busy: function () { return busy; }, say: function (t) { msg.textContent = t; } });
        grid.appendChild(P.side);
        root.appendChild(grid);
        host.appendChild(root);

        function toggle(r, c) {
            if (busy || locked || P.done()) { return; }
            var key = r + ':' + c;
            var b = cells[key];
            if (!b || b.classList.contains('is-found')) { return; }
            var i = -1;
            marked.forEach(function (m, j) { if (m[0] === r && m[1] === c) { i = j; } });
            if (i >= 0) {
                marked.splice(i, 1);
                b.setAttribute('aria-pressed', 'false');
            } else {
                if (marked.length >= sc.max_marks) { msg.textContent = 'За раз можна позначити не більше ' + sc.max_marks + ' клітинок.'; return; }
                marked.push([r, c]);
                b.setAttribute('aria-pressed', 'true');
                b.classList.remove('is-wrong');
            }
            go.textContent = 'Перевірити позначене' + (marked.length ? ' (' + marked.length + ')' : '');
            Sound.tone(440, 0.05, 'square');
        }
        function describe(op, input) {
            if (op === 'report') { return 'Очікувано: ' + input.expected + ' / Фактично: ' + input.actual; }
            return input.map(function (m) {
                var v = sc.rows[m[0]][m[1]];
                return '«' + sc.rows[m[0]][0] + '» · ' + sc.cols[m[1]] + ': ' + (v === '' ? '(порожньо)' : v);
            }).join('; ');
        }
        function send(op, input, retry) {
            if (busy || P.done()) { return; }
            busy = true;
            go.disabled = true;
            o.api('scene_act', { token: o.token, op: op, input: input }).then(function (r) {
                busy = false;
                go.disabled = locked;
                if (!r.ok) {
                    if (r.error === 'conflict' && !retry) { send(op, input, true); return; }
                    if (r.error === 'expired') { o.err('expired'); return; }
                    var t = { too_long: 'Задовге значення або забагато позначок.', too_many_actions: 'Дій у цій спробі вже ' + sc.max_actions + '. Здайте роботу або почніть заново.',
                        already_checked: 'Роботу вже здано.', rate_limited: 'Забагато натискань за хвилину. Зачекайте трохи.' }[r.error];
                    msg.textContent = t || 'Бібліотека не відповідає. Спробуйте ще раз.';
                    msg.className = 'bvs-msg is-bad';
                    return;
                }
                var x = r.reaction;
                msg.textContent = (x.tone === 'bad' ? '⚠ ' : '') + x.text + (x.wrong_left !== undefined && x.result !== 'bug' ? ' Хибних позначок ще можна: ' + x.wrong_left + '.' : '');
                msg.className = 'bvs-msg' + (x.tone === 'bad' ? ' is-bad' : '');
                (x.marks || []).forEach(function (m) {
                    var b = cells[m.r + ':' + m.c];
                    if (!b) { return; }
                    b.setAttribute('aria-pressed', 'false');
                    if (m.res === 'bug' || m.res === 'repeat') {
                        b.classList.add('is-found');
                        b.setAttribute('aria-label', b.getAttribute('aria-label') + ' — помилку знайдено');
                    } else {
                        b.classList.add('is-wrong');
                    }
                });
                if (op === 'check') { marked = []; go.textContent = 'Перевірити позначене'; }
                if (x.locked) {
                    locked = true;
                    go.disabled = true;
                    P.mentor.say('Забагато хибних позначок. Якщо вже є знахідка — здайте роботу, інакше почніть з <b>новою таблицею</b>.', 'neutral');
                }
                if (x.result === 'info') { P.update(r.found, r.can_submit); return; }
                var shown = describe(op, input);
                if (x.result === 'bug') {
                    if (!reduced) { book.classList.remove('is-shake'); void book.offsetWidth; book.classList.add('is-shake'); }
                    showBugs(P, stage, go, x, shown);
                } else if (x.result === 'useless') {
                    P.log.add(shown, op === 'report' ? 'майстер не погодився' : 'тут усе гаразд', null);
                    if (!x.locked) { P.mentor.say(x.text, 'neutral'); }
                } else {
                    P.log.add(shown, x.text, null);
                }
                P.update(r.found, r.can_submit);
            });
        }
        var firstBtn = tbody.querySelector('button') || rep.expected;
        if (firstBtn) { firstBtn.focus({ preventScroll: true }); }
    }

    window.BVScene = { machine: machine, form: form, table: table, Mentor: Mentor, Collection: Collection, Log: Log, finale: finale, stamp: stamp, pop: pop, Sound: Sound };
})();

(function () {
    'use strict';

    var CSRF = (document.querySelector('meta[name="csrf-token"]') || {}).content || '';
    var reduced = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    function el(tag, cls, text) {
        var n = document.createElement(tag);
        if (cls) { n.className = cls; }
        if (text !== undefined && text !== null) { n.textContent = String(text); }
        return n;
    }

    function toast(msg) {
        var t = document.getElementById('bv-toast');
        if (!t) { return; }
        t.textContent = msg;
        t.hidden = false;
        clearTimeout(toast.timer);
        toast.timer = setTimeout(function () { t.hidden = true; }, 3000);
    }

    /** Новини прогресу акаунта (звання, значки) з відповіді API (r.progress) — елемент або null. */
    function progressNews(p) {
        if (!p) { return null; }
        var lines = [];
        if (p.rank_up && p.rank) { lines.push('🎖 Нове звання: ' + p.rank.title + '!'); }
        (p.new_badges || []).forEach(function (b) { lines.push('★ Новий значок: ' + b.title + ' — ' + b.description); });
        if (p.daily && p.streak) {   // лише після Поломки дня: спокійно, без «втратили»
            if (p.streak.restarted) { lines.push('Нова серія починається сьогодні!'); }
            if (p.streak.rested) { lines.push('Пропущений день став вихідним — серія триває.'); }
            lines.push('Днів поспіль: ' + p.streak.current + '. Найкраща серія: ' + p.streak.best + '.');
        }
        if (!lines.length) { return null; }
        var box = el('div', 'bv-news');
        box.setAttribute('role', 'status');
        lines.forEach(function (t) { box.appendChild(el('p', null, t)); });
        if (p.rank_up || (p.new_badges || []).length) {   // свято: нове звання або значок
            box.classList.add('is-celebrate');
            setTimeout(function () { confetti(box.isConnected ? box : null, 46); }, 60);
        }
        return box;
    }

    /** Конфеті з точки (центр елемента або верх екрана). Лише декор: aria-hidden, без reduced-motion, саме прибирається. */
    var CONFETTI_COLORS = ['#2116ad', '#f2b632', '#e4572e', '#4caf7a', '#4c43d8'];
    function confetti(anchor, count) {
        if (reduced) { return; }
        var w = window.innerWidth, h = window.innerHeight;
        var x = w / 2, y = h * 0.3;
        if (anchor) {
            var r = anchor.getBoundingClientRect();
            if (r.bottom > 0 && r.top < h) { x = r.left + r.width / 2; y = r.top + Math.min(r.height / 2, 40); }
        }
        var layer = el('div', 'bv-confetti');
        layer.setAttribute('aria-hidden', 'true');
        for (var i = 0; i < (count || 36); i++) {
            var c = el('i');
            var a = Math.random() * Math.PI * 2, d = 80 + Math.random() * Math.min(220, w * 0.45);
            c.style.cssText = '--x:' + x + 'px;--y:' + y + 'px;--dx:' + Math.round(Math.cos(a) * d) + 'px;--dy:' + Math.round(Math.sin(a) * d * 0.7 + 140 + Math.random() * 120)
                + 'px;--r:' + Math.round(Math.random() * 720 - 360) + 'deg;--t:' + (900 + Math.round(Math.random() * 700)) + 'ms;background:' + CONFETTI_COLORS[i % CONFETTI_COLORS.length]
                + (i % 3 === 0 ? ';border-radius:50%;width:8px;height:8px' : '');
            layer.appendChild(c);
        }
        document.body.appendChild(layer);
        setTimeout(function () { layer.remove(); }, 1800);
    }
    /** Перезапуск короткої CSS-анімації класом (is-turn, is-oops). */
    function replay(node, cls) {
        node.classList.remove(cls);
        void node.offsetWidth;
        node.classList.add(cls);
        clearTimeout(node.bvReplay);
        node.bvReplay = setTimeout(function () { node.classList.remove(cls); }, 1500);
    }

    // ---------- Шапка ----------
    var back = document.querySelector('.bv-back');
    if (back) {
        back.addEventListener('click', function (e) {
            var ref = document.referrer;
            try {
                if (ref && new URL(ref).origin === location.origin && history.length > 1) {
                    e.preventDefault();
                    history.back();
                }
            } catch (err) { /* лишаємо резервну адресу */ }
        });
    }
    var share = document.querySelector('.bv-share');
    if (share) {
        share.addEventListener('click', function () {
            var data = { title: document.title, url: location.href.replace(/[?&]resume=[^&]*/, '') };
            if (navigator.share) {
                navigator.share(data).catch(function () { /* скасовано */ });
                return;
            }
            if (navigator.clipboard && navigator.clipboard.writeText) {
                navigator.clipboard.writeText(data.url).then(function () { toast('Посилання скопійовано'); },
                    function () { toast(data.url); });
            } else {
                toast(data.url);
            }
        });
    }

    // ---------- Перша сторінка (Етап 0): будинок → шлях його місій. Без JS видно всі шляхи; стан (відкрито / закрито) — із сервера ----------
    var street = document.querySelector('.bvh-street');
    if (street) {
        var blds = street.querySelectorAll('.bvh-bld');
        var showLevel = function (lv, focusPanel) {
            blds.forEach(function (b) { b.setAttribute('aria-pressed', b.getAttribute('data-level') === lv ? 'true' : 'false'); });
            document.querySelectorAll('.bvh-path').forEach(function (p) { p.hidden = p.getAttribute('data-level') !== lv; });
            var panel = document.getElementById('bvh-p' + lv);
            if (focusPanel && panel) {
                var r = panel.getBoundingClientRect();
                if (r.top > window.innerHeight - 80) { panel.scrollIntoView({ behavior: reduced ? 'auto' : 'smooth', block: 'start' }); }
            }
        };
        var pressed = street.querySelector('.bvh-bld[aria-pressed="true"]') || blds[0];
        if (pressed) { showLevel(pressed.getAttribute('data-level'), false); }
        street.addEventListener('click', function (e) {
            var b = e.target.closest('.bvh-bld');
            if (b) { showLevel(b.getAttribute('data-level'), true); }
        });
    }

    // ---------- Друк грамоти ----------
    document.querySelectorAll('[data-print]').forEach(function (b) {
        b.addEventListener('click', function () { window.print(); });
    });

    function post(action, data) {
        var body = Object.assign({ action: action, lang: 'uk' }, data || {});
        return fetch('bv-api.php', {
            method: 'POST',
            credentials: 'same-origin',
            headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': CSRF },
            body: JSON.stringify(body)
        }).then(function (r) {
            return r.json().catch(function () { return { ok: false, error: 'unavailable' }; });
        }, function () { return { ok: false, error: 'network' }; });
    }

    // ---------- Іспит (крок 4) ----------
    var exam = document.getElementById('bv-exam');
    if (exam) {
        (function () {
            var box = document.getElementById('bv-scene');
            var examId = parseInt(exam.getAttribute('data-exam'), 10);
            var minAge = exam.getAttribute('data-min-age') || '16';
            var token = '';
            var tasks = [];
            var idx = 0;
            var busy = false;
            var EXAM_ERR = {
                rate_limited: 'Забагато дій за хвилину. Зачекайте трохи.',
                expired: 'Час на іспит минув. Завершіть його, щоб побачити результат.',
                exam_unavailable: 'Іспит зараз недоступний.',
                locked: 'Цей будинок ще закритий. Спершу пройдіть попередні місії.',
                csrf: 'Сторінка застаріла. Оновіть її.',
                cross_site: 'Сторінка застаріла. Оновіть її.'
            };

            function clear() { while (box.firstChild) { box.removeChild(box.firstChild); } box.setAttribute('aria-busy', 'false'); }
            function btn(text, cls, onClick) {
                var b = el('button', 'bv-btn' + (cls ? ' ' + cls : ''), text);
                b.type = 'button';
                b.addEventListener('click', onClick);
                return b;
            }
            function link(text, href, cls) {
                var a = el('a', 'bv-btn' + (cls ? ' ' + cls : ''), text);
                a.href = href;
                return a;
            }
            function localTime(utc) {
                var d = new Date(String(utc).replace(' ', 'T') + 'Z');
                return isNaN(d) ? utc : d.toLocaleTimeString('uk-UA', { hour: '2-digit', minute: '2-digit' });
            }

            function intro(s) {
                clear();
                if (!s.age_confirmed) {
                    box.appendChild(el('p', null, 'Іспити складають гравці з акаунтом від ' + minAge + ' років: так результат і грамота збережуться.'));
                    var row = el('p', 'bv-actions');
                    if (s.logged_in) {
                        row.appendChild(btn('Мені виповнилося ' + minAge + ' років', '', function () {
                            post('confirm_age', { confirm: true }).then(function (r) {
                                if (r.ok) { load(); } else { toast('Не вдалося підтвердити'); }
                            });
                        }));
                    } else {
                        row.appendChild(link('Зареєструватись', exam.getAttribute('data-register') || 'register.php'));
                        row.appendChild(link('Увійти', exam.getAttribute('data-login') || 'login.php', 'bv-btn--ghost'));
                    }
                    box.appendChild(row);
                    return;
                }
                if (s.passed) {
                    box.appendChild(el('p', 'bv-reward', '✓ Іспит уже складено.'));
                    if (s.certificate) {
                        var rowC = el('p', 'bv-actions');
                        rowC.appendChild(link('Грамота', 'bugville-certificate.php?c=' + encodeURIComponent(s.certificate)));
                        box.appendChild(rowC);
                    }
                    box.appendChild(el('p', 'bv-muted', 'Можна скласти ще раз для тренування; нагорода дається лише за перше складання.'));
                }
                if (s.retry_at && !s.open) {
                    box.appendChild(el('p', null, 'Наступна спроба — після ' + localTime(s.retry_at) + '. Поки що можна потренуватися в місіях.'));
                    var rowR = el('p', 'bv-actions');
                    rowR.appendChild(link('До карти', 'bugville.php', 'bv-btn--ghost'));
                    box.appendChild(rowR);
                    return;
                }
                var rowS = el('p', 'bv-actions');
                rowS.appendChild(btn(s.open ? 'Продовжити іспит' : 'Почати іспит', '', begin));
                box.appendChild(rowS);
            }

            function load() {
                post('exam_state', { exam: examId }).then(function (s) {
                    if (!s.ok) { clear(); box.appendChild(el('p', 'bv-msg is-bad', EXAM_ERR[s.error] || 'Іспит зараз недоступний.')); return; }
                    intro(s);
                });
            }

            function begin() {
                if (busy) { return; }
                busy = true;
                post('exam_start', { exam: examId }).then(function (r) {
                    busy = false;
                    if (!r.ok) {
                        if (r.error === 'cooldown') { load(); return; }
                        toast(EXAM_ERR[r.error] || 'Не вдалося почати іспит');
                        return;
                    }
                    token = r.token;
                    tasks = r.tasks || [];
                    idx = 0;
                    while (idx < tasks.length && tasks[idx].answered) { idx++; }
                    show();
                });
            }

            function show() {
                clear();
                if (idx >= tasks.length) { finishView(); return; }
                var t = tasks[idx];
                var form = el('form', 'bv-scene');
                form.noValidate = true;
                var h = el('h2', 'bv-result__sub', 'Завдання ' + (idx + 1) + ' з ' + tasks.length);
                h.tabIndex = -1;
                form.appendChild(h);
                form.appendChild(el('p', 'bv-scene__text', t.scene.text));
                if (t.scene.items && t.scene.items.length) {
                    var ul = el('ul', 'bv-scene__items');
                    t.scene.items.forEach(function (it) { ul.appendChild(el('li', null, it.text)); });
                    form.appendChild(ul);
                }
                var fs = el('fieldset', 'bv-options');
                fs.appendChild(el('legend', 'bv-question', t.scene.question || 'Ваша відповідь'));
                (t.scene.options || []).forEach(function (o, i) {
                    var lab = el('label', 'bv-option');
                    var inp = el('input');
                    inp.type = 'radio';
                    inp.name = 'bv-answer';
                    inp.value = o.id;
                    inp.id = 'bv-e' + idx + '-' + i;
                    lab.appendChild(inp);
                    lab.appendChild(el('span', 'bv-option__text', o.text));
                    fs.appendChild(lab);
                });
                if (t.scene.input === 'number') {
                    var num = el('input', 'bv-input');
                    num.type = 'text';
                    num.inputMode = 'numeric';
                    num.name = 'bv-number';
                    num.setAttribute('aria-label', t.scene.question || 'Число');
                    fs.appendChild(num);
                }
                form.appendChild(fs);
                var msg = el('p', 'bv-msg');
                msg.setAttribute('role', 'alert');
                var row = el('p', 'bv-actions');
                var go = el('button', 'bv-btn', idx + 1 < tasks.length ? 'Відповісти й далі' : 'Відповісти');
                go.type = 'submit';
                row.appendChild(go);
                form.appendChild(row);
                form.appendChild(msg);
                form.addEventListener('submit', function (e) {
                    e.preventDefault();
                    if (busy) { return; }
                    var answer = null;
                    var picked = form.querySelector('input[name="bv-answer"]:checked');
                    if (picked) { answer = picked.value; }
                    var n = form.querySelector('input[name="bv-number"]');
                    if (n && n.value.trim() !== '') { answer = n.value.trim().replace(',', '.'); }
                    if (answer === null) { msg.textContent = 'Спершу оберіть відповідь.'; return; }
                    busy = true;
                    go.disabled = true;
                    post('exam_answer', { token: token, n: t.n, answer: answer }).then(function (r) {
                        busy = false;
                        if (!r.ok && r.error !== 'already_answered') {
                            go.disabled = false;
                            if (r.error === 'expired' || r.error === 'already_finished') { idx = tasks.length; show(); return; }
                            msg.textContent = EXAM_ERR[r.error] || 'Не вдалося зберегти відповідь. Спробуйте ще раз.';
                            return;
                        }
                        idx++;
                        show();
                    });
                });
                box.appendChild(form);
                h.focus();
            }

            function finishView() {
                box.appendChild(el('p', null, 'Усі завдання виконано. Завершіть іспит, щоб побачити результат.'));
                var row = el('p', 'bv-actions');
                row.appendChild(btn('Завершити іспит', '', finish));
                box.appendChild(row);
            }

            function finish() {
                if (busy) { return; }
                busy = true;
                post('exam_finish', { token: token }).then(function (r) {
                    busy = false;
                    clear();
                    if (!r.ok) { box.appendChild(el('p', 'bv-msg is-bad', EXAM_ERR[r.error] || 'Не вдалося завершити іспит.')); return; }
                    var res = el('section', 'bv-result ' + (r.passed ? 'is-good' : 'is-bad'));
                    var h = el('h2', 'bv-result__title', (r.passed ? '✓ Іспит складено: ' : '✗ Поки не складено: ') + r.score + '%');
                    h.tabIndex = -1;
                    res.appendChild(h);
                    res.appendChild(el('p', null, 'Правильних відповідей: ' + r.right + ' з ' + r.total + '.'));
                    if (r.earned && r.earned.xp > 0) {
                        res.appendChild(el('p', 'bv-reward', 'Збережено: +' + r.earned.xp + ' XP, +' + r.earned.coins + ' монет'));
                    }
                    var newsE = progressNews(r.progress);
                    if (newsE) { res.appendChild(newsE); }
                    var ol = el('ol', 'bv-exam-results');
                    (r.results || []).forEach(function (t) {
                        var li = el('li', t.correct ? 'is-right' : 'is-wrong');
                        li.appendChild(el('strong', null, t.correct ? '✓ правильно' : (t.answered ? '✗ неправильно' : '✗ без відповіді')));
                        if (t.explain) { li.appendChild(el('p', null, t.explain)); }
                        ol.appendChild(li);
                    });
                    res.appendChild(el('h3', 'bv-result__sub', 'Розбір'));
                    res.appendChild(ol);
                    var row = el('p', 'bv-actions');
                    if (r.certificate) { row.appendChild(link('Грамота', 'bugville-certificate.php?c=' + encodeURIComponent(r.certificate))); }
                    row.appendChild(link('До карти', 'bugville.php', 'bv-btn--ghost'));
                    res.appendChild(row);
                    if (!r.passed && r.retry_at) {
                        res.appendChild(el('p', 'bv-muted', 'Наступна спроба — після ' + localTime(r.retry_at) + '.'));
                    }
                    box.appendChild(res);
                    h.focus();
                });
            }

            load();
        })();
    }

    // ---------- Книга чарівних слів: вправа «Що означає…?» (правильний варіант знає лише сервер) ----------
    var words = document.getElementById('bv-words');
    if (words && words.getAttribute('data-account') === '1') {
        var WERR = { auth_required: 'Вправи — лише для акаунтів із підтвердженим віком.', locked: 'Це слово ще не відкрито.',
            no_quiz: 'Вправа застаріла. Почніть її ще раз.', rate_limited: 'Забагато спроб за хвилину. Зачекайте трохи.' };
        var counter = document.getElementById('bv-words-count');
        words.addEventListener('click', function (e) {
            var b = e.target.closest('.bv-wquiz-btn');
            if (!b) { return; }
            var card = b.closest('.bv-wcard');
            var word = card.getAttribute('data-word');
            var box = card.querySelector('.bv-wquiz');
            b.disabled = true;
            post('word_quiz', { word: word }).then(function (r) {
                b.disabled = false;
                while (box.firstChild) { box.removeChild(box.firstChild); }
                box.hidden = false;
                if (!r.ok) { box.appendChild(el('p', 'bv-msg is-bad', WERR[r.error] || 'Вправа зараз недоступна.')); return; }
                var form = el('form', 'bv-wquiz__form');
                form.noValidate = true;
                var fs = el('fieldset', 'bv-options');
                var lg = el('legend', 'bv-question', r.question);
                fs.appendChild(lg);
                r.options.forEach(function (o, i) {
                    var lab = el('label', 'bv-option');
                    var inp = el('input');
                    inp.type = 'radio';
                    inp.name = 'bv-w-' + word;
                    inp.value = o.id;
                    inp.id = 'bv-w-' + word + '-' + i;
                    lab.appendChild(inp);
                    lab.appendChild(el('span', 'bv-option__text', o.text));
                    fs.appendChild(lab);
                });
                form.appendChild(fs);
                var row = el('p', 'bv-actions');
                var go = el('button', 'bv-btn bv-btn--small', 'Перевірити');
                go.type = 'submit';
                row.appendChild(go);
                form.appendChild(row);
                var msg = el('p', 'bv-msg');
                msg.setAttribute('role', 'status');
                form.appendChild(msg);
                form.addEventListener('submit', function (ev) {
                    ev.preventDefault();
                    var picked = form.querySelector('input:checked');
                    if (!picked) { msg.textContent = 'Спершу оберіть відповідь.'; return; }
                    go.disabled = true;
                    post('word_check', { word: word, option: picked.value }).then(function (c) {
                        if (!c.ok) { go.disabled = false; msg.className = 'bv-msg is-bad'; msg.textContent = WERR[c.error] || 'Не вдалося перевірити.'; return; }
                        form.querySelectorAll('input').forEach(function (i) { i.disabled = true; });
                        row.hidden = true;
                        msg.className = 'bv-msg ' + (c.correct ? 'is-good' : 'is-bad');
                        msg.textContent = c.correct ? '✓ Правильно! «' + word + '» — ' + c.meaning + '. Слово вивчено.'
                            : '✗ Не зовсім. «' + word + '» означає: ' + c.meaning + '. Спробуйте вправу ще раз.';
                        replay(card, c.correct ? 'is-turn' : 'is-oops');
                        if (c.correct && !card.classList.contains('is-learned')) {
                            setTimeout(function () { confetti(card, 28); }, 300);
                            card.classList.remove('is-open');
                            card.classList.add('is-learned');
                            var stEl = card.querySelector('.bv-wcard__state');
                            if (stEl) { stEl.textContent = '✓ Вивчено'; }
                            b.textContent = 'Повторити вправу';
                            if (counter && typeof c.learned_count === 'number') {
                                var strong = counter.querySelector('strong');
                                if (strong) { strong.textContent = String(c.learned_count); }
                            }
                        }
                        var news = progressNews({ new_badges: c.new_badges || [] });
                        if (news) { box.appendChild(news); }
                    });
                });
                box.appendChild(form);
                var first = form.querySelector('input');
                if (first) { first.focus(); }
            });
        });
    }

    // ---------- Майстерня: купити / вдягнути / зняти / аватар. Баланс і вигляд рахує сервер; після дії — свіжа сторінка ----------
    var ws = document.getElementById('bv-workshop');
    if (ws && ws.getAttribute('data-account') === '1') {
        var wsMsg = document.getElementById('bvw-msg');
        var flash = null;
        try { flash = sessionStorage.getItem('bvWsMsg'); sessionStorage.removeItem('bvWsMsg'); } catch (err) { flash = null; }
        if (flash && wsMsg) { wsMsg.className = 'bv-msg is-good'; wsMsg.textContent = flash; }
        var wsLook = ws.querySelector('.bvw-me .bvw-look');
        if (flash && wsLook && /^Куплено|^Вдягнуто/.test(flash)) { setTimeout(function () { confetti(wsLook, 36); }, 250); }
        // Примірка: показати предмет на своєму герої до покупки (лише в браузері, сервер нічого не змінює)
        var tryOrig = wsLook ? { html: wsLook.innerHTML, cls: wsLook.className } : null;
        var tryBtn = null;
        function tryReset() {
            if (!tryOrig) { return; }
            wsLook.innerHTML = tryOrig.html;   // власна розмітка сторінки, збережена вище
            wsLook.className = tryOrig.cls;
            if (tryBtn) { tryBtn.setAttribute('aria-pressed', 'false'); tryBtn.textContent = 'Приміряти'; }
            tryBtn = null;
        }
        ws.addEventListener('click', function (e) {
            var t = e.target.closest('.bvw-try');
            if (!t || !wsLook) { return; }
            var was = tryBtn === t;
            tryReset();
            if (was) { if (wsMsg) { wsMsg.className = 'bv-msg'; wsMsg.textContent = 'Примірку знято.'; } return; }
            var tpl = t.closest('.bvw-item').querySelector('template.bvw-try__svg');
            if (!tpl) { return; }
            wsLook.innerHTML = '';
            wsLook.appendChild(tpl.content.cloneNode(true));
            wsLook.className = 'bvw-look is-try bvw-bg--' + (t.getAttribute('data-bg') || 'none');
            t.setAttribute('aria-pressed', 'true');
            t.textContent = 'Зняти примірку';
            tryBtn = t;
            if (wsMsg) { wsMsg.className = 'bv-msg'; wsMsg.textContent = 'Примірка: «' + t.getAttribute('data-title') + '». Так ви виглядатимете після покупки.'; }
            var r = wsLook.getBoundingClientRect();
            if (r.bottom < 60 || r.top > window.innerHeight) { wsLook.scrollIntoView({ behavior: reduced ? 'auto' : 'smooth', block: 'center' }); }
        });
        var WSERR = { not_enough: 'Не вистачає монет. Пройдіть ще місії або іспит.', owned: 'Цей предмет уже ваш.',
            not_owned: 'Спершу купіть цей предмет.', not_found: 'Такого предмета немає.', auth_required: 'Майстерня — для акаунтів із підтвердженим віком.',
            rate_limited: 'Забагато дій за хвилину. Зачекайте трохи.' };
        ws.addEventListener('click', function (e) {
            var b = e.target.closest('button[data-action]');
            if (!b || b.disabled) { return; }
            var action = b.getAttribute('data-action');
            var data = action === 'ws_avatar' ? { avatar: b.getAttribute('data-item') }
                : { item: b.getAttribute('data-item') || '', kind: b.getAttribute('data-kind') || '' };
            b.disabled = true;
            post(action, data).then(function (r) {
                if (!r.ok) {
                    b.disabled = false;
                    if (wsMsg) { wsMsg.className = 'bv-msg is-bad'; wsMsg.textContent = WSERR[r.error] || 'Не вдалося. Спробуйте ще раз.'; }
                    return;
                }
                var t = action === 'ws_buy' ? 'Куплено: «' + r.item.title + '». Тепер його можна вдягнути.'
                    : (action === 'ws_avatar' ? 'Аватар змінено.' : (data.item ? 'Вдягнуто.' : 'Знято.'));
                try { sessionStorage.setItem('bvWsMsg', t); } catch (err) { /* без сховища — просто оновимо */ }
                location.reload();
            });
        });
    }

    // ---------- Місія ----------
    var game = document.getElementById('bv-game');
    if (!game) { return; }
    var box = document.getElementById('bv-scene');
    var mission = parseInt(game.getAttribute('data-mission'), 10);
    var isDaily = game.getAttribute('data-daily') === '1';   // «Поломка дня»: місію обирає сервер
    var nextUrl = game.getAttribute('data-next') || '';
    var loginUrl = game.getAttribute('data-login') || 'login.php';
    var registerUrl = game.getAttribute('data-register') || 'register.php';
    var minAge = game.getAttribute('data-min-age') || '16';
    var word = null;
    try { word = JSON.parse(game.getAttribute('data-word') || 'null'); } catch (e) { word = null; }

    var who = { guest: true, logged_in: false, age_confirmed: false };
    var token = '';
    var scene = null;
    var hintUsed = false;
    var busy = false;

    var ERR = {
        rate_limited: 'Забагато спроб за хвилину. Зачекайте трохи й спробуйте знову.',
        expired: 'Час на цю спробу минув. Почнімо нову.',
        not_found: 'Місія зараз недоступна.',
        locked: 'Ця місія ще закрита. Спершу пройдіть попередні.',
        no_variant: 'Місія зараз недоступна.',
        unavailable: 'Гра тимчасово недоступна.',
        csrf: 'Сторінка застаріла. Оновіть її.',
        cross_site: 'Сторінка застаріла. Оновіть її.',
        already_checked: 'Відповідь уже перевірено.',
        bad_answer: 'Оберіть відповідь.'
    };

    function api(action, data) {
        var body = Object.assign({ action: action, lang: 'uk' }, data || {});
        return fetch('bv-api.php', {
            method: 'POST',
            credentials: 'same-origin',
            headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': CSRF },
            body: JSON.stringify(body)
        }).then(function (r) {
            return r.json().catch(function () { return { ok: false, error: 'unavailable' }; });
        }, function () { return { ok: false, error: 'network' }; });
    }

    function setWho(r) {
        if (!r || r.ok === false) { return; }
        who = { guest: !!r.guest, logged_in: !!r.logged_in, age_confirmed: !!r.age_confirmed };
        if (r.credited && r.credited.credited > 0) {
            toast('Зараховано спроб із гостьового сеансу: ' + r.credited.credited);
        }
    }

    function clear() {
        while (box.firstChild) { box.removeChild(box.firstChild); }
    }

    function errorView(code) {
        clear();
        box.setAttribute('aria-busy', 'false');
        box.appendChild(el('p', 'bv-msg is-bad', ERR[code] || 'Щось пішло не так. Спробуйте ще раз.'));
        var row = el('p', 'bv-actions');
        var again = el('button', 'bv-btn', 'Спробувати ще раз');
        again.type = 'button';
        again.addEventListener('click', start);
        row.appendChild(again);
        var map = el('a', 'bv-btn bv-btn--ghost', 'До карти');
        map.href = 'bugville.php';
        row.appendChild(map);
        box.appendChild(row);
    }

    // Акаунт без підтвердженого віку: одноразове «мені виповнилося N років» (інакше грає як гість).
    function ageBox() {
        if (!who.logged_in || who.age_confirmed || document.getElementById('bv-age')) { return; }
        var card = el('section', 'bv-card bv-age');
        card.id = 'bv-age';
        card.appendChild(el('p', null, 'Щоб зберігати XP, зірки й монети, підтвердьте вік. Поки що ви граєте як гість.'));
        var btn = el('button', 'bv-btn', 'Мені виповнилося ' + minAge + ' років');
        btn.type = 'button';
        btn.addEventListener('click', function () {
            btn.disabled = true;
            api('confirm_age', { confirm: true }).then(function (r) {
                if (r.ok) {
                    setWho(r);
                    card.parentNode.removeChild(card);
                    toast('Готово: тепер прогрес зберігається');
                } else {
                    btn.disabled = false;
                    toast(ERR[r.error] || 'Не вдалося підтвердити');
                }
            });
        });
        card.appendChild(btn);
        game.insertBefore(card, box);
    }

    function render(sc) {
        clear();
        box.setAttribute('aria-busy', 'false');
        var form = el('form', 'bv-scene');
        form.noValidate = true;
        form.appendChild(el('p', 'bv-scene__text', sc.text));
        if (sc.items && sc.items.length) {
            var ul = el('ul', 'bv-scene__items');
            sc.items.forEach(function (it) { ul.appendChild(el('li', null, it.text)); });
            form.appendChild(ul);
        }
        var fs = el('fieldset', 'bv-options');
        fs.appendChild(el('legend', 'bv-question', sc.question || 'Ваша відповідь'));
        if (sc.options && sc.options.length) {
            sc.options.forEach(function (o, i) {
                var lab = el('label', 'bv-option');
                lab.setAttribute('data-id', o.id);
                var inp = el('input');
                inp.type = 'radio';
                inp.name = 'bv-answer';
                inp.value = o.id;
                inp.id = 'bv-o' + i;
                lab.appendChild(inp);
                lab.appendChild(el('span', 'bv-option__text', o.text));
                lab.appendChild(el('span', 'bv-option__mark'));
                fs.appendChild(lab);
            });
        } else if (sc.input === 'number') {
            var inpN = el('input', 'bv-input');
            inpN.type = 'text';
            inpN.inputMode = 'numeric';
            inpN.name = 'bv-number';
            inpN.autocomplete = 'off';
            inpN.setAttribute('aria-label', sc.question || 'Число');
            fs.appendChild(inpN);
        }
        form.appendChild(fs);
        var hintP = el('p', 'bv-hint');
        hintP.hidden = true;
        hintP.id = 'bv-hint-text';
        form.appendChild(hintP);
        var row = el('p', 'bv-actions');
        var check = el('button', 'bv-btn', 'Перевірити');
        check.type = 'submit';
        row.appendChild(check);
        var hint = el('button', 'bv-btn bv-btn--ghost', 'Підказка');
        hint.type = 'button';
        hint.addEventListener('click', function () {
            if (busy || hintUsed) { return; }
            busy = true;
            api('hint', { token: token }).then(function (r) {
                busy = false;
                if (!r.ok) { toast(ERR[r.error] || 'Підказка недоступна'); return; }
                hintUsed = true;
                hint.disabled = true;
                hintP.textContent = 'Підказка: ' + r.hint + ' (з підказкою — до 2 зірок)';
                hintP.hidden = false;
            });
        });
        row.appendChild(hint);
        form.appendChild(row);
        var formMsg = el('p', 'bv-msg');
        formMsg.setAttribute('role', 'alert');
        form.appendChild(formMsg);
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            if (busy) { return; }
            var answer = null;
            var picked = form.querySelector('input[name="bv-answer"]:checked');
            if (picked) { answer = picked.value; }
            var num = form.querySelector('input[name="bv-number"]');
            if (num && num.value.trim() !== '') { answer = num.value.trim().replace(',', '.'); }
            if (answer === null) { formMsg.textContent = 'Спершу оберіть відповідь.'; return; }
            formMsg.textContent = '';
            busy = true;
            check.disabled = true;
            api('check', { token: token, answer: answer }).then(function (r) {
                busy = false;
                if (!r.ok) {
                    check.disabled = false;
                    if (r.error === 'expired') { errorView('expired'); return; }
                    formMsg.textContent = ERR[r.error] || 'Не вдалося перевірити. Спробуйте ще раз.';
                    return;
                }
                setWho(r);
                result(form, r, answer);
            });
        });
        box.appendChild(form);
    }

    function starsLine(n) {
        var s = el('p', 'bv-stars bv-stars--big');
        s.setAttribute('aria-label', 'Зірок: ' + n + ' з 3');
        for (var i = 0; i < 3; i++) {
            var st = el('span', 'bv-star' + (i < n ? ' is-on' : ''), i < n ? '★' : '☆');
            st.setAttribute('aria-hidden', 'true');
            s.appendChild(st);
        }
        return s;
    }

    function result(form, r, answer) {
        // Позначки на варіантах: значок + підпис, не лише колір.
        form.querySelectorAll('input').forEach(function (i) { i.disabled = true; });
        form.querySelectorAll('.bv-actions').forEach(function (n) { n.parentNode.removeChild(n); });
        var correct = r.correct_ids || [];
        form.querySelectorAll('.bv-option').forEach(function (lab) {
            var id = lab.getAttribute('data-id');
            var mark = lab.querySelector('.bv-option__mark');
            if (correct.indexOf(id) !== -1) {
                lab.classList.add('is-right');
                mark.textContent = '✓ поломка тут';
            } else if (id === answer) {
                lab.classList.add('is-wrong');
                mark.textContent = '✗ ваш вибір';
            }
        });

        var res = el('section', 'bv-result ' + (r.correct ? 'is-good' : 'is-bad'));
        res.setAttribute('aria-labelledby', 'bv-res-h');
        var h = el('h2', 'bv-result__title', r.correct ? '✓ Вірно! Поломку знайдено' : '✗ Не та відповідь');
        h.id = 'bv-res-h';
        h.tabIndex = -1;
        res.appendChild(h);
        if (r.correct) { res.appendChild(starsLine(r.stars || 0)); }
        if (r.explain) {
            res.appendChild(el('h3', 'bv-result__sub', 'Розбір'));
            res.appendChild(el('p', null, r.explain));
        }
        if (r.correct && word && word.word) {
            var wc = el('div', 'bv-word');
            wc.appendChild(el('p', 'bv-word__label', 'Чарівне слово'));
            var w = el('p', 'bv-word__word', word.word);
            w.setAttribute('lang', 'en');
            wc.appendChild(w);
            wc.appendChild(el('p', 'bv-word__say', '[' + word.say + '] — ' + word.meaning));
            res.appendChild(wc);
        }
        reward(res, r);
        var newsM = progressNews(r.progress);
        if (newsM) { res.appendChild(newsM); }

        var row = el('p', 'bv-actions');
        var again = el('button', 'bv-btn' + (r.correct && nextUrl ? ' bv-btn--ghost' : ''), r.correct ? 'Ще раз (новий варіант)' : 'Спробувати ще (новий варіант)');
        again.type = 'button';
        again.addEventListener('click', start);
        row.appendChild(again);
        if (r.correct && nextUrl) {
            var nx = el('a', 'bv-btn', 'Наступна місія');
            nx.href = nextUrl;
            row.insertBefore(nx, again);
        }
        var map = el('a', 'bv-btn bv-btn--ghost', 'До карти');
        map.href = 'bugville.php';
        row.appendChild(map);
        res.appendChild(row);
        box.appendChild(res);
        h.focus({ preventScroll: false });
    }

    function reward(res, r) {
        if (r.repeat) { return; }
        if (r.daily) { dailyReward(res, r); return; }
        if (r.saved && r.earned) {
            var e = r.earned;
            if (e.xp > 0) {
                res.appendChild(el('p', 'bv-reward', 'Збережено: +' + e.xp + ' XP' + (e.coins > 0 ? ', +' + e.coins + ' монет' : '')));
            } else if (r.correct) {
                res.appendChild(el('p', 'bv-muted', 'Найкращий результат цієї місії вже збережено. Нагорода — лише за покращення.'));
            }
            return;
        }
        if (r.credit_limit) {
            res.appendChild(el('p', 'bv-muted', 'На сьогодні ліміт зарахувань вичерпано, цю спробу не збережено.'));
            return;
        }
        var we = r.would_earn;
        if (!r.correct || !we || we.xp <= 0) { return; }
        var hidden = false;
        try { hidden = sessionStorage.getItem('bvSaveHidden') === '1'; } catch (err) { hidden = false; }
        if (who.logged_in) {
            res.appendChild(el('p', 'bv-muted', '+' + we.xp + ' XP за цю місію не збережено: підтвердьте вік угорі сторінки.'));
            return;
        }
        if (hidden) {
            res.appendChild(el('p', 'bv-muted', '+' + we.xp + ' XP у цьому сеансі'));
            return;
        }
        var save = el('aside', 'bv-save');
        save.appendChild(el('p', null, '+' + we.xp + ' XP, ' + we.stars + ' ★ у цьому сеансі. Щоб зберегти, увійдіть або зареєструйтесь (від ' + minAge + ' років).'));
        var row = el('p', 'bv-actions');
        var reg = el('a', 'bv-btn bv-btn--small', 'Зареєструватись');
        reg.href = registerUrl;
        var lin = el('a', 'bv-btn bv-btn--small bv-btn--ghost', 'Увійти');
        lin.href = loginUrl;
        row.appendChild(reg);
        row.appendChild(lin);
        save.appendChild(row);
        var x = el('button', 'bv-save__close', '×');
        x.type = 'button';
        x.setAttribute('aria-label', 'Закрити пропозицію');
        x.addEventListener('click', function () {
            try { sessionStorage.setItem('bvSaveHidden', '1'); } catch (err) { /* без сховища — лише ховаємо */ }
            save.parentNode.removeChild(save);
        });
        save.appendChild(x);
        res.appendChild(save);
    }

    /** «Поломка дня»: нагорода раз на день; гостю — мʼяка пропозиція рахувати дні (без тиску, можна закрити). */
    function dailyReward(res, r) {
        if (r.saved && r.earned) {
            res.appendChild(el('p', r.earned.xp > 0 ? 'bv-reward' : 'bv-muted', r.earned.xp > 0
                ? 'Збережено: +' + r.earned.xp + ' XP' + (r.earned.coins > 0 ? ', +' + r.earned.coins + ' монети' : '') + '. День зараховано в серію.'
                : 'Нагороду за сьогоднішню поломку вже отримано. Грати ще можна скільки завгодно.'));
            return;
        }
        if (who.logged_in) {
            res.appendChild(el('p', 'bv-muted', 'Щоб рахувати дні підряд, підтвердьте вік угорі сторінки (від ' + minAge + ' років).'));
            return;
        }
        var hidden = false;
        try { hidden = sessionStorage.getItem('bvSaveHidden') === '1'; } catch (err) { hidden = false; }
        if (hidden) { return; }
        var save = el('aside', 'bv-save');
        save.appendChild(el('p', null, 'Зареєструйтесь, щоб рахувати дні підряд і зберігати XP (від ' + minAge + ' років). А можна просто грати далі.'));
        var row = el('p', 'bv-actions');
        var reg = el('a', 'bv-btn bv-btn--small', 'Зареєструватись');
        reg.href = registerUrl;
        var lin = el('a', 'bv-btn bv-btn--small bv-btn--ghost', 'Увійти');
        lin.href = loginUrl;
        row.appendChild(reg);
        row.appendChild(lin);
        save.appendChild(row);
        var x = el('button', 'bv-save__close', '×');
        x.type = 'button';
        x.setAttribute('aria-label', 'Закрити пропозицію');
        x.addEventListener('click', function () {
            try { sessionStorage.setItem('bvSaveHidden', '1'); } catch (err) { /* без сховища — лише ховаємо */ }
            save.parentNode.removeChild(save);
        });
        save.appendChild(x);
        res.appendChild(save);
    }

    function start() {
        if (busy) { return; }
        busy = true;
        hintUsed = false;
        clear();
        box.setAttribute('aria-busy', 'true');
        box.appendChild(el('p', 'bv-loading', 'Готуємо новий варіант…'));
        api('start', isDaily ? { daily: true } : { mission: mission }).then(function (r) {
            busy = false;
            if (!r.ok) { errorView(r.error); return; }
            setWho(r);
            ageBox();
            token = r.token;
            scene = r.scene;
            var sceneFn = scene && window.BVScene ? { input_machine: 'machine', form_scene: 'form', table_scene: 'table' }[scene.type] : null;
            if (sceneFn) {
                game.classList.add('bv-game--scene');
                window.BVScene[sceneFn]({ host: box, scene: scene, token: token, api: api, word: word, nextUrl: nextUrl,
                    onRestart: start, daily: r.daily || null,
                    reward: function (n, res) {
                        reward(n, res);
                        var news = progressNews(res.progress && res.daily ? Object.assign({ daily: true }, res.progress) : res.progress);
                        if (news) { n.appendChild(news); }
                    },
                    setWho: setWho, toast: toast, err: errorView });
                return;
            }
            game.classList.remove('bv-game--scene');
            render(scene);
        });
    }

    api('state').then(function (r) {
        if (!r.ok) { errorView(r.error); return; }
        setWho(r);
        ageBox();
        start();
    });
})();
