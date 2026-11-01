/* AI LAB HUB — кнопка «Поділитися».
 *
 * Один спільний компонент: вставляється в кожну шапку сайту (.site-header)
 * поруч із кнопкою «Викликати Асистента», без жодних правок на окремих
 * сторінках. Заголовок і URL беруться з document.title / поточного
 * location — вони вже коректні на кожній сторінці (назва продукту,
 * категорії тощо — те саме, що й у <title>).
 *
 * Мобільні / браузери з navigator.share → нативне вікно поділитися.
 * Десктоп без підтримки → власне випадаюче меню (копіювати посилання,
 * Telegram, Facebook, WhatsApp, Twitter/X, email).
 *
 * Тексти надає app/footer.php:
 *   window.SHARE_I18N — { button, copyLink, copied, email, productText }
 */
(function () {
    'use strict';

    var I18N = window.SHARE_I18N || {
        button: 'Поділитися',
        copyLink: 'Скопіювати посилання',
        copied: 'Посилання скопійовано',
        email: 'Електронна пошта',
        productText: 'Перегляньте %s на AI LAB HUB'
    };

    var ICONS = {
        share: '<circle cx="18" cy="5" r="3"/><circle cx="6" cy="12" r="3"/><circle cx="18" cy="19" r="3"/>'
            + '<line x1="8.59" y1="13.51" x2="15.42" y2="17.49"/><line x1="15.41" y1="6.51" x2="8.59" y2="10.49"/>',
        link: '<path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"/>'
            + '<path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"/>',
        telegram: '<line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/>',
        facebook: '<path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/>',
        whatsapp: '<path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/>',
        twitter: '<path d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z"/>',
        email: '<path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22 6 12 13 2 6"/>'
    };

    function svg(name, extraClass) {
        return '<svg class="' + (extraClass || '') + '" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" '
            + 'fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">'
            + ICONS[name] + '</svg>';
    }

    /** Заголовок/текст/URL поточної сторінки — те саме, що вже у <title>. */
    function shareData() {
        var url = window.location.href;
        var rawTitle = document.title || 'AI LAB HUB';
        var isProduct = /product\.php/.test(window.location.pathname);

        if (isProduct) {
            var bareTitle = rawTitle.replace(/^AI LAB HUB\s*[—-]\s*/, '');
            return {
                title: bareTitle,
                text: I18N.productText.replace('%s', bareTitle),
                url: url
            };
        }

        return { title: rawTitle, text: rawTitle, url: url };
    }

    function copyToClipboard(text) {
        if (navigator.clipboard && navigator.clipboard.writeText) {
            return navigator.clipboard.writeText(text);
        }
        return new Promise(function (resolve, reject) {
            var ta = document.createElement('textarea');
            ta.value = text;
            ta.style.position = 'fixed';
            ta.style.left = '-9999px';
            document.body.appendChild(ta);
            ta.select();
            try {
                document.execCommand('copy') ? resolve() : reject(new Error('copy failed'));
            } catch (e) {
                reject(e);
            } finally {
                document.body.removeChild(ta);
            }
        });
    }

    var toastEl = null;
    var toastTimer = null;

    function showToast(anchorEl, text) {
        if (toastTimer) {
            window.clearTimeout(toastTimer);
        }
        if (!toastEl) {
            toastEl = document.createElement('div');
            toastEl.className = 'share-toast';
            toastEl.setAttribute('role', 'status');
            document.body.appendChild(toastEl);
        }
        toastEl.textContent = text;

        var r = anchorEl.getBoundingClientRect();
        var width = 240; // орієнтовно, точний розмір ще не відрендерено
        var left = Math.max(8, Math.min(r.left + r.width / 2 - width / 2, window.innerWidth - width - 8));
        var top = r.bottom + 8;
        toastEl.style.left = left + 'px';
        toastEl.style.top = top + 'px';

        // Форсуємо reflow, щоб клас is-visible завжди зіграв перехід.
        toastEl.classList.remove('is-visible');
        void toastEl.offsetWidth;
        toastEl.classList.add('is-visible');

        toastTimer = window.setTimeout(function () {
            if (toastEl) {
                toastEl.classList.remove('is-visible');
            }
        }, 2000);
    }

    var menuEl = null;
    var menuOpenBtn = null;

    function closeMenu() {
        if (menuEl) {
            menuEl.setAttribute('hidden', '');
        }
        menuOpenBtn = null;
    }

    function buildMenu() {
        var el = document.createElement('div');
        el.className = 'share-menu';
        el.setAttribute('role', 'menu');
        el.setAttribute('hidden', '');
        document.body.appendChild(el);
        return el;
    }

    function openMenu(btn) {
        if (menuOpenBtn === btn) {
            closeMenu();
            return;
        }
        if (!menuEl) {
            menuEl = buildMenu();
        }

        var data = shareData();
        var encUrl = encodeURIComponent(data.url);
        var encText = encodeURIComponent(data.text);
        var encTitle = encodeURIComponent(data.title);

        menuEl.innerHTML =
            '<button type="button" class="share-menu__item" data-action="copy">' + svg('link') + '<span>' + I18N.copyLink + '</span></button>'
            + '<a class="share-menu__item" target="_blank" rel="noopener" href="https://t.me/share/url?url=' + encUrl + '&text=' + encText + '">' + svg('telegram') + '<span>Telegram</span></a>'
            + '<a class="share-menu__item" target="_blank" rel="noopener" href="https://www.facebook.com/sharer/sharer.php?u=' + encUrl + '">' + svg('facebook') + '<span>Facebook</span></a>'
            + '<a class="share-menu__item" target="_blank" rel="noopener" href="https://wa.me/?text=' + encText + '%20' + encUrl + '">' + svg('whatsapp') + '<span>WhatsApp</span></a>'
            + '<a class="share-menu__item" target="_blank" rel="noopener" href="https://twitter.com/intent/tweet?url=' + encUrl + '&text=' + encText + '">' + svg('twitter') + '<span>Twitter / X</span></a>'
            + '<a class="share-menu__item" href="mailto:?subject=' + encTitle + '&body=' + encText + '%0A%0A' + encUrl + '">' + svg('email') + '<span>' + I18N.email + '</span></a>';

        menuEl.removeAttribute('hidden');
        menuOpenBtn = btn;

        var r = btn.getBoundingClientRect();
        var menuWidth = menuEl.offsetWidth || 200;
        var left = Math.max(8, Math.min(r.left, window.innerWidth - menuWidth - 8));
        var top = r.bottom + 6;
        if (top + menuEl.offsetHeight > window.innerHeight - 8) {
            top = r.top - menuEl.offsetHeight - 6;
        }
        menuEl.style.left = left + 'px';
        menuEl.style.top = top + 'px';
    }

    document.addEventListener('click', function (event) {
        if (menuEl && menuEl.contains(event.target)) {
            if (event.target.closest('[data-action="copy"]')) {
                var data = shareData();
                copyToClipboard(data.url).then(function () {
                    showToast(menuOpenBtn || document.body, I18N.copied);
                }).catch(function () {});
            }
            closeMenu();
            return;
        }
        if (menuOpenBtn && event.target !== menuOpenBtn && !menuOpenBtn.contains(event.target)) {
            closeMenu();
        }
    });

    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') {
            closeMenu();
        }
    });

    function handleShareClick(btn) {
        var data = shareData();
        if (navigator.share) {
            navigator.share({ title: data.title, text: data.text, url: data.url }).catch(function () {});
            return;
        }
        openMenu(btn);
    }

    function buildButton() {
        var btn = document.createElement('button');
        btn.type = 'button';
        btn.className = 'share-btn';
        btn.setAttribute('aria-label', I18N.button);
        btn.innerHTML = svg('share');
        btn.addEventListener('click', function (event) {
            event.stopPropagation();
            handleShareClick(btn);
        });
        return btn;
    }

    function mount() {
        var header = document.querySelector('.site-header');
        if (!header || header.querySelector('.share-btn')) {
            return;
        }

        var btn = buildButton();
        var cta = header.querySelector('.site-header__cta');
        if (cta) {
            header.insertBefore(btn, cta.nextSibling);
        } else {
            header.appendChild(btn);
        }
    }

    mount();
})();
