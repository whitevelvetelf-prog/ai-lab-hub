<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM Marketplace: створення й редагування безкоштовної пропозиції
 * («Готові рішення»). Лише employee / admin. ?id=N — редагування.
 *
 * Тексти пишуться в mp_listing_translations (lang='uk', source_lang='uk'), категорії — в
 * mp_listing_categories. pricing_model завжди 'free' (price_amount/currency = NULL).
 * Файли — поза webroot (app/marketplace.php), обкладинка — public/assets/images/marketplace/covers.
 * Публічної частини й download.php ще немає (наступний етап).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

mp_require_staff();

$user = auth_current_user($pdo);
if ($user === null) {
    header('Location: login.php');
    exit;
}
$userId = (int) $user['id'];
$cfg = mp_config();

$listingId = (int) ($_GET['id'] ?? 0);

// --- AJAX: миттєва перевірка назви (як dupcheck у CRM каталогу) -----------
if (($_GET['ajax'] ?? '') === 'dupcheck') {
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode(
        mp_find_similar_titles($pdo, (string) ($_GET['title'] ?? ''), (int) ($_GET['exclude'] ?? 0)),
        JSON_UNESCAPED_UNICODE
    );
    exit;
}

$categories = mp_categories($pdo);
$validCatIds = array_column($categories, 'id');
$sellerId = mp_seller_id($pdo);

// --- Завантаження наявної пропозиції ---------------------------------------
$existing = null;
$existingFile = null;
$existingCats = [];
if ($listingId > 0) {
    $st = $pdo->prepare(
        "SELECT l.*, t.title, t.short_desc, t.full_desc, t.features, t.for_whom
         FROM mp_listings l
         LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = 'uk'
         WHERE l.id = :id AND l.section = 'solution'"
    );
    $st->execute([':id' => $listingId]);
    $existing = $st->fetch(PDO::FETCH_ASSOC) ?: null;
    if ($existing === null) {
        header('Location: mp-list.php');
        exit;
    }
    $cst = $pdo->prepare('SELECT category_id FROM mp_listing_categories WHERE listing_id = :id');
    $cst->execute([':id' => $listingId]);
    $existingCats = array_map('intval', $cst->fetchAll(PDO::FETCH_COLUMN));
    if ($existing['file_id'] !== null) {
        $fst = $pdo->prepare('SELECT id, original_name, size_bytes, scan_status FROM mp_files WHERE id = :id');
        $fst->execute([':id' => (int) $existing['file_id']]);
        $existingFile = $fst->fetch(PDO::FETCH_ASSOC) ?: null;
    }
}

// --- Значення форми ---------------------------------------------------------
$v = [
    'title'         => (string) ($existing['title'] ?? ''),
    'short_desc'    => (string) ($existing['short_desc'] ?? ''),
    'full_desc'     => (string) ($existing['full_desc'] ?? ''),
    'features'      => (string) ($existing['features'] ?? ''),
    'for_whom'      => (string) ($existing['for_whom'] ?? ''),
    'categories'    => $existingCats,
    'platform'      => (string) ($existing['platform'] ?? ''),
    'skill_level'   => (string) ($existing['skill_level'] ?? ''),
    'license'       => (string) ($existing['license'] ?? ''),
    'delivery_type' => (string) ($existing['delivery_type'] ?? 'link'),
    'delivery_url'  => (string) ($existing['delivery_url'] ?? ''),
    'status'        => (string) ($existing['status'] ?? 'draft'),
];
if (!isset(mp_form_statuses()[$v['status']])) {
    $v['status'] = 'draft'; // pending/rejected у формі не вибираються
}

