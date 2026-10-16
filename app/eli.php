<?php

declare(strict_types=1);

/**
 * AI LAB HUB — логіка AI-асистентки Елі (public/api-eli-chat.php).
 *
 * Шлях запиту: eli.php (фронтенд) → api-eli-chat.php → eli_answer() нижче:
 *   1. ліміт частоти на сеанс (eli_rate_limited);
 *   2. кеш відповідей eli_cache (ключ — sha256 нормалізованого запиту, мови,
 *      версії промпта й моделі; сам текст запиту не зберігається);
 *   3. попередній відбір кандидатів (eli_candidates): у промпт ідуть лише
 *      max_candidates релевантних продуктів, а не весь каталог;
 *   4. виклик провайдера з тайм-аутом, повторами й запасною моделлю
 *      (eli_call_llm); не-JSON / порожня відповідь / блокування — одна повторна
 *      спроба з простішою інструкцією;
 *   5. якщо AI так і не відповів — запасний режим без AI (eli_db_fallback):
 *      добірка з бази за ключовими словами або посилання на підкатегорії.
 *   Фраза про «технічні труднощі» — лише коли недоступна сама база даних.
 *
 * Кожен запит пише один рядок у eli_api_log (лише технічні поля, без тексту
 * запиту й відповіді). Схема — database/migration-2026-10-16-eli-reliability.sql.
 *
 * Налаштування — config/ai-assistant.php; нові ключі необов'язкові, значення
 * за замовчуванням — eli_settings().
 */

require_once __DIR__ . '/translations.php';

/** Змінюється разом із системним промптом — старий кеш тоді не використовується. */
const ELI_PROMPT_VERSION = 'v2-2026-10-16';

/** Файл-кеш індексу продуктів для відбору кандидатів (секунд). */
const ELI_INDEX_TTL = 600;

/** Скільки карток показує запасний режим без AI. */
const ELI_FALLBACK_CARDS = 6;

/** Слова, що нічого не кажуть про задачу (не впливають на відбір). */
const ELI_STOP_WORDS = [
    // uk
    'що', 'як', 'для', 'мені', 'мене', 'мною', 'потрібно', 'потрібен', 'потрібна', 'треба', 'хочу', 'хотів', 'хотіла',
    'можна', 'який', 'яка', 'яке', 'які', 'якийсь', 'щоб', 'але', 'або', 'это', 'цей', 'ця', 'це', 'ці', 'при', 'про',
    'від', 'без', 'під', 'над', 'все', 'усе', 'дуже', 'допоможи', 'допоможіть', 'знайди', 'знайдіть', 'знайти',
    'порадь', 'порадьте', 'підібрати', 'підбери', 'підберіть', 'інструмент', 'інструменти', 'інструмента',
    'сервіс', 'сервіси', 'програма', 'програму', 'штучний', 'штучного', 'інтелект', 'інтелекту', 'нейромережа',
    'нейромережу', 'нейромережі', 'будь', 'ласка', 'мій', 'моя', 'моє', 'мої', 'свій', 'свою', 'своє', 'свої',
    'має', 'мати', 'було', 'буде', 'тому', 'також', 'теж', 'так', 'ось', 'там', 'тут', 'його', 'її', 'їх',
    'робити', 'зробити', 'допомогти', 'допомогою', 'хороший', 'кращий', 'найкращий', 'найкращі', 'безкоштовно',
    'есть', 'нужно', 'мне', 'для',
    // en
    'the', 'and', 'for', 'with', 'need', 'want', 'help', 'find', 'tool', 'tools', 'app', 'apps', 'that', 'this',
    'what', 'which', 'can', 'how', 'you', 'your', 'please', 'some', 'best', 'service', 'software', 'using', 'use',
    'into', 'from', 'about', 'have', 'like', 'would', 'could', 'should', 'recommend', 'looking', 'any', 'are',
    'there', 'something', 'good', 'make', 'get', 'one', 'who', 'will', 'just', 'also', 'our', 'out',
];

/**
 * Налаштування з config/ai-assistant.php разом зі значеннями за замовчуванням
 * для нових ключів (щоб старий файл на хостингу без них працював).
 *
 * @param array<string,mixed> $ai
 * @return array<string,mixed>
 */
function eli_settings(array $ai): array
{
    $provider = strtolower(trim((string) ($ai['provider'] ?? 'gemini'))) ?: 'gemini';
    if ($provider === 'gemini') {
        $key = trim((string) ($ai['gemini_api_key'] ?? ''));
        $model = trim((string) ($ai['gemini_model'] ?? '')) ?: 'gemini-3.5-flash-lite';
        // Без ключа в конфігу: до важкої моделі запасна — легка (окремий пул квоти й швидша), до легкої — gemini-3.5-flash.
        $fallback = trim((string) ($ai['gemini_fallback_model'] ?? $ai['fallback_model']
            ?? (str_contains($model, 'lite') ? 'gemini-3.5-flash' : 'gemini-3.5-flash-lite')));
        $keyOk = $key !== '' && stripos($key, 'YOUR_') === false;
    } else {
        $provider = 'claude';
        $key = trim((string) ($ai['api_key'] ?? ''));
        $model = trim((string) ($ai['model'] ?? '')) ?: 'claude-sonnet-4-6';
        $fallback = trim((string) ($ai['claude_fallback_model'] ?? 'claude-haiku-4-5'));
        $keyOk = str_starts_with($key, 'sk-ant-') && stripos($key, 'REPLACE') === false && stripos($key, 'YOUR_') === false;
    }

    return [
        'provider' => $provider,
        'api_key' => $keyOk ? $key : '',
        'workspace_id' => trim((string) ($ai['workspace_id'] ?? '')),
        'model' => $model,
        'fallback_model' => $fallback !== $model ? $fallback : '',
        'max_tokens' => min(4096, max(256, (int) ($ai['max_tokens'] ?? 1200))),
        'request_timeout_sec' => min(55, max(8, (int) ($ai['request_timeout_sec'] ?? 25))),
        'max_retries' => min(3, max(0, (int) ($ai['max_retries'] ?? 2))),
        'max_candidates' => min(200, max(10, (int) ($ai['max_candidates'] ?? 50))),
        'rate_limit_per_minute' => max(1, (int) ($ai['rate_limit_per_minute'] ?? 10)),
        'cache_ttl_hours' => max(0, (int) ($ai['cache_ttl_hours'] ?? 24)),
    ];
}

// ---------------------------------------------------------------------------
// Текст запиту: нормалізація, особисті дані, ключові слова
// ---------------------------------------------------------------------------

function eli_normalize(string $text): string
{
    $t = mb_strtolower(trim($text));
    $t = (string) preg_replace('/[\s\x{00A0}]+/u', ' ', $t);

    return (string) preg_replace('/^[\s\p{P}\p{S}]+|[\s\p{P}\p{S}]+$/u', '', $t);
}

/** Явні особисті дані (e-mail, номер телефону) — такі запити не кешуються. */
function eli_has_personal_data(string $text): bool
{
    return preg_match('/[^\s@]+@[^\s@]+\.[a-z]{2,}/iu', $text) === 1
        || preg_match('/\+?\d[\d\s\-().]{8,}\d/u', $text) === 1;
}

