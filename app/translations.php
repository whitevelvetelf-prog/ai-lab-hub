<?php

declare(strict_types=1);

/**
 * AI LAB HUB — багатомовність інтерфейсу (мовонезалежна архітектура).
 *
 * $GLOBALS['TRANSLATIONS'] нижче — це ЛИШЕ мова оригіналу (uk), написана
 * людиною. Переклад на будь-яку іншу активну мову (наразі лише en) шукається
 * в таблиці ui_translations (app/translation-cache.php); якщо перекладу
 * нема — автопереклад через Google Translation API й кешування. Список
 * активних мов інтерфейсу — config/languages.php; тут і в
 * app/translation-cache.php немає жодного хардкоду коду мови.
 *
 * Контент із бази даних (short_description, full_description тощо) сюди
 * не належить — його переклад/кешування живе в product.php через
 * product_translations / pricing_plan_translations (те саме
 * app/translation-cache.php). Назви категорій/підкатегорій — окремий,
 * простіший випадок (готовий переклад у колонці name_en, без автоперекладу
 * й без цієї таблиці) — localized_name() нижче лишається як є.
 *
 * Підключати до будь-якого виводу, одразу після app/auth.php (або першим,
 * якщо auth на сторінці не потрібен):
 *   require_once __DIR__ . '/../app/translations.php';
 *
 * Використання у шаблонах:
 *   <?= t('nav_home') ?>
 *
 * Поточна мова береться з $_SESSION['lang']; типова — мова оригіналу
 * (config/languages.php: 'source'). Перемикання: посилання на ту саму
 * сторінку з ?lang=uk | ?lang=en (чи будь-яку іншу активну мову).
 */

require_once __DIR__ . '/translation-cache.php';

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

/**
 * Словник фраз мовою оригіналу: ключ => 'текст українською'.
 * Список фраз зібрано з наявних шаблонів (шапка, підвал, index.php тощо).
 */
