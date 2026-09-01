<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM: додавання нового AI-продукту.
 *
 * Форма + обробник POST у цьому ж файлі.
 * Повну перевірку доступу до сторінки буде додано пізніше; наразі за
 * роллю ($_SESSION['role']) розмежовано лише видимість службових полів.
 *
 * Логіка збереження:
 *   1. Валідація обов'язкових полів.
 *   2. Антидубль-перевірка: пошук у products за схожою назвою (LIKE)
 *      АБО за нормалізованим офіційним URL (без http/https, www, слешу).
 *      Якщо знайдено схожі записи — показуємо їх і чекаємо підтвердження
 *      («Зберегти все одно»).
 *   3. Вставка у products + product_categories + product_subcategories
 *      + pricing_plans у межах транзакції.
 *   4. status виставляється автоматично (див. autostatus нижче).
 */

require_once __DIR__ . '/../app/auth.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

/** Службові посилання партнерки бачить і редагує лише admin. */
$isAdmin = auth_role() === 'admin';

/** Екранування для HTML. */
function e(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES);
}

/** Нормалізація URL для порівняння: без схеми, www та слешу в кінці. */
function normalize_url(string $url): string
{
    $url = trim($url);
    $url = preg_replace('#^https?://#i', '', $url) ?? $url;
    $url = preg_replace('#^www\.#i', '', $url) ?? $url;
    $url = rtrim($url, '/');

    return mb_strtolower($url);
}

/** Нормалізоване розширення завантаженого файлу (jpe -> jpg). */
function uploaded_ext(string $originalName): string
{
    $ext = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));

    return $ext === 'jpe' ? 'jpg' : $ext;
}

/** Транслітерація + очищення назви продукту для імені файлу логотипа. */
function product_slug(string $name): string
{
    static $map = [
        'а' => 'a', 'б' => 'b', 'в' => 'v', 'г' => 'h', 'ґ' => 'g', 'д' => 'd', 'е' => 'e',
        'є' => 'ie', 'ж' => 'zh', 'з' => 'z', 'и' => 'y', 'і' => 'i', 'ї' => 'i', 'й' => 'i',
        'к' => 'k', 'л' => 'l', 'м' => 'm', 'н' => 'n', 'о' => 'o', 'п' => 'p', 'р' => 'r',
        'с' => 's', 'т' => 't', 'у' => 'u', 'ф' => 'f', 'х' => 'kh', 'ц' => 'ts', 'ч' => 'ch',
        'ш' => 'sh', 'щ' => 'shch', 'ь' => '', 'ю' => 'iu', 'я' => 'ia',
        'ъ' => '', 'ы' => 'y', 'э' => 'e', 'ё' => 'e',
    ];

    $s = strtr(mb_strtolower(trim($name), 'UTF-8'), $map);
    $s = preg_replace('/[^a-z0-9]+/', '-', $s) ?? '';
    $s = trim($s, '-');

    return $s !== '' ? mb_substr($s, 0, 60) : 'logo';
}

// --- Логотип: куди зберігати і що приймати ------------------------------
$logoUploadDir  = __DIR__ . '/assets/images/logos';
$logoUploadRel  = 'assets/images/logos';
$logoAllowedExt = ['png', 'jpg', 'jpeg', 'webp', 'svg'];
$logoMaxBytes   = 2 * 1024 * 1024; // 2 МБ

// --- Довідники для форми --------------------------------------------------
$allCategories = $pdo->query('SELECT id, name FROM categories ORDER BY name')->fetchAll();
$allSubcategories = $pdo->query('SELECT id, category_id, name FROM subcategories ORDER BY name')->fetchAll();

$validCategoryIds = array_map('intval', array_column($allCategories, 'id'));
$subcategoryParent = [];
foreach ($allSubcategories as $sub) {
    $subcategoryParent[(int) $sub['id']] = (int) $sub['category_id'];
}

$platformOptions = ['web' => 'Web', 'mobile' => 'Mobile', 'desktop' => 'Desktop'];
$skillOptions = [
    '' => '— не вказано —',
    'none' => 'Без навичок',
    'basic' => 'Базові знання',
    'course' => 'Спеціальне навчання',
];
$periodOptions = [
    'free' => 'Безкоштовно',
    'week' => 'Тиждень',
    'month' => 'Місяць',
    'year' => 'Рік',
    'one_time' => 'Разово',
];
$partnershipOptions = [
    'found' => 'Знайдено',
    'pending_registration' => 'Очікує реєстрації',
    'partner_connected' => 'Партнерку підключено',
    'no_partnership' => 'Без партнерки',
];
// Статуси, за яких продукт може автоматично публікуватися.
$partnershipReady = ['partner_connected', 'no_partnership'];

