<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: подача й редагування оголошення (будь-який залогінений користувач).
 *
 *   mp-post.php          — нове оголошення
 *   mp-post.php?id=N     — редагування (лише власні; чуже/неіснуюче → 404)
 *
 * Оголошення звичайного користувача після збереження отримує status='pending' (модерація);
 * employee/admin публікують одразу. delivery_type завжди 'contact': контакти показує mp-contact.php.
 * Захист: CSRF, honeypot, ліміти активних/за добу, антидубль назви в межах продавця, стоп-слова,
 * ≤2 посилань в описах, обов'язкова згода з Правилами.
 * Потрібен підтверджений email (mpv_require_verified; employee/admin звільнені).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-email.php';   // підключає marketplace-board.php

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$userId = mpb_require_login();
$user = auth_current_user($pdo);
if ($user === null) {
    header('Location: login.php');
    exit;
}
mpv_require_verified($pdo, $userId);   // публікація й редагування — лише з підтвердженим email (staff звільнені)

$cfg = mp_config();
$lang = current_lang();
$isStaff = mpb_is_staff();
$categories = mpb_categories($pdo, $lang);
$catIds = array_column($categories, 'id');
$maxPhotos = (int) $cfg['photo_max_count'];

// --- Редагування: лише власне оголошення ------------------------------------
$id = (int) ($_GET['id'] ?? 0);
$existing = null;
if ($id > 0) {
    $existing = mpb_own_listing($pdo, $id, $userId);
    if ($existing === null) {
        mp_not_found();
    }
}

// --- Початкові значення ------------------------------------------------------
$v = [
    'title' => '', 'short_desc' => '', 'full_desc' => '', 'categories' => [],
    'price_type' => 'free', 'price_amount' => '', 'currency' => 'UAH',
    'is_remote' => true, 'city' => '',
    'contact_name' => (string) $user['name'], 'contact_phone' => '', 'contact_telegram' => '', 'contact_email' => '',
    'rules' => false,
];
$photos = [];
if ($existing !== null) {
    $tx = $pdo->prepare('SELECT title, short_desc, full_desc FROM mp_listing_translations WHERE listing_id = :id AND lang = :lang');
    $tx->execute([':id' => $id, ':lang' => (string) $existing['source_lang']]);
    $t0 = $tx->fetch(PDO::FETCH_ASSOC) ?: ['title' => '', 'short_desc' => '', 'full_desc' => ''];
    $cs = $pdo->prepare('SELECT category_id FROM mp_listing_categories WHERE listing_id = :id');
    $cs->execute([':id' => $id]);
    $v = [
        'title' => (string) $t0['title'], 'short_desc' => (string) ($t0['short_desc'] ?? ''), 'full_desc' => (string) ($t0['full_desc'] ?? ''),
        'categories' => array_map('intval', $cs->fetchAll(PDO::FETCH_COLUMN)),
        'price_type' => (string) $existing['price_type'],
        'price_amount' => $existing['price_amount'] !== null ? rtrim(rtrim((string) $existing['price_amount'], '0'), '.') : '',
        'currency' => (string) ($existing['currency'] ?? 'UAH'),
        'is_remote' => (int) $existing['is_remote'] === 1, 'city' => (string) ($existing['city'] ?? ''),
        'contact_name' => (string) ($existing['contact_name'] ?? ''), 'contact_phone' => (string) ($existing['contact_phone'] ?? ''),
        'contact_telegram' => (string) ($existing['contact_telegram'] ?? ''), 'contact_email' => (string) ($existing['contact_email'] ?? ''),
        'rules' => false,   // згоду підтверджують при кожному збереженні
    ];
    $photos = mpb_photos($pdo, $id);
}