$GLOBALS['TRANSLATIONS'] = [
    // --- Шапка / навігація ---
    'nav_home'      => 'Головна',
    'nav_account'   => 'Кабінет',
    'nav_saved'     => 'Моя добірка',
    'nav_login'     => 'Увійти',
    'nav_assistant' => 'Викликати Асистента',
    // Короткий підпис кнопки асистента для вузьких екранів (додається через CSS ::after).
    'nav_assistant_short' => 'Спитати Елю',
    'nav_menu'      => 'Меню',
    'lang_switch'   => 'Мова інтерфейсу',

    // --- index.php: hero + напрямки ---
    'title_home'        => 'AI LAB HUB — Головна',
    'hero_title'        => 'AI LAB HUB',
    'hero_subtitle'     => 'Знайдіть AI-інструмент для будь-якого завдання',
    'hero_image_alt'    => 'Колба — AI LAB HUB',
    'directions_title'  => 'Напрямки AI',

    // --- Підвал ---
    'footer_blog'     => 'Блог',
    'footer_about'    => 'Про проєкт',
    'footer_contacts' => 'Контакти',
    'footer_terms'    => 'Умови використання',
    'footer_privacy'  => 'Політика конфіденційності',
    'footer_support'  => 'Підтримати проєкт',
    'footer_social'   => 'Соцмережі',

    // --- blog.php / blog-post.php: блог ---
    'title_blog'         => 'AI LAB HUB — Блог',
    'blog_heading'        => 'Блог',
    'blog_subtitle'       => 'Порівняння AI-інструментів і поради, як обрати те, що підходить саме вам.',
    'blog_empty'          => 'Статей поки немає.',
    'blog_back'           => '← До блогу',
    'blog_not_found'      => 'Статтю не знайдено',
    'blog_not_found_text' => 'Статті з такою адресою не існує або вона ще не опублікована.',

    // --- eli.php: чат з AI-асистенткою Елею ---
    'title_eli'              => 'AI LAB HUB — Еля, AI-асистентка',
    'eli_title'               => 'Еля — ваша AI-асистентка',
    'eli_subtitle'            => 'Опишіть задачу — Еля підбере найкращий AI-інструмент',
    'eli_video_alt'           => 'Відео Елі',
    'eli_greeting'            => 'Доброго дня! Розкажіть, яку задачу потрібно вирішити — і я підберу відповідний AI-інструмент.',
    'eli_input_placeholder'   => 'Опишіть свою задачу…',
    'eli_input_aria'          => 'Повідомлення',
    'eli_send'                => 'Надіслати',
    'eli_tech_error'          => 'Перепрошую, зараз виникли технічні труднощі. Спробуйте, будь ласка, ще раз за хвилину.',
    'eli_thinking'            => 'Еля обмірковує відповідь…',
    'eli_step_label'          => 'Крок',
    'eli_recommend'           => 'Рекомендую',
    'eli_default_reply'       => 'Ось що я підібрала для вас.',
    'eli_new_chat'            => 'Новий діалог',

    // --- Пошук у шапці (app/footer.php + public/assets/js/site-search.js) ---
    'search_placeholder'   => 'Пошук AI-інструментів…',
    'search_clear_aria'    => 'Очистити пошук',
    'search_no_results'    => 'Нічого не знайдено',
    'search_no_results_hint' => 'Спробуйте інший запит або',
    'search_ask_eli_link'  => 'запитайте Елю',
    'search_view_all'      => 'Показати всі результати',
    'search_results_heading' => 'Результати пошуку: «%s»',

    // --- catalog.php / category.php: спільні написи каталогу ---
    'catalog_default_title'        => 'Каталог AI-інструментів',
    'catalog_subcategory_not_found' => 'Підкатегорію не знайдено',
    'category_not_found'           => 'Категорію не знайдено',
    'category_not_found_text'      => 'Напрямок із таким ідентифікатором відсутній.',
    'category_empty'               => 'У цьому напрямку поки немає підкатегорій.',
    'back_to_direction'            => '← До напряму',
    'back_to_all_directions'       => '← Усі напрямки',
    'catalog_empty'                => 'У цьому розділі поки немає опублікованих продуктів.',
    'btn_details'                   => 'Докладніше',
    'price_free'                    => 'Безкоштовно',
    'price_from'                    => 'Від',
    'unit_week'                     => 'тиж',
    'unit_month'                    => 'міс',
    'unit_year'                     => 'рік',
    'unit_one_time'                 => 'разово',

    // --- product.php ---
    'product_not_found'      => 'Продукт не знайдено',
    'product_not_found_text' => 'Продукт із таким ідентифікатором відсутній або ще не опублікований.',
    'back_to_directions'     => 'До напрямків AI',
    'back_button'             => 'Назад',
    'product_visit_site'     => 'Перейти на сайт',
    'product_features_title' => 'Основні функції',
    'product_audience_title' => 'Для кого призначений',
    'product_plans_title'    => 'Тарифні плани',
    'product_plan_select'    => 'Обрати',
    'product_platform_label' => 'Платформа',
    'product_skill_label'    => 'Рівень навичок',
    'platform_web'           => 'Веб',
    'platform_mobile'        => 'Мобільний',
    'platform_desktop'       => 'Десктоп',
    'skill_basic'            => 'Потрібні базові знання',
    'skill_course'           => 'Потрібне окреме навчання (курс)',
    'skill_none'             => 'Не потребує спеціальних знань',

    // --- account.php ---
    'account_title_guest'        => 'Ваш кабінет',
    'account_text_guest'         => 'Увійдіть, щоб зберігати обрані продукти та отримати персональні рекомендації від Елі.',
    'account_create'             => 'Створити акаунт',
    'account_welcome_prefix'     => 'Вітаємо,',
    'role_user'                  => 'Користувач',
    'role_employee'              => 'Співробітник',
    'role_admin'                 => 'Адміністратор',
    'account_saved_title'        => 'Моя добірка',
    'account_saved_empty_prefix' => 'Ще немає збережених продуктів. Перегляньте',
    'account_directions_link'    => 'напрямки AI на головній',
    'account_saved_count'        => 'У добірці продуктів: %d.',
    'account_saved_open_link'    => 'Відкрити «Мою добірку»',

    // --- «Моя добірка»: сторінка saved.php + кнопка «зберегти» на картках ---
    'title_saved'                => 'AI LAB HUB — Моя добірка',
    'saved_page_title'           => 'Моя добірка',
    'saved_empty_text'           => 'У вашій добірці поки порожньо. Збережіть цікаві інструменти лапкою на картці —',
    'saved_empty_link'           => 'перейти до каталогу',
    'saved_btn_save'             => 'Зберегти в добірку',
    'saved_btn_unsave'           => 'Прибрати з добірки',
    'saved_hint_guest'           => 'Увійдіть, щоб зберегти',
    'saved_error'                => 'Не вдалося. Спробуйте ще раз.',
    'account_stats_title'        => 'Статистика користувачів',
    'stats_total_label'          => 'Усього',
    'stats_users_label'          => 'Користувачі',
    'stats_employees_label'      => 'Працівники',
    'stats_admins_label'         => 'Адміни',
    'stats_pending_label'        => 'Заявки на розгляді:',
    'account_staff_employees_title' => 'Працівники',
    'account_staff_admins_title'    => 'Адміністратори',
    'account_role_since_prefix'  => '· роль з',
    'account_crm_access_prefix'  => 'Доступ до CRM:',
    'account_crm_list_link'      => 'список продуктів',
    'account_crm_add_link'       => 'додати новий AI-продукт',
    'account_logout'             => 'Вийти з акаунту',

    // --- account.php: акордеон-структура кабінету ---
    'account_requests_title'         => 'Заявки',
    'account_stats_accordion_title'  => 'Статистика сайту',
    'account_crm_section_title'      => 'CRM',
    'account_accordion_collapse'     => 'Згорнути',

    // --- login.php / register.php ---
    'title_login'            => 'AI LAB HUB — Вхід',
    'login_heading'          => 'Вхід',
    'login_subtitle'         => 'Увійдіть, щоб перейти до свого кабінету.',
    'login_error_invalid'    => 'Невірний email або пароль',
    'login_no_account'       => 'Немає акаунта?',
    'title_register'         => 'AI LAB HUB — Реєстрація',
    'register_heading'       => 'Реєстрація',
    'register_subtitle'      => 'Створіть акаунт, щоб зберігати продукти та отримувати рекомендації від Елі.',
    'register_have_account'  => 'Уже маєте акаунт?',
    'action_register'        => 'Зареєструватися',
    'field_name'             => 'Ім\'я',
    'field_password'         => 'Пароль',
    'field_password_confirm' => 'Підтвердження пароля',
    'pw_show'                => 'Показати',
    'pw_hide'                => 'Сховати',
    'pw_show_aria'           => 'Показати пароль',
    'pw_hide_aria'           => 'Сховати пароль',
    'err_name_required'      => 'Вкажіть ім\'я.',
    'err_name_too_long'      => 'Ім\'я задовге (максимум 255 символів).',
    'err_email_required'     => 'Вкажіть email.',
    'err_email_invalid'      => 'Некоректний email.',
    'err_password_short'     => 'Пароль має містити щонайменше 8 символів.',
    'err_password_mismatch'  => 'Паролі не збігаються.',
    'err_email_taken'        => 'Користувач із таким email уже зареєстрований.',
    'err_register_failed'    => 'Не вдалося створити акаунт. Спробуйте ще раз.',

    // --- login.php: посилання «Забули пароль?» ---
    'forgot_password_link'   => 'Забули пароль?',

    // --- forgot-password.php / login-via-token.php: вхід без пароля (magic link) ---
    'title_forgot_password'  => 'AI LAB HUB — Забули пароль?',
    'forgot_heading'         => 'Забули пароль?',
    'forgot_subtitle'        => 'Введіть email — і ми надішлемо посилання для входу без пароля.',
    'forgot_submit'          => 'Надіслати посилання для входу',
    'forgot_success'         => 'Якщо цей email зареєстрований, на нього надіслано посилання для входу.',
    'forgot_success_hint'    => 'Не бачите листа кілька хвилин — перевірте папку «Спам».',
    'forgot_back_login'      => '← До входу',

    'mail_login_subject'     => 'Вхід в AI LAB HUB',
    'mail_login_greeting'    => 'Вітаємо, %s!',
    'mail_login_intro'       => 'Ви (або хтось від вашого імені) запросили вхід у кабінет AI LAB HUB без пароля. Натисніть кнопку нижче, щоб увійти:',
    'mail_login_button'      => 'Увійти в кабінет',
    'mail_login_fallback'    => 'Якщо кнопка не працює, скопіюйте це посилання у браузер:',
    'mail_login_expiry'      => 'Посилання діє %d хвилин і працює лише один раз. Якщо ви не запитували вхід — просто ігноруйте цей лист.',

    'token_invalid_title'    => 'Посилання недійсне',
    'token_invalid_text'     => 'Це посилання для входу прострочене, вже використане або невірне.',
    'token_invalid_retry'    => 'Запросити нове посилання',

    // --- account.php: flash-повідомлення схвалення заявки (обробник живий,
    // навіть коли кнопка в UI тимчасово прихована) ---
    'flash_request_not_found'  => 'Заявку не знайдено або вона вже опрацьована.',
    'flash_request_approved'   => 'Заявку схвалено. Працівнику присвоєно номер №%d.',
    'flash_request_approve_failed' => 'Не вдалося схвалити заявку. Спробуйте ще раз.',

    // --- Приватна система заявок на роль Адміністратора (apply-admin.php + account.php).
    // Самостійна функція: форма-підтвердження без вибору посади. ---
    'title_apply_admin'          => 'AI LAB HUB — Заявка на адміністратора',
    'apply_admin_heading'        => 'Заявка на роль Адміністратора',
    'apply_admin_confirm_text'   => 'Подати заявку на роль Адміністратора',
    'apply_admin_submit'         => 'Надіслати заявку',
    'apply_admin_already_admin'  => 'Ви вже маєте роль адміністратора.',
    'apply_admin_pending_prefix' => 'Ваша заявка на розгляді (подана',
    'apply_admin_pending_suffix' => '). Очікуйте рішення.',
    'apply_admin_approved_text'  => 'Вашу заявку вже схвалено.',
    'apply_admin_back_account'   => 'До кабінету',
    'account_admin_requests_title' => 'Заявки на роль Адміністратора',
    'account_admin_requests_empty' => 'Немає заявок на розгляді.',
    'account_requested_prefix'     => '· подано',
    'action_approve'               => 'Схвалити',
    'action_reject'                => 'Відхилити',
    'flash_admin_request_approved' => 'Заявку на адміністратора схвалено. Користувачу присвоєно роль Адміністратора.',
    'flash_admin_request_rejected' => 'Заявку відхилено.',
    'flash_admin_request_failed'   => 'Не вдалося обробити заявку. Спробуйте ще раз.',

    // --- Приватні заявки на посади директорів (apply-ceo.php / apply-exec-director.php + account.php).
    // Дві окремі форми, посада «зашита» у формі; поля: Ім'я / Прізвище / Телефон / Email. ---
    'title_apply_ceo'            => 'AI LAB HUB — Заявка на посаду Генерального директора',
    'title_apply_exec'           => 'AI LAB HUB — Заявка на посаду Виконавчого директора',
    'apply_ceo_heading'          => 'Заявка на посаду Генерального директора',
    'apply_exec_heading'         => 'Заявка на посаду Виконавчого директора',
    'apply_director_intro'       => 'Заповніть контактні дані. Рішення ухвалює власниця проєкту особисто.',
    'apply_director_first_name'  => 'Ім’я',
    'apply_director_last_name'   => 'Прізвище',
    'apply_director_phone'       => 'Телефон',
    'apply_director_email'       => 'Email',
    'apply_director_email_hint'  => 'Має збігатися з email вашого акаунта.',
    'apply_director_submit'      => 'Надіслати заявку',
    'apply_director_back_account' => 'До кабінету',
    'apply_director_err_required'      => 'Заповніть усі поля.',
    'apply_director_err_email_invalid' => 'Некоректний email.',
    'apply_director_err_email_match'   => 'Email має збігатися з email вашого акаунта.',
    'apply_director_err_too_long'      => 'Одне з полів задовге.',
    'apply_director_pending'     => 'Вашу заявку на цю посаду вже надіслано. Очікуйте рішення.',
    'apply_director_approved'    => 'Вашу заявку на цю посаду вже схвалено.',
    'account_admin_request_role_label'      => 'роль Адміністратора',
    'account_admin_request_owner_only_note' => 'Підтверджує власниця проєкту',
    'account_admin_position_full_note'      => 'Усі позиції на цю посаду зайняті',
    'flash_admin_request_owner_only' => 'Цю заявку підтверджує лише власниця проєкту.',
    'flash_admin_position_taken'   => 'Немає вільних позицій на посаду «%s». Заявку залишено на розгляді.',
    'flash_admin_director_approved' => 'Заявку схвалено. Кандидату надано доступ до CRM і посаду «%s».',

    // --- Універсальна система заявок на посаду (public/account.php —
    // створення посилання й список; public/apply-position.php — форма
    // кандидата). Заміна окремих apply-ceo.php/apply-exec-director.php
    // для НОВИХ заявок; старі форми й дані лишаються без змін. ---
    'account_create_position_link_title' => 'Створити посилання на заявку',
    'position_title_field'   => 'Назва посади',
    'err_position_title_required' => 'Вкажіть назву посади.',
    'create_position_link_submit' => 'Створити посилання',
    'flash_position_link_created' => 'Посилання створено: %s',

    'account_position_apps_title' => 'Заявки на посади',
    'account_position_apps_empty' => 'Активних заявок немає.',
    'position_apps_col_position'  => 'Посада',
    'position_apps_col_candidate' => 'Кандидат',
    'position_apps_col_status'    => 'Статус',
    'position_apps_col_submitted' => 'Подано',
    'position_apps_status_pending'   => 'Очікує заповнення',
    'position_apps_status_submitted' => 'На розгляді',
    'position_apps_status_confirmed' => 'Підтверджено',
    'action_confirm_application' => 'Підтвердити',
    'flash_position_app_confirmed' => 'Заявку підтверджено. Користувачу присвоєно посаду «%s» і роль Адміністратора.',
    'flash_position_app_no_user' => 'Не вдалося підтвердити: акаунта з email «%s» не знайдено. Кандидат мав зареєструватися перед поданням заявки.',

    'title_apply_position'   => 'AI LAB HUB — Заявка на посаду',
    'apply_position_intro'   => 'Заповніть контактні дані, щоб подати заявку на цю посаду.',
    'apply_position_submit'  => 'Надіслати',
    'apply_position_thanks_title' => 'Дякуємо!',
    'apply_position_thanks_text'  => 'Заявку надіслано. Ми зв’яжемося з вами найближчим часом.',
    'apply_position_no_account_error' => 'Акаунта з цим email не знайдено. Спершу зареєструйтеся на сайті з цим email, а тоді заповніть форму ще раз.',

    // --- Кнопка «Поділитися» (app/footer.php + public/assets/js/share-button.js) ---
    'share_button'       => 'Поділитися',
    'share_copy_link'    => 'Скопіювати посилання',
    'share_copied'       => 'Посилання скопійовано',
    'share_email'        => 'Електронна пошта',
    'share_product_text' => 'Перегляньте %s на AI LAB HUB',

    // --- Дисклеймер про партнерські посилання (app/footer.php, product.php) ---
    'footer_disclaimer'        => 'AI LAB HUB може отримувати комісію за покупки, здійснені через деякі посилання на сайті — це не впливає на вартість для вас.',
    'product_affiliate_badge'  => 'партнерське посилання',
    'product_affiliate_tooltip' => 'Це партнерське посилання: якщо ви скористаєтесь ним, AI LAB HUB може отримати невелику комісію.',

    // --- Внутрішня реклама (app/ads.php, app/ad-banner.php) ---
    'ad_label' => 'Реклама',

    // --- Статистика сайту для admin (public/admin-stats.php, посилання в account.php) ---
    'account_site_stats_link' => 'Статистика сайту →',

    // --- Форма підписки на розсилку (app/footer.php + public/assets/js/newsletter-form.js) ---
    'newsletter_title'         => 'Дізнавайтесь про нові AI-інструменти першими',
    'newsletter_placeholder'   => 'Ваш email',
    'newsletter_submit'        => 'Підписатись',
    'newsletter_success'       => 'Дякуємо! Ви підписані на розсилку.',
    'newsletter_already'       => 'Ви вже підписані.',
    'newsletter_error_invalid' => 'Некоректний email.',
    'newsletter_error_generic' => 'Не вдалося підписатись. Спробуйте пізніше.',
];

