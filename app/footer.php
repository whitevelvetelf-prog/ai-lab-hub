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
require_once __DIR__ . '/marketplace.php';

?>
<style>
    /* ===== Закріплена стрілка «назад» (на всіх сторінках) =====
       Веде на попередню сторінку (history.back), а без історії — на головну.
       JS переносить її першим елементом у закріплену шапку (.site-header),
       тож вона завжди на видному місці й не накладається на контент.
       Запасний варіант — position: fixed під шапкою (top від --header-h,
       z-index 95 < 100 у шапки й підвалу), якщо шапки на сторінці нема.
       Старі текстові посилання «← До …» (.back-link, .back-nav) сховані,
       щоб не дублювати стрілку. */
    .site-back {
        position: fixed;
        left: 16px;
        top: calc(var(--header-h, 84px) + 12px);
        z-index: 95;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 42px;
        height: 42px;
        border-radius: 50%;
        color: #ffffff;
        background: rgba(0, 3, 44, 0.85);
        border: 1px solid rgba(255, 255, 255, 0.3);
        -webkit-backdrop-filter: blur(10px);
        backdrop-filter: blur(10px);
        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.35);
        text-decoration: none;
        transition: background 0.15s ease, border-color 0.15s ease;
    }

    .site-back[hidden] {
        display: none;
    }

    .site-header .site-back {
        position: static;
        flex-shrink: 0;
        box-shadow: none;
    }

    .site-back:hover {
        background: rgba(91, 140, 255, 0.35);
        border-color: rgba(255, 255, 255, 0.5);
    }

    .site-back svg {
        width: 20px;
        height: 20px;
    }

    .back-link,
    .back-nav {
        display: none !important;
    }

    @media (max-width: 600px) {
        .site-back {
            left: 10px;
            width: 38px;
            height: 38px;
        }

        .site-header .site-back {
            width: 38px;
            height: 38px;
        }
    }

    /* ===== Шапка: гнучка розкладка + гамбургер на вузьких екранах =====
       Кнопка «Викликати Асистента» (.site-header__cta) винесена з <nav>,
       тож на мобільному лишається видимою поруч із гамбургером; гамбургер
       згортає лише Головна + Кабінет/Увійти. */
    .site-header {
        gap: 16px 24px;
        flex-wrap: wrap;
    }

    /* ===== Закріплена шапка =====
       Лишається зверху при прокрутці на всіх сторінках. Фон напівпрозорий
       із розмиттям, щоб контент не просвічував крізь логотип і меню.
       scroll-padding-top — щоб якорі (#requests тощо) не ховались під нею. */
    html {
        scroll-padding-top: 96px;
    }

    .site-header {
        position: sticky;
        top: 0;
        z-index: 100;
        background: rgba(0, 3, 44, 0.92);
        -webkit-backdrop-filter: blur(10px);
        backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    /* Перемикач мобільного меню — текстова кнопка «Меню» (t('nav_menu_toggle'))
       замість іконки з трьох рисок; розгортає/згортає той самий #siteNav
       (на мобільному там же й кнопка «Додаток», див. pwa-install.js). */
    .site-nav__toggle {
        display: none;
        align-items: center;
        justify-content: center;
        height: 44px;
        padding: 0 14px;
        background: transparent;
        border: 1px solid rgba(255, 255, 255, 0.35);
        border-radius: 10px;
        color: #ffffff;
        font: inherit;
        font-size: 0.85rem;
        font-weight: 600;
        white-space: nowrap;
        cursor: pointer;
    }

    .site-nav__toggle[aria-expanded="true"] {
        background: rgba(255, 255, 255, 0.12);
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

    /* Вузькі екрани (< 480px): перемикач мови переїжджає в другий рядок під
       верхньою смугою (разом із «Поділитися» — див. блок нижче) — так
       логотип + кнопка асистента (з текстом) + гамбургер гарантовано
       вміщаються в перший рядок навіть на 320px. */
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
            height: 40px;
            padding: 0 10px;
        }
    }

    /* Вузькі екрани (< 480px): перемикач мови й кнопка «Поділитися» — один
       спільний другий рядок (перемикач зліва, «Поділитися» справа) замість
       двох окремих повноширинних. Розрив рядка після верхньої смуги робить
       порожній ::after шапки (order 2, flex-basis 100%, висота 0), а не
       flex-basis 100% самого перемикача. row-gap обнулено, щоб цей
       невидимий рядок не додавав зайвого проміжку; відступи між рядками
       задають margin-top елементів нижніх рядків. Стоїть після блоку
       ≤ 380px, щоб перебити його gap. */
    @media (max-width: 480px) {
        .site-header {
            row-gap: 0;
        }

        .site-header::after {
            content: "";
            order: 2;
            flex-basis: 100%;
            height: 0;
        }

        .site-header .site-lang {
            flex-basis: auto;
            margin: 10px 0 0;
        }

        .site-header .share-btn {
            order: 3;
            margin: 10px 0 0 auto;
        }

        .site-header .site-nav.is-open,
        .site-header .site-search {
            margin-top: 10px;
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
    /* Закріплений підвал: завжди видимий унизу вікна, як шапка вгорі
       (свідоме рішення; варіант «у потоці документа» скасовано). Компактна смуга;
       розсилка й дисклеймер — у панелі .site-footer__more, що розгортається
       вгору. Висоту смуги JS кладе в --footer-h (відступ body і позиція
       кнопки «згорнути» в кабінеті). z-index 100 — як у шапки; вони не
       перетинаються (шапка зверху, підвал знизу). */
    body {
        padding-bottom: var(--footer-h, 72px);
    }

    .site-footer {
        position: fixed;
        left: 0;
        right: 0;
        bottom: 0;
        z-index: 100;
        margin-top: 0;
        padding: 10px 24px;
        max-height: 80vh;
        overflow-y: auto;
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

    .site-footer__toggle {
        padding: 8px 14px;
        border-radius: 999px;
        border: 1px solid rgba(255, 255, 255, 0.3);
        background: transparent;
        color: rgba(255, 255, 255, 0.85);
        font: inherit;
        font-size: 0.85rem;
        font-weight: 600;
        cursor: pointer;
    }

    .site-footer__more {
        display: none;
        padding-top: 14px;
    }

    .site-footer.is-expanded .site-footer__more {
        display: block;
    }

    /* Поки на телефоні відкрита екранна клавіатура (фокус у полі вводу поза
       підвалом — напр. Email/Пароль на сторінці входу), підвал ховаємо:
       інакше браузер піднімає закріплену смугу над клавіатурою і вона
       «їздить» поверх форми. Після виходу з поля підвал на місці. */
    .site-footer.is-kb-hidden {
        display: none;
    }

    @media (max-width: 640px) {
        .site-footer {
            padding: 8px 12px;
        }

        .site-footer__inner {
            gap: 8px 12px;
        }

        .site-footer__links {
            gap: 4px 12px;
        }

        .site-footer__links a {
            font-size: 0.8rem;
        }

        .site-footer__support {
            padding: 6px 12px;
            font-size: 0.8rem;
        }

        .site-footer__social {
            display: none;
        }

        .site-footer__newsletter {
            flex-direction: column;
            align-items: flex-start;
        }

        .newsletter-form__input {
            min-width: 0;
            flex: 1;
        }
    }

    /* ===== Форма підписки на розсилку ===== */
    .site-footer__newsletter {
        max-width: 1080px;
        margin: 0 auto 28px;
        padding-bottom: 28px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.14);
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        justify-content: space-between;
        gap: 14px 20px;
    }

    .newsletter-form__title {
        margin: 0;
        font-size: 1rem;
        font-weight: 700;
        color: #ffffff;
    }

    .newsletter-form {
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        gap: 8px;
    }

    .newsletter-form__input {
        min-width: 220px;
        padding: 10px 16px;
        border-radius: 999px;
        border: 1px solid rgba(255, 255, 255, 0.25);
        background: rgba(255, 255, 255, 0.08);
        color: #ffffff;
        font-size: 0.92rem;
        font-family: inherit;
    }

    .newsletter-form__input::placeholder {
        color: rgba(255, 255, 255, 0.5);
    }

    .newsletter-form__submit {
        padding: 10px 20px;
        border-radius: 999px;
        border: none;
        font-size: 0.9rem;
        font-weight: 700;
        font-family: inherit;
        color: #00032c;
        background: linear-gradient(135deg, #5b8cff, #a5c0ff);
        cursor: pointer;
        transition: background 0.15s ease;
    }

    .newsletter-form__submit:hover {
        background: linear-gradient(135deg, #6f9bff, #b8ceff);
    }

    .newsletter-form__submit:disabled {
        opacity: 0.6;
        cursor: default;
    }

    .newsletter-form__message {
        flex-basis: 100%;
        font-size: 0.85rem;
    }

    .newsletter-form__message.is-success {
        color: #7cffb2;
    }

    .newsletter-form__message.is-error {
        color: #ff9b9b;
    }

    /* ===== Дисклеймер про партнерські посилання ===== */
    .site-footer__disclaimer {
        max-width: 1080px;
        margin: 24px auto 0;
        padding-top: 20px;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        font-size: 0.78rem;
        line-height: 1.5;
        color: rgba(255, 255, 255, 0.5);
        text-align: center;
    }
</style>

<footer class="site-footer" id="siteFooter">
    <div class="site-footer__more" id="siteFooterMore">
    <div class="site-footer__newsletter">
        <p class="newsletter-form__title"><?= htmlspecialchars(t('newsletter_title'), ENT_QUOTES) ?></p>
        <form class="newsletter-form" id="newsletterForm" novalidate>
            <input class="newsletter-form__input" type="email" id="newsletterEmail" name="email"
                   placeholder="<?= htmlspecialchars(t('newsletter_placeholder'), ENT_QUOTES) ?>" required>
            <button class="newsletter-form__submit" type="submit"><?= htmlspecialchars(t('newsletter_submit'), ENT_QUOTES) ?></button>
            <span class="newsletter-form__message" id="newsletterMessage" role="status" hidden></span>
        </form>
    </div>
    <p class="site-footer__disclaimer"><?= htmlspecialchars(t('footer_disclaimer'), ENT_QUOTES) ?></p>
    </div>

    <div class="site-footer__inner">
        <ul class="site-footer__links">
            <li><a href="blog.php"><?= htmlspecialchars(t('footer_blog'), ENT_QUOTES) ?></a></li>
            <?php if (mp_public_nav_visible()): ?>
            <li><a href="marketplace.php"><?= htmlspecialchars(t('footer_marketplace'), ENT_QUOTES) ?></a></li>
            <?php if (mp_rules_link_visible()): ?>
            <li><a href="mp-rules.php"><?= htmlspecialchars(t('footer_mp_rules'), ENT_QUOTES) ?></a></li>
            <?php endif; ?>
            <?php endif; ?>
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

        <button type="button" class="site-footer__toggle" id="siteFooterToggle" aria-expanded="false" aria-controls="siteFooterMore">▲ <?= htmlspecialchars(t('newsletter_submit'), ENT_QUOTES) ?></button>
    </div>
</footer>

<a class="site-back" id="siteBack" href="index.php" aria-label="<?= htmlspecialchars(t('back_button'), ENT_QUOTES) ?>" title="<?= htmlspecialchars(t('back_button'), ENT_QUOTES) ?>">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M19 12H5"/><path d="M12 19l-7-7 7-7"/></svg>
</a>

<script>
    /* Стрілка «назад»: якщо є історія цієї вкладки з нашого ж домену —
       history.back() (повертає туди, звідки прийшли), інакше звичайний
       перехід на головну (href). На головній без такої історії ховаємо. */
    (function () {
        var back = document.getElementById('siteBack');
        if (!back) {
            return;
        }
        var canGoBack = false;
        try {
            canGoBack = !!document.referrer
                && new URL(document.referrer).origin === window.location.origin
                && window.history.length > 1;
        } catch (e) {
            canGoBack = false;
        }
        var path = window.location.pathname;
        if (!canGoBack && (path === '/' || path === '/index.php')) {
            back.hidden = true;
            return;
        }
        var header = document.querySelector('.site-header');
        if (header) {
            header.insertBefore(back, header.firstChild);
        }
        back.addEventListener('click', function (event) {
            if (canGoBack) {
                event.preventDefault();
                window.history.back();
            }
        });
    })();
</script>

<script>
    /* Закріплений підвал: висоту смуги пишемо в --footer-h (відступ body,
       позиція плаваючих кнопок); кнопка розгортає панель розсилки. */
    (function () {
        var footer = document.getElementById('siteFooter');
        if (!footer) {
            return;
        }
        var toggle = document.getElementById('siteFooterToggle');
        function sync() {
            document.documentElement.style.setProperty('--footer-h', footer.offsetHeight + 'px');
        }
        if (toggle) {
            toggle.addEventListener('click', function () {
                var open = footer.classList.toggle('is-expanded');
                toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
                sync();
            });
        }
        sync();
        window.addEventListener('load', sync);
        window.addEventListener('resize', sync);
        if (window.ResizeObserver) {
            new ResizeObserver(sync).observe(footer);
        }
    })();

    /* Екранна клавіатура на сенсорних пристроях: фокус у полі вводу (не в
       самому підвалі) → підвал ховається, щоб не підніматися над клавіатурою. */
    (function () {
        var footer = document.getElementById('siteFooter');
        if (!footer || !window.matchMedia || !window.matchMedia('(pointer: coarse)').matches) {
            return;
        }
        var TYPING = 'input:not([type=checkbox]):not([type=radio]):not([type=button]):not([type=submit]):not([type=reset]):not([type=file]):not([type=range]):not([type=color]),textarea,select,[contenteditable="true"]';
        function typing(el) {
            return el && el.matches && el.matches(TYPING) && !footer.contains(el);
        }
        document.addEventListener('focusin', function (e) {
            if (typing(e.target)) {
                footer.classList.add('is-kb-hidden');
            }
        });
        document.addEventListener('focusout', function () {
            window.setTimeout(function () {
                if (!typing(document.activeElement)) {
                    footer.classList.remove('is-kb-hidden');
                }
            }, 50);
        });
    })();

    /* Висота закріпленої шапки → --header-h (top для закріплених стрілок «назад»). */
    (function () {
        var header = document.querySelector('.site-header');
        if (!header) {
            return;
        }
        function sync() {
            document.documentElement.style.setProperty('--header-h', header.offsetHeight + 'px');
        }
        sync();
        window.addEventListener('load', sync);
        window.addEventListener('resize', sync);
        if (window.ResizeObserver) {
            new ResizeObserver(sync).observe(header);
        }
    })();
</script>

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

<?php /* ===== Форма підписки на розсилку: розмітка вище, у цьому ж файлі ===== */ ?>
<script>
    window.NEWSLETTER_I18N = {
        success: <?= json_encode(t('newsletter_success'), JSON_UNESCAPED_UNICODE) ?>,
        already: <?= json_encode(t('newsletter_already'), JSON_UNESCAPED_UNICODE) ?>,
        invalid: <?= json_encode(t('newsletter_error_invalid'), JSON_UNESCAPED_UNICODE) ?>,
        error: <?= json_encode(t('newsletter_error_generic'), JSON_UNESCAPED_UNICODE) ?>
    };
</script>
<script src="/assets/js/newsletter-form.js" defer></script>

<script>
    if ('serviceWorker' in navigator) {
        window.addEventListener('load', function () {
            navigator.serviceWorker.register('/sw.js').catch(function () {});
        });
    }
</script>

<script>
    window.PWA_I18N = {
        button: <?= json_encode(t('pwa_app_button'), JSON_UNESCAPED_UNICODE) ?>,
        aria: <?= json_encode(t('pwa_app_aria'), JSON_UNESCAPED_UNICODE) ?>,
        iosHint: <?= json_encode(t('pwa_ios_hint'), JSON_UNESCAPED_UNICODE) ?>,
        iosOk: <?= json_encode(t('pwa_ios_ok'), JSON_UNESCAPED_UNICODE) ?>,
        close: <?= json_encode(t('pwa_close'), JSON_UNESCAPED_UNICODE) ?>
    };
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
