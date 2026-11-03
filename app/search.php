<?php

declare(strict_types=1);

/**
 * AI LAB HUB — пошук продуктів за словниковим індексом (без платних API і без моделі).
 *
 * Використовують: public/catalog.php (?search= — повна видача), public/api-search.php (живі підказки в шапці),
 * app/eli.php (додаткові кандидати для Елі, у межах її правил чутливих розділів), CRM (перебудова індексу).
 *
 * Індекс — таблиця search_index (product_id, lang, field_type, token, weight): слова назви (вага 10),
 * категорій і підкатегорій обома мовами (6), основних функцій (3), короткого (2) і повного опису (1)
 * усіма мовами, що є в продукта (колонки UA, *_en і product_translations). Пошук не залежить від мови.
 *
 * Токенізація однакова для індексу й запиту (search_tokenize): mb_strtolower, апострофи ' ’ ʼ прибираються,
 * усі дефіси → «-», слова — послідовності літер і цифр; слово з дефісом дає частини й злите слово
 * («чат-бот» → чат, бот, чатбот).
 *
 * Запит: кожне слово — група варіантів (саме слово, синоніми з search_synonyms; фраза-синонім —
 * усі її слова разом). Слово з 1–2 літер збігається лише цілком, з 3–4 — за початком слова індексу,
 * від 5 — за початком довжиною max(4, довжина − 2) («фотографії» → «фотограф…», «відео» → «віде…»).
 * Жодних LIKE '%…%' по текстах — лише token = x / token LIKE 'x%' по індексу. Між словами «І», між
 * варіантами одного слова «АБО». Бали: для кожного слова — сума ваг полів, у яких воно знайшлося;
 * точна назва — найвище; рівні бали — за алфавітом. Слово, що є в більш ніж broad_share опублікованих
 * продуктів, видачу не звужує; запит лише з таких слів — режим «надто загальний».
 *
 * Самооновлення: CRM викликає search_index_product() після збереження; імпорти через phpMyAdmin
 * підхоплює search_index_sync() під час пошуку (сигнатура каталогу → нові / змінені продукти до
 * sync_budget за запит; зміни зв'язків із категоріями — обхід за content_hash). Рядки індексу не
 * видаляються: продукт переписує свої рядки на місці, зайві стають порожніми (token = '').
 * Неопубліковані продукти відсікає JOIN зі статусом.
 */

const SEARCH_INDEX_VERSION = 1;   // зміна токенізації / ваг → нові content_hash → індекс оновиться сам
const SEARCH_MAX_QUERY = 100;
const SEARCH_MAX_WORDS = 8;
const SEARCH_TOKEN_MAX = 64;
const SEARCH_WEIGHTS = ['name' => 10, 'subcategory' => 6, 'category' => 6, 'features' => 3, 'short' => 2, 'full' => 1];
const SEARCH_EXACT_NAME_BONUS = 1000;
const SEARCH_NAME_PREFIX_BONUS = 50;

/**
 * Розкладка ЙЦУКЕН (укр.) <-> QWERTY за фізичним положенням клавіш: «Тщешщт» → «notion».
 * Пошук пробує перемапити запит, лише якщо прямий нічого не знайшов.
 */
const LAYOUT_UA_TO_LATIN = [
    'й' => 'q', 'ц' => 'w', 'у' => 'e', 'к' => 'r', 'е' => 't', 'н' => 'y',
    'г' => 'u', 'ш' => 'i', 'щ' => 'o', 'з' => 'p', 'х' => '[', 'ї' => ']',
    'ф' => 'a', 'і' => 's', 'в' => 'd', 'а' => 'f', 'п' => 'g', 'р' => 'h',
    'о' => 'j', 'л' => 'k', 'д' => 'l', 'ж' => ';', 'є' => "'",
    'я' => 'z', 'ч' => 'x', 'с' => 'c', 'м' => 'v', 'и' => 'b', 'т' => 'n',
    'ь' => 'm', 'б' => ',', 'ю' => '.',
];

/** Перемапити рядок символ-за-символом за таблицею розкладки (нижній регістр). */
function remap_layout(string $text, array $map): string
{
    $out = '';
    foreach (mb_str_split(mb_strtolower($text)) as $ch) {
        $out .= $map[$ch] ?? $ch;
    }

    return $out;
}

/** Екранувати спецсимволи LIKE (% і _), щоб вони не діяли як вайлдкарди. */
function like_escape(string $value): string
{
    return addcslashes($value, '%_\\');
}

