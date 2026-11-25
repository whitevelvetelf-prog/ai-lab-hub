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
            inner.appendChild(back);
            flip.appendChild(inner);
            flip.addEventListener('click', function () {
                var on = flip.classList.toggle('is-on');
                flip.setAttribute('aria-pressed', String(on));
                flip.setAttribute('aria-label', on ? 'Чарівне слово: ' + o.word.word + ' — ' + o.word.meaning : 'Перевернути картку чарівного слова');
            });
            box.appendChild(flip);
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

        // ----- бічна колонка -----
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
        grid.appendChild(side);
        root.appendChild(grid);
        host.appendChild(root);

        var found = 0;
        function updateSubmit(can) {
            submit.disabled = !can;
            submit.textContent = can ? 'Здати роботу майстру (знайдено ' + found + ' з ' + sc.total + ')'
                : 'Здати роботу майстру (потрібно знайти ' + sc.min_found + ')';
        }
        updateSubmit(false);
        mentor.say(sc.intro, 'happy');
        if (!reduced) { mentor.act('wave', 1900); }

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
            if (busy || done) { return; }
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
            if (busy || done) { return; }
            busy = true;
            submit.disabled = true;
            o.api('scene_finish', { token: o.token }).then(function (r) {
                busy = false;
                if (!r.ok) {
                    if (r.error === 'not_enough') { updateSubmit(false); msg.textContent = 'Щоб здати роботу, знайдіть поломок: щонайменше ' + r.min_found + '.'; return; }
                    if (r.error === 'expired') { o.err('expired'); return; }
                    submit.disabled = false;
                    o.toast('Не вдалося здати роботу. Спробуйте ще раз.');
                    return;
                }
                done = true;
                o.setWho(r);
                var s = r.summary || {};
                var chips = ['Поломок: ' + s.found + ' з ' + s.total];
                var e = r.earned || r.would_earn;
                if (e && e.xp > 0) { chips.unshift('+' + e.xp + ' XP'); }
                if (r.earned && r.earned.coins > 0) { chips.push('+' + r.earned.coins + ' монет'); }
                finale({
                    title: sc.good.charAt(0).toUpperCase() + sc.good.slice(1) + ': автомат перевірено!',
                    stars: r.stars || 0, chips: chips, word: o.word,
                    note: (r.explain || '') + (r.hint_used ? ' Підказку використано.' : ''),
                    extra: function (b) { o.reward(b, r); },
                    actions: [o.nextUrl ? { text: 'Наступна місія', href: o.nextUrl, primary: true } : null,
                        { text: 'Пройти ще раз (новий автомат)', onClick: o.onRestart, primary: !o.nextUrl },
                        { text: 'До карти', href: 'bugville.php' }].filter(Boolean)
                });
            });
        });
        lcd.focus({ preventScroll: true });
    }

    window.BVScene = { machine: machine, Mentor: Mentor, Collection: Collection, Log: Log, finale: finale, stamp: stamp, pop: pop, Sound: Sound };
})();

(function () {
    'use strict';

    var CSRF = (document.querySelector('meta[name="csrf-token"]') || {}).content || '';

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

    // ---------- Місія ----------
    var game = document.getElementById('bv-game');
    if (!game) { return; }
    var box = document.getElementById('bv-scene');
    var mission = parseInt(game.getAttribute('data-mission'), 10);
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

    function start() {
        if (busy) { return; }
        busy = true;
        hintUsed = false;
        clear();
        box.setAttribute('aria-busy', 'true');
        box.appendChild(el('p', 'bv-loading', 'Готуємо новий варіант…'));
        api('start', { mission: mission }).then(function (r) {
            busy = false;
            if (!r.ok) { errorView(r.error); return; }
            setWho(r);
            ageBox();
            token = r.token;
            scene = r.scene;
            if (scene && scene.type === 'input_machine' && window.BVScene) {
                game.classList.add('bv-game--scene');
                window.BVScene.machine({ host: box, scene: scene, token: token, api: api, word: word, nextUrl: nextUrl,
                    onRestart: start, reward: reward, setWho: setWho, toast: toast, err: errorView });
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
