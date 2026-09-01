<?php

/**
 * AI LAB HUB — спільний підвал сайту + адаптив шапки.
 *
 * Підключати перед </body> на кожній сторінці:
 *   include __DIR__ . '/../app/footer.php';
 *
 * Тут в одному місці: стилі підвалу, адаптив шапки (гнучка розкладка +
 * гамбургер на вузьких екранах), розмітка підвалу та скрипт-перемикач
 * мобільного меню. Оновлювати підвал — лише в цьому файлі.
 */

?>
<style>
    /* ===== Шапка: гнучка розкладка + гамбургер на вузьких екранах ===== */
    .site-header {
        gap: 16px 24px;
        flex-wrap: wrap;
    }

    .site-nav__toggle {
        display: none;
        margin-left: auto;
        width: 44px;
        height: 44px;
        padding: 11px;
        flex-direction: column;
        justify-content: space-between;
        background: transparent;
        border: 1px solid rgba(255, 255, 255, 0.35);
        border-radius: 10px;
        cursor: pointer;
    }

    .site-nav__toggle span {
        display: block;
        width: 100%;
        height: 2px;
        background: #ffffff;
        border-radius: 2px;
    }

    @media (max-width: 720px) {
        .site-header {
            justify-content: flex-start;
        }

        .site-nav__toggle {
            display: flex;
        }

        .site-header .site-nav {
            order: 3;
            flex-basis: 100%;
            margin-left: 0;
            display: none;
            flex-direction: column;
            align-items: stretch;
            gap: 6px;
        }

        .site-header .site-nav.is-open {
            display: flex;
        }

        .site-header .site-nav .site-nav__link {
            justify-content: center;
        }
    }

    /* ===== Підвал ===== */
    .site-footer {
        margin-top: 64px;
        padding: 40px 24px 32px;
        background: linear-gradient(160deg, #00032c 0%, #2116ad 100%);
        border-top: 1px solid rgba(255, 255, 255, 0.14);
        color: rgba(255, 255, 255, 0.75);
        font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    }

    .site-footer__inner {
        max-width: 1080px;
        margin: 0 auto;
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        gap: 20px 40px;
    }

    .site-footer__links {
        display: flex;
        flex-wrap: wrap;
        gap: 8px 22px;
        margin: 0;
        padding: 0;
        list-style: none;
    }

    .site-footer__links a {
        color: rgba(255, 255, 255, 0.75);
        text-decoration: none;
        font-size: 0.92rem;
        font-weight: 600;
        transition: color 0.15s ease;
    }

    .site-footer__links a:hover {
        color: #ffffff;
    }

    .site-footer__support {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        border-radius: 999px;
        font-size: 0.9rem;
        font-weight: 700;
        text-decoration: none;
        color: #00032c;
        background: linear-gradient(135deg, #5b8cff, #a5c0ff);
        box-shadow: 0 6px 18px rgba(91, 140, 255, 0.4);
        transition: background 0.15s ease;
    }

    .site-footer__support:hover {
        background: linear-gradient(135deg, #6f9bff, #b8ceff);
    }

    .site-footer__support svg {
        width: 16px;
        height: 16px;
    }

    .site-footer__social {
        display: flex;
        gap: 12px;
        margin-left: auto;
    }

    .site-footer__social a {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 38px;
        height: 38px;
        border-radius: 50%;
        color: rgba(255, 255, 255, 0.8);
        border: 1px solid rgba(255, 255, 255, 0.25);
        transition: color 0.15s ease, border-color 0.15s ease, background 0.15s ease;
    }

    .site-footer__social a:hover {
        color: #ffffff;
        border-color: #5b8cff;
        background: rgba(91, 140, 255, 0.15);
    }

    .site-footer__social svg {
        width: 18px;
        height: 18px;
    }

    @media (max-width: 640px) {
        .site-footer__inner {
            flex-direction: column;
            align-items: flex-start;
            gap: 22px;
        }

        .site-footer__links {
            flex-direction: column;
            gap: 12px;
        }

        .site-footer__social {
            margin-left: 0;
        }
    }
</style>

<footer class="site-footer">
    <div class="site-footer__inner">
        <ul class="site-footer__links">
            <li><a href="blog.php">Блог</a></li>
            <li><a href="about.php">Про проєкт</a></li>
            <li><a href="contacts.php">Контакти</a></li>
            <li><a href="terms.php">Умови використання</a></li>
            <li><a href="privacy.php">Політика конфіденційності</a></li>
        </ul>

        <a class="site-footer__support" href="#">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/></svg>
            Підтримати проєкт
        </a>

        <nav class="site-footer__social" aria-label="Соцмережі">
            <a href="#" aria-label="Facebook">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/></svg>
            </a>
            <a href="#" aria-label="Instagram">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="20" height="20" x="2" y="2" rx="5" ry="5"/><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"/><line x1="17.5" x2="17.51" y1="6.5" y2="6.5"/></svg>
            </a>
            <a href="#" aria-label="Twitter / X">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z"/></svg>
            </a>
            <a href="#" aria-label="LinkedIn">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"/><rect width="4" height="12" x="2" y="9"/><circle cx="4" cy="4" r="2"/></svg>
            </a>
        </nav>
    </div>
</footer>

<script>
    (function () {
        var toggle = document.querySelector('.site-nav__toggle');
        var nav = document.getElementById('siteNav');
        if (!toggle || !nav) {
            return;
        }
        toggle.addEventListener('click', function () {
            var open = nav.classList.toggle('is-open');
            toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
        });
    })();
</script>
