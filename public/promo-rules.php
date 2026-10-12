<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Правила розміщення реклами» (UA/EN).
 *
 * Текст редагує адмін (кабінет → «Реклама: адмін» → «Налаштування», поля
 * rules_text_uk / rules_text_en в ad_settings). Поки поле порожнє, показується
 * вбудована ЧЕРНЕТКА нижче — її має перевірити юрист перед запуском реклами.
 * Додатково виводиться перелік заборонених категорій з налаштувань.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/promo.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$lang = current_lang() === 'en' ? 'en' : 'uk';
$custom = trim(promo_setting($pdo, 'rules_text_' . $lang, '')) ?: trim(promo_setting($pdo, 'rules_text_uk', ''));
$prohibited = trim(promo_setting($pdo, 'prohibited_categories_text_' . $lang, '')) ?: trim(promo_setting($pdo, 'prohibited_categories_text_uk', ''));

// Вбудована чернетка (без цін, строків і реквізитів — це вирішує адміністрація).
$draft = [
    'uk' => [
        'title' => 'Правила розміщення реклами',
        'draft_note' => 'Чернетка правил. Остаточна редакція — після юридичної перевірки.',
        'prohibited_extra' => 'Додатково заборонено',
        'sensitive_title' => 'Чутливі теми',
        'sensitive' => [
            'Реклама не показується на сторінках і біля матеріалів на чутливі теми (наприклад, ментальне здоров’я, харчова поведінка, теми, пов’язані з дітьми).',
            'Реклама окремих категорій не показується біля певних тем: наприклад, реклама їжі й харчування — на сторінках про здоров’я. Ставки, азартні ігри й контент для дорослих не приймаються.',
            'AI LAB HUB залишає за собою право виключати будь-які сторінки чи розділи сайту з показу реклами без попередження; це не є підставою для претензій щодо обсягу показів.',
        ],
        'sections' => [
            ['1. Загальні положення', [
                'Реклама на AI LAB HUB розміщується через кабінет рекламодавця. Кожне рекламне оголошення позначається написом «Реклама».',
                'Реклама показується за мовою сайту, типом пристрою й тематикою сторінки, на якій її показано. Персональні дані відвідувачів для таргетингу не використовуються.',
                'Реклама не показується у відповідях асистентки Елі й не впливає на її добірки інструментів.',
            ]],
            ['2. Заборонений контент', [
                'Незаконні товари, послуги чи діяльність.',
                'Шахрайство, оманливі твердження, обіцянки гарантованого результату чи прибутку.',
                'Шкідливе програмне забезпечення, фішинг, сторінки, що вводять в оману щодо свого власника.',
                'Контент для дорослих, насильство, мова ворожнечі й дискримінація.',
                'Порушення авторських прав і прав на товарні знаки.',
                'Азартні ігри (за замовчуванням заборонені).',
                'Медичні та фінансові твердження без належного підтвердження.',
            ]],
            ['3. Модерація', [
                'Кожен креатив перевіряється модератором до початку показу. Строк модерації не гарантується; поточний статус кампанії видно в кабінеті.',
                'Після будь-якого редагування кампанія знову проходить модерацію.',
                'AI LAB HUB має право відхилити рекламу або зупинити вже схвалену рекламу (зокрема після скарг відвідувачів), повідомивши причину в кабінеті рекламодавця.',
            ]],
            ['4. Оплата й баланс', [
                'Реклама оплачується з балансу рекламодавця, який поповнюється заздалегідь. Кошти зараховуються на баланс після підтвердження платежу.',
                'Списання відбувається за фактичні покази (CPM) або кліки (CPC) за ціною, зафіксованою в момент надсилання кампанії на модерацію.',
                'Кошти, не витрачені кампанією (після зупинки, завершення чи відхилення), лишаються на балансі рекламодавця й можуть бути використані для інших кампаній. Питання повернення коштів з балансу вирішуються за зверненням до адміністрації.',
                'Покази й кліки ботів і повторні кліки протягом короткого часу не оплачуються.',
            ]],
            ['5. Відсутність гарантій', [
                'Прогнози в кабінеті орієнтовні. AI LAB HUB не гарантує конкретної кількості показів, кліків, продажів чи іншого результату реклами.',
            ]],
            ['6. Відповідальність рекламодавця', [
                'Рекламодавець відповідає за зміст реклами, сторінку, на яку веде посилання, і дотримання законодавства та цих правил.',
            ]],
            ['7. Зміни правил', [
                'Правила можуть змінюватися. Актуальна редакція завжди доступна на цій сторінці.',
            ]],
        ],
    ],
    'en' => [
        'title' => 'Advertising rules',
        'draft_note' => 'Draft rules. The final version will be published after legal review.',
        'prohibited_extra' => 'Also prohibited',
        'sensitive_title' => 'Sensitive topics',
        'sensitive' => [
            'Ads are not shown on pages or next to content about sensitive topics (for example, mental health, eating behaviour, topics related to children).',
            'Ads of some categories are not shown next to certain topics: for example, food and nutrition ads are not shown on health pages. Betting, gambling and adult content are not accepted.',
            'AI LAB HUB reserves the right to exclude any pages or sections of the site from showing ads without notice; this is not grounds for claims about delivery volume.',
        ],
        'sections' => [
            ['1. General', [
                'Ads on AI LAB HUB are placed through the advertiser account. Every ad is labelled “Sponsored”.',
                'Ads are shown by site language, device type and the topic of the page where they appear. Visitors’ personal data is not used for targeting.',
                'Ads are never shown inside the answers of the assistant Eli and do not affect her tool recommendations.',
            ]],
            ['2. Prohibited content', [
                'Illegal goods, services or activities.',
                'Fraud, misleading claims, promises of guaranteed results or profit.',
                'Malware, phishing, pages that misrepresent their owner.',
                'Adult content, violence, hate speech and discrimination.',
                'Copyright and trademark infringement.',
                'Gambling (prohibited by default).',
                'Unsubstantiated medical or financial claims.',
            ]],
            ['3. Moderation', [
                'Every creative is reviewed by a moderator before it is shown. Review time is not guaranteed; the current status is shown in the advertiser account.',
                'Any edit sends the campaign to review again.',
                'AI LAB HUB may reject an ad or stop an approved ad (including after visitor reports), stating the reason in the advertiser account.',
            ]],
            ['4. Payment and balance', [
                'Ads are paid from the advertiser’s prepaid balance. Funds are credited after the payment is confirmed.',
                'Charges are for actual impressions (CPM) or clicks (CPC) at the price fixed when the campaign was submitted for review.',
                'Funds not spent by a campaign (after it is stopped, ended or rejected) stay on the advertiser’s balance and can be used for other campaigns. Refunds from the balance are handled on request to the administration.',
                'Bot traffic and repeated clicks within a short time are not charged.',
            ]],
            ['5. No guarantees', [
                'Forecasts in the account are approximate. AI LAB HUB does not guarantee any number of impressions, clicks, sales or other results.',
            ]],
            ['6. Advertiser responsibility', [
                'The advertiser is responsible for the ad content, the landing page and compliance with the law and these rules.',
            ]],
            ['7. Changes', [
                'These rules may change. The current version is always available on this page.',
            ]],
        ],
    ],
][$lang];

