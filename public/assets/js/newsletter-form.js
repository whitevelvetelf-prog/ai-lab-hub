/* AI LAB HUB — форма підписки на розсилку (app/footer.php).
 *
 * AJAX-відправка без перезавантаження сторінки: успіх/дублікат/помилка
 * показуються як текст під полем. Тексти надає app/footer.php:
 *   window.NEWSLETTER_I18N — { success, already, invalid, error }
 */
(function () {
    'use strict';

    var I18N = window.NEWSLETTER_I18N || {
        success: 'Дякуємо! Ви підписані на розсилку.',
        already: 'Ви вже підписані.',
        invalid: 'Некоректний email.',
        error: 'Не вдалося підписатись. Спробуйте пізніше.'
    };

    var form = document.getElementById('newsletterForm');
    if (!form) {
        return;
    }

    var input = document.getElementById('newsletterEmail');
    var message = document.getElementById('newsletterMessage');
    var submitBtn = form.querySelector('.newsletter-form__submit');

    function showMessage(text, isError) {
        message.textContent = text;
        message.hidden = false;
        message.classList.toggle('is-error', !!isError);
        message.classList.toggle('is-success', !isError);
    }

    form.addEventListener('submit', function (event) {
        event.preventDefault();
        var email = input.value.trim();
        if (!email) {
            return;
        }

        submitBtn.disabled = true;

        var body = new URLSearchParams();
        body.set('email', email);

        fetch('/api-newsletter-subscribe.php', {
            method: 'POST',
            headers: { 'X-Requested-With': 'XMLHttpRequest' },
            credentials: 'same-origin',
            body: body
        })
            .then(function (res) {
                return res.json().catch(function () { return null; });
            })
            .then(function (data) {
                submitBtn.disabled = false;
                if (!data || !data.ok) {
                    showMessage((data && data.message) || I18N.error, true);
                    return;
                }
                showMessage(data.already ? I18N.already : I18N.success, false);
                input.value = '';
            })
            .catch(function () {
                submitBtn.disabled = false;
                showMessage(I18N.error, true);
            });
    });
})();