/** Груба основа слова: укр. закінчення відкидаються префіксом, англ. — суфіксом. */
function eli_stem(string $w): string
{
    if (preg_match('/^[a-z0-9]+$/', $w)) {
        foreach (['ing', 'ers', 'ed', 'es', 'er', 's'] as $suf) {
            if (strlen($w) > strlen($suf) + 3 && str_ends_with($w, $suf)) {
                return substr($w, 0, -strlen($suf));
            }
        }

        return $w;
    }
    $l = mb_strlen($w);
    if ($l <= 4) {
        return $w;
    }
    if ($l <= 6) {
        return mb_substr($w, 0, $l - 1);
    }

    return mb_substr($w, 0, max(5, $l - 3));
}

/** @return list<string> основи значущих слів запиту (без повторів) */
function eli_keywords(string $text): array
{
    $words = preg_split('/[^\p{L}\p{N}]+/u', mb_strtolower($text), -1, PREG_SPLIT_NO_EMPTY) ?: [];
    $stop = array_flip(ELI_STOP_WORDS);
    $out = [];
    foreach ($words as $w) {
        if (mb_strlen($w) < 3 || isset($stop[$w])) {
            continue;
        }
        $out[eli_stem($w)] = true;
        if (count($out) >= 12) {
            break;
        }
    }

    return array_keys($out);
}

// ---------------------------------------------------------------------------
// Індекс продуктів (кешується у storage/cache на ELI_INDEX_TTL)
// ---------------------------------------------------------------------------

/**
 * Компактний індекс опублікованих продуктів для відбору кандидатів.
 *
 * @return array{products: array<int,array<string,mixed>>, subcats: array<int,array<string,mixed>>}
 */
function eli_index(PDO $pdo, bool $refresh = false): array
{
    static $mem = null;
    if ($mem !== null && !$refresh) {
        return $mem;
    }
    $file = __DIR__ . '/../storage/cache/eli-index.json';
    if (!$refresh && is_file($file) && (time() - (int) @filemtime($file)) < ELI_INDEX_TTL) {
        $data = json_decode((string) @file_get_contents($file), true);
        if (is_array($data) && ($data['v'] ?? 0) === 2 && isset($data['products'], $data['subcats'])) {
            return $mem = $data;
        }
    }

    $subcats = [];
    $rows = $pdo->query(
        "SELECT s.id, s.name, s.name_en, s.category_id, c.name AS cat_name, c.name_en AS cat_name_en,
                (SELECT COUNT(*) FROM product_subcategories ps JOIN products p ON p.id = ps.product_id
                  WHERE ps.subcategory_id = s.id AND p.status = 'published') AS cnt
           FROM subcategories s JOIN categories c ON c.id = s.category_id"
    )->fetchAll();
    foreach ($rows as $r) {
        $subcats[(int) $r['id']] = [
            'name' => (string) $r['name'], 'name_en' => (string) ($r['name_en'] ?? ''),
            'cat' => (int) $r['category_id'], 'cnt' => (int) $r['cnt'],
            'k' => eli_haystack($r['name'] . ' ' . ($r['name_en'] ?? '') . ' ' . $r['cat_name'] . ' ' . ($r['cat_name_en'] ?? '')),
        ];
    }

    $enDesc = [];
    try {
        $st = $pdo->query("SELECT product_id, translated_text FROM product_translations WHERE lang = 'en' AND field_name = 'short_description'");
        foreach ($st->fetchAll(PDO::FETCH_NUM) as [$pid, $txt]) {
            $enDesc[(int) $pid] = (string) $txt;
        }
    } catch (Throwable $e) {
        // таблиці перекладів може не бути — шукаємо лише українською
    }

    $pop = [];
    try {
        $st = $pdo->query(
            "SELECT page_id, COUNT(*) FROM page_views
              WHERE page_type = 'product' AND viewed_at >= NOW() - INTERVAL 90 DAY AND page_id IS NOT NULL
              GROUP BY page_id"
        );
        foreach ($st->fetchAll(PDO::FETCH_NUM) as [$pid, $n]) {
            $pop[(int) $pid] = (int) $n;
        }
        $st = $pdo->query('SELECT product_id, COUNT(*) FROM link_clicks WHERE clicked_at >= NOW() - INTERVAL 90 DAY GROUP BY product_id');
        foreach ($st->fetchAll(PDO::FETCH_NUM) as [$pid, $n]) {
            $pop[(int) $pid] = ($pop[(int) $pid] ?? 0) + 5 * (int) $n; // перехід на сайт важить більше за перегляд
        }
    } catch (Throwable $e) {
        // аналітики може не бути — популярність 0
    }

    $money = [];
    foreach ($pdo->query(
        'SELECT product_id,
                SUM(CASE WHEN price IS NULL OR price = 0 THEN 1 ELSE 0 END) AS free_cnt,
                SUM(CASE WHEN price > 0 THEN 1 ELSE 0 END) AS paid_cnt,
                MIN(CASE WHEN price > 0 THEN price END) AS min_p,
                MAX(CASE WHEN price > 0 THEN price END) AS max_p
           FROM pricing_plans GROUP BY product_id'
    )->fetchAll() as $r) {
        $free = (int) $r['free_cnt'] > 0;
        $paid = (int) $r['paid_cnt'] > 0;
        $range = '';
        if ($paid) {
            $fmt = static fn($v): string => '$' . rtrim(rtrim(number_format((float) $v, 2, '.', ''), '0'), '.');
            $range = $r['min_p'] === $r['max_p'] ? $fmt($r['min_p']) : $fmt($r['min_p']) . '–' . $fmt($r['max_p']);
        }
        $money[(int) $r['product_id']] = [($free && $paid) ? 'freemium' : ($free ? 'free' : 'paid'), $range];
    }

    $products = [];
    $rows = $pdo->query(
        "SELECT p.id, p.name, p.short_description, p.short_description_en,
                (SELECT GROUP_CONCAT(ps.subcategory_id) FROM product_subcategories ps WHERE ps.product_id = p.id) AS subs,
                (SELECT GROUP_CONCAT(pc.category_id) FROM product_categories pc WHERE pc.product_id = p.id) AS cats
           FROM products p WHERE p.status = 'published'"
    )->fetchAll();
    foreach ($rows as $r) {
        $pid = (int) $r['id'];
        $subs = array_values(array_filter(array_map('intval', explode(',', (string) $r['subs']))));
        $cats = array_values(array_filter(array_map('intval', explode(',', (string) $r['cats']))));
        $desc = eli_first_sentence((string) ($r['short_description'] ?? ''));
        $descEn = eli_first_sentence((string) ($enDesc[$pid] ?? $r['short_description_en'] ?? ''));
        $products[$pid] = [
            'n' => (string) $r['name'],
            'd' => $desc,
            'de' => $descEn,
            's' => $subs,
            'c' => $cats,
            'm' => $money[$pid][0] ?? '',
            'pr' => $money[$pid][1] ?? '',
            'p' => $pop[$pid] ?? 0,
            'kn' => eli_haystack((string) $r['name']),
            'kd' => eli_haystack($desc . ' ' . $descEn),
        ];
    }

    $mem = ['v' => 2, 'products' => $products, 'subcats' => $subcats];
    $dir = dirname($file);
    if (is_dir($dir) || @mkdir($dir, 0775, true)) {
        @file_put_contents($file . '.tmp', json_encode($mem, JSON_UNESCAPED_UNICODE), LOCK_EX);
        @rename($file . '.tmp', $file);
    }

    return $mem;
}

