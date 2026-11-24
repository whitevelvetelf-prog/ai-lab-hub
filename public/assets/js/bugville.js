/* AI LAB HUB — «Багвіль»: сторінки гри (крок 3).
 *
 * Шапка: «Назад» (history.back на тому ж сайті, інакше резервна адреса) і «Поділитися» (navigator.share або копія
 * посилання; без кнопок соцмереж — у грі немає зовнішніх посилань).
 * Місія (#bv-game): state → start → сцена; hint → підказка; check → результат, розбір, чарівне слово, нагорода.
 * Відповідей у браузері немає: сервер дає лише сцену з одноразовими id і після перевірки — розбір.
 * Тексти сервера вставляються лише через textContent. Нічого не пишеться в localStorage; у sessionStorage — лише те,
 * що гість закрив пропозицію «зберегти» (до кінця сеансу, MAIN_TASK розділ 8).
 */
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

    /** Новини прогресу акаунта (звання, значки) з відповіді API (r.progress) — елемент або null. */
    function progressNews(p) {
        if (!p) { return null; }
        var lines = [];
        if (p.rank_up && p.rank) { lines.push('🎖 Нове звання: ' + p.rank.title + '!'); }
        (p.new_badges || []).forEach(function (b) { lines.push('★ Новий значок: ' + b.title + ' — ' + b.description); });
        if (!lines.length) { return null; }
        var box = el('div', 'bv-news');
        box.setAttribute('role', 'status');
        lines.forEach(function (t) { box.appendChild(el('p', null, t)); });
        return box;
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
