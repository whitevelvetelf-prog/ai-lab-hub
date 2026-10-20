<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Політика авторських прав» (UA/EN). ЧЕРНЕТКА ДЛЯ ЮРИСТА: потребує перевірки, особливо щодо
 * відповідальності платформи за контент користувачів і процедури видалення в юрисдикції сайту та користувачів.
 * Посилання — у підвалі сайту й на кожній сторінці «Цифрового матеріалу». Строки беруться з налаштувань.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/asset.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$lang = current_lang() === 'en' ? 'en' : 'uk';
$s = ast_settings($pdo);
$contact = 'admin@ailabhub-directory.com';

$doc = [
    'uk' => [
        'title' => 'Політика авторських прав',
        'draft' => 'ЧЕРНЕТКА. Текст потребує перевірки юристом, зокрема щодо відповідальності платформи за контент користувачів і процедури видалення в юрисдикції сайту та користувачів.',
        'sections' => [
            ['1. Загальне', [
                'AI LAB HUB поважає авторські права й очікує того самого від користувачів. Публікувати в маркетплейсі можна лише власні роботи або роботи, на які автор має права.',
                'Заборонено публікувати чужих персонажів і бренди (фан-арт чужих франшиз, логотипи, відомих персонажів) без письмового дозволу правовласника, а також зображення реальних людей без їхньої згоди й будь-які зображення неповнолітніх у небезпечному чи інтимному контексті.',
                'Автор вказує походження роботи (створено вручну / за участі AI / повністю AI). Видавати AI-згенероване за ручну роботу заборонено.',
            ]],
            ['2. Які заходи ми застосовуємо (і їхні межі)', [
                'Оригінали зберігаються приватно й видаються лише за умовами ліцензії автора; на сайті показуються зменшені превʼю з водяним знаком і без метаданих зйомки.',
                'Ми ведемо журнал завантажень, зберігаємо хеш оригіналу, додаємо у видані файли метадані з номером завантаження й шукаємо схожі зображення під час модерації.',
                'Повністю унеможливити копіювання того, що показується на екрані, неможливо (наприклад, знімок екрана). Ці заходи зменшують цінність копій і допомагають довести авторство й швидко видаляти порушення, але не є гарантією захисту.',
                'Сигнали для ШІ-краулерів (robots.txt, мета-теги noai/noimageai) добровільні — не всі сервіси їх поважають.',
            ]],
            ['3. Як повідомити про порушення', [
                'Заповніть форму «Повідомити про порушення авторських прав» (посилання на сторінці кожного матеріалу) або напишіть на ' . $contact . '.',
                'Вкажіть: посилання чи номер оголошення; яка ваша робота порушена і чим; докази (посилання на оригінал, дати публікації); ваше ім’я як підпис і контакт; заяву про добросовісність і точність відомостей.',
                'Завідомо неправдиві заяви можуть мати правові наслідки для заявника.',
            ]],
            ['4. Розгляд', [
                'Після обґрунтованої заяви матеріал може бути тимчасово прихований до розгляду.',
                'Автор отримує лист із причиною й може подати зустрічну заяву протягом ' . $s['counter_days'] . ' днів.',
                'Адміністратор ухвалює рішення (приховати матеріал, відновити його або відхилити скаргу) і повідомляє обидві сторони.',
            ]],
            ['5. Повторні порушення', [
                'Кожне підтверджене порушення фіксується за акаунтом автора. Після ' . $s['strikes_limit'] . ' підтверджених порушень публікацію матеріалів для акаунта буде призупинено; акаунт може бути заблоковано.',
            ]],
            ['6. Ліцензія платформі', [
                'Публікуючи матеріал, автор надає AI LAB HUB невиключне безоплатне право зберігати файл і показувати його превʼю на сайті, у пошуку сайту й у матеріалах про маркетплейс — у межах, потрібних для роботи сервісу, на строк публікації.',
            ]],
            ['7. Контакт', [
                'Питання щодо авторських прав: ' . $contact . '.',
            ]],
        ],
    ],
    'en' => [
        'title' => 'Copyright policy',
        'draft' => 'DRAFT. This text needs legal review, in particular regarding the platform’s liability for user content and the takedown procedure in the site’s and users’ jurisdictions.',
        'sections' => [
            ['1. General', [
                'AI LAB HUB respects copyright and expects the same from users. Only your own works, or works you hold the rights to, may be published in the marketplace.',
                'Publishing other people’s characters and brands (fan art of others’ franchises, logos, well-known characters) without the rights holder’s written permission is prohibited, as are images of real people without their consent and any images of minors in a dangerous or intimate context.',
                'The author declares the origin of the work (made by hand / with AI assistance / fully AI-generated). Presenting AI-generated work as handmade is prohibited.',
            ]],
            ['2. What we do (and the limits)', [
                'Originals are stored privately and issued only under the author’s licence terms; the site shows reduced watermarked previews without camera metadata.',
                'We log downloads, keep a hash of the original, add metadata with a download number to issued files and look for similar images during moderation.',
                'Nothing shown on a screen can be made fully copy-proof (e.g. screenshots). These measures reduce the value of copies and help prove authorship and remove infringements quickly, but they are not a guarantee of protection.',
                'Signals for AI crawlers (robots.txt, noai/noimageai meta tags) are voluntary — not all services respect them.',
            ]],
            ['3. How to report an infringement', [
                'Use the “Report a copyright infringement” form (linked on every asset page) or write to ' . $contact . '.',
                'Include: the listing link or number; which of your works is infringed and how; evidence (links to the original, publication dates); your name as signature and contact; a statement of good faith and accuracy.',
                'Knowingly false notices may have legal consequences for the sender.',
            ]],
            ['4. Review', [
                'After a substantiated notice, the asset may be temporarily hidden pending review.',
                'The author receives an email with the reason and may file a counter-notice within ' . $s['counter_days'] . ' days.',
                'An administrator decides (disable the asset, restore it or reject the claim) and notifies both parties.',
            ]],
            ['5. Repeat infringers', [
                'Each confirmed infringement is recorded against the author’s account. After ' . $s['strikes_limit'] . ' confirmed infringements, publishing assets is suspended for the account; the account may be blocked.',
            ]],
            ['6. Licence to the platform', [
                'By publishing an asset, the author grants AI LAB HUB a non-exclusive, free right to store the file and show its preview on the site, in site search and in materials about the marketplace — to the extent needed to run the service, for the duration of the publication.',
            ]],
            ['7. Contact', [
                'Copyright questions: ' . $contact . '.',
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
    <title><?= $e($doc['title']) ?> — AI LAB HUB</title>
    <style>
        .legal-list li { margin: 0 0 8px; overflow-wrap: anywhere; }
        .legal-draft { margin: 16px 0 24px; padding: 12px 16px; border: 1px solid rgba(255, 210, 122, 0.55); border-radius: 12px; }
    </style>
    <link rel="stylesheet" href="/assets/css/site-nav.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/../app/site-header.php'; ?>
    <main class="page">
        <h1 class="stub__title"><?= $e($doc['title']) ?></h1>
        <p class="legal-draft"><?= $e($doc['draft']) ?></p>
        <?php foreach ($doc['sections'] as [$heading, $items]): ?>
        <h2 class="legal-heading"><?= $e($heading) ?></h2>
        <ul class="legal-list">
            <?php foreach ($items as $item): ?><li><?= $e($item) ?></li><?php endforeach; ?>
        </ul>
        <?php endforeach; ?>
        <p><a href="copyright-report.php"><?= $e(ast_tr('claim_title')) ?></a></p>
    </main>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
