/* AI LAB HUB — розкривні пункти меню шапки (<details class="site-nav__group">, app/site-header.php).
 * Без JS <details> і так розкривається; тут лише зручності: закрити кліком поза меню, клавішею Escape
 * (фокус повертається на пункт) і відкрити лише одне меню за раз. */
(function () {
    'use strict';

    var groups = document.querySelectorAll('.site-nav__group');
    if (!groups.length || window.__siteNavGroupReady) {
        return;
    }
    window.__siteNavGroupReady = true;

    function closeAll(except) {
        groups.forEach(function (g) {
            if (g !== except) {
                g.open = false;
            }
        });
    }

    groups.forEach(function (g) {
        g.addEventListener('toggle', function () {
            if (g.open) {
                closeAll(g);
            }
        });
    });

    document.addEventListener('click', function (e) {
        groups.forEach(function (g) {
            if (g.open && !g.contains(e.target)) {
                g.open = false;
            }
        });
    });

    document.addEventListener('keydown', function (e) {
        if (e.key !== 'Escape') {
            return;
        }
        groups.forEach(function (g) {
            if (g.open) {
                g.open = false;
                var s = g.querySelector('summary');
                if (s) {
                    s.focus();
                }
            }
        });
    });
})();