// --- Стан сторінки -----------------------------------------------------------
$errors = [];
$similar = [];
$noticeDuplicate = false;
$savedProductId = null;

$old = [
    'name' => '',
    'logo_url' => '',
    'official_url' => '',
    'internal_registration_url' => '',
    'affiliate_url' => '',
    'partnership_status' => 'found',
    'short_description' => '',
    'full_description' => '',
    'main_features' => '',
    'target_audience' => '',
    'categories' => [],
    'subcategories' => [],
    'platform' => [],
    'skill_level' => '',
];
$plans = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $forceSave = ($_POST['action'] ?? '') === 'force';

    $old['name'] = trim((string) ($_POST['name'] ?? ''));
    $old['logo_url'] = trim((string) ($_POST['logo_url'] ?? ''));
    $old['official_url'] = trim((string) ($_POST['official_url'] ?? ''));
    $old['short_description'] = trim((string) ($_POST['short_description'] ?? ''));

    // --- Логотип: завантажений файл має пріоритет над полем URL ------------
    $logoFile = $_FILES['logo_file'] ?? null;
    $logoFileProvided = is_array($logoFile)
        && (int) ($logoFile['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE;

    if ($logoFileProvided) {
        $uploadErr = (int) $logoFile['error'];
        if ($uploadErr === UPLOAD_ERR_INI_SIZE || $uploadErr === UPLOAD_ERR_FORM_SIZE) {
            $errors[] = 'Файл логотипа завеликий: максимум 2 МБ.';
        } elseif ($uploadErr !== UPLOAD_ERR_OK) {
            $errors[] = 'Не вдалося завантажити файл логотипа (код ' . $uploadErr . ').';
        } elseif ((int) $logoFile['size'] > $logoMaxBytes) {
            $errors[] = 'Файл логотипа завеликий: максимум 2 МБ.';
        } elseif ((int) $logoFile['size'] <= 0) {
            $errors[] = 'Файл логотипа порожній.';
        } elseif (!in_array(uploaded_ext((string) $logoFile['name']), $logoAllowedExt, true)) {
            $errors[] = 'Дозволені формати логотипа: PNG, JPG, JPEG, WEBP, SVG.';
        }
    }

    // Статус партнерства — лише з дозволеного переліку.
    $submittedPartnership = (string) ($_POST['partnership_status'] ?? '');
    $old['partnership_status'] = array_key_exists($submittedPartnership, $partnershipOptions)
        ? $submittedPartnership
        : 'found';

    // Службові посилання партнерки приймаємо лише від admin (employee їх не бачить і не надсилає).
    if ($isAdmin) {
        $old['internal_registration_url'] = trim((string) ($_POST['internal_registration_url'] ?? ''));
        $old['affiliate_url'] = trim((string) ($_POST['affiliate_url'] ?? ''));
    }
    $old['full_description'] = trim((string) ($_POST['full_description'] ?? ''));
    $old['main_features'] = trim((string) ($_POST['main_features'] ?? ''));
    $old['target_audience'] = trim((string) ($_POST['target_audience'] ?? ''));

    // Категорії — лише валідні id.
    $old['categories'] = array_values(array_intersect(
        array_map('intval', (array) ($_POST['categories'] ?? [])),
        $validCategoryIds
    ));

    // Підкатегорії — лише ті, що належать до обраних категорій.
    $old['subcategories'] = array_values(array_filter(
        array_map('intval', (array) ($_POST['subcategories'] ?? [])),
        static fn (int $sid): bool => isset($subcategoryParent[$sid])
            && in_array($subcategoryParent[$sid], $old['categories'], true)
    ));

    // Платформа.
    $old['platform'] = array_values(array_intersect(
        (array) ($_POST['platform'] ?? []),
        array_keys($platformOptions)
    ));

    // Рівень навичок.
    $skill = (string) ($_POST['skill_level'] ?? '');
    $old['skill_level'] = in_array($skill, ['none', 'basic', 'course'], true) ? $skill : '';

    // Тарифні плани — рядки з масивів; повністю порожні пропускаємо.
    $planNames = (array) ($_POST['plan_name'] ?? []);
    foreach ($planNames as $i => $planName) {
        $planName = trim((string) $planName);
        $priceRaw = trim((string) ($_POST['plan_price'][$i] ?? ''));
        $period = (string) ($_POST['plan_period'][$i] ?? 'free');
        $planDesc = trim((string) ($_POST['plan_desc'][$i] ?? ''));

        if ($planName === '' && $priceRaw === '' && $planDesc === '') {
            continue;
        }
        if (!array_key_exists($period, $periodOptions)) {
            $period = 'free';
        }

        $plans[] = [
            'plan_name' => $planName,
            'price' => $priceRaw === '' ? null : round((float) str_replace(',', '.', $priceRaw), 2),
            'period' => $period,
            'description' => $planDesc,
        ];
    }

    // --- Валідація обов'язкових полів ----------------------------------------
    if ($old['name'] === '') {
        $errors[] = 'Вкажіть назву продукту.';
    }
    if ($old['official_url'] === '') {
        $errors[] = 'Вкажіть офіційний сайт / URL продукту.';
    }
    if ($old['short_description'] === '') {
        $errors[] = 'Додайте короткий опис.';
    }
    foreach ($plans as $idx => $plan) {
        if ($plan['plan_name'] === '') {
            $errors[] = 'Тарифний план №' . ($idx + 1) . ': вкажіть назву плану або приберіть рядок.';
        }
    }

    // --- Антидубль-перевірка ----------------------------------------------
    if ($errors === [] && !$forceSave) {
        $normUrl = normalize_url($old['official_url']);
        $dupStmt = $pdo->prepare(
            "SELECT id, name, official_url, status
             FROM products
             WHERE name LIKE CONCAT('%', :name1, '%')
                OR :name2 LIKE CONCAT('%', name, '%')
                OR (
                    official_url IS NOT NULL AND official_url <> '' AND
                    TRIM(TRAILING '/' FROM
                        REPLACE(REPLACE(REPLACE(LOWER(TRIM(official_url)), 'https://', ''), 'http://', ''), 'www.', '')
                    ) = :norm_url
                )
             ORDER BY name
             LIMIT 20"
        );
        $dupStmt->execute([
            ':name1' => $old['name'],
            ':name2' => $old['name'],
            ':norm_url' => $normUrl,
        ]);
        $similar = $dupStmt->fetchAll();
    }

    // --- Збереження -------------------------------------------------------
    if ($errors === [] && ($similar === [] || $forceSave)) {
        $movedLogoAbsPath = null;
        try {
            // Публічне посилання «Офіційний сайт»: партнерське, якщо задане, інакше офіційне.
            $publicOfficialUrl = $old['affiliate_url'] !== '' ? $old['affiliate_url'] : $old['official_url'];

            // --- Логотип --------------------------------------------------
            // Пріоритет: валідний завантажений файл → інакше вписаний URL → інакше порожньо.
            $logoValue = $old['logo_url'] !== '' ? $old['logo_url'] : null;

            if ($logoFileProvided) {
                if (!is_dir($logoUploadDir) && !mkdir($logoUploadDir, 0775, true) && !is_dir($logoUploadDir)) {
                    throw new RuntimeException('Не вдалося створити теку public/' . $logoUploadRel . '/.');
                }
                if (!is_writable($logoUploadDir)) {
                    throw new RuntimeException('Тека public/' . $logoUploadRel . '/ недоступна для запису.');
                }

                $ext = uploaded_ext((string) $logoFile['name']);
                $base = product_slug($old['name']);
                $filename = $base . '-' . time() . '.' . $ext;
                for ($n = 1; file_exists($logoUploadDir . '/' . $filename); $n++) {
                    $filename = $base . '-' . time() . '-' . $n . '.' . $ext;
                }

                $dest = $logoUploadDir . '/' . $filename;
                if (!is_uploaded_file($logoFile['tmp_name']) || !move_uploaded_file($logoFile['tmp_name'], $dest)) {
                    throw new RuntimeException('Не вдалося зберегти файл логотипа.');
                }
                @chmod($dest, 0644);

                $movedLogoAbsPath = $dest;
                $logoValue = $logoUploadRel . '/' . $filename;
            }

            // --- AUTOSTATUS -------------------------------------------------
            // published — лише коли всі обов'язкові поля заповнені І партнерка
            // доведена до кінця (partner_connected / no_partnership).
            // На етапах found / pending_registration — завжди in_progress.
            $requiredComplete = $old['name'] !== ''
                && $publicOfficialUrl !== ''
                && $old['short_description'] !== '';

            $status = ($requiredComplete && in_array($old['partnership_status'], $partnershipReady, true))
                ? 'published'
                : 'in_progress';

            $pdo->beginTransaction();

            $insert = $pdo->prepare(
                'INSERT INTO products
                    (name, logo_url, official_url, internal_registration_url, affiliate_url,
                     short_description, full_description, main_features, target_audience,
                     platform, skill_level, status, partnership_status, created_by)
                 VALUES
                    (:name, :logo_url, :official_url, :internal_registration_url, :affiliate_url,
                     :short_description, :full_description, :main_features, :target_audience,
                     :platform, :skill_level, :status, :partnership_status, NULL)'
            );
            $insert->execute([
                ':name' => $old['name'],
                ':logo_url' => $logoValue,
                ':official_url' => $publicOfficialUrl,
                ':internal_registration_url' => $old['internal_registration_url'] !== '' ? $old['internal_registration_url'] : null,
                ':affiliate_url' => $old['affiliate_url'] !== '' ? $old['affiliate_url'] : null,
                ':short_description' => $old['short_description'],
                ':full_description' => $old['full_description'] !== '' ? $old['full_description'] : null,
                ':main_features' => $old['main_features'] !== '' ? $old['main_features'] : null,
                ':target_audience' => $old['target_audience'] !== '' ? $old['target_audience'] : null,
                ':platform' => $old['platform'] !== [] ? implode(',', $old['platform']) : null,
                ':skill_level' => $old['skill_level'] !== '' ? $old['skill_level'] : 'none',
                ':status' => $status,
                ':partnership_status' => $old['partnership_status'],
            ]);
            $savedProductId = (int) $pdo->lastInsertId();

            if ($old['categories'] !== []) {
                $pcStmt = $pdo->prepare(
                    'INSERT INTO product_categories (product_id, category_id) VALUES (:p, :c)'
                );
                foreach ($old['categories'] as $categoryId) {
                    $pcStmt->execute([':p' => $savedProductId, ':c' => $categoryId]);
                }
            }

            if ($old['subcategories'] !== []) {
                $psStmt = $pdo->prepare(
                    'INSERT INTO product_subcategories (product_id, subcategory_id) VALUES (:p, :s)'
                );
                foreach ($old['subcategories'] as $subcategoryId) {
                    $psStmt->execute([':p' => $savedProductId, ':s' => $subcategoryId]);
                }
            }

            if ($plans !== []) {
                $planStmt = $pdo->prepare(
                    'INSERT INTO pricing_plans (product_id, plan_name, price, period, description)
                     VALUES (:p, :n, :pr, :pe, :d)'
                );
                foreach ($plans as $plan) {
                    $planStmt->execute([
                        ':p' => $savedProductId,
                        ':n' => $plan['plan_name'],
                        ':pr' => $plan['price'],
                        ':pe' => $plan['period'],
                        ':d' => $plan['description'] !== '' ? $plan['description'] : null,
                    ]);
                }
            }

            $pdo->commit();

            // Успіх — очищаємо форму.
            $old = array_merge($old, [
                'name' => '', 'logo_url' => '', 'official_url' => '',
                'internal_registration_url' => '', 'affiliate_url' => '',
                'partnership_status' => 'found',
                'short_description' => '', 'full_description' => '',
                'main_features' => '', 'target_audience' => '',
                'categories' => [], 'subcategories' => [], 'platform' => [], 'skill_level' => '',
            ]);
            $plans = [];
            $similar = [];
        } catch (Throwable $ex) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            // Прибираємо осиротілий файл логотипа, якщо запис у БД не вдався.
            if ($movedLogoAbsPath !== null && is_file($movedLogoAbsPath)) {
                @unlink($movedLogoAbsPath);
            }
            $errors[] = 'Помилка збереження: ' . $ex->getMessage();
        }
    } elseif ($errors === [] && $similar !== [] && !$forceSave) {
        $noticeDuplicate = true;
    }
}