/**
 * Посади директорів для приватних форм заявки (public/apply-ceo.php,
 * public/apply-exec-director.php) та кабінету (public/account.php).
 *   ключ         — у admin_requests.position і як технічний ідентифікатор форми;
 *   label        — людський підпис (зберігається в users.position, показується
 *                  в кабінеті/CRM замість ролі);
 *   capacity     — скільки людей можуть обіймати посаду одночасно
 *                  (Генеральний — 1, Виконавчий — 2).
 * Роль кандидата після підтвердження — 'admin' (рівень доступу до CRM).
 */
const DIRECTOR_POSITIONS = [
    'ceo'           => ['label' => 'Генеральний директор', 'capacity' => 1],
    'exec_director' => ['label' => 'Виконавчий директор',  'capacity' => 2],
];

/** Людський підпис посади директора за ключем, або null для невідомого/порожнього. */
function director_position_label(?string $key): ?string
{
    if ($key === null || $key === '') {
        return null;
    }

    return DIRECTOR_POSITIONS[$key]['label'] ?? null;
}

/** Скільки людей можуть обіймати цю посаду одночасно (0 — невідома посада). */
function director_position_capacity(?string $key): int
{
    if ($key === null || $key === '') {
        return 0;
    }

    return DIRECTOR_POSITIONS[$key]['capacity'] ?? 0;
}

