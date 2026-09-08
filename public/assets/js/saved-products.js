/* AI LAB HUB — кнопка «зберегти в добірку» (іконка-лапка).
 *
 * Делегований клік по .save-btn на будь-якій сторінці (каталог, видача
 * Елі, «Моя добірка»). Гість → підказка «Увійдіть, щоб зберегти». Залогінений
 * → AJAX-toggle на /api-saved-products.php, миттєва зміна стану без
 * перезавантаження; на 401 (сесія втрачена) → редірект на вхід.
 *
 * Тексти й стан авторизації надає app/footer.php:
 *   window.AI_LAB_AUTH  — true/false
 *   window.SAVED_I18N   — { save, unsave, hintGuest, loginUrl, error }
 */
(function () {
    'use strict';

    var I18N = window.SAVED_I18N || {
        save: 'Зберегти в добірку',
        unsave: 'Прибрати з добірки',
        hintGuest: 'Увійдіть, щоб зберегти',
        loginUrl: 'login.php',
        error: 'Не вдалося. Спробуйте ще раз.'
    };
    var ENDPOINT = '/api-saved-products.php';

    var hintEl = null;
    var hintTimer = null;

    function hideHint() {
        if (hintTimer) {
            window.clearTimeout(hintTimer);
            hintTimer = null;
        }
        if (hintEl) {
            hintEl.classList.remove('is-visible');
            var el = hintEl;
            window.setTimeout(function () {
                if (el && el.parentNode) {
                    el.parentNode.removeChild(el);
                }
            }, 200);
            hintEl = null;
        }
    }

    function showHint(btn, html) {
        hideHint();
        hintEl = document.createElement('div');
        hintEl.className = 'save-hint';
        hintEl.setAttribute('role', 'status');
        hintEl.innerHTML = html;
        document.body.appendChild(hintEl);

        var r = btn.getBoundingClientRect();
        var hr = hintEl.getBoundingClientRect();
        var left = Math.max(8, Math.min(r.left + r.width / 2 - hr.width / 2, window.innerWidth - hr.width - 8));
        var top = r.bottom + 8;
        if (top + hr.height > window.innerHeight - 8) {
            top = r.top - hr.height - 8;
        }
        hintEl.style.left = left + 'px';
        hintEl.style.top = top + 'px';

        window.requestAnimationFrame(function () {
            if (hintEl) {
                hintEl.classList.add('is-visible');
            }
        });
        hintTimer = window.setTimeout(hideHint, 3500);
    }

    function applyState(btn, saved) {
        btn.dataset.saved = saved ? '1' : '0';
        btn.classList.toggle('is-saved', saved);
        btn.setAttribute('aria-pressed', saved ? 'true' : 'false');
        var label = saved ? I18N.unsave : I18N.save;
        btn.setAttribute('aria-label', label);
        btn.setAttribute('title', label);
    }

    function toggle(btn) {
        if (btn.getAttribute('aria-disabled') === 'true') {
            return;
        }
        var productId = parseInt(btn.dataset.productId, 10);
        if (!productId) {
            return;
        }

        // Гість — не чіпаємо сервер, показуємо підказку з посиланням на вхід.
        if (!window.AI_LAB_AUTH) {
            showHint(
                btn,
                '<a href="' + I18N.loginUrl + '">' + I18N.hintGuest + '</a>'
            );
            return;
        }

        var wasSaved = btn.dataset.saved === '1';
        applyState(btn, !wasSaved);            // оптимістично
        btn.setAttribute('aria-disabled', 'true');

        var body = new URLSearchParams();
        body.set('product_id', String(productId));

        fetch(ENDPOINT, {
            method: 'POST',
            headers: { 'X-Requested-With': 'XMLHttpRequest' },
            credentials: 'same-origin',
            body: body
        })
            .then(function (res) {
                if (res.status === 401) {
                    window.location.href = I18N.loginUrl;
                    return null;
                }
                return res.json().catch(function () { return null; });
            })
            .then(function (data) {
                btn.removeAttribute('aria-disabled');
                if (!data || !data.ok) {
                    applyState(btn, wasSaved);   // відкат
                    showHint(btn, I18N.error);
                    return;
                }
                applyState(btn, !!data.saved);

                // На сторінці «Моя добірка» знята картка одразу зникає.
                if (!data.saved && btn.closest('[data-saved-list]')) {
                    var card = btn.closest('.product-card, .rec-card');
                    if (card) {
                        card.style.transition = 'opacity 0.2s ease';
                        card.style.opacity = '0';
                        window.setTimeout(function () {
                            if (card.parentNode) {
                                card.parentNode.removeChild(card);
                            }
                            var list = document.querySelector('[data-saved-list]');
                            if (list && list.querySelectorAll('.product-card, .rec-card').length === 0) {
                                window.location.reload();
                            }
                        }, 210);
                    }
                }
            })
            .catch(function () {
                btn.removeAttribute('aria-disabled');
                applyState(btn, wasSaved);
                showHint(btn, I18N.error);
            });
    }

    document.addEventListener('click', function (e) {
        var btn = e.target.closest ? e.target.closest('.save-btn') : null;
        if (btn) {
            e.preventDefault();
            toggle(btn);
        } else if (hintEl && !e.target.closest('.save-hint')) {
            hideHint();
        }
    });

    window.addEventListener('scroll', hideHint, { passive: true });
    window.addEventListener('resize', hideHint);

    /** Розмітка кнопки для карток, які створюються у JS (видача Елі). */
    window.savedProductsButton = function (productId, saved) {
        var btn = document.createElement('button');
        btn.type = 'button';
        btn.className = 'save-btn' + (saved ? ' is-saved' : '');
        btn.dataset.productId = String(productId);
        applyState(btn, !!saved);
        btn.innerHTML = '<svg class="paw-icon" viewBox="0 0 1024 1024" aria-hidden="true" focusable="false"><use href="#paw-icon"></use></svg>';
        return btn;
    };
})();