// --- Обробка форми -----------------------------------------------------------
$errors = [];   // string (ключ t()) або [ключ, аргументи для sprintf]
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if ($_POST === [] && (int) ($_SERVER['CONTENT_LENGTH'] ?? 0) > 0) {
        // Перевищено post_max_size — PHP відкинув усе тіло запиту.
        $errors[] = 'mpb_err_post_too_big';
    } elseif (!mp_csrf_verify()) {
        http_response_code(403);
        mpb_message_page(403, t('mpb_err_csrf_title'), '<p class="mp-text">' . mp_e(t('mpb_err_csrf')) . '</p>', 'marketplace.php');
    } elseif ((string) ($_POST['website'] ?? '') !== '') {
        // Honeypot заповнили — це бот.
        error_log('[marketplace] honeypot triggered, user ' . $userId);
        mpb_message_page(400, t('mpb_err_generic_title'), '<p class="mp-text">' . mp_e(t('mpb_err_spam')) . '</p>', 'marketplace.php');
    } else {
        $str = static fn(string $k): string => is_string($_POST[$k] ?? null) ? trim((string) $_POST[$k]) : '';

        $v['title'] = mb_substr($str('title'), 0, 400);
        $v['short_desc'] = mb_substr($str('short_desc'), 0, 1000);
        $v['full_desc'] = mb_substr($str('full_desc'), 0, 10000);
        $v['categories'] = array_values(array_unique(array_map('intval', is_array($_POST['cats'] ?? null) ? $_POST['cats'] : [])));
        $v['price_type'] = $str('price_type');
        $v['price_amount'] = $str('price_amount');
        $v['currency'] = $str('currency');
        $v['is_remote'] = ($_POST['is_remote'] ?? '') === '1';
        $v['city'] = mb_substr($str('city'), 0, 240);
        foreach (['contact_name', 'contact_phone', 'contact_telegram', 'contact_email'] as $k) {
            $v[$k] = mb_substr($str($k), 0, 300);
        }
        $v['rules'] = ($_POST['rules'] ?? '') === '1';

        // Назва й описи
        $titleLen = mb_strlen($v['title']);
        if ($titleLen < 3 || $titleLen > 200) {
            $errors[] = 'mpb_err_title';
        }
        $shortLen = mb_strlen($v['short_desc']);
        if ($shortLen < 10 || $shortLen > 500) {
            $errors[] = 'mpb_err_short';
        }
        if (mb_strlen($v['full_desc']) > 5000) {
            $errors[] = 'mpb_err_full';
        }

        // Категорії (лише активні категорії дошки, 1–3)
        $v['categories'] = array_values(array_intersect($v['categories'], $catIds));
        if ($v['categories'] === [] || count($v['categories']) > 3) {
            $errors[] = 'mpb_err_categories';
        }

        // Ціна
        $priceAmount = null;
        $currency = null;
        if (!in_array($v['price_type'], MPB_PRICE_TYPES, true)) {
            $errors[] = 'mpb_err_price_type';
        } elseif ($v['price_type'] === 'fixed') {
            $num = str_replace([' ', ','], ['', '.'], $v['price_amount']);
            if (preg_match('/^\d{1,8}(\.\d{1,2})?$/', $num) !== 1 || (float) $num <= 0) {
                $errors[] = 'mpb_err_price_amount';
            } else {
                $priceAmount = number_format((float) $num, 2, '.', '');
            }
            if (!isset(MPB_CURRENCIES[$v['currency']])) {
                $v['currency'] = 'UAH';
            }
            $currency = $v['currency'];
        }

        // Місто / дистанційно
        if (!$v['is_remote'] && $v['city'] === '') {
            $errors[] = 'mpb_err_location';
        }
        if (mb_strlen($v['city']) > 120) {
            $errors[] = 'mpb_err_city_long';
        }

        // Контакти
        $contact = mpb_normalize_contacts($v, $errors);

        // Згода з Правилами
        if (!$v['rules']) {
            $errors[] = 'mpb_err_rules';
        }

        // Спам-перевірки тексту
        $maxLinks = (int) $cfg['max_links_in_desc'];
        if (mpb_count_links($v['title'] . "\n" . $v['short_desc'] . "\n" . $v['full_desc']) > $maxLinks) {
            $errors[] = ['mpb_err_links', $maxLinks];
        }
        if (mpb_stop_word($v['title'], $v['short_desc'], $v['full_desc']) !== null) {
            $errors[] = 'mpb_err_stopword';
        }

        // Фото: що видаляємо, у якому порядку лишаємо, що додаємо
        $existingIds = array_column($photos, 'id');
        $deleteIds = array_values(array_intersect(
            array_map('intval', is_array($_POST['photo_delete'] ?? null) ? $_POST['photo_delete'] : []),
            $existingIds
        ));
        $keepPhotos = array_values(array_filter($photos, static fn(array $p): bool => !in_array($p['id'], $deleteIds, true)));
        $orderIn = is_array($_POST['photo_order'] ?? null) ? $_POST['photo_order'] : [];
        usort($keepPhotos, static function (array $a, array $b) use ($orderIn): int {
            $oa = is_numeric($orderIn[$a['id']] ?? null) ? (int) $orderIn[$a['id']] : $a['sort_order'];
            $ob = is_numeric($orderIn[$b['id']] ?? null) ? (int) $orderIn[$b['id']] : $b['sort_order'];

            return [$oa, $a['sort_order'], $a['id']] <=> [$ob, $b['sort_order'], $b['id']];
        });
        $photoOrder = array_column($keepPhotos, 'id');
        $coverId = (int) ($_POST['photo_cover'] ?? 0);
        if ($coverId > 0 && in_array($coverId, $photoOrder, true)) {
            $photoOrder = array_merge([$coverId], array_values(array_diff($photoOrder, [$coverId])));
        }
        $uploads = mpb_uploaded_photos();
        if (count($photoOrder) + count($uploads) > $maxPhotos) {
            $errors[] = ['mpb_err_photo_count', $maxPhotos];
        }
        $inspected = [];
        foreach ($uploads as $up) {
            $res = mpb_inspect_photo($up);
            if (is_string($res)) {
                $errors[] = $res;
            } else {
                $inspected[] = $res;
            }
        }

        // Ліміти й антидубль (employee/admin не обмежуються)
        $sellerId = $existing !== null ? (int) $existing['seller_id'] : null;
        if ($existing === null) {
            $lookup = $pdo->prepare('SELECT id FROM mp_sellers WHERE user_id = :u ORDER BY id LIMIT 1');
            $lookup->execute([':u' => $userId]);
            $found = $lookup->fetchColumn();
            $sellerId = $found === false ? null : (int) $found;
        }
        if (!$isStaff) {
            if ($existing === null && mpb_new_today_count($pdo, $userId) >= (int) $cfg['max_new_per_day']) {
                $errors[] = ['mpb_err_limit_day', (int) $cfg['max_new_per_day']];
            }
            $becomesActive = $existing === null || !in_array((string) $existing['status'], ['pending', 'published'], true);
            if ($becomesActive && mpb_active_count($pdo, $userId, $id) >= (int) $cfg['max_active_per_user']) {
                $errors[] = ['mpb_err_limit_active', (int) $cfg['max_active_per_user']];
            }
        }
        if ($sellerId !== null && mpb_seller_has_title($pdo, $sellerId, $v['title'], $id)) {
            $errors[] = 'mpb_err_duplicate';
        }

        // Збереження
        if ($errors === []) {
            $created = [];
            try {
                foreach ($inspected as $ins) {
                    $created[] = mpb_process_photo($ins['tmp'], $ins['mime']);
                }
                $sellerId ??= mpb_seller_for_user($pdo, $userId, (string) $user['name']);
                $savedId = mpb_save_listing($pdo, [
                    'title' => $v['title'], 'short_desc' => $v['short_desc'], 'full_desc' => $v['full_desc'],
                    'categories' => $v['categories'], 'price_type' => $v['price_type'],
                    'price_amount' => $priceAmount, 'currency' => $currency,
                    'is_remote' => $v['is_remote'], 'city' => $v['city'] !== '' ? $v['city'] : null,
                    'contact' => $contact,
                ], $existing, $userId, $sellerId, $lang, $created, $deleteIds, $photoOrder);

                mpb_flash('ok', t($isStaff ? 'mpb_saved_published' : 'mpb_saved_pending'));
                mpb_redirect('mp-my.php?tab=' . ($isStaff ? 'active' : 'pending'));
            } catch (Throwable $e) {
                // mpb_save_listing сам прибирає файли при збої; тут — лише ті, що не дійшли до нього.
                if (!isset($savedId)) {
                    foreach ($created as $c) {
                        mpb_delete_photo_files($c['file_name'], $c['thumb_name']);
                    }
                }
                error_log('[marketplace] save failed: ' . $e->getMessage());
                $errors[] = $e instanceof RuntimeException && str_contains($e->getMessage(), 'image') ? 'mpb_err_photo_process' : 'mpb_err_save';
            }
        }
    }
}