/**
 * Поточна мова інтерфейсу: значення з сесії, якщо воно є серед активних
 * (config/languages.php), інакше — мова оригіналу.
 */
function current_lang(): string
{
    $lang = $_SESSION['lang'] ?? translation_source_lang();

    return in_array($lang, active_lang_codes(), true) ? $lang : translation_source_lang();
}

/** Зберігає обрану мову в сесію (тихо ігнорує неактивні коди мови). */
function set_lang(string $lang): void
{
    if (in_array($lang, active_lang_codes(), true)) {
        $_SESSION['lang'] = $lang;
    }
}

/**
 * Власне PDO-з'єднання для перекладу статичних написів — створюється
 * лише за потреби (кеш-міс у ui_translations, див. t() нижче), тож
 * сторінки, які й без цього не працюють з БД, зайвого з'єднання не платять.
 */
function translation_pdo(): PDO
{
    static $pdo = null;
    if ($pdo === null) {
        $pdo = require __DIR__ . '/../config/database.php';
    }

    return $pdo;
}

/**
 * Усі закешовані переклади написів для мови одним запитом (замість
 * запиту на кожен окремий викор t() на сторінці). Для мови оригіналу
 * не викликається взагалі — t() повертає оригінал без БД.
 *
 * @return array<string, string>
 */
