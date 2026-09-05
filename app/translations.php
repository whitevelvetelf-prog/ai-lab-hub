<?php

declare(strict_types=1);

/**
 * AI LAB HUB — базова багатомовність інтерфейсу (UA / EN).
 *
 * Перекладаємо лише статичні написи сторінок. Контент із бази даних
 * (назви категорій, продуктів тощо) тут НЕ перекладається — це окремий крок.
 *
 * Підключати до будь-якого виводу, одразу після app/auth.php (або першим,
 * якщо auth на сторінці не потрібен):
 *   require_once __DIR__ . '/../app/translations.php';
 *
 * Використання у шаблонах:
 *   <?= t('nav_home') ?>
 *
 * Поточна мова береться з $_SESSION['lang']; типова — 'uk'.
 * Перемикання: посилання на ту саму сторінку з ?lang=uk | ?lang=en.
 */

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

/** Підтримувані мови інтерфейсу. */
const LANGS = ['uk', 'en'];

/** Мова за замовчуванням. */
const LANG_DEFAULT = 'uk';

/**
 * Словник перекладів: ключ => ['uk' => '…', 'en' => '…'].
 * Список фраз зібрано з наявних шаблонів (шапка, підвал, index.php).
 */
$GLOBALS['TRANSLATIONS'] = [
    // --- Шапка / навігація ---
    'nav_home'      => ['uk' => 'Головна',              'en' => 'Home'],
    'nav_account'   => ['uk' => 'Кабінет',              'en' => 'Account'],
    'nav_login'     => ['uk' => 'Увійти',               'en' => 'Log In'],
    'nav_assistant' => ['uk' => 'Викликати Асистента',  'en' => 'Call Assistant'],
    // Короткий підпис кнопки асистента для вузьких екранів (додається через CSS ::after).
    'nav_assistant_short' => ['uk' => 'Спитати Елю',    'en' => 'Ask Eli'],
    'nav_menu'      => ['uk' => 'Меню',                 'en' => 'Menu'],
    'lang_switch'   => ['uk' => 'Мова інтерфейсу',      'en' => 'Interface language'],

    // --- index.php: hero + напрямки ---
    'title_home'        => ['uk' => 'AI LAB HUB — Головна', 'en' => 'AI LAB HUB — Home'],
    'hero_title'        => ['uk' => 'AI LAB HUB',           'en' => 'AI LAB HUB'],
    'hero_subtitle'     => [
        'uk' => 'Знайдіть AI-інструмент для будь-якого завдання',
        'en' => 'Find an AI tool for any task',
    ],
    'hero_image_alt'    => ['uk' => 'Колба — AI LAB HUB', 'en' => 'Flask — AI LAB HUB'],
    'directions_title'  => ['uk' => 'Напрямки AI',        'en' => 'AI Directions'],

    // --- Підвал ---
    'footer_blog'     => ['uk' => 'Блог',                        'en' => 'Blog'],
    'footer_about'    => ['uk' => 'Про проєкт',                  'en' => 'About'],
    'footer_contacts' => ['uk' => 'Контакти',                    'en' => 'Contacts'],
    'footer_terms'    => ['uk' => 'Умови використання',          'en' => 'Terms of Use'],
    'footer_privacy'  => ['uk' => 'Політика конфіденційності',   'en' => 'Privacy Policy'],
    'footer_support'  => ['uk' => 'Підтримати проєкт',           'en' => 'Support the Project'],
    'footer_social'   => ['uk' => 'Соцмережі',                   'en' => 'Social media'],

    // --- eli.php: чат з AI-асистенткою Елею ---
    'title_eli'              => ['uk' => 'AI LAB HUB — Еля, AI-асистентка', 'en' => 'AI LAB HUB — Eli, AI Assistant'],
    'eli_title'               => ['uk' => 'Еля — ваша AI-асистентка',       'en' => 'Eli — your AI assistant'],
    'eli_subtitle'            => [
        'uk' => 'Опишіть задачу — Еля підбере найкращий AI-інструмент',
        'en' => 'Describe your task — Eli will find the best AI tool',
    ],
    'eli_video_alt'           => ['uk' => 'Відео Елі',                     'en' => 'Eli video'],
    'eli_greeting'            => [
        'uk' => 'Доброго дня! Розкажіть, яку задачу потрібно вирішити — і я підберу відповідний AI-інструмент.',
        'en' => 'Hello! Tell me what task you need to solve, and I will find the right AI tool for you.',
    ],
    'eli_input_placeholder'   => ['uk' => 'Опишіть свою задачу…',          'en' => 'Describe your task…'],
    'eli_input_aria'          => ['uk' => 'Повідомлення',                  'en' => 'Message'],
    'eli_send'                => ['uk' => 'Надіслати',                    'en' => 'Send'],
    'eli_tech_error'          => [
        'uk' => 'Перепрошую, зараз виникли технічні труднощі. Спробуйте, будь ласка, ще раз за хвилину.',
        'en' => 'Sorry, I am experiencing technical difficulties right now. Please try again in a minute.',
    ],
    'eli_thinking'            => ['uk' => 'Еля обмірковує відповідь…',      'en' => 'Eli is thinking…'],
    'eli_step_label'          => ['uk' => 'Крок',                         'en' => 'Step'],
    'eli_recommend'           => ['uk' => 'Рекомендую',                   'en' => 'Recommended'],
    'eli_default_reply'       => ['uk' => 'Ось що я підібрала для вас.',   'en' => 'Here is what I found for you.'],

    // --- catalog.php / category.php: спільні написи каталогу ---
    'catalog_default_title'        => ['uk' => 'Каталог AI-інструментів',                         'en' => 'AI Tools Catalog'],
    'catalog_subcategory_not_found' => ['uk' => 'Підкатегорію не знайдено',                        'en' => 'Subcategory not found'],
    'category_not_found'           => ['uk' => 'Категорію не знайдено',                           'en' => 'Category not found'],
    'category_not_found_text'      => ['uk' => 'Напрямок із таким ідентифікатором відсутній.',    'en' => 'No direction exists with this identifier.'],
    'category_empty'               => ['uk' => 'У цьому напрямку поки немає підкатегорій.',        'en' => 'This direction has no subcategories yet.'],
    'back_to_direction'            => ['uk' => '← До напряму',                                     'en' => '← Back to direction'],
    'back_to_all_directions'       => ['uk' => '← Усі напрямки',                                   'en' => '← All directions'],
    'catalog_empty'                => ['uk' => 'У цьому розділі поки немає опублікованих продуктів.', 'en' => 'There are no published products in this section yet.'],
    'btn_details'                   => ['uk' => 'Докладніше',                                       'en' => 'Details'],
    'price_free'                    => ['uk' => 'Безкоштовно',                                      'en' => 'Free'],
    'price_from'                    => ['uk' => 'Від',                                              'en' => 'From'],
    'unit_week'                     => ['uk' => 'тиж',                                              'en' => 'wk'],
    'unit_month'                    => ['uk' => 'міс',                                              'en' => 'mo'],
    'unit_year'                     => ['uk' => 'рік',                                              'en' => 'yr'],
    'unit_one_time'                 => ['uk' => 'разово',                                           'en' => 'one-time'],

    // --- product.php ---
    'product_not_found'      => ['uk' => 'Продукт не знайдено',                                                  'en' => 'Product not found'],
    'product_not_found_text' => ['uk' => 'Продукт із таким ідентифікатором відсутній або ще не опублікований.',   'en' => 'No product exists with this identifier, or it is not published yet.'],
    'back_to_directions'     => ['uk' => 'До напрямків AI',                                                       'en' => 'Back to AI directions'],
    'product_visit_site'     => ['uk' => 'Перейти на сайт',                                                       'en' => 'Visit website'],
    'product_features_title' => ['uk' => 'Основні функції',                                                      'en' => 'Key features'],
    'product_audience_title' => ['uk' => 'Для кого призначений',                                                 'en' => 'Who it is for'],
    'product_plans_title'    => ['uk' => 'Тарифні плани',                                                        'en' => 'Pricing plans'],
    'product_plan_select'    => ['uk' => 'Обрати',                                                               'en' => 'Choose'],
    'product_platform_label' => ['uk' => 'Платформа',                                                            'en' => 'Platform'],
    'product_skill_label'    => ['uk' => 'Рівень навичок',                                                       'en' => 'Skill level'],
    'platform_web'           => ['uk' => 'Веб',                                                                  'en' => 'Web'],
    'platform_mobile'        => ['uk' => 'Мобільний',                                                            'en' => 'Mobile'],
    'platform_desktop'       => ['uk' => 'Десктоп',                                                              'en' => 'Desktop'],
    'skill_basic'            => ['uk' => 'Потрібні базові знання',                                               'en' => 'Basic knowledge required'],
    'skill_course'           => ['uk' => 'Потрібне окреме навчання (курс)',                                      'en' => 'Dedicated training required (course)'],
    'skill_none'             => ['uk' => 'Не потребує спеціальних знань',                                        'en' => 'No special knowledge required'],

    // --- account.php ---
    'account_title_guest'        => ['uk' => 'Ваш кабінет',       'en' => 'Your account'],
    'account_text_guest'         => [
        'uk' => 'Увійдіть, щоб зберігати обрані продукти та отримати персональні рекомендації від Елі.',
        'en' => 'Log in to save favorite products and get personal recommendations from Eli.',
    ],
    'account_create'             => ['uk' => 'Створити акаунт',   'en' => 'Create account'],
    'account_welcome_prefix'     => ['uk' => 'Вітаємо,',          'en' => 'Welcome,'],
    'role_user'                  => ['uk' => 'Користувач',        'en' => 'User'],
    'role_employee'              => ['uk' => 'Співробітник',      'en' => 'Employee'],
    'role_admin'                 => ['uk' => 'Адміністратор',     'en' => 'Administrator'],
    'account_saved_title'        => ['uk' => 'Збережені продукти', 'en' => 'Saved products'],
    'account_saved_empty_prefix' => ['uk' => 'Ще немає збережених продуктів. Перегляньте', 'en' => 'No saved products yet. Check out'],
    'account_directions_link'    => ['uk' => 'напрямки AI на головній', 'en' => 'AI directions on the homepage'],
    'account_stats_title'        => ['uk' => 'Статистика користувачів', 'en' => 'User statistics'],
    'stats_total_label'          => ['uk' => 'Усього',            'en' => 'Total'],
    'stats_users_label'          => ['uk' => 'Користувачі',       'en' => 'Users'],
    'stats_employees_label'      => ['uk' => 'Працівники',        'en' => 'Employees'],
    'stats_admins_label'         => ['uk' => 'Адміни',            'en' => 'Admins'],
    'stats_pending_label'        => ['uk' => 'Заявки на розгляді:', 'en' => 'Pending requests:'],
    'account_staff_employees_title' => ['uk' => 'Працівники',     'en' => 'Employees'],
    'account_staff_admins_title'    => ['uk' => 'Адміністратори', 'en' => 'Administrators'],
    'account_role_since_prefix'  => ['uk' => '· роль з',          'en' => '· role since'],
    'account_crm_access_prefix'  => ['uk' => 'Доступ до CRM:',    'en' => 'CRM access:'],
    'account_crm_list_link'      => ['uk' => 'список продуктів',  'en' => 'product list'],
    'account_crm_add_link'       => ['uk' => 'додати новий AI-продукт', 'en' => 'add a new AI product'],
    'account_logout'             => ['uk' => 'Вийти з акаунту',   'en' => 'Log out'],

    // --- login.php / register.php ---
    'title_login'            => ['uk' => 'AI LAB HUB — Вхід',        'en' => 'AI LAB HUB — Log In'],
    'login_heading'          => ['uk' => 'Вхід',                     'en' => 'Log In'],
    'login_subtitle'         => ['uk' => 'Увійдіть, щоб перейти до свого кабінету.', 'en' => 'Log in to access your account.'],
    'login_error_invalid'    => ['uk' => 'Невірний email або пароль', 'en' => 'Invalid email or password'],
    'login_no_account'       => ['uk' => 'Немає акаунта?',           'en' => "Don't have an account?"],
    'title_register'         => ['uk' => 'AI LAB HUB — Реєстрація',  'en' => 'AI LAB HUB — Sign Up'],
    'register_heading'       => ['uk' => 'Реєстрація',               'en' => 'Sign Up'],
    'register_subtitle'      => [
        'uk' => 'Створіть акаунт, щоб зберігати продукти та отримувати рекомендації від Елі.',
        'en' => 'Create an account to save products and get recommendations from Eli.',
    ],
    'register_have_account'  => ['uk' => 'Уже маєте акаунт?',        'en' => 'Already have an account?'],
    'action_register'        => ['uk' => 'Зареєструватися',         'en' => 'Sign up'],
    'field_name'             => ['uk' => 'Ім\'я',                    'en' => 'Name'],
    'field_password'         => ['uk' => 'Пароль',                   'en' => 'Password'],
    'field_password_confirm' => ['uk' => 'Підтвердження пароля',    'en' => 'Confirm password'],
    'pw_show'                => ['uk' => 'Показати',                 'en' => 'Show'],
    'pw_hide'                => ['uk' => 'Сховати',                  'en' => 'Hide'],
    'pw_show_aria'           => ['uk' => 'Показати пароль',          'en' => 'Show password'],
    'pw_hide_aria'           => ['uk' => 'Сховати пароль',           'en' => 'Hide password'],
    'err_name_required'      => ['uk' => 'Вкажіть ім\'я.',           'en' => 'Please enter your name.'],
    'err_name_too_long'      => ['uk' => 'Ім\'я задовге (максимум 255 символів).', 'en' => 'Name is too long (255 characters max).'],
    'err_email_required'     => ['uk' => 'Вкажіть email.',           'en' => 'Please enter your email.'],
    'err_email_invalid'      => ['uk' => 'Некоректний email.',       'en' => 'Invalid email.'],
    'err_password_short'     => ['uk' => 'Пароль має містити щонайменше 8 символів.', 'en' => 'Password must be at least 8 characters long.'],
    'err_password_mismatch'  => ['uk' => 'Паролі не збігаються.',    'en' => 'Passwords do not match.'],
    'err_email_taken'        => ['uk' => 'Користувач із таким email уже зареєстрований.', 'en' => 'A user with this email is already registered.'],
    'err_register_failed'    => ['uk' => 'Не вдалося створити акаунт. Спробуйте ще раз.', 'en' => 'Could not create account. Please try again.'],

    // --- account.php: flash-повідомлення схвалення заявки (обробник живий,
    // навіть коли кнопка в UI тимчасово прихована) ---
    'flash_request_not_found'  => ['uk' => 'Заявку не знайдено або вона вже опрацьована.', 'en' => 'Request not found or already processed.'],
    'flash_request_approved'   => ['uk' => 'Заявку схвалено. Працівнику присвоєно номер №%d.', 'en' => 'Request approved. The employee was assigned number #%d.'],
    'flash_request_approve_failed' => ['uk' => 'Не вдалося схвалити заявку. Спробуйте ще раз.', 'en' => 'Could not approve the request. Please try again.'],
];