$pageTitle = t($existing === null ? 'mpb_post_title' : 'mpb_edit_title');
$currencyKeys = array_keys(MPB_CURRENCIES);
$priceLabels = ['free' => t('mpb_pt_free'), 'fixed' => t('mpb_pt_fixed'), 'negotiable' => t('mpb_pt_negotiable'), 'exchange' => t('mpb_pt_exchange')];
$formAction = 'mp-post.php' . ($existing !== null ? '?id=' . $id : '');

mpb_open($pageTitle);
?>
    <div class="mp-page mp-page--narrow">
        <a class="mp-back" href="mp-my.php"><?= mp_e(t('mpb_my_link')) ?></a>
        <h1 class="mp-title"><?= mp_e($pageTitle) ?></h1>
        <p class="mp-subtitle"><?= mp_e(t($isStaff ? 'mpb_post_note_staff' : 'mpb_post_note')) ?></p>

        <?php if ($existing !== null && (string) $existing['status'] === 'rejected' && !empty($existing['reject_reason'])): ?>
            <div class="mp-alert mp-alert--error"><strong><?= mp_e(t('mpb_reject_reason')) ?>:</strong> <?= mp_e($existing['reject_reason']) ?></div>
        <?php endif; ?>

        <?php if ($errors !== []): ?>
            <div class="mp-alert mp-alert--error" role="alert">
                <ul class="mp-alert__list">
                    <?php foreach ($errors as $e): ?>
                        <li><?= mp_e(is_array($e) ? sprintf(t($e[0]), ...array_slice($e, 1)) : t($e)) ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <form class="mp-form" method="post" action="<?= mp_e($formAction) ?>" enctype="multipart/form-data" novalidate>
            <?= mp_csrf_field() ?>
            <div class="mp-hp" aria-hidden="true">
                <label>Website <input type="text" name="website" value="" tabindex="-1" autocomplete="off"></label>
            </div>

            <div class="mp-field">
                <label class="mp-label" for="title"><?= mp_e(t('mpb_f_title')) ?></label>
                <input class="mp-input" type="text" id="title" name="title" maxlength="200" required value="<?= mp_e($v['title']) ?>">
            </div>

            <div class="mp-field">
                <label class="mp-label" for="short_desc"><?= mp_e(t('mpb_f_short')) ?></label>
                <textarea class="mp-input" id="short_desc" name="short_desc" rows="3" maxlength="500" required><?= mp_e($v['short_desc']) ?></textarea>
                <p class="mp-hint"><?= mp_e(t('mpb_f_short_hint')) ?></p>
            </div>

            <div class="mp-field">
                <label class="mp-label" for="full_desc"><?= mp_e(t('mpb_f_full')) ?></label>
                <textarea class="mp-input" id="full_desc" name="full_desc" rows="8" maxlength="5000"><?= mp_e($v['full_desc']) ?></textarea>
                <p class="mp-hint"><?= mp_e(sprintf(t('mpb_f_full_hint'), (int) $cfg['max_links_in_desc'])) ?></p>
            </div>

            <fieldset class="mp-field mp-fieldset">
                <legend class="mp-label"><?= mp_e(t('mpb_f_categories')) ?></legend>
                <div class="mp-checks">
                    <?php foreach ($categories as $c): ?>
                        <label class="mp-check"><input type="checkbox" name="cats[]" value="<?= (int) $c['id'] ?>"<?= in_array($c['id'], $v['categories'], true) ? ' checked' : '' ?>> <span><?= mp_e($c['name']) ?></span></label>
                    <?php endforeach; ?>
                </div>
                <p class="mp-hint"><?= mp_e(t('mpb_f_categories_hint')) ?></p>
            </fieldset>

            <div class="mp-row">
                <div class="mp-field">
                    <label class="mp-label" for="price_type"><?= mp_e(t('mpb_f_price_type')) ?></label>
                    <select class="mp-input" id="price_type" name="price_type">
                        <?php foreach ($priceLabels as $k => $label): ?>
                            <option value="<?= mp_e($k) ?>"<?= $v['price_type'] === $k ? ' selected' : '' ?>><?= mp_e($label) ?></option>
                        <?php endforeach; ?>
                    </select>
                    <p class="mp-hint"><?= mp_e(t('mpb_f_price_hint')) ?></p>
                </div>
                <div class="mp-field" id="priceBox">
                    <label class="mp-label" for="price_amount"><?= mp_e(t('mpb_f_price_amount')) ?></label>
                    <div class="mp-inline">
                        <input class="mp-input" type="text" inputmode="decimal" id="price_amount" name="price_amount" maxlength="12" value="<?= mp_e($v['price_amount']) ?>">
                        <select class="mp-input mp-input--short" name="currency" aria-label="<?= mp_e(t('mpb_f_currency')) ?>">
                            <?php foreach ($currencyKeys as $cur): ?>
                                <option value="<?= mp_e($cur) ?>"<?= $v['currency'] === $cur ? ' selected' : '' ?>><?= mp_e($cur) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>
            </div>

            <div class="mp-row">
                <div class="mp-field">
                    <label class="mp-label" for="city"><?= mp_e(t('mpb_f_city')) ?></label>
                    <input class="mp-input" type="text" id="city" name="city" maxlength="120" value="<?= mp_e($v['city']) ?>">
                </div>
                <div class="mp-field mp-field--check">
                    <label class="mp-check"><input type="checkbox" name="is_remote" value="1"<?= $v['is_remote'] ? ' checked' : '' ?>> <span><?= mp_e(t('mpb_f_remote')) ?></span></label>
                </div>
            </div>

            <fieldset class="mp-field mp-fieldset">
                <legend class="mp-label"><?= mp_e(t('mpb_f_contacts')) ?></legend>
                <p class="mp-hint"><?= mp_e(t('mpb_f_contacts_hint')) ?></p>
                <div class="mp-row">
                    <div class="mp-field">
                        <label class="mp-label" for="contact_name"><?= mp_e(t('mpb_contact_name')) ?></label>
                        <input class="mp-input" type="text" id="contact_name" name="contact_name" maxlength="100" value="<?= mp_e($v['contact_name']) ?>">
                    </div>
                    <div class="mp-field">
                        <label class="mp-label" for="contact_phone"><?= mp_e(t('mpb_contact_phone')) ?></label>
                        <input class="mp-input" type="tel" id="contact_phone" name="contact_phone" maxlength="40" value="<?= mp_e($v['contact_phone']) ?>" placeholder="+380…">
                    </div>
                </div>
                <div class="mp-row">
                    <div class="mp-field">
                        <label class="mp-label" for="contact_telegram">Telegram</label>
                        <input class="mp-input" type="text" id="contact_telegram" name="contact_telegram" maxlength="80" value="<?= mp_e($v['contact_telegram']) ?>" placeholder="@username">
                    </div>
                    <div class="mp-field">
                        <label class="mp-label" for="contact_email">Email</label>
                        <input class="mp-input" type="email" id="contact_email" name="contact_email" maxlength="190" value="<?= mp_e($v['contact_email']) ?>">
                    </div>
                </div>
            </fieldset>

            <fieldset class="mp-field mp-fieldset">
                <legend class="mp-label"><?= mp_e(sprintf(t('mpb_f_photos'), $maxPhotos)) ?></legend>
                <?php if ($photos !== []): ?>
                    <div class="mp-photo-edit">
                        <?php foreach ($photos as $i => $p): ?>
                            <div class="mp-photo-edit__item">
                                <img src="<?= mp_e(mpb_photo_url($p['thumb_name']) ?? '') ?>" alt="" loading="lazy">
                                <label class="mp-photo-edit__row"><?= mp_e(t('mpb_photo_order')) ?>
                                    <input class="mp-input mp-input--num" type="number" min="1" max="99" name="photo_order[<?= (int) $p['id'] ?>]" value="<?= $i + 1 ?>">
                                </label>
                                <label class="mp-photo-edit__row"><input type="radio" name="photo_cover" value="<?= (int) $p['id'] ?>"> <?= mp_e(t('mpb_photo_cover')) ?></label>
                                <label class="mp-photo-edit__row"><input type="checkbox" name="photo_delete[]" value="<?= (int) $p['id'] ?>"> <?= mp_e(t('mpb_photo_delete')) ?></label>
                            </div>
                        <?php endforeach; ?>
                    </div>
                <?php endif; ?>
                <input class="mp-input" type="file" name="photos[]" multiple accept="image/jpeg,image/png,image/webp">
                <p class="mp-hint"><?= mp_e(sprintf(t('mpb_f_photos_hint'), (int) round((int) $cfg['photo_max_bytes'] / 1048576))) ?></p>
            </fieldset>

            <div class="mp-field">
                <label class="mp-check mp-check--block">
                    <input type="checkbox" name="rules" value="1" required<?= $v['rules'] ? ' checked' : '' ?>>
                    <span><?= mp_e(t('mpb_f_rules_text')) ?> <a href="mp-rules.php" target="_blank" rel="noopener"><?= mp_e(t('mpb_f_rules_link')) ?></a></span>
                </label>
            </div>

            <div class="mp-actions">
                <button class="mp-btn mp-btn--primary mp-btn--lg" type="submit"><?= mp_e(t($existing === null ? 'mpb_submit_new' : 'mpb_submit_save')) ?></button>
                <a class="mp-btn" href="mp-my.php"><?= mp_e(t('mpb_cancel')) ?></a>
            </div>
        </form>
    </div>
    <script>
    (function () {
        var type = document.getElementById('price_type');
        var box = document.getElementById('priceBox');
        function sync() { box.style.display = type.value === 'fixed' ? '' : 'none'; }
        type.addEventListener('change', sync);
        sync();
    })();
    </script>
<?php mpb_close(); ?>
