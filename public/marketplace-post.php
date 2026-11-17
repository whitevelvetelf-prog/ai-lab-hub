<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: подача й редагування оголошення (будь-який залогінений користувач).
 *
 *   marketplace-post.php            — крок 1: вибір блока (плитки, як на головній Marketplace)
 *   marketplace-post.php?block=S    — крок 2: форма для блока S (solution | goods | other) з підкатегоріями
 *                                     (чекбокси, 1–3, лише свого блока). Вакансії/курси/послуги → listing-post.php?type=S,
 *                                     «Цифрові матеріали» → asset-post.php
 *   marketplace-post.php?id=N       — редагування (лише власні; чуже/неіснуюче → 404); &block=S — інший блок
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
require_once __DIR__ . '/../app/mpb-rules.php';
require_once __DIR__ . '/../app/mp-geo-form.php';
require_once __DIR__ . '/../app/mp-drafts.php';

mp_public_or_staff_require();   // при public_enabled=false — лише employee/admin (публіка: 404)

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

// Поетапний запуск: поки posting_enabled = false, подавати й редагувати можуть лише employee/admin (сервер, GET і POST).
if (!mpb_posting_open()) {
    mpb_posting_closed_page();
}

header('Cache-Control: no-store');
// Порядок: гість → вхід/реєстрація з поверненням сюди; пошта не підтверджена → екран «Підтвердьте пошту»
// ДО показу форми (з поверненням сюди після підтвердження).
$userId = mpb_require_login();
$user = auth_current_user($pdo);
if ($user === null) {
    header('Location: ' . auth_login_url(auth_current_next()));
    exit;
}
mpv_require_verified($pdo, $userId);   // публікація й редагування — лише з підтвердженим email (staff звільнені)
mpl_require_can_post($pdo, $userId);   // попередження/заборона подачі/блокування (п. 7.3–7.4): зрозуміле повідомлення з посиланням на п. 7.5

// Після відправлення (PRG): «Оголошення на модерації, відповімо протягом N год» + «Мої оголошення».
$sentId = (int) ($_GET['sent'] ?? 0);
if ($sentId > 0 && ($sent = mpb_own_listing($pdo, $sentId, $userId)) !== null) {
    require_once __DIR__ . '/../app/listing.php';   // lst_settings(): спільна «мета розгляду»
    $reviewHours = (int) lst_settings($pdo)['review_hours'];
    $isPending = (string) $sent['status'] === 'pending';
    mpb_message_page(
        200,
        $isPending ? mpf_tr('sent_title') : t('mpb_saved_published'),
        ($isPending ? '<p class="mp-text">' . mp_e(mpf_tr('sent_text', $reviewHours)) . '</p>' : '')
        . '<p class="mp-actions"><a class="mp-btn mp-btn--primary" href="marketplace-my.php?tab=pending">' . mp_e(mpf_tr('sent_my')) . '</a></p>',
        null
    );
}

$cfg = mp_config();
$lang = current_lang();
$isStaff = mpb_is_staff();
$maxPhotos = (int) $cfg['photo_max_count'];

// --- Редагування: лише власне оголошення ------------------------------------
$id = (int) ($_GET['id'] ?? 0);
$existing = null;
if ($id > 0) {
    $existing = mpb_own_listing($pdo, $id, $userId);
    if ($existing === null) {
        mp_not_found();
    }
    // Приховане на час розгляду скарги чи зняте адміністрацією — не редагується (лише оскарження, п. 7.5).
    if (in_array((string) $existing['status'], ['hidden', 'removed'], true)) {
        mpb_message_page(403, mpl_status_label((string) $existing['status']), '<p class="mp-text">'
            . mp_e(mpl_reason_text($existing['reject_code'] ?? null, $existing['reject_reason'] ?? null)) . '</p><p class="mp-text">'
            . sprintf(mp_e(mpl_tr('ban_appeal')), '<a href="marketplace-rules.php#section-7-5">' . mp_e(mpl_tr('ban_appeal_link')) . '</a>', '<a href="mailto:' . mp_e(MP_ABUSE_EMAIL) . '">' . mp_e(MP_ABUSE_EMAIL) . '</a>')
            . '</p><p class="mp-actions"><a class="mp-btn" href="marketplace-my.php?tab=attention">' . mp_e(t('mpb_my_title')) . '</a></p>', null);
    }
}

