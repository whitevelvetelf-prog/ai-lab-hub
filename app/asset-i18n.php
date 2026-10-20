<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тексти «Цифрових матеріалів» маркетплейсу (UA/EN).
 *
 * Окремий словник, як app/listing-i18n.php. Мова — ast_lang() (мова інтерфейсу сесії). Плейсхолдери
 * інтерфейсу — sprintf (%s), листів — {name} (ast_tr_lang()). Адмінка — лише українською (тексти в коді).
 *
 * ЧЕСНІСТЬ: ніде не обіцяємо «повного захисту» чи «гарантій» — лише називаємо реальні заходи.
 */

const AST_I18N = [
    // Розділ
    'nav' => ['Цифрові матеріали', 'Digital assets'],
    'sub' => ['Зображення, ілюстрації й персонажі від авторів — з ліцензією, що показана біля кожного превʼю.', 'Images, illustrations and characters from their authors — with the licence shown next to every preview.'],
    'post_btn' => ['Опублікувати матеріал', 'Publish an asset'],
    'kind_image' => ['Зображення', 'Image'],
    'kind_illustration' => ['Ілюстрація', 'Illustration'],
    'kind_character' => ['Персонаж', 'Character'],
    'kinds_all' => ['Усі види', 'All kinds'],
    'licenses_all' => ['Усі ліцензії', 'All licences'],
    'filter_kind' => ['Вид', 'Kind'],
    'filter_license' => ['Ліцензія', 'Licence'],
    'filter_q' => ['Пошук', 'Search'],
    'filter_apply' => ['Показати', 'Show'],
    'filter_reset' => ['Скинути', 'Reset'],
    'found' => ['Знайдено: %d', 'Found: %d'],
    'empty' => ['Поки що немає опублікованих матеріалів.', 'No published assets yet.'],
    'empty_search' => ['За цими умовами нічого не знайдено.', 'Nothing matches these filters.'],
    'pages' => ['Сторінки', 'Pages'],

    // Походження
    'origin_human' => ['Створено вручну', 'Made by hand'],
    'origin_ai_assisted' => ['Створено за участі AI', 'Made with AI assistance'],
    'origin_ai_generated' => ['Повністю згенеровано AI', 'Fully AI-generated'],
    'origin_label' => ['Походження', 'Origin'],

    // Сторінка активу
    'author' => ['Автор', 'Author'],
    'license' => ['Ліцензія', 'Licence'],
    'license_full' => ['Повні умови ліцензії', 'Full licence terms'],
    'tags' => ['Теги', 'Tags'],
    'character_name' => ['Ім’я персонажа', 'Character name'],
    'character_terms' => ['Умови використання персонажа', 'Character usage terms'],
    'published' => ['Опубліковано', 'Published'],
    'preview_note' => ['Показано зменшене превʼю з водяним знаком. Оригінал зберігається приватно.', 'A reduced preview with a watermark is shown. The original is stored privately.'],
    'download_btn' => ['Завантажити оригінал', 'Download the original'],
    'download_accept' => ['Я прочитав(-ла) умови ліцензії «%s» і приймаю їх.', 'I have read and accept the terms of the “%s” licence.'],
    'download_login' => ['Щоб завантажити оригінал, увійдіть в акаунт.', 'Log in to download the original.'],
    'download_not_allowed' => ['Оригінал за цією ліцензією не завантажується.', 'The original cannot be downloaded under this licence.'],
    'download_contact' => ['Зв’язатися з автором', 'Contact the author'],
    'download_limit' => ['Ліміт завантажень на сьогодні вичерпано. Спробуйте завтра.', 'Today’s download limit is reached. Please try again tomorrow.'],
    'download_need_accept' => ['Позначте, що приймаєте умови ліцензії.', 'Please confirm that you accept the licence terms.'],
    'download_expired' => ['Посилання для завантаження застаріло або вже використане. Почніть ще раз зі сторінки матеріалу.', 'The download link has expired or was already used. Start again from the asset page.'],
    'download_note' => ['У виданий файл додаються метадані: автор, ліцензія й унікальний номер завантаження.', 'The issued file contains metadata: author, licence and a unique download number.'],
    'report_btn' => ['Повідомити про порушення авторських прав', 'Report a copyright infringement'],
    'policy_link' => ['Політика авторських прав', 'Copyright policy'],
    'contact_reveal' => ['Показати контакт автора', 'Show the author’s contact'],
    'contact_none' => ['Автор не залишив контакту. Напишіть через форму скарги, якщо йдеться про порушення.', 'The author left no contact.'],
    'guard_note' => ['Збереження превʼю через контекстне меню вимкнено — це лише легка перешкода, а не захист.', 'Saving the preview via the context menu is disabled — this is only a light obstacle, not protection.'],

    // Форма публікації
    'form_title_new' => ['Новий цифровий матеріал', 'New digital asset'],
    'form_title_edit' => ['Редагування матеріалу', 'Edit asset'],
    'form_intro' => ['Після надсилання матеріал перевіряє модератор. Публічними стають лише схвалені матеріали; оригінал зберігається приватно, на сайті показується зменшене превʼю з водяним знаком.', 'After submission a moderator reviews the asset. Only approved assets become public; the original is stored privately and the site shows a reduced watermarked preview.'],
    'protection_title' => ['Як ми захищаємо роботу (і де межі)', 'How we protect your work (and the limits)'],
    'protection_text' => ['Оригінал не має прямої адреси й видається лише за умовами вашої ліцензії. Превʼю зменшене, без EXIF/GPS і з водяним знаком по всьому зображенню. Ми ведемо журнал завантажень, рахуємо хеш оригіналу й шукаємо схожі зображення. Повністю унеможливити копіювання того, що показується на екрані, неможливо (знімок екрана) — тому ці заходи зменшують цінність копій і допомагають довести авторство й швидко видаляти порушення.', 'The original has no direct address and is issued only under your licence terms. The preview is reduced, stripped of EXIF/GPS and covered by a watermark across the whole image. We log downloads, hash the original and look for similar images. Nothing shown on a screen can be made fully copy-proof (screenshots exist) — these measures reduce the value of copies and help prove authorship and remove infringements quickly.'],
    'f_kind' => ['Вид матеріалу', 'Asset kind'],
    'f_file' => ['Файл (PNG, JPG або WebP, до %d МБ)', 'File (PNG, JPG or WebP, up to %d MB)'],
    'f_file_keep' => ['Залиште порожнім, щоб не змінювати файл.', 'Leave empty to keep the current file.'],
    'f_title' => ['Назва', 'Title'],
    'f_alt' => ['Альтернативний текст (що зображено) — обов’язково', 'Alt text (what is shown) — required'],
    'f_alt_hint' => ['Коротко опишіть зображення для людей, які не бачать його: «Рудий кіт у космічному шоломі на тлі Місяця».', 'Briefly describe the image for people who cannot see it: “A ginger cat in a space helmet in front of the Moon”.'],
    'f_desc' => ['Опис', 'Description'],
    'f_tags' => ['Теги через кому', 'Tags, comma-separated'],
    'f_char_name' => ['Ім’я персонажа', 'Character name'],
    'f_char_desc' => ['Короткий опис персонажа', 'Short character description'],
    'f_char_terms' => ['Умови використання персонажа', 'Character usage terms'],
    'f_license' => ['Ліцензія', 'Licence'],
    'f_license_custom' => ['Ваші умови (для «Власних умов»; модератор перевіряє текст)', 'Your terms (for “Author’s own terms”; reviewed by a moderator)'],
    'f_allow_download' => ['Дозволити завантаження оригіналу залогіненим користувачам, які приймуть ліцензію', 'Allow logged-in users who accept the licence to download the original'],
    'f_allow_download_hint' => ['Для «Лише перегляд» і «Комерційна за домовленістю» оригінал не завантажується в будь-якому разі.', 'For “View only” and “Commercial by agreement” the original is never downloadable.'],
    'f_ccby_warning' => ['Увага: CC BY 4.0 дозволяє будь-кому використовувати й змінювати роботу, зокрема комерційно, якщо зазначено автора. Цю ліцензію не можна відкликати для вже отриманих копій.', 'Note: CC BY 4.0 lets anyone use and adapt the work, including commercially, with attribution. It cannot be revoked for copies already obtained.'],
    'f_origin' => ['Походження (обов’язково)', 'Origin (required)'],
    'f_origin_hint' => ['Правовий захист суто AI-згенерованих зображень у багатьох країнах обмежений або відсутній. За потреби порадьтеся з юристом.', 'In many countries, legal protection for purely AI-generated images is limited or absent. Consult a lawyer if needed.'],
    'f_watermark' => ['Щільність водяного знака на превʼю', 'Preview watermark density'],
    'wm_normal' => ['Звичайна', 'Normal'],
    'wm_high' => ['Висока', 'High'],
    'f_noimageindex' => ['Просити пошукові системи не індексувати превʼю (noimageindex)', 'Ask search engines not to index the preview (noimageindex)'],
    'f_ownership' => ['Я автор цієї роботи або маю права на її публікацію й передачу ліцензій; робота не порушує чужих прав.', 'I am the author of this work or hold the rights to publish it and grant licences; the work does not infringe anyone’s rights.'],
    'f_rules' => ['Я прочитав(-ла) правила маркетплейсу й політику авторських прав.', 'I have read the marketplace rules and the copyright policy.'],
    'f_submit' => ['Надіслати на модерацію', 'Submit for review'],
    'f_preview_wm' => ['Так виглядатиме водяний знак на превʼю:', 'This is how the watermark will look on the preview:'],
    'saved' => ['Матеріал надіслано на модерацію. Після схвалення він з’явиться в маркетплейсі.', 'The asset was sent for review. It will appear in the marketplace once approved.'],

    // Помилки
    'err_title' => ['Назва — від 3 до %d символів.', 'Title must be 3 to %d characters.'],
    'err_alt' => ['Альтернативний текст — від 5 до 300 символів.', 'Alt text must be 5 to 300 characters.'],
    'err_desc' => ['Опис — до %d символів.', 'Description must be up to %d characters.'],
    'err_kind' => ['Оберіть вид матеріалу.', 'Choose the asset kind.'],
    'err_origin' => ['Вкажіть походження роботи.', 'Specify the origin of the work.'],
    'err_license' => ['Оберіть ліцензію.', 'Choose a licence.'],
    'err_license_custom' => ['Для «Власних умов» опишіть умови (20–3000 символів).', 'For “Author’s own terms” describe the terms (20–3000 characters).'],
    'err_char' => ['Для персонажа вкажіть ім’я (до 120 символів).', 'For a character give a name (up to 120 characters).'],
    'err_ownership' => ['Підтвердьте, що маєте права на роботу.', 'Confirm that you hold the rights to the work.'],
    'err_rules' => ['Підтвердьте, що прочитали правила.', 'Confirm that you have read the rules.'],
    'err_file_required' => ['Додайте файл зображення.', 'Add an image file.'],
    'err_file_size' => ['Файл завеликий: максимум %d МБ.', 'The file is too large: maximum %d MB.'],
    'err_file_type' => ['Дозволені лише PNG, JPG і WebP (перевіряється вміст файлу, а не розширення).', 'Only PNG, JPG and WebP are allowed (the file content is checked, not the extension).'],
    'err_file_broken' => ['Не вдалося прочитати зображення. Збережіть його ще раз і спробуйте знову.', 'The image could not be read. Re-save it and try again.'],
    'err_file_dims' => ['Зображення завелике за розміром у пікселях (максимум %d мегапікселів).', 'The image has too many pixels (maximum %d megapixels).'],
    'err_upload' => ['Файл не завантажився. Спробуйте ще раз.', 'The file did not upload. Please try again.'],
    'err_no_gd' => ['Публікація матеріалів тимчасово недоступна: на сервері немає бібліотеки обробки зображень. Адміністратора повідомлено.', 'Publishing assets is temporarily unavailable: the server lacks an image processing library. The administrator has been notified.'],
    'err_duplicate' => ['Цей самий файл уже опубліковано на сайті.', 'This exact file is already published on the site.'],
    'err_too_fast' => ['Форму надіслано надто швидко. Перевірте поля й надішліть ще раз.', 'The form was submitted too quickly. Check the fields and submit again.'],
    'err_pending_limit' => ['На модерації вже %d ваших матеріали — дочекайтеся рішення.', 'You already have %d assets under review — please wait for a decision.'],
    'err_blocked' => ['Публікацію матеріалів для вашого акаунта призупинено через повторні порушення авторських прав.', 'Publishing assets is suspended for your account due to repeated copyright infringements.'],
    'err_save' => ['Не вдалося зберегти. Спробуйте ще раз.', 'Could not save. Please try again.'],
    'err_stopword' => ['Текст містить заборонені слова.', 'The text contains prohibited words.'],
    'rate_limited' => ['Забагато запитів. Спробуйте трохи пізніше.', 'Too many requests. Please try again a bit later.'],

    // Мої активи
    'my_title' => ['Мої цифрові матеріали', 'My digital assets'],
    'my_empty' => ['Ви ще не публікували матеріали.', 'You have not published any assets yet.'],
    'my_col_asset' => ['Матеріал', 'Asset'],
    'my_col_status' => ['Статус', 'Status'],
    'my_col_stats' => ['Перегляди / завантаження', 'Views / downloads'],
    'my_col_claims' => ['Скарги', 'Claims'],
    'my_col_actions' => ['Дії', 'Actions'],
    'my_edit' => ['Редагувати', 'Edit'],
    'my_remove' => ['Зняти', 'Remove'],
    'my_extend' => ['Продовжити', 'Extend'],
    'my_proof' => ['Підтвердження публікації', 'Publication record'],
    'my_counter' => ['Подати зустрічну заяву', 'File a counter-notice'],
    'st_pending' => ['На модерації', 'Under review'],
    'st_published' => ['Опубліковано', 'Published'],
    'st_rejected' => ['Відхилено', 'Rejected'],
    'st_archived' => ['Знято', 'Removed'],
    'st_expired' => ['Термін минув', 'Expired'],
    'st_disabled' => ['Приховано через скаргу', 'Hidden due to a claim'],
    'removed_ok' => ['Матеріал знято з публікації.', 'The asset was removed.'],
    'extended_ok' => ['Термін продовжено.', 'The term was extended.'],

    // Підтвердження публікації
    'proof_title' => ['Підтвердження публікації', 'Publication record'],
    'proof_note' => ['Це технічний запис AI LAB HUB про те, що файл із наведеним хешем завантажив указаний акаунт у вказаний час. Це не юридичне свідоцтво й не підтвердження авторства третьою стороною.', 'This is an AI LAB HUB technical record stating that the file with the given hash was uploaded by the given account at the given time. It is not a legal certificate or third-party proof of authorship.'],
    'proof_sha' => ['SHA-256 оригіналу', 'Original SHA-256'],
    'proof_uploaded' => ['Завантажено (UTC)', 'Uploaded (UTC)'],
    'proof_account' => ['Акаунт', 'Account'],
    'proof_print' => ['Надрукувати або зберегти як PDF', 'Print or save as PDF'],
    'proof_size' => ['Розмір і тип', 'Size and type'],

    // Скарги
    'claim_title' => ['Повідомити про порушення авторських прав', 'Report a copyright infringement'],
    'claim_intro' => ['Форма для правовласників і їхніх представників. Акаунт не потрібен. Ми розглянемо заяву й повідомимо результат на вказану пошту.', 'For rights holders and their representatives. No account is needed. We will review the notice and reply to the email given.'],
    'claim_listing' => ['Посилання на матеріал або його номер', 'Link to the asset or its number'],
    'claim_what' => ['Що саме порушено (яка ваша робота, чим порушення)', 'What is infringed (your work, how it is infringed)'],
    'claim_evidence' => ['Докази: посилання на оригінал, дати публікації, інше', 'Evidence: links to the original, publication dates, other'],
    'claim_name' => ['Ваше ім’я (як підпис)', 'Your name (as signature)'],
    'claim_email' => ['E-mail для відповіді', 'Email for the reply'],
    'claim_contact' => ['Інший контакт (необов’язково)', 'Other contact (optional)'],
    'claim_good_faith' => ['Я добросовісно вважаю, що використання не дозволене правовласником чи законом, а відомості в заяві точні; я правовласник або маю право діяти від його імені.', 'I believe in good faith that the use is not authorised by the rights holder or the law, the information in this notice is accurate, and I am the rights holder or authorised to act on their behalf.'],
    'claim_send' => ['Надіслати заяву', 'Send the notice'],
    'claim_sent' => ['Дякуємо. Заяву №%d отримано, ми повідомимо результат на вказану пошту.', 'Thank you. Notice #%d was received; we will reply by email.'],
    'claim_err' => ['Заповніть обов’язкові поля й підтвердьте добросовісність заяви.', 'Fill in the required fields and confirm the good-faith statement.'],
    'counter_title' => ['Зустрічна заява', 'Counter-notice'],
    'counter_intro' => ['Якщо ви вважаєте, що скарга помилкова (у вас є права на роботу), поясніть це й додайте докази до %s. Адміністратор розгляне заяву й повідомить обидві сторони.', 'If you believe the claim is mistaken (you hold the rights), explain why and add evidence by %s. An administrator will review it and notify both parties.'],
    'counter_text' => ['Пояснення й докази', 'Explanation and evidence'],
    'counter_send' => ['Надіслати зустрічну заяву', 'Send the counter-notice'],
    'counter_sent' => ['Зустрічну заяву надіслано.', 'The counter-notice was sent.'],
    'counter_closed' => ['Строк зустрічної заяви минув або скаргу вже розглянуто.', 'The counter-notice period has ended or the claim was already decided.'],
    'cst_new' => ['Нова', 'New'],
    'cst_under_review' => ['На розгляді', 'Under review'],
    'cst_content_disabled' => ['Матеріал приховано', 'Content disabled'],
    'cst_counter_notice' => ['Зустрічна заява', 'Counter-notice'],
    'cst_restored' => ['Відновлено', 'Restored'],
    'cst_rejected' => ['Скаргу відхилено', 'Claim rejected'],

    // Політика
    'policy_title' => ['Політика авторських прав', 'Copyright policy'],

    // Листи
    'mail_footer' => ['— AI LAB HUB, {site}', '— AI LAB HUB, {site}'],
    'mail_asset_received_subject' => ['Матеріал «{title}» отримано', 'Asset “{title}” received'],
    'mail_asset_received_body' => ['Ваш матеріал «{title}» надіслано на модерацію. Після схвалення він з’явиться в маркетплейсі. Кабінет: {cabinet}', 'Your asset “{title}” was sent for review. It will appear in the marketplace once approved. Account: {cabinet}'],
    'mail_asset_approved_subject' => ['Матеріал «{title}» опубліковано', 'Asset “{title}” is published'],
    'mail_asset_approved_body' => ['Ваш матеріал «{title}» схвалено й опубліковано: {url}', 'Your asset “{title}” was approved and published: {url}'],
    'mail_asset_rejected_subject' => ['Матеріал «{title}» не схвалено', 'Asset “{title}” was not approved'],
    'mail_asset_rejected_body' => ['На жаль, матеріал «{title}» не схвалено. Причина: {reason}. Ви можете виправити й надіслати знову: {cabinet}', 'Unfortunately, the asset “{title}” was not approved. Reason: {reason}. You can fix it and resubmit: {cabinet}'],
    'mail_asset_proof_subject' => ['Матеріал «{title}»: потрібні підтвердження авторства', 'Asset “{title}”: proof of authorship needed'],
    'mail_asset_proof_body' => ['Модератор просить підтвердити авторство матеріалу «{title}»: {reason}. Надішліть, будь ласка, процесні файли, ескізи або посилання на портфоліо у відповідь на цей лист.', 'A moderator asks you to confirm authorship of the asset “{title}”: {reason}. Please reply to this email with process files, sketches or a portfolio link.'],
    'mail_claim_owner_subject' => ['Скарга на матеріал «{title}»', 'A claim about your asset “{title}”'],
    'mail_claim_owner_body' => ['На ваш матеріал «{title}» надійшла скарга на порушення авторських прав (№{claim}). {hidden}Якщо ви вважаєте скаргу помилковою, подайте зустрічну заяву до {deadline}: {counter}', 'A copyright claim (#{claim}) was filed about your asset “{title}”. {hidden}If you believe the claim is mistaken, file a counter-notice by {deadline}: {counter}'],
    'mail_claim_hidden' => ['До розгляду матеріал тимчасово приховано. ', 'The asset is temporarily hidden pending review. '],
    'mail_claim_decision_subject' => ['Рішення за скаргою №{claim}', 'Decision on claim #{claim}'],
    'mail_claim_decision_body' => ['Рішення за скаргою №{claim} щодо матеріалу «{title}»: {decision}. {note}', 'Decision on claim #{claim} about the asset “{title}”: {decision}. {note}'],
];

function ast_lang(): string
{
    return function_exists('current_lang') && current_lang() === 'en' ? 'en' : 'uk';
}

/** Текст мовою інтерфейсу; аргументи — sprintf. */
function ast_tr(string $key, mixed ...$args): string
{
    $pair = AST_I18N[$key] ?? null;
    if ($pair === null) {
        return $key;
    }
    $txt = ast_lang() === 'en' ? $pair[1] : $pair[0];

    return $args === [] ? $txt : vsprintf($txt, $args);
}

/** Текст заданою мовою з плейсхолдерами {name} (листи). @param array<string,string> $vars */
function ast_tr_lang(string $key, string $lang, array $vars = []): string
{
    $pair = AST_I18N[$key] ?? null;
    if ($pair === null) {
        return $key;
    }
    $repl = [];
    foreach ($vars as $k => $v) {
        $repl['{' . $k . '}'] = (string) $v;
    }

    return strtr($lang === 'en' ? $pair[1] : $pair[0], $repl);
}

function ast_e(mixed $v): string
{
    return htmlspecialchars((string) $v, ENT_QUOTES);
}
