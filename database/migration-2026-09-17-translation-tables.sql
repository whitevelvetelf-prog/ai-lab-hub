-- =====================================================================
-- AI LAB HUB — міграція: масштабована архітектура перекладу
--
--   Причина: попередній підхід (колонки *_en у products / pricing_plans,
--   const LANGS у app/translations.php) хардкодив мову прямо в структурі —
--   додавання нової мови означало нову колонку в кожній таблиці.
--
--   Рішення: три мовонезалежні таблиці перекладів, ключовані
--   (сутність, поле, lang). uk — мова оригіналу, завжди читається напряму
--   з products / pricing_plans / app/translations.php, БЕЗ звернення до
--   цих таблиць. Для будь-якої іншої активної мови (зараз лише en):
--   пошук перекладу в таблиці → якщо нема — автопереклад через Google
--   Translation API і кешування (source='auto') → ручна вичитка в CRM
--   позначається source='manual' і більше не перезаписується автопере-
--   кладом. Список активних мов інтерфейсу — config/languages.php,
--   єдине місце, куди дописувати нову мову.
--
--   Колонки *_en у products / pricing_plans (міграції 2026-09-15/16)
--   лишаються в БД незайманими (ADD COLUMN назад не відкатуємо), але
--   код більше їх не читає й не пише — картка продукту (public/product.php)
--   і CRM (public/crm-add-product.php) переведені на product_translations /
--   pricing_plan_translations.
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL
--     (база вже обрана в інтерфейсі; рядок USE нижче лишити закоментованим).
--   * локально через CLI:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-17-translation-tables.sql
--
--   Безпечно повторно застосовувати: CREATE TABLE IF NOT EXISTS +
--   INSERT IGNORE (унікальний ключ (key_name, lang) не дає дублів).
--   Жодних DROP / DELETE / ALTER існуючих таблиць чи колонок.
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin на хостингу не потрібно