$flash = $_SESSION['mp_flash'] ?? [];
unset($_SESSION['mp_flash']);
$errors = [];
$exactDups = [];
$similar = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!mp_csrf_verify()) {
        http_response_code(403);
        $errors[] = 'Форму не прийнято: сесія застаріла. Оновіть сторінку й спробуйте ще раз.';
    } elseif ($sellerId === null) {
        $errors[] = 'Не знайдено продавця «ailabhub» (mp_sellers) — застосуйте міграцію Marketplace.';
    } else {
        $str = static fn(string $k): string => is_string($_POST[$k] ?? null) ? trim((string) $_POST[$k]) : '';

        $v['title'] = $str('title');
        $v['short_desc'] = $str('short_desc');
        $v['full_desc'] = $str('full_desc');
        $v['features'] = $str('features');
        $v['for_whom'] = $str('for_whom');
        $v['platform'] = $str('platform');
        $v['skill_level'] = $str('skill_level');
        $v['license'] = $str('license');
        $v['delivery_type'] = $str('delivery_type');
        $v['delivery_url'] = $str('delivery_url');
        $v['status'] = $str('status');
        $v['categories'] = array_values(array_intersect(
            array_unique(array_map('intval', array_filter((array) ($_POST['categories'] ?? []), 'is_scalar'))),
            $validCatIds
        ));
        $removeCover = $str('remove_cover') === '1';
        $forceSave = $str('force_save') === '1';

        // --- Валідація ---
        if (mb_strlen($v['title']) < 3 || mb_strlen($v['title']) > 200) {
            $errors[] = 'Назва: від 3 до 200 символів.';
        }
        if (mb_strlen($v['short_desc']) > 500) {
            $errors[] = 'Короткий опис: не більше 500 символів (зараз ' . mb_strlen($v['short_desc']) . ').';
        }
        if (!isset(mp_form_statuses()[$v['status']])) {
            $errors[] = 'Оберіть статус: чернетка, опубліковано чи архів.';
        }
        if (!isset(mp_delivery_labels()[$v['delivery_type']])) {
            $errors[] = 'Оберіть тип видачі: посилання, файл чи контакт.';
        }
        if ($v['skill_level'] !== '' && !isset(mp_skill_labels()[$v['skill_level']])) {
            $errors[] = 'Некоректний рівень навичок.';
        }
        if (mb_strlen($v['platform']) > 100) {
            $errors[] = 'Платформа: не більше 100 символів.';
        }
        if (mb_strlen($v['license']) > 40) {
            $errors[] = 'Ліцензія: не більше 40 символів.';
        }

        $isPublished = $v['status'] === 'published';
        $dt = $v['delivery_type'];
        $fileInfo = null;
        $coverInfo = mp_inspect_cover($_FILES['cover_file'] ?? null, $errors);

        if ($dt === 'link') {
            if ($v['delivery_url'] === '') {
                if ($isPublished) {
                    $errors[] = 'Для публікації вкажіть посилання видачі (http/https).';
                }
            } elseif (!mp_is_http_url($v['delivery_url'])) {
                $errors[] = 'Посилання видачі має починатися з http:// або https:// (до 500 символів).';
            }
        } elseif ($dt === 'contact') {
            if ($v['delivery_url'] === '') {
                if ($isPublished) {
                    $errors[] = 'Для публікації вкажіть контакт: email або посилання.';
                }
            } elseif (!mp_is_contact($v['delivery_url'])) {
                $errors[] = 'Контакт має бути email-адресою або http/https-посиланням.';
            }
        } elseif ($dt === 'file') {
            $v['delivery_url'] = '';
            $fileInfo = mp_inspect_offer_file($_FILES['offer_file'] ?? null, $errors);
            if ($fileInfo === null && $existingFile === null && $isPublished && $errors === []) {
                $errors[] = 'Для публікації завантажте файл (pdf, md, txt, json, csv, zip).';
            }
        }

        if ($isPublished) {
            if ($v['short_desc'] === '') {
                $errors[] = 'Для публікації потрібен короткий опис.';
            }
            if ($v['categories'] === []) {
                $errors[] = 'Для публікації оберіть щонайменше одну категорію.';
            }
        }

        // --- Антидубль за назвою ---
        if (mb_strlen($v['title']) >= 3) {
            $dups = mp_find_similar_titles($pdo, $v['title'], $listingId);
            if ($dups['exact'] !== []) {
                $exactDups = $dups['exact'];
                $errors[] = 'Пропозиція з такою назвою вже є (див. нижче) — змініть назву або відредагуйте наявну.';
            } elseif ($dups['similar'] !== [] && !$forceSave) {
                $similar = $dups['similar'];
            }
        }

        // --- Збереження ---
        if ($errors === [] && $similar === []) {
            $storedFilePath = null;
            $storedCoverPath = null;
            $notices = [];
            try {
                $pdo->beginTransaction();

                $fileId = ($existing['file_id'] ?? null) !== null ? (int) $existing['file_id'] : null;
                if ($dt !== 'file') {
                    $fileId = null;
                } elseif ($fileInfo !== null) {
                    $saved = mp_save_offer_file($pdo, $fileInfo, $userId);
                    $fileId = $saved['id'];
                    if ($saved['existing']) {
                        $notices[] = 'Файл із таким самим вмістом (sha256) уже є в системі: №' . $saved['id'] . ' «' . $saved['original_name'] . '». Дубль не створено — до пропозиції прив\'язано наявний файл.';
                    } else {
                        $storedFilePath = $saved['stored_path'];
                        $notices[] = 'Файл збережено (перевірка вірусів: очікує).';
                    }
                }

                $coverValue = $existing['cover_image'] ?? null;
                if ($coverInfo !== null) {
                    $coverValue = mp_save_cover($coverInfo);
                    $storedCoverPath = (string) $cfg['cover_dir'] . '/' . basename($coverValue);
                } elseif ($removeCover) {
                    $coverValue = null;
                }

                // Перший перехід у published: published_at / moderated_at ставить сама БД (NOW() — той самий
                // час, що в created_at), а не PHP (інша часова зона).
                $pubNow = $isPublished && ($existing['published_at'] ?? null) === null ? 1 : 0;

                $params = [
                    ':status'   => $v['status'],
                    ':dt'       => $dt,
                    ':du'       => $dt === 'file' || $v['delivery_url'] === '' ? null : $v['delivery_url'],
                    ':fid'      => $fileId,
                    ':lic'      => $v['license'] !== '' ? $v['license'] : null,
                    ':cover'    => $coverValue,
                    ':platform' => $v['platform'] !== '' ? $v['platform'] : null,
                    ':skill'    => $v['skill_level'] !== '' ? $v['skill_level'] : null,
                    ':pn1'      => $pubNow,   // один параметр не можна повторювати (EMULATE_PREPARES = false)
                    ':pn2'      => $pubNow,
                    ':pn3'      => $pubNow,
                    ':modby'    => $userId,
                ];

                if ($existing === null) {
                    $ins = $pdo->prepare(
                        "INSERT INTO mp_listings
                            (section, seller_id, status, pricing_model, price_amount, currency, delivery_type, delivery_url, file_id,
                             license, cover_image, source_lang, platform, skill_level, created_by, moderated_by, moderated_at, published_at)
                         VALUES
                            ('solution', :seller, :status, 'free', NULL, NULL, :dt, :du, :fid,
                             :lic, :cover, 'uk', :platform, :skill, :uid,
                             IF(:pn1 = 1, :modby, NULL), IF(:pn2 = 1, NOW(), NULL), IF(:pn3 = 1, NOW(), NULL))"
                    );
                    $ins->execute($params + [':seller' => $sellerId, ':uid' => $userId]);
                    $savedId = (int) $pdo->lastInsertId();
                    mp_log($pdo, $savedId, $userId, 'created', 'статус: ' . $v['status']);
                } else {
                    $savedId = $listingId;
                    $upd = $pdo->prepare(
                        "UPDATE mp_listings SET status = :status, delivery_type = :dt, delivery_url = :du, file_id = :fid,
                            license = :lic, cover_image = :cover, platform = :platform, skill_level = :skill,
                            moderated_by = IF(:pn1 = 1, :modby, moderated_by),
                            moderated_at = IF(:pn2 = 1, NOW(), moderated_at),
                            published_at = IF(:pn3 = 1, NOW(), published_at)
                         WHERE id = :id AND section = 'solution'"
                    );
                    $upd->execute($params + [':id' => $savedId]);
                    if ($existing['status'] !== $v['status']) {
                        mp_log($pdo, $savedId, $userId, 'status:' . $existing['status'] . '→' . $v['status']);
                    }
                }

                $tr = $pdo->prepare(
                    "INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, full_desc, features, for_whom, is_auto)
                     VALUES (:id, 'uk', :title, :short, :full, :features, :for_whom, 0)
                     ON DUPLICATE KEY UPDATE title = VALUES(title), short_desc = VALUES(short_desc), full_desc = VALUES(full_desc),
                        features = VALUES(features), for_whom = VALUES(for_whom), is_auto = 0"
                );
                $tr->execute([
                    ':id' => $savedId, ':title' => $v['title'],
                    ':short' => $v['short_desc'] !== '' ? $v['short_desc'] : null,
                    ':full' => $v['full_desc'] !== '' ? $v['full_desc'] : null,
                    ':features' => $v['features'] !== '' ? $v['features'] : null,
                    ':for_whom' => $v['for_whom'] !== '' ? $v['for_whom'] : null,
                ]);

                // Категорії: додаємо нові, прибираємо зняті
                $toAdd = array_diff($v['categories'], $existingCats);
                $toDel = array_diff($existingCats, $v['categories']);
                $addSt = $pdo->prepare('INSERT IGNORE INTO mp_listing_categories (listing_id, category_id) VALUES (:l, :c)');
                foreach ($toAdd as $cid) {
                    $addSt->execute([':l' => $savedId, ':c' => (int) $cid]);
                }
                $delSt = $pdo->prepare('DELETE FROM mp_listing_categories WHERE listing_id = :l AND category_id = :c');
                foreach ($toDel as $cid) {
                    $delSt->execute([':l' => $savedId, ':c' => (int) $cid]);
                }

                $pdo->commit();
            } catch (Throwable $ex) {
                if ($pdo->inTransaction()) {
                    $pdo->rollBack();
                }
                foreach ([$storedFilePath, $storedCoverPath] as $p) {
                    if ($p !== null && is_file($p)) {
                        @unlink($p);
                    }
                }
                error_log('[mp-add-offer] ' . $ex->getMessage());
                $errors[] = 'Помилка збереження: ' . $ex->getMessage();
            }

            if ($errors === []) {
                $_SESSION['mp_flash'] = array_merge(
                    [$existing === null ? 'Пропозицію створено.' : 'Зміни збережено.'],
                    $notices
                );
                header('Location: mp-add-offer.php?id=' . $savedId);
                exit;
            }
        }
    }
}

