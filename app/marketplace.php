<?php

declare(strict_types=1);

/**
 * AI LAB HUB — спільні хелпери CRM Marketplace (mp-add-offer.php, mp-list.php).
 *
 * Таблиці mp_* — database/migration-2026-09-21-marketplace-core.sql. Зв'язки з users
 * без FOREIGN KEY, тож цілісність (створювач, завантажувач) перевіряється тут, у PHP.
 * Підключати після app/auth.php:
 *   require_once __DIR__ . '/../app/auth.php';
 *   require_once __DIR__ . '/../app/marketplace.php';
 */

/** Налаштування: значення за замовчуванням + необов'язковий config/marketplace.php. */
function mp_config(): array
{
    static $cfg = null;
    if ($cfg === null) {
        $defaults = [
            'max_upload_bytes'   => 10 * 1024 * 1024,
            'max_cover_bytes'    => 2 * 1024 * 1024,
            'allowed_extensions' => ['pdf', 'md', 'txt', 'json', 'csv', 'zip'],
            'file_storage_dir'   => dirname(__DIR__) . '/storage/marketplace/files',
            'cover_dir'          => dirname(__DIR__) . '/public/assets/images/marketplace/covers',
            // Публічна частина (marketplace.php, offer.php, get.php, пункти меню): вимкнена, доки не ввімкнено вручну.
            'public_enabled'     => false,
            // Дошка оголошень (етап 4) — пояснення в config/marketplace.php.
            'photo_dir'          => dirname(__DIR__) . '/public/uploads/marketplace',
            'photo_url'          => '/uploads/marketplace',
            'photo_max_count'    => 8,
            'photo_max_bytes'    => 5 * 1024 * 1024,
            'photo_max_side'     => 1600,
            'photo_thumb_side'   => 400,
            'listing_ttl_days'   => 30,
            'max_active_per_user' => 5,
            'max_new_per_day'    => 10,
            'max_links_in_desc'  => 2,
            'stop_words'         => [],
            'reveals_per_day'    => 30,
            'reports_threshold'  => 3,
            'cron_token'         => '',
        ];
        $cfg = $defaults;
        // config/marketplace.php — базові значення; config/marketplace.local.php (не в git) — локальне перевизначення.
        foreach (['marketplace.php', 'marketplace.local.php'] as $name) {
            $file = __DIR__ . '/../config/' . $name;
            $custom = is_file($file) ? require $file : [];
            if (is_array($custom)) {
                $cfg = array_merge($cfg, $custom);
            }
        }
    }

    return $cfg;
}

/** Екранування для HTML. */
function mp_e(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES);
}

/** CRM Marketplace — лише employee та admin; решту відправляє в кабінет. */
function mp_require_staff(): void
{
    if (!auth_has_role('employee', 'admin')) {
        header('Location: account.php');
        exit;
    }
}

// --- CSRF ---------------------------------------------------------------

function mp_csrf_token(): string
{
    if (empty($_SESSION['mp_csrf']) || !is_string($_SESSION['mp_csrf'])) {
        $_SESSION['mp_csrf'] = bin2hex(random_bytes(32));
    }

    return $_SESSION['mp_csrf'];
}

function mp_csrf_field(): string
{
    return '<input type="hidden" name="csrf" value="' . mp_e(mp_csrf_token()) . '">';
}

function mp_csrf_verify(): bool
{
    $sent = $_POST['csrf'] ?? '';

    return is_string($sent) && $sent !== '' && hash_equals(mp_csrf_token(), $sent);
}

// --- Довідники -----------------------------------------------------------

/** @return array<string,string> */
function mp_status_labels(): array
{
    return ['draft' => 'Чернетка', 'pending' => 'На модерації', 'published' => 'Опубліковано', 'rejected' => 'Відхилено', 'archived' => 'Архів', 'expired' => 'Термін минув'];
}

/** @return array<string,string> статуси, які можна вибрати у формі */
function mp_form_statuses(): array
{
    return ['draft' => 'Чернетка', 'published' => 'Опубліковано', 'archived' => 'Архів'];
}

/** @return array<string,string> */
function mp_skill_labels(): array
{
    return ['none' => 'Без навичок', 'basic' => 'Базові знання', 'course' => 'Спеціальне навчання'];
}

