/**
 * Підтвердження дій на всьому сайті (підключається в app/header.php).
 *
 * <form data-confirm="Текст?"> або <button data-confirm="Текст?"> — перед
 * надсиланням питає window.confirm. Порожній data-confirm — типовий текст
 * мовою сторінки з назвою кнопки. Такі кнопки підсвічує confirm-actions.css.
 * Рекламні кабінети мають власний data-pc-confirm (promo-cabinet.js).
 */
(function () {
    'use strict';

    function message(el, button) {
        var text = (el.getAttribute('data-confirm') || '').trim();
        if (text !== '') {
            return text;
        }
        var label = button ? button.textContent.replace(/\s+/g, ' ').trim() : '';
        var en = (document.documentElement.lang || '').toLowerCase().indexOf('en') === 0;
        if (label === '') {
            return en ? 'Are you sure?' : 'Ви впевнені?';
        }
        return en ? 'Confirm: “' + label + '”?' : 'Підтвердіть дію: «' + label + '»?';
    }

    document.addEventListener('submit', function (e) {
        var form = e.target;
        if (!form || form.tagName !== 'FORM') {
            return;
        }
        var button = e.submitter || null;
        var el = button && button.hasAttribute('data-confirm') ? button
            : (form.hasAttribute('data-confirm') ? form : null);
        if (el && !window.confirm(message(el, button))) {
            e.preventDefault();
            e.stopImmediatePropagation();
        }
    }, true);
})();