$isEdit = $existing !== null;
$coverSrc = !empty($existing['cover_image']) ? '/assets/images/marketplace/' . $existing['cover_image'] : '';
$maxMb = round(((int) $cfg['max_upload_bytes']) / 1048576, 1);
?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Marketplace: <?= $isEdit ? 'редагування' : 'нова' ?> пропозиція</title>
    <link rel="stylesheet" href="/assets/css/crm-ads.css">
    <link rel="stylesheet" href="/assets/css/mp-crm.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="/logo.png" alt="AI LAB HUB">
        </a>
    </header>

    <div class="page page--narrow">
        <a class="back-link" href="mp-list.php">← До пропозицій</a>

        <h1 class="page__title"><?= $isEdit ? 'Пропозиція №' . $listingId : 'Нова пропозиція' ?></h1>
        <p class="page__subtitle">Marketplace › Готові рішення (безкоштовні). Публічної сторінки поки немає — це внутрішня CRM.</p>

        <?php foreach ($flash as $msg): ?>
            <div class="notice notice--success"><p><?= mp_e($msg) ?></p></div>
        <?php endforeach; ?>

        <?php if ($sellerId === null): ?>
            <div class="notice notice--error"><p>Не знайдено продавця «ailabhub» — застосуйте міграцію database/migration-2026-09-21-marketplace-core.sql.</p></div>
        <?php endif; ?>

        <?php if ($errors !== []): ?>
            <div class="notice notice--error">
                <p class="notice__title">Виправте помилки:</p>
                <ul>
                    <?php foreach ($errors as $error): ?>
                        <li><?= mp_e($error) ?></li>
                    <?php endforeach; ?>
                </ul>
                <?php if ($exactDups !== []): ?>
                    <ul class="similar-list">
                        <?php foreach ($exactDups as $d): ?>
                            <li class="similar-item"><a href="mp-add-offer.php?id=<?= (int) $d['id'] ?>"><?= mp_e($d['title']) ?></a>
                                <span class="table__muted">№<?= (int) $d['id'] ?> · <?= mp_e(mp_status_labels()[$d['status']] ?? $d['status']) ?></span></li>
                        <?php endforeach; ?>
                    </ul>
                <?php endif; ?>
            </div>
        <?php endif; ?>

        <?php if ($similar !== []): ?>
            <div class="notice notice--warn">
                <p class="notice__title">Знайдено схожі назви — це може бути дублікат:</p>
                <ul class="similar-list">
                    <?php foreach ($similar as $d): ?>
                        <li class="similar-item"><a href="mp-add-offer.php?id=<?= (int) $d['id'] ?>" target="_blank" rel="noopener"><?= mp_e($d['title']) ?></a>
                            <span class="table__muted">№<?= (int) $d['id'] ?> · <?= mp_e(mp_status_labels()[$d['status']] ?? $d['status']) ?></span></li>
                    <?php endforeach; ?>
                </ul>
                <p style="margin-top:10px;">Змініть назву або натисніть «Зберегти все одно». Файл і обкладинку, якщо вибирали, доведеться вибрати знову.</p>
            </div>
        <?php endif; ?>

        <form class="form" method="post" enctype="multipart/form-data" action="mp-add-offer.php<?= $isEdit ? '?id=' . $listingId : '' ?>" id="offerForm">
            <?= mp_csrf_field() ?>

            <div class="field">
                <label class="field__label" for="title">Назва <span class="req">*</span></label>
                <input class="input" type="text" id="title" name="title" maxlength="200" value="<?= mp_e($v['title']) ?>" required autocomplete="off">
                <p class="dupcheck" id="dupcheck" aria-live="polite"></p>
            </div>

            <div class="field">
                <label class="field__label" for="short_desc">Короткий опис <span class="field__hint" style="display:inline">(до 500 символів)</span></label>
                <textarea class="textarea" id="short_desc" name="short_desc" maxlength="500" rows="3"><?= mp_e($v['short_desc']) ?></textarea>
                <p class="counter" id="shortCounter"></p>
            </div>

            <div class="field">
                <label class="field__label" for="full_desc">Повний опис</label>
                <textarea class="textarea" id="full_desc" name="full_desc" rows="6"><?= mp_e($v['full_desc']) ?></textarea>
            </div>

            <div class="field">
                <label class="field__label" for="features">Основні функції</label>
                <textarea class="textarea" id="features" name="features" rows="4" placeholder="По одному пункту на рядок"><?= mp_e($v['features']) ?></textarea>
            </div>

            <div class="field">
                <label class="field__label" for="for_whom">Для кого призначено</label>
                <textarea class="textarea" id="for_whom" name="for_whom" rows="2"><?= mp_e($v['for_whom']) ?></textarea>
            </div>

            <div class="field">
                <span class="field__label">Категорії <span class="field__hint" style="display:inline">(для публікації — щонайменше одна)</span></span>
                <?php if ($categories === []): ?>
                    <p class="field__hint">Категорій ще немає (mp_categories).</p>
                <?php else: ?>
                    <div class="checks">
                        <?php foreach ($categories as $c): ?>
                            <label class="check"><input type="checkbox" name="categories[]" value="<?= (int) $c['id'] ?>"<?= in_array($c['id'], $v['categories'], true) ? ' checked' : '' ?>> <?= mp_e($c['name']) ?></label>
                        <?php endforeach; ?>
                    </div>
                <?php endif; ?>
            </div>

            <div class="field-row">
                <div class="field">
                    <label class="field__label" for="platform">Платформа / інструмент</label>
                    <input class="input" type="text" id="platform" name="platform" maxlength="100" value="<?= mp_e($v['platform']) ?>" placeholder="напр. ChatGPT, Claude, n8n">
                </div>
                <div class="field">
                    <label class="field__label" for="skill_level">Рівень навичок</label>
                    <select class="select" id="skill_level" name="skill_level">
                        <option value="">— не вказано —</option>
                        <?php foreach (mp_skill_labels() as $key => $label): ?>
                            <option value="<?= mp_e($key) ?>"<?= $v['skill_level'] === $key ? ' selected' : '' ?>><?= mp_e($label) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>

            <div class="field">
                <label class="field__label" for="license">Ліцензія</label>
                <input class="input" type="text" id="license" name="license" maxlength="40" list="licenseList" value="<?= mp_e($v['license']) ?>" placeholder="напр. CC BY 4.0, MIT">
                <datalist id="licenseList">
                    <option value="CC0"><option value="CC BY 4.0"><option value="CC BY-SA 4.0"><option value="MIT"><option value="Apache-2.0"><option value="Усі права захищено">
                </datalist>
            </div>

            <div class="field">
                <label class="field__label" for="delivery_type">Тип видачі</label>
                <select class="select" id="delivery_type" name="delivery_type">
                    <?php foreach (mp_delivery_labels() as $key => $label): ?>
                        <option value="<?= mp_e($key) ?>"<?= $v['delivery_type'] === $key ? ' selected' : '' ?>><?= mp_e($label) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="field delivery-panel" id="panelUrl">
                <label class="field__label" for="delivery_url" id="deliveryUrlLabel">Посилання видачі</label>
                <input class="input" type="text" id="delivery_url" name="delivery_url" maxlength="500" value="<?= mp_e($v['delivery_url']) ?>" placeholder="https://…">
                <p class="field__hint" id="deliveryUrlHint">Лише http:// або https://.</p>
            </div>

            <div class="field delivery-panel" id="panelFile">
                <label class="field__label" for="offer_file">Файл</label>
                <input class="input" type="file" id="offer_file" name="offer_file" accept=".pdf,.md,.txt,.json,.csv,.zip">
                <p class="field__hint">Формати: <?= mp_e(implode(', ', (array) $cfg['allowed_extensions'])) ?>; до <?= mp_e((string) $maxMb) ?> МБ. Перевіряється реальний тип вмісту. Зберігається поза публічною текою.</p>
                <?php if ($existingFile !== null): ?>
                    <p class="file-info">Поточний файл: <strong><?= mp_e($existingFile['original_name']) ?></strong>
                        <span>№<?= (int) $existingFile['id'] ?> · <?= mp_e(number_format((int) $existingFile['size_bytes'] / 1024, 1, '.', ' ')) ?> КБ · перевірка: <?= mp_e($existingFile['scan_status']) ?></span>
                        <span>Новий файл замінить його в цій пропозиції.</span></p>
                <?php endif; ?>
            </div>

            <div class="field">
                <label class="field__label" for="cover_file">Обкладинка</label>
                <?php if ($coverSrc !== ''): ?>
                    <img class="cover-preview" src="<?= mp_e($coverSrc) ?>" alt="">
                    <label class="check" style="margin-bottom:10px;"><input type="checkbox" name="remove_cover" value="1"> Прибрати обкладинку</label>
                <?php endif; ?>
                <input class="input" type="file" id="cover_file" name="cover_file" accept=".jpg,.jpeg,.png,.webp">
                <p class="field__hint">JPG, PNG або WEBP, до <?= mp_e((string) round(((int) $cfg['max_cover_bytes']) / 1048576, 1)) ?> МБ.</p>
            </div>

            <div class="field">
                <label class="field__label" for="status">Статус</label>
                <select class="select" id="status" name="status">
                    <?php foreach (mp_form_statuses() as $key => $label): ?>
                        <option value="<?= mp_e($key) ?>"<?= $v['status'] === $key ? ' selected' : '' ?>><?= mp_e($label) ?></option>
                    <?php endforeach; ?>
                </select>
                <p class="field__hint">
                    Для «Опубліковано» потрібні короткий опис, категорія й видача. Дата публікації ставиться при першому переході в «Опубліковано»<?php if ($isEdit && $existing['published_at'] !== null): ?> (зараз: <?= mp_e($existing['published_at']) ?>)<?php endif; ?>.
                    Вартість завжди безкоштовна.
                </p>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn--primary"><?= $isEdit ? 'Зберегти зміни' : 'Створити пропозицію' ?></button>
                <?php if ($similar !== []): ?>
                    <button type="submit" class="btn btn--ghost" name="force_save" value="1">Зберегти все одно</button>
                <?php endif; ?>
                <a class="btn btn--ghost" href="mp-list.php">До списку</a>
            </div>
        </form>
    </div>

    <script>
    (function () {
        var titleInput = document.getElementById('title');
        var statusEl = document.getElementById('dupcheck');
        var excludeId = <?= (int) $listingId ?>;
        var timer = null;
        var controller = null;

        function setStatus(text, cls) {
            statusEl.textContent = text;
            statusEl.className = 'dupcheck' + (cls ? ' dupcheck--' + cls : '');
        }

        function run() {
            var title = (titleInput.value || '').trim();
            if (title.length < 2) { setStatus('', ''); return; }
            if (controller) { controller.abort(); }
            controller = ('AbortController' in window) ? new AbortController() : null;
            setStatus('Перевіряємо, чи така пропозиція вже є…', '');
            fetch('mp-add-offer.php?ajax=dupcheck&title=' + encodeURIComponent(title) + '&exclude=' + excludeId, {
                headers: { 'X-Requested-With': 'fetch' },
                signal: controller ? controller.signal : undefined
            })
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    var exact = (d && d.exact) || [], sim = (d && d.similar) || [];
                    if (exact.length) {
                        setStatus('Така назва вже є: №' + exact[0].id + ' «' + exact[0].title + '». Змініть назву.', 'bad');
                    } else if (sim.length) {
                        var names = sim.slice(0, 3).map(function (p) { return '«' + p.title + '»'; }).join(', ');
                        setStatus('Схожі назви (' + sim.length + '): ' + names + (sim.length > 3 ? ' та інші' : '') + '. Перевірте, що це не дублікат.', 'warn');
                    } else {
                        setStatus('Схожих назв не знайдено.', 'ok');
                    }
                })
                .catch(function (e) { if (!e || e.name !== 'AbortError') { setStatus('', ''); } });
        }

        titleInput.addEventListener('input', function () { clearTimeout(timer); timer = setTimeout(run, 400); });
        titleInput.addEventListener('blur', run);

        // Лічильник короткого опису
        var shortEl = document.getElementById('short_desc');
        var counter = document.getElementById('shortCounter');
        function count() {
            var n = shortEl.value.length;
            counter.textContent = n + ' / 500';
            counter.className = 'counter' + (n > 500 ? ' counter--over' : '');
        }
        shortEl.addEventListener('input', count);
        count();

        // Панелі видачі за типом
        var typeEl = document.getElementById('delivery_type');
        var panelUrl = document.getElementById('panelUrl');
        var panelFile = document.getElementById('panelFile');
        var label = document.getElementById('deliveryUrlLabel');
        var hint = document.getElementById('deliveryUrlHint');
        var urlInput = document.getElementById('delivery_url');
        function sync() {
            var t = typeEl.value;
            panelUrl.hidden = (t === 'file');
            panelFile.hidden = (t !== 'file');
            urlInput.disabled = (t === 'file');
            if (t === 'contact') {
                label.textContent = 'Контакт (email або посилання)';
                hint.textContent = 'Email-адреса або http:// / https://-посилання.';
                urlInput.placeholder = 'name@example.com або https://…';
            } else {
                label.textContent = 'Посилання видачі';
                hint.textContent = 'Лише http:// або https://.';
                urlInput.placeholder = 'https://…';
            }
        }
        typeEl.addEventListener('change', sync);
        sync();
    })();
    </script>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