// --- Блок дерева категорій ------------------------------------------------------
$tree = mpt_tree($pdo, $lang);
$reqBlock = is_string($_GET['block'] ?? null) ? (string) $_GET['block'] : '';
$allowedBlocks = MPT_AD_SECTIONS;
if ($existing !== null && !in_array((string) $existing['section'], $allowedBlocks, true)) {
    $allowedBlocks[] = (string) $existing['section'];   // оголошення з колишньої дошки в блоці послуг тощо
}
if ($existing === null && $reqBlock !== '' && !in_array($reqBlock, $allowedBlocks, true)) {
    if (in_array($reqBlock, MPT_LST_SECTIONS, true) || $reqBlock === 'asset') {
        header('Location: ' . mpt_post_url($reqBlock), true, 303);
        exit;
    }
    $reqBlock = '';
}
$blockSec = in_array($reqBlock, $allowedBlocks, true) ? $reqBlock : ($existing !== null ? (string) $existing['section'] : '');
$block = $blockSec !== '' ? mpt_block($tree, $blockSec) : null;
if ($block === null) {
    // Крок 1: вибір блока (картки як на головній Marketplace). Є чернетка — «Продовжити заповнення».
    $draftRow = mpd_get($pdo, $userId, 'board');
    $draftBlock = is_string($draftRow['data']['block'] ?? null) && in_array($draftRow['data']['block'], MPT_AD_SECTIONS, true) ? (string) $draftRow['data']['block'] : '';
    $items = [];
    foreach ($tree as $b) {
        $items[] = [$b['name'], $b['icon'], mpt_post_url($b['section']), null];
    }
    $assets = mpt_assets_tile(['cats' => [], 'blocks' => [], 'assets' => 1]);
    if ($assets !== null) {
        array_splice($items, max(0, count($items) - 1), 0, [[$assets[0], $assets[1], 'asset-post.php', null]]);
    }
    mpt_open(t('mpb_post_title') . ' — ' . t('title_marketplace'), t('mpt_pick_block'), 'marketplace-post.php', true, 'post');
    echo '<div class="mp-page">' . mpt_crumbs([[t('mp_heading'), 'marketplace.php'], [t('mpb_post_title'), null]])
        . '<h1 class="mp-title">' . mp_e(t('mpb_post_title')) . '</h1><p class="mp-subtitle">' . mp_e(t('mpt_pick_block')) . '</p>';
    if ($draftBlock !== '') {
        echo '<p class="mp-note mp-note--box"><a class="mp-btn" href="marketplace-post.php?block=' . mp_e($draftBlock) . '">'
            . mp_e(mpf_tr('draft_continue')) . '</a> ' . mp_e($draftRow['title'] !== '' ? $draftRow['title'] : mpf_tr('draft_untitled')) . '</p>';
    }
    echo '<div class="mpt-pick">' . mpt_tiles($items, t('mpt_pick_block')) . '</div></div>';
    mpt_close();
    exit;
}
$categories = mpb_categories($pdo, $lang, $blockSec);
$catIds = array_column($categories, 'id');

