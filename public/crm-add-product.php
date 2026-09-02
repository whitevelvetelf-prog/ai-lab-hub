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
require_once __DIR__ . '/../app/translations.php';

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

/**
 * Завантажує вміст сторінки за URL: curl, а якщо його немає —
 * file_get_contents. Повертає HTML або null, якщо не вдалося.
 */
function crm_fetch_url(string $url): ?string
{
    $ua = 'Mozilla/5.0 (compatible; AILabHubBot/1.0)';
    $maxBytes = 2000000; // 2 МБ — достатньо для <head> та основного тексту

    if (function_exists('curl_init')) {
        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_MAXREDIRS => 3,
            CURLOPT_CONNECTTIMEOUT => 6,
            CURLOPT_TIMEOUT => 12,
            CURLOPT_USERAGENT => $ua,
            CURLOPT_SSL_VERIFYPEER => true,
            CURLOPT_SSL_VERIFYHOST => 2,
            CURLOPT_ACCEPT_ENCODING => '',
            CURLOPT_PROTOCOLS => CURLPROTO_HTTP | CURLPROTO_HTTPS,
            CURLOPT_REDIR_PROTOCOLS => CURLPROTO_HTTP | CURLPROTO_HTTPS,
        ]);
        $body = curl_exec($ch);
        $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
        curl_close($ch);

        if (is_string($body) && $body !== '' && $code < 400) {
            return strlen($body) > $maxBytes ? substr($body, 0, $maxBytes) : $body;
        }

        return null;
    }

    if (!ini_get('allow_url_fopen')) {
        return null;
    }

    $ctx = stream_context_create([
        'http' => [
            'method' => 'GET',
            'timeout' => 12,
            'follow_location' => 1,
            'max_redirects' => 3,
            'header' => "User-Agent: {$ua}\r\nAccept: text/html,application/xhtml+xml\r\n",
        ],
        'ssl' => ['verify_peer' => true, 'verify_peer_name' => true],
    ]);
    $body = @file_get_contents($url, false, $ctx, 0, $maxBytes);

    return is_string($body) && $body !== '' ? $body : null;
}

/** Декодує HTML-сутності та стискає пробіли — повертає однорядковий текст. */
function crm_clean_text(string $text): string
{
    $text = html_entity_decode($text, ENT_QUOTES | ENT_HTML5, 'UTF-8');
    $text = preg_replace('/\s+/u', ' ', $text) ?? $text;

    return trim($text);
}

/** content першого <meta name="..."> (або property="...") зі сторінки. */
function crm_meta(string $html, string $key, string $attr = 'name'): string
{
    $pattern = '#<meta[^>]+' . $attr . '=["\']' . preg_quote($key, '#') . '["\'][^>]*>#i';
    if (preg_match($pattern, $html, $tag)
        && preg_match('#content=["\'](.*?)["\']#is', $tag[0], $content)) {
        return crm_clean_text($content[1]);
    }

    return '';
}

/** Відрізає «хвіст» заголовка після типового роздільника: «Назва — Гасло». */
function crm_trim_title(string $title): string
{
    $title = crm_clean_text($title);
    $parts = preg_split('/\s+[|\x{2013}\x{2014}\x{00B7}:\-]\s+/u', $title, 2);
    if (is_array($parts) && isset($parts[0]) && mb_strlen($parts[0]) >= 2) {
        $title = $parts[0];
    }

    return mb_substr($title, 0, 255);
}

/**
 * Базове автозаповнення картки продукту зі сторінки офіційного сайту.
 * БЕЗ AI: сторінка завантажується, HTML чиститься (script/style/теги),
 * назва й опис дістаються простими евристиками — title сторінки як назва,
 * meta description як короткий опис. Повноцінну AI-обробку підключимо
 * окремим кроком, коли визначимося з конкретним AI API.
 *
 * @return array{ok: bool, error?: string, fields?: array<string, string>, meta?: array<string, mixed>}
 */