function ui_translations_map(string $lang): array
{
    static $cache = [];
    if (!isset($cache[$lang])) {
        $stmt = translation_pdo()->prepare(
            'SELECT key_name, translated_text FROM ui_translations WHERE lang = :lang'
        );
        $stmt->execute([':lang' => $lang]);
        $cache[$lang] = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);
    }

    return $cache[$lang];
}

/**
 * Переклад за ключем для поточної мови.
 *
 * Мова оригіналу → повертає $GLOBALS['TRANSLATIONS'][$key] напряму, без
 * звернення до ui_translations. Інша активна мова → готовий переклад із
 * ui_translations (один запит на все на сторінку); якщо конкретного ключа
 * там ще нема (новий рядок у коді) — автопереклад і кешування «на льоту»
 * через cached_translation() (app/translation-cache.php).
 */
function t(string $key): string
{
    $lang = current_lang();
    $sourceText = $GLOBALS['TRANSLATIONS'][$key] ?? $key;

    if ($lang === translation_source_lang()) {
        return $sourceText;
    }

    $map = ui_translations_map($lang);
    if (isset($map[$key]) && $map[$key] !== '') {
        return $map[$key];
    }

    return cached_translation(translation_pdo(), 'ui_translations', ['key_name' => $key], $lang, $sourceText);
}

