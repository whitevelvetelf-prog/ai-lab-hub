<?php

/**
 * AI LAB HUB — спільний підвал сайту + адаптив шапки.
 *
 * Підключати перед </body> на кожній сторінці:
 *   include __DIR__ . '/../app/footer.php';
 *
 * Тут в одному місці: стилі підвалу, адаптив шапки (гнучка розкладка +
 * гамбургер на вузьких екранах), перемикач мови UA/EN у шапці, розмітка
 * підвалу та скрипт-перемикач мобільного меню. Оновлювати підвал — лише
 * в цьому файлі.
 */

require_once __DIR__ . '/auth.php';
require_once __DIR__ . '/translations.php';
require_once __DIR__ . '/paw-icon.php';

?>
<style>
    /* ===== Шапка: гнучка розкладка + гамбургер на вузьких екранах =====
       Кнопка «Викликати Асистента» (.site-header__cta) винесена з <nav>,
       тож на мобільному лишається видимою поруч із гамбургером; гамбургер
       згортає лише Головна + Кабінет/Увійти. */
    .site-header {
        gap: 16px 24px;
        flex-wrap: wrap;
    }

    .site-nav__toggle {
        display: none;
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

    /* Мобільна шапка (< 768px): «Головна / Кабінет / Увійти» — у гамбургер.
       Повний набір правил нижче, після базових стилів перемикача мови
       (щоб перебивати їх за рівної специфічності). */

    /* ===== Перемикач мови UA/EN у шапці =====
       Розмітку вставляє скрипт унизу цього файлу — у кожній шапці
       (.site-header) сайту, перед кнопкою «Викликати Асистента». */
    .site-lang {
        display: inline-flex;
        align-items: center;
        gap: 2px;
        padding: 3px;
        border-radius: 999px;
        border: 1px solid rgba(255, 255, 255, 0.25);
    }

    .site-lang__btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 38px;
        padding: 6px 10px;
        border-radius: 999px;
        font-size: 0.8rem;
        font-weight: 700;
        letter-spacing: 0.04em;
        text-decoration: none;
        color: rgba(255, 255, 255, 0.75);
        transition: color 0.15s ease, background 0.15s ease;
    }

    .site-lang__btn:hover {
        color: #ffffff;
    }

    .site-lang__btn.is-active {
        color: #00032c;
        background: linear-gradient(135deg, #5b8cff, #a5c0ff);
    }

    /* ===== Мобільна шапка (< 768px) =====
       «Головна / Кабінет / Увійти» ховаються в гамбургер. Верхній рядок:
       логотип → (вільний простір) → перемикач мови → кнопка асистента →
       гамбургер. Кнопка асистента ЗАВЖДИ показує короткий підпис поруч з
       іконкою (ніколи не лишається самою іконкою) і має пріоритет: не
       стискається і завжди видима повністю. */
    @media (max-width: 768px) {
        .site-header {
            justify-content: flex-start;
        }

        .site-header__logo {
            height: 40px;
        }

        .site-nav__toggle {
            display: flex;
            flex-shrink: 0;
            margin-left: 10px;
        }

        /* Перемикач мови забирає вільний простір і притискає праву групу. */
        .site-lang {
            margin-left: auto;
        }

        /* Довгий підпис із розмітки ховаємо (font-size: 0), а короткий
           показуємо через ::after — так не треба правити шапку на кожній
           сторінці. Доступна назва посилання лишається для скрінрідерів. */
        .site-header__cta {
            margin-left: 10px;
            flex-shrink: 0;
            font-size: 0;
            gap: 0;
            padding: 10px 14px;
        }

        .site-header__cta > svg {
            width: 18px;
            height: 18px;
        }

        .site-header__cta::after {
            content: <?= '"' . addcslashes(t('nav_assistant_short'), '"\\') . '"' ?>;
            margin-left: 8px;
            font-size: 0.82rem;
            font-weight: 600;
            letter-spacing: 0.01em;
            white-space: nowrap;
        }

        .site-header .site-nav {
            order: 4;
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

    /* Вузькі екрани (< 480px): перемикач мови переїжджає на власний рядок під
       верхньою смугою — так логотип + кнопка асистента (з текстом) + гамбургер
       гарантовано вміщаються в перший рядок навіть на 320px. */
    @media (max-width: 480px) {
        .site-lang {
            order: 3;
            flex-basis: 100%;
            justify-content: center;
            margin: 4px 0 0;
        }

        /* Кнопка асистента + гамбургер притискаються праворуч у першому рядку. */
        .site-header__cta {
            margin-left: auto;
        }
    }

    /* Найвужчі екрани (≈320–380px): підтискаємо логотип, гамбургер та відступи.
       Кнопка асистента з текстом лишається недоторканою. */
    @media (max-width: 380px) {
        .site-header {
            gap: 10px 12px;
            padding: 14px 12px;
        }

        .site-header__logo {
            height: 34px;
        }

        .site-header__cta {
            padding: 9px 12px;
        }

        .site-nav__toggle {
            width: 40px;
            height: 40px;
            padding: 10px;
        }
    }

    /* ===== Пошук у шапці =====
       Розмітку вставляє public/assets/js/site-search.js. .site-search
       завжди йде окремим (повношириним) другим рядком під навігацією —
       order: 10 + flex-basis: 100% всередині гнучкого .site-header
       (та сама техніка, що й для #siteNav на мобільному нижче), тож
       ані кнопка Елі, ані гамбургер не зачіпаються: обидва лишаються
       в першому рядку, як і раніше. */
    .site-search {
        order: 10;
        flex-basis: 100%;
        width: 100%;
    }

    .site-search__inner {
        position: relative;
        width: 65%;
        max-width: 600px;
        min-width: 280px;
        margin: 0 auto;
    }

    .site-search__form {
        position: relative;
        display: flex;
        align-items: center;
    }

    .site-search__icon {
        position: absolute;
        left: 14px;
        width: 18px;
        height: 18px;
        color: rgba(255, 255, 255, 0.55);
        pointer-events: none;
    }

    .site-search__input {
        width: 100%;
        padding: 11px 40px;
        border-radius: 999px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        background: rgba(255, 255, 255, 0.06);
        color: #ffffff;
        font-size: 0.95rem;
        font-family: inherit;
    }

    .site-search__input::placeholder {
        color: rgba(255, 255, 255, 0.5);
    }

    .site-search__input::-webkit-search-cancel-button {
        display: none;
    }

    .site-search__clear {
        display: none;
        position: absolute;
        right: 8px;
        width: 26px;
        height: 26px;
        align-items: center;
        justify-content: center;
        border: none;
        border-radius: 999px;
        background: transparent;
        color: rgba(255, 255, 255, 0.6);
        font-size: 1.1rem;
        line-height: 1;
        cursor: pointer;
    }

    .site-search__clear.is-visible {
        display: inline-flex;
    }

    .site-search__clear:hover {
        color: #ffffff;
        background: rgba(255, 255, 255, 0.1);
    }

    .site-search__results {
        position: absolute;
        top: calc(100% + 8px);
        left: 0;
        right: 0;
        background: #0b0f3d;
        border: 1px solid rgba(255, 255, 255, 0.16);
        border-radius: 14px;
        box-shadow: 0 20px 50px rgba(0, 0, 0, 0.45);
        padding: 8px;
        max-height: 400px;
        overflow-y: auto;
        z-index: 60;
    }

    .site-search__results[hidden] {
        display: none;
    }

    .site-search__item {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 8px;
        border-radius: 10px;
        text-decoration: none;
        color: #ffffff;
        cursor: pointer;
    }

    .site-search__item:hover,
    .site-search__item.is-active {
        background: rgba(255, 255, 255, 0.08);
    }

    .site-search__thumb {
        flex-shrink: 0;
        width: 36px;
        height: 36px;
        border-radius: 8px;
        object-fit: cover;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 0.75rem;
        font-weight: 700;
        color: #ffffff;
        background: linear-gradient(135deg, #2116ad, #5b8cff);
    }

    .site-search__text {
        min-width: 0;
        display: flex;
        flex-direction: column;
        gap: 2px;
    }

    .site-search__name {
        font-weight: 600;
        font-size: 0.92rem;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .site-search__meta {
        font-size: 0.78rem;
        color: rgba(255, 255, 255, 0.6);
    }

    .site-search__empty {
        margin: 0;
        padding: 14px 8px;
        text-align: center;
        color: rgba(255, 255, 255, 0.75);
        font-size: 0.9rem;
        line-height: 1.5;
    }

    .site-search__empty a {
        color: #a5c0ff;
        font-weight: 600;
    }

    .site-search__viewall {
        display: block;
        text-align: center;
        padding: 10px;
        margin-top: 6px;
        border-top: 1px solid rgba(255, 255, 255, 0.12);
        color: #a5c0ff;
        text-decoration: none;
        font-weight: 600;
        font-size: 0.88rem;
    }

    .site-search__viewall:hover {
        color: #ffffff;
    }

    /* Мобільний — поле на всю ширину рядка (немає сенсу тримати 65%-обмеження
       на вузькому екрані), трохи більший розмір торкання. Рядок 1 (лого,
       кнопка Елі, гамбургер) цей блок не займає — лишається компактним. */
    @media (max-width: 768px) {
        .site-search__inner {
            width: 100%;
            max-width: none;
            min-width: 0;
        }

        .site-search__input {
            font-size: 1rem;
            padding: 12px 40px;
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
            <li><a href="blog.php"><?= htmlspecialchars(t('footer_blog'), ENT_QUOTES) ?></a></li>
            <li><a href="about.php"><?= htmlspecialchars(t('footer_about'), ENT_QUOTES) ?></a></li>
            <li><a href="contacts.php"><?= htmlspecialchars(t('footer_contacts'), ENT_QUOTES) ?></a></li>
            <li><a href="terms.php"><?= htmlspecialchars(t('footer_terms'), ENT_QUOTES) ?></a></li>
            <li><a href="privacy.php"><?= htmlspecialchars(t('footer_privacy'), ENT_QUOTES) ?></a></li>
        </ul>

        <a class="site-footer__support" href="/donate.php">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 14c1.49-1.46 3-3.21 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.76 0-3 .5-4.5 2-1.5-1.5-2.74-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4.05 3 5.5l7 7Z"/></svg>
            <?= htmlspecialchars(t('footer_support'), ENT_QUOTES) ?>
        </a>

        <nav class="site-footer__social" aria-label="<?= htmlspecialchars(t('footer_social'), ENT_QUOTES) ?>">
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

<?php /* ===== Пошук у шапці: довге поле на 2-му рядку + живі підказки ===== */ ?>
<script>
    window.SEARCH_I18N = {
        placeholder: <?= json_encode(t('search_placeholder'), JSON_UNESCAPED_UNICODE) ?>,
        clearAria: <?= json_encode(t('search_clear_aria'), JSON_UNESCAPED_UNICODE) ?>,
        noResults: <?= json_encode(t('search_no_results'), JSON_UNESCAPED_UNICODE) ?>,
        noResultsHint: <?= json_encode(t('search_no_results_hint'), JSON_UNESCAPED_UNICODE) ?>,
        askEli: <?= json_encode(t('search_ask_eli_link'), JSON_UNESCAPED_UNICODE) ?>,
        viewAll: <?= json_encode(t('search_view_all'), JSON_UNESCAPED_UNICODE) ?>
    };
</script>
<script src="/assets/js/site-search.js"></script>

<script>
    /* Перемикач мови UA/EN. Вставляємо в кожну шапку сайту, щоб не дублювати
       розмітку в десятках сторінок. Посилання ведуть на поточний URL із
       ?lang=uk|en — сервер (app/translations.php) зберігає вибір у сесію
       і повертає на цю ж сторінку без параметра. */
    (function () {
        var current = <?= json_encode(current_lang()) ?>;
        var label = <?= json_encode(t('lang_switch')) ?>;
        var languages = <?= json_encode(active_languages(), JSON_UNESCAPED_UNICODE) ?>;
        var header = document.querySelector('.site-header');
        if (!header || header.querySelector('.site-lang')) {
            return;
        }

        function langUrl(lang) {
            var url = new URL(window.location.href);
            url.searchParams.set('lang', lang);
            return url.pathname + url.search + url.hash;
        }

        var box = document.createElement('div');
        box.className = 'site-lang';
        box.setAttribute('role', 'group');
        box.setAttribute('aria-label', label);

        Object.keys(languages).forEach(function (code) {
            var a = document.createElement('a');
            a.className = 'site-lang__btn' + (code === current ? ' is-active' : '');
            a.href = langUrl(code);
            a.textContent = languages[code];
            a.setAttribute('lang', code);
            if (code === current) {
                a.setAttribute('aria-current', 'true');
            }
            box.appendChild(a);
        });

        var cta = header.querySelector('.site-header__cta');
        if (cta) {
            header.insertBefore(box, cta);
        } else {
            header.appendChild(box);
        }
    })();
</script>

<?php /* ===== Кнопка «Поділитися»: одна на всі сторінки, поруч із «Викликати Асистента» ===== */ ?>
<script>
    window.SHARE_I18N = {
        button: <?= json_encode(t('share_button'), JSON_UNESCAPED_UNICODE) ?>,
        copyLink: <?= json_encode(t('share_copy_link'), JSON_UNESCAPED_UNICODE) ?>,
        copied: <?= json_encode(t('share_copied'), JSON_UNESCAPED_UNICODE) ?>,
        email: <?= json_encode(t('share_email'), JSON_UNESCAPED_UNICODE) ?>,
        productText: <?= json_encode(t('share_product_text'), JSON_UNESCAPED_UNICODE) ?>
    };
</script>
<script src="/assets/js/share-button.js"></script>

<?php /* ===== Кнопка «Назад» на картці продукту: розмітку дає app/back-button.php ===== */ ?>
<script src="/assets/js/back-button.js"></script>

<script>
    if ('serviceWorker' in navigator) {
        window.addEventListener('load', function () {
            navigator.serviceWorker.register('/sw.js').catch(function () {});
        });
    }
</script>

<script src="/assets/js/pwa-install.js" defer></script>

<?php /* ===== «Моя добірка»: іконка-лапка, кнопка «зберегти», пункт меню ===== */ ?>
<?= paw_icon_sprite() ?>
<script>
    window.AI_LAB_AUTH = <?= auth_check() ? 'true' : 'false' ?>;
    window.SAVED_I18N = {
        save: <?= json_encode(t('saved_btn_save'), JSON_UNESCAPED_UNICODE) ?>,
        unsave: <?= json_encode(t('saved_btn_unsave'), JSON_UNESCAPED_UNICODE) ?>,
        hintGuest: <?= json_encode(t('saved_hint_guest'), JSON_UNESCAPED_UNICODE) ?>,
        loginUrl: 'login.php',
        error: <?= json_encode(t('saved_error'), JSON_UNESCAPED_UNICODE) ?>
    };
</script>
<script src="/assets/js/saved-products.js" defer></script>

<?php if (auth_check()): ?>
<script>
    /* Пункт меню «Моя добірка» — лише для залогінених; вставляємо в кожну
       шапку сайту, щоб не дублювати розмітку в десятках сторінок. */
    (function () {
        var nav = document.getElementById('siteNav');
        if (!nav || nav.querySelector('[data-nav-saved]')) {
            return;
        }
        var a = document.createElement('a');
        a.className = 'site-nav__link';
        a.href = 'saved.php';
        a.setAttribute('data-nav-saved', '');
        a.textContent = <?= json_encode(t('nav_saved'), JSON_UNESCAPED_UNICODE) ?>;
        if (/(^|\/)saved\.php(\?|$)/.test(window.location.pathname + window.location.search)) {
            a.setAttribute('aria-current', 'page');
        }
        nav.appendChild(a);
    })();
</script>
<?php endif; ?>