/** @return array{broad_share: float, broad_top: int, broad_always: array<string, true>, per_page: int, suggest_limit: int, sync_budget: int, sync_check_seconds: int, rebuild_batch: int, ip_limit_per_day: int, log_keep_days: int} */
function search_config(): array
{
    static $cfg = null;
    if ($cfg === null) {
        $path = __DIR__ . '/../config/search.php';
        $raw = is_file($path) ? (array) (require $path) : [];
        $cfg = [
            'broad_share' => min(1.0, max(0.01, (float) ($raw['broad_share'] ?? 0.30))),
            'broad_top' => max(1, (int) ($raw['broad_top'] ?? 20)),
            'broad_always' => array_fill_keys(array_map(static fn($w): string => implode('', search_query_tokens((string) $w)), (array) ($raw['broad_always'] ?? [])), true),
            'per_page' => max(1, (int) ($raw['per_page'] ?? 24)),
            'suggest_limit' => max(1, (int) ($raw['suggest_limit'] ?? 10)),
            'sync_budget' => max(0, (int) ($raw['sync_budget'] ?? 100)),
            'sync_check_seconds' => max(0, (int) ($raw['sync_check_seconds'] ?? 60)),
            'rebuild_batch' => max(1, (int) ($raw['rebuild_batch'] ?? 200)),
            'ip_limit_per_day' => max(1, (int) ($raw['ip_limit_per_day'] ?? 3000)),
            'log_keep_days' => max(1, (int) ($raw['log_keep_days'] ?? 90)),
        ];
    }

    return $cfg;
}

// --- Токенізація --------------------------------------------------------------------------------

/** Нижній регістр, без апострофів, усі дефіси / тире між словами — «-». */
function search_normalize(string $text): string
{
    $t = mb_strtolower($text, 'UTF-8');
    $t = str_replace(["'", '’', 'ʼ', '‘', '`', '´', 'ʹ'], '', $t);

    return str_replace(['‐', '‑', '‒', '–', '—', '―', '−', '﹣', '－'], '-', $t);
}

/**
 * Слова тексту (з повторами, у порядку появи). Слово з дефісом — частини й злите слово.
 *
 * @return list<string>
 */
function search_tokenize(string $text): array
{
    if (!preg_match_all('/[\p{L}\p{M}\p{N}]+(?:-[\p{L}\p{M}\p{N}]+)*/u', search_normalize($text), $m)) {
        return [];
    }
    $out = [];
    foreach ($m[0] as $w) {
        if (str_contains($w, '-')) {
            foreach (explode('-', $w) as $part) {
                $out[] = mb_substr($part, 0, SEARCH_TOKEN_MAX);
            }
            $out[] = mb_substr(str_replace('-', '', $w), 0, SEARCH_TOKEN_MAX);
        } else {
            $out[] = mb_substr($w, 0, SEARCH_TOKEN_MAX);
        }
    }

    return $out;
}

/**
 * Слова запиту: як search_tokenize, але слово з дефісом — одне злите слово («чат-бот» → «чатбот»).
 *
 * @return list<string>
 */
function search_query_tokens(string $text): array
{
    if (!preg_match_all('/[\p{L}\p{M}\p{N}]+(?:-[\p{L}\p{M}\p{N}]+)*/u', search_normalize($text), $m)) {
        return [];
    }

    return array_map(static fn(string $w): string => mb_substr(str_replace('-', '', $w), 0, SEARCH_TOKEN_MAX), $m[0]);
}

/**
 * Правило збігу одного слова: ['exact', слово] для 1–2 літер, інакше ['prefix', початок].
 *
 * @return array{0: string, 1: string}
 */
function search_token_rule(string $token): array
{
    $len = mb_strlen($token);
    if ($len <= 2) {
        return ['exact', $token];
    }
    if ($len <= 4) {
        return ['prefix', $token];
    }

    return ['prefix', mb_substr($token, 0, max(4, $len - 2))];
}

/** Чи підходить слово індексу під правило. */
function search_rule_matches(array $rule, string $token): bool
{
    return $rule[0] === 'exact' ? $token === $rule[1] : str_starts_with($token, $rule[1]);
}

// --- Синоніми -----------------------------------------------------------------------------------

/**
 * Групи синонімів: слово (одне злите слово запиту) → id груп; фрази (кілька слів) → id груп.
 *
 * @return array{single: array<string, list<int>>, phrases: list<array{tokens: list<string>, group: int}>, groups: array<int, list<list<string>>>}
 */
function search_synonyms(PDO $pdo): array
{
    static $cache = null;
    if ($cache !== null) {
        return $cache;
    }
    $cache = ['single' => [], 'phrases' => [], 'groups' => []];
    try {
        $rows = $pdo->query('SELECT group_id, word FROM search_synonyms ORDER BY group_id, id')->fetchAll();
    } catch (PDOException $e) {
        return $cache;   // міграцію ще не застосовано — без синонімів
    }
    foreach ($rows as $r) {
        $gid = (int) $r['group_id'];
        $toks = search_query_tokens((string) $r['word']);
        if ($toks === []) {
            continue;
        }
        $cache['groups'][$gid][] = $toks;
        if (count($toks) === 1) {
            $cache['single'][$toks[0]][] = $gid;
        } else {
            $cache['phrases'][] = ['tokens' => $toks, 'group' => $gid];
        }
    }
    // Довші фрази — першими (жадібний збіг).
    usort($cache['phrases'], static fn(array $a, array $b): int => count($b['tokens']) <=> count($a['tokens']));

    return $cache;
}

/**
 * Групи слів запиту. Кожна група — набір варіантів; варіант — список слів, що мають знайтися разом
 * (одне слово або фраза-синонім).
 *
 * @return list<array{word: string, variants: list<list<string>>}>
 */