// Рядки тарифів для показу: submitted або один порожній.
$displayPlans = $plans !== []
    ? $plans
    : [['plan_name' => '', 'price' => '', 'period' => 'free', 'description' => '']];

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — CRM: додати продукт</title>
    <style>
        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }

        :root {
            --bg-start: #00032c;
            --bg-end: #2116ad;
            --card-bg: rgba(255, 255, 255, 0.05);
            --card-border: rgba(255, 255, 255, 0.14);
            --text-muted: rgba(255, 255, 255, 0.75);
            --accent: #5b8cff;
        }

        html,
        body {
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #ffffff;
            background: linear-gradient(160deg, var(--bg-start) 0%, var(--bg-end) 100%);
            background-attachment: fixed;
            line-height: 1.6;
        }

        .site-header {
            display: flex;
            align-items: center;
            padding: 20px 32px;
        }

        .site-header__brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: #ffffff;
        }

        .site-header__logo {
            height: 42px;
            width: auto;
            display: block;
            border-radius: 10px;
        }

        .site-header__name {
            font-size: clamp(0.95rem, 3.5vw, 1.15rem);
            font-weight: 800;
            letter-spacing: 0.04em;
            line-height: 1;
            white-space: nowrap;
            color: #ffffff;
        }

        .page {
            max-width: 800px;
            margin: 0 auto;
            padding: 24px 24px 72px;
        }

        .page__title {
            margin: 0 0 8px;
            font-size: clamp(1.6rem, 4.5vw, 2.2rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .page__subtitle {
            margin: 0 0 28px;
            color: var(--text-muted);
        }

        /* Панель форми */
        .form {
            padding: 28px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 18px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .field {
            margin-bottom: 22px;
        }

        .field__label {
            display: block;
            margin-bottom: 7px;
            font-size: 0.9rem;
            font-weight: 700;
            letter-spacing: 0.02em;
        }

        .field__hint {
            margin: 6px 0 0;
            font-size: 0.8rem;
            color: rgba(255, 255, 255, 0.55);
        }

        .req {
            color: #fca5a5;
        }

        .field__admin {
            display: inline-block;
            margin-left: 6px;
            padding: 1px 7px;
            border-radius: 999px;
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: #bcd0ff;
            background: rgba(91, 140, 255, 0.18);
            border: 1px solid rgba(91, 140, 255, 0.45);
            vertical-align: middle;
        }

        .input,
        .textarea,
        .select {
            width: 100%;
            padding: 11px 14px;
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.08);
            color: #ffffff;
            font-size: 0.98rem;
            font-family: inherit;
        }

        .textarea {
            min-height: 90px;
            resize: vertical;
        }

        .select[multiple] {
            padding: 6px;
        }

        .select[multiple] option {
            padding: 6px 8px;
            border-radius: 6px;
        }

        .input:focus,
        .textarea:focus,
        .select:focus {
            outline: none;
            border-color: var(--accent);
            background: rgba(255, 255, 255, 0.12);
        }

        .input::placeholder,
        .textarea::placeholder {
            color: rgba(255, 255, 255, 0.45);
        }

        input[type="file"].input {
            padding: 9px 12px;
            cursor: pointer;
        }

        input[type="file"].input::file-selector-button {
            margin-right: 12px;
            padding: 6px 12px;
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.12);
            color: #ffffff;
            font: inherit;
            cursor: pointer;
        }

        option {
            color: #00032c;
        }

        /* Checkboxes */
        .checks {
            display: flex;
            flex-wrap: wrap;
            gap: 10px 20px;
        }

        .check {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 0.95rem;
        }

        .check input {
            width: 16px;
            height: 16px;
            accent-color: var(--accent);
        }

        /* Редактор тарифних планів */
        .plans-editor {
            display: grid;
            gap: 14px;
        }

        .plan-row {
            display: grid;
            grid-template-columns: 1.2fr 0.7fr 0.9fr 1.6fr auto;
            gap: 10px;
            align-items: start;
            padding: 14px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid var(--card-border);
            border-radius: 12px;
        }

        .plan-row .input,
        .plan-row .select,
        .plan-row .textarea {
            padding: 9px 11px;
            font-size: 0.92rem;
        }

        .plan-row__remove {
            padding: 9px 12px;
            border-radius: 10px;
            border: 1px solid rgba(252, 165, 165, 0.5);
            background: rgba(252, 165, 165, 0.12);
            color: #fca5a5;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            white-space: nowrap;
        }

        .plan-row__remove:hover {
            background: rgba(252, 165, 165, 0.22);
        }

        @media (max-width: 680px) {
            .plan-row {
                grid-template-columns: 1fr 1fr;
            }

            .plan-row__remove {
                grid-column: 1 / -1;
            }
        }

        /* Кнопки */
        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 999px;
            font-size: 1rem;
            font-weight: 600;
            font-family: inherit;
            text-decoration: none;
            cursor: pointer;
            border: 1px solid transparent;
            transition: transform 0.15s ease, background 0.15s ease, border-color 0.15s ease;
        }

        .btn:active {
            transform: translateY(1px);
        }

        .btn--primary {
            background: #ffffff;
            color: #00032c;
        }

        .btn--primary:hover {
            background: rgba(255, 255, 255, 0.88);
        }

        .btn--ghost {
            background: transparent;
            color: #ffffff;
            border-color: rgba(255, 255, 255, 0.4);
        }

        .btn--ghost:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .btn--sm {
            padding: 9px 18px;
            font-size: 0.9rem;
        }

        .actions {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 28px;
        }

        /* Повідомлення */
        .notice {
            margin-bottom: 24px;
            padding: 18px 20px;
            border-radius: 12px;
            border: 1px solid var(--card-border);
            background: var(--card-bg);
        }

        .notice__title {
            margin: 0 0 8px;
            font-size: 1.05rem;
            font-weight: 700;
        }

        .notice--error {
            border-color: rgba(252, 165, 165, 0.6);
            background: rgba(252, 165, 165, 0.12);
        }

        .notice--warn {
            border-color: rgba(251, 191, 36, 0.6);
            background: rgba(251, 191, 36, 0.12);
        }

        .notice--success {
            border-color: rgba(52, 211, 153, 0.6);
            background: rgba(52, 211, 153, 0.14);
        }

        .notice ul {
            margin: 8px 0 0;
            padding-left: 20px;
        }

        .similar-list {
            list-style: none;
            margin: 12px 0 0;
            padding: 0;
            display: grid;
            gap: 8px;
        }

        .similar-item {
            display: flex;
            flex-wrap: wrap;
            align-items: baseline;
            gap: 6px 12px;
            padding: 10px 14px;
            background: rgba(0, 0, 0, 0.2);
            border-radius: 10px;
        }

        .similar-item__name {
            font-weight: 700;
        }

        .similar-item__url {
            font-size: 0.85rem;
            color: var(--text-muted);
            word-break: break-all;
        }

        .similar-item__status {
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            padding: 2px 8px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.12);
        }

        .similar-item a {
            color: #bcd0ff;
        }
    </style>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB">
            <span class="site-header__name">AI LAB HUB</span>
        </a>
    </header>

    <div class="page">
        <h1 class="page__title">CRM — додати AI-продукт</h1>
        <p class="page__subtitle">
            Статус (<strong>in_progress</strong> / <strong>published</strong>) визначається автоматично —
            за статусом партнерства та заповненістю обов'язкових полів.
            <?php if ($isAdmin): ?>Ви увійшли як <strong>admin</strong>: службові поля партнерки доступні.<?php else: ?>Службові поля партнерки бачить лише admin.<?php endif; ?>
        </p>

        <?php if ($savedProductId !== null): ?>
            <div class="notice notice--success">
                <p class="notice__title">Продукт збережено ✓</p>
                <p style="margin:0;">
                    ID у базі: <strong>#<?= (int) $savedProductId ?></strong>.
                    <a href="product.php?id=<?= (int) $savedProductId ?>">Відкрити картку продукту</a>
                    · <a href="catalog.php">до каталогу</a>
                </p>
            </div>
        <?php endif; ?>

        <?php if ($errors !== []): ?>
            <div class="notice notice--error">
                <p class="notice__title">Виправте помилки:</p>
                <ul>
                    <?php foreach ($errors as $error): ?>
                        <li><?= e($error) ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <?php if ($noticeDuplicate): ?>
            <div class="notice notice--warn">
                <p class="notice__title">Знайдено схожі продукти в базі</p>
                <p style="margin:0;">Перевірте, чи це не дублікат. Дані форми збережено нижче — можна відкоригувати їх або натиснути «Зберегти все одно».</p>
                <ul class="similar-list">
                    <?php foreach ($similar as $row): ?>
                        <li class="similar-item">
                            <span class="similar-item__name"><?= e($row['name']) ?></span>
                            <span class="similar-item__status"><?= e($row['status']) ?></span>
                            <span class="similar-item__url"><?= e($row['official_url']) ?></span>
                            <a href="product.php?id=<?= (int) $row['id'] ?>" target="_blank" rel="noopener">картка #<?= (int) $row['id'] ?></a>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>

        <form class="form" method="post" action="crm-add-product.php" enctype="multipart/form-data" novalidate>
            <div class="field">
                <label class="field__label" for="name">Назва продукту <span class="req">*</span></label>
                <input class="input" type="text" id="name" name="name" required
                       value="<?= e($old['name']) ?>" placeholder="Напр. TestAI Pro">
            </div>

            <div class="field">
                <span class="field__label">Логотип</span>
                <input class="input" type="file" id="logo_file" name="logo_file"
                       accept="image/png,image/jpeg,image/webp,image/svg+xml">
                <p class="field__hint">PNG, JPG, JPEG, WEBP або SVG, до 2&nbsp;МБ. Файл зберігається на нашому сервері.</p>
                <input class="input" type="text" id="logo_url" name="logo_url" style="margin-top:10px;"
                       value="<?= e($old['logo_url']) ?>" placeholder="або URL логотипа: https://…/logo.png">
                <p class="field__hint">Якщо файл не вибрано — використовується це посилання (на чужому сервері). Файл має пріоритет над URL.</p>
            </div>

            <div class="field">
                <label class="field__label" for="official_url">Офіційний сайт / URL <span class="req">*</span></label>
                <input class="input" type="text" id="official_url" name="official_url" required
                       value="<?= e($old['official_url']) ?>" placeholder="https://example.com">
                <p class="field__hint">Посилання «Офіційний сайт» на публічній картці. Якщо задано партнерське посилання — на картці показується воно.</p>
            </div>

            <?php if ($isAdmin): ?>
            <div class="field">
                <label class="field__label" for="internal_registration_url">Службове посилання для реєстрації <span class="field__admin">admin</span></label>
                <input class="input" type="text" id="internal_registration_url" name="internal_registration_url"
                       value="<?= e($old['internal_registration_url']) ?>" placeholder="Внутрішнє посилання на реєстрацію в партнерській програмі">
                <p class="field__hint">Не потрапляє на публічну картку. Видиме лише для admin.</p>
            </div>

            <div class="field">
                <label class="field__label" for="affiliate_url">Партнерське (affiliate) посилання <span class="field__admin">admin</span></label>
                <input class="input" type="text" id="affiliate_url" name="affiliate_url"
                       value="<?= e($old['affiliate_url']) ?>" placeholder="https://example.com/?ref=ailabhub">
                <p class="field__hint">Якщо заповнене — саме воно стає посиланням «Офіційний сайт» на публічній картці.</p>
            </div>
            <?php endif; ?>

            <div class="field">
                <label class="field__label" for="partnership_status">Статус партнерства</label>
                <select class="select" id="partnership_status" name="partnership_status">
                    <?php foreach ($partnershipOptions as $value => $label): ?>
                        <option value="<?= e($value) ?>" <?= $old['partnership_status'] === $value ? 'selected' : '' ?>>
                            <?= e($label) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
                <p class="field__hint">
                    «Партнерку підключено» або «Без партнерки» + усі обов'язкові поля → продукт публікується (published).
                    «Знайдено» / «Очікує реєстрації» → лишається чернеткою (in_progress) незалежно від решти полів.
                </p>
            </div>

            <div class="field">
                <label class="field__label" for="short_description">Короткий опис <span class="req">*</span></label>
                <textarea class="textarea" id="short_description" name="short_description" required
                          placeholder="1–2 речення для картки в каталозі"><?= e($old['short_description']) ?></textarea>
            </div>

            <div class="field">
                <label class="field__label" for="full_description">Повний опис</label>
                <textarea class="textarea" id="full_description" name="full_description"
                          placeholder="Розгорнутий опис для сторінки продукту"><?= e($old['full_description']) ?></textarea>
            </div>

            <div class="field">
                <label class="field__label" for="categories">Категорії</label>
                <select class="select" id="categories" name="categories[]" multiple size="6">
                    <?php foreach ($allCategories as $category): ?>
                        <option value="<?= (int) $category['id'] ?>"
                            <?= in_array((int) $category['id'], $old['categories'], true) ? 'selected' : '' ?>>
                            <?= e($category['name']) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
                <p class="field__hint">Утримуйте Ctrl / Cmd, щоб обрати кілька.</p>
            </div>

            <div class="field">
                <label class="field__label" for="subcategories">Підкатегорії</label>
                <select class="select" id="subcategories" name="subcategories[]" multiple size="6">
                    <?php foreach ($allSubcategories as $subcategory): ?>
                        <option value="<?= (int) $subcategory['id'] ?>"
                                data-category="<?= (int) $subcategory['category_id'] ?>"
                            <?= in_array((int) $subcategory['id'], $old['subcategories'], true) ? 'selected' : '' ?>>
                            <?= e($subcategory['name']) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
                <p class="field__hint">Показуються лише підкатегорії обраних категорій.</p>
            </div>

            <div class="field">
                <label class="field__label" for="main_features">Основні функції</label>
                <textarea class="textarea" id="main_features" name="main_features"
                          placeholder="По одному пункту на рядок"><?= e($old['main_features']) ?></textarea>
            </div>

            <div class="field">
                <label class="field__label" for="target_audience">Для кого призначений</label>
                <textarea class="textarea" id="target_audience" name="target_audience"
                          placeholder="Хто цільова аудиторія продукту"><?= e($old['target_audience']) ?></textarea>
            </div>

            <div class="field">
                <span class="field__label">Платформа</span>
                <div class="checks">
                    <?php foreach ($platformOptions as $value => $label): ?>
                        <label class="check">
                            <input type="checkbox" name="platform[]" value="<?= e($value) ?>"
                                <?= in_array($value, $old['platform'], true) ? 'checked' : '' ?>>
                            <?= e($label) ?>
                        </label>
                    <?php endforeach; ?>
                </div>
            </div>

            <div class="field">
                <label class="field__label" for="skill_level">Рівень навичок</label>
                <select class="select" id="skill_level" name="skill_level">
                    <?php foreach ($skillOptions as $value => $label): ?>
                        <option value="<?= e($value) ?>" <?= $old['skill_level'] === $value ? 'selected' : '' ?>>
                            <?= e($label) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="field">
                <span class="field__label">Тарифні плани</span>
                <div class="plans-editor" id="plans-editor">
                    <?php foreach ($displayPlans as $plan): ?>
                        <div class="plan-row">
                            <input class="input" type="text" name="plan_name[]"
                                   value="<?= e($plan['plan_name']) ?>" placeholder="Назва плану">
                            <input class="input" type="number" name="plan_price[]" step="0.01" min="0"
                                   value="<?= e($plan['price']) ?>" placeholder="Ціна">
                            <select class="select" name="plan_period[]">
                                <?php foreach ($periodOptions as $value => $label): ?>
                                    <option value="<?= e($value) ?>" <?= ($plan['period'] ?? 'free') === $value ? 'selected' : '' ?>>
                                        <?= e($label) ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                            <input class="input" type="text" name="plan_desc[]"
                                   value="<?= e($plan['description']) ?>" placeholder="Короткий опис плану">
                            <button type="button" class="plan-row__remove" data-remove-plan>Видалити</button>
                        </div>
                    <?php endforeach; ?>
                </div>
                <div style="margin-top:12px;">
                    <button type="button" class="btn btn--ghost btn--sm" id="add-plan">+ Додати план</button>
                </div>
            </div>

            <div class="actions">
                <button type="submit" class="btn btn--primary" name="action" value="save">Зберегти продукт</button>
                <?php if ($noticeDuplicate): ?>
                    <button type="submit" class="btn btn--ghost" name="action" value="force">Зберегти все одно</button>
                <?php endif; ?>
                <a class="btn btn--ghost" href="catalog.php">Скасувати</a>
            </div>
        </form>
    </div>

    <template id="plan-row-template">
        <div class="plan-row">
            <input class="input" type="text" name="plan_name[]" placeholder="Назва плану">
            <input class="input" type="number" name="plan_price[]" step="0.01" min="0" placeholder="Ціна">
            <select class="select" name="plan_period[]">
                <?php foreach ($periodOptions as $value => $label): ?>
                    <option value="<?= e($value) ?>"><?= e($label) ?></option>
                <?php endforeach; ?>
            </select>
            <input class="input" type="text" name="plan_desc[]" placeholder="Короткий опис плану">
            <button type="button" class="plan-row__remove" data-remove-plan>Видалити</button>
        </div>
    </template>

    <script>
        // --- Підкатегорії залежать від обраних категорій ---
        var catSelect = document.getElementById('categories');
        var subSelect = document.getElementById('subcategories');

        function syncSubcategories() {
            var chosen = Array.prototype.map.call(catSelect.selectedOptions, function (o) { return o.value; });
            Array.prototype.forEach.call(subSelect.options, function (opt) {
                var belongs = chosen.indexOf(opt.dataset.category) !== -1;
                opt.hidden = !belongs;
                opt.disabled = !belongs;
                if (!belongs) {
                    opt.selected = false;
                }
            });
        }

        catSelect.addEventListener('change', syncSubcategories);
        syncSubcategories();

        // --- Динамічні тарифні плани ---
        var editor = document.getElementById('plans-editor');
        var tpl = document.getElementById('plan-row-template');

        document.getElementById('add-plan').addEventListener('click', function () {
            editor.appendChild(tpl.content.cloneNode(true));
        });

        editor.addEventListener('click', function (event) {
            if (!event.target.matches('[data-remove-plan]')) {
                return;
            }
            var rows = editor.querySelectorAll('.plan-row');
            if (rows.length > 1) {
                event.target.closest('.plan-row').remove();
            } else {
                // останній рядок лише очищаємо
                event.target.closest('.plan-row')
                    .querySelectorAll('input').forEach(function (i) { i.value = ''; });
            }
        });
    </script>
</body>
</html>