function crm_autofill_from_url(string $rawUrl): array
{
    $url = trim($rawUrl);
    if ($url === '') {
        return ['ok' => false, 'error' => 'Вкажіть URL офіційного сайту продукту.'];
    }
    if (!preg_match('#^https?://#i', $url)) {
        $url = 'https://' . $url;
    }
    if (filter_var($url, FILTER_VALIDATE_URL) === false) {
        return ['ok' => false, 'error' => 'Некоректний URL.'];
    }

    $host = (string) parse_url($url, PHP_URL_HOST);
    if ($host === '') {
        return ['ok' => false, 'error' => 'Не вдалося визначити домен у URL.'];
    }

    // Мінімальний захист від SSRF: без localhost та приватних діапазонів.
    if (preg_match('/^(localhost|127\.|0\.|10\.|192\.168\.|169\.254\.)/i', $host)
        || preg_match('/^172\.(1[6-9]|2\d|3[01])\./', $host)
        || $host === '::1') {
        return ['ok' => false, 'error' => 'URL веде на локальну / приватну адресу — завантаження заборонено.'];
    }
    $ip = gethostbyname($host);
    if (filter_var($ip, FILTER_VALIDATE_IP) !== false
        && filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE) === false) {
        return ['ok' => false, 'error' => 'URL веде на локальну / приватну адресу — завантаження заборонено.'];
    }

    $html = crm_fetch_url($url);
    if ($html === null) {
        return ['ok' => false, 'error' => 'Не вдалося завантажити сторінку за цим URL.'];
    }

    // Приводимо до UTF-8, якщо сторінка оголошує інше кодування.
    if (preg_match('#<meta[^>]+charset=["\']?\s*([a-z0-9\-]+)#i', $html, $cs)) {
        $charset = strtoupper(trim($cs[1]));
        if ($charset !== '' && $charset !== 'UTF-8' && function_exists('mb_convert_encoding')) {
            $converted = @mb_convert_encoding($html, 'UTF-8', $charset);
            if (is_string($converted) && $converted !== '') {
                $html = $converted;
            }
        }
    }

    $pageTitle = '';
    if (preg_match('#<title[^>]*>(.*?)</title>#is', $html, $t)) {
        $pageTitle = crm_clean_text($t[1]);
    }

    $metaDescription = crm_meta($html, 'description');
    $ogTitle = crm_meta($html, 'og:title', 'property');
    $ogDescription = crm_meta($html, 'og:description', 'property');
    $ogSiteName = crm_meta($html, 'og:site_name', 'property');

    // Основний текст сторінки — для запасного короткого опису, якщо немає
    // meta description. Спершу викидаємо службові блоки, потім усі теги.
    $body = preg_replace(
        '#<(script|style|noscript|svg|template|head|nav|footer)\b[^>]*>.*?</\1>#is',
        ' ',
        $html
    ) ?? $html;
    $body = preg_replace('#<[^>]+>#', ' ', $body) ?? $body;
    $bodyText = crm_clean_text($body);

    // Запасний короткий опис — перше змістовне речення зі сторінки.
    $firstSentence = '';
    if ($bodyText !== '') {
        $firstSentence = preg_match('#(.{40,300}?[.!?])(\s|$)#u', $bodyText, $sentence)
            ? trim($sentence[1])
            : mb_substr($bodyText, 0, 200);
    }

    // Евристика назви: og:site_name → og:title → <title> (до роздільника).
    $name = $ogSiteName !== '' ? $ogSiteName : ($ogTitle !== '' ? $ogTitle : $pageTitle);
    $name = crm_trim_title($name);

    // Евристика короткого опису: meta description → og:description → 1-ше речення.
    $shortDescription = $metaDescription !== ''
        ? $metaDescription
        : ($ogDescription !== '' ? $ogDescription : $firstSentence);
    $shortDescription = mb_substr(crm_clean_text($shortDescription), 0, 500);

    return [
        'ok' => true,
        'fields' => [
            'name' => $name,
            'official_url' => $url,
            'short_description' => $shortDescription,
        ],
        'meta' => [
            'page_title' => $pageTitle,
            'source_url' => $url,
            'used_ai' => false,
        ],
    ];
}

/**
 * Миттєва перевірка на можливий дублікат за назвою та/або офіційним URL —
 * той самий принцип, що й серверна антидубль-перевірка при збереженні.
 *
 * @return array<int, array<string, mixed>>
 */