/** @return array<string,string> */
function mp_delivery_labels(): array
{
    return ['link' => 'Посилання', 'file' => 'Файл', 'contact' => 'Контакт'];
}

/**
 * Категорії розділу «Готові рішення» з українськими назвами.
 *
 * @return list<array{id:int,slug:string,name:string}>
 */
function mp_categories(PDO $pdo, string $section = 'solution'): array
{
    $stmt = $pdo->prepare(
        "SELECT c.id, c.slug, COALESCE(t.name, c.slug) AS name
         FROM mp_categories c
         LEFT JOIN mp_category_translations t ON t.category_id = c.id AND t.lang = 'uk'
         WHERE c.section = :section AND c.is_active = 1
         ORDER BY c.sort_order, c.id"
    );
    $stmt->execute([':section' => $section]);

    return array_map(
        static fn(array $r): array => ['id' => (int) $r['id'], 'slug' => (string) $r['slug'], 'name' => (string) $r['name']],
        $stmt->fetchAll(PDO::FETCH_ASSOC)
    );
}

/** id продавця за slug (за замовчуванням — сама платформа) або null. */
function mp_seller_id(PDO $pdo, string $slug = 'ailabhub'): ?int
{
    $stmt = $pdo->prepare("SELECT id FROM mp_sellers WHERE slug = :slug AND status = 'active' LIMIT 1");
    $stmt->execute([':slug' => $slug]);
    $id = $stmt->fetchColumn();

    return $id === false ? null : (int) $id;
}

// --- Антидубль за назвою ---------------------------------------------------

/** Нормалізація назви для порівняння: нижній регістр, лише літери й цифри. */
function mp_norm_title(string $title): string
{
    return preg_replace('/[^\p{L}\p{N}]+/u', '', mb_strtolower(trim($title))) ?? '';
}

/**
 * Схожі назви серед пропозицій (uk). exact — збіг після нормалізації (блокує збереження),
 * similar — одна назва містить іншу (лише попередження).
 *
 * @return array{exact:list<array<string,mixed>>,similar:list<array<string,mixed>>}
 */
function mp_find_similar_titles(PDO $pdo, string $title, int $excludeId = 0): array
{
    $norm = mp_norm_title($title);
    $res = ['exact' => [], 'similar' => []];
    if (mb_strlen($norm) < 2) {
        return $res;
    }

    $stmt = $pdo->prepare(
        "SELECT t.listing_id AS id, t.title, l.status
         FROM mp_listing_translations t
         JOIN mp_listings l ON l.id = t.listing_id
         WHERE t.lang = 'uk' AND t.listing_id <> :ex
         ORDER BY t.title
         LIMIT 5000"
    );
    $stmt->execute([':ex' => $excludeId]);
    foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $r) {
        $n = mp_norm_title((string) $r['title']);
        $row = ['id' => (int) $r['id'], 'title' => (string) $r['title'], 'status' => (string) $r['status']];
        if ($n === $norm) {
            $res['exact'][] = $row;
        } elseif (mb_strlen($n) >= 3 && (str_contains($n, $norm) || str_contains($norm, $n))) {
            $res['similar'][] = $row;
        }
    }
    $res['exact'] = array_slice($res['exact'], 0, 20);
    $res['similar'] = array_slice($res['similar'], 0, 20);

    return $res;
}

// --- Посилання видачі ----------------------------------------------------

/** Лише http(s)-посилання (без пробілів, ≤500 символів). */
function mp_is_http_url(string $url): bool
{
    return $url !== '' && mb_strlen($url) <= 500
        && preg_match('#^https?://[^\s/$.?\#].[^\s]*$#i', $url) === 1
        && filter_var($url, FILTER_VALIDATE_URL) !== false;
}

/** Контакт видачі: email або http(s)-посилання. */
function mp_is_contact(string $value): bool
{
    return mb_strlen($value) <= 500
        && (filter_var($value, FILTER_VALIDATE_EMAIL) !== false || mp_is_http_url($value));
}

// --- Завантаження файлів ---------------------------------------------------

