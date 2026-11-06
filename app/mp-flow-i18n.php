<?php

declare(strict_types=1);

/**
 * AI LAB HUB — рядки UA/EN для підтвердження пошти, подачі оголошень (чернетки, блоки форми) і блоків-категорій.
 * Той самий механізм, що LST_I18N (app/listing-i18n.php): пара [uk, en], мова — current_lang().
 */

const MPF_I18N = [
    // Підтвердження пошти
    'v_title' => ['Підтвердження пошти', 'Email confirmation'],
    'v_ok_state' => ['Пошту підтверджено ✓', 'Email confirmed ✓'],
    'v_need_state' => ['Підтвердьте пошту', 'Please confirm your email'],
    'v_need_text' => ['Щоб подавати оголошення, показувати контакти й скаржитися, підтвердьте пошту %s. Це потрібно один раз.', 'To post listings, see contacts and send reports, confirm your email %s. You only need to do this once.'],
    'v_sent_at' => ['Лист із посиланням уже надіслано на %s о %s. Посилання діє до %s. Перевірте «Вхідні» і «Спам».', 'A confirmation link was sent to %s at %s. It is valid until %s. Check your inbox and spam folder.'],
    'v_send_btn' => ['Надіслати лист', 'Send the email'],
    'v_resend_btn' => ['Надіслати ще раз', 'Send again'],
    'v_resend_hint' => ['Повторно — не частіше ніж раз на %d хв. Попередні посилання теж залишаються дійсними.', 'You can resend once every %d min. Earlier links stay valid too.'],
    'v_check_btn' => ['Я підтвердив(ла)', 'I have confirmed'],
    'v_check_hint' => ['Відкрили посилання в іншому браузері чи застосунку? Натисніть «Я підтвердив(ла)» — ми перевіримо.', 'Opened the link in another browser or app? Tap “I have confirmed” and we will check.'],
    'v_check_not_yet' => ['Підтвердження ще не надійшло. Відкрийте посилання з листа й натисніть кнопку «Підтвердити email» на сторінці, що відкриється.', 'We have not received the confirmation yet. Open the link from the email and press “Confirm email” on the page that opens.'],
    'v_already_sent' => ['Лист уже надіслано — нового не надсилаємо, поки діє попереднє посилання.', 'The email has already been sent — we will not send a new one while the previous link is valid.'],
    'v_continue' => ['Продовжити', 'Continue'],
    'v_login_continue' => ['Увійти й продовжити', 'Log in and continue'],
    'v_done_title' => ['Пошту підтверджено', 'Email confirmed'],
    'v_done_text' => ['Готово! Пошту підтверджено — більше її підтверджувати не потрібно.', 'Done! Your email is confirmed — you will not need to do it again.'],
    'v_done_login' => ['Щоб продовжити, увійдіть у свій акаунт у цьому браузері.', 'To continue, log in to your account in this browser.'],
    'v_done_other_user' => ['Зараз у цьому браузері відкрито інший акаунт. Пошту підтверджено для акаунта, якому надсилали лист.', 'Another account is open in this browser. The email was confirmed for the account the message was sent to.'],
    'v_confirm_text' => ['Натисніть кнопку, щоб підтвердити пошту. Входити в акаунт для цього не потрібно.', 'Press the button to confirm your email. You do not need to log in for this.'],
    'v_cabinet_btn' => ['Підтвердити пошту', 'Confirm email'],

    // Вхід
    'login_title' => ['Увійдіть, щоб продовжити', 'Log in to continue'],
    'login_text' => ['Подавати оголошення можуть зареєстровані користувачі. Після входу ви повернетеся сюди.', 'Only registered users can post listings. After logging in you will come back here.'],

    // Чернетки
    'draft_saved' => ['Чернетку збережено', 'Draft saved'],
    'draft_saving' => ['Зберігаємо чернетку…', 'Saving draft…'],
    'draft_restored' => ['Відновлено вашу чернетку від %s.', 'Your draft from %s has been restored.'],
    'draft_discard' => ['Почати заново', 'Start over'],
    'draft_badge' => ['Чернетка', 'Draft'],
    'draft_continue' => ['Продовжити заповнення', 'Continue editing'],
    'draft_untitled' => ['Без назви', 'Untitled'],
    'draft_board' => ['Оголошення дошки', 'Board listing'],

    // Форма блоками
    'blk_section' => ['1. Розділ і категорія', '1. Section and category'],
    'blk_main' => ['2. Основне', '2. Main details'],
    'blk_place' => ['3. Місце й формат', '3. Location and format'],
    'blk_contacts' => ['4. Контакти й посилання', '4. Contacts and link'],
    'blk_photos' => ['5. Фото', '5. Photos'],
    'blk_rules' => ['Правила й відправлення', 'Rules and submission'],
    'blk_details' => ['Деталі', 'Details'],
    'required_note' => ['Поля з * обов’язкові.', 'Fields marked * are required.'],
    'errors_below' => ['Перевірте поля, позначені нижче.', 'Please check the fields marked below.'],

    // Після відправлення
    'sent_title' => ['Оголошення на модерації', 'Your listing is under review'],
    'sent_text' => ['Дякуємо! Оголошення на модерації — відповімо протягом %d год. Ми надішлемо лист, коли його схвалять.', 'Thank you! Your listing is under review — we will reply within %d hours and email you once it is approved.'],
    'sent_my' => ['Мої оголошення', 'My listings'],

    // Блоки-категорії
    'cat_title' => ['Категорії', 'Categories'],
    'cat_count' => ['%d оголошення|%d оголошення|%d оголошень', '%d listing|%d listings|%d listings'],
    'cat_new' => ['Нові оголошення', 'New listings'],
    'cat_all_job' => ['Усі вакансії', 'All jobs'],
    'cat_all_course' => ['Усі курси', 'All courses'],
    'cat_all_service' => ['Усі послуги', 'All services'],
    'cat_empty_all' => ['Тут поки немає оголошень. Станьте першими — розміщення безкоштовне.', 'There are no listings here yet. Be the first — posting is free.'],
    'cat_back' => ['← Усі категорії', '← All categories'],
    'flt_city' => ['Місто', 'City'],
    'flt_fresh' => ['Свіжість', 'Posted'],
    'flt_fresh_1' => ['За добу', 'Last 24 hours'],
    'flt_fresh_7' => ['За тиждень', 'Last 7 days'],
    'flt_fresh_30' => ['За місяць', 'Last 30 days'],
    'flt_format' => ['Формат', 'Format'],
    'flt_format_remote' => ['Віддалено', 'Remote'],
    'flt_format_onsite' => ['На місці', 'On-site'],
];

/** Кількість із відмінюванням: рядок «одна|кілька|багато» (uk) або «one|many|many» (en). */
function mpf_count(string $key, int $n): string
{
    $forms = explode('|', mpf_tr($key, $n, $n, $n));
    $lang = function_exists('current_lang') ? current_lang() : 'uk';
    if ($lang === 'en') {
        $i = $n === 1 ? 0 : 1;
    } else {
        $m10 = $n % 10;
        $m100 = $n % 100;
        $i = $m10 === 1 && $m100 !== 11 ? 0 : ($m10 >= 2 && $m10 <= 4 && ($m100 < 12 || $m100 > 14) ? 1 : 2);
    }

    return $forms[$i] ?? $forms[0];
}

function mpf_tr(string $key, mixed ...$args): string
{
    $pair = MPF_I18N[$key] ?? null;
    if ($pair === null) {
        return $key;
    }
    $lang = function_exists('current_lang') ? current_lang() : 'uk';
    $txt = $lang === 'en' ? $pair[1] : $pair[0];

    return $args === [] ? $txt : vsprintf($txt, $args);
}
