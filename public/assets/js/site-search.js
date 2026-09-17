/* AI LAB HUB — пошук продуктів у шапці (довге поле + живі підказки).
 *
 * Вставляє .site-search (поле пошуку на всю ширину власного рядка +
 * випадаючий список підказок) у кожну шапку сайту, де є основний нав
 * (#siteNav) — тобто на сторінках з повним меню (каталог, категорія,
 * продукт, кабінет, Еля, добірка). Легкі сторінки (про нас, вхід, CRM
 * тощо) пошук не отримують — там немає #siteNav.
 *
 * Поле завжди на видноті окремим рядком під навігацією (CSS:
 * .site-search { order: 10; flex-basis: 100%; } у app/footer.php) —
 * жодного кліку для розгортання не потрібно. Кнопка Елі й гамбургер
 * лишаються в першому рядку шапки, цей блок їх не займає.
 *
 * Тексти надає app/footer.php:
 *   window.SEARCH_I18N — { placeholder, noResults, noResultsHint,
 *                           askEli, viewAll, clearAria }
 */
(function () {
    'use strict';

    var nav = document.getElementById('siteNav');
    var header = document.querySelector('.site-header');
    if (!nav || !header || header.querySelector('.site-search')) {
        return;
    }

    var I18N = window.SEARCH_I18N || {
        placeholder: 'Пошук AI-інструментів…',
        noResults: 'Нічого не знайдено',
        noResultsHint: 'Спробуйте інший запит або',
        askEli: 'запитайте Елю',
        viewAll: 'Показати всі результати',
        clearAria: 'Очистити пошук'
    };
    var ENDPOINT = '/api-search.php';
    var MIN_LENGTH = 2;
    var DEBOUNCE_MS = 300;
    var VIEW_ALL_THRESHOLD = 8;

    var wrap = document.createElement('div');
    wrap.className = 'site-search';

    var inner = document.createElement('div');
    inner.className = 'site-search__inner';

    var form = document.createElement('form');
    form.className = 'site-search__form';
    form.setAttribute('role', 'search');
    form.setAttribute('autocomplete', 'off');

    var resultsId = 'site-search-listbox';

    var icon = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    icon.setAttribute('class', 'site-search__icon');
    icon.setAttribute('viewBox', '0 0 24 24');
    icon.setAttribute('fill', 'none');
    icon.setAttribute('stroke', 'currentColor');
    icon.setAttribute('stroke-width', '2');
    icon.setAttribute('stroke-linecap', 'round');
    icon.setAttribute('stroke-linejoin', 'round');
    icon.innerHTML = '<circle cx="11" cy="11" r="8"></circle><path d="m21 21-4.3-4.3"></path>';

    var input = document.createElement('input');
    input.type = 'search';
    input.className = 'site-search__input';
    input.placeholder = I18N.placeholder;
    input.setAttribute('aria-label', I18N.placeholder);
    input.setAttribute('role', 'combobox');
    input.setAttribute('aria-expanded', 'false');
    input.setAttribute('aria-autocomplete', 'list');
    input.setAttribute('aria-controls', resultsId);

    var clear = document.createElement('button');
    clear.type = 'button';
    clear.className = 'site-search__clear';
    clear.setAttribute('aria-label', I18N.clearAria);
    clear.innerHTML = '&times;';

    form.appendChild(icon);
    form.appendChild(input);
    form.appendChild(clear);

    var results = document.createElement('div');
    results.className = 'site-search__results';
    results.id = resultsId;
    results.setAttribute('role', 'listbox');
    results.hidden = true;

    inner.appendChild(form);
    inner.appendChild(results);
    wrap.appendChild(inner);
    header.appendChild(wrap);

    var debounceTimer = null;
    var activeIndex = -1;
    var requestSeq = 0;

    function hideResults() {
        results.hidden = true;
        input.setAttribute('aria-expanded', 'false');
        activeIndex = -1;
    }

    function updateClearVisibility() {
        clear.classList.toggle('is-visible', input.value.length > 0);
    }

    document.addEventListener('click', function (e) {
        if (!wrap.contains(e.target)) {
            hideResults();
        }
    }, true);

    input.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') {
            if (input.value) {
                input.value = '';
                updateClearVisibility();
            }
            hideResults();
        }
    });

    clear.addEventListener('click', function () {
        input.value = '';
        updateClearVisibility();
        hideResults();
        input.focus();
    });

    function renderEmpty() {
        results.innerHTML = '';
        var p = document.createElement('p');
        p.className = 'site-search__empty';
        var strong = document.createElement('strong');
        strong.textContent = I18N.noResults;
        p.appendChild(strong);
        p.appendChild(document.createElement('br'));
        p.appendChild(document.createTextNode(I18N.noResultsHint + ' '));
        var a = document.createElement('a');
        a.href = 'eli.php';
        a.textContent = I18N.askEli;
        p.appendChild(a);
        results.appendChild(p);
        results.hidden = false;
    }

    function renderResults(items, query) {
        activeIndex = -1;
        results.innerHTML = '';

        if (!items || items.length === 0) {
            renderEmpty();
            return;
        }

        items.forEach(function (item, i) {
            var a = document.createElement('a');
            a.className = 'site-search__item';
            a.href = 'product.php?id=' + encodeURIComponent(item.id);
            a.setAttribute('role', 'option');
            a.id = 'site-search-item-' + i;

            var thumb;
            if (item.logo_url) {
                thumb = document.createElement('img');
                thumb.className = 'site-search__thumb';
                thumb.src = item.logo_url;
                thumb.alt = '';
                thumb.loading = 'lazy';
            } else {
                thumb = document.createElement('span');
                thumb.className = 'site-search__thumb site-search__thumb--initials';
                thumb.textContent = item.initials || '';
            }

            var text = document.createElement('span');
            text.className = 'site-search__text';

            var name = document.createElement('span');
            name.className = 'site-search__name';
            name.textContent = item.name;
            text.appendChild(name);

            var meta = [item.category, item.subcategory].filter(function (v) { return !!v; }).join(' · ');
            if (meta) {
                var metaEl = document.createElement('span');
                metaEl.className = 'site-search__meta';
                metaEl.textContent = meta;
                text.appendChild(metaEl);
            }

            a.appendChild(thumb);
            a.appendChild(text);
            results.appendChild(a);
        });

        if (items.length >= VIEW_ALL_THRESHOLD) {
            var viewAll = document.createElement('a');
            viewAll.className = 'site-search__viewall';
            viewAll.href = 'catalog.php?search=' + encodeURIComponent(query);
            viewAll.textContent = I18N.viewAll;
            results.appendChild(viewAll);
        }

        results.hidden = false;
    }

    function fetchResults(query) {
        var seq = ++requestSeq;
        fetch(ENDPOINT + '?q=' + encodeURIComponent(query), { credentials: 'same-origin' })
            .then(function (res) {
                return res.ok ? res.json() : null;
            })
            .then(function (data) {
                if (seq !== requestSeq) {
                    return; // застаріла відповідь — новіший запит вже в польоті
                }
                if (data && data.ok) {
                    renderResults(data.results, query);
                    input.setAttribute('aria-expanded', 'true');
                }
            })
            .catch(function () {
                // Мовчки ігноруємо мережеву помилку — підказки лишаються порожніми,
                // Enter все одно веде на повну сторінку видачі.
            });
    }

    function scheduleSearch(value) {
        if (debounceTimer) {
            window.clearTimeout(debounceTimer);
        }
        if (value.length < MIN_LENGTH) {
            hideResults();
            return;
        }
        debounceTimer = window.setTimeout(function () {
            fetchResults(value);
        }, DEBOUNCE_MS);
    }

    input.addEventListener('input', function () {
        updateClearVisibility();
        scheduleSearch(input.value.trim());
    });

    // Повернення фокуса в непорожнє поле — одразу показати підказки знову.
    input.addEventListener('focus', function () {
        var value = input.value.trim();
        if (value.length >= MIN_LENGTH) {
            scheduleSearch(value);
        }
    });

    function setActive(index, items) {
        for (var i = 0; i < items.length; i++) {
            items[i].classList.remove('is-active');
        }
        if (index >= 0 && index < items.length) {
            items[index].classList.add('is-active');
            items[index].scrollIntoView({ block: 'nearest' });
            input.setAttribute('aria-activedescendant', items[index].id);
        } else {
            input.removeAttribute('aria-activedescendant');
        }
        activeIndex = index;
    }

    input.addEventListener('keydown', function (e) {
        var items = results.querySelectorAll('.site-search__item');
        if (e.key === 'ArrowDown') {
            if (items.length) {
                e.preventDefault();
                setActive((activeIndex + 1) % items.length, items);
            }
        } else if (e.key === 'ArrowUp') {
            if (items.length) {
                e.preventDefault();
                setActive((activeIndex - 1 + items.length) % items.length, items);
            }
        } else if (e.key === 'Enter' && activeIndex >= 0 && items[activeIndex]) {
            e.preventDefault();
            window.location.href = items[activeIndex].href;
        }
        // Enter без активної підказки — звичайний submit форми нижче.
    });

    form.addEventListener('submit', function (e) {
        e.preventDefault();
        var value = input.value.trim();
        if (value.length < MIN_LENGTH) {
            return;
        }
        window.location.href = 'catalog.php?search=' + encodeURIComponent(value);
    });
})();
