<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тексти оголошень компаній (вакансії, курси, послуги) UA/EN.
 *
 * Окремий словник, як app/promo-i18n.php: готовий переклад тут же, без автоперекладу й міграцій
 * ui_translations. Мова — lst_lang() (мова інтерфейсу сесії). Плейсхолдери інтерфейсу — sprintf (%s),
 * листів — {name} (lst_tr_lang()). Адмінка — лише українською (як решта CRM), її тексти в коді.
 */

const LST_I18N = [
    // Типи
    'type_job' => ['Вакансії', 'Jobs'],
    'type_course' => ['Курси', 'Courses'],
    'type_service' => ['Послуги', 'Services'],
    'type1_job' => ['Вакансія', 'Job'],
    'type1_course' => ['Курс', 'Course'],
    'type1_service' => ['Послуга', 'Service'],
    'sub_job' => ['Вакансії у сфері штучного інтелекту від компаній.', 'AI jobs posted by companies.'],
    'sub_course' => ['Курси й навчальні програми з AI від авторів і шкіл.', 'AI courses and learning programs from schools and authors.'],
    'sub_service' => ['Послуги у сфері AI: консалтинг, розробка, автоматизація.', 'AI services: consulting, development, automation.'],
    'post_job' => ['Розмістити вакансію', 'Post a job'],
    'post_course' => ['Розмістити курс', 'Post a course'],
    'post_service' => ['Розмістити послугу', 'Post a service'],

    // Статуси
    'st_draft' => ['Чернетка', 'Draft'],
    'st_pending' => ['На модерації', 'Under review'],
    'st_published' => ['Опубліковано', 'Published'],
    'st_rejected' => ['Відхилено', 'Rejected'],
    'st_expired' => ['Термін минув', 'Expired'],
    'st_archived' => ['Знято', 'Removed'],

    // Безкоштовне розміщення
    'free_until' => ['Безкоштовне розміщення до %s', 'Free listing until %s'],
    'free_now' => ['Розміщення безкоштовне', 'Listing is free'],

    // Форма
    'form_new' => ['Нове оголошення: %s', 'New listing: %s'],
    'form_edit' => ['Редагування оголошення', 'Edit listing'],
    'form_lead' => ['Оголошення публікує сама компанія або автор. Після перевірки модератором воно з\'явиться на сайті на %d днів.', 'Listings are posted by the company or author themselves. After a moderator review, it appears on the site for %d days.'],
    'form_edit_note' => ['Після редагування схваленого оголошення воно знову піде на модерацію й тимчасово зникне з сайту.', 'After you edit an approved listing it goes back to review and is hidden until approved again.'],
    'f_type' => ['Тип оголошення', 'Listing type'],
    'f_title' => ['Назва', 'Title'],
    'f_title_hint_job' => ['Лише назва посади, без зарплати, міста й назви компанії (до %d символів).', 'Job title only — no salary, city or company name (up to %d characters).'],
    'f_title_hint' => ['До %d символів.', 'Up to %d characters.'],
    'f_company' => ['Компанія / школа / автор', 'Company / school / author'],
    'f_company_hint' => ['Офіційна назва, яка видна на вашому сайті.', 'The official name shown on your website.'],
    'f_short' => ['Короткий опис', 'Short description'],
    'f_short_hint' => ['1–2 речення для картки в списку (до %d символів).', '1–2 sentences for the list card (up to %d characters).'],
    'f_desc' => ['Повний опис', 'Full description'],
    'f_desc_hint_job' => ['Обов\'язки, вимоги, умови, графік (до %d символів, лише текст). Посилань в описі — не більше %d.', 'Responsibilities, requirements, conditions, schedule (up to %d characters, text only). No more than %d links.'],
    'f_desc_hint' => ['До %d символів, лише текст. Посилань в описі — не більше %d.', 'Up to %d characters, text only. No more than %d links.'],
    'f_url' => ['Посилання на сторінку', 'Link to the page'],
    'f_url_hint_job' => ['https-адреса сторінки вакансії на вашому сайті або в ATS, де можна подати заявку.', 'The https address of the job page on your site or ATS where people can apply.'],
    'f_url_hint_course' => ['https-адреса сторінки курсу.', 'The https address of the course page.'],
    'f_url_hint_service' => ['https-адреса сторінки послуги.', 'The https address of the service page.'],
    'f_domain_hint' => ['Порада: якщо домен сайту збігається з доменом вашої пошти (%s), модерація проходить швидше. Інакше модератор перевіряє компанію вручну.', 'Tip: if the website domain matches your email domain (%s), review is faster. Otherwise a moderator verifies the company manually.'],
    'f_country' => ['Країна', 'Country'],
    'f_country_hint_job' => ['Для віддаленої роботи — країна, з якої можна працювати.', 'For remote jobs — the country candidates may work from.'],
    'f_lang' => ['Мова роботи / навчання', 'Working / teaching language'],
    'lang_uk' => ['Українська', 'Ukrainian'],
    'lang_en' => ['Англійська', 'English'],
    'lang_other' => ['Інша', 'Other'],
    'f_remote' => ['Віддалено', 'Remote'],
    'f_remote_job' => ['100% віддалена робота', '100% remote job'],
    'f_focus' => ['AI-спрямування', 'AI focus'],
    'f_focus_hint' => ['Оберіть 1–3.', 'Choose 1–3.'],
    'f_any' => ['— не вказано —', '— not specified —'],
    'f_rules' => ['Я підтверджую, що оголошення відповідає Правилам і не належить до заборонених категорій.', 'I confirm the listing follows the Rules and is not in a prohibited category.'],
    'f_rules_link' => ['Правила', 'Rules'],
    'f_submit_new' => ['Надіслати на модерацію', 'Submit for review'],
    'f_submit_save' => ['Зберегти й надіслати на модерацію', 'Save and submit for review'],
    'f_cancel' => ['Скасувати', 'Cancel'],
    'f_details' => ['Деталі', 'Details'],

    // Поля деталей
    'd_employment' => ['Тип зайнятості', 'Employment type'],
    'd_level' => ['Рівень', 'Level'],
    'd_salary' => ['Зарплатна вилка (необов\'язково)', 'Salary range (optional)'],
    'd_salary_min' => ['від', 'from'],
    'd_salary_max' => ['до', 'to'],
    'd_salary_period' => ['за період', 'per'],
    'd_city' => ['Місто', 'City'],
    'd_apply_until' => ['Подати заявку до', 'Apply by'],
    'd_format' => ['Формат', 'Format'],
    'd_duration' => ['Тривалість', 'Duration'],
    'd_duration_ph' => ['напр. 6 тижнів', 'e.g. 6 weeks'],
    'd_price' => ['Ціна', 'Price'],
    'd_is_free' => ['Безкоштовний курс', 'Free course'],
    'd_start_date' => ['Дата старту', 'Start date'],
    'd_service_type' => ['Тип послуги', 'Service type'],
    'd_price_from' => ['Ціна «від» (необов\'язково)', 'Price “from” (optional)'],
    'd_delivery_time' => ['Строк виконання', 'Turnaround time'],
    'd_delivery_ph' => ['напр. від 2 тижнів', 'e.g. from 2 weeks'],
    'v_full_time' => ['Повна зайнятість', 'Full-time'],
    'v_part_time' => ['Часткова зайнятість', 'Part-time'],
    'v_contract' => ['Контракт / фриланс', 'Contract / freelance'],
    'v_internship' => ['Стажування', 'Internship'],
    'v_temporary' => ['Тимчасова', 'Temporary'],
    'v_junior' => ['Junior', 'Junior'],
    'v_middle' => ['Middle', 'Middle'],
    'v_senior' => ['Senior', 'Senior'],
    'v_lead' => ['Lead', 'Lead'],
    'v_any' => ['Будь-який', 'Any'],
    'v_beginner' => ['Початковий', 'Beginner'],
    'v_intermediate' => ['Середній', 'Intermediate'],
    'v_advanced' => ['Просунутий', 'Advanced'],
    'v_online' => ['Онлайн', 'Online'],
    'v_offline' => ['Офлайн', 'In person'],
    'v_hybrid' => ['Змішаний', 'Hybrid'],
    'v_MONTH' => ['місяць', 'month'],
    'v_YEAR' => ['рік', 'year'],
    'v_HOUR' => ['година', 'hour'],
    'v_consulting' => ['Консалтинг', 'Consulting'],
    'v_development' => ['Розробка', 'Development'],
    'v_automation' => ['Автоматизація', 'Automation'],
    'v_training' => ['Навчання команд', 'Team training'],
    'v_content' => ['Контент і дизайн', 'Content & design'],
    'v_data' => ['Дані та аналітика', 'Data & analytics'],
    'v_other' => ['Інше', 'Other'],

    // Помилки форми
    'err_type' => ['Оберіть тип оголошення.', 'Choose a listing type.'],
    'err_title' => ['Назва — від 3 до %d символів.', 'Title must be 3 to %d characters.'],
    'err_company' => ['Вкажіть назву компанії (до %d символів).', 'Enter the company name (up to %d characters).'],
    'err_short' => ['Короткий опис — від 10 до %d символів.', 'Short description must be 10 to %d characters.'],
    'err_desc' => ['Повний опис — до %d символів.', 'Full description must be up to %d characters.'],
    'err_desc_job' => ['Для вакансії потрібен повний опис (щонайменше 50 символів).', 'A job needs a full description (at least 50 characters).'],
    'err_url' => ['Потрібне коректне https-посилання (без логіна й пароля в адресі).', 'A valid https link is required (no login or password in the address).'],
    'err_link_blocked' => ['Посилання не пройшло перевірку безпеки (заборонений або небезпечний домен, чи внутрішня адреса). Вкажіть іншу сторінку.', 'The link failed the safety check (blocked or unsafe domain, or an internal address). Please use a different page.'],
    'err_country' => ['Оберіть країну.', 'Choose a country.'],
    'err_lang' => ['Оберіть мову.', 'Choose a language.'],
    'err_focus' => ['Оберіть від 1 до 3 AI-спрямувань.', 'Choose 1 to 3 AI focus areas.'],
    'err_number' => ['Числові поля — лише цілі числа.', 'Number fields accept whole numbers only.'],
    'err_date' => ['Дата має бути у форматі РРРР-ММ-ДД.', 'Dates must be in YYYY-MM-DD format.'],
    'err_salary_range' => ['Зарплата «від» не може бути більшою за «до».', 'Salary “from” cannot exceed “to”.'],
    'err_apply_past' => ['Дата закінчення подання вже минула.', 'The application deadline has already passed.'],
    'err_job_location' => ['Для невіддаленої вакансії вкажіть місто.', 'Enter a city for a non-remote job.'],
    'err_rules' => ['Підтвердьте відповідність Правилам.', 'Please confirm the listing follows the Rules.'],
    'err_links' => ['В описах забагато посилань (максимум %d).', 'Too many links in the descriptions (max %d).'],
    'err_stopword' => ['Текст містить заборонені слова. Перевірте Правила.', 'The text contains prohibited words. Please check the Rules.'],
    'err_pending_limit' => ['У вас уже %d оголошення на модерації. Зачекайте рішення щодо них.', 'You already have %d listings under review. Please wait for a decision.'],
    'err_day_limit' => ['Досягнуто ліміту нових оголошень за добу (%d).', 'Daily limit of new listings reached (%d).'],
    'err_rate' => ['Забагато спроб із вашої мережі. Спробуйте пізніше.', 'Too many attempts from your network. Please try later.'],
    'err_too_fast' => ['Форму надіслано надто швидко. Перевірте дані й надішліть ще раз.', 'The form was sent too quickly. Please review and submit again.'],
    'err_save' => ['Не вдалося зберегти. Спробуйте ще раз.', 'Could not save. Please try again.'],
    'err_spam' => ['Запит відхилено.', 'The request was rejected.'],
    'err_extend_status' => ['Продовжити можна лише опубліковане або прострочене оголошення.', 'Only published or expired listings can be extended.'],
    'err_extend_early' => ['Продовжити можна, коли до кінця терміну лишиться %d днів або менше.', 'You can extend when %d days or fewer remain.'],
    'err_extend_deadline' => ['Дата закінчення подання вже минула — змініть її в оголошенні.', 'The application deadline has passed — update it in the listing.'],
    'saved' => ['Оголошення надіслано на модерацію. Ми повідомимо вас листом.', 'Your listing was submitted for review. We will notify you by email.'],
    'extended' => ['Оголошення продовжено.', 'The listing was extended.'],
    'removed' => ['Оголошення знято з публікації.', 'The listing was removed.'],
    'action_failed' => ['Дію не виконано.', 'The action was not completed.'],

    // Заборонені категорії (підказка у формі й на сторінках)
    'rules_title' => ['Що не можна розміщувати', 'What is not allowed'],
    'rules_list' => [
        "оплата від кандидата чи слухача за можливість подати заявку або співбесіду\nбагаторівневий маркетинг і фінансові піраміди\n«швидкі гроші», «пасивний дохід», криптосхеми, ставки й казино\nдорослий контент\nдискримінація за будь-якою ознакою\nнелегальні товари й послуги\nоманливі гарантії результату («працевлаштування гарантовано», «дохід від …»)",
        "fees from candidates or students to apply or get an interview\nmulti-level marketing and pyramid schemes\n“easy money”, “passive income”, crypto schemes, betting and casinos\nadult content\ndiscrimination of any kind\nillegal goods and services\nmisleading guarantees of results (“guaranteed job”, “earn from …”)",
    ],
    'disclaimer' => ['AI LAB HUB лише розміщує оголошення й не є стороною трудових чи цивільних відносин між компанією та кандидатом, слухачем чи клієнтом. Перевіряйте умови на сайті компанії. Див. Умови використання.', 'AI LAB HUB only hosts listings and is not a party to any employment or civil relationship between the company and a candidate, student or client. Check the terms on the company’s website. See the Terms of Use.'],

    'terms_link' => ['Умови використання', 'Terms of Use'],

    // Публічна частина
    'list_found' => ['Знайдено: %d', 'Found: %d'],
    'list_empty' => ['Поки що оголошень немає.', 'No listings yet.'],
    'list_empty_search' => ['За цими фільтрами нічого не знайдено.', 'Nothing matches these filters.'],
    'flt_search' => ['Пошук', 'Search'],
    'flt_search_ph' => ['Назва або компанія', 'Title or company'],
    'flt_lang' => ['Мова', 'Language'],
    'flt_country' => ['Країна', 'Country'],
    'flt_focus' => ['AI-спрямування', 'AI focus'],
    'flt_all' => ['Усі', 'All'],
    'flt_price' => ['Ціна', 'Price'],
    'flt_free' => ['Безкоштовні', 'Free'],
    'flt_paid' => ['Платні', 'Paid'],
    'flt_max' => ['Ціна до', 'Price up to'],
    'flt_remote' => ['Лише віддалено', 'Remote only'],
    'flt_apply' => ['Показати', 'Apply'],
    'flt_reset' => ['Скинути', 'Reset'],
    'pages' => ['Сторінки', 'Pages'],
    'go' => ['Перейти на сторінку', 'Open the page'],
    'go_hint' => ['Відкриється сайт компанії: %s', 'Opens the company website: %s'],
    'posted' => ['Опубліковано', 'Posted'],
    'valid_until' => ['Актуально до', 'Valid until'],
    'company' => ['Компанія', 'Company'],
    'location' => ['Місце', 'Location'],
    'remote' => ['віддалено', 'remote'],
    'free' => ['Безкоштовно', 'Free'],
    'from' => ['від %s', 'from %s'],
    'per' => ['/ %s', '/ %s'],
    'expired_notice' => ['Термін дії цього оголошення минув.', 'This listing has expired.'],
    'preview_notice' => ['Попередній перегляд: оголошення ще не опубліковане (статус: %s). Його бачите лише ви й модератори.', 'Preview: this listing is not published yet (status: %s). Only you and moderators can see it.'],
    'reject_reason' => ['Причина відхилення', 'Reason for rejection'],
    'other_types' => ['Інші розділи', 'Other sections'],
    'back_list' => ['← До списку', '← Back to list'],
    'text_auto' => ['Текст перекладено автоматично.', 'Text translated automatically.'],

    // Кабінет
    'my_title' => ['Мої оголошення', 'My listings'],
    'my_empty' => ['У вас ще немає оголошень про вакансії, курси чи послуги.', 'You have no job, course or service listings yet.'],
    'my_col_listing' => ['Оголошення', 'Listing'],
    'my_col_status' => ['Статус', 'Status'],
    'my_col_stats' => ['Перегляди / переходи (30 дн.)', 'Views / clicks (30 days)'],
    'my_col_until' => ['До', 'Until'],
    'my_col_actions' => ['Дії', 'Actions'],
    'my_edit' => ['Редагувати', 'Edit'],
    'my_extend' => ['Продовжити', 'Extend'],
    'my_remove' => ['Зняти', 'Remove'],
    'my_remove_confirm' => ['Зняти оголошення з публікації?', 'Remove this listing?'],
    'my_view' => ['Переглянути', 'View'],
    'my_csv' => ['Експорт CSV', 'Export CSV'],
    'my_stats_note' => ['Перегляди й переходи рахуються без персональних даних; боти й повторні відвідування не враховуються.', 'Views and clicks are counted without personal data; bots and repeat visits are excluded.'],

    // Листи (плейсхолдери {name})
    'mail_received_subject' => ['Оголошення отримано: {title}', 'Listing received: {title}'],
    'mail_received_body' => ["Добрий день!\n\nМи отримали ваше оголошення «{title}». Модератор перевірить його найближчим часом, і ми повідомимо вас про рішення.\n\nПереглянути статус: {cabinet}", "Hello!\n\nWe have received your listing “{title}”. A moderator will review it shortly and we will let you know the decision.\n\nCheck the status: {cabinet}"],
    'mail_approved_subject' => ['Оголошення опубліковано: {title}', 'Listing published: {title}'],
    'mail_approved_body' => ["Добрий день!\n\nВаше оголошення «{title}» схвалено й опубліковано до {expires}.\n\nСторінка оголошення: {url}\nКабінет: {cabinet}", "Hello!\n\nYour listing “{title}” was approved and is published until {expires}.\n\nListing page: {url}\nDashboard: {cabinet}"],
    'mail_rejected_subject' => ['Оголошення не опубліковано: {title}', 'Listing not published: {title}'],
    'mail_rejected_body' => ["Добрий день!\n\nНа жаль, оголошення «{title}» не пройшло модерацію.\nПричина: {reason}\n\nВи можете виправити оголошення й надіслати його повторно: {cabinet}\nПравила: {rules}", "Hello!\n\nUnfortunately, your listing “{title}” did not pass review.\nReason: {reason}\n\nYou can fix the listing and submit it again: {cabinet}\nRules: {rules}"],
    'mail_expiring_subject' => ['Термін оголошення спливає {expires}: {title}', 'Your listing expires on {expires}: {title}'],
    'mail_expiring_body' => ["Добрий день!\n\nТермін дії оголошення «{title}» спливає {expires}. Якщо воно ще актуальне, продовжте його в кабінеті (безкоштовно): {cabinet}", "Hello!\n\nYour listing “{title}” expires on {expires}. If it is still relevant, extend it in your dashboard (free): {cabinet}"],
    'mail_report_subject' => ['Звіт за 30 днів: {title}', '30-day report: {title}'],
    'mail_report_body' => ["Добрий день!\n\nЗвіт за оголошенням «{title}» за останні 30 днів:\n· переглядів сторінки: {views}\n· переходів на ваш сайт: {clicks}\n\nБоти й повторні відвідування не враховуються. Детальніше й експорт CSV — у кабінеті: {cabinet}", "Hello!\n\nReport for your listing “{title}” for the last 30 days:\n· page views: {views}\n· clicks to your website: {clicks}\n\nBots and repeat visits are excluded. Details and CSV export are in your dashboard: {cabinet}"],
    'mail_footer' => ["—\nAI LAB HUB · каталог AI-інструментів\nВи отримали цей лист, бо розмістили оголошення на AI LAB HUB.", "—\nAI LAB HUB · AI tools directory\nYou received this email because you posted a listing on AI LAB HUB."],

    // Причини відхилення (шаблони)
    'rej_prohibited' => ['Оголошення належить до забороненої категорії (див. Правила).', 'The listing belongs to a prohibited category (see the Rules).'],
    'rej_misleading' => ['Оголошення містить оманливі обіцянки або гарантії результату.', 'The listing contains misleading promises or guaranteed results.'],
    'rej_not_ai' => ['Оголошення не стосується сфери штучного інтелекту.', 'The listing is not related to artificial intelligence.'],
    'rej_broken_link' => ['Посилання не відкривається або веде не на сторінку оголошення.', 'The link does not open or does not lead to the listing page.'],
    'rej_incomplete' => ['Бракує важливої інформації (опис, умови, компанія).', 'Important information is missing (description, conditions, company).'],
    'rej_duplicate' => ['Таке оголошення вже розміщено.', 'This listing has already been posted.'],
    'rej_unverified' => ['Не вдалося підтвердити зв\'язок автора з компанією. Напишіть нам із корпоративної пошти.', 'We could not verify that you represent the company. Please contact us from a corporate email.'],
    'rej_other' => ['Оголошення не відповідає Правилам.', 'The listing does not follow the Rules.'],
];

function lst_lang(): string
{
    return function_exists('current_lang') && current_lang() === 'en' ? 'en' : 'uk';
}

/** Текст мовою інтерфейсу; аргументи — sprintf. */
function lst_tr(string $key, mixed ...$args): string
{
    $pair = LST_I18N[$key] ?? null;
    if ($pair === null) {
        return $key;
    }
    $txt = lst_lang() === 'en' ? $pair[1] : $pair[0];

    return $args === [] ? $txt : vsprintf($txt, $args);
}

/** Текст заданою мовою з плейсхолдерами {name} (листи). @param array<string,string> $vars */
function lst_tr_lang(string $key, string $lang, array $vars = []): string
{
    $pair = LST_I18N[$key] ?? null;
    if ($pair === null) {
        return $key;
    }
    $txt = $lang === 'en' ? $pair[1] : $pair[0];
    $repl = [];
    foreach ($vars as $k => $v) {
        $repl['{' . $k . '}'] = (string) $v;
    }

    return strtr($txt, $repl);
}

function lst_e(mixed $v): string
{
    return htmlspecialchars((string) $v, ENT_QUOTES);
}
