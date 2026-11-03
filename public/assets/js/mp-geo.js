/*
 * AI LAB HUB — Marketplace: вибір місця з автопідказкою, блок «Де надається», кнопка «Поблизу».
 *
 *   [data-geo-picker]  — текстове поле + приховане значення (id місця або код країни). Значення ставиться
 *                        ЛИШЕ вибором з підказки; будь-яке редагування тексту його скидає (вільний текст не приймається).
 *   [data-geo-form]    — перемикає секції за форматом (data-geo-show="online" / "offline hybrid").
 *   [data-geo-near]    — геолокація браузера лише після натискання; координати йдуть POST-ом на
 *                        mp-geo-suggest.php (near=1), сервер повертає найближче місто й нічого не зберігає.
 */
(function () {
    'use strict';

    var ENDPOINT = '/mp-geo-suggest.php';

    function initPicker(root) {
        if (root.dataset.geoReady) { return; }
        root.dataset.geoReady = '1';
        var input = root.querySelector('[data-geo-input]');
        var hidden = root.querySelector('[data-geo-id]');
        var list = root.querySelector('.mp-geo-list');
        var type = root.dataset.type || 'any';
        var lang = root.dataset.lang || document.documentElement.lang || 'en';
        var mode = root.dataset.value || 'id';
        var timer = null;
        var seq = 0;
        var items = [];
        var active = -1;

        function close() {
            list.hidden = true;
            input.setAttribute('aria-expanded', 'false');
            input.removeAttribute('aria-activedescendant');
            active = -1;
        }

        function choose(it) {
            hidden.value = mode === 'code' ? it.country_code : String(it.id);
            input.value = it.label;
            close();
            root.dispatchEvent(new CustomEvent('geo:change', { bubbles: true, detail: it }));
        }
        root.geoChoose = choose;

        function render() {
            list.textContent = '';
            items.forEach(function (it, i) {
                var li = document.createElement('li');
                li.id = list.id + '_' + i;
                li.setAttribute('role', 'option');
                li.className = 'mp-geo-list__item' + (i === active ? ' is-active' : '');
                li.textContent = it.label;
                li.addEventListener('mousedown', function (e) { e.preventDefault(); choose(it); });
                list.appendChild(li);
            });
            list.hidden = items.length === 0;
            input.setAttribute('aria-expanded', items.length ? 'true' : 'false');
            if (active >= 0) { input.setAttribute('aria-activedescendant', list.id + '_' + active); }
        }

        function query() {
            var q = input.value.trim();
            if (q.length < 2) { items = []; render(); return; }
            var my = ++seq;
            fetch(ENDPOINT + '?q=' + encodeURIComponent(q) + '&lang=' + encodeURIComponent(lang) + '&type=' + encodeURIComponent(type),
                { credentials: 'same-origin', headers: { 'Accept': 'application/json' } })
                .then(function (r) { return r.ok ? r.json() : { items: [] }; })
                .then(function (d) {
                    if (my !== seq) { return; }
                    items = Array.isArray(d.items) ? d.items : [];
                    active = -1;
                    render();
                })
                .catch(function () { /* мережа: просто без підказок */ });
        }

        input.addEventListener('input', function () {
            hidden.value = '';   // текст змінено — попередній вибір недійсний
            clearTimeout(timer);
            timer = setTimeout(query, 250);
        });
        input.addEventListener('keydown', function (e) {
            if (list.hidden) { return; }
            if (e.key === 'ArrowDown') { active = Math.min(items.length - 1, active + 1); render(); e.preventDefault(); }
            else if (e.key === 'ArrowUp') { active = Math.max(0, active - 1); render(); e.preventDefault(); }
            else if (e.key === 'Enter' && active >= 0) { choose(items[active]); e.preventDefault(); }
            else if (e.key === 'Escape') { close(); }
        });
        input.addEventListener('blur', function () {
            setTimeout(close, 150);
            if (!hidden.value) { input.value = ''; }
        });
    }

    function initForm(form) {
        function sync() {
            var checked = form.querySelector('[data-geo-format]:checked');
            var wf = checked ? checked.value : 'online';
            form.querySelectorAll('[data-geo-show]').forEach(function (s) {
                s.hidden = s.dataset.geoShow.split(' ').indexOf(wf) === -1;
            });
        }
        form.querySelectorAll('[data-geo-format]').forEach(function (r) { r.addEventListener('change', sync); });
        sync();
    }

    function initNear(btn) {
        if (!('geolocation' in navigator)) { btn.hidden = true; return; }
        btn.addEventListener('click', function () {
            var target = document.getElementById(btn.dataset.geoNear);
            var picker = target && (target.matches('[data-geo-picker]') ? target : target.querySelector('[data-geo-picker]'));
            var status = btn.parentNode.querySelector('[data-geo-status]');
            var say = function (t) { if (status) { status.textContent = t || ''; } };
            btn.disabled = true;
            say(btn.dataset.msgWait || '');
            navigator.geolocation.getCurrentPosition(function (pos) {
                var fd = new FormData();
                fd.append('near', '1');
                fd.append('lat', String(pos.coords.latitude));
                fd.append('lon', String(pos.coords.longitude));
                fd.append('csrf', btn.dataset.csrf || '');
                fd.append('lang', (picker && picker.dataset.lang) || 'en');
                fetch(ENDPOINT, { method: 'POST', body: fd, credentials: 'same-origin' })
                    .then(function (r) { return r.ok ? r.json() : { place: null }; })
                    .then(function (d) {
                        btn.disabled = false;
                        if (d.place && picker && picker.geoChoose) { picker.geoChoose(d.place); say(''); }
                        else { say(btn.dataset.msgFail || ''); }
                    })
                    .catch(function () { btn.disabled = false; say(btn.dataset.msgFail || ''); });
            }, function () {
                btn.disabled = false;
                say(btn.dataset.msgDenied || '');
            }, { enableHighAccuracy: false, timeout: 10000, maximumAge: 600000 });
        });
    }

    function init() {
        document.querySelectorAll('[data-geo-picker]').forEach(initPicker);
        document.querySelectorAll('[data-geo-form]').forEach(initForm);
        document.querySelectorAll('[data-geo-near]').forEach(initNear);
    }

    if (document.readyState === 'loading') { document.addEventListener('DOMContentLoaded', init); } else { init(); }
}());