/**
 * Поточна мова інтерфейсу: значення з сесії, якщо воно валідне,
 * інакше — мова за замовчуванням.
 */
function current_lang(): string
{
    $lang = $_SESSION['lang'] ?? LANG_DEFAULT;

    return in_array($lang, LANGS, true) ? $lang : LANG_DEFAULT;
}

/** Зберігає обрану мову в сесію (тихо ігнорує непідтримувані значення). */
function set_lang(string $lang): void
{
    if (in_array($lang, LANGS, true)) {
        $_SESSION['lang'] = $lang;
    }
}

/**
 * Переклад за ключем для поточної мови.
 * Порядок пошуку: поточна мова → мова за замовчуванням → сам ключ.
 */
function t(string $key): string
{
    $lang = current_lang();
    $entry = $GLOBALS['TRANSLATIONS'][$key] ?? null;

    if ($entry === null) {
        return $key;
    }

    return $entry[$lang] ?? $entry[LANG_DEFAULT] ?? $key;
}

/*
 * Перемикач мови.
 *
 * Посилання ведуть на поточну сторінку з ?lang=uk|en. Зберігаємо вибір
 * у сесію і, якщо вивід ще не почався, робимо чистий редірект назад на цю ж
 * сторінку без параметра lang (інші параметри зберігаються). Якщо заголовки
 * вже надіслані (translations.php підключено пізно, напр. із підвалу) —
 * просто зберігаємо вибір, він застосується з наступного завантаження.
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
