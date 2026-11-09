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

// Сесія стартує в auth.php (з безпечними параметрами кукі: HttpOnly, SameSite=Lax) — щоб кукі не створювалась без них,
// якщо цей файл підключено раніше за auth.php.
require_once __DIR__ . '/auth.php';

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
    'nav_assistant' => 'Виклик Асистента',
    // Короткий підпис кнопки асистента для вузьких екранів (додається через CSS ::after).
    'nav_assistant_short' => 'Виклик Асистента',
    'nav_menu'      => 'Меню',
    // Видимий підпис кнопки-перемикача мобільного меню (замість іконки «три риски»).
    'nav_menu_toggle' => 'Меню',
    // Мобільна шапка (≤ 768px): підпис кнопки Елі; на найвужчих (< 340px) — «Еля».
    'nav_eli_ask'   => 'Спитати Елю',
    'nav_eli_tiny'  => 'Еля',
    'lang_switch'   => 'Мова інтерфейсу',

    // --- Кнопка «Додаток» (встановлення PWA, assets/js/pwa-install.js) ---
    'pwa_app_button' => 'Додаток',
    'pwa_app_aria'   => 'Встановити застосунок AI LAB HUB',
    'pwa_ios_hint'   => 'Щоб встановити AI LAB HUB як застосунок: у Safari натисніть «Поділитися», потім «На початковий екран».',
    'pwa_menu_label' => 'Встановити додаток',
    'pwa_other_hint' => 'Щоб встановити AI LAB HUB як застосунок: відкрийте меню браузера (⋮ або ☰) і виберіть «Встановити застосунок» або «Додати на головний екран».',
    'pwa_ios_ok'     => 'Зрозуміло',
    'pwa_close'      => 'Закрити',

    // --- Marketplace (публічна частина: marketplace.php, marketplace-offer.php, get.php) ---
    'nav_marketplace'            => 'Marketplace',
    // Сторінка «Скоро», поки Marketplace приховано перемикачем (app/marketplace.php: mp_coming_soon())
    'mp_soon_title'              => 'Marketplace скоро відкриється',
    'mp_soon_text'               => 'Ми готуємо розділ готових AI-рішень та оголошень. Поки що скористайтеся каталогом AI-інструментів або запитайте асистентку Елю.',
    'mp_soon_contact'            => 'Хочете розмістити своє рішення чи рекламу? Напишіть нам:',
    'mp_soon_catalog'            => 'До каталогу',
    'mp_soon_advertise'          => 'Реклама на сайті',
    // Перемикач у кабінеті адміна (account.php → CRM)
    'account_outbound_link'      => 'Переходи на сайти продуктів →',
    'account_summary_link'       => 'Зведення для медіакіту →',
    'mp_switch_title'            => 'Marketplace для відвідувачів',
    'mp_switch_on'               => 'показується',
    'mp_switch_off'              => 'приховано — прямі адреси показують сторінку «Скоро»',
    'mp_switch_show'             => 'Показати відвідувачам',
    'mp_switch_hide'             => 'Приховати',
    'mp_switch_note'             => 'Поки приховано: розділу немає в меню, підвалі, на головній і в рекламі, сторінки не індексуються. Співробітники бачать розділ як раніше.',
    'mp_switch_error'            => 'Не вдалося зберегти. Спробуйте ще раз.',
    'mp_switch_config_off'       => 'Розділ вимкнено в config/marketplace.php (public_enabled) — перемикач діятиме після його ввімкнення.',
    'footer_marketplace'         => 'Marketplace',
    'title_marketplace'          => 'AI LAB HUB — Marketplace',
    'mp_heading'                 => 'Marketplace',
    'mp_subtitle'                => 'Готові рішення: промпти, шаблони автоматизацій, гайди та скрипти — безкоштовно.',
    'mp_search_placeholder'      => 'Пошук за назвою…',
    'mp_search_btn'              => 'Знайти',
    'mp_search_reset'            => 'Скинути',
    'mp_all_categories'          => 'Усі',
    'mp_empty_search'            => 'За вашим запитом нічого не знайдено.',
    'mp_back'                    => '← До Marketplace',
    'mp_details'                 => 'Докладніше',
    'mp_get'                     => 'Отримати',
    'mp_license_label'           => 'Ліцензія',
    'mp_categories_label'        => 'Категорії',
    'mp_seller_label'            => 'Продавець',
    'mp_original_lang'           => 'Текст мовою оригіналу: %s',
    'mp_auto_translated'         => 'Текст оголошення перекладено автоматично.',
    'mp_solution_auto_translated' => 'Текст перекладено автоматично.',
    'mp_get_hint_file'           => 'Файл доступний зареєстрованим користувачам.',
    'mp_login_title'             => 'Потрібен вхід',
    'mp_login_text'              => 'Файли доступні лише зареєстрованим користувачам. Увійдіть або створіть акаунт, щоб отримати файл.',
    'mp_register'                => 'Зареєструватися',
    'mp_contact_title'           => 'Контакт для отримання',
    'mp_contact_text'            => 'Щоб отримати це рішення, скористайтеся контактом:',
    'mp_unavailable_title'       => 'Наразі недоступно',
    'mp_unavailable_text'        => 'Отримати цю пропозицію зараз неможливо. Спробуйте пізніше.',

    // --- Marketplace: дошка оголошень (етап 4; mpb_*) ---
    'mpb_subtitle'                   => 'Оголошення від користувачів: послуги, шаблони, навчання, робота. Платформа лише публікує оголошення.',
    'mpb_empty'                      => 'Активних оголошень поки немає. Станьте першим — подайте своє!',
    'mpb_post_btn'                   => 'Подати оголошення',
    'mpb_my_link'                    => 'Мої оголошення',
    // Єдина навігація розділу (app/mp-section-nav.php)
    'mp_nav_label'                   => 'Розділ Marketplace',
    'mp_nav_board'                   => 'Оголошення',
    'mp_nav_solutions'               => 'Готові AI-рішення',
    'mp_nav_rules'                   => 'Правила',
    'mp_solution_tag'                => 'Готове AI-рішення · AI LAB HUB',
    'mpb_found'                      => 'Знайдено оголошень: %d',
    'mpb_pages'                      => 'Сторінки',
    'mpb_disclaimer'                 => 'Платформа не бере участі в угоді між сторонами: не гарантує якість, оплату чи виконання домовленостей. Домовляйтеся напряму й перевіряйте партнера самостійно.',
    'mpb_f_search'                   => 'Пошук за назвою',
    'mpb_f_category'                 => 'Категорія',
    'mpb_f_price_type'               => 'Тип ціни',
    'mpb_f_price_range'              => 'Ціна',
    'mpb_from'                       => 'від',
    'mpb_to'                         => 'до',
    'mpb_f_sort'                     => 'Сортування',
    'mpb_sort_new'                   => 'Спочатку нові',
    'mpb_sort_cheap'                 => 'Спочатку дешевші',
    'mpb_sort_expensive'             => 'Спочатку дорожчі',
    'mpb_pt_none'                    => 'Не вказано',
    'mpb_pt_free'                    => 'Безкоштовно',
    'mpb_pt_fixed'                   => 'Вказана ціна',
    'mpb_pt_negotiable'              => 'Договірна',
    'mpb_pt_exchange'                => 'Обмін',
    'mpb_price_negotiable'           => 'Договірна',
    'mpb_price_exchange'             => 'Обмін',
    'mpb_remote'                     => 'дистанційно',
    // Marketplace: дерево категорій (EN — migration-2026-11-06-marketplace-ui-strings-tree.sql)
    'mpt_home_title'                 => 'Marketplace — вакансії, курси, послуги й готові AI-рішення',
    'mpt_home_desc'                  => 'Оголошення у сфері AI: вакансії, курси, послуги, готові рішення, обладнання. Оберіть розділ або скористайтеся пошуком.',
    'mpt_home_subtitle'              => 'Вакансії, навчання, послуги й готові рішення у сфері AI. Оберіть розділ.',
    'mpt_blocks_title'               => 'Розділи',
    'mpt_fresh'                      => 'Свіжі оголошення',
    'mpt_free_solutions'             => 'Безкоштовні рішення',
    'mpt_crumbs'                     => 'Навігаційний ланцюжок',
    'mpt_subcategories'              => 'Підкатегорії',
    'mpt_subcategory'                => 'Підкатегорія',
    'mpt_all_subcategories'          => 'Усі підкатегорії',
    'mpt_empty_block'                => 'Оголошень поки немає. Станьте першим',
    'mpt_empty_sub'                  => 'У цій категорії поки немає оголошень.',
    'mpt_search_in'                  => 'Пошук у розділі «%s»…',
    'mpt_search_title'               => 'Пошук оголошень',
    'mpt_search_title_q'             => 'Пошук: %s',
    'mpt_page_n'                     => 'сторінка %d',
    'mpt_block_desc'                 => '%1$s на Marketplace AI LAB HUB: %2$d оголошень. Оберіть підкатегорію або скористайтеся пошуком.',
    'mpt_sub_desc'                   => '%1$s (%3$s) на Marketplace AI LAB HUB: %2$d оголошень. Фільтри за форматом, містом і ціною.',
    'mpt_fmt_online'                 => 'Онлайн / віддалено',
    'mpt_fmt_offline'                => 'На місці',
    'mpt_from_platform'              => 'Від AI LAB HUB',
    'mpt_from_author'                => 'Від автора',
    'mpt_pick_block'                 => 'Оберіть розділ, у якому розмістити оголошення.',
    'mpt_block_label'                => 'Розділ',
    'mpt_change_block'               => 'Змінити розділ',
    'mpt_optional'                   => 'необов’язково',
    // Marketplace, етап 6: географія, розширений пошук, налаштування (EN — migration-2026-11-03-marketplace-ui-strings-geo.sql)
    'mpg_where_title'                => 'Де надається',
    'mpg_where_hint'                 => 'Не залежить від мови сайту чи мови тексту оголошення.',
    'mpg_fmt_online'                 => 'Онлайн',
    'mpg_fmt_offline'                => 'Офлайн',
    'mpg_fmt_hybrid'                 => 'Змішано',
    'mpg_fmt_any'                    => 'Будь-який формат',
    'mpg_only_online'                => 'Лише онлайн',
    'mpg_only_offline'               => 'Лише офлайн',
    'mpg_only_hybrid'                => 'Лише змішано',
    'mpg_scope_title'                => 'Охоплення',
    'mpg_scope_worldwide'            => 'Увесь світ',
    'mpg_scope_countries'            => 'Вибрані країни',
    'mpg_scope_local'                => 'Це місто з околицями',
    'mpg_scope_country'              => 'Вся країна',
    'mpg_country_n'                  => 'Країна %d',
    'mpg_country_none'               => '— країна —',
    'mpg_city_label'                 => 'Місто',
    'mpg_radius_label'               => 'Радіус',
    'mpg_radius_city_only'           => 'Лише місто',
    'mpg_extra_title'                => 'Додаткові місця (до %d): міста або країни',
    'mpg_extra_n'                    => 'Додаткове місце %d',
    'mpg_also'                       => 'також:',
    'mpg_ph_city'                    => 'Почніть вводити назву міста',
    'mpg_ph_country'                 => 'Почніть вводити назву країни',
    'mpg_err_city'                   => 'Для офлайн і змішаного формату виберіть місто з підказки.',
    'mpg_err_countries'              => 'Виберіть хоча б одну країну або «Увесь світ».',
    'mpg_err_extra_max'              => 'Додаткових місць може бути не більше п’яти.',
    'mpg_f_place'                    => 'Місто',
    'mpg_f_radius'                   => 'Радіус',
    'mpg_f_country'                  => 'Країна',
    'mpg_f_format'                   => 'Формат',
    'mpg_f_price_usd'                => 'Ціна, USD',
    'mpg_f_listing_lang'             => 'Мова оголошення',
    'mpg_f_listing_langs'            => 'Мови оголошень',
    'mpg_f_with_photos'              => 'Лише з фото',
    'mpg_f_verified'                 => 'Лише перевірені продавці',
    'mpg_f_units'                    => 'Одиниці',
    'mpg_f_show_online'              => 'Показувати онлайн-оголошення разом із місцевими',
    'mpg_any_lang'                   => 'Будь-яка',
    'mpg_lang_uk'                    => 'Українська',
    'mpg_lang_en'                    => 'Англійська',
    'mpg_anywhere'                   => 'Будь-де',
    'mpg_more_filters'               => 'Більше фільтрів',
    'mpg_sort_distance'              => 'Найближчі',
    'mpg_unit_km'                    => 'км',
    'mpg_unit_mi'                    => 'мі',
    'mpg_near_btn'                   => 'Поблизу',
    'mpg_near_wait'                  => 'Визначаємо місто…',
    'mpg_near_fail'                  => 'Не вдалося визначити місто — виберіть його зі списку.',
    'mpg_near_denied'                => 'Доступ до геолокації не надано.',
    'mpg_near_hint'                  => '«Поблизу» питає геолокацію браузера лише після натискання; координати не зберігаються — лише найближче місто.',
    'mpg_using_saved'                => 'Показано для вашого місця: %s.',
    'mpg_remember_btn'               => 'Запам’ятати «%s»',
    'mpg_settings_link'              => 'Налаштування місця',
    'mpg_settings_title'             => 'Налаштування пошуку',
    'mpg_settings_note'              => 'Ці налаштування підставляються в пошук Marketplace, коли ви не вибрали місце явно.',
    'mpg_settings_guest_note'        => 'Без входу зберігається лише місто — у файлі cookie на цьому пристрої (рік). Увійдіть, щоб зберегти більше налаштувань.',
    'mpg_country_hint'               => 'Якщо місто не вибрано — пошук у межах країни.',
    'mpg_langs_hint'                 => 'Нічого не вибрано — оголошення будь-якою мовою.',
    'mpg_save_btn'                   => 'Зберегти',
    'mpg_forget_btn'                 => 'Забути місце',
    'mpg_back_to_search'             => 'До пошуку',
    'mpg_settings_saved'             => 'Налаштування збережено.',
    'mpg_settings_forgot'            => 'Збережене місце видалено.',
    'mpb_views'                      => 'Переглядів',
    'mpb_published_label'            => 'Опубліковано',
    'mpb_photo_n'                    => 'Фото %d',
    'mpb_preview_banner'             => 'Це перегляд: оголошення не опубліковане. Статус:',
    'mpb_own_note'                   => 'Це ваше оголошення.',
    'mpb_seller_other'               => 'Інші оголошення продавця',
    'mpb_contact_btn'                => 'Показати контакт',
    'mpb_contact_title'              => 'Контакти продавця',
    'mpb_contact_name'               => 'Ім\'я',
    'mpb_contact_phone'              => 'Телефон',
    'mpb_contact_login'              => 'Щоб побачити контакти, увійдіть в акаунт або зареєструйтеся.',
    'mpb_contact_limit'              => 'Ліміт розкриття контактів вичерпано (%d за добу). Спробуйте завтра.',
    'mpb_contact_notfound'           => 'Оголошення недоступне.',
    'mpb_contact_error'              => 'Не вдалося отримати контакти. Спробуйте ще раз.',
    'mpb_fav_add'                    => 'У вибране',
    'mpb_fav_remove'                 => 'Прибрати з вибраного',
    'mpb_fav_login'                  => 'У вибране (потрібен вхід)',
    'mpb_fav_title'                  => 'Вибране',
    'mpb_fav_empty'                  => 'У вибраному поки нічого немає.',
    'mpb_fav_added'                  => 'Додано у вибране.',
    'mpb_fav_removed'                => 'Прибрано з вибраного.',
    'mpb_fav_unavailable'            => 'Це оголошення недоступне для додавання у вибране.',
    'mpb_report_btn'                 => 'Поскаржитись',
    'mpb_report_reason'              => 'Причина',
    'mpb_report_note'                => 'Коментар (необов\'язково)',
    'mpb_report_send'                => 'Надіслати скаргу',
    'mpb_report_login'               => 'Щоб поскаржитись, увійдіть в акаунт.',
    'mpb_report_ok'                  => 'Дякуємо, скаргу прийнято. Модератори її розглянуть.',
    'mpb_report_duplicate'           => 'Ви вже скаржилися на це оголошення.',
    'mpb_report_own'                 => 'Не можна скаржитись на власне оголошення.',
    'mpb_report_invalid'             => 'Оберіть причину скарги.',
    'mpb_report_notfound'            => 'Оголошення недоступне.',
    'mpb_reason_fraud'               => 'Шахрайство',
    'mpb_reason_prohibited'          => 'Заборонений товар чи послуга',
    'mpb_reason_spam'                => 'Спам',
    'mpb_reason_wrong_category'      => 'Неправильна категорія',
    'mpb_reason_other'               => 'Інше',
    'mpb_login_title'                => 'Потрібен вхід',
    'mpb_login_text'                 => 'Ця дія доступна лише зареєстрованим користувачам. Увійдіть або створіть акаунт.',
    'mpb_post_title'                 => 'Нове оголошення',
    'mpb_edit_title'                 => 'Редагування оголошення',
    'mpb_post_note'                  => 'Після збереження оголошення потрапить на модерацію й з\'явиться на дошці після схвалення. Термін показу — 30 днів.',
    'mpb_post_note_staff'            => 'Ви публікуєте як співробітник — оголошення з\'явиться на дошці одразу, без модерації.',
    'mpb_f_title'                    => 'Назва',
    'mpb_f_short'                    => 'Короткий опис',
    'mpb_f_short_hint'               => '10–500 символів. Показується в списку.',
    'mpb_f_full'                     => 'Повний опис',
    'mpb_f_full_hint'                => 'До 5000 символів. Не більше %d посилань у всіх описах разом.',
    'mpb_f_categories'               => 'Категорії',
    'mpb_f_categories_hint'          => 'Оберіть від 1 до 3.',
    'mpb_f_price_amount'             => 'Сума',
    'mpb_f_currency'                 => 'Валюта',
    'mpb_f_price_hint'               => 'Це ціна між вами й покупцем. Платформа грошей не бере.',
    'mpb_f_city'                     => 'Місто',
    'mpb_f_remote'                   => 'Дистанційно',
    'mpb_f_contacts'                 => 'Контакти',
    'mpb_f_contacts_hint'            => 'Потрібен хоча б один: телефон, Telegram або email. Показуються лише після кліку «Показати контакт» зареєстрованому користувачу.',
    'mpb_f_photos'                   => 'Фото (до %d)',
    'mpb_f_photos_hint'              => 'JPG, PNG або WEBP, до %d МБ кожне. Перше фото — обкладинка.',
    'mpb_photo_order'                => 'Порядок',
    'mpb_photo_cover'                => 'Зробити обкладинкою',
    'mpb_photo_delete'               => 'Видалити',
    'mpb_submit_new'                 => 'Подати на модерацію',
    'mpb_submit_save'                => 'Зберегти зміни',
    'mpb_cancel'                     => 'Скасувати',
    'mpb_saved_pending'              => 'Оголошення збережено й надіслано на модерацію.',
    'mpb_saved_published'            => 'Оголошення збережено й опубліковано.',
    'mpb_err_csrf_title'             => 'Сесія застаріла',
    'mpb_err_csrf'                   => 'Сесія застаріла або запит некоректний. Оновіть сторінку й спробуйте ще раз.',
    'mpb_err_generic_title'          => 'Помилка',
    'mpb_err_spam'                   => 'Запит схожий на автоматичний. Якщо це помилка — спробуйте ще раз.',
    'mpb_err_post_too_big'           => 'Файли завеликі для одного запиту. Зменшіть розмір або кількість фото.',
    'mpb_err_title'                  => 'Назва: від 3 до 200 символів.',
    'mpb_err_short'                  => 'Короткий опис: від 10 до 500 символів.',
    'mpb_err_full'                   => 'Повний опис: не більше 5000 символів.',
    'mpb_err_categories'             => 'Оберіть від 1 до 3 категорій.',
    'mpb_err_price_type'             => 'Оберіть тип ціни.',
    'mpb_err_price_amount'           => 'Вкажіть суму більше нуля (число, до двох знаків після коми).',
    'mpb_err_location'               => 'Вкажіть місто або позначте «Дистанційно».',
    'mpb_err_city_long'              => 'Місто: не більше 120 символів.',
    'mpb_err_contact_required'       => 'Вкажіть хоча б один контакт: телефон, Telegram або email.',
    'mpb_err_phone'                  => 'Телефон вказано некоректно.',
    'mpb_err_telegram'               => 'Telegram: 5–32 символи (літери, цифри, підкреслення), напр. @username.',
    'mpb_err_email'                  => 'Email вказано некоректно.',
    'mpb_err_rules'                  => 'Потрібно погодитись із Правилами розміщення оголошень.',
    'mpb_rate_limited'               => 'Забагато запитів, спробуйте пізніше.',
    'mpb_posting_closed'             => 'Подача оголошень відкриється згодом.',
    'mpb_posting_closed_title'       => 'Подача оголошень',
    'mpb_posting_staff_login'        => 'Співробітникам:',
    'mpb_err_links'                  => 'В описах може бути не більше %d посилань.',
    'mpb_err_stopword'               => 'Текст містить заборонені слова. Відредагуйте його.',
    'mpb_err_photo_count'            => 'Фото може бути не більше %d.',
    'mpb_err_photo_size'             => 'Одне з фото завелике.',
    'mpb_err_photo_type'             => 'Дозволені лише справжні зображення JPG, PNG або WEBP.',
    'mpb_err_photo_upload'           => 'Не вдалося завантажити одне з фото. Спробуйте ще раз.',
    'mpb_err_photo_process'          => 'Не вдалося обробити одне з фото. Спробуйте інший файл.',
    'mpb_err_limit_active'           => 'Ліміт активних оголошень (на модерації + опубліковані): %d. Заархівуйте зайві.',
    'mpb_err_limit_day'              => 'Ліміт нових оголошень: %d за добу. Спробуйте завтра.',
    'mpb_err_duplicate'              => 'У вас уже є оголошення з такою назвою.',
    'mpb_err_save'                   => 'Не вдалося зберегти оголошення. Спробуйте пізніше.',
    'mpb_my_title'                   => 'Мої оголошення',
    'mpb_my_empty'                   => 'У цій вкладці оголошень немає.',
    'mpb_tab_pending'                => 'На модерації',
    'mpb_tab_active'                 => 'Активні',
    'mpb_tab_finished'               => 'Завершені',
    'mpb_tab_rejected'               => 'Відхилені',
    'mpb_st_pending'                 => 'На модерації',
    'mpb_st_published'               => 'Опубліковано',
    'mpb_st_rejected'                => 'Відхилено',
    'mpb_st_archived'                => 'В архіві',
    'mpb_st_expired'                 => 'Термін минув',
    'mpb_until'                      => 'діє до',
    'mpb_ended'                      => 'діяло до',
    'mpb_reject_reason'              => 'Причина відхилення',
    'mpb_edit_btn'                   => 'Редагувати',
    'mpb_extend_btn'                 => 'Продовжити (+30 днів)',
    'mpb_archive_btn'                => 'Архівувати',
    'mpb_extended'                   => 'Термін продовжено.',
    'mpb_archived'                   => 'Оголошення заархівовано.',
    'mpb_err_archive'                => 'Не вдалося заархівувати оголошення.',
    'mpb_err_extend_early'           => 'Продовжити можна, коли до кінця терміну лишається не більше 30 днів.',
    'mpb_err_extend_status'          => 'Це оголошення не можна продовжити.',

    // --- Marketplace: підтвердження email (етап 5; mpv_*) ---
    'mpv_title'                      => 'Підтвердження email',
    'mpv_block_title'                => 'Підтвердьте email',
    'mpv_block_text'                 => 'Щоб подавати й редагувати оголошення, показувати контакти та скаржитися, підтвердьте свій email. Ми надішлемо лист із посиланням.',
    'mpv_send_btn'                   => 'Надіслати лист із посиланням',
    'mpv_contact_block'              => 'Щоб побачити контакти, підтвердьте email.',
    'mpv_page_text'                  => 'Лист надійде на адресу вашого акаунта: %s.',
    'mpv_sent'                       => 'Лист надіслано. Посилання діє %d год. Перевірте пошту (і папку «Спам»).',
    'mpv_too_soon'                   => 'Лист уже надсилали нещодавно. Зачекайте %d хв і спробуйте ще раз.',
    'mpv_daily'                      => 'Ліміт листів вичерпано (%d на добу). Спробуйте завтра.',
    'mpv_already'                    => 'Ваш email уже підтверджено.',
    'mpv_fail'                       => 'Не вдалося надіслати лист. Спробуйте пізніше.',
    'mpv_ok_title'                   => 'Email підтверджено',
    'mpv_fail_title'                 => 'Не вдалося підтвердити',
    'mpv_ok'                         => 'Дякуємо! Email підтверджено — тепер можна подавати оголошення, показувати контакти та скаржитися.',
    'mpv_expired'                    => 'Термін дії посилання минув. Надішліть новий лист.',
    'mpv_used'                       => 'Це посилання вже використано. Якщо email ще не підтверджено — надішліть новий лист.',
    'mpv_changed'                    => 'Email в акаунті змінено, тож це посилання недійсне. Надішліть новий лист.',
    'mpv_invalid'                    => 'Посилання недійсне. Надішліть новий лист.',
    'mpv_mail_subject'               => 'Підтвердіть email — AI LAB HUB Marketplace',
    'mpv_mail_intro'                 => 'Щоб користуватися Marketplace, підтвердьте свій email за посиланням:',
    'mpv_mail_button'                => 'Підтвердити email',
    'mpv_mail_expiry'                => 'Посилання діє %d год і працює один раз.',
    'mpv_mail_ignore'                => 'Якщо ви цього не робили — просто проігноруйте лист.',
    'mpv_confirm_title'              => 'Підтвердження email',
    'mpv_confirm_text'               => 'Натисніть кнопку, щоб підтвердити email і користуватися Marketplace.',
    'mpv_confirm_btn'                => 'Підтвердити email',
    'mpb_f_rules_link'               => 'Правила розміщення оголошень',
    'mpb_rules_uk_only'              => 'Правила доступні українською мовою.',

    // --- index.php: hero + напрямки ---
    'title_home'        => 'AI LAB HUB — Головна',
    'hero_title'        => 'AI LAB HUB',
    'hero_subtitle'     => 'Знайдіть AI-інструмент для будь-якого завдання',
    'home_free_solutions_btn' => 'Безкоштовні AI-рішення',
    // Примітка-застереження чутливої підкатегорії (app/subcategory-note.php)
    'subcat_note_mental_health_eating' => "Інструменти в цій підкатегорії не замінюють лікування. Якщо ви підозрюєте розлад харчової поведінки чи іншу проблему психічного здоров'я у себе або близької людини, зверніться до лікаря чи психотерапевта.",
    'subcat_note_parenting' => 'Застосунки не замінюють консультацію педіатра, психолога чи іншого фахівця. Перш ніж вводити дані про дитину, перегляньте політику приватності сервісу.',
    'subcat_note_dog_training' => 'Методи дресирування різняться. Обирайте методи без болю й страху. Складні проблеми з поведінкою краще обговорити з кінологом чи ветеринаром.',
    'subcat_note_working_dogs' => 'Це облікові й допоміжні інструменти. Вони не замінюють сертифікацію, кваліфікованого кінолога чи внутрішні правила вашої служби. Обережно поводьтеся з чутливими даними.',
    'subcat_note_digital_memory' => "Ці інструменти працюють із пам'яттю про померлих і можуть сильно впливати на емоційний стан. Вони не замінюють підтримку психолога чи близьких. Цифрові копії людей створюйте лише за згодою людини або з відомої вам її волі та з дотриманням закону. Якщо горе заважає вам жити чи з'являються думки про самоушкодження, зверніться до лікаря, психотерапевта чи екстрених служб у вашій країні.",
    'product_note_simulation' => 'Такий сервіс створює симуляцію: вона може говорити те, чого людина ніколи не казала. Платні моделі можуть залежати від існування компанії.',
    'hero_image_alt'    => 'Колба — AI LAB HUB',
    'directions_title'  => 'Напрямки AI',

    // --- Підвал ---
    'footer_blog'     => 'Блог',
    'footer_about'    => 'Про проєкт',
    'footer_contacts' => 'Контакти',
    'footer_terms'    => 'Умови використання',
    'footer_privacy'  => 'Політика конфіденційності',
    'footer_promo_rules' => 'Правила реклами',
    'footer_advertise' => 'Реклама на сайті',
    'footer_support'  => 'Підтримати проєкт',

    // --- blog.php / blog-post.php: блог ---
    'title_blog'         => 'AI LAB HUB — Блог',
    'blog_heading'        => 'Блог',
    'blog_subtitle'       => 'Порівняння AI-інструментів і поради, як обрати те, що підходить саме вам.',
    'blog_empty'          => 'Статей поки немає.',
    'blog_back'           => '← До блогу',
    'blog_not_found'      => 'Статтю не знайдено',
    'blog_not_found_text' => 'Статті з такою адресою не існує або вона ще не опублікована.',
    'blog_topics_label'   => 'Тематика статей',
    'blog_topic_all'      => 'Усі теми',
    'blog_topic_all_in_category' => 'Уся категорія',
    'blog_translation_pending' => 'Переклад цієї статті ще готується — поки що показуємо українську версію.',

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
    // Запасний режим і спокійні підказки (app/eli.php, api-eli-chat.php, eli.php)
    'eli_fallback_intro'      => 'Розумний підбір зараз недоступний, але ось що знайшлося за вашим запитом:',
    'eli_fallback_step'       => 'Знайдено в каталозі',
    'eli_fallback_none'       => 'Не знайшлося точного збігу. Ось розділи, де можна пошукати. Або спробуйте запитати ще раз трохи пізніше — розумний підбір зараз тимчасово недоступний.',
    'eli_fallback_links'      => 'Розділи, де можна пошукати',
    'eli_rate_limited'        => 'Зачекайте хвилину й спробуйте ще раз.',
    'eli_empty_message'       => 'Опишіть, будь ласка, свою задачу — і я підберу відповідний AI-інструмент.',
    'eli_catalog_empty'       => 'Наразі в каталозі немає опублікованих інструментів. Завітайте трохи згодом.',
    'eli_nothing_found'       => 'На жаль, серед наявних інструментів не знайшлося відповідного під цю задачу.',
    'eli_client_timeout'      => 'Відповідь затримується довше, ніж зазвичай. Спробуйте, будь ласка, ще раз.',
    'eli_client_network'      => 'Не вдалося зв\'язатися із сайтом. Перевірте з\'єднання й спробуйте ще раз.',

    // --- Пошук у шапці (app/footer.php + public/assets/js/site-search.js) ---
    'search_placeholder'   => 'Пошук AI-інструментів…',
    'search_clear_aria'    => 'Очистити пошук',
    // Мобільна шапка: іконка пошуку розкриває поле на всю ширину, стрілка — закриває.
    'search_open_aria'     => 'Відкрити пошук',
    'search_close_aria'    => 'Закрити пошук',
    'search_no_results'    => 'Нічого не знайдено',
    'search_no_results_hint' => 'Спробуйте інший запит або',
    'search_ask_eli_link'  => 'запитайте Елю',
    'search_view_all'      => 'Показати всі результати',
    'search_found'               => 'Знайдено: %d',
    'search_too_broad'           => 'Запит надто загальний, оберіть категорію',
    'search_broad_top'           => 'Найрелевантніші за назвою',
    'search_not_found_eli'       => 'Не знайшли? Запитайте Елю',
    'search_ask_eli_small'       => 'Спитати Елю',
    'search_matching_sections'   => 'Розділи, що відповідають запиту',
    'search_layout_note'         => 'Показано результати для «%s»',
    'search_page_prev'           => '← Попередня',
    'search_page_next'           => 'Наступна →',
    'search_page_of'             => 'Сторінка %1$d з %2$d',
    'search_rate_limited'        => 'Забагато пошукових запитів. Спробуйте пізніше.',
    'search_categories_title'    => 'Категорії',
    'search_results_heading' => 'Результати пошуку: «%s»',

    // --- catalog.php / category.php: спільні написи каталогу ---
    'catalog_default_title'        => 'Каталог AI-інструментів',
    'catalog_subcategory_not_found' => 'Підкатегорію не знайдено',
    'category_not_found'           => 'Категорію не знайдено',
    'category_not_found_text'      => 'Напрямок із таким ідентифікатором відсутній.',
    'category_empty'               => 'У цьому напрямку поки немає підкатегорій.',
    'category_others'              => 'Інші категорії',
    'back_to_direction'            => '← До напряму',
    'back_to_all_directions'       => '← Усі напрямки',
    'catalog_empty'                => 'У цьому розділі поки немає опублікованих продуктів.',
    'btn_details'                   => 'Докладніше',
    'price_free'                    => 'Безкоштовно',
    'price_from'                    => 'Від',
    'price_on_request'              => 'За запитом',
    'price_not_specified'           => 'Ціна не вказана',
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
    'product_related_articles_title' => 'Статті на цю тему',
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
    'account_crm_ads_link'       => 'реклама',
    'account_crm_donations_link' => 'донати',
    'account_crm_search_link' => 'Пошук: індекс, синоніми, запити без результатів',
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

    // --- вхід через соцмережі (app/oauth.php, auth-google*.php, account.php) ---
    'social_or_login'              => 'Або увійдіть через',
    'social_or_register'           => 'Або зареєструйтеся через',
    'social_soon'                  => 'Скоро',
    'social_error_generic'         => 'Не вдалося увійти через %s. Спробуйте ще раз.',
    'social_error_unverified'      => '%s не підтвердив цю адресу email, тому ми не можемо прив\'язати її до акаунта.',
    'social_error_taken'           => 'Цей акаунт %s уже прив\'язано до іншого користувача.',
    'social_error_disabled'        => 'Вхід через %s поки недоступний.',
    'account_social_title'         => 'Способи входу',
    'account_social_password'      => 'Пароль',
    'account_social_password_set'  => 'Встановлено',
    'account_social_password_none' => 'Не встановлено',
    'account_social_connected'     => 'Прив\'язано %s',
    'account_social_not_connected' => 'Не прив\'язано',
    'account_social_unlink'        => 'Відв\'язати',
    'account_social_link'          => 'Прив\'язати',
    'account_social_last_method'   => 'Це ваш єдиний спосіб входу — його не можна відв\'язати.',
    'account_social_email_hint'    => 'Також ви завжди можете увійти за посиланням на email («Забули пароль?»).',
    'account_social_linked_flash'  => '%s прив\'язано до акаунта.',
    'account_social_unlinked_flash' => '%s відв\'язано від акаунта.',
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

    // --- Спливаюче вікно реклами (public/assets/js/ad-popup.js) ---
    'ad_popup_skip_in'    => 'Пропустити через %d с',
    'ad_popup_skip'       => 'Пропустити',
    'ad_popup_skip_ready' => 'Рекламу можна пропустити',
    'ad_popup_replay'     => '↻ Переглянути ще раз',
    'ad_popup_dialog'     => 'Рекламне оголошення',

    // --- Тексти про рекламу в «Умовах», «Політиці конфіденційності» й «Про проєкт» (EN — ui_translations, manual) ---
    'legal_terms_ads_title' => '3.3. Реклама та рекламодавці',
    'legal_terms_ads_format' => 'На платформі розміщується реклама, позначена написом «Реклама». Вона показується у спливаючому вікні поверх сторінки: зображення або коротке відео, що стартує без звуку (звук відвідувач вмикає сам). Кнопка «Пропустити» стає доступною через 5 секунд. Вікно з’являється не раніше ніж через 5 хвилин на сайті й одному відвідувачу показується не частіше ніж раз на 10 хвилин; оголошення різних рекламодавців чергуються.',
    'legal_terms_ads_rules' => 'Розміщення реклами регулюється %s, які є невід\'ємною частиною цих Умов для рекламодавців. Рекламодавець самостійно відповідає за зміст реклами та сторінку, на яку вона веде; платформа має право відхилити або зупинити рекламу, що порушує Правила.',
    'legal_ads_rules_link' => 'Правилами розміщення реклами',
    'legal_privacy_ads_title' => '3.3. Вимірювання реклами',
    'legal_privacy_ads_counts' => 'Для обліку реклами ми рахуємо покази, перегляди відео, кліки й пропуски. Показ рахується, коли вікно з рекламою було видимим щонайменше 1 секунду. Покази, перегляди й пропуски зберігаються лише як знеособлені лічильники за днями (скільки разів показано кожне оголошення), без прив\'язки до відвідувача. Кліки зберігаються разом з анонімним ідентифікатором сеансу (хеш, з якого неможливо відновити IP-адресу чи особу) до 30 днів — для захисту від накрутки; далі лишається лише агрегована статистика. Відомих ботів не рахуємо.',
    'legal_privacy_ads_session' => 'Щоб показувати рекламне вікно не частіше ніж раз на 10 хвилин і не повторювати те саме оголошення, сайт зберігає час закриття вікна в localStorage вашого браузера, а в сесії (на сервері, лише на час відвідування) — час початку візиту, кількість переглянутих сторінок, час останнього показу й короткий список нещодавно показаних оголошень. Це не персональні дані, і для профілювання вони не використовуються; запис у localStorage можна видалити в налаштуваннях браузера.',
    'legal_privacy_ads_targeting' => 'IP-адреси у відкритому вигляді не зберігаються. Рекламодавцям доступна лише агрегована статистика (кількість показів, переглядів, кліків). Персонального таргетингу немає: реклама добирається лише за мовою сайту, типом пристрою й тематикою сторінки.',
    'cc_title'                           => 'Cookie на сайті',
    'cc_text'                            => 'Без вашої згоди працюють лише необхідні cookie: вхід, мова, обране місце в Marketplace. Відео з YouTube у рекламі (Google може зберігати свої cookie) вантажаться лише після «Прийняти всі» або натискання ▶.',
    'cc_more'                            => 'Детальніше',
    'cc_accept_all'                      => 'Прийняти всі',
    'cc_necessary'                       => 'Лише необхідні',
    'cc_settings'                        => 'Налаштування cookie',
    'cc_state_all'                       => 'Зараз обрано: прийнято всі.',
    'cc_state_necessary'                 => 'Зараз обрано: лише необхідні.',
    'cc_yt_note'                         => 'Відео з YouTube завантажиться після натискання ▶',
    'legal_privacy_cookies_title'        => '3.5. Cookie й локальне сховище',
    'legal_privacy_cookies_necessary'    => 'Необхідні (працюють без згоди): cookie сесії — вхід, мова інтерфейсу, частота показу реклами; alh_consent — ваш вибір щодо cookie (1 рік); mp_loc — місто для пошуку в Marketplace, лише якщо ви натиснули «Запам\'ятати» (1 рік, без координат). У localStorage браузера — час останнього рекламного вікна й налаштування звуку реклами; у sessionStorage — розмова з асистенткою Елею до закриття вкладки.',
    'legal_privacy_cookies_youtube'      => 'Зовнішні медіа (лише за згодою): відео з YouTube у рекламі вбудовуються з youtube-nocookie.com; після запуску YouTube (Google) може зберігати свої cookie чи дані в браузері. Без згоди ми показуємо мініатюру (зображення з сервера YouTube), а відео вантажиться лише після натискання ▶.',
    'legal_privacy_cookies_none'         => 'Аналітики, рекламних трекерів і cookie третіх сторін для стеження ми не використовуємо. Змінити вибір можна будь-коли посиланням «Налаштування cookie» внизу сторінки.',
    'about_ads_text' => 'На сайті є реклама: вона завжди позначена написом «Реклама» й показується у спливаючому вікні — зображення або коротке відео без звуку, з кнопкою «Пропустити» через 5 секунд, не раніше ніж через 5 хвилин на сайті й не частіше ніж раз на 10 хвилин. Оголошення різних рекламодавців чергуються. Розмістити свою рекламу можна самостійно в кабінеті — деталі на сторінці %s.',
    'about_ads_link' => '«Реклама на сайті»',

    // --- Сторінка донатів (public/donate.php, реквізити — site_settings, app/donations.php) ---
    'donate_page_title'    => 'Підтримати AI LAB HUB',
    'donate_intro'         => 'AI LAB HUB — незалежний каталог AI-інструментів. Якщо він вам корисний, ви можете підтримати проєкт добровільним внеском: це допомагає розвивати й наповнювати каталог.',
    'donate_thanks'        => 'Дякуємо за будь-яку підтримку!',
    'donate_soon'          => 'Скоро тут з’являться способи підтримати проєкт. Дякуємо, що зазирнули!',
    'donate_ua_title'      => 'Для донатів з України',
    'donate_intl_title'    => 'Для міжнародних переказів',
    'donate_jar_btn'       => 'Відкрити банку для донату',
    'donate_qr_hint'       => 'Або відскануйте QR-код камерою телефона',
    'donate_card'          => 'Номер картки',
    'donate_recipient'     => 'Отримувач',
    'donate_iban_uah'      => 'IBAN (гривня)',
    'donate_iban_usd'      => 'IBAN (долар США)',
    'donate_iban_eur'      => 'IBAN (євро)',
    'donate_swift'         => 'SWIFT / BIC',
    'donate_bank'          => 'Банк',
    'donate_purpose'       => 'Призначення платежу',
    'donate_purpose_default' => 'Добровільний внесок на розвиток AI LAB HUB',
    'donate_intl_note'     => 'Міжнародні перекази зазвичай надходять за кілька робочих днів, а банки-посередники можуть утримувати комісію.',
    'donate_copy'          => 'Скопіювати',
    'donate_copied'        => 'Скопійовано',
    'donate_copy_failed'   => 'Не вдалося скопіювати — виділіть текст і скопіюйте вручну',
    'donate_legal_note'    => 'Донат добровільний, не є оплатою послуг і поверненню не підлягає.',
    'donate_terms_link'    => 'Умови використання',

    // --- Кнопка «Підтримати проєкт» (головна, кабінет, меню) та історія донатів (app/donation-history.php) ---
    'support_cta_btn'       => 'Підтримати проєкт',
    'support_home_title'    => 'AI LAB HUB вам корисний?',
    'support_home_text'     => 'Каталог безкоштовний і незалежний. Добровільний донат допомагає додавати нові інструменти й тримати описи актуальними.',
    'support_account_title' => 'Дякуємо, що ви з нами!',
    'support_account_text'  => 'Якщо AI LAB HUB вам допомагає, ви можете підтримати його розвиток донатом будь-якого розміру.',
    'support_account_history_link' => 'Історія підтримки',
    'donhist_title'         => 'Мої підтримки проєкту',
    'donhist_empty'         => 'Тут поки немає донатів. Якщо вирішите підтримати AI LAB HUB, ваш донат з’явиться в цьому списку після того, як ми його підтвердимо. Дякуємо, що ви просто тут!',
    'donhist_note'          => 'Донати надходять через банк, тому з’являються тут після ручного підтвердження, зазвичай протягом кількох днів. Якщо ви задонатили, а запису немає, напишіть нам через «Контакти».',
    'donhist_col_date'      => 'Дата',
    'donhist_col_amount'    => 'Сума',
    'donhist_col_status'    => 'Статус',
    'donhist_col_method'    => 'Спосіб оплати',
    'donhist_paid'          => 'сплачено',
    'donhist_total'         => 'Усього отримано: %s',
    'donhist_prev'          => '← Новіші',
    'donhist_next'          => 'Старіші →',
    'donhist_page'          => 'Сторінка %1$d з %2$d',
    'donhist_status_received'  => 'Отримано',
    'donhist_status_pending'   => 'Очікується',
    'donhist_status_refunded'  => 'Повернено',
    'donhist_status_cancelled' => 'Скасовано',
    'donhist_method_jar'       => 'Банка monobank',
    'donhist_method_card'      => 'Переказ на картку',
    'donhist_method_iban_uah'  => 'Банківський переказ (гривня)',
    'donhist_method_iban_intl' => 'Міжнародний переказ',
    'donhist_method_other'     => 'Інше',

    // --- Відеореклама (app/promo.php, public/promo-serve.php → public/assets/js/sponsored.js) ---
    'promo_label'            => 'Реклама',
    'promo_sound_on'         => 'Увімкнути звук',
    'promo_sound_off'        => 'Вимкнути звук',
    'promo_play'             => 'Відтворити відео',
    'promo_report'           => 'Поскаржитись на рекламу',
    'promo_report_send'      => 'Надіслати скаргу',
    'promo_report_cancel'    => 'Скасувати',
    'promo_report_thanks'    => 'Дякуємо, скаргу надіслано.',
    'promo_reason_misleading'    => 'Оманлива або неправдива',
    'promo_reason_inappropriate' => 'Неприйнятний вміст',
    'promo_reason_scam'          => 'Шахрайство',
    'promo_reason_irrelevant'    => 'Не стосується теми',
    'promo_reason_other'         => 'Інше',
    'promo_cta_learn_more'   => 'Дізнатись більше',
    'promo_cta_try'          => 'Спробувати',
    'promo_cta_go'           => 'Перейти',
    'promo_cta_download'     => 'Завантажити',

    // --- Статистика сайту для admin (public/admin-stats.php, посилання в account.php) ---
    'account_site_stats_link' => 'Статистика сайту →',
    // Блок «Перегляди сайту» (app/site-stats.php) і рядок у кабінеті.
    'pv_block_title'        => 'Перегляди сайту',
    'pv_block_note'         => 'Перегляд — відкриття сторінки сайту (головна, каталог, категорії, картки продуктів, статті блогу); кабінет і адмінка не рахуються. Доба — за київським часом.',
    'pv_card_today'         => 'Сьогодні',
    'pv_card_week'          => 'Тиждень',
    'pv_card_month'         => 'Місяць',
    'pv_period_today'       => 'сьогодні, {date}',
    'pv_period_days'        => 'останні {n} днів, {from}–{to}',
    'pv_views'              => 'переглядів',
    'pv_sessions'           => 'унікальних сеансів',
    'pv_vs_yesterday'       => 'проти вчора на цю ж годину',
    'pv_vs_prev7'           => 'проти попередніх 7 днів',
    'pv_vs_prev30'          => 'проти попередніх 30 днів',
    'pv_no_compare'         => 'Порівняння з’явиться, коли буде повний попередній період',
    'pv_of_record'          => '{pct}% від рекорду',
    'pv_new_record'         => 'Новий рекорд',
    'pv_record_title'       => 'Рекорди за весь час',
    'pv_record_day'         => 'Найкращий день',
    'pv_record_week'        => 'Найкращий тиждень',
    'pv_record_month'       => 'Найкращий місяць',
    'pv_record_sessions'    => '{n} сеансів',
    'pv_few_data'           => 'даних поки мало',
    'pv_no_data'            => 'Даних ще немає',
    'pv_chart_title'        => 'Перегляди за останні 30 днів',
    'pv_chart_record'       => 'день рекорду',
    'pv_migration_needed'   => 'Застосуйте міграцію database/migration-2026-10-12-site-stats.sql.',
    'pv_settings_title'     => 'Налаштування статистики',
    'pv_exclude_staff'      => 'Не рахувати перегляди адмінів',
    'pv_exclude_staff_hint' => 'Перегляди залогінених адмінів і працівників не записуються. Давні перегляди адмінів, записані раніше, залишаються в статистиці.',
    'pv_save'               => 'Зберегти',
    'pv_saved'              => 'Збережено.',
    'pv_save_failed'        => 'Не вдалося зберегти. Сесія застаріла або немає таблиці site_settings.',
    'pv_account_today'      => 'Сьогодні',
    'pv_account_7d'         => '7 днів',
    'pv_account_30d'        => '30 днів',
    'pv_account_record'     => 'Рекорд дня',
    'pv_account_more'       => 'Докладніше',

    // --- Форма підписки на розсилку (app/footer.php + public/assets/js/newsletter-form.js) ---
    'newsletter_title'         => 'Дізнавайтесь про нові AI-інструменти першими',
    'newsletter_placeholder'   => 'Ваш email',
    'newsletter_submit'        => 'Підписатись',
    'newsletter_success'       => 'Дякуємо! Ви підписані на розсилку.',
    'newsletter_already'       => 'Ви вже підписані.',
    'newsletter_error_invalid' => 'Некоректний email.',
    'newsletter_error_generic' => 'Не вдалося підписатись. Спробуйте пізніше.',

    // --- Marketplace, Хвиля 1 (2026-11-09): фільтри, популярні запити, збережені пошуки, продавець, статистика, «Як ми використовуємо АІ».
    //     EN — database/migration-2026-11-09-marketplace-ui-strings-wave1.sql.
    'mpj_filters'            => 'Фільтри',
    'mpj_show_n'             => 'Показати результати: %d',
    'mpj_reset_all'          => 'Скинути все',
    'mpj_active_filters'     => 'Активні фільтри',
    'mpj_remove_filter'      => 'Прибрати фільтр «%s»',
    'mpj_f_employment'       => 'Тип зайнятості',
    'mpj_f_schedule'         => 'Графік',
    'mpj_f_experience'       => 'Досвід',
    'mpj_f_work_format'      => 'Формат роботи',
    'mpj_wf_offline'         => 'Офіс',
    'mpj_wf_online'          => 'Онлайн / віддалено',
    'mpj_wf_hybrid'          => 'Змішано',
    'mpj_f_salary_from'      => 'Зарплата від',
    'mpj_f_currency'         => 'Валюта',
    'mpj_f_period'           => 'Період',
    'mpj_cur_UAH'            => 'грн',
    'mpj_cur_USD'            => 'USD',
    'mpj_cur_EUR'            => 'EUR',
    'mpj_per_MONTH'          => 'за місяць',
    'mpj_per_HOUR'           => 'за годину',
    'mpj_per_PROJECT'        => 'за проєкт',
    'mpj_salary_hint'        => 'Порівнюються лише вакансії з тим самим періодом; суми перераховуються за курсом НБУ. Вакансії без зарплати в цей фільтр не потрапляють.',
    'mpj_salary_no_rate'     => 'Курс валюти зараз недоступний, тому фільтр зарплати не застосовано.',
    'mpj_salary_negotiable'  => 'за домовленістю',
    'mpj_chip_salary'        => 'від %s %s %s',
    'mpj_f_fit'              => 'Підходить',
    'mpj_fit_prefix'         => 'Підходить:',
    'mpj_fit_students'       => 'студентам',
    'mpj_fit_no_experience'  => 'без досвіду',
    'mpj_fit_career_switch'  => 'для зміни професії',
    'mpj_fit_junior'         => 'початківцям (junior)',
    'mpj_form_fit_hint'      => 'Нейтральні позначки, без вимог до віку. Можна не вибирати.',
    'mpj_form_salary_hint'   => 'Якщо зарплату не вказано, у списку буде «за домовленістю». Вакансії без зарплати не потрапляють у фільтр за зарплатою.',
    'mpj_sort_salary_desc'   => 'Зарплата: спочатку більша',
    'mpj_sort_salary_asc'    => 'Зарплата: спочатку менша',
    'mpj_f_course_format'    => 'Формат навчання',
    'mpj_f_price_type'       => 'Вартість',
    'mpj_ptype_free'         => 'Безкоштовні',
    'mpj_ptype_paid'         => 'Платні',
    'mpj_regions_title'      => 'Вакансії за областями',
    'mpj_region'             => 'Область',
    'mpq_title'              => 'Часто шукають:',
    'mpq_admin_link'         => 'Популярні запити',
    'mpss_page_title'        => 'Збережені пошуки',
    'mpss_page_lead'         => 'Збережено %d із %d. «Нових» — оголошення, опубліковані після того, як ви востаннє відкривали пошук.',
    'mpss_save_btn'          => 'Зберегти пошук',
    'mpss_login_hint'        => 'Увійдіть, щоб зберігати пошуки.',
    'mpss_saved'             => 'Пошук збережено.',
    'mpss_exists'            => 'Цей пошук уже збережено.',
    'mpss_limit'             => 'Можна зберегти не більше %d пошуків. Видаліть непотрібний і спробуйте ще раз.',
    'mpss_invalid'           => 'Не вдалося виконати дію. Задайте запит або фільтр і спробуйте ще раз.',
    'mpss_empty'             => 'Збережених пошуків поки немає. Задайте запит чи фільтри в Marketplace і натисніть «Зберегти пошук».',
    'mpss_new_n'             => 'Нових: %d',
    'mpss_open'              => 'Відкрити',
    'mpss_rename'            => 'Перейменувати',
    'mpss_rename_save'       => 'Зберегти назву',
    'mpss_renamed'           => 'Назву змінено.',
    'mpss_remove'            => 'Видалити',
    'mpss_remove_confirm'    => 'Видалити цей збережений пошук?',
    'mpss_removed'           => 'Пошук видалено.',
    'mpss_notify_label'      => 'Сповіщати поштою раз на день',
    'mpss_notify_on'         => 'Сповіщення ввімкнено.',
    'mpss_notify_off'        => 'Сповіщення вимкнено.',
    'mpss_notify_hint'       => 'Лист приходить не частіше одного разу на добу й лише коли є нові оголошення. Відписатися можна за посиланням у листі.',
    'mpss_notify_hint_off'   => 'Листи-сповіщення ще не надсилаються: перемикач запам’ятає вашу згоду, і листи почнуть приходити, коли ми їх увімкнемо.',
    'mpss_title_all'         => 'Усі оголошення',
    'mpss_title_salary'      => 'від %s %s',
    'mpss_unsub_ok_title'    => 'Сповіщення вимкнено',
    'mpss_unsub_ok'          => 'Листи за цим збереженим пошуком більше не надходитимуть. Сам пошук лишився у вашому кабінеті.',
    'mpss_unsub_bad_title'   => 'Посилання недійсне',
    'mpss_unsub_bad'         => 'Посилання для відписки недійсне або пошкоджене. Вимкнути сповіщення можна в кабінеті: «Збережені пошуки».',
    'mpss_mail_subject'      => 'Нові оголошення за вашими пошуками: %d',
    'mpss_mail_heading'      => 'Нові оголошення за вашими збереженими пошуками',
    'mpss_mail_open'         => 'Переглянути',
    'mpss_mail_unsub'        => 'Не надсилати листи за цим пошуком',
    'mpss_mail_footer'       => 'Ви отримали цей лист, бо ввімкнули сповіщення для збереженого пошуку на AI LAB HUB. Керувати:',
    'mpst_link'              => 'Статистика',
    'mpst_title'             => 'Статистика: %s',
    'mpst_heading'           => 'Статистика оголошення',
    'mpst_views'             => 'Перегляди',
    'mpst_reveals'           => 'Відкрили контакт',
    'mpst_favorites'         => 'Додали в обране',
    'mpst_clicks'            => 'Переходи на сайт',
    'mpst_days_n'            => '%d дн.',
    'mpst_views_30'          => 'За 30 днів: %d',
    'mpst_chart_title'       => 'Перегляди за %d днів',
    'mpst_note'              => 'Видно лише вам і адміністратору. Ваші власні перегляди, пошукові роботи й автоматичні запити не рахуються; повтори з того самого пристрою — не частіше разу на день. Дані зберігаються 90 днів.',
    'mpsl_title'             => '%s — оголошення продавця на Marketplace AI LAB HUB',
    'mpsl_desc'              => 'Усі оголошення продавця %1$s на Marketplace AI LAB HUB: %2$d активних.',
    'mpsl_since'             => 'на платформі з %s',
    'mpsl_verified'          => 'Перевірений продавець',
    'mpsl_logo_alt'          => 'Логотип: %s',
    'mpsl_no_contacts_note'  => 'Контакти продавця — лише в оголошеннях, через кнопку «Показати контакт». Платформа не бере участі в угодах.',
    'mpsl_empty'             => 'Активних оголошень зараз немає.',
    'mpsl_all_listings'      => 'Усі оголошення продавця (%d)',
    'mpsl_settings_title'    => 'Моя сторінка продавця',
    'mpsl_settings_lead'     => 'Публічна сторінка з вашими оголошеннями. Контакти на ній не показуються.',
    'mpsl_view_page'         => 'Переглянути сторінку',
    'mpsl_no_seller'         => 'Сторінка продавця з’явиться після вашого першого оголошення.',
    'mpsl_name_label'        => 'Назва на сторінці',
    'mpsl_f_public'          => 'Показувати мою сторінку',
    'mpsl_f_public_hint'     => 'Якщо вимкнути, сторінка й посилання «Усі оголошення продавця» зникнуть; самі оголошення лишаться.',
    'mpsl_f_bio'             => 'Короткий опис',
    'mpsl_f_bio_hint'        => 'До %d символів, лише текст. Без пошти, телефонів, посилань і нікнеймів — контакти доступні лише в оголошеннях.',
    'mpsl_f_logo'            => 'Логотип',
    'mpsl_f_logo_hint'       => 'JPG, PNG або WebP до 5 МБ. Зображення перекодовується й зменшується.',
    'mpsl_f_logo_remove'     => 'Прибрати логотип',
    'mpsl_f_site'            => 'Сайт',
    'mpsl_f_site_hint'       => 'Лише https. На сторінці показується для перевірених продавців.',
    'mpsl_saved'             => 'Налаштування сторінки збережено.',
    'mpsl_err_bio_len'       => 'Опис задовгий.',
    'mpsl_err_bio_contacts'  => 'Приберіть з опису пошту, телефони, посилання й нікнейми.',
    'mpsl_err_site'          => 'Вкажіть адресу сайту, що починається з https://.',
    'ais_title'              => 'Як ми використовуємо АІ',
    'ais_admin_warning'      => 'Чернетка: у тексті лишилося маркерів [ПІДТВЕРДИТИ]: %d. Поки вони є, сторінка відкривається лише адміністратору, а для решти віддає 404; посилання в підвалі немає.',
    'ais_uk_only'            => 'Текст доступний лише українською.',
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