/** Текст для пошуку за початком слова: нижній регістр, слова через пробіл, пробіл попереду. */
function eli_haystack(string $text): string
{
    return ' ' . trim((string) preg_replace('/[^\p{L}\p{N}]+/u', ' ', mb_strtolower($text))) . ' ';
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

/**
 * Попередній відбір: продукти, у назві / описі (uk і en) / категорії /
 * підкатегорії яких є слова запиту. Якщо збігів менше за $limit — доповнення
 * популярними продуктами тих самих підкатегорій, далі — найпопулярнішими загалом.
 *
 * @return array{ids: list<int>, matched: list<int>, subcats: list<int>}
 *   ids — кандидати для промпта (за релевантністю), matched — лише ті, що мають
 *   збіг зі словами запиту (для запасного режиму), subcats — релевантні підкатегорії.
 */
function eli_candidates(array $index, string $message, int $limit): array
{
    $kw = eli_keywords($message);
    $products = $index['products'];

    $subScore = [];
    foreach ($index['subcats'] as $sid => $s) {
        foreach ($kw as $k) {
            if (str_contains($s['k'], ' ' . $k)) {
                $subScore[$sid] = ($subScore[$sid] ?? 0) + 1;
            }
        }
    }

    $hits = [];
    $df = array_fill_keys($kw, 0);
    if ($kw !== []) {
        foreach ($products as $pid => $p) {
            foreach ($kw as $k) {
                $w = 0;
                if (str_contains($p['kn'], ' ' . $k)) {
                    $w = 6;
                } else {
                    foreach ($p['s'] as $sid) {
                        if (isset($subScore[$sid]) && str_contains($index['subcats'][$sid]['k'], ' ' . $k)) {
                            $w = 4;
                            break;
                        }
                    }
                    if ($w === 0 && str_contains($p['kd'], ' ' . $k)) {
                        $w = 2;
                    }
                }
                if ($w > 0) {
                    $hits[$pid][$k] = $w;
                    $df[$k]++;
                }
            }
        }
    }
    // Рідкісне слово запиту важить більше за загальне (IDF), популярність лише розводить рівні бали.
    $total = max(1, count($products));
    $scores = [];
    foreach ($hits as $pid => $byKw) {
        $score = 0.0;
        foreach ($byKw as $k => $w) {
            $score += $w * log(1 + $total / (1 + $df[$k]));
        }
        $scores[$pid] = $score + min(1.0, log(1 + $products[$pid]['p']) / 10);
    }
    arsort($scores);
    $matched = array_map('intval', array_keys($scores));

    // Найрелевантніші підкатегорії: прямий збіг назви або підкатегорії топ-продуктів.
    $relSubs = $subScore;
    foreach (array_slice($matched, 0, 15) as $pid) {
        foreach ($products[$pid]['s'] as $sid) {
            $relSubs[$sid] = ($relSubs[$sid] ?? 0) + 0.2;
        }
    }
    arsort($relSubs);
    $relSubs = array_slice(array_map('intval', array_keys($relSubs)), 0, 6);

    $ids = array_slice($matched, 0, $limit);
    if (count($ids) < $limit) {
        $have = array_flip($ids);
        $pad = [];
        $relSet = array_flip($relSubs);
        foreach ($products as $pid => $p) {
            if (isset($have[$pid])) {
                continue;
            }
            $inRel = array_intersect_key(array_flip($p['s']), $relSet) !== [];
            $pad[$pid] = ($inRel ? 1_000_000 : 0) + $p['p'];
        }
        arsort($pad);
        foreach (array_keys($pad) as $pid) {
            if (count($ids) >= $limit) {
                break;
            }
            $ids[] = (int) $pid;
        }
    }

    return ['ids' => $ids, 'matched' => $matched, 'subcats' => $relSubs];
}

// ---------------------------------------------------------------------------
// Промпт
// ---------------------------------------------------------------------------

/** @param list<int> $ids */
function eli_product_context(array $index, array $ids, string $lang): string
{
    $lines = [];
    foreach ($ids as $pid) {
        $p = $index['products'][$pid] ?? null;
        if ($p === null) {
            continue;
        }
        $sub = $p['s'] !== [] ? ($index['subcats'][$p['s'][0]] ?? null) : null;
        $tax = $sub ? (($lang === 'en' && $sub['name_en'] !== '') ? $sub['name_en'] : $sub['name']) : '—';
        $desc = ($lang === 'en' && $p['de'] !== '') ? $p['de'] : $p['d'];
        $money = ($p['m'] !== '' ? $p['m'] : 'n/a') . ($p['pr'] !== '' ? ' ' . $p['pr'] : '');
        $lines[] = "[{$pid}] {$p['n']} | {$tax} | {$money} | {$desc}";
    }

    return implode("\n", $lines);
}

function eli_system_prompt(string $productContext, string $lang, bool $simple = false): string
{
    $format = '{"reply_text": "<text>", "steps": [{"step_title": "<short title>", "product_ids": [<ids>]}]}';
    if ($simple) {
        return "You recommend AI tools from the list below. Reply language: {$lang}. "
            . "Return ONLY a JSON object exactly like {$format}. Use 1-3 steps, 1-5 integer ids from the list per step. "
            . "reply_text: one or two polite sentences in {$lang}. No markdown.\n\nPRODUCTS ([id] name | subcategory | pricing | description):\n{$productContext}";
    }

    return <<<PROMPT
Ти — Елеонора (Еля), AI-асистентка каталогу AI LAB HUB.
Характер: формальна, гідна, доброзичлива, без панібратства й пихатості.

ОСОБИСТІ ПИТАННЯ (коротко, лише якщо запитають напряму, і одразу повертайся до основної теми): повне ім'я — Елеонора (можна звертатись просто Еля); порода — білий бархатний ельф; країна — Україна; місто — Львів. На будь-які ІНШІ особисті питання ввічливо відмовляйся й переводь розмову на пошук AI-інструментів.

ГОЛОВНА ЗАДАЧА: підібрати з наведеного списку продуктів ті, що підходять під задачу користувача, враховуючи вартість (разові дешеві задачі vs регулярне професійне використання). Якщо задача потребує кількох інструментів послідовно — кілька кроків. Список — це попередньо відібрані кандидати з каталогу; відповідай лише продуктами з нього, нічого не вигадуй.

МОВА ВІДПОВІДІ: "{$lang}" (мова інтерфейсу сайту) — для reply_text і step_title. Назви продуктів не перекладай.

ФОРМАТ. Поверни ВИКЛЮЧНО валідний JSON-об'єкт без markdown:
{$format}
- Один набір інструментів — один крок із коротким step_title (напр. "Рекомендую" / "Recommended").
- Багатоетапна задача — кілька кроків ("Крок 1: …" / "Step 1: …").
- Нічого не підходить або питання не про інструменти — steps: [] і ввічливе пояснення в reply_text.
- У product_ids лише цілі id зі списку, до 6 на крок.

СПИСОК ПРОДУКТІВ. Формат: [id] Назва | Підкатегорія | монетизація (free / freemium / paid / n/a) і ціна платних тарифів | короткий опис:
{$productContext}
PROMPT;
}

// ---------------------------------------------------------------------------
// HTTP і провайдери
// ---------------------------------------------------------------------------

/**
 * Реальний HTTP POST (cURL). Тести підставляють власний транспорт тієї ж форми.
 *
 * @return array{status:int, body:string, errno:int, error:string, retry_after:?int}
 */
function eli_http_post(string $url, array $headers, string $payload, int $timeout): array
{
    $retryAfter = null;
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $payload,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_CONNECTTIMEOUT => min(5, $timeout),
        CURLOPT_TIMEOUT => $timeout,
        CURLOPT_SSL_VERIFYPEER => true,
        CURLOPT_SSL_VERIFYHOST => 2,
        CURLOPT_HTTPHEADER => $headers,
        CURLOPT_HEADERFUNCTION => static function ($ch, string $line) use (&$retryAfter): int {
            if (stripos($line, 'retry-after:') === 0) {
                $v = trim(substr($line, 12));
                $retryAfter = ctype_digit($v) ? (int) $v : max(0, (int) (strtotime($v) - time()));
            }

            return strlen($line);
        },
    ]);
    $raw = curl_exec($ch);
    $out = [
        'status' => (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE),
        'body' => is_string($raw) ? $raw : '',
        'errno' => curl_errno($ch),
        'error' => curl_error($ch),
        'retry_after' => $retryAfter,
    ];
    curl_close($ch);

    return $out;
}