function search_query_groups(PDO $pdo, string $query): array
{
    $tokens = array_slice(search_query_tokens($query), 0, SEARCH_MAX_WORDS);
    $syn = search_synonyms($pdo);
    $groups = [];
    $i = 0;
    $n = count($tokens);
    while ($i < $n) {
        $gids = [];
        $word = $tokens[$i];
        $step = 1;
        foreach ($syn['phrases'] as $ph) {
            $len = count($ph['tokens']);
            if ($len > 1 && array_slice($tokens, $i, $len) === $ph['tokens']) {
                $gids = [$ph['group']];
                $word = implode(' ', $ph['tokens']);
                $step = $len;
                break;
            }
        }
        $variants = [];
        if ($step === 1) {
            $variants[] = [$tokens[$i]];
            $gids = $syn['single'][$tokens[$i]] ?? [];
        }
        foreach ($gids as $gid) {
            foreach ($syn['groups'][$gid] ?? [] as $v) {
                $variants[] = $v;
            }
        }
        $uniq = [];
        foreach ($variants as $v) {
            $uniq[implode(' ', $v)] = $v;
        }
        $groups[] = ['word' => $word, 'variants' => array_values($uniq)];
        $i += $step;
    }

    return $groups;
}

// --- Індекс -------------------------------------------------------------------------------------

/** Чи застосовано міграцію (таблиці індексу є). */
function search_ready(PDO $pdo): bool
{
    static $ok = null;
    if ($ok === null) {
        try {
            $pdo->query('SELECT 1 FROM search_index_state LIMIT 1');
            $pdo->query('SELECT 1 FROM search_index LIMIT 1');
            $ok = true;
        } catch (PDOException $e) {
            $ok = false;
        }
    }

    return $ok;
}

/**
 * Документи для індексу: на кожен продукт — content_hash і рядки [lang, field_type, token, weight]
 * (одне слово в одному полі — один рядок, незалежно від мов).
 *
 * @param list<int> $ids
 * @return array<int, array{hash: string, rows: list<array{0: string, 1: string, 2: string, 3: int}>}>
 */
