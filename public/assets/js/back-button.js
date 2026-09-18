/* AI LAB HUB — кнопка «Назад» на картці продукту (app/back-button.php).
 *
 * href завжди веде на резервну адресу (data-fallback) — працює і без JS.
 * Якщо ж referrer цієї вкладки — той самий домен і є куди повертатись,
 * перехоплюємо клік і робимо history.back(), щоб користувач опинився
 * саме там, звідки прийшов (каталог, категорія, пошук, чат Елі, інша картка).
 */
(function () {
    'use strict';

    function isSameOrigin(url) {
        try {
            return new URL(url, window.location.href).origin === window.location.origin;
        } catch (e) {
            return false;
        }
    }

    var links = document.querySelectorAll('.back-nav[data-fallback]');
    for (var i = 0; i < links.length; i++) {
        links[i].addEventListener('click', function (event) {
            if (document.referrer && isSameOrigin(document.referrer) && window.history.length > 1) {
                event.preventDefault();
                window.history.back();
            }
        });
    }
})();
