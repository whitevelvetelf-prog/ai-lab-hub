<?php

declare(strict_types=1);

/**
 * AI LAB HUB — рядки UA/EN для Правил Marketplace і юридичних механізмів (згода, AI-позначка, умови використання,
 * модерація, скарги, оскарження, облік контактів, санкції, повідомлення).
 * Той самий механізм, що LST_I18N (app/listing-i18n.php) і MPF_I18N (app/mp-flow-i18n.php): пара [uk, en],
 * мова — current_lang(); у листах — мова, передана явно (mpl_tr_lang). Плейсхолдери інтерфейсу — sprintf (%s / %d),
 * у листах — {name}.
 */

const MPL_I18N = [
    // --- Правила, посилання ---
    'rules_title' => ['Правила Marketplace', 'Marketplace Rules'],
    'rules_link' => ['Правила Marketplace', 'Marketplace Rules'],
    'rules_version' => ['Редакція від %s', 'Version of %s'],
    'rules_uk_prevails' => ['У разі розбіжностей між мовними версіями перевагу має українська версія (п. 1.6).', 'If the language versions differ, the Ukrainian version prevails (clause 1.6).'],
    'rules_toc' => ['Зміст', 'Contents'],
    'rules_other_lang' => ['Українська версія', 'English version'],

    // --- Згода (п. 1.5) ---
    'consent_label' => ['Я прочитав(ла) і приймаю', 'I have read and accept the'],
    'consent_err' => ['Щоб подати оголошення, прийміть Правила Marketplace.', 'To submit a listing, please accept the Marketplace Rules.'],

    // --- Поля оголошення (крок 3) ---
    'ai_media_label' => ['Зображення, відео чи тексти створені за допомогою AI і можуть сприйматися як реальні', 'Images, videos or texts were made with AI and may look real'],
    'ai_media_hint' => ['Позначте, якщо в оголошенні є AI-фото «результату», AI-люди чи AI-відгуки (п. 4.5 Правил). На сторінці з\'явиться мітка «Створено з AI».', 'Tick this if the listing shows AI-made “results”, AI people or AI reviews (clause 4.5). The page will show a “Made with AI” label.'],
    'ai_badge' => ['Створено з AI', 'Made with AI'],
    'ai_badge_title' => ['Автор позначив, що зображення, відео чи тексти в оголошенні створені за допомогою AI', 'The author marked that images, videos or texts in this listing were made with AI'],
    'usage_label' => ['Умови використання (для цифрових продуктів)', 'Terms of use (for digital products)'],
    'usage_hint' => ['Необов\'язково. Якщо продаєте чи роздаєте шаблони, персонажів, зображення — вкажіть, як їх можна використовувати (п. 9.5).', 'Optional. If you sell or give away templates, characters or images, say how they may be used (clause 9.5).'],
    'usage_none' => ['— не вказано —', '— not specified —'],
    'usage_personal' => ['Лише особисте використання', 'Personal use only'],
    'usage_commercial' => ['Можна комерційно', 'Commercial use allowed'],
    'usage_no_changes' => ['Використовувати без змін', 'Use without modifications'],
    'usage_other' => ['Інше (вказати)', 'Other (specify)'],
    'usage_other_ph' => ['Опишіть умови коротко', 'Describe the terms briefly'],
    'usage_err_other' => ['Опишіть умови використання (поле «Інше»).', 'Please describe the terms of use (the “Other” field).'],
    'usage_view' => ['Умови використання', 'Terms of use'],
    'course_city_err' => ['Для офлайн- чи змішаного курсу вкажіть місто (п. 6.5 Правил).', 'For an offline or hybrid course, please enter the city (clause 6.5).'],

    // --- Статуси ---
    'st_draft' => ['Чернетка', 'Draft'],
    'st_pending' => ['На модерації', 'Under review'],
    'st_published' => ['Опубліковано', 'Published'],
    'st_needs_changes' => ['Повернуто на доопрацювання', 'Returned for changes'],
    'st_rejected' => ['Відхилено', 'Rejected'],
    'st_hidden' => ['Тимчасово приховано (розгляд скарги)', 'Temporarily hidden (complaint under review)'],
    'st_removed' => ['Знято адміністрацією', 'Removed by moderators'],
    'st_expired' => ['Строк минув', 'Expired'],
    'st_archived' => ['Видалено автором', 'Deleted by author'],

    // --- Пункти Правил (причини рішень) ---
    'pt_5.1.1' => ['5.1.1 — не відповідає тематиці розділу 4', '5.1.1 — off-topic (section 4)'],
    'pt_5.1.2' => ['5.1.2 — заборонені або обмежені законом товари чи послуги', '5.1.2 — goods or services banned or restricted by law'],
    'pt_5.1.3' => ['5.1.3 — шахрайство, піраміди, «гарантований заробіток»', '5.1.3 — fraud, pyramid schemes, “guaranteed income”'],
    'pt_5.1.4' => ['5.1.4 — злом, шкідливе ПЗ, чужі дані, вкрадені акаунти чи ключі', '5.1.4 — hacking, malware, others\' data, stolen accounts or keys'],
    'pt_5.1.5' => ['5.1.5 — діпфейки реальних людей без згоди, інтимні зображення', '5.1.5 — deepfakes of real people without consent, intimate images'],
    'pt_5.1.6' => ['5.1.6 — порнографія, сексуальний контент із неповнолітніми', '5.1.6 — pornography, sexual content involving minors'],
    'pt_5.1.7' => ['5.1.7 — дипломи, іспити за іншу особу, підробка документів', '5.1.7 — ghost-writing theses, taking exams for others, forged documents'],
    'pt_5.1.8' => ['5.1.8 — накрутка відгуків, лайків, підписників, фейкові акаунти', '5.1.8 — fake reviews, likes, followers, fake accounts'],
    'pt_5.1.9' => ['5.1.9 — продаж чужих продуктів без права, піратство', '5.1.9 — selling others\' products without rights, piracy'],
    'pt_5.1.10' => ['5.1.10 — заклики до насильства, дискримінації, ворожнечі', '5.1.10 — calls for violence, discrimination, hatred'],
    'pt_5.1.11' => ['5.1.11 — проти незалежності чи територіальної цілісності України', '5.1.11 — against Ukraine\'s independence or territorial integrity'],
    'pt_5.1.12' => ['5.1.12 — приховані посилання, фішинг, передоплата за вакансію', '5.1.12 — hidden links, phishing, upfront fees for a job'],
    'pt_5.1.13' => ['5.1.13 — чужі персональні дані чи фото без згоди', '5.1.13 — others\' personal data or photos without consent'],
    'pt_5.2' => ['5.2 — інше порушення законодавства чи прав третіх осіб', '5.2 — other breach of law or third-party rights'],
    'pt_4' => ['Розділ 4 — оголошення не відповідає вимогам (категорія, дублікат, опис, ціна, AI-позначка)', 'Section 4 — listing requirements not met (category, duplicate, description, price, AI label)'],
    'pt_6' => ['Розділ 6 — вимоги до вакансій чи курсів', 'Section 6 — job or course requirements'],
    'pt_10' => ['Розділ 10 — порушення прав правовласника', 'Section 10 — rights holder\'s rights infringed'],

    // --- Кабінет автора ---
    'my_attention_tab' => ['Потребують уваги', 'Need attention'],
    'my_reason' => ['Причина', 'Reason'],
    'my_rule_point' => ['Пункт Правил', 'Rules clause'],
    'my_notifications' => ['Повідомлення', 'Notifications'],
    'my_notifications_empty' => ['Нових повідомлень немає.', 'No new notifications.'],
    'my_mark_read' => ['Позначити прочитаними', 'Mark as read'],
    'my_decisions_title' => ['Рішення модерації, скарги й оскарження', 'Moderation decisions, complaints and appeals'],
    'my_appeal_btn' => ['Оскаржити рішення', 'Appeal the decision'],
    'my_appeal_until' => ['Оскаржити можна до %s (п. 7.5 Правил).', 'You can appeal until %s (clause 7.5).'],
    'my_appeal_closed' => ['Строк оскарження (%d днів) минув. Можна написати на %s.', 'The %d-day appeal period is over. You can still write to %s.'],
    'my_appeal_text' => ['Чому рішення слід переглянути', 'Why the decision should be reviewed'],
    'my_appeal_send' => ['Надіслати оскарження', 'Send the appeal'],
    'my_appeal_open' => ['Оскарження на розгляді. Відповідь — протягом %d робочих днів.', 'Your appeal is under review. We will answer within %d business days.'],
    'my_appeal_restored' => ['Оскарження задоволено — оголошення відновлено.', 'Appeal granted — the listing has been restored.'],
    'my_appeal_upheld' => ['Рішення залишено в силі.', 'The decision stands.'],
    'my_appeal_sent' => ['Оскарження надіслано. Відповімо протягом %d робочих днів.', 'Appeal sent. We will answer within %d business days.'],
    'my_appeal_err_text' => ['Опишіть, чому рішення слід переглянути (від 10 символів).', 'Please explain why the decision should be reviewed (at least 10 characters).'],
    'my_appeal_err_window' => ['Оскарження недоступне: минув строк або рішення вже оскаржено.', 'Appeal not available: the period is over or the decision has already been appealed.'],
    'my_complaint_title' => ['Скарга про порушення прав', 'Rights infringement complaint'],
    'my_complaint_text' => ['На оголошення надійшла скарга правовласника. Суть претензії:', 'A rights holder has filed a complaint about this listing. The claim:'],
    'my_complaint_work' => ['Що, за словами заявника, порушено', 'What the claimant says is infringed'],
    'my_counter_until' => ['Заперечення з доказами своїх прав можна подати до %s (п. 10.3). Якщо заперечення не надійде, оголошення буде видалено.', 'You can file a counter-notice with proof of your rights until %s (clause 10.3). Without it the listing will be removed.'],
    'my_counter_text' => ['Ваше заперечення', 'Your counter-notice'],
    'my_counter_url' => ['Посилання на докази ваших прав (оригінал з датою, публікація, договір)', 'Link to proof of your rights (dated original, publication, contract)'],
    'my_counter_send' => ['Надіслати заперечення', 'Send the counter-notice'],
    'my_counter_sent' => ['Заперечення отримано. Адміністрація розгляне його.', 'Counter-notice received. Moderators will review it.'],
    'my_counter_done' => ['Заперечення подано %s.', 'Counter-notice filed on %s.'],
    'my_counter_err' => ['Опишіть заперечення (від 10 символів) і додайте https-посилання на докази.', 'Please write the counter-notice (at least 10 characters) and add an https link to the proof.'],
    'my_counter_closed' => ['Строк для заперечення минув.', 'The counter-notice period is over.'],
    'my_contact_views' => ['Контакти переглянули: %d', 'Contacts viewed: %d'],

    // --- Блокування й обмеження ---
    'ban_title' => ['Подача оголошень обмежена', 'Posting is restricted'],
    'ban_until' => ['Адміністрація обмежила вам подачу оголошень до %s (п. 7.3 Правил).', 'Moderators have restricted your posting until %s (clause 7.3).'],
    'ban_forever' => ['Адміністрація обмежила вам подачу оголошень безстроково (п. 7.3–7.4 Правил).', 'Moderators have restricted your posting indefinitely (clauses 7.3–7.4).'],
    'ban_blocked' => ['Ваш акаунт заблоковано за порушення Правил Marketplace (п. 7.4).', 'Your account has been blocked for breaking the Marketplace Rules (clause 7.4).'],
    'ban_appeal' => ['Не згодні? Рішення можна оскаржити — див. %s або напишіть на %s.', 'Disagree? You can appeal — see %s or write to %s.'],
    'ban_appeal_link' => ['п. 7.5 Правил', 'clause 7.5 of the Rules'],
    'blocked_action' => ['Дія недоступна: акаунт заблоковано.', 'Not available: the account is blocked.'],

    // --- Скарги (форма) ---
    'c_title' => ['Поскаржитися на оголошення', 'Report this listing'],
    'c_btn' => ['Поскаржитися', 'Report'],
    'c_reason' => ['Причина', 'Reason'],
    'c_reason_fraud' => ['Шахрайство', 'Fraud'],
    'c_reason_prohibited' => ['Заборонений контент', 'Prohibited content'],
    'c_reason_copyright' => ['Порушення авторських прав', 'Copyright infringement'],
    'c_reason_wrong_category' => ['Невідповідна категорія', 'Wrong category'],
    'c_reason_misleading' => ['Оманливий опис', 'Misleading description'],
    'c_reason_other' => ['Інше', 'Other'],
    'c_note' => ['Опишіть проблему', 'Describe the problem'],
    'c_email' => ['Ваш email (для відповіді)', 'Your email (for our reply)'],
    'c_guest_hint' => ['Ви не увійшли. Залиште email або %s.', 'You are not logged in. Leave your email or %s.'],
    'c_login' => ['увійдіть', 'log in'],
    'c_cr_intro' => ['Заява правовласника (п. 10.1 Правил). Усі поля обов\'язкові.', 'Rights holder\'s notice (clause 10.1). All fields are required.'],
    'c_cr_name' => ['Ваше ім\'я або назва організації', 'Your name or organisation'],
    'c_cr_contact' => ['Контакти (email, телефон)', 'Contact details (email, phone)'],
    'c_cr_work' => ['Який саме твір чи об\'єкт порушено', 'Which work or item is infringed'],
    'c_cr_evidence_url' => ['Посилання на докази ваших прав', 'Link to proof of your rights'],
    'c_cr_evidence_file' => ['або файл із доказами (PDF, JPG, PNG, до 5 МБ)', 'or a file with proof (PDF, JPG, PNG, up to 5 MB)'],
    'c_cr_good_faith' => ['Інформація правдива, я дію добросовісно', 'The information is true and I am acting in good faith'],
    'c_send' => ['Надіслати скаргу', 'Send the complaint'],
    'c_ok' => ['Дякуємо! Скаргу отримано. Заяви правовласників розглядаємо протягом %d робочих днів.', 'Thank you! Complaint received. Rights holder notices are reviewed within %d business days.'],
    'c_ok_simple' => ['Дякуємо! Скаргу отримано, модератори її переглянуть.', 'Thank you! Complaint received; moderators will review it.'],
    'c_err_reason' => ['Оберіть причину скарги.', 'Please choose a reason.'],
    'c_err_note' => ['Опишіть проблему (до 2000 символів).', 'Please describe the problem (up to 2000 characters).'],
    'c_err_email' => ['Вкажіть коректний email або увійдіть.', 'Please enter a valid email or log in.'],
    'c_err_cr_name' => ['Вкажіть ім\'я або назву організації.', 'Please enter your name or organisation.'],
    'c_err_cr_contact' => ['Вкажіть контакти.', 'Please enter your contact details.'],
    'c_err_cr_work' => ['Опишіть, що саме порушено.', 'Please describe what is infringed.'],
    'c_err_cr_evidence' => ['Додайте https-посилання на докази або файл.', 'Please add an https link to the proof or a file.'],
    'c_err_cr_file' => ['Файл доказів: лише PDF, JPG чи PNG до 5 МБ.', 'Proof file: PDF, JPG or PNG up to 5 MB only.'],
    'c_err_cr_good_faith' => ['Підтвердьте, що інформація правдива і ви дієте добросовісно.', 'Please confirm the information is true and you act in good faith.'],
    'c_err_limit' => ['Забагато скарг за добу. Спробуйте завтра або напишіть на %s.', 'Too many complaints today. Try tomorrow or write to %s.'],
    'c_err_duplicate' => ['Ви вже скаржилися на це оголошення — скарга на розгляді.', 'You have already reported this listing — it is under review.'],
    'c_err_own' => ['Це ваше оголошення.', 'This is your own listing.'],
    'c_err_notfound' => ['Оголошення не знайдено.', 'Listing not found.'],
    'c_err_blocked' => ['Скарги з цього акаунта не приймаються.', 'Complaints from this account are not accepted.'],
    'c_err_save' => ['Не вдалося зберегти скаргу. Спробуйте ще раз або напишіть на %s.', 'Could not save the complaint. Try again or write to %s.'],
    'c_alt_email' => ['Також можна написати на %s.', 'You can also write to %s.'],

    // --- Контакти (п. 12) ---
    'contacts_note' => ['Контакти можна використовувати лише для зв\'язку щодо цього оголошення. Перегляд фіксується (п. 12.2–12.3).', 'Use these contacts only to discuss this listing. Views are logged (clauses 12.2–12.3).'],
    'contacts_limit' => ['Ви переглянули контакти %d разів за добу — це ліміт (п. 12.3 Правил). Спробуйте завтра.', 'You have viewed contacts %d times today, which is the limit (clause 12.3). Please try tomorrow.'],

    // --- Повідомлення (кабінет і листи) ---
    'n_approved' => ['Оголошення «{title}» опубліковано.', 'Your listing “{title}” has been published.'],
    'n_needs_changes' => ['Оголошення «{title}» повернуто на доопрацювання. Причина: {reason}', 'Your listing “{title}” was returned for changes. Reason: {reason}'],
    'n_rejected' => ['Оголошення «{title}» відхилено. Причина: {reason}', 'Your listing “{title}” was rejected. Reason: {reason}'],
    'n_moved' => ['Оголошення «{title}» перенесено в іншу категорію: {reason}', 'Your listing “{title}” was moved to another category: {reason}'],
    'n_hidden' => ['Оголошення «{title}» тимчасово приховано на час розгляду скарги.', 'Your listing “{title}” is temporarily hidden while a complaint is reviewed.'],
    'n_removed' => ['Оголошення «{title}» знято з публікації. Причина: {reason}', 'Your listing “{title}” was removed. Reason: {reason}'],
    'n_copyright' => ['На оголошення «{title}» надійшла скарга про порушення прав. Ви можете подати заперечення до {until}.', 'A rights infringement complaint was filed about “{title}”. You can file a counter-notice until {until}.'],
    'n_appeal_restored' => ['Оскарження щодо «{title}» задоволено — оголошення відновлено. {reason}', 'Your appeal about “{title}” was granted — the listing is restored. {reason}'],
    'n_appeal_upheld' => ['Оскарження щодо «{title}» розглянуто: рішення залишено в силі. {reason}', 'Your appeal about “{title}” was reviewed: the decision stands. {reason}'],
    'n_expiring' => ['Строк публікації «{title}» закінчується {until}. Продовжте його в кабінеті.', 'Your listing “{title}” expires on {until}. You can extend it in your account.'],
    'n_warning' => ['Адміністрація винесла вам попередження за порушення Правил Marketplace. {reason}', 'Moderators have issued you a warning for breaking the Marketplace Rules. {reason}'],
    'n_posting_banned' => ['Подачу оголошень обмежено до {until}. {reason}', 'Posting is restricted until {until}. {reason}'],
    'n_blocked' => ['Ваш акаунт заблоковано за порушення Правил Marketplace. {reason}', 'Your account has been blocked for breaking the Marketplace Rules. {reason}'],
    'n_unblocked' => ['Обмеження з вашого акаунта знято.', 'The restrictions on your account have been lifted.'],
    'mail_subject' => ['AI LAB HUB Marketplace: {title}', 'AI LAB HUB Marketplace: {title}'],
    'mail_footer' => ["Мої оголошення: {cabinet}\nПравила Marketplace: {rules}\nОскарження й скарги: {abuse}", "My listings: {cabinet}\nMarketplace Rules: {rules}\nAppeals and complaints: {abuse}"],
    'forever' => ['безстроково', 'indefinitely'],
];

/** Мова словника: uk або en (інші мови інтерфейсу — англійською). */
function mpl_lang(): string
{
    return function_exists('current_lang') && current_lang() === 'uk' ? 'uk' : 'en';
}

/** Рядок мовою інтерфейсу, з sprintf-аргументами. Невідомий ключ → сам ключ. */
function mpl_tr(string $key, mixed ...$args): string
{
    $pair = MPL_I18N[$key] ?? null;
    if ($pair === null) {
        return $key;
    }
    $s = mpl_lang() === 'uk' ? $pair[0] : $pair[1];

    return $args === [] ? $s : vsprintf($s, $args);
}

/** Рядок указаною мовою з підстановкою {name} (для листів і повідомлень). */
function mpl_tr_lang(string $key, string $lang, array $vars = []): string
{
    $pair = MPL_I18N[$key] ?? [$key, $key];
    $s = $lang === 'uk' ? $pair[0] : $pair[1];
    foreach ($vars as $k => $v) {
        $s = str_replace('{' . $k . '}', (string) $v, $s);
    }

    return trim($s);
}
