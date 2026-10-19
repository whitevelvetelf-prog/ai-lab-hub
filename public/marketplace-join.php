<?php

declare(strict_types=1);

/**
 * AI LAB HUB — сторінка запрошення з листа аутрічу: marketplace-join.php?t=TOKEN.
 *
 * Коротко про безкоштовне розміщення, кроки, посилання на форму публікації й правила. Токен прив'язує візит до ліду
 * (у сесії лише id ліду, без персональних даних); оголошення, створене в цій сесії, переводить лід у «Розмістили»
 * (public/listing-post.php → omail_join_listed()). Звіт через 30 днів після публікації надсилає cron/marketplace-daily.php.
 * Поки Marketplace приховано — сторінка «Скоро» (як решта розділу).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/outreach-mail.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$raw = is_string($_GET['t'] ?? null) ? (string) $_GET['t'] : '';
$leadId = $raw !== '' ? omail_join_lead($pdo, $raw) : null;
if ($leadId !== null) {
    $_SESSION['outreach_join_lead'] = $leadId;
}
$st = $leadId !== null ? $pdo->prepare('SELECT lead_type FROM outreach_leads WHERE id = :id') : null;
if ($st !== null) {
    $st->execute([':id' => $leadId]);
}
$type = $st !== null ? (string) ($st->fetchColumn() ?: 'job') : 'job';
if (!lst_type_valid($type)) {
    $type = 'job';
}
$days = lst_settings($pdo)['days'];
$free = lst_free_label($pdo);
$en = lst_lang() === 'en';
$tx = static fn(string $uk, string $enText): string => lst_e($en ? $enText : $uk);

lst_open($en ? 'Free listing for AI companies' : 'Безкоштовне розміщення для AI-компаній', true, '', '');
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= $tx('Розмістіть вакансію, курс чи послугу на AI LAB HUB', 'Post your job, course or service on AI LAB HUB') ?></h1>
        <?php if ($free !== ''): ?><p class="mp-callout lst-free"><?= lst_e($free) ?></p><?php endif; ?>
        <p class="mp-subtitle"><?= $tx('AI LAB HUB — каталог AI-інструментів. У розділі маркетплейсу компанії самі публікують вакансії, курси й послуги у сфері штучного інтелекту.', 'AI LAB HUB is a directory of AI tools. In its marketplace section, companies post their own AI-related jobs, courses and services.') ?></p>
        <section class="mp-panel">
            <h2 class="mp-panel__title"><?= $tx('Як це працює', 'How it works') ?></h2>
            <ol class="mp-text">
                <li><?= $tx('Зареєструйтеся або увійдіть і підтвердьте пошту (бажано корпоративну — так модерація проходить швидше).', 'Sign up or log in and confirm your email (a corporate address speeds up review).') ?></li>
                <li><?= $tx('Заповніть коротку форму й додайте посилання на сторінку вакансії, курсу чи послуги на вашому сайті.', 'Fill in a short form and add a link to the job, course or service page on your website.') ?></li>
                <li><?= lst_e($en ? sprintf('A moderator reviews the listing; once approved it is shown for %d days. You can extend it for free.', $days) : sprintf('Модератор перевіряє оголошення; після схвалення воно показується %d днів. Продовжити можна безкоштовно.', $days)) ?></li>
                <li><?= $tx('Через 30 днів ми надішлемо звіт про перегляди й переходи за вашим оголошенням.', 'After 30 days we will send you a report on views and clicks.') ?></li>
            </ol>
            <p class="mp-actions">
                <a class="mp-btn mp-btn--primary mp-btn--lg" href="listing-post.php?type=<?= lst_e($type) ?>"><?= lst_e(lst_tr('post_' . $type)) ?></a>
                <?php foreach (LST_TYPES as $t): if ($t !== $type): ?><a class="mp-btn" href="listing-post.php?type=<?= $t ?>"><?= lst_e(lst_tr('post_' . $t)) ?></a><?php endif; endforeach; ?>
            </p>
            <?php if (auth_user_id() === null): ?>
                <p class="mp-note"><?= $tx('Спершу потрібен акаунт:', 'You will need an account first:') ?> <a href="register.php"><?= $tx('реєстрація', 'sign up') ?></a> · <a href="login.php"><?= $tx('вхід', 'log in') ?></a></p>
            <?php endif; ?>
        </section>
        <?= lst_rules_html() ?>
        <p class="mp-note"><a href="marketplace-rules.php"><?= lst_e(lst_tr('f_rules_link')) ?></a> · <a href="terms.php"><?= lst_e(lst_tr('terms_link')) ?></a> · <?= $tx('Питання:', 'Questions:') ?> <a href="mailto:partners@ailabhub-directory.com">partners@ailabhub-directory.com</a></p>
        <p class="mp-note"><?= lst_e(lst_tr('disclaimer')) ?></p>
    </div>
<?php mpb_close(); ?>