-- ---------------------------------------------------------------------
-- product_translations — переклад полів картки продукту
--   field_name: short_description | full_description | main_features | target_audience
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS product_translations (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_id      INT UNSIGNED NOT NULL,
    field_name      VARCHAR(50) NOT NULL,
    lang            VARCHAR(5) NOT NULL,
    translated_text MEDIUMTEXT NOT NULL,
    source          ENUM('auto', 'manual') NOT NULL DEFAULT 'auto',
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_product_field_lang (product_id, field_name, lang),
    CONSTRAINT fk_product_translations_product
        FOREIGN KEY (product_id) REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- pricing_plan_translations — переклад полів тарифного плану
--   field_name: plan_name | description
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pricing_plan_translations (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    plan_id         INT UNSIGNED NOT NULL,
    field_name      VARCHAR(50) NOT NULL,
    lang            VARCHAR(5) NOT NULL,
    translated_text MEDIUMTEXT NOT NULL,
    source          ENUM('auto', 'manual') NOT NULL DEFAULT 'auto',
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_plan_field_lang (plan_id, field_name, lang),
    CONSTRAINT fk_pricing_plan_translations_plan
        FOREIGN KEY (plan_id) REFERENCES pricing_plans (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- ui_translations — переклад статичних написів інтерфейсу
--   (те, що раніше жило лише в масиві app/translations.php).
--   key_name — ключ t(), той самий, що й у $GLOBALS['TRANSLATIONS'].
--   Немає FK — ключі не з БД, а з namespace викликів t() у коді.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ui_translations (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    key_name        VARCHAR(100) NOT NULL,
    lang            VARCHAR(5) NOT NULL,
    translated_text MEDIUMTEXT NOT NULL,
    source          ENUM('auto', 'manual') NOT NULL DEFAULT 'auto',
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_key_lang (key_name, lang)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Наповнення ui_translations готовими EN-перекладами, які вже існували
-- в app/translations.php (написані людиною, source='manual' — тобто
-- API Google Translate тут НЕ витрачається і надалі ці рядки не
-- будуть перезаписані автоперекладом).
-- ---------------------------------------------------------------------
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('nav_home', 'en', 'Home', 'manual'),
('nav_account', 'en', 'Account', 'manual'),
('nav_saved', 'en', 'My collection', 'manual'),
('nav_login', 'en', 'Log In', 'manual'),
('nav_assistant', 'en', 'Call Assistant', 'manual'),
('nav_assistant_short', 'en', 'Ask Eli', 'manual'),
('nav_menu', 'en', 'Menu', 'manual'),
('lang_switch', 'en', 'Interface language', 'manual'),
('title_home', 'en', 'AI LAB HUB — Home', 'manual'),
('hero_title', 'en', 'AI LAB HUB', 'manual'),
('hero_subtitle', 'en', 'Find an AI tool for any task', 'manual'),
('hero_image_alt', 'en', 'Flask — AI LAB HUB', 'manual'),
('directions_title', 'en', 'AI Directions', 'manual'),
('footer_blog', 'en', 'Blog', 'manual'),
('footer_about', 'en', 'About', 'manual'),
('footer_contacts', 'en', 'Contacts', 'manual'),
('footer_terms', 'en', 'Terms of Use', 'manual'),
('footer_privacy', 'en', 'Privacy Policy', 'manual'),
('footer_support', 'en', 'Support the Project', 'manual'),
('footer_social', 'en', 'Social media', 'manual'),
('title_blog', 'en', 'AI LAB HUB — Blog', 'manual'),
('blog_heading', 'en', 'Blog', 'manual'),
('blog_subtitle', 'en', 'AI tool comparisons and tips on choosing what fits you best.', 'manual'),
('blog_empty', 'en', 'No articles yet.', 'manual'),
('blog_back', 'en', '← Back to blog', 'manual'),
('blog_not_found', 'en', 'Article not found', 'manual'),
('blog_not_found_text', 'en', 'No article exists at this address, or it is not published yet.', 'manual'),
('title_eli', 'en', 'AI LAB HUB — Eli, AI Assistant', 'manual'),
('eli_title', 'en', 'Eli — your AI assistant', 'manual'),
('eli_subtitle', 'en', 'Describe your task — Eli will find the best AI tool', 'manual'),
('eli_video_alt', 'en', 'Eli video', 'manual'),
('eli_greeting', 'en', 'Hello! Tell me what task you need to solve, and I will find the right AI tool for you.', 'manual'),
('eli_input_placeholder', 'en', 'Describe your task…', 'manual'),
('eli_input_aria', 'en', 'Message', 'manual'),
('eli_send', 'en', 'Send', 'manual'),
('eli_tech_error', 'en', 'Sorry, I am experiencing technical difficulties right now. Please try again in a minute.', 'manual'),
('eli_thinking', 'en', 'Eli is thinking…', 'manual'),
('eli_step_label', 'en', 'Step', 'manual'),
('eli_recommend', 'en', 'Recommended', 'manual'),
('eli_default_reply', 'en', 'Here is what I found for you.', 'manual'),
('eli_new_chat', 'en', 'New chat', 'manual'),
('search_placeholder', 'en', 'Search AI tools…', 'manual'),
('search_clear_aria', 'en', 'Clear search', 'manual'),
('search_no_results', 'en', 'Nothing found', 'manual'),
('search_no_results_hint', 'en', 'Try a different search, or', 'manual'),
('search_ask_eli_link', 'en', 'ask Eli', 'manual'),
('search_view_all', 'en', 'View all results', 'manual'),
('search_results_heading', 'en', 'Search results: “%s”', 'manual'),
('catalog_default_title', 'en', 'AI Tools Catalog', 'manual'),
('catalog_subcategory_not_found', 'en', 'Subcategory not found', 'manual'),
('category_not_found', 'en', 'Category not found', 'manual'),
('category_not_found_text', 'en', 'No direction exists with this identifier.', 'manual'),
('category_empty', 'en', 'This direction has no subcategories yet.', 'manual'),
('back_to_direction', 'en', '← Back to direction', 'manual'),
('back_to_all_directions', 'en', '← All directions', 'manual'),
('catalog_empty', 'en', 'There are no published products in this section yet.', 'manual'),
('btn_details', 'en', 'Details', 'manual'),
('price_free', 'en', 'Free', 'manual'),
('price_from', 'en', 'From', 'manual'),
('unit_week', 'en', 'wk', 'manual'),
('unit_month', 'en', 'mo', 'manual'),
('unit_year', 'en', 'yr', 'manual'),
('unit_one_time', 'en', 'one-time', 'manual'),
('product_not_found', 'en', 'Product not found', 'manual'),
('product_not_found_text', 'en', 'No product exists with this identifier, or it is not published yet.', 'manual'),
('back_to_directions', 'en', 'Back to AI directions', 'manual'),
('back_to_eli', 'en', 'Back to Elya\'s picks', 'manual'),
('product_visit_site', 'en', 'Visit website', 'manual'),
('product_features_title', 'en', 'Key features', 'manual'),
('product_audience_title', 'en', 'Who it is for', 'manual'),
('product_plans_title', 'en', 'Pricing plans', 'manual'),
('product_plan_select', 'en', 'Choose', 'manual'),
('product_platform_label', 'en', 'Platform', 'manual'),
('product_skill_label', 'en', 'Skill level', 'manual'),
('platform_web', 'en', 'Web', 'manual'),
('platform_mobile', 'en', 'Mobile', 'manual'),
('platform_desktop', 'en', 'Desktop', 'manual'),
('skill_basic', 'en', 'Basic knowledge required', 'manual'),
('skill_course', 'en', 'Dedicated training required (course)', 'manual'),
('skill_none', 'en', 'No special knowledge required', 'manual'),
('account_title_guest', 'en', 'Your account', 'manual'),
('account_text_guest', 'en', 'Log in to save favorite products and get personal recommendations from Eli.', 'manual'),
('account_create', 'en', 'Create account', 'manual'),
('account_welcome_prefix', 'en', 'Welcome,', 'manual'),
('role_user', 'en', 'User', 'manual'),
('role_employee', 'en', 'Employee', 'manual'),
('role_admin', 'en', 'Administrator', 'manual'),
('account_saved_title', 'en', 'My collection', 'manual'),
('account_saved_empty_prefix', 'en', 'No saved products yet. Check out', 'manual'),
('account_directions_link', 'en', 'AI directions on the homepage', 'manual'),
('account_saved_count', 'en', 'Products in your collection: %d.', 'manual'),
('account_saved_open_link', 'en', 'Open “My collection”', 'manual'),
('title_saved', 'en', 'AI LAB HUB — My collection', 'manual'),
('saved_page_title', 'en', 'My collection', 'manual'),
('saved_empty_text', 'en', 'Your collection is empty. Save tools you like with the paw on a card —', 'manual'),
('saved_empty_link', 'en', 'go to the catalog', 'manual'),
('saved_btn_save', 'en', 'Save to collection', 'manual'),
('saved_btn_unsave', 'en', 'Remove from collection', 'manual'),
('saved_hint_guest', 'en', 'Log in to save', 'manual'),
('saved_error', 'en', 'Something went wrong. Try again.', 'manual'),
('account_stats_title', 'en', 'User statistics', 'manual'),
('stats_total_label', 'en', 'Total', 'manual'),
('stats_users_label', 'en', 'Users', 'manual'),
('stats_employees_label', 'en', 'Employees', 'manual'),
('stats_admins_label', 'en', 'Admins', 'manual'),
('stats_pending_label', 'en', 'Pending requests:', 'manual'),
('account_staff_employees_title', 'en', 'Employees', 'manual'),
('account_staff_admins_title', 'en', 'Administrators', 'manual'),
('account_role_since_prefix', 'en', '· role since', 'manual'),
('account_crm_access_prefix', 'en', 'CRM access:', 'manual'),
('account_crm_list_link', 'en', 'product list', 'manual'),
('account_crm_add_link', 'en', 'add a new AI product', 'manual'),
('account_logout', 'en', 'Log out', 'manual'),
('title_login', 'en', 'AI LAB HUB — Log In', 'manual'),
('login_heading', 'en', 'Log In', 'manual'),
('login_subtitle', 'en', 'Log in to access your account.', 'manual'),
('login_error_invalid', 'en', 'Invalid email or password', 'manual'),
('login_no_account', 'en', 'Don\'t have an account?', 'manual'),
('title_register', 'en', 'AI LAB HUB — Sign Up', 'manual'),
('register_heading', 'en', 'Sign Up', 'manual'),
('register_subtitle', 'en', 'Create an account to save products and get recommendations from Eli.', 'manual'),
('register_have_account', 'en', 'Already have an account?', 'manual'),
('action_register', 'en', 'Sign up', 'manual'),
('field_name', 'en', 'Name', 'manual'),
('field_password', 'en', 'Password', 'manual'),
('field_password_confirm', 'en', 'Confirm password', 'manual'),
('pw_show', 'en', 'Show', 'manual'),
('pw_hide', 'en', 'Hide', 'manual'),
('pw_show_aria', 'en', 'Show password', 'manual'),
('pw_hide_aria', 'en', 'Hide password', 'manual'),
('err_name_required', 'en', 'Please enter your name.', 'manual'),
('err_name_too_long', 'en', 'Name is too long (255 characters max).', 'manual'),
('err_email_required', 'en', 'Please enter your email.', 'manual'),
('err_email_invalid', 'en', 'Invalid email.', 'manual'),
('err_password_short', 'en', 'Password must be at least 8 characters long.', 'manual'),
('err_password_mismatch', 'en', 'Passwords do not match.', 'manual'),
('err_email_taken', 'en', 'A user with this email is already registered.', 'manual'),
('err_register_failed', 'en', 'Could not create account. Please try again.', 'manual'),
('forgot_password_link', 'en', 'Forgot password?', 'manual'),
('title_forgot_password', 'en', 'AI LAB HUB — Forgot Password', 'manual'),
('forgot_heading', 'en', 'Forgot password?', 'manual'),
('forgot_subtitle', 'en', 'Enter your email — we’ll send you a link to log in without a password.', 'manual'),
('forgot_submit', 'en', 'Send login link', 'manual'),
('forgot_success', 'en', 'If this email is registered, a login link has been sent to it.', 'manual'),
('forgot_success_hint', 'en', 'Don\'t see the email after a few minutes — check your Spam folder.', 'manual'),
('forgot_back_login', 'en', '← Back to login', 'manual'),
('mail_login_subject', 'en', 'Log in to AI LAB HUB', 'manual'),
('mail_login_greeting', 'en', 'Hello, %s!', 'manual'),
('mail_login_intro', 'en', 'You (or someone on your behalf) requested passwordless login to AI LAB HUB. Click the button below to log in:', 'manual'),
('mail_login_button', 'en', 'Log in to your account', 'manual'),
('mail_login_fallback', 'en', 'If the button doesn\'t work, copy this link into your browser:', 'manual'),
('mail_login_expiry', 'en', 'This link is valid for %d minutes and works only once. If you didn\'t request this, just ignore this email.', 'manual'),
('token_invalid_title', 'en', 'Link is invalid', 'manual'),
('token_invalid_text', 'en', 'This login link is expired, already used, or invalid.', 'manual'),
('token_invalid_retry', 'en', 'Request a new link', 'manual'),
('flash_request_not_found', 'en', 'Request not found or already processed.', 'manual'),
('flash_request_approved', 'en', 'Request approved. The employee was assigned number #%d.', 'manual'),
('flash_request_approve_failed', 'en', 'Could not approve the request. Please try again.', 'manual'),
('title_apply_admin', 'en', 'AI LAB HUB — Admin Request', 'manual'),
('apply_admin_heading', 'en', 'Administrator Role Request', 'manual'),
('apply_admin_confirm_text', 'en', 'Submit a request for the Administrator role', 'manual'),
('apply_admin_submit', 'en', 'Submit request', 'manual'),
('apply_admin_already_admin', 'en', 'You already have the Administrator role.', 'manual'),
('apply_admin_pending_prefix', 'en', 'Your request is under review (submitted', 'manual'),
('apply_admin_pending_suffix', 'en', '). Please wait for a decision.', 'manual'),
('apply_admin_approved_text', 'en', 'Your request has already been approved.', 'manual'),
('apply_admin_back_account', 'en', 'Back to account', 'manual'),
('account_admin_requests_title', 'en', 'Administrator role requests', 'manual'),
('account_admin_requests_empty', 'en', 'No pending requests.', 'manual'),
('account_requested_prefix', 'en', '· submitted', 'manual'),
('action_approve', 'en', 'Approve', 'manual'),
('action_reject', 'en', 'Reject', 'manual'),
('flash_admin_request_approved', 'en', 'Administrator request approved. The user was granted the Administrator role.', 'manual'),
('flash_admin_request_rejected', 'en', 'Request rejected.', 'manual'),
('flash_admin_request_failed', 'en', 'Could not process the request. Please try again.', 'manual'),
('title_apply_ceo', 'en', 'AI LAB HUB — CEO Position Request', 'manual'),
('title_apply_exec', 'en', 'AI LAB HUB — Executive Director Position Request', 'manual'),
('apply_ceo_heading', 'en', 'CEO Position Request', 'manual'),
('apply_exec_heading', 'en', 'Executive Director Position Request', 'manual'),
('apply_director_intro', 'en', 'Fill in your contact details. The project owner decides personally.', 'manual'),
('apply_director_first_name', 'en', 'First name', 'manual'),
('apply_director_last_name', 'en', 'Last name', 'manual'),
('apply_director_phone', 'en', 'Phone', 'manual'),
('apply_director_email', 'en', 'Email', 'manual'),
('apply_director_email_hint', 'en', 'Must match your account email.', 'manual'),
('apply_director_submit', 'en', 'Submit request', 'manual'),
('apply_director_back_account', 'en', 'Back to account', 'manual'),
('apply_director_err_required', 'en', 'Fill in all fields.', 'manual'),
('apply_director_err_email_invalid', 'en', 'Invalid email.', 'manual'),
('apply_director_err_email_match', 'en', 'The email must match your account email.', 'manual'),
('apply_director_err_too_long', 'en', 'One of the fields is too long.', 'manual'),
('apply_director_pending', 'en', 'Your request for this position has already been submitted. Please wait for a decision.', 'manual'),
('apply_director_approved', 'en', 'Your request for this position has already been approved.', 'manual'),
('account_admin_request_role_label', 'en', 'Administrator role', 'manual'),
('account_admin_request_owner_only_note', 'en', 'Approved by the project owner', 'manual'),
('account_admin_position_full_note', 'en', 'All slots for this position are filled', 'manual'),
('flash_admin_request_owner_only', 'en', 'Only the project owner can approve this request.', 'manual'),
('flash_admin_position_taken', 'en', 'No open slots for the position "%s". The request was left pending.', 'manual'),
('flash_admin_director_approved', 'en', 'Request approved. The candidate was granted CRM access and the position "%s".', 'manual'),
('account_create_position_link_title', 'en', 'Create application link', 'manual'),
('position_title_field', 'en', 'Position title', 'manual'),
('err_position_title_required', 'en', 'Please enter a position title.', 'manual'),
('create_position_link_submit', 'en', 'Create link', 'manual'),
('flash_position_link_created', 'en', 'Link created: %s', 'manual'),
('account_position_apps_title', 'en', 'Position applications', 'manual'),
('account_position_apps_empty', 'en', 'No active applications.', 'manual'),
('position_apps_col_position', 'en', 'Position', 'manual'),
('position_apps_col_candidate', 'en', 'Candidate', 'manual'),
('position_apps_col_status', 'en', 'Status', 'manual'),
('position_apps_col_submitted', 'en', 'Submitted', 'manual'),
('position_apps_status_pending', 'en', 'Awaiting submission', 'manual'),
('position_apps_status_submitted', 'en', 'Under review', 'manual'),
('position_apps_status_confirmed', 'en', 'Confirmed', 'manual'),
('action_confirm_application', 'en', 'Confirm', 'manual'),
('flash_position_app_confirmed', 'en', 'Application confirmed. The user was granted the position "%s" and the Administrator role.', 'manual'),
('flash_position_app_no_user', 'en', 'Could not confirm: no account found for email "%s". The candidate must register before applying.', 'manual'),
('title_apply_position', 'en', 'AI LAB HUB — Position Application', 'manual'),
('apply_position_intro', 'en', 'Fill in your contact details to apply for this position.', 'manual'),
('apply_position_submit', 'en', 'Submit', 'manual'),
('apply_position_thanks_title', 'en', 'Thank you!', 'manual'),
('apply_position_thanks_text', 'en', 'Your application has been sent. We will contact you soon.', 'manual'),
('apply_position_no_account_error', 'en', 'No account found for this email. Please register on the site with this email first, then fill in the form again.', 'manual');
