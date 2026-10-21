<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Умови використання (заглушка).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Умови використання</title>
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
            display: flex;
            flex-direction: column;
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

        .page {
            flex: 1;
            width: 100%;
            max-width: 760px;
            margin: 0 auto;
            padding: 48px 24px 64px;
        }

        .stub__title {
            margin: 0 0 12px;
            font-size: clamp(1.8rem, 5vw, 2.6rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .stub__text {
            margin: 0;
            font-size: 1.05rem;
            color: var(--text-muted);
        }

        .legal-heading {
            margin: 32px 0 12px;
            font-size: 1.25rem;
            font-weight: 700;
        }

        .legal-updated {
            margin-top: 32px;
            font-size: 0.85rem;
            color: var(--text-muted);
        }
    </style>
    <link rel="stylesheet" href="/assets/css/site-nav.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <main class="page">
        <h1 class="stub__title">Умови використання</h1>
        <p class="stub__text">Документ буде додано найближчим часом</p>

        <h2 class="legal-heading">3.1. Marketplace, курси та вакансії</h2>
        <p class="stub__text">Платформа може надавати доступ до додаткових розділів: маркетплейсу готових AI-рішень, курсів від сторонніх авторів/компаній, та розділу вакансій для роботодавців у сфері AI.</p>
        <p class="stub__text">Стосовно Marketplace: продавці готових рішень самостійно відповідають за якість, законність і відповідність заявленому опису своїх товарів/послуг. Платформа може утримувати комісію з транзакцій, розмір якої вказується окремо в момент здійснення покупки.</p>
        <p class="stub__text">Стосовно курсів: автори курсів самостійно відповідають за зміст навчальних матеріалів. Платформа не гарантує певного результату навчання.</p>
        <p class="stub__text">Стосовно вакансій: роботодавці, що розміщують вакансії, самостійно відповідають за правдивість інформації про вакансію та умови працевлаштування. Платформа не є стороною трудових відносин між роботодавцем і кандидатом і не несе відповідальності за умови працевлаштування.</p>

        <?php /* ЧЕРНЕТКА: пункт про донати потребує перевірки юристом перед остаточною публікацією. */ ?>
        <h2 class="legal-heading" id="donations">3.2. Донати</h2>
        <p class="stub__text">Підтримати проєкт можна добровільним внеском (донатом) за реквізитами, наведеними на сторінці <a href="donate.php">«Підтримати проєкт»</a>. Донат є добровільною безоплатною підтримкою проєкту, не є оплатою товарів чи послуг і не надає донору додаткових прав чи переваг на платформі.</p>
        <p class="stub__text">Повернення донатів не передбачено.</p>
        <p class="stub__text">Платформа не приймає й не обробляє платежі: переказ здійснюється безпосередньо через банк чи платіжний сервіс донора. Платформа не отримує й не зберігає платіжних даних донорів (номерів карток, рахунків тощо).</p>

        <?php /* ЧЕРНЕТКА: пункт про рекламодавців потребує перевірки юристом перед запуском реклами. */ ?>
        <?php // Текст — у системі перекладу (app/translations.php + ui_translations EN), а не в шаблоні. ?>
        <h2 class="legal-heading" id="advertising"><?= htmlspecialchars(t('legal_terms_ads_title'), ENT_QUOTES) ?></h2>
        <p class="stub__text"><?= htmlspecialchars(t('legal_terms_ads_format'), ENT_QUOTES) ?></p>
        <p class="stub__text"><?= sprintf(htmlspecialchars(t('legal_terms_ads_rules'), ENT_QUOTES), '<a href="promo-rules.php">' . htmlspecialchars(t('legal_ads_rules_link'), ENT_QUOTES) . '</a>') ?></p>

        <?php /* ЧЕРНЕТКА: пункт про цифрові матеріали потребує перевірки юристом (відповідальність платформи за контент
                 користувачів, процедура видалення в юрисдикції сайту й користувачів). */ ?>
        <h2 class="legal-heading" id="assets">3.4. Цифрові матеріали (зображення, ілюстрації, персонажі) — ЧЕРНЕТКА</h2>
        <p class="stub__text">Публікувати можна лише власні роботи або роботи, на які автор має права. Заборонено публікувати чужих персонажів і бренди (фан-арт чужих франшиз, логотипи, відомих персонажів) без письмового дозволу правовласника, зображення реальних людей без їхньої згоди й будь-які зображення неповнолітніх у небезпечному чи інтимному контексті.</p>
        <p class="stub__text">Автор зазначає походження роботи (створено вручну, за участі AI або повністю AI) і не може видавати AI-згенероване за ручну роботу. Правовий захист суто AI-згенерованих зображень у багатьох країнах обмежений або відсутній.</p>
        <p class="stub__text">Публікуючи матеріал, автор надає платформі невиключне безоплатне право зберігати файл і показувати його превʼю на сайті на строк публікації. Користувачі отримують права на матеріал лише за ліцензією, обраною автором і показаною біля превʼю; платформа не є стороною ліцензійних угод і угод між автором і користувачем.</p>
        <p class="stub__text">Автор відповідає за порушення прав третіх осіб. Платформа може видаляти чи приховувати матеріали, обмежувати публікацію й блокувати акаунти за порушення. Скарги на порушення авторських прав і зустрічні заяви розглядаються за <a href="copyright-policy.php">Політикою авторських прав</a>; повторні порушення ведуть до призупинення публікації.</p>
        <p class="stub__text">Платформа застосовує технічні заходи (приватне сховище оригіналів, превʼю з водяним знаком, журнал завантажень), але повністю унеможливити копіювання того, що показується на екрані, неможливо — гарантій захисту від копіювання немає.</p>

        <p class="stub__text legal-updated">Останнє оновлення: 11 жовтня 2026 р.; пункт 3.4 (чернетка) — 22 жовтня 2026 р.</p>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