/**
 * Короткі описи для карток списку продуктів (каталог, «Моя добірка») поточною мовою.
 *
 * Мова оригіналу → $product['short_description'] як є. Інша мова — без машинного
 * перекладу (у списку можуть бути тисячі карток): одним-двома запитами беремо готовий
 * переклад із product_translations, далі колонку products.short_description_<lang>,
 * а якщо нема й її — лишаємо оригінал (тоді 'fallback' = true, щоб позначити lang).
 * Сторінка продукту сама перекладає й кешує відсутнє, тож прогалини поступово зникають.
 *
 * @param list<array<string, mixed>> $products Рядки з 'id' і 'short_description'.
 * @return array<int, array{text: string, fallback: bool}> За id продукту.
 */
function localized_short_descriptions(PDO $pdo, array $products): array
{
    $lang = current_lang();
    $result = [];
    foreach ($products as $p) {
        $result[(int) $p['id']] = ['text' => (string) ($p['short_description'] ?? ''), 'fallback' => false];
    }
    if ($lang === translation_source_lang() || $result === []) {
        return $result;
    }

    $found = [];
    $column = 'short_description_' . preg_replace('/[^a-z]/', '', $lang);
    foreach (array_chunk(array_keys($result), 1000) as $ids) {
        $in = implode(',', array_map('intval', $ids));
        $st = $pdo->prepare(
            "SELECT product_id, translated_text FROM product_translations
              WHERE field_name = 'short_description' AND lang = :lang AND product_id IN ($in)"
        );
        $st->execute([':lang' => $lang]);
        foreach ($st->fetchAll(PDO::FETCH_NUM) as [$pid, $text]) {
            if (trim((string) $text) !== '') {
                $found[(int) $pid] = (string) $text;
            }
        }

        $missing = array_values(array_diff($ids, array_keys($found)));
        if ($missing !== []) {
            try {
                $st = $pdo->query("SELECT id, `$column` FROM products WHERE id IN (" . implode(',', array_map('intval', $missing)) . ')');
                foreach ($st->fetchAll(PDO::FETCH_NUM) as [$pid, $text]) {
                    if (trim((string) $text) !== '') {
                        $found[(int) $pid] = (string) $text;
                    }
                }
            } catch (PDOException $e) {
                // Колонки для цієї мови немає — лишаються переклади з product_translations.
            }
        }
    }

    foreach ($result as $pid => $row) {
        if (isset($found[$pid])) {
            $result[$pid] = ['text' => $found[$pid], 'fallback' => false];
        } elseif ($row['text'] !== '') {
            $result[$pid]['fallback'] = true;
        }
    }

    return $result;
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
        // hl — адреса мовної версії статті блогу (public/blog-post.php): після
        // перемикання в шапці вона б знову ввімкнула стару мову, тож прибираємо.
        unset($params['lang'], $params['hl']);

        $path = strtok($_SERVER['REQUEST_URI'] ?? '', '?');
        $query = http_build_query($params);

        header('Location: ' . $path . ($query !== '' ? '?' . $query : ''), true, 302);
        exit;
    }
}