function search_index_docs(PDO $pdo, array $ids): array
{
    $ids = array_values(array_unique(array_filter(array_map('intval', $ids), static fn(int $v): bool => $v > 0)));
    if ($ids === []) {
        return [];
    }
    $in = implode(',', $ids);
    $src = [];   // id => list of [lang, field, text]
    foreach ($pdo->query("SELECT id, name, short_description, short_description_en, main_features, main_features_en,
                                 full_description, full_description_en FROM products WHERE id IN ($in)") as $p) {
        $id = (int) $p['id'];
        $src[$id] = [
            ['', 'name', (string) $p['name']],
            ['uk', 'short', (string) $p['short_description']],
            ['en', 'short', (string) $p['short_description_en']],
            ['uk', 'features', (string) $p['main_features']],
            ['en', 'features', (string) $p['main_features_en']],
            ['uk', 'full', (string) $p['full_description']],
            ['en', 'full', (string) $p['full_description_en']],
        ];
    }
    $fieldMap = ['short_description' => 'short', 'main_features' => 'features', 'full_description' => 'full'];
    foreach ($pdo->query("SELECT product_id, field_name, lang, translated_text FROM product_translations
                          WHERE product_id IN ($in) AND field_name IN ('short_description', 'main_features', 'full_description')
                          ORDER BY product_id, field_name, lang") as $t) {
        $id = (int) $t['product_id'];
        if (isset($src[$id])) {
            $src[$id][] = [(string) $t['lang'], $fieldMap[(string) $t['field_name']], (string) $t['translated_text']];
        }
    }
    foreach ($pdo->query("SELECT pc.product_id, c.name, c.name_en FROM product_categories pc JOIN categories c ON c.id = pc.category_id
                          WHERE pc.product_id IN ($in) ORDER BY pc.product_id, c.id") as $c) {
        $id = (int) $c['product_id'];
        if (isset($src[$id])) {
            $src[$id][] = ['uk', 'category', (string) $c['name']];
            $src[$id][] = ['en', 'category', (string) $c['name_en']];
        }
    }
    foreach ($pdo->query("SELECT ps.product_id, s.name, s.name_en FROM product_subcategories ps JOIN subcategories s ON s.id = ps.subcategory_id
                          WHERE ps.product_id IN ($in) ORDER BY ps.product_id, s.id") as $s) {
        $id = (int) $s['product_id'];
        if (isset($src[$id])) {
            $src[$id][] = ['uk', 'subcategory', (string) $s['name']];
            $src[$id][] = ['en', 'subcategory', (string) $s['name_en']];
        }
    }

    $docs = [];
    foreach ($src as $id => $parts) {
        $rows = [];
        foreach ($parts as [$lang, $field, $text]) {
            foreach (search_tokenize($text) as $tok) {
                $key = $field . "\x1f" . $tok;
                if (!isset($rows[$key])) {
                    $rows[$key] = [$lang, $field, $tok, SEARCH_WEIGHTS[$field]];
                }
            }
        }
        $docs[$id] = [
            'hash' => md5(SEARCH_INDEX_VERSION . "\x1e" . json_encode($parts, JSON_UNESCAPED_UNICODE)),
            'rows' => array_values($rows),
        ];
    }

    return $docs;
}

/**
 * Переписати продукти в індексі (на місці: наявні рядки оновлюються, нові додаються, зайві стають порожніми).
 * Продукт без змін (той самий content_hash) лише позначається перевіреним.
 *
 * @param list<int> $ids
 * @return int скільки продуктів справді переписано
 */
function search_index_products(PDO $pdo, array $ids, bool $force = false): int
{
    if (!search_ready($pdo)) {
        return 0;
    }
    $docs = search_index_docs($pdo, $ids);
    if ($docs === []) {
        return 0;
    }
    $in = implode(',', array_keys($docs));
    $state = $pdo->query("SELECT product_id, content_hash FROM search_index_state WHERE product_id IN ($in)")->fetchAll(PDO::FETCH_KEY_PAIR);
    $touch = $pdo->prepare('INSERT INTO search_index_state (product_id, content_hash, indexed_at) VALUES (:p, :h, NOW())
                            ON DUPLICATE KEY UPDATE content_hash = VALUES(content_hash), indexed_at = VALUES(indexed_at)');
    $slots = $pdo->prepare('SELECT id FROM search_index WHERE product_id = :p ORDER BY id');
    $written = 0;
    foreach ($docs as $id => $doc) {
        if (!$force && ($state[$id] ?? null) === $doc['hash']) {
            $touch->execute([':p' => $id, ':h' => $doc['hash']]);
            continue;
        }
        $slots->execute([':p' => $id]);
        $have = array_map('intval', $slots->fetchAll(PDO::FETCH_COLUMN));
        $rows = $doc['rows'];
        $pdo->beginTransaction();
        try {
            foreach (array_chunk($rows, 300, true) as $chunk) {
                $vals = [];
                $params = [];
                foreach ($chunk as $k => [$lang, $field, $tok, $w]) {
                    $slotId = $have[$k] ?? null;
                    $vals[] = '(?, ?, ?, ?, ?, ?)';
                    array_push($params, $slotId, $id, $lang, $field, $tok, $w);
                }
                $pdo->prepare('INSERT INTO search_index (id, product_id, lang, field_type, token, weight) VALUES ' . implode(',', $vals)
                    . ' ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), lang = VALUES(lang), field_type = VALUES(field_type),
                        token = VALUES(token), weight = VALUES(weight)')->execute($params);
            }
            $spare = array_slice($have, count($rows));
            foreach (array_chunk($spare, 500) as $chunk) {
                $pdo->exec("UPDATE search_index SET token = '', weight = 0, field_type = '', lang = '' WHERE id IN (" . implode(',', $chunk) . ')');
            }
            $touch->execute([':p' => $id, ':h' => $doc['hash']]);
            $pdo->commit();
            $written++;
            $memo = &search_hits_memo();
            $memo = [];
        } catch (Throwable $e) {
            $pdo->rollBack();
            throw $e;
        }
    }

    return $written;
}

/** Переписати один продукт (CRM після збереження). Помилки — лише в журнал, збереження не ламаємо. */
function search_index_product(PDO $pdo, int $productId): void
{
    try {
        search_index_products($pdo, [$productId]);
    } catch (Throwable $e) {
        error_log('[search] index product ' . $productId . ': ' . $e->getMessage());
    }
}

function search_setting_get(PDO $pdo, string $key): string
{
    $st = $pdo->prepare('SELECT setting_value FROM site_settings WHERE setting_key = :k');
    $st->execute([':k' => $key]);
    $v = $st->fetchColumn();

    return $v === false ? '' : (string) $v;
}

function search_setting_set(PDO $pdo, string $key, string $value): void
{
    $pdo->prepare('INSERT INTO site_settings (setting_key, setting_value) VALUES (:k, :v)
                   ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)')->execute([':k' => $key, ':v' => $value]);
}

/**
 * Сигнатура каталогу двома частинами: «час» (продукти й переклади) і «зв'язки» (категорії, підкатегорії, їхні назви).
 *
 * @return array{0: string, 1: string}
 */
function search_index_signature(PDO $pdo): array
{
    $a = $pdo->query("SELECT COUNT(*), MAX(updated_at) FROM products WHERE status = 'published'")->fetch(PDO::FETCH_NUM);
    $b = $pdo->query('SELECT COUNT(*), MAX(updated_at) FROM product_translations')->fetch(PDO::FETCH_NUM);
    $c = $pdo->query('SELECT COUNT(*), SUM(product_id * 131 + category_id) FROM product_categories')->fetch(PDO::FETCH_NUM);
    $d = $pdo->query('SELECT COUNT(*), SUM(product_id * 131 + subcategory_id) FROM product_subcategories')->fetch(PDO::FETCH_NUM);
    $e = $pdo->query("SELECT COUNT(*), SUM(CRC32(CONCAT(id, '|', name, '|', IFNULL(name_en, '')))) FROM categories")->fetch(PDO::FETCH_NUM);
    $f = $pdo->query("SELECT COUNT(*), SUM(CRC32(CONCAT(id, '|', name, '|', IFNULL(name_en, '')))) FROM subcategories")->fetch(PDO::FETCH_NUM);

    return [md5(SEARCH_INDEX_VERSION . json_encode([$a, $b])), md5(SEARCH_INDEX_VERSION . json_encode([$c, $d, $e, $f]))];
}

/**
 * Самооновлення під час пошуку: якщо каталог змінився (імпорт через phpMyAdmin тощо) — дописати до
 * $budget нових / змінених продуктів. Повертає скільки перевірено й чи індекс уже актуальний.
 *
 * @return array{checked: int, written: int, fresh: bool}
 */
function search_index_sync(PDO $pdo, ?int $budget = null): array
{
    static $ran = false;
    $res = ['checked' => 0, 'written' => 0, 'fresh' => true];
    if ($ran || !search_ready($pdo)) {
        return $res;
    }
    $ran = true;
    $throttled = $budget === null;   // виклик із пошуку — не частіше за sync_check_seconds; явний (тести, CLI) — завжди
    $budget ??= search_config()['sync_budget'];
    try {
        if ($throttled) {
            $every = search_config()['sync_check_seconds'];
            $last = (int) search_setting_get($pdo, 'search_index_checked_at');
            if ($every > 0 && $last > 0 && time() - $last < $every) {
                return $res;
            }
        }
        [$sigTime, $sigLinks] = search_index_signature($pdo);
        $stored = explode(':', search_setting_get($pdo, 'search_index_sig') . ':');
        if ($stored[0] === $sigTime && $stored[1] === $sigLinks) {
            $res['fresh'] = true;
        } else {
            $res = search_index_sync_step($pdo, $budget, $sigTime, $sigLinks, $stored);
        }
    } catch (Throwable $e) {
        error_log('[search] sync: ' . $e->getMessage());
    }
    if ($throttled && $res['fresh']) {
        // Наступна перевірка — через sync_check_seconds; поки індекс не наздогнав каталог — на кожен пошук.
        try {
            search_setting_set($pdo, 'search_index_checked_at', (string) time());
        } catch (Throwable $e) {
            error_log('[search] sync mark: ' . $e->getMessage());
        }
    }

    return $res;
}

/**
 * Один крок дописування індексу (каталог змінився).
 *
 * @param list<string> $stored збережена сигнатура [час, зв'язки]
 * @return array{checked: int, written: int, fresh: bool}
 */
function search_index_sync_step(PDO $pdo, int $budget, string $sigTime, string $sigLinks, array $stored): array
{
    $res = ['checked' => 0, 'written' => 0, 'fresh' => false];
    if ($budget <= 0) {
        return $res;
    }
    {
        // 1. Нові, змінені продукти й продукти зі зміненими перекладами.
        $ids = $pdo->query(
            "SELECT p.id FROM products p
             LEFT JOIN search_index_state s ON s.product_id = p.id
             LEFT JOIN (SELECT product_id, MAX(updated_at) AS t FROM product_translations GROUP BY product_id) pt ON pt.product_id = p.id
             WHERE p.status = 'published'
               AND (s.product_id IS NULL OR p.updated_at > s.indexed_at OR pt.t > s.indexed_at)
             ORDER BY p.id LIMIT " . (int) $budget
        )->fetchAll(PDO::FETCH_COLUMN);
        if ($ids !== []) {
            $res['written'] += search_index_products($pdo, array_map('intval', $ids));
            $res['checked'] += count($ids);
        }
        if (count($ids) >= $budget) {
            return $res;   // ще лишилось — наступний запит продовжить
        }
        if ($stored[1] === $sigLinks) {
            search_setting_set($pdo, 'search_index_sig', $sigTime . ':' . $sigLinks);
            $res['fresh'] = true;

            return $res;
        }
        // 2. Змінились зв'язки з категоріями чи їхні назви: обхід за content_hash порціями.
        $left = $budget - count($ids);
        $cursor = (int) search_setting_get($pdo, 'search_index_cursor');
        $batch = $pdo->query("SELECT id FROM products WHERE status = 'published' AND id > " . $cursor . ' ORDER BY id LIMIT ' . (int) $left)
            ->fetchAll(PDO::FETCH_COLUMN);
        if ($batch !== []) {
            $res['written'] += search_index_products($pdo, array_map('intval', $batch));
            $res['checked'] += count($batch);
        }
        if (count($batch) < $left) {
            search_setting_set($pdo, 'search_index_cursor', '0');
            search_setting_set($pdo, 'search_index_sig', $sigTime . ':' . $sigLinks);
            $res['fresh'] = true;
        } else {
            search_setting_set($pdo, 'search_index_cursor', (string) end($batch));
        }
    }

    return $res;
}

/**
 * Порція повної перебудови (кнопка в CRM): переписати продукти з id > $afterId.
 *
 * @return array{next: ?int, processed: int, written: int, total: int}
 */
function search_index_rebuild_batch(PDO $pdo, int $afterId, ?int $batch = null): array
{
    $batch ??= search_config()['rebuild_batch'];
    $ids = $pdo->prepare("SELECT id FROM products WHERE status = 'published' AND id > :a ORDER BY id LIMIT " . (int) $batch);
    $ids->execute([':a' => $afterId]);
    $ids = array_map('intval', $ids->fetchAll(PDO::FETCH_COLUMN));
    $written = $ids === [] ? 0 : search_index_products($pdo, $ids, true);
    $total = (int) $pdo->query("SELECT COUNT(*) FROM products WHERE status = 'published'")->fetchColumn();
    $next = count($ids) < $batch ? null : end($ids);
    if ($next === null) {
        // Кінець обходу: індекс актуальний — запам'ятати сигнатуру, щоб пошук не перевіряв усе знову.
        [$sigTime, $sigLinks] = search_index_signature($pdo);
        search_setting_set($pdo, 'search_index_sig', $sigTime . ':' . $sigLinks);
        search_setting_set($pdo, 'search_index_cursor', '0');
    }

    return ['next' => $next, 'processed' => count($ids), 'written' => $written, 'total' => $total];
}

/** @return array{published: int, indexed: int, outdated: int, rows: int} */
function search_index_status(PDO $pdo): array
{
    $pub = (int) $pdo->query("SELECT COUNT(*) FROM products WHERE status = 'published'")->fetchColumn();
    if (!search_ready($pdo)) {
        return ['published' => $pub, 'indexed' => 0, 'outdated' => $pub, 'rows' => 0];
    }
    $idx = (int) $pdo->query("SELECT COUNT(*) FROM products p JOIN search_index_state s ON s.product_id = p.id WHERE p.status = 'published'")->fetchColumn();
    $old = (int) $pdo->query("SELECT COUNT(*) FROM products p JOIN search_index_state s ON s.product_id = p.id
                              WHERE p.status = 'published' AND p.updated_at > s.indexed_at")->fetchColumn();
    $rows = (int) $pdo->query("SELECT COUNT(*) FROM search_index WHERE token <> ''")->fetchColumn();

    return ['published' => $pub, 'indexed' => $idx, 'outdated' => $old + ($pub - $idx), 'rows' => $rows];
}

// --- Пошук --------------------------------------------------------------------------------------

/** Кеш збігів у межах запиту; скидається після кожного запису в індекс. */
function &search_hits_memo(): array
{
    static $memo = [];

    return $memo;
}

/**
 * Бали продуктів для одного слова індексу за правилом: product_id => [field_type => вага].
 *
 * @return array<int, array<string, int>>
 */
function search_rule_hits(PDO $pdo, array $rule): array
{
    $memo = &search_hits_memo();
    $key = $rule[0] . ':' . $rule[1];
    if (isset($memo[$key])) {
        return $memo[$key];
    }
    if ($rule[0] === 'exact') {
        $st = $pdo->prepare("SELECT si.product_id, si.field_type, MAX(si.weight) AS w FROM search_index si
                             JOIN products p ON p.id = si.product_id AND p.status = 'published'
                             WHERE si.token = :t GROUP BY si.product_id, si.field_type");
        $st->execute([':t' => $rule[1]]);
    } else {
        $st = $pdo->prepare("SELECT si.product_id, si.field_type, MAX(si.weight) AS w FROM search_index si
                             JOIN products p ON p.id = si.product_id AND p.status = 'published'
                             WHERE si.token LIKE :t GROUP BY si.product_id, si.field_type");
        $st->execute([':t' => like_escape($rule[1]) . '%']);
    }
    $out = [];
    foreach ($st as $r) {
        $out[(int) $r['product_id']][(string) $r['field_type']] = (int) $r['w'];
    }

    return $memo[$key] = $out;
}

/**
 * Продукти, що відповідають групі слова: product_id => [field_type => вага] (найбільша з варіантів).
 *
 * @return array<int, array<string, int>>
 */
function search_group_hits(PDO $pdo, array $group): array
{
    $hits = [];
    foreach ($group['variants'] as $variant) {
        $acc = null;   // фраза: продукт має містити всі її слова
        foreach ($variant as $tok) {
            $h = search_rule_hits($pdo, search_token_rule($tok));
            if ($acc === null) {
                $acc = $h;
            } else {
                $next = [];
                foreach ($acc as $pid => $fields) {
                    if (isset($h[$pid])) {
                        $merged = $fields;
                        foreach ($h[$pid] as $f => $w) {
                            $merged[$f] = max($merged[$f] ?? 0, $w);
                        }
                        $next[$pid] = $merged;
                    }
                }
                $acc = $next;
            }
            if ($acc === []) {
                break;
            }
        }
        foreach ($acc ?? [] as $pid => $fields) {
            foreach ($fields as $f => $w) {
                $hits[$pid][$f] = max($hits[$pid][$f] ?? 0, $w);
            }
        }
    }

    return $hits;
}

/**
 * Пошук продуктів. status: ok — є результати; broad — запит лише із загальних слів (ids — до broad_top за
 * назвою); empty — нічого; invalid — порожній запит. layout — запит у перемапленій розкладці, якщо прямий
 * нічого не дав.
 *
 * @return array{status: string, query: string, layout: ?string, total: int, ids: list<int>, page: int, pages: int, per_page: int, broad_words: list<string>, scores: array<int, int>}
 */
function search_products(PDO $pdo, string $query, int $page = 1, ?int $perPage = null, bool $sync = true): array
{
    $cfg = search_config();
    $perPage ??= $cfg['per_page'];
    $query = mb_substr(trim((string) preg_replace('/\s+/u', ' ', $query)), 0, SEARCH_MAX_QUERY);
    $res = ['status' => 'invalid', 'query' => $query, 'layout' => null, 'total' => 0, 'ids' => [], 'page' => 1, 'pages' => 1,
            'per_page' => $perPage, 'broad_words' => [], 'scores' => []];
    if (!search_ready($pdo)) {
        return $res;
    }
    if ($sync) {
        search_index_sync($pdo);
    }
    $ranked = search_rank($pdo, $query, $cfg);
    if ($ranked === null) {
        return $res;
    }
    if ($ranked['scores'] === [] && $ranked['status'] !== 'broad') {
        // Набрано не в тій розкладці («Тщешщт» → «notion», «ьшвоощгктун» → «midjourney»).
        foreach ([remap_layout($query, LAYOUT_UA_TO_LATIN), remap_layout($query, array_flip(LAYOUT_UA_TO_LATIN))] as $alt) {
            if ($alt === mb_strtolower($query) || search_query_tokens($alt) === []) {
                continue;
            }
            $altRanked = search_rank($pdo, $alt, $cfg);
            if ($altRanked !== null && $altRanked['scores'] !== [] && $altRanked['status'] === 'ok') {
                $ranked = $altRanked;
                $res['layout'] = $alt;
                break;
            }
        }
    }
    $res['status'] = $ranked['status'];
    $res['broad_words'] = $ranked['broad_words'];
    $ids = array_keys($ranked['scores']);
    $res['total'] = count($ids);
    $res['pages'] = max(1, (int) ceil(count($ids) / $perPage));
    $res['page'] = min(max(1, $page), $res['pages']);
    $res['ids'] = array_map('intval', array_slice($ids, ($res['page'] - 1) * $perPage, $perPage));
    $res['scores'] = $ranked['scores'];
    if ($res['total'] === 0 && $res['status'] === 'ok') {
        $res['status'] = 'empty';
    }

    return $res;
}

/**
 * Ранжування без пагінації. null — у запиті немає жодного слова.
 *
 * @return array{status: string, scores: array<int, int>, broad_words: list<string>}|null
 */
function search_rank(PDO $pdo, string $query, array $cfg): ?array
{
    $groups = search_query_groups($pdo, $query);
    if ($groups === []) {
        return null;
    }
    $published = max(1, (int) $pdo->query("SELECT COUNT(*) FROM products WHERE status = 'published'")->fetchColumn());
    $perGroup = [];
    $broad = [];
    $narrow = [];
    foreach ($groups as $gi => $g) {
        $perGroup[$gi] = search_group_hits($pdo, $g);
        if (count($perGroup[$gi]) / $published > $cfg['broad_share'] || isset($cfg['broad_always'][str_replace(' ', '', $g['word'])])) {
            $broad[] = $gi;
        } else {
            $narrow[] = $gi;
        }
    }
    $broadWords = array_map(static fn(int $gi): string => $groups[$gi]['word'], $broad);

    if ($narrow === []) {
        // Лише загальні слова: до broad_top продуктів, у назві яких є ці слова.
        $scores = [];
        foreach ($broad as $gi) {
            foreach ($perGroup[$gi] as $pid => $fields) {
                if (isset($fields['name'])) {
                    $scores[$pid] = ($scores[$pid] ?? 0) + array_sum($fields);
                }
            }
        }
        $scores = search_sort($pdo, $scores, $query);

        return ['status' => 'broad', 'scores' => array_slice($scores, 0, $cfg['broad_top'], true), 'broad_words' => $broadWords];
    }

    // «І» між звужувальними словами.
    $cand = null;
    foreach ($narrow as $gi) {
        $set = $perGroup[$gi];
        $cand = $cand === null ? $set : array_intersect_key($cand, $set);
        if ($cand === []) {
            break;
        }
    }
    $scores = [];
    foreach (array_keys($cand ?? []) as $pid) {
        $s = 0;
        foreach ($perGroup as $hits) {
            if (isset($hits[$pid])) {
                $s += array_sum($hits[$pid]);
            }
        }
        $scores[$pid] = $s;
    }

    return ['status' => 'ok', 'scores' => search_sort($pdo, $scores, $query), 'broad_words' => $broadWords];
}

/**
 * Бонус за точну назву / назву, що починається з запиту; сортування: бали ↓, назва за алфавітом.
 *
 * @param array<int, int> $scores
 * @return array<int, int>
 */
function search_sort(PDO $pdo, array $scores, string $query): array
{
    if ($scores === []) {
        return [];
    }
    $names = [];
    foreach (array_chunk(array_keys($scores), 1000) as $chunk) {
        foreach ($pdo->query('SELECT id, name FROM products WHERE id IN (' . implode(',', array_map('intval', $chunk)) . ')') as $r) {
            $names[(int) $r['id']] = (string) $r['name'];
        }
    }
    $q = implode(' ', search_query_tokens($query));
    foreach ($scores as $pid => $s) {
        $n = implode(' ', search_query_tokens($names[$pid] ?? ''));
        if ($q !== '' && $n === $q) {
            $scores[$pid] = $s + SEARCH_EXACT_NAME_BONUS;
        } elseif ($q !== '' && str_starts_with($n, $q)) {
            $scores[$pid] = $s + SEARCH_NAME_PREFIX_BONUS;
        }
    }
    $ids = array_keys($scores);
    usort($ids, static function (int $a, int $b) use ($scores, $names): int {
        return [$scores[$b], mb_strtolower($names[$a] ?? '')] <=> [$scores[$a], mb_strtolower($names[$b] ?? '')];
    });
    $out = [];
    foreach ($ids as $id) {
        $out[$id] = $scores[$id];
    }

    return $out;
}

/** До $limit id продуктів за запитом (без пагінації; для Елі й підказок). @return list<int> */
function search_product_ids(PDO $pdo, string $query, int $limit, bool $sync = false): array
{
    $r = search_products($pdo, $query, 1, $limit, $sync);

    return in_array($r['status'], ['ok', 'broad'], true) ? $r['ids'] : [];
}

/**
 * Категорії й підкатегорії, назви яких відповідають запиту (для порожньої видачі).
 *
 * @return list<array{type: string, id: int, name: string, name_en: ?string, category_id: ?int}>
 */
function search_matching_sections(PDO $pdo, string $query): array
{
    $groups = search_query_groups($pdo, $query);
    if ($groups === []) {
        return [];
    }
    $out = [];
    $check = static function (array $row) use ($groups): bool {
        $toks = array_merge(search_tokenize((string) $row['name']), search_tokenize((string) ($row['name_en'] ?? '')));
        foreach ($groups as $g) {
            $found = false;
            foreach ($g['variants'] as $variant) {
                $all = true;
                foreach ($variant as $vt) {
                    $rule = search_token_rule($vt);
                    $any = false;
                    foreach ($toks as $t) {
                        if (search_rule_matches($rule, $t)) {
                            $any = true;
                            break;
                        }
                    }
                    if (!$any) {
                        $all = false;
                        break;
                    }
                }
                if ($all) {
                    $found = true;
                    break;
                }
            }
            if ($found) {
                return true;   // достатньо одного слова запиту — це підказка, не фільтр
            }
        }

        return false;
    };
    foreach ($pdo->query('SELECT id, name, name_en FROM categories ORDER BY id') as $c) {
        if ($check($c)) {
            $out[] = ['type' => 'category', 'id' => (int) $c['id'], 'name' => (string) $c['name'], 'name_en' => $c['name_en'], 'category_id' => null];
        }
    }
    foreach ($pdo->query('SELECT id, category_id, name, name_en FROM subcategories ORDER BY id') as $s) {
        if ($check($s)) {
            $out[] = ['type' => 'subcategory', 'id' => (int) $s['id'], 'name' => (string) $s['name'], 'name_en' => $s['name_en'], 'category_id' => (int) $s['category_id']];
        }
    }

    return array_slice($out, 0, 24);
}

// --- Безпека й журнал ---------------------------------------------------------------------------

/** Ліміт частоти пошуку з IP (наявний механізм mp_rate_limits); staff не рахується. true — дозволено. */
function search_rate_ok(PDO $pdo): bool
{
    $role = function_exists('auth_role') ? auth_role() : (is_string($_SESSION['role'] ?? null) ? $_SESSION['role'] : null);
    if (in_array($role, ['admin', 'employee'], true)) {
        return true;
    }
    try {
        require_once __DIR__ . '/marketplace-board.php';

        return mpb_ip_hit($pdo, 'search', search_config()['ip_limit_per_day']);
    } catch (Throwable $e) {
        error_log('[search] rate limit: ' . $e->getMessage());

        return true;
    }
}

/** Журнал запитів без результатів (без IP і без користувача); рядки старші за log_keep_days прибираються. */
function search_log_zero(PDO $pdo, string $query, string $lang): void
{
    $q = mb_substr(trim((string) preg_replace('/\s+/u', ' ', $query)), 0, 200);
    if ($q === '' || search_query_tokens($q) === []) {
        return;
    }
    try {
        $pdo->prepare('INSERT INTO search_log (query, lang, results_count, created_at) VALUES (:q, :l, 0, NOW())')
            ->execute([':q' => $q, ':l' => substr(preg_replace('/[^a-z-]/', '', strtolower($lang)) ?: 'uk', 0, 5)]);
        if (random_int(1, 100) === 1) {
            $pdo->exec('DELETE FROM search_log WHERE created_at < NOW() - INTERVAL ' . search_config()['log_keep_days'] . ' DAY');
        }
    } catch (Throwable $e) {
        error_log('[search] log: ' . $e->getMessage());
    }
}
