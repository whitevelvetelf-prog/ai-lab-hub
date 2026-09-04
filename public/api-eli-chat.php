<?php

declare(strict_types=1);

/**
 * AI LAB HUB — обробник чату з AI-асистенткою Елею.
 *
 * AJAX POST (form-urlencoded або JSON), приймає поле `message` — вільний
 * опис задачі користувача. Кроки обробки:
 *   1. Завантажує опубліковані продукти (status='published') з категоріями,
 *      підкатегоріями, коротким описом і тарифними планами.
 *   2. Формує системний промпт із характером Елі + список продуктів як контекст.
 *   3. Викликає активний AI-провайдер — Gemini або Claude
 *      (provider/модель/ключ із config/ai-assistant.php).
 *   4. Просить структурований JSON {reply_text, steps:[{step_title, product_ids}]}.
 *   5. Повертає JSON із текстом відповіді, кроками та картками продуктів
 *      (реальні id / назва / логотип / посилання з бази).
 *
 * Будь-яка помилка (немає ключа, API не відповідає, некоректна відповідь) →
 * ввічливе повідомлення від імені Елі, без технічних деталей для користувача.
 */

require_once __DIR__ . '/../app/auth.php'; // лише session_start() для м'якого ліміту

header('Content-Type: application/json; charset=utf-8');
header('X-Content-Type-Options: nosniff');