$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
?>
<!DOCTYPE html>
<html lang="<?= $e($lang) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= $e($draft['title']) ?> — AI LAB HUB</title>
    <style>
        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }

        :root {
            --bg-start: #00032c;
            --bg-end: #2116ad;
            --text-muted: rgba(255, 255, 255, 0.78);
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
            padding: 32px 16px 120px;
            overflow-wrap: anywhere;
        }

        .page a {
            color: #bcd0ff;
        }

        .page a:hover {
            color: #ffffff;
        }

        .stub__title {
            margin: 0 0 16px;
            font-size: clamp(1.7rem, 5vw, 2.4rem);
            font-weight: 800;
        }

        .legal-heading {
            margin: 28px 0 10px;
            font-size: 1.2rem;
        }

        .legal-list {
            margin: 0;
            padding-left: 22px;
            color: var(--text-muted);
        }

        .legal-list li {
            margin: 0 0 8px;
        }

        .legal-text {
            color: var(--text-muted);
            white-space: pre-line;
        }

        .legal-draft {
            margin-top: 28px;
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
        <h1 class="stub__title"><?= $e($draft['title']) ?></h1>

        <?php if ($custom !== ''): ?>
        <div class="legal-text"><?= $e($custom) ?></div>
        <?php else: ?>
            <?php foreach ($draft['sections'] as [$heading, $items]): ?>
            <h2 class="legal-heading"><?= $e($heading) ?></h2>
            <ul class="legal-list">
                <?php foreach ($items as $item): ?>
                <li><?= $e($item) ?></li>
                <?php endforeach; ?>
            </ul>
            <?php endforeach; ?>
        <?php endif; ?>

        <h2 class="legal-heading"><?= $e($draft['sensitive_title']) ?></h2>
        <ul class="legal-list">
            <?php foreach ($draft['sensitive'] as $item): ?>
            <li><?= $e($item) ?></li>
            <?php endforeach; ?>
        </ul>

        <?php if ($prohibited !== ''): ?>
        <h2 class="legal-heading"><?= $e($draft['prohibited_extra']) ?></h2>
        <div class="legal-text"><?= $e($prohibited) ?></div>
        <?php endif; ?>

        <?php if ($custom === ''): ?>
        <p class="legal-draft"><?= $e($draft['draft_note']) ?></p>
        <?php endif; ?>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
