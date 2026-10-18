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

    var roots = Array.prototype.slice.call(document.querySelectorAll('.pc'));
    if (roots.length === 0) {
        return;
    }

    // --- Вкладки (кабінет рекламодавця й адмінка: data-pc-param — параметр URL) ---
    roots.forEach(function (box) {
        box.classList.add('pc-js');
        var param = box.getAttribute('data-pc-param') || 'promo_tab';
        var hash = box.getAttribute('data-pc-hash') || 'acc-promo';

        function showTab(name) {
            box.querySelectorAll('[data-pc-panel]').forEach(function (p) {
                p.hidden = p.getAttribute('data-pc-panel') !== name;
            });
            box.querySelectorAll('.pc-tab').forEach(function (t) {
                var on = t.getAttribute('data-pc-tab') === name;
                t.classList.toggle('is-active', on);
                t.setAttribute('aria-selected', on ? 'true' : 'false');
            });
            try {
                var url = new URL(window.location.href);
                url.searchParams.set(param, name);
                url.hash = hash;
                window.history.replaceState(null, '', url.toString());
            } catch (e) { /* старий браузер — не критично */ }
        }
        box.addEventListener('click', function (e) {
            var link = e.target.closest('[data-pc-tab]');
            if (link && box.contains(link) && box.querySelector('[data-pc-panel="' + link.getAttribute('data-pc-tab') + '"]')) {
                e.preventDefault();
                showTab(link.getAttribute('data-pc-tab'));
            }
        });

        box.querySelectorAll('form[data-pc-confirm]').forEach(function (form) {
            form.addEventListener('submit', function (e) {
                if (!window.confirm(form.getAttribute('data-pc-confirm'))) {
                    e.preventDefault();
                }
            });
        });
    });
    var root = document.querySelector('.pc[data-pc-param="promo_tab"]') || roots[0];

    // --- Місця показу (галочки): майстер і форма «Місця показу» кампанії ---------
    // opts.model() — 'cpm' | 'cpc' | null; opts.targeting() — {language, device, cats, subs};
    // opts.onChange() — після зміни вибору (прогноз бюджету).
    function initPlaces(box, opts) {
        var t = JSON.parse(box.getAttribute('data-i18n') || '{}');
        var house = box.getAttribute('data-house') === '1';
        var minViews = parseInt(box.getAttribute('data-min-views'), 10) || 100;
        var items = Array.prototype.slice.call(box.querySelectorAll('[data-pc-place]'));
        var all = box.querySelector('[data-pc-places-all]');
        var required = box.querySelector('[data-pc-places-required]');
        var onChange = opts.onChange || function () {};

        function inputs(enabledOnly) {
            return items.map(function (item) { return item.querySelector('input'); })
                .filter(function (i) { return !enabledOnly || !i.disabled; });
        }
        function syncAll() {
            var enabled = inputs(true);
            var checked = enabled.filter(function (i) { return i.checked; }).length;
            all.disabled = enabled.length === 0;
            all.checked = enabled.length > 0 && checked === enabled.length;
            all.indeterminate = checked > 0 && checked < enabled.length;
            if (checked > 0) {
                required.hidden = true;
            }
        }
        function refresh() {
            var m = opts.model();
            items.forEach(function (item) {
                var input = item.querySelector('input');
                var block = item.getAttribute('data-block');
                var price = m ? parseInt(item.getAttribute('data-' + m), 10) || 0 : 0;
                var ok = !block && (house || price > 0);
                input.disabled = !ok;
                if (!ok) {
                    input.checked = false;
                }
                item.classList.toggle('is-disabled', !ok);
                var priceEl = item.querySelector('[data-pc-place-price]');
                if (priceEl && !block) {
                    priceEl.textContent = !m ? t.place_no_model : (price > 0 ? item.getAttribute('data-' + m + '-text') : t.place_no_price);
                    priceEl.classList.toggle('pc-warn-text', !!m && price <= 0);
                }
            });
            syncAll();
        }

        all.addEventListener('change', function () {
            inputs(true).forEach(function (i) { i.checked = all.checked; });
            syncAll();
            onChange();
        });
        inputs(false).forEach(function (i) {
            i.addEventListener('change', function () { syncAll(); onChange(); });
        });

        // Орієнтовна ємність: перегляди сторінок місця за 30 днів у межах таргетингу.
        var timer = null;
        var seq = 0;
        function loadCapacity() {
            window.clearTimeout(timer);
            timer = window.setTimeout(function () {
                var tg = opts.targeting();
                var q = new URLSearchParams({
                    cats: tg.cats.join(','), subs: tg.subs.join(','), language: tg.language || 'all', device: tg.device || 'all'
                });
                var my = ++seq;
                items.forEach(function (item) { item.querySelector('[data-pc-place-capacity]').textContent = t.capacity_loading; });
                fetch(box.getAttribute('data-capacity-url') + '?' + q.toString(), { credentials: 'same-origin' })
                    .then(function (res) { return res.ok ? res.json() : {}; })
                    .catch(function () { return {}; })
                    .then(function (data) {
                        if (my !== seq) {
                            return;
                        }
                        items.forEach(function (item) {
                            var n = data[item.getAttribute('data-pc-place')];
                            var el = item.querySelector('[data-pc-place-capacity]');
                            if (typeof n !== 'number') {
                                el.textContent = t.capacity_none;
                            } else if (n < minViews) {
                                el.textContent = t.capacity_few;
                            } else {
                                el.textContent = String(t.capacity_views || '%s').replace('%s', n.toLocaleString(document.documentElement.lang === 'en' ? 'en-US' : 'uk-UA'));
                            }
                        });
                    });
            }, 300);
        }

        refresh();
        loadCapacity();

        return {
            refresh: refresh,
            loadCapacity: loadCapacity,
            // Мінімум одна галочка: false — показали спокійне повідомлення.
            validate: function () {
                if (inputs(true).some(function (i) { return i.checked; })) {
                    return true;
                }
                required.hidden = false;
                required.scrollIntoView({ block: 'center', behavior: 'smooth' });
                return false;
            },
            labels: function () {
                return items.filter(function (item) { return item.querySelector('input').checked; })
                    .map(function (item) { return item.querySelector('strong').textContent; });
            }
        };
    }

    document.querySelectorAll('form.pc-places-form').forEach(function (f) {
        var box = f.querySelector('[data-pc-places]');
        var fixed = JSON.parse(box.getAttribute('data-fixed-targeting') || '{}');
        var places = initPlaces(box, {
            model: function () { return box.getAttribute('data-fixed-model') || null; },
            targeting: function () { return { language: fixed.language, device: fixed.device, cats: fixed.cats || [], subs: fixed.subs || [] }; }
        });
        f.addEventListener('submit', function (e) {
            if (!places.validate()) {
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
        var tpl = i18n.money_fmt || '%s $';
        var n = (kop / 100).toLocaleString(tpl.charAt(0) === '$' ? 'en-US' : 'uk-UA', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        return fmt(tpl, n);
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

    // --- Ціни й прогноз --------------------------------------------------
    var pricesBox = form.querySelector('[data-pc-prices]');
    var forecastBox = form.querySelector('[data-pc-forecast]');
    var balanceWarn = form.querySelector('[data-pc-balance-warning]');

    function model() {
        return val('objective') === 'clicks' ? 'cpc' : 'cpm';
    }

    // --- Аудиторія й місця показу ----------------------------------------
    // Нічого не вибрано в категоріях = усі категорії.
    var places = initPlaces(form.querySelector('[data-pc-places]'), {
        model: function () { return form.querySelector('[data-pc-places]').getAttribute('data-house') === '1' ? null : model(); },
        targeting: function () {
            return {
                language: val('language'),
                device: val('device'),
                cats: checkedValues('cats[]'),
                subs: checkedValues('subs[]')
            };
        },
        onChange: function () { updatePrices(); }
    });
    form.querySelectorAll('input[name="cats[]"], input[name="subs[]"], select[name="language"], select[name="device"]').forEach(function (i) {
        i.addEventListener('change', places.loadCapacity);
    });
    form.querySelectorAll('input[name="objective"]').forEach(function (i) {
        i.addEventListener('change', places.refresh);
    });
    form.addEventListener('submit', function (e) {
        if (!places.validate()) {
            e.preventDefault();
            go(3);
        }
    });

    function placeTitle(pl) {
        var strong = form.querySelector('[data-pc-place="' + pl + '"] strong');
        return strong ? strong.textContent : pl;
    }

    function updatePrices() {
        if (!pricesBox || !forecastBox) {
            return; // власна реклама сайту — без прайсу й прогнозу
        }
        var m = model();
        var placements = checkedValues('placements[]');
        pricesBox.textContent = '';
        forecastBox.textContent = '';
        var prices = [];
        placements.forEach(function (pl) {
            var p = document.createElement('p');
            var label = placeTitle(pl);
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
        row(labelOf(form.querySelector('input[name="placements[]"]')), places.labels().join(', '));
        var catCount = checkedValues('cats[]').length + checkedValues('subs[]').length;
        row(labelOf(form.querySelector('[data-pc-cats]')), catCount === 0 ? i18n.categories_all : fmt(i18n.categories_selected, catCount));
        row(labelOf(form.elements.daily_budget), val('daily_budget') ? money(parseMoney(val('daily_budget')) || 0) : '');
        row(labelOf(form.elements.total_budget), val('total_budget') ? money(parseMoney(val('total_budget')) || 0) : '');
        row(labelOf(form.elements.start_date), val('start_date') + (val('end_date') ? ' — ' + val('end_date') : ''));

        var need = parseMoney(val('daily_budget')) || parseMoney(val('total_budget')) || 1;
        if (balanceWarn) {
            balanceWarn.hidden = balance >= need;
        }
    }

    previewText();
    toggleShow();
    go(1);
})();