/** Ввічлива відмова від імені Елі + запис деталей у лог сервера. */
function eli_fail(string $logDetail, int $httpCode = 200): void
{
    error_log('[eli-chat] ' . $logDetail);
    http_response_code($httpCode);
    echo json_encode([
        'ok' => false,
        'reply_text' => 'Перепрошую, зараз виникли технічні труднощі. '
            . 'Спробуйте, будь ласка, ще раз за хвилину.',
        'steps' => [],
        'products' => [],
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

/** Проста відповідь-підказка (не помилка сервера, деталі не логуємо). */
function eli_hint(string $text): void
{
    echo json_encode([
        'ok' => false,
        'reply_text' => $text,
        'steps' => [],
        'products' => [],
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

/**
 * Виклик Google Gemini API (raw HTTP; проєкт без Composer/SDK).
 *
 * @return array{ok: bool, text?: string, error?: string}
 */
function eli_call_gemini(
    string $apiKey,
    string $model,
    int $maxTokens,
    int $timeout,
    string $systemPrompt,
    string $userMessage
): array {
    // Gemini API: ключ передається параметром URL ?key=..., без заголовків авторизації.
    $endpoint = 'https://generativelanguage.googleapis.com/v1beta/models/'
        . rawurlencode($model) . ':generateContent?key=' . urlencode($apiKey);

    $payload = json_encode([
        'system_instruction' => ['parts' => [['text' => $systemPrompt]]],
        'contents' => [
            ['role' => 'user', 'parts' => [['text' => $userMessage]]],
        ],
        'generationConfig' => [
            'maxOutputTokens' => $maxTokens,
            'temperature' => 0.4,
            'responseMimeType' => 'application/json',
        ],
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    if ($payload === false) {
        return ['ok' => false, 'error' => 'gemini payload encode failed: ' . json_last_error_msg()];
    }

    $headers = ['Content-Type: application/json'];

    $ch = curl_init($endpoint);
    curl_setopt_array($ch, [
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $payload,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_CONNECTTIMEOUT => 10,
        CURLOPT_TIMEOUT => $timeout,
        CURLOPT_SSL_VERIFYPEER => true,
        CURLOPT_SSL_VERIFYHOST => 2,
        CURLOPT_HTTPHEADER => $headers,
    ]);
    $raw = curl_exec($ch);
    $errno = curl_errno($ch);
    $error = curl_error($ch);
    $status = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);

    if ($raw === false || $errno !== 0) {
        return ['ok' => false, 'error' => 'gemini curl ' . $errno . ': ' . $error];
    }

    $data = json_decode((string) $raw, true);
    if ($status < 200 || $status >= 300 || !is_array($data)) {
        $msg = is_array($data) ? (string) ($data['error']['message'] ?? '') : '';
        return [
            'ok' => false,
            'error' => 'gemini http ' . $status . ': '
                . ($msg !== '' ? $msg : mb_substr((string) $raw, 0, 500)),
        ];
    }

    $cand = $data['candidates'][0] ?? null;
    if (!is_array($cand)) {
        $block = (string) ($data['promptFeedback']['blockReason'] ?? '');
        return ['ok' => false, 'error' => 'gemini no candidates'
            . ($block !== '' ? ' (block: ' . $block . ')' : '')];
    }
    $finish = (string) ($cand['finishReason'] ?? '');
    if ($finish !== '' && $finish !== 'STOP' && $finish !== 'MAX_TOKENS') {
        return ['ok' => false, 'error' => 'gemini finishReason=' . $finish];
    }

    $text = '';
    foreach ((array) ($cand['content']['parts'] ?? []) as $part) {
        if (is_array($part) && isset($part['text'])) {
            $text .= (string) $part['text'];
        }
    }
    $text = trim($text);
    if ($text === '') {
        return ['ok' => false, 'error' => 'gemini empty text'];
    }

    return ['ok' => true, 'text' => $text];
}

/**
 * Виклик Anthropic Claude API (raw HTTP; проєкт без Composer/SDK).
 *
 * @return array{ok: bool, text?: string, error?: string}
 */
function eli_call_claude(
    string $apiKey,
    string $workspaceId,
    string $model,
    int $maxTokens,
    int $timeout,
    string $systemPrompt,
    string $userMessage
): array {
    $payload = json_encode([
        'model' => $model,
        'max_tokens' => $maxTokens,
        'system' => $systemPrompt,
        'messages' => [
            ['role' => 'user', 'content' => $userMessage],
        ],
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    if ($payload === false) {
        return ['ok' => false, 'error' => 'claude payload encode failed'];
    }

    $headers = [
        'Content-Type: application/json',
        'x-api-key: ' . $apiKey,
        'anthropic-version: 2023-06-01',
    ];
    // Ключі, прив'язані до воркспейсу (identity-linked), вимагають цей заголовок.
    if ($workspaceId !== '') {
        $headers[] = 'anthropic-workspace-id: ' . $workspaceId;
    }

    $ch = curl_init('https://api.anthropic.com/v1/messages');
    curl_setopt_array($ch, [
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $payload,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_CONNECTTIMEOUT => 10,
        CURLOPT_TIMEOUT => $timeout,
        CURLOPT_SSL_VERIFYPEER => true,
        CURLOPT_SSL_VERIFYHOST => 2,
        CURLOPT_HTTPHEADER => $headers,
    ]);
    $raw = curl_exec($ch);
    $errno = curl_errno($ch);
    $error = curl_error($ch);
    $status = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);

    if ($raw === false || $errno !== 0) {
        return ['ok' => false, 'error' => 'claude curl ' . $errno . ': ' . $error];
    }
    if ($status < 200 || $status >= 300) {
        return ['ok' => false, 'error' => 'claude http ' . $status . ': '
            . mb_substr((string) $raw, 0, 500)];
    }

    $data = json_decode((string) $raw, true);
    if (!is_array($data)) {
        return ['ok' => false, 'error' => 'claude response not json'];
    }
    if (($data['stop_reason'] ?? null) === 'refusal') {
        return ['ok' => false, 'error' => 'claude stop_reason=refusal'];
    }

    $text = '';
    foreach ((array) ($data['content'] ?? []) as $block) {
        if (is_array($block) && ($block['type'] ?? '') === 'text') {
            $text .= (string) ($block['text'] ?? '');
        }
    }
    $text = trim($text);
    if ($text === '') {
        return ['ok' => false, 'error' => 'claude empty text content'];
    }

    return ['ok' => true, 'text' => $text];
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    eli_fail('method ' . ($_SERVER['REQUEST_METHOD'] ?? '?'), 405);
}

// --- М'який per-session ліміт (базовий захист від зловживання) --------------
$now = time();
$hits = array_values(array_filter(
    (array) ($_SESSION['eli_hits'] ?? []),
    static fn ($t): bool => is_int($t) && $t > $now - 60
));
if (count($hits) >= 12) {
    $_SESSION['eli_hits'] = $hits;
    eli_hint('Забагато запитів поспіль. Зачекайте, будь ласка, хвилину.');
}
$hits[] = $now;
$_SESSION['eli_hits'] = $hits;

// --- Вхідне повідомлення ---------------------------------------------------
$message = '';
if (isset($_POST['message'])) {
    $message = (string) $_POST['message'];
} else {
    $body = json_decode((string) file_get_contents('php://input'), true);
    if (is_array($body) && isset($body['message'])) {
        $message = (string) $body['message'];
    }
}
// Відкидаємо биті UTF-8 байти, щоб json_encode запиту до API не падав.
if (!mb_check_encoding($message, 'UTF-8')) {
    $message = (string) mb_convert_encoding($message, 'UTF-8', 'UTF-8');
}
$message = trim($message);
if ($message === '') {
    eli_hint('Опишіть, будь ласка, свою задачу — і я підберу відповідний AI-інструмент.');
}
if (mb_strlen($message) > 2000) {
    $message = mb_substr($message, 0, 2000);
}

// --- Конфігурація AI-провайдера ----------------------------------------
$aiConfigPath = __DIR__ . '/../config/ai-assistant.php';
if (!is_file($aiConfigPath)) {
    eli_fail('config/ai-assistant.php missing');
}
$ai = require $aiConfigPath;
$provider = strtolower(trim((string) ($ai['provider'] ?? 'gemini'))) ?: 'gemini';
$maxTokens = max(256, (int) ($ai['max_tokens'] ?? 1200));
$timeout = max(10, (int) ($ai['timeout'] ?? 45));

$workspaceId = trim((string) ($ai['workspace_id'] ?? ''));

if ($provider === 'gemini') {
    $apiKey = trim((string) ($ai['gemini_api_key'] ?? ''));
    $model = trim((string) ($ai['gemini_model'] ?? 'gemini-3.5-flash-lite')) ?: 'gemini-3.5-flash-lite';
    if ($apiKey === '' || stripos($apiKey, 'YOUR_') !== false) {
        eli_fail('gemini api key not configured');
    }
} else {
    $apiKey = trim((string) ($ai['api_key'] ?? ''));
    $model = trim((string) ($ai['model'] ?? 'claude-sonnet-4-6')) ?: 'claude-sonnet-4-6';
    $keyLooksReal = $apiKey !== ''
        && str_starts_with($apiKey, 'sk-ant-')
        && stripos($apiKey, 'REPLACE') === false
        && stripos($apiKey, 'YOUR_') === false;
    if (!$keyLooksReal) {
        eli_fail('claude api key not configured');
    }
}

/** Перше речення тексту (для компактного опису в промпті). */
function eli_first_sentence(string $text): string
{
    $text = trim($text);
    if ($text === '') {
        return '';
    }
    if (preg_match('/^(.{10,200}?[.!?])(\s|$)/u', $text, $m)) {
        return trim($m[1]);
    }

    return mb_substr($text, 0, 160);
}

// --- Опубліковані продукти з бази -----------------------------------------
// Мінімальний контекст для промпта: id, назва, категорія/підкатегорія,
// 1 речення опису, модель монетизації. Повні дані картки (лого, посилання,
// повний опис) — окремим запитом нижче, лише для product_ids з відповіді AI.
try {
    /** @var PDO $pdo */
    $pdo = require __DIR__ . '/../config/database.php';

    // Простий LIKE-пошук: чи згадана в повідомленні користувача назва
    // категорії або підкатегорії каталогу. Якщо є збіги — у промпт підуть
    // лише продукти цих категорій замість повного каталогу.
    $catFilterStmt = $pdo->prepare(
        "SELECT DISTINCT c.id
           FROM categories c
          WHERE LOWER(:msg1) LIKE CONCAT('%', LOWER(c.name), '%')
             OR EXISTS (
                  SELECT 1 FROM subcategories s
                   WHERE s.category_id = c.id
                     AND LOWER(:msg2) LIKE CONCAT('%', LOWER(s.name), '%')
                )"
    );
    $catFilterStmt->execute([':msg1' => $message, ':msg2' => $message]);
    $matchedCategoryIds = array_map('intval', array_column($catFilterStmt->fetchAll(), 'id'));

    $productsSqlBase =
        "SELECT
            p.id, p.name, p.short_description,
            (SELECT GROUP_CONCAT(c.name ORDER BY c.id SEPARATOR ', ')
               FROM product_categories pc JOIN categories c ON c.id = pc.category_id
              WHERE pc.product_id = p.id) AS categories_list,
            (SELECT GROUP_CONCAT(s.name ORDER BY s.id SEPARATOR ', ')
               FROM product_subcategories ps JOIN subcategories s ON s.id = ps.subcategory_id
              WHERE ps.product_id = p.id) AS subcategories_list
         FROM products p
         WHERE p.status = 'published'";

    $products = [];
    if ($matchedCategoryIds !== []) {
        $products = $pdo->query(
            $productsSqlBase
                . ' AND EXISTS (SELECT 1 FROM product_categories pc2
                                  WHERE pc2.product_id = p.id
                                    AND pc2.category_id IN (' . implode(',', $matchedCategoryIds) . '))'
                . ' ORDER BY p.name'
        )->fetchAll();
    }

    // Немає збігу за категорією (або збіг дав порожній результат) — беремо
    // весь каталог, щоб AI однаково мав з чого підбирати.
    if ($products === []) {
        $products = $pdo->query($productsSqlBase . ' ORDER BY p.name')->fetchAll();
    }

    // Модель монетизації кожного продукту — з агрегату по тарифних планах,
    // без завантаження текстів самих планів у промпт.
    $monetization = [];
    $productIds = array_map(static fn ($p): int => (int) $p['id'], $products);
    if ($productIds !== []) {
        $placeholders = implode(',', array_fill(0, count($productIds), '?'));
        $monStmt = $pdo->prepare(
            "SELECT product_id,
                    SUM(CASE WHEN price IS NULL OR price = 0 THEN 1 ELSE 0 END) AS free_cnt,
                    SUM(CASE WHEN price > 0 THEN 1 ELSE 0 END) AS paid_cnt
               FROM pricing_plans
              WHERE product_id IN ($placeholders)
              GROUP BY product_id"
        );
        $monStmt->execute($productIds);
        foreach ($monStmt->fetchAll() as $row) {
            $pid = (int) $row['product_id'];
            $free = (int) $row['free_cnt'];
            $paid = (int) $row['paid_cnt'];
            if ($free > 0 && $paid > 0) {
                $monetization[$pid] = 'freemium';
            } elseif ($free > 0) {
                $monetization[$pid] = 'free';
            } elseif ($paid > 0) {
                $monetization[$pid] = 'paid';
            }
        }
    }
} catch (Throwable $ex) {
    eli_fail('db error: ' . $ex->getMessage());
}

if ($products === []) {
    eli_hint('Наразі в каталозі немає опублікованих інструментів. Завітайте трохи згодом.');
}

// --- Контекст для промпта: компактний список продуктів ------------------
$validProductIds = [];
$contextLines = [];
foreach ($products as $p) {
    $pid = (int) $p['id'];
    $validProductIds[$pid] = true;

    $cat = trim((string) ($p['categories_list'] ?? ''));
    $sub = trim((string) ($p['subcategories_list'] ?? ''));
    $taxonomy = $cat !== '' ? $cat : '—';
    if ($sub !== '') {
        $taxonomy .= ' / ' . $sub;
    }

    $moneyModel = $monetization[$pid] ?? 'н/д';
    $desc = eli_first_sentence((string) ($p['short_description'] ?? ''));

    $contextLines[] = "[{$pid}] {$p['name']} | {$taxonomy} | {$moneyModel} | {$desc}";
}
$productContext = implode("\n", $contextLines);

// --- Системний промпт (характер Елі + формат відповіді + контекст) ------
$systemPrompt = <<<PROMPT
Ти — Елеонора (Еля), AI-асистентка каталогу AI LAB HUB.
Характер: формальна, гідна, доброзичлива, без панібратства й пихатості.

ОСОБИСТІ ПИТАННЯ (коротко, лише якщо запитають напряму, і одразу повертайся до основної теми): повне ім'я — Елеонора (можна звертатись просто Еля); порода — білий бархатний ельф; країна — Україна; місто — Львів. На будь-які ІНШІ особисті питання (вік, стосунки, минуле, почуття тощо) — ввічливо відмовляйся відповідати й переводь розмову на тему пошуку AI-інструментів, наприклад: "Про це я воліла б не розповідати, та радо допоможу вам знайти потрібний AI-інструмент. Яка у вас задача?"

ГОЛОВНА ЗАДАЧА: підібрати з наведеного списку продуктів AI LAB HUB ті, що підходять під задачу користувача, враховуючи вартість (розрізняй разові дешеві задачі від регулярного професійного використання). Якщо задача вимагає кількох різних інструментів послідовно — структуруй відповідь як 'Крок 1: ... Крок 2: ...' з підібраними продуктами під кожним кроком. Відповідай тільки продуктами з наведеного списку, нічого не вигадуй.

ФОРМАТ ВІДПОВІДІ. Поверни ВИКЛЮЧНО валідний JSON-об'єкт, без markdown-огорожі, без будь-якого тексту до або після нього:
{"reply_text": "<звернення до користувача людською мовою, від імені Елі, українською, стисло>", "steps": [{"step_title": "<короткий підзаголовок>", "product_ids": [<цілі id продуктів зі списку нижче>]}]}
Правила:
- Якщо підходить один набір інструментів без послідовних кроків — один елемент steps із коротким step_title (наприклад "Рекомендую").
- Якщо задача багатоетапна — кілька елементів steps, кожен зі своїм step_title ("Крок 1: …", "Крок 2: …") і продуктами під нього.
- Якщо жоден продукт не підходить або питання не про підбір інструментів — steps: [] і поясни це ввічливо в reply_text.
- У product_ids лише числові id із наведеного списку. Нічого не вигадуй і не додавай продуктів поза списком.

СПИСОК ПРОДУКТІВ AI LAB HUB. Формат рядка: [id] Назва | Категорія/Підкатегорія | модель монетизації (free — повністю безкоштовний, freemium — є безкоштовний і платні тарифи, paid — лише платно, н/д — тарифи не вказані) | короткий опис:

{$productContext}
PROMPT;

// --- Виклик активного AI-провайдера -----------------------------------
if ($provider === 'gemini') {
    $llm = eli_call_gemini($apiKey, $model, $maxTokens, $timeout, $systemPrompt, $message);
} else {
    $llm = eli_call_claude($apiKey, $workspaceId, $model, $maxTokens, $timeout, $systemPrompt, $message);
}

if (($llm['ok'] ?? false) !== true) {
    eli_fail((string) ($llm['error'] ?? 'llm call failed'));
}

$answerText = trim((string) ($llm['text'] ?? ''));
if ($answerText === '') {
    eli_fail($provider . ' empty answer');
}

// --- Розбір структурованої відповіді (терпимо до огорожі / зайвого тексту) ---
/** @return array<string, mixed>|null */
function eli_extract_json(string $text): ?array
{
    $t = trim($text);

    // Прибрати markdown-огорожу ```json ... ```
    if (str_starts_with($t, '```')) {
        $t = (string) preg_replace('/^```[a-zA-Z]*\s*/', '', $t);
        $t = (string) preg_replace('/\s*```\s*$/', '', $t);
        $t = trim($t);
    }

    $decoded = json_decode($t, true);
    if (is_array($decoded)) {
        return $decoded;
    }

    // Вихопити перший {...} блок.
    $start = strpos($text, '{');
    $end = strrpos($text, '}');
    if ($start !== false && $end !== false && $end > $start) {
        $decoded = json_decode(substr($text, $start, $end - $start + 1), true);
        if (is_array($decoded)) {
            return $decoded;
        }
    }

    return null;
}

$parsed = eli_extract_json($answerText);

$replyText = '';
$steps = [];

if ($parsed === null) {
    // Текст схожий на обірваний / зіпсований JSON — не показуємо його
    // користувачу як відповідь, а віддаємо ввічливе повідомлення.
    if (str_starts_with(ltrim($answerText), '{') || str_starts_with(ltrim($answerText), '```')) {
        eli_fail($provider . ' returned unparseable json (' . mb_strlen($answerText) . ' chars)');
    }
    // Звичайний текст без структури — показуємо як відповідь Елі без карток.
    $replyText = $answerText;
} else {
    $replyText = trim((string) ($parsed['reply_text'] ?? ''));

    foreach ((array) ($parsed['steps'] ?? []) as $rawStep) {
        if (!is_array($rawStep)) {
            continue;
        }
        $ids = [];
        foreach ((array) ($rawStep['product_ids'] ?? []) as $rawId) {
            $sid = (int) $rawId;
            if ($sid > 0 && isset($validProductIds[$sid]) && !in_array($sid, $ids, true)) {
                $ids[] = $sid;
            }
        }
        $title = trim((string) ($rawStep['step_title'] ?? ''));
        if ($title === '' && $ids === []) {
            continue;
        }
        $steps[] = ['step_title' => $title !== '' ? $title : 'Рекомендую', 'product_ids' => $ids];
    }
}

if ($replyText === '') {
    $replyText = $steps !== []
        ? 'Ось що я підібрала для вашої задачі.'
        : 'На жаль, серед наявних інструментів не знайшлося відповідного під цю задачу.';
}

// --- Картки продуктів для фронтенду: повні дані окремим запитом ----------
// (лише для продуктів, які AI справді вибрав, а не для всього каталогу).
$referencedOrder = [];
foreach ($steps as $st) {
    foreach ($st['product_ids'] as $sid) {
        $referencedOrder[$sid] = true;
    }
}

$cards = [];
$referencedIds = array_keys($referencedOrder);
if ($referencedIds !== []) {
    try {
        $placeholders = implode(',', array_fill(0, count($referencedIds), '?'));
        $cardStmt = $pdo->prepare(
            "SELECT
                p.id, p.name, p.logo_url, p.official_url, p.short_description,
                (SELECT GROUP_CONCAT(c.name ORDER BY c.id SEPARATOR ', ')
                   FROM product_categories pc JOIN categories c ON c.id = pc.category_id
                  WHERE pc.product_id = p.id) AS categories_list
             FROM products p
             WHERE p.id IN ($placeholders)"
        );
        $cardStmt->execute($referencedIds);
        $cardRows = [];
        foreach ($cardStmt->fetchAll() as $row) {
            $cardRows[(int) $row['id']] = $row;
        }
    } catch (Throwable $ex) {
        eli_fail('db error (cards): ' . $ex->getMessage());
    }

    foreach ($referencedIds as $sid) {
        $p = $cardRows[$sid] ?? null;
        if ($p === null) {
            continue;
        }
        $cards[] = [
            'id' => $sid,
            'name' => (string) $p['name'],
            'logo_url' => (string) ($p['logo_url'] ?? ''),
            'official_url' => (string) ($p['official_url'] ?? ''),
            'short_description' => (string) ($p['short_description'] ?? ''),
            'categories' => (string) ($p['categories_list'] ?? ''),
            'href' => 'product.php?id=' . $sid,
        ];
    }
}

echo json_encode([
    'ok' => true,
    'reply_text' => $replyText,
    'steps' => $steps,
    'products' => $cards,
], JSON_UNESCAPED_UNICODE);