/**
 * Один виклик моделі. error_type: none | timeout | rate_limit | server_error |
 * invalid_json | empty_response | safety_block | network | auth | bad_request | not_found | other.
 *
 * @return array{ok:bool, text:string, status:?int, error_type:string, detail:string, retry_after:?int}
 */
function eli_provider_call(array $cfg, string $model, string $system, string $message, int $timeout, callable $transport, ?bool $thinkingMin = null): array
{
    // «Важкі» моделі Gemini 3.x за замовчуванням міркують (thinking) — для підбору зі списку це лише
    // затримка. Просимо мінімальне міркування; якщо модель відхилить параметр (400) — повтор без нього.
    $thinkingMin ??= $cfg['provider'] === 'gemini' && !str_contains($model, 'lite');
    if ($cfg['provider'] === 'gemini') {
        $url = 'https://generativelanguage.googleapis.com/v1beta/models/' . rawurlencode($model)
            . ':generateContent?key=' . urlencode($cfg['api_key']);
        $headers = ['Content-Type: application/json'];
        $gen = [
            'maxOutputTokens' => $cfg['max_tokens'],
            'temperature' => 0.4,
            'responseMimeType' => 'application/json',
        ];
        if ($thinkingMin) {
            $gen['thinkingConfig'] = ['thinkingLevel' => 'minimal'];
        }
        $payload = json_encode([
            'system_instruction' => ['parts' => [['text' => $system]]],
            'contents' => [['role' => 'user', 'parts' => [['text' => $message]]]],
            'generationConfig' => $gen,
        ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    } else {
        $url = 'https://api.anthropic.com/v1/messages';
        $headers = ['Content-Type: application/json', 'x-api-key: ' . $cfg['api_key'], 'anthropic-version: 2023-06-01'];
        if ($cfg['workspace_id'] !== '') {
            $headers[] = 'anthropic-workspace-id: ' . $cfg['workspace_id'];
        }
        $payload = json_encode([
            'model' => $model,
            'max_tokens' => $cfg['max_tokens'],
            'system' => $system,
            'messages' => [['role' => 'user', 'content' => $message]],
        ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    }
    $res = ['ok' => false, 'text' => '', 'status' => null, 'error_type' => 'other', 'detail' => '', 'retry_after' => null];
    if ($payload === false) {
        $res['detail'] = 'payload encode: ' . json_last_error_msg();

        return $res;
    }

    $r = $transport($url, $headers, $payload, $timeout);
    if ($r['errno'] !== 0 || ($r['status'] === 0 && $r['body'] === '')) {
        $res['error_type'] = $r['errno'] === 28 ? 'timeout' : 'network';
        $res['detail'] = 'curl ' . $r['errno'] . ': ' . $r['error'];

        return $res;
    }
    $status = (int) $r['status'];
    $res['status'] = $status;
    $data = json_decode($r['body'], true);

    if ($status < 200 || $status >= 300) {
        $msg = is_array($data) ? (string) ($data['error']['message'] ?? '') : '';
        $res['detail'] = 'http ' . $status . ': ' . mb_substr($msg !== '' ? $msg : $r['body'], 0, 300);
        $res['error_type'] = match (true) {
            $status === 429 => 'rate_limit',
            $status >= 500 => 'server_error',
            $status === 401, $status === 403 => 'auth',
            $status === 404 => 'not_found',
            $status === 400 && stripos($msg, 'api key') !== false => 'auth',
            $status === 400 => 'bad_request',
            default => 'other',
        };
        if ($res['error_type'] === 'bad_request' && $thinkingMin) {
            return eli_provider_call($cfg, $model, $system, $message, $timeout, $transport, false);
        }
        $retry = $r['retry_after'];
        // Gemini кладе паузу в тіло: error.details[].retryDelay = "37s"
        if ($retry === null && is_array($data)) {
            foreach ((array) ($data['error']['details'] ?? []) as $d) {
                if (is_array($d) && isset($d['retryDelay']) && preg_match('/^(\d+(?:\.\d+)?)s$/', (string) $d['retryDelay'], $m)) {
                    $retry = (int) ceil((float) $m[1]);
                }
            }
        }
        $res['retry_after'] = $retry;

        return $res;
    }
    if (!is_array($data)) {
        $res['error_type'] = 'invalid_json';
        $res['detail'] = 'provider body not json';

        return $res;
    }

    $text = '';
    if ($cfg['provider'] === 'gemini') {
        $cand = $data['candidates'][0] ?? null;
        if (!is_array($cand)) {
            $block = (string) ($data['promptFeedback']['blockReason'] ?? '');
            $res['error_type'] = $block !== '' ? 'safety_block' : 'empty_response';
            $res['detail'] = 'no candidates' . ($block !== '' ? ' block=' . $block : '');

            return $res;
        }
        $finish = (string) ($cand['finishReason'] ?? '');
        if (in_array($finish, ['SAFETY', 'PROHIBITED_CONTENT', 'BLOCKLIST', 'SPII', 'RECITATION'], true)) {
            $res['error_type'] = 'safety_block';
            $res['detail'] = 'finishReason=' . $finish;

            return $res;
        }
        foreach ((array) ($cand['content']['parts'] ?? []) as $part) {
            if (is_array($part) && isset($part['text']) && empty($part['thought'])) {
                $text .= (string) $part['text'];
            }
        }
    } else {
        if (($data['stop_reason'] ?? null) === 'refusal') {
            $res['error_type'] = 'safety_block';
            $res['detail'] = 'stop_reason=refusal';

            return $res;
        }
        foreach ((array) ($data['content'] ?? []) as $block) {
            if (is_array($block) && ($block['type'] ?? '') === 'text') {
                $text .= (string) ($block['text'] ?? '');
            }
        }
    }
    $text = trim($text);
    if ($text === '') {
        $res['error_type'] = 'empty_response';
        $res['detail'] = 'empty text';

        return $res;
    }

    return ['ok' => true, 'text' => $text, 'status' => $status, 'error_type' => 'none', 'detail' => '', 'retry_after' => null];
}

/** @return array<string,mixed>|null */
function eli_extract_json(string $text): ?array
{
    $t = trim($text);
    if (str_starts_with($t, '```')) {
        $t = trim((string) preg_replace(['/^```[a-zA-Z]*\s*/', '/\s*```\s*$/'], '', $t));
    }
    $decoded = json_decode($t, true);
    if (is_array($decoded)) {
        return $decoded;
    }
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

/**
 * Розібрати відповідь моделі: reply_text + кроки лише з дозволеними id.
 *
 * @param array<int,true> $valid
 * @return array{reply_text:string, steps:list<array{step_title:string, product_ids:list<int>}>}|null
 */
function eli_parse_answer(string $text, array $valid): ?array
{
    $parsed = eli_extract_json($text);
    if ($parsed === null || !isset($parsed['reply_text']) && !isset($parsed['steps'])) {
        return null;
    }
    $steps = [];
    foreach ((array) ($parsed['steps'] ?? []) as $rawStep) {
        if (!is_array($rawStep)) {
            continue;
        }
        $ids = [];
        foreach ((array) ($rawStep['product_ids'] ?? []) as $rawId) {
            $sid = (int) $rawId;
            if ($sid > 0 && isset($valid[$sid]) && !in_array($sid, $ids, true)) {
                $ids[] = $sid;
            }
        }
        $title = trim((string) ($rawStep['step_title'] ?? ''));
        if ($ids === []) {
            continue;
        }
        $steps[] = ['step_title' => $title !== '' ? $title : t('eli_recommend'), 'product_ids' => array_slice($ids, 0, 8)];
    }

    return ['reply_text' => trim((string) ($parsed['reply_text'] ?? '')), 'steps' => $steps];
}

/**
 * Виклик AI з тайм-аутом на весь запит, повторами для тимчасових помилок,
 * запасною моделлю і однією спробою з простішою інструкцією, якщо відповідь
 * не вдалося розібрати.
 *
 * @param array<int,true> $valid
 * @return array{answer:?array, model:string, status:?int, error_type:string, attempts:int, used_fallback:bool, detail:string}
 */
function eli_call_llm(array $cfg, string $system, string $simpleSystem, string $message, array $valid, callable $transport, ?callable $sleep = null): array
{
    $sleep ??= static fn(float $s) => usleep((int) ($s * 1_000_000));
    $deadline = microtime(true) + $cfg['request_timeout_sec'];
    $perCall = max(6, (int) floor($cfg['request_timeout_sec'] * 0.6));
    $transient = ['timeout', 'rate_limit', 'server_error', 'network'];
    $out = ['answer' => null, 'model' => $cfg['model'], 'status' => null, 'error_type' => 'none', 'attempts' => 0, 'used_fallback' => false, 'detail' => ''];
    $firstError = null;
    $simplified = false;

    $models = [$cfg['model']];
    if ($cfg['fallback_model'] !== '') {
        $models[] = $cfg['fallback_model'];
    }

    foreach ($models as $mi => $model) {
        $retries = $mi === 0 ? $cfg['max_retries'] : 1;
        for ($try = 0; $try <= $retries; $try++) {
            $left = $deadline - microtime(true);
            if ($left < 3) {
                break 2;
            }
            $out['attempts']++;
            $out['model'] = $model;
            $out['used_fallback'] = $mi > 0;
            $r = eli_provider_call($cfg, $model, $simplified ? $simpleSystem : $system, $message, (int) min($perCall, floor($left - 1)), $transport);
            $out['status'] = $r['status'];

            if ($r['ok']) {
                $answer = eli_parse_answer($r['text'], $valid);
                if ($answer !== null) {
                    $out['answer'] = $answer;
                    $out['error_type'] = $firstError ?? 'none';

                    return $out;
                }
                $r['error_type'] = 'invalid_json';
                $r['detail'] = 'unparseable answer (' . mb_strlen($r['text']) . ' chars)';
            }
            $firstError ??= $r['error_type'];
            $out['error_type'] = $firstError;
            $out['detail'] = $r['detail'];

            // Не-JSON / порожньо / блокування — одна спроба з простішою інструкцією, далі запасний режим.
            if (in_array($r['error_type'], ['invalid_json', 'empty_response', 'safety_block'], true)) {
                if ($simplified) {
                    break 2;
                }
                $simplified = true;
                continue;
            }
            if (in_array($r['error_type'], ['auth', 'bad_request'], true)) {
                break 2; // постійна помилка (ключ / запит) — повтори не допоможуть
            }
            if (!in_array($r['error_type'], $transient, true) || $r['error_type'] === 'timeout') {
                continue 2; // not_found / other / тайм-аут (з'їв час) — одразу запасна модель
            }
            if ($try < $retries) {
                $pause = 0.5 * (2 ** $try);
                if ($r['retry_after'] !== null) {
                    if ($r['retry_after'] > ($deadline - microtime(true)) - 4) {
                        continue 2; // провайдер просить чекати довше, ніж є часу — пробуємо запасну модель
                    }
                    $pause = max($pause, (float) $r['retry_after']);
                }
                $sleep($pause);
            }
        }
    }

    return $out;
}

// ---------------------------------------------------------------------------
// Кеш, ліміт частоти, журнал
// ---------------------------------------------------------------------------

function eli_cache_key(string $message, string $lang, array $cfg): string
{
    return hash('sha256', eli_normalize($message) . '|' . $lang . '|' . ELI_PROMPT_VERSION . '|' . $cfg['provider'] . ':' . $cfg['model']);
}

/** @return array{reply_text:string, steps:array}|null */
function eli_cache_get(PDO $pdo, string $key, int $ttlHours): ?array
{
    if ($ttlHours <= 0) {
        return null;
    }
    try {
        $st = $pdo->prepare('SELECT response_json FROM eli_cache WHERE key_hash = :k AND created_at >= NOW() - INTERVAL :h HOUR');
        $st->bindValue(':k', $key);
        $st->bindValue(':h', $ttlHours, PDO::PARAM_INT);
        $st->execute();
        $json = $st->fetchColumn();
        if ($json === false) {
            return null;
        }
        $data = json_decode((string) $json, true);
        if (!is_array($data) || !isset($data['steps'])) {
            return null;
        }
        $pdo->prepare('UPDATE eli_cache SET hits = hits + 1 WHERE key_hash = :k')->execute([':k' => $key]);

        return $data;
    } catch (Throwable $e) {
        return null;
    }
}

function eli_cache_put(PDO $pdo, string $key, array $answer): void
{
    try {
        $pdo->prepare(
            'INSERT INTO eli_cache (key_hash, response_json, created_at, hits) VALUES (:k, :j, NOW(), 0)
             ON DUPLICATE KEY UPDATE response_json = VALUES(response_json), created_at = NOW(), hits = 0'
        )->execute([':k' => $key, ':j' => json_encode($answer, JSON_UNESCAPED_UNICODE)]);
    } catch (Throwable $e) {
        error_log('[eli] cache put: ' . $e->getMessage());
    }
}

/** Ліміт запитів на сеанс за хвилину (лічильник у $_SESSION). */
function eli_rate_limited(array &$session, int $perMinute, ?int $now = null): bool
{
    $now ??= time();
    $hits = array_values(array_filter((array) ($session['eli_hits'] ?? []), static fn($t): bool => is_int($t) && $t > $now - 60));
    if (count($hits) >= $perMinute) {
        $session['eli_hits'] = $hits;

        return true;
    }
    $hits[] = $now;
    $session['eli_hits'] = $hits;

    return false;
}

/** Рядок журналу: лише технічні поля, без тексту запиту й відповіді. */
function eli_log(PDO $pdo, array $row): void
{
    // used_fallback — відповідь запасним режимом без AI; used_fallback_model — відповіла запасна модель;
    // fallback_empty — запасна добірка не знайшла нічого впевненого (міграція 2026-10-17).
    try {
        $pdo->prepare(
            'INSERT INTO eli_api_log (created_at, provider, model, http_status, error_type, source, latency_ms, attempts, used_fallback, used_fallback_model, fallback_empty, lang, session_hash)
             VALUES (NOW(), :provider, :model, :status, :err, :source, :lat, :att, :fb, :fbm, :fbe, :lang, :sh)'
        )->execute([
            ':provider' => substr((string) ($row['provider'] ?? ''), 0, 20),
            ':model' => substr((string) ($row['model'] ?? ''), 0, 60),
            ':status' => $row['http_status'] ?? null,
            ':err' => substr((string) ($row['error_type'] ?? 'none'), 0, 20),
            ':source' => (string) ($row['source'] ?? 'ai'),
            ':lat' => (int) ($row['latency_ms'] ?? 0),
            ':att' => (int) ($row['attempts'] ?? 0),
            ':fb' => !empty($row['used_fallback']) ? 1 : 0,
            ':fbm' => !empty($row['used_fallback_model']) ? 1 : 0,
            ':fbe' => !empty($row['fallback_empty']) ? 1 : 0,
            ':lang' => substr((string) ($row['lang'] ?? ''), 0, 5),
            ':sh' => (string) ($row['session_hash'] ?? ''),
        ]);

        return;
    } catch (Throwable $e) {
        // міграцію 2026-10-17 ще не застосовано — попередній формат рядка нижче
    }
    if (($row['source'] ?? '') === 'diag') {
        $row['source'] = 'fail'; // без нового значення ENUM перевірку записати не можна точніше
    }
    try {
        $pdo->prepare(
            'INSERT INTO eli_api_log (created_at, provider, model, http_status, error_type, source, latency_ms, attempts, used_fallback, lang, session_hash)
             VALUES (NOW(), :provider, :model, :status, :err, :source, :lat, :att, :fb, :lang, :sh)'
        )->execute([
            ':provider' => substr((string) ($row['provider'] ?? ''), 0, 20),
            ':model' => substr((string) ($row['model'] ?? ''), 0, 60),
            ':status' => $row['http_status'] ?? null,
            ':err' => substr((string) ($row['error_type'] ?? 'none'), 0, 20),
            ':source' => (string) ($row['source'] ?? 'ai'),
            ':lat' => (int) ($row['latency_ms'] ?? 0),
            ':att' => (int) ($row['attempts'] ?? 0),
            ':fb' => !empty($row['used_fallback']) ? 1 : 0,
            ':lang' => substr((string) ($row['lang'] ?? ''), 0, 5),
            ':sh' => (string) ($row['session_hash'] ?? ''),
        ]);
    } catch (Throwable $e) {
        error_log('[eli] log: ' . $e->getMessage());
    }
}

// ---------------------------------------------------------------------------
// Картки й запасний режим
// ---------------------------------------------------------------------------

/**
 * Повні дані карток для фронтенду (у порядку $ids) + стан «збережено» для користувача.
 *
 * @param list<int> $ids
 */
function eli_cards(PDO $pdo, array $ids, ?int $userId): array
{
    if ($ids === []) {
        return [];
    }
    $ph = implode(',', array_fill(0, count($ids), '?'));
    $st = $pdo->prepare(
        "SELECT p.id, p.name, p.logo_url, p.official_url, p.short_description,
                (SELECT GROUP_CONCAT(c.name ORDER BY c.id SEPARATOR ', ')
                   FROM product_categories pc JOIN categories c ON c.id = pc.category_id
                  WHERE pc.product_id = p.id) AS categories_list
           FROM products p WHERE p.id IN ($ph) AND p.status = 'published'"
    );
    $st->execute($ids);
    $rows = [];
    foreach ($st->fetchAll() as $r) {
        $rows[(int) $r['id']] = $r;
    }
    $saved = [];
    if ($userId !== null) {
        try {
            $s = $pdo->prepare("SELECT product_id FROM saved_products WHERE user_id = ? AND product_id IN ($ph)");
            $s->execute(array_merge([$userId], $ids));
            foreach ($s->fetchAll(PDO::FETCH_COLUMN) as $sp) {
                $saved[(int) $sp] = true;
            }
        } catch (Throwable $e) {
            // добірка не критична для відповіді
        }
    }
    $cards = [];
    foreach ($ids as $id) {
        $p = $rows[$id] ?? null;
        if ($p === null) {
            continue;
        }
        $cards[] = [
            'id' => $id,
            'name' => (string) $p['name'],
            'logo_url' => (string) ($p['logo_url'] ?? ''),
            'official_url' => (string) ($p['official_url'] ?? ''),
            'short_description' => (string) ($p['short_description'] ?? ''),
            'categories' => (string) ($p['categories_list'] ?? ''),
            'href' => 'product.php?id=' . $id,
            'saved' => isset($saved[$id]),
        ];
    }

    return $cards;
}

/**
 * Запасний режим без AI: до ELI_FALLBACK_CARDS продуктів зі збігом слів запиту,
 * а без збігів — посилання на популярні підкатегорії.
 *
 * @return array{reply_text:string, steps:array, links:array}
 */
function eli_db_fallback(array $index, array $cand, string $lang): array
{
    $ids = array_slice($cand['matched'], 0, ELI_FALLBACK_CARDS);
    if ($ids !== []) {
        return [
            'reply_text' => t('eli_fallback_intro'),
            'steps' => [['step_title' => t('eli_fallback_step'), 'product_ids' => $ids]],
            'links' => [],
        ];
    }
    $subs = $index['subcats'];
    uasort($subs, static fn($a, $b) => $b['cnt'] <=> $a['cnt']);
    $links = [];
    foreach (array_slice($subs, 0, 6, true) as $sid => $s) {
        $links[] = [
            'title' => ($lang === 'en' && $s['name_en'] !== '') ? $s['name_en'] : $s['name'],
            'href' => 'catalog.php?subcategory=' . (int) $sid,
        ];
    }

    return ['reply_text' => t('eli_fallback_none'), 'steps' => [], 'links' => $links];
}

// ---------------------------------------------------------------------------
// Головна функція
// ---------------------------------------------------------------------------

/**
 * Відповідь Елі на одне повідомлення. Не кидає винятків, окрім збою БД
 * (тоді викликач показує eli_tech_error).
 *
 * @param array<string,mixed> $session $_SESSION (ліміт частоти)
 * @return array{response: array<string,mixed>, log: array<string,mixed>}
 */
function eli_answer(PDO $pdo, string $message, string $lang, array $cfg, array &$session, string $sessionHash, ?int $userId, callable $transport, ?callable $sleep = null): array
{
    $t0 = microtime(true);
    $log = ['provider' => $cfg['provider'], 'model' => $cfg['model'], 'http_status' => null, 'error_type' => 'none', 'source' => 'ai',
            'attempts' => 0, 'used_fallback' => false, 'used_fallback_model' => false, 'fallback_empty' => false,
            'lang' => $lang, 'session_hash' => $sessionHash];
    $finish = static function (array $resp, array $log) use ($t0): array {
        $log['latency_ms'] = (int) round((microtime(true) - $t0) * 1000);

        return ['response' => $resp, 'log' => $log];
    };

    if (eli_rate_limited($session, $cfg['rate_limit_per_minute'])) {
        $log['source'] = 'limited';

        return $finish(['ok' => true, 'mode' => 'limited', 'reply_text' => t('eli_rate_limited'), 'steps' => [], 'products' => []], $log);
    }

    $index = eli_index($pdo); // збій БД тут — виняток нагору
    if ($index['products'] === []) {
        $log['source'] = 'fallback';
        $log['used_fallback'] = true;
        $log['fallback_empty'] = true;
        $log['error_type'] = 'catalog_empty';

        return $finish(['ok' => true, 'mode' => 'fallback', 'reply_text' => t('eli_catalog_empty'), 'steps' => [], 'products' => []], $log);
    }

    $cacheable = !eli_has_personal_data($message) && mb_strlen(eli_normalize($message)) >= 3;
    $cacheKey = eli_cache_key($message, $lang, $cfg);
    if ($cacheable && ($hit = eli_cache_get($pdo, $cacheKey, $cfg['cache_ttl_hours'])) !== null) {
        $ids = [];
        foreach ($hit['steps'] as $s) {
            foreach ($s['product_ids'] as $pid) {
                $ids[(int) $pid] = true;
            }
        }
        $log['source'] = 'cache';

        return $finish(['ok' => true, 'mode' => 'ai', 'reply_text' => (string) $hit['reply_text'], 'steps' => $hit['steps'],
                        'products' => eli_cards($pdo, array_keys($ids), $userId)], $log);
    }

    $cand = eli_candidates($index, $message, $cfg['max_candidates']);
    $answer = null;
    if ($cfg['api_key'] !== '') {
        $context = eli_product_context($index, $cand['ids'], $lang);
        $res = eli_call_llm($cfg, eli_system_prompt($context, $lang), eli_system_prompt($context, $lang, true), $message,
            array_fill_keys($cand['ids'], true), $transport, $sleep);
        $log = array_merge($log, ['model' => $res['model'], 'http_status' => $res['status'], 'error_type' => $res['error_type'],
                                  'attempts' => $res['attempts'], 'used_fallback_model' => $res['used_fallback']]);
        if ($res['answer'] === null && $res['detail'] !== '') {
            error_log('[eli-chat] ' . $res['error_type'] . ' ' . $res['model'] . ': ' . $res['detail']);
        }
        $answer = $res['answer'];
    } else {
        $log['error_type'] = 'no_key';
        error_log('[eli-chat] api key not configured (' . $cfg['provider'] . ')');
    }

    if ($answer !== null) {
        if ($answer['reply_text'] === '') {
            $answer['reply_text'] = $answer['steps'] !== [] ? t('eli_default_reply') : t('eli_nothing_found');
        }
        if ($cacheable) {
            eli_cache_put($pdo, $cacheKey, $answer);
        }
        $ids = [];
        foreach ($answer['steps'] as $s) {
            foreach ($s['product_ids'] as $pid) {
                $ids[$pid] = true;
            }
        }

        return $finish(['ok' => true, 'mode' => 'ai', 'reply_text' => $answer['reply_text'], 'steps' => $answer['steps'],
                        'products' => eli_cards($pdo, array_keys($ids), $userId)], $log);
    }

    $fb = eli_db_fallback($index, $cand, $lang);
    $log['source'] = 'fallback';
    $log['used_fallback'] = true;
    $ids = $fb['steps'] !== [] ? $fb['steps'][0]['product_ids'] : [];
    $log['fallback_empty'] = $ids === [];
    if ($log['error_type'] === 'none') {
        $log['error_type'] = 'other'; // AI відповів, але відповідь не прийнято — запасний режим без конкретної причини
    }

    return $finish(['ok' => true, 'mode' => 'fallback', 'reply_text' => $fb['reply_text'], 'steps' => $fb['steps'],
                    'products' => eli_cards($pdo, $ids, $userId), 'links' => $fb['links']], $log);
}

// ---------------------------------------------------------------------------
// Показники для адмінки (admin-stats.php і «Реклама: адмін» → «Стан»)
// ---------------------------------------------------------------------------

/** @return array<string,mixed>|null null — таблиці ще немає */
function eli_stats(PDO $pdo): ?array
{
    try {
        $rows = $pdo->query(
            "SELECT source, error_type, latency_ms, created_at >= NOW() - INTERVAL 1 DAY AS d1, created_at >= NOW() - INTERVAL 7 DAY AS d7
               FROM eli_api_log WHERE created_at >= NOW() - INTERVAL 30 DAY"
        )->fetchAll();
    } catch (Throwable $e) {
        return null;
    }
    $out = [];
    foreach (['24h' => 'd1', '7d' => 'd7', '30d' => null] as $label => $flag) {
        $set = array_filter($rows, static fn($r) => $r['source'] !== 'diag' && ($flag === null || (int) $r[$flag] === 1));
        $answered = array_values(array_filter($set, static fn($r) => $r['source'] !== 'limited'));
        $n = count($answered);
        $by = ['ai' => 0, 'cache' => 0, 'fallback' => 0, 'fail' => 0];
        $errors = [];
        $lat = [];
        foreach ($answered as $r) {
            $by[$r['source']] = ($by[$r['source']] ?? 0) + 1;
            if ($r['error_type'] !== 'none') {
                $errors[$r['error_type']] = ($errors[$r['error_type']] ?? 0) + 1;
            }
            if ($r['source'] === 'ai') {
                $lat[] = (int) $r['latency_ms'];
            }
        }
        sort($lat);
        arsort($errors);
        $pct = static fn(int $x) => $n > 0 ? round($x * 100 / $n, 1) : 0.0;
        $q = static fn(float $p) => $lat === [] ? null : $lat[(int) min(count($lat) - 1, floor($p * (count($lat) - 1) + 0.5))];
        $out[$label] = [
            'total' => count($set),
            'answered' => $n,
            'limited' => count($set) - $n,
            'ai_pct' => $pct($by['ai'] + $by['cache']),
            'cache_pct' => $pct($by['cache']),
            'fallback_pct' => $pct($by['fallback']),
            'fail_pct' => $pct($by['fail']),
            'p50' => $q(0.5),
            'p95' => $q(0.95),
            'errors' => array_slice($errors, 0, 5, true),
        ];
    }
    $d = $out['24h'];
    $out['alarm'] = $d['answered'] >= 20 && $d['ai_pct'] < 95;

    return $out;
}

/** HTML-блок «Еля» (адмінка; підписи українською, як решта адмін-інтерфейсу). */
function eli_stats_html(PDO $pdo): string
{
    $s = eli_stats($pdo);
    $h = static fn($v): string => htmlspecialchars((string) $v, ENT_QUOTES);
    if ($s === null) {
        return '<div class="eli-stats"><p>Журнал Елі ще не створено — застосуйте міграцію database/migration-2026-10-16-eli-reliability.sql.</p></div>';
    }
    $errLabels = ['timeout' => 'тайм-аут', 'rate_limit' => 'ліміт провайдера (429)', 'server_error' => 'помилка сервера AI (5xx)',
                  'invalid_json' => 'відповідь не JSON', 'empty_response' => 'порожня відповідь', 'safety_block' => 'блокування безпеки',
                  'network' => 'мережа', 'auth' => 'ключ / доступ', 'bad_request' => 'некоректний запит', 'not_found' => 'модель не знайдена',
                  'no_key' => 'ключ не налаштовано', 'other' => 'інше'];
    $html = '<div class="eli-stats">';
    if ($s['alarm']) {
        $html .= '<p class="eli-stats__alarm">За останні 24 години AI відповів лише на ' . $h($s['24h']['ai_pct'])
            . '% запитів (поріг 95%). Відвідувачі бачать запасну добірку з бази. Перевірте ключ, квоту провайдера й журнал помилок нижче.</p>';
    }
    $html .= '<div class="eli-stats__wrap"><table class="eli-stats__table"><thead><tr><th>Період</th><th>Запитів</th><th>AI</th><th>з них кеш</th><th>Запасний режим</th><th>Збої</th><th>Медіана, с</th><th>95%, с</th><th>Типові помилки</th></tr></thead><tbody>';
    $sec = static fn($ms) => $ms === null ? '—' : number_format($ms / 1000, 1, ',', '');
    foreach (['24h' => '24 години', '7d' => '7 днів', '30d' => '30 днів'] as $k => $label) {
        $r = $s[$k];
        $errs = [];
        foreach ($r['errors'] as $type => $cnt) {
            $errs[] = ($errLabels[$type] ?? $type) . ': ' . $cnt;
        }
        $html .= '<tr><td data-label="Період">' . $label . '</td>'
            . '<td data-label="Запитів">' . $r['answered'] . ($r['limited'] > 0 ? ' <small>(+' . $r['limited'] . ' ліміт)</small>' : '') . '</td>'
            . '<td data-label="AI">' . $h($r['ai_pct']) . '%</td>'
            . '<td data-label="Кеш">' . $h($r['cache_pct']) . '%</td>'
            . '<td data-label="Запасний режим">' . $h($r['fallback_pct']) . '%</td>'
            . '<td data-label="Збої">' . $h($r['fail_pct']) . '%</td>'
            . '<td data-label="Медіана">' . $sec($r['p50']) . '</td>'
            . '<td data-label="95%">' . $sec($r['p95']) . '</td>'
            . '<td data-label="Помилки">' . ($errs !== [] ? $h(implode(', ', $errs)) : '—') . '</td></tr>';
    }
    $html .= '</tbody></table></div><p class="eli-stats__note">AI — відповідь моделі (зокрема з кешу); запасний режим — добірка з бази без AI; збій — недоступна база. Час — лише для відповідей AI. Типові помилки враховують і ті, що вирішилися повтором чи запасною моделлю. Текст запитів не зберігається.</p></div>';

    return $html;
}

/** Спільні стилі блоку (вставляються поряд із ним). */
function eli_stats_css(): string
{
    return '<style>
.eli-stats__alarm{background:rgba(255,196,77,.12);border:1px solid rgba(255,196,77,.55);color:#ffe7b0;border-radius:10px;padding:10px 14px;margin:0 0 12px}
.eli-stats__wrap{overflow-x:auto;max-width:100%}
.eli-stats__table{border-collapse:collapse;width:100%;font-size:14px}
.eli-stats__table th,.eli-stats__table td{border-bottom:1px solid rgba(255,255,255,.14);padding:6px 8px;text-align:left;vertical-align:top}
.eli-stats__note{font-size:13px;opacity:.75;margin:8px 0 0}
.eli-diag{margin-top:18px}.eli-diag__form{display:flex;flex-wrap:wrap;gap:10px;align-items:center;margin:0 0 12px}
.eli-diag__btn{padding:9px 18px;border-radius:999px;border:1px solid rgba(255,255,255,.35);background:transparent;color:#e4ebff;font:inherit;cursor:pointer}
.eli-diag__btn:hover,.eli-diag__btn:focus-visible{background:rgba(255,255,255,.14);color:#fff}
.eli-diag__verdict{border:1px solid rgba(255,255,255,.2);border-radius:10px;padding:10px 14px;margin:0 0 12px;overflow-wrap:anywhere}
.eli-diag__verdict p{margin:0 0 6px}.eli-diag .eli-stats__wrap{margin-bottom:12px}
@media (max-width:640px){.eli-stats__table thead{display:none}.eli-stats__table tr{display:block;border-bottom:1px solid rgba(255,255,255,.2);padding:6px 0}
.eli-stats__table td{display:flex;justify-content:space-between;gap:12px;border:0;padding:3px 4px;overflow-wrap:anywhere}.eli-stats__table td::before{content:attr(data-label);font-weight:600;flex-shrink:0}}
</style>';
}

/** Очищення (cron/promo-daily.php): журнал старший за 90 днів, кеш старший за TTL. */
function eli_maintenance(PDO $pdo): int
{
    $n = 0;
    try {
        $n += (int) $pdo->exec('DELETE FROM eli_api_log WHERE created_at < NOW() - INTERVAL 90 DAY');
        $path = __DIR__ . '/../config/ai-assistant.php';
        $ttl = eli_settings(is_file($path) ? (array) (require $path) : [])['cache_ttl_hours'];
        $st = $pdo->prepare('DELETE FROM eli_cache WHERE created_at < NOW() - INTERVAL :h HOUR');
        $st->bindValue(':h', max(1, $ttl), PDO::PARAM_INT);
        $st->execute();
        $n += $st->rowCount();
    } catch (Throwable $e) {
        error_log('[eli] maintenance: ' . $e->getMessage());
    }

    return $n;
}
