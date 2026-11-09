/*
 * AI LAB HUB — Marketplace: панель фільтрів (Хвиля 1).
 *   - Панель (<details data-mpf-panel open>) на ширині > 768 px завжди розкрита; на мобільному JS згортає її до кнопки «Фільтри (N)».
 *   - Після зміни фільтра кнопка відправлення показує «Показати N результатів» (GET mp-count.php з тими ж полями).
 *   Без JS усе працює: форма — звичайний GET, кнопка «Показати результати».
 */
(function () {
    'use strict';
    // Панель розмічена відкритою (без JS усе видно); на мобільному — згортаємо до кнопки «Фільтри (N)».
    var mobile = window.matchMedia ? window.matchMedia('(max-width: 768px)') : null;
    document.querySelectorAll('[data-mpf-panel]').forEach(function (panel) {
        if (mobile && mobile.matches) { panel.open = false; }
    });

    document.querySelectorAll('form[data-count-url]').forEach(function (form) {
        var btn = form.querySelector('[data-mpf-submit]');
        var label = form.getAttribute('data-count-label') || '%d';
        var page = form.getAttribute('data-count-page') || '';
        if (!btn || !window.fetch || !window.URLSearchParams || !window.FormData) { return; }
        var timer = null, seq = 0;
        function update() {
            var params = new URLSearchParams(new FormData(form));
            params.set('p', page);
            params.delete('page');
            var my = ++seq;
            btn.setAttribute('aria-busy', 'true');
            fetch(form.getAttribute('data-count-url') + '?' + params.toString(), { credentials: 'same-origin', headers: { 'Accept': 'application/json' } })
                .then(function (r) { return r.ok ? r.json() : null; })
                .then(function (j) {
                    if (my !== seq) { return; }
                    btn.removeAttribute('aria-busy');
                    if (j && j.ok && typeof j.total === 'number') { btn.textContent = label.replace('%d', String(j.total)); }
                })
                .catch(function () { btn.removeAttribute('aria-busy'); });
        }
        form.addEventListener('change', function () { clearTimeout(timer); timer = setTimeout(update, 300); });
        form.addEventListener('input', function (e) {
            if (e.target && e.target.type === 'text') { clearTimeout(timer); timer = setTimeout(update, 600); }
        });
    });
})();