function crm_find_similar(PDO $pdo, string $name, string $officialUrl): array
{
    $name = trim($name);
    $normUrl = $officialUrl !== '' ? normalize_url($officialUrl) : '';

    $conditions = [];
    $params = [];
    if (mb_strlen($name) >= 2) {
        $conditions[] = "(name LIKE CONCAT('%', :name1, '%') OR :name2 LIKE CONCAT('%', name, '%'))";
        $params[':name1'] = $name;
        $params[':name2'] = $name;
    }
    if ($normUrl !== '') {
        $conditions[] = "(official_url IS NOT NULL AND official_url <> '' AND "
            . "TRIM(TRAILING '/' FROM "
            . "REPLACE(REPLACE(REPLACE(LOWER(TRIM(official_url)), 'https://', ''), 'http://', ''), 'www.', '')"
            . ") = :norm_url)";
        $params[':norm_url'] = $normUrl;
    }
    if ($conditions === []) {
        return [];
    }

    $stmt = $pdo->prepare(
        'SELECT id, name, official_url, status FROM products WHERE '
        . implode(' OR ', $conditions)
        . ' ORDER BY name LIMIT 20'
    );
    $stmt->execute($params);

    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// --- AJAX-ендпоінти: автозаповнення з URL + миттєва перевірка дубліката ---
if (($_GET['ajax'] ?? '') !== '') {
    header('Content-Type: application/json; charset=utf-8');
    $ajax = (string) $_GET['ajax'];

    if ($ajax === 'autofill') {
        echo json_encode(
            crm_autofill_from_url((string) ($_GET['url'] ?? '')),
            JSON_UNESCAPED_UNICODE
        );
        exit;
    }

    if ($ajax === 'dupcheck') {
        echo json_encode(
            ['similar' => crm_find_similar(
                $pdo,
                (string) ($_GET['name'] ?? ''),
                trim((string) ($_GET['url'] ?? ''))
            )],
            JSON_UNESCAPED_UNICODE
        );
        exit;
    }

    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'Невідома дія.'], JSON_UNESCAPED_UNICODE);
    exit;
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

        /* Автозаповнення з URL */
        .autofill {
            padding: 16px 18px;
            border: 1px dashed rgba(91, 140, 255, 0.55);
            border-radius: 12px;
            background: rgba(91, 140, 255, 0.08);
        }

        .autofill__row {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .autofill__row .input {
            flex: 1;
            min-width: 0;
        }

        @media (max-width: 560px) {
            .autofill__row {
                flex-wrap: wrap;
            }

            .autofill__row .btn {
                width: 100%;
            }
        }

        .autofill__status,
        .dup-check {
            margin: 10px 0 0;
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .dup-check {
            margin: 8px 0 0;
        }

        .autofill__status.is-warn,
        .dup-check.is-warn {
            color: #fcd34d;
        }

        .autofill__status.is-ok,
        .dup-check.is-ok {
            color: #6ee7b7;
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
        </a>
    </header>

    <div class="page">
        <p style="margin:0 0 16px;">
            <a class="btn btn--ghost btn--sm" href="crm-list.php">← До списку продуктів</a>
        </p>
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
                    · <a href="index.php">до напрямків AI</a>
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
            <div class="field autofill" id="autofill-box">
                <label class="field__label" for="autofill_url">Автозаповнити з посилання</label>
                <div class="autofill__row">
                    <input class="input" type="url" id="autofill_url"
                           placeholder="https://офіційний-сайт-продукту.com">
                    <button type="button" class="btn btn--ghost btn--sm" id="autofill-btn">Автозаповнити</button>
                </div>
                <p class="field__hint">
                    Завантажимо сторінку за цим URL, приберемо HTML і витягнемо назву та опис
                    (поки що без AI — прості евристики: заголовок сторінки → назва,
                    meta description → короткий опис). Поля лише заповнюються чернетково —
                    перевірте й відкоригуйте їх перед збереженням.
                </p>
                <p class="autofill__status" id="autofill-status" role="status" aria-live="polite" hidden></p>
            </div>

            <div class="field">
                <label class="field__label" for="name">Назва продукту <span class="req">*</span></label>
                <input class="input" type="text" id="name" name="name" required
                       value="<?= e($old['name']) ?>" placeholder="Напр. TestAI Pro">
                <p class="dup-check" id="dup-check" role="status" aria-live="polite" hidden></p>
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
                <a class="btn btn--ghost" href="index.php">Скасувати</a>
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

        // --- Автозаповнення форми з URL + миттєва перевірка дубліката ---
        (function () {
            var endpoint = 'crm-add-product.php';
            var urlInput = document.getElementById('autofill_url');
            var autofillBtn = document.getElementById('autofill-btn');
            var autofillStatus = document.getElementById('autofill-status');
            var nameInput = document.getElementById('name');
            var officialUrlInput = document.getElementById('official_url');
            var dupCheck = document.getElementById('dup-check');

            function setStatus(el, message, kind) {
                el.className = el.className.replace(/\s*is-\w+/g, '');
                if (!message) {
                    el.hidden = true;
                    el.textContent = '';
                    return;
                }
                el.hidden = false;
                el.textContent = message;
                if (kind) {
                    el.className += ' is-' + kind;
                }
            }

            function fillField(id, value) {
                if (!value) {
                    return;
                }
                var el = document.getElementById(id);
                if (!el) {
                    return;
                }
                el.value = value;
                el.dispatchEvent(new Event('input', { bubbles: true }));
            }

            // --- Миттєва перевірка дубліката за назвою / URL ---
            var dupTimer = null;
            var dupController = null;

            function runDuplicateCheck() {
                var name = (nameInput.value || '').trim();
                var url = (officialUrlInput.value || '').trim();
                if (name.length < 2 && !url) {
                    setStatus(dupCheck, '', '');
                    return;
                }
                if (dupController) {
                    dupController.abort();
                }
                dupController = ('AbortController' in window) ? new AbortController() : null;
                setStatus(dupCheck, 'Перевіряємо, чи такий продукт уже є в базі…', 'pending');

                var query = endpoint + '?ajax=dupcheck'
                    + '&name=' + encodeURIComponent(name)
                    + '&url=' + encodeURIComponent(url);

                fetch(query, {
                    headers: { 'X-Requested-With': 'fetch' },
                    signal: dupController ? dupController.signal : undefined
                })
                    .then(function (response) { return response.json(); })
                    .then(function (data) {
                        var similar = (data && data.similar) || [];
                        if (!similar.length) {
                            setStatus(dupCheck, 'Схожих продуктів у базі не знайдено.', 'ok');
                            return;
                        }
                        var names = similar.slice(0, 5).map(function (p) { return p.name; }).join(', ');
                        var tail = similar.length > 5 ? ' та інші' : '';
                        setStatus(
                            dupCheck,
                            'Можливий дублікат — знайдено ' + similar.length + ': ' + names + tail
                                + '. Перевірте список при збереженні.',
                            'warn'
                        );
                    })
                    .catch(function (error) {
                        if (error && error.name === 'AbortError') {
                            return;
                        }
                        setStatus(dupCheck, '', '');
                    });
            }

            function scheduleDuplicateCheck() {
                clearTimeout(dupTimer);
                dupTimer = setTimeout(runDuplicateCheck, 400);
            }

            nameInput.addEventListener('input', scheduleDuplicateCheck);
            nameInput.addEventListener('blur', runDuplicateCheck);
            officialUrlInput.addEventListener('blur', runDuplicateCheck);

            // --- Автозаповнення з офіційного сайту ---
            autofillBtn.addEventListener('click', function () {
                var url = (urlInput.value || '').trim();
                if (!url) {
                    setStatus(autofillStatus, 'Вставте URL офіційного сайту продукту.', 'warn');
                    urlInput.focus();
                    return;
                }

                autofillBtn.disabled = true;
                setStatus(autofillStatus, 'Завантажуємо сторінку та розбираємо вміст…', 'pending');

                fetch(endpoint + '?ajax=autofill&url=' + encodeURIComponent(url), {
                    headers: { 'X-Requested-With': 'fetch' }
                })
                    .then(function (response) { return response.json(); })
                    .then(function (data) {
                        if (!data || !data.ok) {
                            setStatus(
                                autofillStatus,
                                (data && data.error) || 'Не вдалося обробити сторінку.',
                                'warn'
                            );
                            return;
                        }
                        var fields = data.fields || {};
                        fillField('name', fields.name);
                        fillField('official_url', fields.official_url);
                        fillField('short_description', fields.short_description);
                        setStatus(
                            autofillStatus,
                            'Поля заповнено чернетково (без AI, за евристиками). '
                                + 'Перевірте й відкоригуйте їх перед збереженням.',
                            'ok'
                        );
                        // Одразу після заповнення назви — миттєва перевірка дубліката.
                        runDuplicateCheck();
                    })
                    .catch(function () {
                        setStatus(autofillStatus, 'Помилка запиту. Спробуйте ще раз.', 'warn');
                    })
                    .then(function () {
                        autofillBtn.disabled = false;
                    });
            });
        })();
    </script>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
