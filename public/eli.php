<?php

declare(strict_types=1);

/**
 * AI LAB HUB — чат з AI-асистенткою Елею (Елеонора).
 *
 * Макет чат-інтерфейсу. JS-симуляція сценарію з відео Елі
 * (привітання -> друкування -> відповідь). Без реальної AI-логіки.
 *
 * Однаковий сценарій для всіх розмірів екрана: одне велике відео Елі
 * (#eliStage) — спершу привітання (грає раз, застигає на кадрі, видиме
 * разом із текстом привітання й полем вводу), потім «друкує» (грає раз
 * при кожному повідомленні користувача і зникає ПОВНІСТЮ, щойно
 * зʼявляється текстова відповідь). Текстові відповіді та картки
 * продуктів — без відео/аватарок поруч. Десктоп: відео — великий блок
 * у колонці чату (не на весь екран); мобільний (< 768px): майже на
 * весь екран.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Еля, AI-асистентка</title>
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
           екран). Мобільний (< 768px): майже на весь екран — див.
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
           Велике відео Елі майже на весь екран; текст і картки — у чаті під
           ним; поле вводу — знизу. Поки грає «друкує» — видно лише відео. */
        @media (max-width: 768px) {
            body {
                display: flex;
                flex-direction: column;
                min-height: 100dvh;
            }

            .site-header {
                flex: 0 0 auto;
            }

            .page {
                flex: 1 1 auto;
                min-height: 0;
                max-width: none;
                padding: 0;
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }

            .chat-head {
                display: none;
            }

            .chat {
                flex: 1 1 auto;
                min-height: 0;
                overflow-y: auto;
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

            /* Велике відео Елі: займає більшість висоти екрана. */
            .eli-stage {
                height: auto;
                flex: 1 1 auto;
                min-height: 0;
                margin-bottom: 0;
                border: none;
                border-radius: 0;
            }

            /* Поки видно велике відео — чат стискається до смужки під ним
               (там лишається текст привітання). */
            .eli-stage:not([hidden]) ~ .chat {
                flex: 0 0 auto;
                max-height: 30vh;
            }

            /* Поки грає відео «друкує» — на екрані лишається тільки відео. */
            .page.is-typing .chat,
            .page.is-typing .composer {
                display: none;
            }

            /* На мобільному Еля — це повноекранний чат-режим; підвал ховаємо. */
            .site-footer {
                display: none;
            }
        }
    </style>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB">
        </a>
        <nav class="site-nav" id="siteNav">
            <a class="site-nav__link" href="index.php">Головна</a>
            <?php if (auth_check()): ?>
            <a class="site-nav__link" href="account.php">Кабінет</a>
            <?php else: ?>
            <a class="site-nav__link" href="login.php">Увійти</a>
            <?php endif; ?>
        </nav>
        <a class="site-nav__link site-nav__link--cta site-header__cta" href="eli.php">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .962 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.962 0z"/><path d="M20 3v4"/><path d="M22 5h-4"/><path d="M4 17v2"/><path d="M6 18H2"/></svg>
            Викликати Асистента
        </a>
        <button class="site-nav__toggle" type="button" aria-label="Меню" aria-expanded="false" aria-controls="siteNav">
            <span></span>
            <span></span>
            <span></span>
        </button>
    </header>

    <div class="page" id="page">
        <div class="chat-head">
            <h1 class="chat-head__title">Еля — ваша AI-асистентка</h1>
            <p class="chat-head__subtitle">Опишіть задачу — Еля підбере найкращий AI-інструмент</p>
        </div>

        <!-- Велике відео Елі (привітання / «друкує»). Один елемент для всіх
             розмірів екрана; показ і зміну ролика керує JS нижче. -->
        <div id="eliStage" class="eli-stage" hidden>
            <video id="eliStageVideo" class="eli-stage__video" muted playsinline
                   aria-label="Відео Елі"></video>
        </div>

        <div class="chat" id="chat">
            <!-- Текст привітання Елі. Показується разом із великим відео
                 привітання (#eliStage) та полем вводу; прибирається повністю
                 при першому повідомленні користувача. -->
            <div class="msg msg--eli" id="greetingMsg">
                <div class="msg__bubble">
                    Доброго дня! Розкажіть, яку задачу потрібно вирішити — і я підберу
                    відповідний AI-інструмент.
                </div>
            </div>
        </div>

        <form class="composer" id="composer" onsubmit="return false;">
            <input id="composerInput" class="composer__input" type="text" autocomplete="off"
                   placeholder="Опишіть свою задачу…" aria-label="Повідомлення">
            <button class="composer__btn" type="submit">Надіслати</button>
        </form>
    </div>

    <script>
    (function () {
        'use strict';

        var chat = document.getElementById('chat');
        var form = document.getElementById('composer');
        var input = document.getElementById('composerInput');
        var page = document.getElementById('page');
        var greetingMsg = document.getElementById('greetingMsg');
        var stage = document.getElementById('eliStage');
        var stageVideo = document.getElementById('eliStageVideo');

        var GREETING_SRC = 'assets/videos/elya-greeting.mp4';
        var TYPING_SRC = 'assets/videos/elya-typing.mp4';

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

        // Міні-картка продукту: лого (ініціали), назва, кнопка "Докладніше".
        function makeRecCard(initials, name, href) {
            var card = document.createElement('div');
            card.className = 'rec-card';

            var logo = document.createElement('div');
            logo.className = 'rec-card__logo';
            logo.textContent = initials;

            var nm = document.createElement('span');
            nm.className = 'rec-card__name';
            nm.textContent = name;

            var btn = document.createElement('a');
            btn.className = 'rec-card__btn';
            btn.href = href;
            btn.textContent = 'Докладніше';

            card.appendChild(logo);
            card.appendChild(nm);
            card.appendChild(btn);
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

        // Тестова багатокрокова відповідь Елі з добіркою продуктів —
        // тільки текст і картки, без відео/аватарки поруч.
        function addEliResponse() {
            var msg = document.createElement('div');
            msg.className = 'msg msg--eli';

            var bubble = document.createElement('div');
            bubble.className = 'msg__bubble';
            bubble.appendChild(document.createTextNode(
                'Для створення рекламного відео з озвученням знадобиться ' +
                'кілька інструментів:'
            ));

            var steps = document.createElement('div');
            steps.className = 'rec-steps';

            steps.appendChild(makeRecStep('Крок 1: Генерація зображення', [
                makeRecCard('PF', 'PixelForge', 'product.php?id=1'),
                makeRecCard('TA', 'TestAI Pro', 'product.php?id=2')
            ]));
            steps.appendChild(makeRecStep('Крок 2: Анімація зображення у відео', [
                makeRecCard('TA', 'TestAI Pro', 'product.php?id=2')
            ]));
            steps.appendChild(makeRecStep('Крок 3: Озвучення', [
                makeRecCard('VC', 'VoiceCast', 'product.php?id=3')
            ]));

            bubble.appendChild(steps);
            msg.appendChild(bubble);
            chat.appendChild(msg);
            scrollIntoView(msg);
        }

        // Старт: велике відео-привітання грає раз і застигає на кадрі;
        // текст привітання й поле вводу лишаються видимими.
        playStage(GREETING_SRC, { freeze: true });

        // Кожне повідомлення користувача: велике відео «друкує» з початку,
        // грає раз, зникає повністю — і одразу зʼявляється відповідь.
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            var text = input.value.trim();
            if (text === '') {
                return;
            }

            removeGreeting();
            addUserMessage(text);
            input.value = '';

            playStage(TYPING_SRC, {
                typing: true,
                freeze: false,
                onEnd: addEliResponse
            });
        });
    })();
    </script>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