/** Допустимі реальні MIME (за finfo) для кожного дозволеного розширення. */
const MP_FILE_MIME = [
    'pdf'  => ['application/pdf'],
    'md'   => ['text/plain', 'text/markdown', 'text/x-markdown'],
    'txt'  => ['text/plain'],
    'json' => ['application/json', 'text/plain'],
    'csv'  => ['text/csv', 'text/plain', 'application/csv'],
    'zip'  => ['application/zip', 'application/x-zip-compressed'],
];

const MP_COVER_MIME = ['jpg' => 'image/jpeg', 'jpeg' => 'image/jpeg', 'png' => 'image/png', 'webp' => 'image/webp'];

function mp_upload_error_text(int $code): string
{
    return match ($code) {
        UPLOAD_ERR_INI_SIZE, UPLOAD_ERR_FORM_SIZE => 'Файл більший за дозволений сервером розмір.',
        UPLOAD_ERR_PARTIAL => 'Файл завантажився не повністю — спробуйте ще раз.',
        UPLOAD_ERR_NO_TMP_DIR, UPLOAD_ERR_CANT_WRITE, UPLOAD_ERR_EXTENSION => 'Сервер не зміг прийняти файл (тимчасова тека недоступна).',
        default => 'Не вдалося завантажити файл (код ' . $code . ').',
    };
}

/** Реальний MIME файлу за вмістом (finfo), не за іменем. */
function mp_real_mime(string $path): string
{
    $fi = new finfo(FILEINFO_MIME_TYPE);
    $mime = $fi->file($path);

    return is_string($mime) ? $mime : '';
}

/** Ім'я без шляху й керівних символів, ≤255. */
function mp_clean_filename(string $name): string
{
    $name = basename(str_replace('\\', '/', $name));
    $name = preg_replace('/[\x00-\x1F\x7F]+/u', '', $name) ?? '';
    $name = trim($name);

    return mb_substr($name !== '' ? $name : 'file', 0, 255);
}

/**
 * Перевірка (БЕЗ збереження) завантаженого файлу пропозиції.
 * Повертає null, якщо файл не вибрано; інакше масив із результатом перевірки або додає помилку в $errors.
 *
 * @return array{tmp:string,name:string,ext:string,mime:string,size:int,sha256:string}|null
 */