/**
 * Назва категорії/підкатегорії поточною мовою.
 *
 * Готовий переклад лежить прямо в рядку (колонка name_en, заповнена
 * вручну один раз при додаванні категорії/підкатегорії — назв мало,
 * автопереклад тут не потрібен). Українська (name) завжди заповнена;
 * якщо перекладу нема — лишаємо українську, щоб ніколи не показати
 * порожній напис.
 *
 * @param array{name: string, name_en?: string|null} $row
 */
function localized_name(array $row): string
{
    if (current_lang() !== translation_source_lang() && !empty($row['name_en'])) {
        return (string) $row['name_en'];
    }

    return (string) $row['name'];
}

/**
 * Довільне текстове поле сутності з БД поточною мовою — для контенту
 * картки продукту (short_description, full_description, main_features,
 * target_audience у product_translations; plan_name, description у
 * pricing_plan_translations).
 *
 * Мова оригіналу → значення напряму з $row[$field], без звернення до
 * таблиці перекладів. Інша активна мова → cached_translation() шукає
 * готовий переклад і, якщо нема, перекладає й кешує (app/translation-cache.php).
 *
 * @param array<string, mixed> $row Рядок із БД; має містити 'id'.
 */
function localized_field(PDO $pdo, string $table, string $idColumn, array $row, string $field): string
{
    $sourceText = (string) ($row[$field] ?? '');
    $lang = current_lang();

    if ($lang === translation_source_lang()) {
        return $sourceText;
    }

    return cached_translation(
        $pdo,
        $table,
        [$idColumn => (int) $row['id'], 'field_name' => $field],
        $lang,
        $sourceText
    );
}

/*
 * Перемикач мови.
 *
 * Посилання ведуть на поточну сторінку з ?lang=<код активної мови>.
 * Зберігаємо вибір у сесію і, якщо вивід ще не почався, робимо чистий
 * редірект назад на цю ж сторінку без параметра lang (інші параметри
 * зберігаються). Якщо заголовки вже надіслані (translations.php
 * підключено пізно, напр. із підвалу) — просто зберігаємо вибір, він
 * застосується з наступного завантаження.
 */
if (isset($_GET['lang'])) {
    set_lang((string) $_GET['lang']);

    if (!headers_sent()) {
        $params = $_GET;
        unset($params['lang']);

        $path = strtok($_SERVER['REQUEST_URI'] ?? '', '?');
        $query = http_build_query($params);

        header('Location: ' . $path . ($query !== '' ? '?' . $query : ''), true, 302);
        exit;
    }
}