// --- Початкові значення ------------------------------------------------------
$v = [
    'title' => '', 'short_desc' => '', 'full_desc' => '', 'categories' => [],
    'price_type' => 'none', 'price_amount' => '', 'currency' => 'UAH',
    'is_remote' => true, 'city' => '',
    'contact_name' => (string) $user['name'], 'contact_phone' => '', 'contact_telegram' => '', 'contact_email' => '',
    'rules' => false,
    // Правила Marketplace: п. 4.5 (AI-медіа) і п. 9.5 (умови використання цифрового продукту).
    'ai_media' => false, 'usage' => '', 'usage_note' => '',
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
        'ai_media' => (int) ($existing['ai_generated_media'] ?? 0) === 1,
        'usage' => (string) ($existing['usage_terms'] ?? ''), 'usage_note' => (string) ($existing['usage_terms_note'] ?? ''),
    ];
    $photos = mpb_photos($pdo, $id);
}
// Блок «Де надається» (етап 6): формат, місто з автопідказки, охоплення — app/mp-geo.php.
$geoV = $existing !== null ? mpg_form_from_listing($pdo, $existing) : mpg_form_defaults();
$geoReady = mpg_ready($pdo);

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
        $v['ai_media'] = ($_POST['ai_media'] ?? '') === '1';
        $v['usage'] = in_array($str('usage_terms'), MPL_USAGE_TERMS, true) ? $str('usage_terms') : '';
        $v['usage_note'] = mb_substr($str('usage_terms_note'), 0, 200);
        if ($v['usage'] === 'other' && $v['usage_note'] === '') {
            $errors[] = 'mpl:usage_err_other';
        }

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
        if ($block['children'] === []) {
            $v['categories'] = $catIds;   // блок без підкатегорій («Інше») — категорія сам блок
        }
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

        // Де надається (етап 6) — замість вільного тексту міста; без міграцій — старі поля місто / дистанційно.
        if ($geoReady) {
            $geoV = mpg_form_from_post($_POST);
            $geo = mpg_validate($pdo, $geoV, $errors);
            $v['is_remote'] = $geo['work_format'] !== 'offline';
        } else {
            if (!$v['is_remote'] && $v['city'] === '') {
                $errors[] = 'mpb_err_location';
            }
            if (mb_strlen($v['city']) > 120) {
                $errors[] = 'mpb_err_city_long';
            }
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

        // Ліміти й збереження — під блокуванням користувача: паралельні запити з різних сесій не обходять
        // ліміт активних/за добу. Блокування звільняється наприкінці запиту (shutdown) або при закритті з'єднання.
        $postLock = 'mp_post_' . $userId;
        if (mpb_lock($pdo, $postLock)) {
            register_shutdown_function(static function () use ($pdo, $postLock): void {
                try {
                    mpb_unlock($pdo, $postLock);
                } catch (Throwable) {
                }
            });
        } else {
            $errors[] = 'mpb_err_save';
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

        // IP-ліміт нових оголошень (другий шар; лише створення, лише не-staff) — реєструємо, коли все інше пройшло
        if ($errors === [] && $existing === null && !$isStaff && !mpb_ip_hit($pdo, 'post', (int) $cfg['ip_limit_post'])) {
            $errors[] = 'mpb_rate_limited';
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
                    'section' => $blockSec, 'categories' => $v['categories'], 'price_type' => $v['price_type'],
                    'price_amount' => $priceAmount, 'currency' => $currency,
                    'is_remote' => $v['is_remote'], 'city' => $v['city'] !== '' ? $v['city'] : null,
                    'contact' => $contact,
                    // Курс береться до транзакції (може звернутися до НБУ); немає курсу → NULL.
                    'geo' => $geoReady ? $geo + ['price_usd' => mpg_price_usd($pdo, $priceAmount, $currency)] : null,
                ], $existing, $userId, $sellerId, $lang, $created, $deleteIds, $photoOrder);
                mpl_save_listing_extras($pdo, $savedId, $v['ai_media'], $v['usage'], $v['usage_note']);

                if ($existing === null) {
                    mpd_delete($pdo, $userId, 'board');   // чернетку подано — більше не потрібна
                }
                if ($isStaff) {
                    mpb_flash('ok', t('mpb_saved_published'));
                    mpb_redirect('marketplace-my.php?tab=active');
                }
                mpb_redirect('marketplace-post.php?sent=' . $savedId);
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
$priceLabels = ['none' => t('mpb_pt_none'), 'free' => t('mpb_pt_free'), 'fixed' => t('mpb_pt_fixed'), 'negotiable' => t('mpb_pt_negotiable'), 'exchange' => t('mpb_pt_exchange')];
$formAction = 'marketplace-post.php?' . http_build_query(($existing !== null ? ['id' => $id] : []) + ['block' => $blockSec]);
// Помилки біля полів (ключ t() → поле); решта — у загальному блоці вгорі.
$errField = [
    'mpb_err_title' => 'title', 'mpb_err_short' => 'short_desc', 'mpb_err_full' => 'full_desc', 'mpb_err_links' => 'full_desc',
    'mpb_err_categories' => 'categories', 'mpb_err_price_type' => 'price', 'mpb_err_price_amount' => 'price',
    'mpb_err_location' => 'location', 'mpb_err_city_long' => 'location', 'mpb_err_contact_required' => 'contacts',
    'mpb_err_phone' => 'contacts', 'mpb_err_telegram' => 'contacts', 'mpb_err_email' => 'contacts', 'mpb_err_rules' => 'rules',
    'mpb_err_photo_count' => 'photos', 'mpb_err_photo_size' => 'photos', 'mpb_err_photo_type' => 'photos',
    'mpb_err_photo_upload' => 'photos', 'mpb_err_photo_process' => 'photos', 'mpb_err_duplicate' => 'title',
    'mpl:usage_err_other' => 'usage',
];
$byField = [];
$generalErrors = [];
foreach ($errors as $err) {
    $k = is_array($err) ? (string) $err[0] : (string) $err;
    $msg = str_starts_with($k, 'mpl:') ? mpl_tr(substr($k, 4))   // рядки Правил — app/mp-legal-i18n.php
        : (is_array($err) ? sprintf(t($err[0]), ...array_slice($err, 1)) : t($err));
    if (isset($errField[$k])) {
        $byField[$errField[$k]][] = $msg;
    } else {
        $generalErrors[] = $msg;
    }
}
$fieldErr = static fn(string $f): string => isset($byField[$f])
    ? '<p class="mpf-error" id="err_' . mp_e($f) . '">' . mp_e(implode(' ', $byField[$f])) . '</p>' : '';
$invalid = static fn(string $f): string => isset($byField[$f]) ? ' aria-invalid="true" aria-describedby="err_' . mp_e($f) . '"' : '';
// Автозбереження чернетки (лише нове оголошення); відновлення — коли форма відкрита вперше.
$draft = $existing === null
    ? mpd_form_bits($pdo, $userId, 'board', ($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST')
    : ['attrs' => '', 'html' => ''];

mpb_open($pageTitle, true, 'post');
?>
    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= mp_e($pageTitle) ?></h1>
        <p class="mp-subtitle"><?= mp_e(t($isStaff ? 'mpb_post_note_staff' : 'mpb_post_note')) ?></p>

        <?php if ($existing !== null && in_array((string) $existing['status'], ['rejected', 'needs_changes'], true) && (!empty($existing['reject_reason']) || !empty($existing['reject_code']))): ?>
            <div class="mp-alert mp-alert--error"><strong><?= mp_e(mpl_status_label((string) $existing['status'])) ?>.</strong>
                <?= mp_e(mpl_reason_text($existing['reject_code'] ?? null, $existing['reject_reason'] ?? null)) ?></div>
        <?php endif; ?>

        <?php if ($errors !== []): ?>
            <div class="mp-alert mp-alert--error" role="alert">
                <p><strong><?= mp_e(mpf_tr('errors_below')) ?></strong></p>
                <?php if ($generalErrors !== []): ?><ul class="mp-alert__list">
                    <?php foreach ($generalErrors as $msg): ?><li><?= mp_e($msg) ?></li><?php endforeach; ?>
                </ul><?php endif; ?>
            </div>
        <?php endif; ?>
        <?= $draft['html'] ?>

        <form class="mp-form mpf-form" method="post" action="<?= mp_e($formAction) ?>" enctype="multipart/form-data" novalidate<?= $draft['attrs'] ?>>
            <?= mp_csrf_field() ?>
            <div class="mp-hp" aria-hidden="true">
                <label>Website <input type="text" name="website" value="" tabindex="-1" autocomplete="off"></label>
            </div>

            <p class="mp-hint"><?= mp_e(mpf_tr('required_note')) ?></p>

            <fieldset class="mpf-block" id="blk-section">
                <legend class="mpf-block__title"><?= mp_e(mpf_tr('blk_section')) ?></legend>
                <input type="hidden" name="block" value="<?= mp_e($blockSec) ?>">
                <p class="mp-text"><?= mp_e(t('mpt_block_label')) ?>: <strong><?= mp_e($block['name']) ?></strong>
                    <?php if ($existing === null): ?> · <a href="marketplace-post.php"><?= mp_e(t('mpt_change_block')) ?></a><?php endif; ?>
                </p>
                <?php if ($existing !== null && in_array((string) $existing['section'], MPT_AD_SECTIONS, true)): ?>
                    <p class="mp-hint"><?= mp_e(t('mpt_change_block')) ?>:
                        <?php foreach (MPT_AD_SECTIONS as $abs): ?>
                            <?php $ab = mpt_block($tree, $abs); ?>
                            <?php if ($ab !== null && $abs !== $blockSec): ?><a class="mp-chip" href="marketplace-post.php?id=<?= (int) $id ?>&amp;block=<?= mp_e($abs) ?>"><?= mp_e($ab['name']) ?></a><?php endif; ?>
                        <?php endforeach; ?>
                    </p>
                <?php endif; ?>
            <?php if ($block['children'] !== []): ?>
            <fieldset class="mp-field mp-fieldset">
                <legend class="mp-label"><?= mp_e(t('mpb_f_categories')) ?> <span class="mpf-req">*</span></legend>
                <div class="mp-checks">
                    <?php foreach ($categories as $c): ?>
                        <label class="mp-check"><input type="checkbox" name="cats[]" value="<?= (int) $c['id'] ?>"<?= in_array($c['id'], $v['categories'], true) ? ' checked' : '' ?>> <span><?= mp_e($c['name']) ?></span></label>
                    <?php endforeach; ?>
                </div>
                <p class="mp-hint"><?= mp_e(t('mpb_f_categories_hint')) ?></p>
                <?= $fieldErr('categories') ?>
            </fieldset>
            <?php endif; ?>
            </fieldset>
            <fieldset class="mpf-block" id="blk-main">
                <legend class="mpf-block__title"><?= mp_e(mpf_tr('blk_main')) ?></legend>
            <div class="mp-field">
                <label class="mp-label" for="title"><?= mp_e(t('mpb_f_title')) ?> <span class="mpf-req">*</span></label>
                <input class="mp-input" type="text" id="title" name="title" maxlength="200" required value="<?= mp_e($v['title']) ?>"<?= $invalid('title') ?>>
                <?= $fieldErr('title') ?>
            </div>

            <div class="mp-field">
                <label class="mp-label" for="short_desc"><?= mp_e(t('mpb_f_short')) ?> <span class="mpf-req">*</span></label>
                <textarea class="mp-input" id="short_desc" name="short_desc" rows="3" maxlength="500" required<?= $invalid('short_desc') ?>><?= mp_e($v['short_desc']) ?></textarea>
                <?= $fieldErr('short_desc') ?>
                <p class="mp-hint"><?= mp_e(t('mpb_f_short_hint')) ?></p>
            </div>

            <div class="mp-field">
                <label class="mp-label" for="full_desc"><?= mp_e(t('mpb_f_full')) ?></label>
                <textarea class="mp-input" id="full_desc" name="full_desc" rows="8" maxlength="5000"<?= $invalid('full_desc') ?>><?= mp_e($v['full_desc']) ?></textarea>
                <?= $fieldErr('full_desc') ?>
                <p class="mp-hint"><?= mp_e(sprintf(t('mpb_f_full_hint'), (int) $cfg['max_links_in_desc'])) ?></p>
            </div>

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
                    <?= $fieldErr('price') ?>
                </div>
            </div>

            <div class="mp-field">
                <label class="mp-check mp-check--block">
                    <input type="checkbox" name="ai_media" value="1"<?= $v['ai_media'] ? ' checked' : '' ?>>
                    <span><?= mp_e(mpl_tr('ai_media_label')) ?></span>
                </label>
                <p class="mp-hint"><?= mp_e(mpl_tr('ai_media_hint')) ?></p>
            </div>

            <div class="mp-row">
                <div class="mp-field">
                    <label class="mp-label" for="usage_terms"><?= mp_e(mpl_tr('usage_label')) ?></label>
                    <select class="mp-input" id="usage_terms" name="usage_terms"<?= $invalid('usage') ?>>
                        <option value=""><?= mp_e(mpl_tr('usage_none')) ?></option>
                        <?php foreach (MPL_USAGE_TERMS as $ut): ?>
                            <option value="<?= mp_e($ut) ?>"<?= $v['usage'] === $ut ? ' selected' : '' ?>><?= mp_e(mpl_tr('usage_' . $ut)) ?></option>
                        <?php endforeach; ?>
                    </select>
                    <p class="mp-hint"><?= mp_e(mpl_tr('usage_hint')) ?></p>
                </div>
                <div class="mp-field" id="usageNoteBox">
                    <label class="mp-label" for="usage_terms_note"><?= mp_e(mpl_tr('usage_other')) ?></label>
                    <input class="mp-input" type="text" id="usage_terms_note" name="usage_terms_note" maxlength="200" placeholder="<?= mp_e(mpl_tr('usage_other_ph')) ?>" value="<?= mp_e($v['usage_note']) ?>">
                    <?= $fieldErr('usage') ?>
                </div>
            </div>

            </fieldset>
            <fieldset class="mpf-block" id="blk-place">
                <legend class="mpf-block__title"><?= mp_e(mpf_tr('blk_place')) ?></legend>
            <?php if ($geoReady): ?>
                <?= mpg_form_html($pdo, $geoV, $lang) ?>
            <?php else: ?>
            <div class="mp-row">
                <div class="mp-field">
                    <label class="mp-label" for="city"><?= mp_e(t('mpb_f_city')) ?></label>
                    <input class="mp-input" type="text" id="city" name="city" maxlength="120" value="<?= mp_e($v['city']) ?>">
                </div>
                <div class="mp-field mp-field--check">
                    <label class="mp-check"><input type="checkbox" name="is_remote" value="1"<?= $v['is_remote'] ? ' checked' : '' ?>> <span><?= mp_e(t('mpb_f_remote')) ?></span></label>
                </div>
            </div>
            <?php endif; ?>
                <?= $fieldErr('location') ?>
            </fieldset>
            <fieldset class="mpf-block" id="blk-contacts">
                <legend class="mpf-block__title"><?= mp_e(mpf_tr('blk_contacts')) ?></legend>
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
                <?= $fieldErr('contacts') ?>
            </fieldset>
            <fieldset class="mpf-block" id="blk-photos">
                <legend class="mpf-block__title"><?= mp_e(mpf_tr('blk_photos')) ?></legend>
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
                <?= $fieldErr('photos') ?>
            </fieldset>
            <fieldset class="mpf-block" id="blk-rules">
                <legend class="mpf-block__title"><?= mp_e(mpf_tr('blk_rules')) ?></legend>
            <div class="mp-field">
                <label class="mp-check mp-check--block">
                    <input type="checkbox" name="rules" value="1" required<?= $v['rules'] ? ' checked' : '' ?>>
                    <span><?= mp_e(mpl_tr('consent_label')) ?> <a href="marketplace-rules.php" target="_blank" rel="noopener"><?= mp_e(mpl_tr('rules_link')) ?></a> <span class="mpf-req">*</span></span>
                </label>
                <?= $fieldErr('rules') ?>
            </div>

            <div class="mp-actions">
                <button class="mp-btn mp-btn--primary mp-btn--lg" type="submit"><?= mp_e(t($existing === null ? 'mpb_submit_new' : 'mpb_submit_save')) ?></button>
                <a class="mp-btn" href="marketplace-my.php"><?= mp_e(t('mpb_cancel')) ?></a>
            </div>
            </fieldset>
        </form>
    </div>
    <script src="/assets/js/mp-draft.js?v=<?= (int) @filemtime(__DIR__ . '/assets/js/mp-draft.js') ?>" defer></script>
    <script>
    (function () {
        var type = document.getElementById('price_type');
        var box = document.getElementById('priceBox');
        function sync() { box.style.display = type.value === 'fixed' ? '' : 'none'; }
        type.addEventListener('change', sync);
        sync();
        // Умови використання: поле «Інше» — лише коли вибрано «Інше».
        var usage = document.getElementById('usage_terms'), note = document.getElementById('usageNoteBox');
        function syncUsage() { note.style.display = usage.value === 'other' ? '' : 'none'; }
        usage.addEventListener('change', syncUsage);
        syncUsage();
        // Згода з Правилами (п. 1.5): перевірка й на клієнті (форма novalidate — підказки біля полів дає сервер).
        var form = document.querySelector('form.mpf-form'), rules = form && form.querySelector('input[name="rules"]');
        if (form && rules) {
            form.addEventListener('submit', function (e) {
                if (rules.checked) { return; }
                e.preventDefault();
                rules.setCustomValidity(<?= json_encode(mpl_tr('consent_err'), JSON_UNESCAPED_UNICODE | JSON_HEX_TAG) ?>);
                rules.reportValidity();
                rules.focus();
            });
            rules.addEventListener('change', function () { rules.setCustomValidity(''); });
        }
    })();
    </script>
<?php mpb_close(); ?>
