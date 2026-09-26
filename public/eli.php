<?php

declare(strict_types=1);

/**
 * AI LAB HUB — чат з AI-асистенткою Елею (Елеонора).
 *
 * Чат-інтерфейс + відео-сценарій Елі (привітання -> друкування ->
 * відповідь). Повідомлення користувача йде на public/api-eli-chat.php,
 * який викликає Claude API і повертає текст відповіді та підібрані
 * продукти каталогу; фронтенд малює їх картками (за кроками, якщо їх кілька).
 *
 * Однаковий сценарій для всіх розмірів екрана: одне велике відео Елі
 * (#eliStage) — спершу привітання (грає раз, застигає на кадрі, видиме
 * разом із текстом привітання й полем вводу), потім «друкує» (грає раз
 * при кожному повідомленні користувача і зникає ПОВНІСТЮ, щойно
 * зʼявляється текстова відповідь). Текстові відповіді та картки
 * продуктів — без відео/аватарок поруч. Десктоп: відео — великий блок
 * у колонці чату (не на весь екран); мобільний (< 768px): компактний
 * банер над діалогом, прокручується лише чат.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars(current_lang(), ENT_QUOTES) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= htmlspecialchars(t('title_eli'), ENT_QUOTES) ?></title>
    <style>
        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }

        :root {
            --bg-start: #00032c;
            --bg-end: #2116ad;
            --card-bg: rgba(255, 255, 255, 0.05);
            --card-border: rgba(255, 255, 255, 0.14);
            --text-muted: rgba(255, 255, 255, 0.75);
            --accent: #5b8cff;
        }

        html,
        body {
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #ffffff;
            background: linear-gradient(160deg, var(--bg-start) 0%, var(--bg-end) 100%);
            background-attachment: fixed;
            line-height: 1.6;
        }

        .site-header {
            display: flex;
            align-items: center;
            padding: 20px 32px;
        }

        .site-header__brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: #ffffff;
        }

        .site-header__logo {
            height: 42px;
            width: auto;
            display: block;
            border-radius: 10px;
        }

        .site-nav {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .site-nav__link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 9px 16px;
            border-radius: 999px;
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            color: var(--text-muted);
            transition: color 0.15s ease, background 0.15s ease;
        }

        .site-nav__link:hover {
            color: #ffffff;
            background: rgba(255, 255, 255, 0.08);
        }

        /* Заклик до дії — виділений пункт меню «Викликати Асистента» */
        .site-nav__link--cta {
            color: #00032c;
            background: linear-gradient(135deg, #5b8cff, #a5c0ff);
            box-shadow: 0 6px 18px rgba(91, 140, 255, 0.4);
        }

        .site-nav__link--cta:hover {
            color: #00032c;
            background: linear-gradient(135deg, #6f9bff, #b8ceff);
        }

        .site-nav__link--cta svg {
            width: 16px;
            height: 16px;
        }

        .page {
            max-width: 760px;
            margin: 0 auto;
            padding: 24px 24px 40px;
        }

        /* Заголовок */
        .chat-head {
            margin-bottom: 28px;
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
        }

        .chat-head__title {
            margin: 0 0 6px;
            font-size: clamp(1.6rem, 4.5vw, 2.2rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .chat-head__subtitle {
            margin: 0;
            font-size: 1rem;
            color: var(--text-muted);
        }

        .chat-head__reset {
            flex-shrink: 0;
            padding: 9px 16px;
            border-radius: 999px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background: transparent;
            color: #ffffff;
            font-size: 0.85rem;
            font-weight: 600;
            font-family: inherit;
            cursor: pointer;
            transition: background 0.15s ease, border-color 0.15s ease;
        }

        .chat-head__reset:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.5);
        }

        /* Область чату */
        .chat {
            display: flex;
            flex-direction: column;
            gap: 20px;
            padding: 24px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .msg {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            max-width: 86%;
        }

        .msg--eli {
            align-self: flex-start;
        }

        .msg--user {
            align-self: flex-end;
            flex-direction: row-reverse;
        }

        .msg__bubble {
            padding: 14px 18px;
            border-radius: 16px;
            font-size: 0.98rem;
        }

        .msg--eli .msg__bubble {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid var(--card-border);
            border-bottom-left-radius: 4px;
        }

        .msg--user .msg__bubble {
            background: var(--accent);
            color: #ffffff;
            border-bottom-right-radius: 4px;
        }

        /* Міні-картка продукту в повідомленні */
        .rec-card {
            margin-top: 14px;
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--card-border);
            border-radius: 12px;
        }

        .rec-card__logo {
            width: 42px;
            height: 42px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.95rem;
            font-weight: 800;
            letter-spacing: 0.02em;
            background: linear-gradient(135deg, #2116ad, #5b8cff);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            flex-shrink: 0;
            overflow: hidden;
        }

        /* Коли в лого справжнє зображення продукту — світла підкладка
           замість градієнта, щоб темні логотипи читалися. */
        .rec-card__logo--img {
            background: rgba(255, 255, 255, 0.92);
        }

        .rec-card__logo-img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            display: block;
        }

        .rec-card__name {
            flex: 1;
            font-size: 1rem;
            font-weight: 700;
        }

        .rec-card__btn {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 999px;
            font-size: 0.85rem;
            font-weight: 600;
            text-decoration: none;
            color: #00032c;
            background: #ffffff;
            white-space: nowrap;
            transition: background 0.15s ease;
        }

        .rec-card__btn:hover {
            background: rgba(255, 255, 255, 0.88);
        }

        /* Багатокрокова відповідь: підзаголовок кроку + рядок міні-карток */
        .rec-steps {
            margin-top: 14px;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .rec-step__title {
            margin-bottom: 8px;
            font-size: 0.82rem;
            font-weight: 700;
            letter-spacing: 0.04em;
            text-transform: uppercase;
            color: var(--text-muted);
        }

        .rec-step__cards {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        /* Картка всередині кроку: компактна, кілька можуть іти в ряд */
        .rec-step__cards .rec-card {
            margin-top: 0;
            flex: 1 1 200px;
            min-width: 0;
        }

        /* Індикатор очікування відповіді Елі («обмірковує…» + анімовані крапки) */
        .eli-thinking {
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .eli-thinking__dots {
            display: inline-flex;
            gap: 4px;
        }

        .eli-thinking__dots span {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: currentColor;
            opacity: 0.3;
            animation: eli-thinking-bounce 1.2s infinite ease-in-out;
        }

        .eli-thinking__dots span:nth-child(2) {
            animation-delay: 0.2s;
        }

        .eli-thinking__dots span:nth-child(3) {
            animation-delay: 0.4s;
        }

        @keyframes eli-thinking-bounce {

            0%,
            80%,
            100% {
                opacity: 0.3;
                transform: translateY(0);
            }

            40% {
                opacity: 1;
                transform: translateY(-3px);
            }
        }

        /* Поле вводу */
        .composer {
            margin-top: 20px;
            display: flex;
            gap: 12px;
        }

        .composer__input {
            flex: 1;
            padding: 14px 18px;
            border-radius: 999px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.08);
            color: #ffffff;
            font-size: 1rem;
            font-family: inherit;
        }

        .composer__input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .composer__input:focus {
            outline: none;
            border-color: var(--accent);
            background: rgba(255, 255, 255, 0.12);
        }

        .composer__btn {
            padding: 14px 26px;
            border-radius: 999px;
            border: none;
            background: #ffffff;
            color: #00032c;
            font-size: 1rem;
            font-weight: 600;
            font-family: inherit;
            cursor: pointer;
            transition: background 0.15s ease;
        }

        .composer__btn:hover {
            background: rgba(255, 255, 255, 0.88);
        }

        /* Велике відео Елі (привітання / «друкує») — один блок для всіх
           екранів. Десктоп: великий блок у колонці чату (не на весь
           екран). Мобільний (< 768px): компактний банер над діалогом — див.
           медіа-запит нижче. Видимістю та зміною ролика керує JS. */
        .eli-stage {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            height: 360px;
            margin-bottom: 24px;
            background: var(--bg-start);
            border: 1px solid var(--card-border);
            border-radius: 20px;
            overflow: hidden;
        }

        .eli-stage[hidden] {
            display: none;
        }

        .eli-stage__video {
            width: 100%;
            height: 100%;
            object-fit: contain;
            display: block;
        }

        @media (max-width: 600px) {
            .site-header {
                justify-content: center;
                padding: 16px;
                flex-wrap: wrap;
                gap: 12px;
            }

            .msg {
                max-width: 94%;
            }

            .composer__btn {
                padding: 14px 18px;
            }
        }

        /* --- Мобільний режим Елі (< 768px) --------------------------------
           Екран-застосунок рівно на висоту вікна: шапка → компактний банер
           із відео Елі → чат (єдине, що прокручується) → поле вводу знизу.
           body має фіксовану висоту (а не min-height) і overflow: hidden —
           інакше з ростом діалогу прокручується вся сторінка, і банер
           «їде» під напівпрозору закріплену шапку. */
        @media (max-width: 768px) {
            body {
                display: flex;
                flex-direction: column;
                height: 100vh;
                height: 100dvh;
                overflow: hidden;
            }

            .site-header {
                flex: 0 0 auto;
            }

            /* margin: 0 (а не базове 0 auto): у колонковому flex-body
               auto-поля вимикають розтягування, і .page брала ширину
               вмісту (поле вводу + кнопка ≈ 369px) → горизонтальний скрол
               на 320px. */
            .page {
                flex: 1 1 auto;
                min-height: 0;
                max-width: none;
                width: 100%;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }

            .chat-head {
                display: none;
            }

            /* Чат — за висотою вмісту (flex: 0 1 auto, а не 1 1 auto): поле
               вводу стоїть одразу під останнім повідомленням, без порожнього
               простору між привітанням і полем. Коли розмова довша за екран,
               чат стискається (min-height: 0) і прокручується сам.
               overflow-x: hidden — довгі назви/посилання в картках не дають
               горизонтального скролу. */
            .chat {
                flex: 0 1 auto;
                min-height: 0;
                overflow-y: auto;
                overflow-x: hidden;
                padding: 14px 16px;
                background: transparent;
                border: none;
                border-radius: 0;
                box-shadow: none;
            }

            .composer {
                flex: 0 0 auto;
                margin-top: 0;
                padding: 12px 16px;
                gap: 8px;
                background: var(--bg-end);
                border-top: 1px solid var(--card-border);
            }

            /* Поле вводу стискається, кнопка «Надіслати» — ні: обидва завжди
               в межах ширини екрана (без min-width: 0 input має власну
               мінімальну ширину й виштовхує кнопку за край на ~320px). */
            .composer__input {
                min-width: 0;
            }

            .composer__btn {
                flex-shrink: 0;
            }

            .msg__bubble {
                min-width: 0;
                overflow-wrap: anywhere;
            }

            /* Відео Елі — компактний банер над діалогом (не на весь екран):
               фіксована висота, у потоці над чатом, не прокручується разом
               із повідомленнями. position/z-index: 0 — нижче закріпленої
               шапки (z-index 100), тож банер ніколи не перекриває її. */
            .eli-stage {
                position: relative;
                z-index: 0;
                flex: 0 0 auto;
                height: 120px;
                width: auto;
                margin: 12px 16px 0;
                border-radius: 16px;
            }

            /* Ролик вертикальний (1088×1904), банер — горизонтальний: cover
               заповнює всю ширину картки без порожніх полів по боках. Банер
               навмисно низький (120px), щоб шапка, банер, привітання й поле
               вводу вміщалися в ~620–700px видимої висоти iPhone без скролу;
               object-position 44% ставить у кадр обличчя Елі й комір піджака. */
            .eli-stage__video {
                object-fit: cover;
                object-position: center 44%;
            }

            /* На мобільному Еля — це повноекранний чат-режим; підвал ховаємо. */
            .site-footer {
                display: none;
            }

            /* Підвал прихований — відступ під нього (footer.php) не потрібен. */
            body {
                padding-bottom: 0;
            }
        }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <div class="page" id="page">
        <div class="chat-head">
            <div>
                <h1 class="chat-head__title"><?= htmlspecialchars(t('eli_title'), ENT_QUOTES) ?></h1>
                <p class="chat-head__subtitle"><?= htmlspecialchars(t('eli_subtitle'), ENT_QUOTES) ?></p>
            </div>
            <button type="button" id="eliNewChatBtn" class="chat-head__reset"><?= htmlspecialchars(t('eli_new_chat'), ENT_QUOTES) ?></button>
        </div>

        <!-- Велике відео Елі (привітання / «друкує»). Один елемент для всіх
             розмірів екрана; показ і зміну ролика керує JS нижче. -->
        <div id="eliStage" class="eli-stage" hidden>
            <video id="eliStageVideo" class="eli-stage__video" muted playsinline
                   aria-label="<?= htmlspecialchars(t('eli_video_alt'), ENT_QUOTES) ?>"></video>
        </div>

        <div class="chat" id="chat">
            <!-- Текст привітання Елі. Показується разом із великим відео
                 привітання (#eliStage) та полем вводу; прибирається повністю
                 при першому повідомленні користувача. -->
            <div class="msg msg--eli" id="greetingMsg">
                <div class="msg__bubble">
                    <?= htmlspecialchars(t('eli_greeting'), ENT_QUOTES) ?>
                </div>
            </div>
        </div>

        <form class="composer" id="composer" onsubmit="return false;">
            <input id="composerInput" class="composer__input" type="text" autocomplete="off"
                   placeholder="<?= htmlspecialchars(t('eli_input_placeholder'), ENT_QUOTES) ?>" aria-label="<?= htmlspecialchars(t('eli_input_aria'), ENT_QUOTES) ?>">
            <button class="composer__btn" type="submit"><?= htmlspecialchars(t('eli_send'), ENT_QUOTES) ?></button>
        </form>
    </div>

    <script>
    (function () {
        'use strict';

        var I18N = {
            techError: <?= json_encode(t('eli_tech_error'), JSON_UNESCAPED_UNICODE) ?>,
            thinking: <?= json_encode(t('eli_thinking'), JSON_UNESCAPED_UNICODE) ?>,
            details: <?= json_encode(t('btn_details'), JSON_UNESCAPED_UNICODE) ?>,
            stepLabel: <?= json_encode(t('eli_step_label'), JSON_UNESCAPED_UNICODE) ?>,
            recommend: <?= json_encode(t('eli_recommend'), JSON_UNESCAPED_UNICODE) ?>,
            defaultReply: <?= json_encode(t('eli_default_reply'), JSON_UNESCAPED_UNICODE) ?>
        };

        var chat = document.getElementById('chat');
        var form = document.getElementById('composer');
        var input = document.getElementById('composerInput');
        var page = document.getElementById('page');
        var greetingMsg = document.getElementById('greetingMsg');
        var stage = document.getElementById('eliStage');
        var stageVideo = document.getElementById('eliStageVideo');
        var newChatBtn = document.getElementById('eliNewChatBtn');

        var GREETING_SRC = 'assets/videos/elya-greeting.mp4';
        var TYPING_SRC = 'assets/videos/elya-typing.mp4';

        // Стан розмови (текст користувача + повні відповіді Елі з добірками)
        // у sessionStorage — переживає перехід на product.php і повернення
        // назад кнопкою браузера, але зникає із закриттям вкладки.
        var STORAGE_KEY = 'eliChatState';
        var chatState = [];

        function loadState() {
            try {
                var raw = sessionStorage.getItem(STORAGE_KEY);
                if (!raw) {
                    return null;
                }
                var parsed = JSON.parse(raw);
                return Array.isArray(parsed) && parsed.length ? parsed : null;
            } catch (e) {
                return null;
            }
        }

        function saveState() {
            try {
                sessionStorage.setItem(STORAGE_KEY, JSON.stringify(chatState));
            } catch (e) {
                // приватний режим / переповнене сховище — не критично, чат
                // просто не відновиться після повернення на сторінку.
            }
        }

        function clearSavedState() {
            chatState = [];
            try {
                sessionStorage.removeItem(STORAGE_KEY);
            } catch (e) {}
        }

        var stageDetach = null;   // знімає слухачі поточного ролика
        var greetingGone = false;

        function safePlay(video) {
            var p = video.play();
            if (p && typeof p.catch === 'function') {
                p.catch(function () {});
            }
        }

        function scrollIntoView(el) {
            if (el && typeof el.scrollIntoView === 'function') {
                el.scrollIntoView({ behavior: 'smooth', block: 'end' });
            }
        }

        // Повністю прибрати велике відео Елі: зняти слухачі, зупинити,
        // очистити src (щоб не лишалося застиглого кадру), сховати блок.
        function clearStage() {
            if (stageDetach) {
                stageDetach();
                stageDetach = null;
            }
            try { stageVideo.pause(); } catch (e) {}
            stageVideo.removeAttribute('src');
            stageVideo.load();
            stage.hidden = true;
            page.classList.remove('is-typing');
        }

        // Показати велике відео Елі й програти його рівно один раз.
        //   opts.typing — на час відтворення ховати чат і поле вводу
        //                 (мобільний повноекранний режим).
        //   opts.freeze — після 'ended' застигнути на останньому кадрі
        //                 (лишити видимим). Інакше — прибрати блок повністю.
        //   opts.onEnd  — колбек після завершення / помилки.
        function playStage(src, opts) {
            opts = opts || {};
            clearStage();

            if (opts.typing) {
                page.classList.add('is-typing');
            }

            var finished = false;

            function detach() {
                stageVideo.removeEventListener('ended', onEnded);
                stageVideo.removeEventListener('error', onError);
            }
            stageDetach = detach;

            function finish(removeStage) {
                if (finished) {
                    return;
                }
                finished = true;
                detach();
                stageDetach = null;
                if (removeStage) {
                    clearStage();
                } else {
                    try { stageVideo.pause(); } catch (e) {}
                    page.classList.remove('is-typing');
                }
                if (typeof opts.onEnd === 'function') {
                    opts.onEnd();
                }
            }

            function onEnded() {
                finish(!opts.freeze);
            }

            function onError() {
                // Немає ролика (напр. 404) — не блокуємо сценарій,
                // одразу показуємо відповідь.
                finish(true);
            }

            stageVideo.addEventListener('ended', onEnded);
            stageVideo.addEventListener('error', onError);

            stageVideo.src = src;
            stageVideo.muted = true;
            stage.hidden = false;
            try { stageVideo.currentTime = 0; } catch (e) {}
            safePlay(stageVideo);
        }

        // Мобільний (≤768px): відео — постійний банер-заголовок над діалогом,
        // тож він не зникає ні після ролика «друкує», ні при відновленні
        // розмови. На десктопі блок великий (360px) — там, як і раніше,
        // прибирається, щоб не відсувати чат.
        var mobileBanner = window.matchMedia
            ? window.matchMedia('(max-width: 768px)')
            : { matches: false };

        // Нерухомий кадр ролика в банері без відтворення (відновлена
        // розмова на мобільному). #t — щоб браузер відмалював кадр з
        // Елею, а не порожній перший; preload — інакше iOS кадр не вантажить.
        function showStageStill(src) {
            clearStage();
            stageVideo.preload = 'auto';
            stageVideo.muted = true;
            stageVideo.src = src + '#t=0.5';
            stage.hidden = false;
            stageVideo.addEventListener('error', function onStillError() {
                stageVideo.removeEventListener('error', onStillError);
                stage.hidden = true;
            });
        }

        function removeGreeting() {
            if (greetingGone) {
                return;
            }
            greetingGone = true;
            if (greetingMsg && greetingMsg.parentNode) {
                greetingMsg.parentNode.removeChild(greetingMsg);
            }
        }

        function addUserMessage(text) {
            var msg = document.createElement('div');
            msg.className = 'msg msg--user';

            var bubble = document.createElement('div');
            bubble.className = 'msg__bubble';
            bubble.textContent = text;

            msg.appendChild(bubble);
            chat.appendChild(msg);
            scrollIntoView(msg);
        }

        var TECH_ERROR = I18N.techError;

        // Ініціали з назви продукту — запасний варіант, коли немає логотипа.
        function initialsOf(name) {
            var parts = String(name || '').trim().split(/\s+/).slice(0, 2);
            var s = parts.map(function (w) { return w.charAt(0); }).join('');
            return s ? s.toUpperCase() : '•';
        }

        // Міні-картка продукту: логотип із бази (або ініціали), назва,
        // кнопка "Докладніше" на сторінку продукту.
        function makeRecCard(product) {
            var card = document.createElement('div');
            card.className = 'rec-card';

            var logo = document.createElement('div');
            logo.className = 'rec-card__logo';
            if (product.logo_url) {
                var img = document.createElement('img');
                img.className = 'rec-card__logo-img';
                img.src = product.logo_url;
                img.alt = '';
                img.loading = 'lazy';
                img.addEventListener('error', function () {
                    if (img.parentNode === logo) {
                        logo.removeChild(img);
                    }
                    logo.classList.remove('rec-card__logo--img');
                    logo.textContent = initialsOf(product.name);
                });
                logo.classList.add('rec-card__logo--img');
                logo.appendChild(img);
            } else {
                logo.textContent = initialsOf(product.name);
            }

            var nm = document.createElement('span');
            nm.className = 'rec-card__name';
            nm.textContent = product.name;

            var btn = document.createElement('a');
            btn.className = 'rec-card__btn';
            btn.href = product.href || ('product.php?id=' + product.id);
            btn.textContent = I18N.details;

            card.appendChild(logo);
            card.appendChild(nm);
            card.appendChild(btn);

            // Кнопка «зберегти в добірку» (іконка-лапка). Розмітку створює
            // assets/js/saved-products.js; клік обробляється делеговано там само.
            if (product.id && window.savedProductsButton) {
                card.appendChild(window.savedProductsButton(product.id, !!product.saved));
            }
            return card;
        }

        // Крок відповіді: підзаголовок + рядок карток під ним.
        function makeRecStep(title, cards) {
            var step = document.createElement('div');
            step.className = 'rec-step';

            var heading = document.createElement('div');
            heading.className = 'rec-step__title';
            heading.textContent = title;
            step.appendChild(heading);

            var row = document.createElement('div');
            row.className = 'rec-step__cards';
            cards.forEach(function (c) {
                row.appendChild(c);
            });
            step.appendChild(row);
            return step;
        }

        // Тимчасове повідомлення Елі, поки очікуємо відповідь від API
        // (відео «друкує» вже завершилося). Текст + анімовані крапки, щоб
        // було видно, що система працює, а не зависла. Повертає елемент
        // для заміни готовою відповіддю.
        function addEliPlaceholder() {
            var msg = document.createElement('div');
            msg.className = 'msg msg--eli';
            var bubble = document.createElement('div');
            bubble.className = 'msg__bubble';

            var wrap = document.createElement('span');
            wrap.className = 'eli-thinking';

            var text = document.createElement('span');
            text.textContent = I18N.thinking;
            wrap.appendChild(text);

            var dots = document.createElement('span');
            dots.className = 'eli-thinking__dots';
            dots.innerHTML = '<span></span><span></span><span></span>';
            wrap.appendChild(dots);

            bubble.appendChild(wrap);
            msg.appendChild(bubble);
            chat.appendChild(msg);
            scrollIntoView(msg);
            return msg;
        }

        // Відповідь Елі за даними API: текст + (за наявності) кроки з
        // картками реальних продуктів каталогу.
        function renderEliResponse(data) {
            var msg = document.createElement('div');
            msg.className = 'msg msg--eli';

            var bubble = document.createElement('div');
            bubble.className = 'msg__bubble';

            var replyText = (data && data.reply_text) ? String(data.reply_text) : '';
            if (replyText === '') {
                replyText = I18N.defaultReply;
            }
            bubble.appendChild(document.createTextNode(replyText));

            var rawSteps = (data && Array.isArray(data.steps)) ? data.steps : [];
            var products = (data && Array.isArray(data.products)) ? data.products : [];
            var byId = {};
            products.forEach(function (p) { byId[String(p.id)] = p; });

            var steps = rawSteps.filter(function (s) {
                return s && Array.isArray(s.product_ids) && s.product_ids.length;
            });

            if (steps.length) {
                var wrap = document.createElement('div');
                wrap.className = 'rec-steps';
                var multi = steps.length > 1;
                steps.forEach(function (s) {
                    var cards = [];
                    s.product_ids.forEach(function (pid) {
                        var p = byId[String(pid)];
                        if (p) {
                            cards.push(makeRecCard(p));
                        }
                    });
                    if (!cards.length) {
                        return;
                    }
                    var title = s.step_title || (multi ? I18N.stepLabel : I18N.recommend);
                    wrap.appendChild(makeRecStep(title, cards));
                });
                if (wrap.childNodes.length) {
                    bubble.appendChild(wrap);
                }
            }

            msg.appendChild(bubble);
            chat.appendChild(msg);
            scrollIntoView(msg);
        }

        // Відновити всю історію розмови з sessionStorage: кожне повідомлення
        // користувача й кожну повну відповідь Елі (текст + добірки) —
        // без відео привітання, бо це вже не новий діалог.
        function renderHistory(savedState) {
            removeGreeting();
            if (mobileBanner.matches) {
                showStageStill(GREETING_SRC);
            } else {
                clearStage();
            }
            savedState.forEach(function (entry) {
                if (entry.role === 'user') {
                    addUserMessage(entry.text);
                } else if (entry.role === 'assistant') {
                    renderEliResponse(entry.data);
                }
            });
        }

        // Старт: якщо в sessionStorage є збережена розмова (користувач
        // повернувся зі сторінки продукту чи іншої сторінки в межах цієї ж
        // вкладки) — відновлюємо її. Інакше — звичайний початок: велике
        // відео-привітання грає раз і застигає на кадрі.
        var restored = loadState();
        if (restored) {
            chatState = restored;
            // saved-products.js підключений з defer у app/footer.php (нижче
            // за це вбудоване вставлення), тож window.savedProductsButton
            // з'являється лише перед DOMContentLoaded — чекаємо на нього,
            // інакше кнопка «зберегти» на відновлених картках не малюється.
            if (document.readyState === 'loading') {
                document.addEventListener('DOMContentLoaded', function () {
                    renderHistory(chatState);
                });
            } else {
                renderHistory(chatState);
            }
        } else {
            playStage(GREETING_SRC, { freeze: true });
        }

        if (newChatBtn) {
            newChatBtn.addEventListener('click', function () {
                clearSavedState();
                window.location.reload();
            });
        }

        var submitBtn = form.querySelector('.composer__btn');
        var busy = false;

        function setBusy(state) {
            busy = state;
            input.disabled = state;
            if (submitBtn) {
                submitBtn.disabled = state;
            }
        }

        // Одне повідомлення користувача:
        //   1. прибираємо привітання, додаємо репліку користувача;
        //   2. паралельно запускаємо відео «друкує» і запит до API;
        //   3. відповідь показуємо, коли готові ОБИДВА (відео завершилось
        //      і прийшла відповідь). Якщо відео скінчилось раніше —
        //      показуємо тимчасовий плейсхолдер і замінюємо його відповіддю.
        function submitMessage(text) {
            removeGreeting();
            addUserMessage(text);
            chatState.push({ role: 'user', text: text });
            saveState();
            input.value = '';
            setBusy(true);

            var result = null;      // {reply_text, steps, products} — успіх або ввічлива відмова
            var videoDone = false;
            var rendered = false;
            var placeholder = null;

            function tryRender() {
                if (rendered || !videoDone) {
                    return;
                }
                if (result === null) {
                    if (!placeholder) {
                        placeholder = addEliPlaceholder();
                    }
                    return;
                }
                rendered = true;
                if (placeholder && placeholder.parentNode) {
                    placeholder.parentNode.removeChild(placeholder);
                }
                renderEliResponse(result);
                chatState.push({ role: 'assistant', data: result });
                saveState();
                setBusy(false);
            }

            fetch('api-eli-chat.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                    'X-Requested-With': 'fetch'
                },
                body: 'message=' + encodeURIComponent(text)
            })
                .then(function (r) { return r.json(); })
                .then(function (data) {
                    result = (data && typeof data === 'object')
                        ? data
                        : { reply_text: TECH_ERROR, steps: [], products: [] };
                })
                .catch(function () {
                    result = { reply_text: TECH_ERROR, steps: [], products: [] };
                })
                .then(function () { tryRender(); });

            playStage(TYPING_SRC, {
                typing: true,
                freeze: mobileBanner.matches,
                onEnd: function () { videoDone = true; tryRender(); }
            });
        }

        form.addEventListener('submit', function (e) {
            e.preventDefault();
            if (busy) {
                return;
            }
            var text = input.value.trim();
            if (text === '') {
                return;
            }
            submitMessage(text);
        });
    })();
    </script>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
