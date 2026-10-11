/* AI LAB HUB — сторінка донатів (public/donate.php).
 *
 *   * Кнопки «Скопіювати» ([data-copy]): Clipboard API, а де його немає
 *     (старі мобільні браузери, http) — запасний варіант через textarea.
 *     Підпис на 2 с змінюється на «Скопійовано».
 *   * QR-код ([data-qr]) будується локально бібліотекою qrcode-generator (MIT)
 *     у SVG — жодних зовнішніх запитів. Сам QR — посилання на банку.
 */
(function () {
    'use strict';

    var I18N = window.DONATE_I18N || { copied: 'Скопійовано', failed: 'Не вдалося скопіювати' };

    function fallbackCopy(text) {
        var area = document.createElement('textarea');
        area.value = text;
        area.setAttribute('readonly', '');
        area.style.position = 'fixed';
        area.style.top = '0';
        area.style.left = '0';
        area.style.opacity = '0';
        document.body.appendChild(area);
        area.focus();
        area.select();
        area.setSelectionRange(0, text.length); // iOS
        var ok = false;
        try {
            ok = document.execCommand('copy');
        } catch (e) {
            ok = false;
        }
        document.body.removeChild(area);
        return ok;
    }

    function copy(text) {
        if (navigator.clipboard && window.isSecureContext) {
            return navigator.clipboard.writeText(text).then(function () { return true; }, function () {
                return fallbackCopy(text);
            });
        }
        return Promise.resolve(fallbackCopy(text));
    }

    document.querySelectorAll('[data-copy]').forEach(function (btn) {
        var label = btn.querySelector('span');
        var original = label ? label.textContent : '';
        var timer = null;
        btn.addEventListener('click', function () {
            copy(btn.getAttribute('data-copy')).then(function (ok) {
                if (label) {
                    label.textContent = ok ? I18N.copied : I18N.failed;
                }
                btn.classList.toggle('is-copied', ok);
                window.clearTimeout(timer);
                timer = window.setTimeout(function () {
                    if (label) {
                        label.textContent = original;
                    }
                    btn.classList.remove('is-copied');
                }, ok ? 2000 : 4000);
            });
        });
    });

    function renderQr(box) {
        if (typeof window.qrcode !== 'function') {
            return;
        }
        var text = box.getAttribute('data-qr');
        window.qrcode.stringToBytes = window.qrcode.stringToBytesFuncs['UTF-8'];
        var qr = window.qrcode(0, 'M');
        qr.addData(text, 'Byte');
        qr.make();

        var count = qr.getModuleCount();
        var margin = 2;
        var size = count + margin * 2;
        var NS = 'http://www.w3.org/2000/svg';
        var svg = document.createElementNS(NS, 'svg');
        svg.setAttribute('viewBox', '0 0 ' + size + ' ' + size);
        svg.setAttribute('shape-rendering', 'crispEdges');
        svg.setAttribute('aria-hidden', 'true');
        var bg = document.createElementNS(NS, 'rect');
        bg.setAttribute('width', size);
        bg.setAttribute('height', size);
        bg.setAttribute('fill', '#ffffff');
        svg.appendChild(bg);
        var d = '';
        for (var r = 0; r < count; r++) {
            for (var c = 0; c < count; c++) {
                if (qr.isDark(r, c)) {
                    d += 'M' + (c + margin) + ' ' + (r + margin) + 'h1v1h-1z';
                }
            }
        }
        var path = document.createElementNS(NS, 'path');
        path.setAttribute('d', d);
        path.setAttribute('fill', '#000000');
        svg.appendChild(path);
        box.appendChild(svg);
    }

    function initQr() {
        document.querySelectorAll('[data-qr]').forEach(renderQr);
    }

    if (document.readyState === 'complete') {
        initQr();
    } else {
        window.addEventListener('load', initQr);
    }
})();
