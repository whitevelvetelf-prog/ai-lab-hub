<?php

declare(strict_types=1);

/**
 * AI LAB HUB — чат з AI-асистенткою Елею (Елеонора).
 *
 * Макет чат-інтерфейсу. JS-симуляція сценарію з відео Елі
 * (привітання -> друкування -> відповідь). Без реальної AI-логіки.
 */

require_once __DIR__ . '/../app/auth.php';

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

        /* Контейнер аватарки: фіксований розмір ~140x140.
           Місце лишається навіть коли відео прибрано з DOM. */
        .msg__avatar {
            width: 140px;
            height: 140px;
            flex-shrink: 0;
        }

        /* Відео Елі: персонаж влазить повністю, без обрізки голови. */
        .msg__video {
            width: 100%;
            height: 100%;
            object-fit: contain;
            display: block;
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

            .msg__avatar {
                width: 120px;
                height: 120px;
            }

            .composer__btn {
                padding: 14px 18px;
            }
        }
    </style>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB">
        </a>
        <nav class="site-nav">
            <a class="site-nav__link" href="index.php">Головна</a>
            <?php if (auth_check()): ?>
            <a class="site-nav__link" href="account.php">Кабінет</a>
            <?php else: ?>
            <a class="site-nav__link" href="login.php">Увійти</a>
            <?php endif; ?>
            <a class="site-nav__link site-nav__link--cta" href="eli.php">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .962 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.962 0z"/><path d="M20 3v4"/><path d="M22 5h-4"/><path d="M4 17v2"/><path d="M6 18H2"/></svg>
                Викликати Асистента
            </a>
        </nav>
    </header>

    <div class="page">
        <div class="chat-head">
            <h1 class="chat-head__title">Еля — ваша AI-асистентка</h1>
            <p class="chat-head__subtitle">Опишіть задачу — Еля підбере найкращий AI-інструмент</p>
        </div>

        <div class="chat" id="chat">
            <!-- Привітання Елі: відео програється один раз і застигає на
                 останньому кадрі. Зникає лише коли користувач надсилає
                 перше повідомлення (див. обробник submit). -->
            <div class="msg msg--eli">
                <div class="msg__avatar">
                    <video id="greetingVideo" class="msg__video"
                           src="assets/videos/elya-greeting.mp4"
                           autoplay muted playsinline
                           aria-label="Еля вітається"></video>
                </div>
                <div class="msg__bubble">
                    Доброго дня! Розкажіть, яку задачу потрібно вирішити — і я підберу
                    відповідний AI-інструмент.
                </div>
            </div>
        </div>

        <form class="composer" id="composer" onsubmit="return false;">
            <input id="composerInput" class="composer__input" type="text"
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
        var greetingVideo = document.getElementById('greetingVideo');

        function safePlay(video) {
            var p = video.play();
            if (p && typeof p.catch === 'function') {
                p.catch(function () {});
            }
        }

        function scrollIntoView(el) {
            if (typeof el.scrollIntoView === 'function') {
                el.scrollIntoView({ behavior: 'smooth', block: 'end' });
            }
        }

        // Крок 2: привітальне відео — один прогін без loop, застигає на
        // останньому кадрі. З DOM НЕ прибираємо — це робить обробник submit
        // при першому надісланому повідомленні.
        if (greetingVideo) {
            greetingVideo.addEventListener('ended', function () {
                greetingVideo.pause();
            });
            safePlay(greetingVideo);
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

        // Крок 3: нове повідомлення Елі з відео "друкує".
        function addEliTypingMessage() {
            var msg = document.createElement('div');
            msg.className = 'msg msg--eli';

            var avatar = document.createElement('div');
            avatar.className = 'msg__avatar';

            var video = document.createElement('video');
            video.className = 'msg__video';
            video.src = 'assets/videos/elya-typing.mp4';
            video.muted = true;
            video.setAttribute('playsinline', '');
            video.setAttribute('aria-label', 'Еля друкує');

            avatar.appendChild(video);
            msg.appendChild(avatar);
            chat.appendChild(msg);
            scrollIntoView(msg);

            video.addEventListener('ended', function () {
                // Застигнути на останньому кадрі (відео не приховуємо).
                video.pause();
                addEliResponse(msg);
            });

            video.addEventListener('loadedmetadata', function () {
                try { video.currentTime = 0; } catch (e) {}
            });

            safePlay(video);
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

        // Тестова багатокрокова відповідь Елі з добіркою продуктів.
        function addEliResponse(msg) {
            if (msg.querySelector('.msg__bubble')) {
                return;
            }

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
            scrollIntoView(msg);
        }

        // Кроки 3–4: кожне повідомлення користувача запускає новий цикл.
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            var text = input.value.trim();
            if (text === '') {
                return;
            }
            // Привітальне відео/картинка зникає саме тут — при першому
            // надісланому повідомленні, а не одразу після завершення відео.
            if (greetingVideo) {
                greetingVideo.remove();
                greetingVideo = null;
            }
            addUserMessage(text);
            input.value = '';
            addEliTypingMessage();
        });
    })();
    </script>
</body>
</html>