function mp_inspect_offer_file(?array $file, array &$errors): ?array
{
    if ($file === null || (int) ($file['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) {
        return null;
    }
    $cfg = mp_config();
    if ((int) $file['error'] !== UPLOAD_ERR_OK) {
        $errors[] = mp_upload_error_text((int) $file['error']);
        return null;
    }
    $tmp = (string) $file['tmp_name'];
    if (!is_uploaded_file($tmp)) {
        $errors[] = 'Файл не був завантажений через форму.';
        return null;
    }
    $size = (int) filesize($tmp);
    if ($size <= 0) {
        $errors[] = 'Файл порожній.';
        return null;
    }
    if ($size > (int) $cfg['max_upload_bytes']) {
        $errors[] = 'Файл завеликий: максимум ' . round(((int) $cfg['max_upload_bytes']) / 1048576, 1) . ' МБ.';
        return null;
    }

    $name = mp_clean_filename((string) $file['name']);
    $ext = strtolower(pathinfo($name, PATHINFO_EXTENSION));
    if (!in_array($ext, (array) $cfg['allowed_extensions'], true) || !isset(MP_FILE_MIME[$ext])) {
        $errors[] = 'Дозволені формати файлу: ' . implode(', ', (array) $cfg['allowed_extensions']) . '.';
        return null;
    }

    $mime = mp_real_mime($tmp);
    if (!in_array($mime, MP_FILE_MIME[$ext], true)) {
        $errors[] = 'Вміст файлу не відповідає розширенню .' . $ext . ' (визначено тип «' . $mime . '»).';
        return null;
    }
    // Текстові формати не повинні містити нульових байтів (бінарник під виглядом тексту).
    if ($ext !== 'pdf' && $ext !== 'zip') {
        $head = (string) file_get_contents($tmp, false, null, 0, 8192);
        if (str_contains($head, "\0")) {
            $errors[] = 'Текстовий файл містить бінарні дані — відхилено.';
            return null;
        }
    }

    return ['tmp' => $tmp, 'name' => $name, 'ext' => $ext, 'mime' => $mime, 'size' => $size, 'sha256' => hash_file('sha256', $tmp)];
}

/**
 * Зберегти перевірений файл ПОЗА webroot і записати в mp_files.
 * Якщо файл із таким sha256 уже є — дубль не створюється, повертається наявний id (existing=true).
 *
 * @param array{tmp:string,name:string,ext:string,mime:string,size:int,sha256:string} $info
 * @return array{id:int,existing:bool,original_name:string,stored_path:?string}
 */
function mp_save_offer_file(PDO $pdo, array $info, ?int $userId): array
{
    $stmt = $pdo->prepare('SELECT id, original_name FROM mp_files WHERE sha256 = :h ORDER BY id LIMIT 1');
    $stmt->execute([':h' => $info['sha256']]);
    $dup = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($dup !== false) {
        return ['id' => (int) $dup['id'], 'existing' => true, 'original_name' => (string) $dup['original_name'], 'stored_path' => null];
    }

    $dir = (string) mp_config()['file_storage_dir'];
    if (!is_dir($dir) && !mkdir($dir, 0775, true) && !is_dir($dir)) {
        throw new RuntimeException('Не вдалося створити теку зберігання файлів.');
    }
    $stored = bin2hex(random_bytes(16));   // випадкове ім'я без розширення
    $path = $dir . '/' . $stored;
    if (!move_uploaded_file($info['tmp'], $path)) {
        throw new RuntimeException('Не вдалося зберегти файл на сервері.');
    }
    @chmod($path, 0640);

    $ins = $pdo->prepare(
        "INSERT INTO mp_files (original_name, stored_name, mime, size_bytes, sha256, scan_status, uploaded_by)
         VALUES (:o, :s, :m, :z, :h, 'pending', :u)"
    );
    $ins->execute([':o' => $info['name'], ':s' => $stored, ':m' => $info['mime'], ':z' => $info['size'], ':h' => $info['sha256'], ':u' => $userId]);

    return ['id' => (int) $pdo->lastInsertId(), 'existing' => false, 'original_name' => $info['name'], 'stored_path' => $path];
}

/**
 * Перевірка (БЕЗ збереження) обкладинки: jpg/png/webp, реальний MIME, розмір.
 *
 * @return array{tmp:string,ext:string}|null
 */
function mp_inspect_cover(?array $file, array &$errors): ?array
{
    if ($file === null || (int) ($file['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) {
        return null;
    }
    $cfg = mp_config();
    if ((int) $file['error'] !== UPLOAD_ERR_OK) {
        $errors[] = 'Обкладинка: ' . mp_upload_error_text((int) $file['error']);
        return null;
    }
    $tmp = (string) $file['tmp_name'];
    if (!is_uploaded_file($tmp)) {
        $errors[] = 'Обкладинка не була завантажена через форму.';
        return null;
    }
    $size = (int) filesize($tmp);
    if ($size <= 0 || $size > (int) $cfg['max_cover_bytes']) {
        $errors[] = 'Обкладинка: розмір має бути до ' . round(((int) $cfg['max_cover_bytes']) / 1048576, 1) . ' МБ.';
        return null;
    }
    $ext = strtolower(pathinfo(mp_clean_filename((string) $file['name']), PATHINFO_EXTENSION));
    if (!isset(MP_COVER_MIME[$ext])) {
        $errors[] = 'Обкладинка: дозволені формати JPG, PNG, WEBP.';
        return null;
    }
    $mime = mp_real_mime($tmp);
    $dims = @getimagesize($tmp);
    if ($mime !== MP_COVER_MIME[$ext] || $dims === false || $dims[0] < 1 || $dims[1] < 1 || $dims[0] > 8000 || $dims[1] > 8000) {
        $errors[] = 'Обкладинка: вміст файлу не є коректним зображенням ' . strtoupper($ext) . '.';
        return null;
    }

    return ['tmp' => $tmp, 'ext' => $ext === 'jpeg' ? 'jpg' : $ext];
}

/** Зберегти обкладинку у public/assets/images/marketplace/covers; повертає значення для mp_listings.cover_image. */
function mp_save_cover(array $info): string
{
    $dir = (string) mp_config()['cover_dir'];
    if (!is_dir($dir) && !mkdir($dir, 0775, true) && !is_dir($dir)) {
        throw new RuntimeException('Не вдалося створити теку обкладинок.');
    }
    $name = bin2hex(random_bytes(12)) . '.' . $info['ext'];
    if (!move_uploaded_file($info['tmp'], $dir . '/' . $name)) {
        throw new RuntimeException('Не вдалося зберегти обкладинку.');
    }

    return 'covers/' . $name;
}

/** Запис у журнал модерації (mp_moderation_log). */
function mp_log(PDO $pdo, int $listingId, ?int $actorId, string $action, ?string $note = null): void
{
    $stmt = $pdo->prepare('INSERT INTO mp_moderation_log (listing_id, actor_id, action, note) VALUES (:l, :a, :act, :n)');
    $stmt->execute([':l' => $listingId, ':a' => $actorId, ':act' => mb_substr($action, 0, 30), ':n' => $note !== null ? mb_substr($note, 0, 500) : null]);
}

/** «Працівник №N» / ім'я — для колонки «Хто додав» (users без FK: користувача може не бути). */
function mp_user_label(?string $name, ?string $employeeNumber): string
{
    if ($name === null || $name === '') {
        return '—';
    }
    if ($employeeNumber !== null && $employeeNumber !== '') {
        return 'Працівник №' . (int) $employeeNumber;
    }

    return $name;
}

// =========================================================================
// Публічна частина (marketplace.php, marketplace-category.php, offer.php, get.php)
// Працює лише при config 'public_enabled' => true; показує лише status='published'.
// Публічно НІКОЛИ не віддаються delivery_url і file_id — лише get.php (єдина точка видачі).
// =========================================================================

/** Чи ввімкнена публічна частина. */
function mp_public_enabled(): bool
{
    return mp_config()['public_enabled'] === true;
}

/** 404 без розкриття причини (вимкнено / чернетка / архів / немає такого id). */
function mp_not_found(): never
{
    http_response_code(404);
    header('Content-Type: text/html; charset=utf-8');
    echo "<!DOCTYPE html>\n<html lang=\"en\"><head><meta charset=\"utf-8\"><title>404 Not Found</title></head>"
        . "<body><h1>Not Found</h1><p>The requested URL was not found on this server.</p></body></html>";
    exit;
}

/** Публічні сторінки: при вимкненому перемикачі — 404. Викликати першим рядком сторінки. */
function mp_public_require(): void
{
    if (!mp_public_enabled()) {
        mp_not_found();
    }
}

/**
 * Показувати пункти навігації Marketplace: достатньо ввімкненого перемикача (дошка оголошень
 * має сенс і порожньою — там є кнопка «Подати оголошення»). При вимкненому перемикачі —
 * жодних запитів до БД.
 */
function mp_public_nav_visible(): bool
{
    return mp_public_enabled();
}

/** Мова оригіналу контенту (uk) — для назв категорій. */
function mp_source_lang(): string
{
    return function_exists('translation_source_lang') ? translation_source_lang() : 'uk';
}

/**
 * Категорії розділу з назвами поточною мовою (запасний варіант — мова оригіналу, потім slug)
 * і кількістю опублікованих пропозицій.
 *
 * @return list<array{id:int,slug:string,name:string,cnt:int}>
 */
function mp_public_categories(PDO $pdo, string $lang, string $section = 'solution'): array
{
    $stmt = $pdo->prepare(
        "SELECT c.id, c.slug,
                COALESCE(NULLIF(tl.name, ''), NULLIF(ts.name, ''), c.slug) AS name,
                (SELECT COUNT(*) FROM mp_listing_categories lc
                   JOIN mp_listings l ON l.id = lc.listing_id
                  WHERE lc.category_id = c.id AND l.section = :section2 AND l.status = 'published') AS cnt
         FROM mp_categories c
         LEFT JOIN mp_category_translations tl ON tl.category_id = c.id AND tl.lang = :lang
         LEFT JOIN mp_category_translations ts ON ts.category_id = c.id AND ts.lang = :src
         WHERE c.section = :section AND c.is_active = 1
         ORDER BY c.sort_order, c.id"
    );
    $stmt->execute([':section' => $section, ':section2' => $section, ':lang' => $lang, ':src' => mp_source_lang()]);

    return array_map(
        static fn(array $r): array => ['id' => (int) $r['id'], 'slug' => (string) $r['slug'], 'name' => (string) $r['name'], 'cnt' => (int) $r['cnt']],
        $stmt->fetchAll(PDO::FETCH_ASSOC)
    );
}

/** Спільна частина SELECT: тексти поточною мовою, запасний варіант (по кожному полю) — мова оригіналу (source_lang). */
function mp_public_select(): string
{
    return "SELECT l.id, l.cover_image, l.platform, l.skill_level, l.license, l.delivery_type, l.claims_count,
                   l.published_at, l.source_lang, s.display_name AS seller_name,
                   COALESCE(NULLIF(tc.title, ''), ts.title)           AS title,
                   COALESCE(NULLIF(tc.short_desc, ''), ts.short_desc) AS short_desc,
                   COALESCE(NULLIF(tc.full_desc, ''), ts.full_desc)   AS full_desc,
                   COALESCE(NULLIF(tc.features, ''), ts.features)     AS features,
                   COALESCE(NULLIF(tc.for_whom, ''), ts.for_whom)     AS for_whom,
                   IF(tc.title IS NULL OR tc.title = '', l.source_lang, tc.lang) AS text_lang
            FROM mp_listings l
            LEFT JOIN mp_sellers s ON s.id = l.seller_id
            LEFT JOIN mp_listing_translations tc ON tc.listing_id = l.id AND tc.lang = :lang
            LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang
            WHERE l.section = 'solution' AND l.status = 'published'
              AND COALESCE(NULLIF(tc.title, ''), ts.title) IS NOT NULL";
}

/**
 * Опубліковані пропозиції для карток. Фільтри: category_id, q (пошук за назвою: у мові інтерфейсу або оригіналу).
 *
 * @param array{category_id?:int,q?:string,limit?:int} $opts
 * @return list<array<string,mixed>> кожен рядок має 'categories' => list<{id,name}>
 */
function mp_public_listings(PDO $pdo, string $lang, array $opts = []): array
{
    $sql = mp_public_select();
    $params = [':lang' => $lang];
    $catId = (int) ($opts['category_id'] ?? 0);
    if ($catId > 0) {
        $sql .= ' AND EXISTS (SELECT 1 FROM mp_listing_categories x WHERE x.listing_id = l.id AND x.category_id = :cat)';
        $params[':cat'] = $catId;
    }
    $q = trim((string) ($opts['q'] ?? ''));
    if ($q !== '') {
        $sql .= " AND (tc.title LIKE :q1 ESCAPE '\\\\' OR ts.title LIKE :q2 ESCAPE '\\\\')";
        $like = '%' . addcslashes($q, '%_\\') . '%';
        $params[':q1'] = $like;
        $params[':q2'] = $like;
    }
    $limit = max(1, min(200, (int) ($opts['limit'] ?? 60)));
    $sql .= ' ORDER BY l.published_at DESC, l.id DESC LIMIT ' . $limit;

    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);

    return mp_attach_categories($pdo, $stmt->fetchAll(PDO::FETCH_ASSOC), $lang);
}

/** Одна опублікована пропозиція за id або null (чернетки/архів/невідомий id → null). */
function mp_public_listing(PDO $pdo, int $id, string $lang): ?array
{
    $stmt = $pdo->prepare(mp_public_select() . ' AND l.id = :id');
    $stmt->execute([':lang' => $lang, ':id' => $id]);
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($row === false) {
        return null;
    }

    return mp_attach_categories($pdo, [$row], $lang)[0];
}

/**
 * Додає до рядків ключ 'categories' (назви поточною мовою). Один запит на всі рядки.
 *
 * @param list<array<string,mixed>> $rows
 * @return list<array<string,mixed>>
 */
function mp_attach_categories(PDO $pdo, array $rows, string $lang): array
{
    if ($rows === []) {
        return [];
    }
    $ids = array_map(static fn(array $r): int => (int) $r['id'], $rows);
    $in = implode(',', array_fill(0, count($ids), '?'));
    $stmt = $pdo->prepare(
        "SELECT lc.listing_id, c.id, COALESCE(NULLIF(tl.name, ''), NULLIF(ts.name, ''), c.slug) AS name
         FROM mp_listing_categories lc
         JOIN mp_categories c ON c.id = lc.category_id AND c.is_active = 1
         LEFT JOIN mp_category_translations tl ON tl.category_id = c.id AND tl.lang = ?
         LEFT JOIN mp_category_translations ts ON ts.category_id = c.id AND ts.lang = ?
         WHERE lc.listing_id IN ($in)
         ORDER BY c.sort_order, c.id"
    );
    $stmt->execute(array_merge([$lang, mp_source_lang()], $ids));
    $byListing = [];
    foreach ($stmt->fetchAll(PDO::FETCH_ASSOC) as $r) {
        $byListing[(int) $r['listing_id']][] = ['id' => (int) $r['id'], 'name' => (string) $r['name']];
    }
    foreach ($rows as &$row) {
        $row['categories'] = $byListing[(int) $row['id']] ?? [];
    }
    unset($row);

    return $rows;
}

/** URL обкладинки або null (cover_image зберігається як 'covers/<файл>' відносно public/assets/images/marketplace/). */
function mp_cover_url(?string $cover): ?string
{
    if ($cover === null || !preg_match('~^covers/[A-Za-z0-9._-]+$~', $cover)) {
        return null;
    }

    return '/assets/images/marketplace/' . $cover;
}

/** Підпис рівня навичок (ключі t() skill_*): none/basic/course. */
function mp_skill_text(?string $skill): ?string
{
    return match ($skill) {
        'none', 'basic', 'course' => t('skill_' . $skill),
        default => null,
    };
}

/** http(s)-посилання без пробілів/керівних символів — безпечне для Location. */
function mp_safe_redirect_url(string $url): bool
{
    return mp_is_http_url($url) && !preg_match('/[\x00-\x1F\x7F\s]/', $url);
}

/**
 * Реєструє «отримання» не частіше 1 разу на добу для пари (користувач АБО сесія + пропозиція)
 * й збільшує mp_listings.claims_count. Повертає true, якщо claim створено.
 *
 * Користувач: перевірка за mp_claims (user_id). Гість: у mp_claims немає колонки сесії (ALTER заборонено),
 * тож ліміт для гостя тримається в $_SESSION['mp_claimed'][listing_id] = unix-час останнього claim.
 * Рядок листингу блокується (FOR UPDATE), щоб два паралельні запити не порахувалися двічі.
 */
function mp_register_claim(PDO $pdo, int $listingId, ?int $userId): bool
{
    $now = time();
    if ($userId === null) {
        $last = (int) ($_SESSION['mp_claimed'][$listingId] ?? 0);
        if ($last > $now - 86400) {
            return false;
        }
    }

    $pdo->beginTransaction();
    try {
        $lock = $pdo->prepare("SELECT id FROM mp_listings WHERE id = :id AND status = 'published' FOR UPDATE");
        $lock->execute([':id' => $listingId]);
        if ($lock->fetchColumn() === false) {
            $pdo->rollBack();

            return false;
        }
        if ($userId !== null) {
            $seen = $pdo->prepare('SELECT 1 FROM mp_claims WHERE listing_id = :l AND user_id = :u AND created_at > (NOW() - INTERVAL 1 DAY) LIMIT 1');
            $seen->execute([':l' => $listingId, ':u' => $userId]);
            if ($seen->fetchColumn() !== false) {
                $pdo->rollBack();

                return false;
            }
        }
        $ins = $pdo->prepare('INSERT INTO mp_claims (listing_id, user_id) VALUES (:l, :u)');
        $ins->execute([':l' => $listingId, ':u' => $userId]);
        $upd = $pdo->prepare('UPDATE mp_listings SET claims_count = claims_count + 1 WHERE id = :l');
        $upd->execute([':l' => $listingId]);
        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        throw $e;
    }
    if ($userId === null) {
        $_SESSION['mp_claimed'][$listingId] = $now;
    }

    return true;
}
