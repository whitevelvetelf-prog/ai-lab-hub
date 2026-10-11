/* AI LAB HUB — кабінет рекламодавця (розділ «Реклама» в account.php, app/promo-cabinet.php).
 *
 *   * вкладки без перезавантаження (посилання працюють і без JS);
 *   * майстер кампанії: 5 кроків, «Назад/Далі», зберегти чернетку можна на будь-якому
 *     кроці (без JS усі кроки видно одразу);
 *   * перевірка відео в браузері (тип, розмір, тривалість) і кадр для постера;
 *   * попередній перегляд картки, ціни з прайсу, орієнтовний прогноз, підсумок.
 * Увесь текст користувача вставляється через textContent.
 */
(function () {
    'use strict';

    var root = document.querySelector('.pc');
    if (!root) {
        return;
    }
    root.classList.add('pc-js');

    // --- Вкладки ---------------------------------------------------------
    function showTab(name) {
        root.querySelectorAll('[data-pc-panel]').forEach(function (p) {
            p.hidden = p.getAttribute('data-pc-panel') !== name;
        });
        root.querySelectorAll('.pc-tab').forEach(function (t) {
            var on = t.getAttribute('data-pc-tab') === name;
            t.classList.toggle('is-active', on);
            t.setAttribute('aria-selected', on ? 'true' : 'false');
        });
        try {
            var url = new URL(window.location.href);
            url.searchParams.set('promo_tab', name);
            url.hash = 'acc-promo';
            window.history.replaceState(null, '', url.toString());
        } catch (e) { /* старий браузер — не критично */ }
    }
    root.addEventListener('click', function (e) {
        var link = e.target.closest('[data-pc-tab]');
        if (link && root.contains(link)) {
            e.preventDefault();
            showTab(link.getAttribute('data-pc-tab'));
        }
    });

    root.querySelectorAll('form[data-pc-confirm]').forEach(function (form) {
        form.addEventListener('submit', function (e) {
            if (!window.confirm(form.getAttribute('data-pc-confirm'))) {
                e.preventDefault();
            }
        });
    });

    // --- Майстер ---------------------------------------------------------
    var form = document.getElementById('pcWizard');
    if (!form) {
        return;
    }
    var i18n = JSON.parse(form.getAttribute('data-i18n') || '{}');
    var rates = JSON.parse(form.getAttribute('data-rates') || '{}');
    var maxMb = parseInt(form.getAttribute('data-max-mb'), 10) || 30;
    var maxSec = parseInt(form.getAttribute('data-max-sec'), 10) || 30;
    var balance = parseInt(form.getAttribute('data-balance'), 10) || 0;

    function fmt(str) {
        var args = Array.prototype.slice.call(arguments, 1);
        var i = 0;
        return String(str || '').replace(/%[sd]/g, function () { return args[i++]; });
    }
    function money(kop) {
        return (kop / 100).toLocaleString('uk-UA', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + ' ' + (i18n.currency_uah || 'грн');
    }
    function parseMoney(v) {
        var t = String(v || '').replace(/[\s ]/g, '').replace(',', '.');
        if (!/^\d{1,9}(\.\d{1,2})?$/.test(t)) {
            return null;
        }
        return Math.round(parseFloat(t) * 100);
    }
    function val(name) {
        var el = form.elements[name];
        if (!el) {
            return '';
        }
        if (el instanceof RadioNodeList) {
            return el.value;
        }
        return el.value;
    }
    function checkedValues(name) {
        return Array.prototype.map.call(form.querySelectorAll('input[name="' + name + '"]:checked'), function (i) { return i.value; });
    }

    var steps = Array.prototype.slice.call(form.querySelectorAll('[data-pc-step]'));
    var navItems = Array.prototype.slice.call(root.querySelectorAll('[data-pc-step-nav]'));
    var prevBtn = form.querySelector('[data-pc-prev]');
    var nextBtn = form.querySelector('[data-pc-next]');
    var submitBtn = form.querySelector('[data-pc-submit]');
    var current = 1;

    function go(n) {
        current = Math.max(1, Math.min(steps.length, n));
        steps.forEach(function (s) {
            s.classList.toggle('is-current', parseInt(s.getAttribute('data-pc-step'), 10) === current);
        });
        navItems.forEach(function (li) {
            var k = parseInt(li.getAttribute('data-pc-step-nav'), 10);
            li.classList.toggle('is-current', k === current);
            li.classList.toggle('is-done', k < current);
        });
        prevBtn.hidden = current === 1;
        nextBtn.hidden = current === steps.length;
        submitBtn.hidden = current !== steps.length;
        if (current === 4) {
            updatePrices();
        }
        if (current === 5) {
            updateSummary();
        }
    }
    prevBtn.addEventListener('click', function () { go(current - 1); });
    nextBtn.addEventListener('click', function () { go(current + 1); });
    navItems.forEach(function (li) {
        li.addEventListener('click', function () { go(parseInt(li.getAttribute('data-pc-step-nav'), 10)); });
    });

    // Показ полів залежно від типу відео.
    function toggleShow() {
        form.querySelectorAll('[data-pc-show]').forEach(function (el) {
            var parts = el.getAttribute('data-pc-show').split('=');
            el.hidden = val(parts[0]) !== parts[1];
        });
        renderMedia();
    }
    form.querySelectorAll('input[name="video_type"]').forEach(function (r) { r.addEventListener('change', toggleShow); });

    // Лічильники символів.
    form.querySelectorAll('[data-pc-count]').forEach(function (counter) {
        var field = form.elements[counter.getAttribute('data-pc-count')];
        var max = field.getAttribute('maxlength');
        function upd() { counter.textContent = field.value.length + '/' + max; }
        field.addEventListener('input', upd);
        upd();
    });

    // --- Попередній перегляд картки --------------------------------------
    var media = form.querySelector('[data-pc-preview-media]');
    var captureBtn = form.querySelector('[data-pc-capture]');
    var videoInput = form.elements.video;
    var posterInput = form.elements.poster;
    var localVideoUrl = null;
    var localPosterUrl = null;
    var previewVideo = null;

    function youtubeId(url) {
        var m = String(url || '').match(/(?:youtube\.com\/(?:watch\?(?:.*&)?v=|shorts\/|embed\/|live\/)|youtu\.be\/|youtube-nocookie\.com\/embed\/)([A-Za-z0-9_-]{11})/);
        return m ? m[1] : '';
    }

    function renderMedia() {
        media.textContent = '';
        previewVideo = null;
        captureBtn.hidden = true;
        var poster = localPosterUrl || form.elements.poster_data.value || media.getAttribute('data-poster') || '';
        if (val('video_type') === 'youtube') {
            var id = youtubeId(val('youtube_url')) || media.getAttribute('data-youtube');
            if (id) {
                var img = document.createElement('img');
                img.alt = '';
                img.src = poster || ('https://i.ytimg.com/vi/' + encodeURIComponent(id) + '/hqdefault.jpg');
                media.appendChild(img);
            }
            return;
        }
        var src = localVideoUrl || media.getAttribute('data-video');
        if (!src) {
            if (poster) {
                var pimg = document.createElement('img');
                pimg.alt = '';
                pimg.src = poster;
                media.appendChild(pimg);
            }
            return;
        }
        var v = document.createElement('video');
        v.muted = true;
        v.setAttribute('muted', '');
        v.setAttribute('playsinline', '');
        v.setAttribute('preload', 'metadata');
        v.controls = true;
        if (poster) {
            v.poster = poster;
        }
        v.src = src;
        media.appendChild(v);
        previewVideo = v;
        v.addEventListener('loadeddata', function () { captureBtn.hidden = false; });
    }

    function previewText() {
        form.querySelector('[data-pc-preview="title"]').textContent = val('title');
        form.querySelector('[data-pc-preview="description"]').textContent = val('description');
        var cta = form.elements.cta_key;
        form.querySelector('[data-pc-preview="cta"]').textContent = cta.options[cta.selectedIndex].text;
    }
    ['title', 'description', 'cta_key'].forEach(function (n) {
        form.elements[n].addEventListener('input', previewText);
        form.elements[n].addEventListener('change', previewText);
    });
    form.elements.youtube_url.addEventListener('input', renderMedia);

    var videoErrorEl = form.querySelector('[data-pc-video-error]');
    function videoError(msg) {
        videoErrorEl.textContent = msg;
        videoErrorEl.hidden = false;
        videoInput.value = '';
        if (localVideoUrl) {
            URL.revokeObjectURL(localVideoUrl);
            localVideoUrl = null;
        }
        form.elements.duration_client.value = '';
        renderMedia();
    }

    videoInput.addEventListener('change', function () {
        var file = videoInput.files && videoInput.files[0];
        if (localVideoUrl) {
            URL.revokeObjectURL(localVideoUrl);
            localVideoUrl = null;
        }
        videoErrorEl.hidden = true;
        if (!file) {
            renderMedia();
            return;
        }
        if (!/\.(mp4|webm)$/i.test(file.name) || (file.type && !/^video\/(mp4|webm)$/.test(file.type))) {
            videoError(i18n.js_video_type);
            return;
        }
        if (file.size > maxMb * 1024 * 1024) {
            videoError(fmt(i18n.js_video_too_big, maxMb));
            return;
        }
        localVideoUrl = URL.createObjectURL(file);
        form.elements.poster_data.value = '';
        renderMedia();
        previewVideo.addEventListener('loadedmetadata', function () {
            var d = previewVideo.duration;
            if (isFinite(d)) {
                form.elements.duration_client.value = d.toFixed(2);
                if (d > maxSec + 0.5) {
                    videoError(fmt(i18n.js_video_too_long, maxSec));
                }
            }
        });
    });

    posterInput.addEventListener('change', function () {
        var file = posterInput.files && posterInput.files[0];
        if (localPosterUrl) {
            URL.revokeObjectURL(localPosterUrl);
        }
        localPosterUrl = file ? URL.createObjectURL(file) : null;
        if (file) {
            form.elements.poster_data.value = '';
        }
        renderMedia();
    });

    // Кадр із відео як постер (поточна позиція відтворення).
    captureBtn.addEventListener('click', function () {
        if (!previewVideo || !previewVideo.videoWidth) {
            return;
        }
        var canvas = document.createElement('canvas');
        var scale = Math.min(1, 1280 / previewVideo.videoWidth);
        canvas.width = Math.round(previewVideo.videoWidth * scale);
        canvas.height = Math.round(previewVideo.videoHeight * scale);
        try {
            canvas.getContext('2d').drawImage(previewVideo, 0, 0, canvas.width, canvas.height);
            form.elements.poster_data.value = canvas.toDataURL('image/jpeg', 0.85);
            posterInput.value = '';
            if (localPosterUrl) {
                URL.revokeObjectURL(localPosterUrl);
                localPosterUrl = null;
            }
            previewVideo.poster = form.elements.poster_data.value;
            captureBtn.textContent = i18n.poster_captured;
        } catch (e) { /* відео з іншого джерела — кадр недоступний */ }
    });

    // --- Аудиторія: «усі категорії» вимикає вибір окремих ------------------
    var catAll = form.querySelector('[data-pc-cat-all]');
    var catsBox = form.querySelector('[data-pc-cats]');
    function syncCats() {
        catsBox.classList.toggle('is-disabled', catAll.checked);
        catsBox.querySelectorAll('input').forEach(function (i) { i.disabled = catAll.checked; });
    }
    catAll.addEventListener('change', syncCats);

    // --- Ціни й прогноз --------------------------------------------------
    var pricesBox = form.querySelector('[data-pc-prices]');
    var forecastBox = form.querySelector('[data-pc-forecast]');
    var balanceWarn = form.querySelector('[data-pc-balance-warning]');

    function model() {
        return val('objective') === 'clicks' ? 'cpc' : 'cpm';
    }

    function updatePrices() {
        var m = model();
        var placements = checkedValues('placements[]');
        pricesBox.textContent = '';
        forecastBox.textContent = '';
        var prices = [];
        placements.forEach(function (pl) {
            var p = document.createElement('p');
            var label = i18n['placement_' + pl] || pl;
            var price = rates[pl] && rates[pl][m];
            if (price) {
                prices.push(price);
                p.textContent = fmt(m === 'cpm' ? i18n.price_cpm : i18n.price_cpc, label, money(price));
            } else {
                p.textContent = fmt(i18n.no_price_for, label);
                p.className = 'pc-warn-text';
            }
            pricesBox.appendChild(p);
        });
        var total = parseMoney(val('total_budget'));
        if (total && prices.length) {
            var lo = Math.min.apply(null, prices);
            var hi = Math.max.apply(null, prices);
            var units = function (price) {
                return Math.floor(m === 'cpm' ? total * 1000 / price : total / price);
            };
            var range = units(hi) === units(lo)
                ? units(hi).toLocaleString('uk-UA')
                : units(hi).toLocaleString('uk-UA') + '–' + units(lo).toLocaleString('uk-UA');
            var f = document.createElement('p');
            f.textContent = fmt(m === 'cpm' ? i18n.forecast_cpm : i18n.forecast_cpc, range);
            var note = document.createElement('small');
            note.textContent = i18n.forecast_note;
            forecastBox.appendChild(f);
            forecastBox.appendChild(note);
        }
        forecastBox.hidden = forecastBox.childNodes.length === 0;
    }
    ['total_budget', 'daily_budget'].forEach(function (n) { form.elements[n].addEventListener('input', updatePrices); });
    form.querySelectorAll('input[name="placements[]"], input[name="objective"]').forEach(function (i) {
        i.addEventListener('change', updatePrices);
    });

    // --- Підсумок --------------------------------------------------------
    function labelOf(el) {
        var lab = el.closest('.pc-field, .pc-choice-row');
        var span = lab ? lab.querySelector('span') : null;
        return span ? span.childNodes[0].textContent.trim() : el.name;
    }
    function updateSummary() {
        var dl = form.querySelector('[data-pc-summary]');
        dl.textContent = '';
        function row(label, value) {
            var dt = document.createElement('dt');
            dt.textContent = label;
            var dd = document.createElement('dd');
            dd.textContent = value || i18n.summary_empty;
            dl.appendChild(dt);
            dl.appendChild(dd);
        }
        var objective = form.querySelector('input[name="objective"]:checked');
        row(labelOf(form.elements.name), val('name'));
        if (objective) {
            row(objective.closest('[role="radiogroup"]').getAttribute('aria-label'), objective.closest('label').querySelector('strong').textContent);
        }
        row(labelOf(form.elements.title), val('title'));
        row(labelOf(form.elements.destination_url), val('destination_url'));
        ['language', 'device'].forEach(function (n) {
            var s = form.elements[n];
            row(labelOf(s), s.options[s.selectedIndex].text);
        });
        row(labelOf(form.querySelector('input[name="placements[]"]')), checkedValues('placements[]').map(function (pl) {
            return i18n['placement_' + pl] || pl;
        }).join(', '));
        row(labelOf(catAll), catAll.checked ? i18n.categories_all
            : fmt(i18n.categories_selected, checkedValues('cats[]').length + checkedValues('subs[]').length));
        row(labelOf(form.elements.daily_budget), val('daily_budget') ? money(parseMoney(val('daily_budget')) || 0) : '');
        row(labelOf(form.elements.total_budget), val('total_budget') ? money(parseMoney(val('total_budget')) || 0) : '');
        row(labelOf(form.elements.start_date), val('start_date') + (val('end_date') ? ' — ' + val('end_date') : ''));

        var need = parseMoney(val('daily_budget')) || parseMoney(val('total_budget')) || 1;
        balanceWarn.hidden = balance >= need;
    }

    previewText();
    toggleShow();
    syncCats();
    go(1);
})();
