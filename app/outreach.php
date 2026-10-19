<?php

declare(strict_types=1);

/**
 * AI LAB HUB — пошук потенційних партнерів (ліди), блок M2.
 *
 * Джерела — лише офіційні публічні API/RSS (outreach_sources; кожне вмикає адмін). Запити: власний User-Agent
 * з контактом, тайм-аути, ETag / Last-Modified, не частіше min_interval_min (типово раз на добу), без обходу обмежень.
 * Мережеві запити — із SSRF-захистом сервісу перевірки посилань (app/promo-linkcheck.php: лише публічні IP,
 * CURLOPT_RESOLVE, ручні редиректи з повторною перевіркою).
 *
 * ПЕРСОНАЛЬНІ ДАНІ: зберігаються лише дані рівня компанії (назва, сайт, публічна сторінка контактів, ділова
 * адреса з переліку ролей). Імена авторів (HN), рекрутерів і особисті адреси не зберігаються й не передаються моделі.
 * Тексти чужих вакансій на сайті не публікуються: лід — внутрішній запис адмінки з посиланням на оригінал.
 *
 * Розбір кожного джерела — чисті функції outreach_parse_*() (тестуються на збережених зразках без мережі).
 */

require_once __DIR__ . '/site-settings.php';
require_once __DIR__ . '/promo-linkcheck.php';   // promo_resolve_host(), promo_ip_is_public(), promo_norm_host()

const OUTREACH_UA = 'AILabHub-Partners/1.0 (+https://ailabhub-directory.com; partners@ailabhub-directory.com)';
const OUTREACH_LEAD_TYPES = ['job', 'course', 'service'];
const OUTREACH_STATUSES = ['new', 'approved', 'rejected', 'draft_ready', 'queued', 'sent', 'sent_manual', 'replied', 'listed', 'declined', 'unsubscribed', 'bounced'];
const OUTREACH_STATUS_UK = [
    'new' => 'Новий', 'approved' => 'Схвалено для аутрічу', 'rejected' => 'Відхилено', 'draft_ready' => 'Чернетка готова',
    'queued' => 'У черзі', 'sent' => 'Надіслано', 'sent_manual' => 'Надіслано вручну', 'replied' => 'Відповіли', 'listed' => 'Розмістили',
    'declined' => 'Відмовились', 'unsubscribed' => 'Відписались', 'bounced' => 'Відскок',
];
/** Ділові ролі адрес (локальна частина до @), які дозволено зберігати. */
const OUTREACH_ROLE_LOCALS = ['info', 'hello', 'contact', 'contacts', 'partners', 'partner', 'partnership', 'partnerships', 'sales',
    'support', 'jobs', 'careers', 'career', 'hr', 'admin', 'office', 'team', 'business', 'enquiries', 'inquiries'];
const OUTREACH_MIN_SCORE = 30;            // нижче — не AI-релевантно, лід не зберігається
const OUTREACH_FETCH_TIMEOUT = 15;
const OUTREACH_MAX_BYTES = 4194304;       // 4 МБ — відповідь API/RSS
const OUTREACH_PAGE_MAX_BYTES = 524288;   // 512 КБ — сторінка сайту компанії
const OUTREACH_CONTACT_PATHS = ['/', '/contact', '/contacts', '/contact-us', '/partners', '/about'];
/** Домени, які не є сайтом компанії: соцмережі, ATS, дошки вакансій, конструктори документів. */
const OUTREACH_NOT_COMPANY_DOMAINS = ['linkedin.com', 'twitter.com', 'x.com', 'facebook.com', 'instagram.com', 'github.com', 'lever.co', 'greenhouse.io',
    'ashbyhq.com', 'workable.com', 'bamboohr.com', 'smartrecruiters.com', 'ycombinator.com', 'wellfound.com', 'notion.site', 'google.com',
    'forms.gle', 'bit.ly', 'medium.com', 'substack.com', 'deel.com', 'workatastartup.com', 'rippling.com', 'recruitee.com',
    'teamtailor.com', 'personio.de', 'jobs.personio.com', 'breezy.hr', 'jobvite.com', 'myworkdayjobs.com', 'welcometothejungle.com', 'remoteok.com', 'himalayas.app', 'arbeitnow.com', 'weworkremotely.com', 'remotive.com'];

// =========================================================================
// HTTP із SSRF-захистом
// =========================================================================

/**
 * GET-запит до публічної адреси. Редиректи — вручну (≤3), кожен із перевіркою IP.
 *
 * @param array<string,string> $extraHeaders
 * @return array{status:int,body:string,etag:?string,last_modified:?string,content_type:string,error:?string,final_url:string}
 */
function outreach_http_get(string $url, array $extraHeaders = [], int $maxBytes = OUTREACH_MAX_BYTES): array
{
    $res = ['status' => 0, 'body' => '', 'etag' => null, 'last_modified' => null, 'content_type' => '', 'error' => null, 'final_url' => $url];
    for ($hop = 0; $hop <= 3; $hop++) {
        $p = parse_url($url);
        $scheme = strtolower((string) ($p['scheme'] ?? ''));
        $host = (string) ($p['host'] ?? '');
        if (!in_array($scheme, ['http', 'https'], true) || $host === '' || isset($p['user']) || isset($p['pass'])) {
            $res['error'] = 'недопустима адреса';

            return $res;
        }
        $port = (int) ($p['port'] ?? ($scheme === 'https' ? 443 : 80));
        if (!in_array($port, [80, 443], true)) {
            $res['error'] = 'недопустимий порт';

            return $res;
        }
        $ips = promo_resolve_host($host);
        if ($ips === []) {
            $res['error'] = 'хост не розв\'язується';

            return $res;
        }
        foreach ($ips as $ip) {
            if (!promo_ip_is_public($ip)) {
                $res['error'] = 'адреса веде у внутрішню мережу (заблоковано)';

                return $res;
            }
        }
        $ip = $ips[0];
        $headersOut = [];
        $received = 0;
        $body = '';
        $ch = curl_init($url);
        $hdr = ['Accept: application/json, application/rss+xml, application/xml, text/html;q=0.8, */*;q=0.5'];
        foreach ($extraHeaders as $k => $v) {
            $hdr[] = $k . ': ' . str_replace(["\r", "\n"], '', $v);
        }
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => false,
            CURLOPT_FOLLOWLOCATION => false,
            CURLOPT_TIMEOUT => OUTREACH_FETCH_TIMEOUT,
            CURLOPT_CONNECTTIMEOUT => 6,
            CURLOPT_USERAGENT => OUTREACH_UA,
            CURLOPT_HTTPHEADER => $hdr,
            CURLOPT_RESOLVE => [$host . ':' . $port . ':' . (str_contains($ip, ':') ? '[' . $ip . ']' : $ip)],
            CURLOPT_PROTOCOLS => CURLPROTO_HTTP | CURLPROTO_HTTPS,
            CURLOPT_ENCODING => '',
            CURLOPT_WRITEFUNCTION => static function ($c, string $chunk) use (&$body, &$received, $maxBytes): int {
                $received += strlen($chunk);
                if ($received > $maxBytes) {
                    return 0;
                }
                $body .= $chunk;

                return strlen($chunk);
            },
            CURLOPT_HEADERFUNCTION => static function ($c, string $line) use (&$headersOut): int {
                $parts = explode(':', $line, 2);
                if (count($parts) === 2) {
                    $headersOut[strtolower(trim($parts[0]))] = trim($parts[1]);
                }

                return strlen($line);
            },
        ]);
        $ok = curl_exec($ch);
        $status = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
        $primary = (string) curl_getinfo($ch, CURLINFO_PRIMARY_IP);
        $err = curl_error($ch);
        curl_close($ch);
        if ($primary !== '' && !promo_ip_is_public($primary)) {
            $res['error'] = 'адреса веде у внутрішню мережу (заблоковано)';

            return $res;
        }
        if ($ok === false && $received <= $maxBytes) {
            $res['error'] = 'мережа: ' . mb_substr($err, 0, 200);

            return $res;
        }
        if ($received > $maxBytes) {
            $res['error'] = 'відповідь завелика';

            return $res;
        }
        $res['status'] = $status;
        if ($status >= 300 && $status < 400 && !empty($headersOut['location']) && $status !== 304) {
            $url = outreach_abs_url($url, $headersOut['location']);
            $res['final_url'] = $url;
            continue;
        }
        $res['body'] = $body;
        $res['etag'] = $headersOut['etag'] ?? null;
        $res['last_modified'] = $headersOut['last-modified'] ?? null;
        $res['content_type'] = $headersOut['content-type'] ?? '';

        return $res;
    }
    $res['error'] = 'забагато переадресацій';

    return $res;
}

/** Абсолютна адреса з відносного посилання. */
function outreach_abs_url(string $base, string $rel): string
{
    if (preg_match('~^https?://~i', $rel)) {
        return $rel;
    }
    $p = parse_url($base);
    $root = ($p['scheme'] ?? 'https') . '://' . ($p['host'] ?? '') . (isset($p['port']) ? ':' . $p['port'] : '');
    if (str_starts_with($rel, '//')) {
        return ($p['scheme'] ?? 'https') . ':' . $rel;
    }
    if (str_starts_with($rel, '/')) {
        return $root . $rel;
    }
    $dir = preg_replace('~/[^/]*$~', '/', (string) ($p['path'] ?? '/')) ?: '/';

    return $root . $dir . $rel;
}

// =========================================================================
// Нормалізація, AI-релевантність
// =========================================================================

/** Домен сайту (хост без www.) або ''. */
function outreach_domain(?string $url): string
{
    $url = trim((string) $url);
    if ($url === '') {
        return '';
    }
    if (!preg_match('~^https?://~i', $url)) {
        $url = 'https://' . $url;
    }
    $h = rtrim(strtolower((string) parse_url($url, PHP_URL_HOST)), '.');
    // Службові піддомени вакансій/сайту → домен компанії (careers.acme.io → acme.io).
    if (substr_count($h, '.') >= 2) {
        $h = preg_replace('~^(?:www|careers|career|jobs|job|apply|work|hiring|join)\.~', '', $h) ?? $h;
    }

    return str_starts_with($h, 'www.') ? substr($h, 4) : $h;
}

/** Нормалізована назва компанії для дедуплікації. */
function outreach_norm_company(string $name): string
{
    $n = mb_strtolower(trim($name));
    $n = preg_replace('~\b(inc|llc|ltd|gmbh|corp|co|s\.?a|b\.?v|ag|oy|ab|sp\.? z o\.?o|тов|фоп)\b\.?~u', '', $n) ?? $n;

    return trim(preg_replace('~[^\p{L}\p{N}]+~u', ' ', $n) ?? $n);
}

/** Чистий текст (без HTML, пробіли згорнуті), обрізаний. */
function outreach_text(string $html, int $max = 4000): string
{
    $t = html_entity_decode(strip_tags(str_replace(['<br>', '<br/>', '<br />', '<p>', '</p>', '</li>'], "\n", $html)), ENT_QUOTES | ENT_HTML5, 'UTF-8');

    return mb_substr(trim(preg_replace('/[ \t\r\f\v]+/u', ' ', $t) ?? $t), 0, $max);
}

/**
 * Оцінка AI-релевантності за ключовими словами: 0–100. Назва важить більше за опис.
 * Без персональних даних: оцінюються лише назва посади/пропозиції, теги й текст опису.
 */
function outreach_ai_keyword_score(string $title, string $text = '', array $tags = []): int
{
    $strong = '~\b(ai|a\.i\.|artificial intelligence|machine learning|ml|llms?|genai|gen ai|generative|deep learning|nlp|computer vision|'
        . 'mlops|prompt|rag|data scientist|ai engineer|ml engineer|neural|transformers?|langchain|pytorch|tensorflow|chatbot|agentic|ai agents?)\b'
        . '|штучн\w* інтелект|машинн\w* навчан|нейромереж|генеративн|промпт|künstliche intelligenz|maschinelles lernen~iu';
    $tagText = implode(' ', array_map('strval', $tags));
    $tagHit = $tagText !== '' && preg_match($strong, $tagText) === 1;
    $hits = $text !== '' ? (int) preg_match_all($strong, $text) : 0;
    if (preg_match($strong, $title) === 1) {
        return min(100, 70 + ($tagHit ? 15 : 0) + min(15, $hits * 3));
    }
    // Без збігу в назві — лише «сіра зона» (≤45): згадка AI в описі ще не робить роль AI-роллю.
    return min(45, ($tagHit ? 20 : 0) + min(30, $hits * 5));
}

/**
 * Необов'язкова класифікація моделлю (налаштування outreach_ai_classify = 1) — лише для «сірої зони» оцінок,
 * з кешем і денним лімітом викликів. У промпт іде ЛИШЕ назва вакансії/пропозиції (без компанії, людей, адрес).
 * Повертає нову оцінку або null (вимкнено / ліміт / помилка).
 */
function outreach_ai_classify(PDO $pdo, string $title, ?callable $transport = null): ?int
{
    if (site_setting($pdo, 'outreach_ai_classify', '0') !== '1') {
        return null;
    }
    $title = mb_substr(trim(preg_replace('~[\w.+-]+@[\w-]+\.[\w.-]+~u', '', $title) ?? $title), 0, 160);
    if ($title === '') {
        return null;
    }
    $hash = hash('sha256', mb_strtolower($title));
    $st = $pdo->prepare('SELECT score FROM outreach_ai_cache WHERE text_hash = :h');
    $st->execute([':h' => $hash]);
    $cached = $st->fetchColumn();
    if ($cached !== false) {
        return (int) $cached;
    }
    $cap = max(0, (int) site_setting($pdo, 'outreach_ai_daily_cap', '50'));
    $used = (int) $pdo->query('SELECT COUNT(*) FROM outreach_ai_cache WHERE created_at > (NOW() - INTERVAL 1 DAY)')->fetchColumn();
    if ($used >= $cap) {
        return null;
    }
    $cfgFile = __DIR__ . '/../config/ai-assistant.php';
    if (!is_file($cfgFile)) {
        return null;
    }
    require_once __DIR__ . '/eli.php';
    $cfg = eli_settings(require $cfgFile);
    if ($cfg['api_key'] === '') {
        return null;
    }
    $system = 'You classify job or offer titles. Answer with JSON only: {"ai":true|false}. "ai" is true only if the role or offer is mainly about artificial intelligence, machine learning, LLMs or data science.';
    try {
        $transport ??= 'eli_http_post';
        $r = eli_provider_call($cfg, (string) $cfg['model'], $system, 'Title: ' . $title, 15, $transport);
        $json = !empty($r['ok']) ? eli_extract_json((string) $r['text']) : null;
    } catch (Throwable $e) {
        error_log('[outreach] classify: ' . $e->getMessage());

        return null;
    }
    if (!is_array($json) || !array_key_exists('ai', $json)) {
        return null;
    }
    $score = $json['ai'] === true ? 60 : 10;
    $pdo->prepare('INSERT IGNORE INTO outreach_ai_cache (text_hash, score) VALUES (:h, :s)')->execute([':h' => $hash, ':s' => $score]);

    return $score;
}

// =========================================================================
// Розбір джерел (чисті функції; повертають список «сирих» лідів)
// Лід: company_name, title, source_url, company_website?, country?, language?, text (для оцінки, не зберігається), tags
// =========================================================================

/** @return list<array<string,mixed>> */
function outreach_parse_arbeitnow(array $json): array
{
    $out = [];
    foreach ((array) ($json['data'] ?? []) as $j) {
        if (!is_array($j) || empty($j['company_name']) || empty($j['url'])) {
            continue;
        }
        $out[] = [
            'company_name' => (string) $j['company_name'], 'title' => (string) ($j['title'] ?? ''), 'source_url' => (string) $j['url'],
            'country' => preg_match('~\b(germany|deutschland)\b~i', (string) ($j['location'] ?? '')) ? 'DE' : null,
            'text' => outreach_text((string) ($j['description'] ?? '')), 'tags' => array_merge((array) ($j['tags'] ?? []), (array) ($j['job_types'] ?? [])),
        ];
    }

    return $out;
}

/** Remote OK: перший елемент масиву — юридична примітка, його пропускаємо. @return list<array<string,mixed>> */
function outreach_parse_remoteok(array $json): array
{
    $out = [];
    foreach ($json as $j) {
        if (!is_array($j) || empty($j['company']) || empty($j['url']) || isset($j['legal'])) {
            continue;
        }
        $out[] = [
            'company_name' => (string) $j['company'], 'title' => (string) ($j['position'] ?? ''), 'source_url' => (string) $j['url'],
            'text' => outreach_text((string) ($j['description'] ?? '')), 'tags' => (array) ($j['tags'] ?? []),
        ];
    }

    return $out;
}

/** @return list<array<string,mixed>> */
function outreach_parse_himalayas(array $json): array
{
    $out = [];
    foreach ((array) ($json['jobs'] ?? []) as $j) {
        if (!is_array($j) || empty($j['companyName'])) {
            continue;
        }
        $src = (string) ($j['guid'] ?? $j['applicationLink'] ?? '');
        if ($src === '') {
            continue;
        }
        $loc = (array) ($j['locationRestrictions'] ?? []);
        $out[] = [
            'company_name' => (string) $j['companyName'], 'title' => (string) ($j['title'] ?? ''), 'source_url' => $src,
            'country' => count($loc) === 1 ? outreach_country_code((string) $loc[0]) : null,
            'text' => outreach_text((string) ($j['excerpt'] ?? $j['description'] ?? '')), 'tags' => (array) ($j['categories'] ?? []),
        ];
    }

    return $out;
}

/** We Work Remotely RSS: заголовок «Компанія: Посада». @return list<array<string,mixed>> */
function outreach_parse_wwr(string $xml): array
{
    $prev = libxml_use_internal_errors(true);
    $doc = simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NONET | LIBXML_NOCDATA);
    libxml_use_internal_errors($prev);
    if ($doc === false || !isset($doc->channel->item)) {
        return [];
    }
    $out = [];
    foreach ($doc->channel->item as $it) {
        $title = trim((string) $it->title);
        $link = trim((string) $it->link);
        if ($link === '' || !str_contains($title, ':')) {
            continue;
        }
        [$company, $position] = array_map('trim', explode(':', $title, 2));
        if ($company === '') {
            continue;
        }
        $out[] = ['company_name' => $company, 'title' => $position, 'source_url' => $link,
            'text' => outreach_text((string) $it->description), 'tags' => [(string) ($it->category ?? '')]];
    }

    return $out;
}

/** HN Algolia: id найсвіжішого «Ask HN: Who is hiring?» з відповіді search_by_date. */
function outreach_hn_story_id(array $json): ?int
{
    foreach ((array) ($json['hits'] ?? []) as $h) {
        if (is_array($h) && stripos((string) ($h['title'] ?? ''), 'who is hiring') !== false && !empty($h['objectID'])) {
            return (int) $h['objectID'];
        }
    }

    return null;
}

/**
 * HN: коментарі верхнього рівня. Компанія — перший сегмент першого рядка до «|». Ім'я автора НЕ береться.
 * @return list<array<string,mixed>>
 */
function outreach_parse_hn_item(array $item): array
{
    $out = [];
    foreach ((array) ($item['children'] ?? []) as $c) {
        if (!is_array($c) || empty($c['text']) || empty($c['id'])) {
            continue;
        }
        $text = outreach_text((string) $c['text'], 3000);
        $first = trim(strtok($text, "\n") ?: '');
        if (!str_contains($first, '|')) {
            continue;
        }
        $parts = array_map('trim', explode('|', $first));
        $company = preg_replace('~\s*\(.*?\)\s*~', ' ', $parts[0]) ?? $parts[0];
        $company = trim(mb_substr($company, 0, 120));
        if ($company === '' || mb_strlen($company) > 80) {
            continue;
        }
        $site = null;
        if (preg_match('~https?://[^\s|)<>"]+~i', $first, $m)) {
            $site = rtrim($m[0], '.,;');
        }
        $out[] = [
            'company_name' => $company, 'title' => outreach_short_title(implode(' | ', array_slice($parts, 1, 2))),
            'source_url' => 'https://news.ycombinator.com/item?id=' . (int) $c['id'], 'company_website' => $site,
            'text' => $text, 'tags' => [],
        ];
    }

    return $out;
}

/** Короткий контекст (≤100 символів, по межі слова): у першому рядку HN-коментаря часто далі йде опис. */
function outreach_short_title(string $t): string
{
    $t = trim(preg_replace('/\s+/u', ' ', $t) ?? $t);
    if (mb_strlen($t) <= 100) {
        return $t;
    }
    $cut = mb_substr($t, 0, 100);
    $sp = mb_strrpos($cut, ' ');

    return rtrim($sp !== false && $sp > 40 ? mb_substr($cut, 0, $sp) : $cut, ' ,.;|') . '…';
}

/** Greenhouse boards API (jobs). @return list<array<string,mixed>> */
function outreach_parse_greenhouse(array $json, string $token): array
{
    $out = [];
    foreach ((array) ($json['jobs'] ?? []) as $j) {
        if (!is_array($j) || empty($j['absolute_url'])) {
            continue;
        }
        $out[] = ['company_name' => (string) ($j['company_name'] ?? ucfirst($token)), 'title' => (string) ($j['title'] ?? ''),
            'source_url' => (string) $j['absolute_url'], 'text' => outreach_text((string) ($j['content'] ?? '')), 'tags' => []];
    }

    return $out;
}

/** Lever postings API. @return list<array<string,mixed>> */
function outreach_parse_lever(array $json, string $token): array
{
    $out = [];
    foreach ($json as $j) {
        if (!is_array($j) || empty($j['hostedUrl'])) {
            continue;
        }
        $out[] = ['company_name' => ucfirst($token), 'title' => (string) ($j['text'] ?? ''), 'source_url' => (string) $j['hostedUrl'],
            'text' => outreach_text((string) ($j['descriptionPlain'] ?? '')), 'tags' => array_values(array_filter([(string) ($j['categories']['team'] ?? '')]))];
    }

    return $out;
}

/** Remotive (вимкнено за замовчуванням). @return list<array<string,mixed>> */
function outreach_parse_remotive(array $json): array
{
    $out = [];
    foreach ((array) ($json['jobs'] ?? []) as $j) {
        if (!is_array($j) || empty($j['company_name']) || empty($j['url'])) {
            continue;
        }
        $out[] = ['company_name' => (string) $j['company_name'], 'title' => (string) ($j['title'] ?? ''), 'source_url' => (string) $j['url'],
            'text' => outreach_text((string) ($j['description'] ?? '')), 'tags' => (array) ($j['tags'] ?? [])];
    }

    return $out;
}

/** Назва країни англійською → ISO-код (невеликий словник) або null. */
function outreach_country_code(string $name): ?string
{
    $map = ['ukraine' => 'UA', 'poland' => 'PL', 'germany' => 'DE', 'united kingdom' => 'GB', 'uk' => 'GB', 'united states' => 'US', 'usa' => 'US',
        'canada' => 'CA', 'netherlands' => 'NL', 'france' => 'FR', 'spain' => 'ES', 'italy' => 'IT', 'portugal' => 'PT', 'ireland' => 'IE',
        'czechia' => 'CZ', 'czech republic' => 'CZ', 'romania' => 'RO', 'estonia' => 'EE', 'sweden' => 'SE', 'israel' => 'IL', 'india' => 'IN', 'singapore' => 'SG',
        'russia' => 'RU', 'russian federation' => 'RU', 'belarus' => 'BY'];
    $k = strtolower(trim($name));
    if (preg_match('/^[A-Z]{2}$/', trim($name))) {
        return trim($name);
    }

    return $map[$k] ?? null;
}

// =========================================================================
// Збереження: виключення, дублікати, «вже в каталозі»
// =========================================================================

/** @return list<string> рядки налаштування (через кому / новий рядок), у нижньому регістрі */
function outreach_setting_list(PDO $pdo, string $key): array
{
    $raw = site_setting($pdo, $key, '');

    return array_values(array_filter(array_map(static fn($x) => strtolower(trim($x)), preg_split('/[\s,;]+/', $raw) ?: [])));
}

/** Домени продуктів каталогу (official_url) — для позначки «вже в каталозі». @return array<string,bool> */
function outreach_catalog_domains(PDO $pdo): array
{
    static $cache = null;
    if ($cache !== null) {
        return $cache;
    }
    $cache = [];
    try {
        foreach ($pdo->query("SELECT official_url FROM products WHERE official_url IS NOT NULL AND official_url <> ''") as $r) {
            $d = outreach_domain((string) $r['official_url']);
            if ($d !== '') {
                $cache[$d] = true;
            }
        }
    } catch (Throwable $e) {
        error_log('[outreach] catalog domains: ' . $e->getMessage());
    }

    return $cache;
}

/** Чи домен у списку (точний збіг або піддомен). */
function outreach_domain_in(string $domain, array $list): bool
{
    foreach ($list as $d) {
        $d = ltrim($d, '.');
        if ($d !== '' && ($domain === $d || str_ends_with($domain, '.' . $d))) {
            return true;
        }
    }

    return false;
}

/** Чи вже є лід цієї компанії (за доменом, а без домену — за нормалізованою назвою). */
function outreach_is_duplicate(PDO $pdo, string $domain, string $company): bool
{
    if ($domain !== '') {
        $st = $pdo->prepare('SELECT 1 FROM outreach_leads WHERE company_domain = :d LIMIT 1');
        $st->execute([':d' => $domain]);
        if ($st->fetchColumn() !== false) {
            return true;
        }
    }
    $norm = outreach_norm_company($company);
    if ($norm === '') {
        return true;
    }
    $st = $pdo->prepare('SELECT company_name FROM outreach_leads WHERE company_name LIKE :p LIMIT 200');
    $st->execute([':p' => mb_substr($company, 0, 3) . '%']);
    foreach ($st->fetchAll(PDO::FETCH_COLUMN) as $n) {
        if (outreach_norm_company((string) $n) === $norm) {
            return true;
        }
    }

    return false;
}

/**
 * Записує ліди з джерела (лише AI-релевантні, не виключені, не дублікати).
 *
 * @param list<array<string,mixed>> $leads
 * @return array{added:int,dupes:int,irrelevant:int,excluded:int}
 */
function outreach_store_leads(PDO $pdo, string $sourceKey, string $sourceName, string $leadType, array $leads): array
{
    $stat = ['added' => 0, 'dupes' => 0, 'irrelevant' => 0, 'excluded' => 0];
    $exCountries = array_map('strtoupper', outreach_setting_list($pdo, 'outreach_excluded_countries'));
    $exDomains = outreach_setting_list($pdo, 'outreach_excluded_domains');
    $catalog = outreach_catalog_domains($pdo);
    $ins = $pdo->prepare(
        "INSERT INTO outreach_leads (source_key, source_name, source_url, company_name, company_domain, title, lead_type, country, language,
                                     relevance_score, relevance_method, status, in_catalog, company_website, last_action_at)
         VALUES (:sk, :sn, :su, :cn, :cd, :t, :lt, :c, :l, :rs, :rm, 'new', :ic, :cw, NOW())"
    );
    $seen = [];
    foreach ($leads as $l) {
        $company = trim(mb_substr((string) ($l['company_name'] ?? ''), 0, 190));
        $title = trim(mb_substr((string) ($l['title'] ?? ''), 0, 255));
        if ($company === '') {
            continue;
        }
        $score = outreach_ai_keyword_score($title, (string) ($l['text'] ?? ''), (array) ($l['tags'] ?? []));
        $method = 'keywords';
        if ($score > 0 && $score < OUTREACH_MIN_SCORE + 20) {
            $m = outreach_ai_classify($pdo, $title);
            if ($m !== null) {
                $score = max($score, $m);
                $method = 'model';
            }
        }
        if ($score < OUTREACH_MIN_SCORE) {
            $stat['irrelevant']++;
            continue;
        }
        $website = (string) ($l['company_website'] ?? '');
        $domain = outreach_domain($website);
        if ($domain !== '' && outreach_domain_in($domain, OUTREACH_NOT_COMPANY_DOMAINS)) {
            $website = '';
            $domain = '';
        }
        $country = isset($l['country']) && is_string($l['country']) && preg_match('/^[A-Z]{2}$/', $l['country']) ? $l['country'] : null;
        if (($country !== null && in_array($country, $exCountries, true)) || ($domain !== '' && outreach_domain_in($domain, $exDomains))) {
            $stat['excluded']++;
            continue;
        }
        $key = $domain !== '' ? $domain : outreach_norm_company($company);
        if (isset($seen[$key]) || outreach_is_duplicate($pdo, $domain, $company)) {
            $stat['dupes']++;
            continue;
        }
        $seen[$key] = true;
        $ins->execute([
            ':sk' => $sourceKey, ':sn' => $sourceName, ':su' => mb_substr((string) ($l['source_url'] ?? ''), 0, 500), ':cn' => $company,
            ':cd' => $domain !== '' ? $domain : null, ':t' => $title !== '' ? $title : null, ':lt' => $leadType, ':c' => $country,
            ':l' => isset($l['language']) && in_array($l['language'], ['uk', 'en', 'other'], true) ? $l['language'] : null,
            ':rs' => $score, ':rm' => $method, ':ic' => ($domain !== '' && isset($catalog[$domain])) ? 1 : 0,
            ':cw' => $website !== '' ? mb_substr($website, 0, 500) : null,
        ]);
        $stat['added']++;
    }

    return $stat;
}

// =========================================================================
// Запуск джерел
// =========================================================================

/** @return list<array<string,mixed>> */
function outreach_sources(PDO $pdo): array
{
    return $pdo->query('SELECT * FROM outreach_sources ORDER BY enabled DESC, source_key')->fetchAll(PDO::FETCH_ASSOC);
}

/** Завантажити JSON (з ETag/Last-Modified). null — не змінилось (304); виняток — помилка. */
function outreach_fetch_json(string $url, ?string $etag = null, ?string $lastMod = null, ?array &$meta = null): ?array
{
    $h = [];
    if ($etag !== null && $etag !== '') {
        $h['If-None-Match'] = $etag;
    }
    if ($lastMod !== null && $lastMod !== '') {
        $h['If-Modified-Since'] = $lastMod;
    }
    $r = outreach_http_get($url, $h);
    $meta = $r;
    if ($r['error'] !== null) {
        throw new RuntimeException($r['error']);
    }
    if ($r['status'] === 304) {
        return null;
    }
    if ($r['status'] !== 200) {
        throw new RuntimeException('HTTP ' . $r['status']);
    }
    $j = json_decode($r['body'], true);
    if (!is_array($j)) {
        throw new RuntimeException('некоректний JSON');
    }

    return $j;
}

/**
 * Запустити одне джерело. $force — ігнорувати мінімальний інтервал (кнопка «Запустити зараз» усе одно не
 * частіше разу на годину). Повертає рядок стану.
 */
function outreach_run_source(PDO $pdo, array $src, bool $force = false): string
{
    $key = (string) $src['source_key'];
    if ((int) $src['enabled'] !== 1) {
        return $key . ': вимкнено';
    }
    $interval = $force ? 60 : max(60, (int) $src['min_interval_min']);
    if (!empty($src['last_run_at']) && strtotime((string) $src['last_run_at']) > time() - $interval * 60) {
        return $key . ': ще рано (інтервал ' . $interval . ' хв)';
    }
    $etag = $src['etag'] ?? null;
    $lm = $src['last_modified'] ?? null;
    $meta = null;
    $leads = [];
    $notModified = false;
    try {
        switch ($key) {
            case 'arbeitnow':
                $j = outreach_fetch_json((string) $src['endpoint'], $etag, $lm, $meta);
                $leads = $j === null ? [] : outreach_parse_arbeitnow($j);
                $notModified = $j === null;
                break;
            case 'remoteok':
                $j = outreach_fetch_json((string) $src['endpoint'], $etag, $lm, $meta);
                $leads = $j === null ? [] : outreach_parse_remoteok($j);
                $notModified = $j === null;
                break;
            case 'himalayas':
                $j = outreach_fetch_json((string) $src['endpoint'], $etag, $lm, $meta);
                $leads = $j === null ? [] : outreach_parse_himalayas($j);
                $notModified = $j === null;
                break;
            case 'remotive':
                $j = outreach_fetch_json((string) $src['endpoint'], $etag, $lm, $meta);
                $leads = $j === null ? [] : outreach_parse_remotive($j);
                $notModified = $j === null;
                break;
            case 'weworkremotely':
                $h = array_filter(['If-None-Match' => (string) $etag, 'If-Modified-Since' => (string) $lm]);
                $meta = outreach_http_get((string) $src['endpoint'], $h);
                if ($meta['error'] !== null) {
                    throw new RuntimeException($meta['error']);
                }
                $notModified = $meta['status'] === 304;
                if (!$notModified && $meta['status'] !== 200) {
                    throw new RuntimeException('HTTP ' . $meta['status']);
                }
                $leads = $notModified ? [] : outreach_parse_wwr($meta['body']);
                break;
            case 'hn_hiring':
                $list = outreach_fetch_json((string) $src['endpoint']);
                $id = $list === null ? null : outreach_hn_story_id($list);
                if ($id === null) {
                    throw new RuntimeException('не знайдено свіжий тред «Who is hiring»');
                }
                $item = outreach_fetch_json('https://hn.algolia.com/api/v1/items/' . $id);
                $leads = $item === null ? [] : outreach_parse_hn_item($item);
                break;
            case 'ats_boards':
                foreach (outreach_setting_list($pdo, 'outreach_ats_boards') as $line) {
                    if (preg_match('/^(greenhouse|lever):([a-z0-9_-]{2,60})$/', $line, $m) !== 1) {
                        continue;
                    }
                    usleep(1000000);   // 1 запит на секунду
                    if ($m[1] === 'greenhouse') {
                        $j = outreach_fetch_json('https://boards-api.greenhouse.io/v1/boards/' . $m[2] . '/jobs?content=true');
                        $leads = array_merge($leads, $j === null ? [] : outreach_parse_greenhouse($j, $m[2]));
                    } else {
                        $j = outreach_fetch_json('https://api.lever.co/v0/postings/' . $m[2] . '?mode=json');
                        $leads = array_merge($leads, $j === null ? [] : outreach_parse_lever($j, $m[2]));
                    }
                }
                break;
            default:
                throw new RuntimeException('невідоме джерело');
        }
        $stat = outreach_store_leads($pdo, $key, (string) $src['name'], (string) $src['type'], $leads);
        $msg = $notModified ? 'не змінилось (304)' : sprintf('знайдено %d, нових %d, дублікатів %d, не AI %d, виключено %d', count($leads), $stat['added'], $stat['dupes'], $stat['irrelevant'], $stat['excluded']);
        $pdo->prepare('UPDATE outreach_sources SET last_run_at = NOW(), last_status = :s, last_found = :f, etag = COALESCE(:e, etag), last_modified = COALESCE(:lm, last_modified) WHERE source_key = :k')
            ->execute([':s' => 'OK: ' . $msg, ':f' => $stat['added'], ':e' => $meta['etag'] ?? null, ':lm' => $meta['last_modified'] ?? null, ':k' => $key]);

        return $key . ': ' . $msg;
    } catch (Throwable $e) {
        $pdo->prepare('UPDATE outreach_sources SET last_run_at = NOW(), last_status = :s WHERE source_key = :k')
            ->execute([':s' => 'ПОМИЛКА: ' . mb_substr($e->getMessage(), 0, 400), ':k' => $key]);

        return $key . ': помилка — ' . $e->getMessage();
    }
}

/** Усі ввімкнені джерела (cron). */
function outreach_run_all(PDO $pdo): string
{
    $out = [];
    foreach (outreach_sources($pdo) as $src) {
        if ((int) $src['enabled'] === 1) {
            $out[] = outreach_run_source($pdo, $src);
        }
    }

    return $out === [] ? 'немає ввімкнених джерел' : implode('; ', $out);
}

// =========================================================================
// Ручне додавання й імпорт CSV
// =========================================================================

/**
 * Перевірка й нормалізація одного рядка (ручне додавання / CSV).
 * @return array{0:?array<string,mixed>,1:?string} [лід, помилка]
 */
function outreach_validate_manual(array $in): array
{
    $company = trim(mb_substr(strip_tags((string) ($in['company_name'] ?? '')), 0, 190));
    $website = trim((string) ($in['website'] ?? ''));
    $type = trim((string) ($in['lead_type'] ?? ''));
    $country = strtoupper(trim((string) ($in['country'] ?? '')));
    $lang = strtolower(trim((string) ($in['language'] ?? '')));
    if ($company === '') {
        return [null, 'немає назви компанії'];
    }
    if ($website !== '' && !preg_match('~^https?://~i', $website)) {
        $website = 'https://' . $website;
    }
    if ($website !== '' && (filter_var($website, FILTER_VALIDATE_URL) === false || outreach_domain($website) === '' || !str_contains(outreach_domain($website), '.'))) {
        return [null, 'некоректний сайт: ' . $website];
    }
    if (!in_array($type, OUTREACH_LEAD_TYPES, true)) {
        return [null, 'lead_type має бути job, course або service'];
    }
    if ($country !== '' && preg_match('/^[A-Z]{2}$/', $country) !== 1) {
        return [null, 'country — дволітерний код ISO'];
    }
    if ($lang !== '' && !in_array($lang, ['uk', 'en', 'other'], true)) {
        return [null, 'language — uk, en або other'];
    }

    return [[
        'company_name' => $company, 'company_website' => $website, 'lead_type' => $type, 'country' => $country !== '' ? $country : null,
        'language' => $lang !== '' ? $lang : null, 'notes' => mb_substr(strip_tags((string) ($in['notes'] ?? '')), 0, 2000),
    ], null];
}

/** Додати лід вручну (без оцінки AI-релевантності — адмін сам вирішив). @return string 'ok' | 'duplicate' | 'excluded' */
function outreach_add_manual(PDO $pdo, array $lead, string $sourceKey = 'manual'): string
{
    $domain = outreach_domain((string) $lead['company_website']);
    if (outreach_is_duplicate($pdo, $domain, (string) $lead['company_name'])) {
        return 'duplicate';
    }
    if (($domain !== '' && outreach_domain_in($domain, outreach_setting_list($pdo, 'outreach_excluded_domains')))
        || ($lead['country'] !== null && in_array($lead['country'], array_map('strtoupper', outreach_setting_list($pdo, 'outreach_excluded_countries')), true))) {
        return 'excluded';
    }
    $catalog = outreach_catalog_domains($pdo);
    $pdo->prepare(
        "INSERT INTO outreach_leads (source_key, source_name, company_name, company_domain, lead_type, country, language, relevance_score,
                                     relevance_method, status, in_catalog, company_website, notes, last_action_at)
         VALUES (:sk, :sn, :cn, :cd, :lt, :c, :l, 50, 'manual', 'new', :ic, :cw, :n, NOW())"
    )->execute([
        ':sk' => $sourceKey, ':sn' => $sourceKey === 'csv' ? 'Імпорт CSV' : 'Додано вручну', ':cn' => $lead['company_name'],
        ':cd' => $domain !== '' ? $domain : null, ':lt' => $lead['lead_type'], ':c' => $lead['country'], ':l' => $lead['language'],
        ':ic' => $domain !== '' && isset($catalog[$domain]) ? 1 : 0, ':cw' => $lead['company_website'] !== '' ? $lead['company_website'] : null,
        ':n' => $lead['notes'] !== '' ? $lead['notes'] : null,
    ]);

    return 'ok';
}

/**
 * Імпорт CSV: заголовок company_name, website, lead_type, country, language, notes (порядок колонок — за заголовком).
 * @return array{added:int,duplicates:int,excluded:int,errors:list<string>}
 */
function outreach_import_csv(PDO $pdo, string $csv): array
{
    $res = ['added' => 0, 'duplicates' => 0, 'excluded' => 0, 'errors' => []];
    $csv = preg_replace('/^\xEF\xBB\xBF/', '', $csv) ?? $csv;
    $lines = preg_split('/\r\n|\n|\r/', trim($csv)) ?: [];
    if ($lines === [] || trim($lines[0]) === '') {
        $res['errors'][] = 'порожній файл';

        return $res;
    }
    $delim = substr_count($lines[0], ';') > substr_count($lines[0], ',') ? ';' : ',';
    $head = array_map(static fn($h) => strtolower(trim((string) $h)), str_getcsv($lines[0], $delim, '"', '\\'));
    foreach (['company_name', 'website', 'lead_type'] as $req) {
        if (!in_array($req, $head, true)) {
            $res['errors'][] = 'у заголовку немає колонки ' . $req;
        }
    }
    if ($res['errors'] !== []) {
        return $res;
    }
    foreach (array_slice($lines, 1, 2000) as $i => $line) {
        if (trim($line) === '') {
            continue;
        }
        $cells = str_getcsv($line, $delim, '"', '\\');
        $row = [];
        foreach ($head as $k => $name) {
            $row[$name] = (string) ($cells[$k] ?? '');
        }
        [$lead, $err] = outreach_validate_manual($row);
        if ($err !== null) {
            $res['errors'][] = 'рядок ' . ($i + 2) . ': ' . $err;
            continue;
        }
        $r = outreach_add_manual($pdo, $lead, 'csv');
        if ($r === 'ok') {
            $res['added']++;
        } elseif ($r === 'duplicate') {
            $res['duplicates']++;
        } else {
            $res['excluded']++;
        }
    }

    return $res;
}

// =========================================================================
// «Знайти публічні контакти» — лише ділові адреси й форми
// =========================================================================

/** Чи це ділова роль-адреса (info@, jobs@ …), а не особиста (ім'я.прізвище@). */
function outreach_is_business_email(string $email): bool
{
    $email = strtolower(trim($email));
    if (filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
        return false;
    }
    $local = substr($email, 0, (int) strpos($email, '@'));

    return in_array($local, OUTREACH_ROLE_LOCALS, true);
}

/** Розібрані правила robots.txt для нашого UA або «*»: список заборонених префіксів шляхів. @return list<string> */
function outreach_robots_disallow(string $robots): array
{
    // Групи: кілька рядків User-agent підряд — одна група; правила належать останній групі.
    $groups = [];
    $lastWasAgent = false;
    foreach (preg_split('/\r\n|\n|\r/', $robots) ?: [] as $line) {
        $line = trim(preg_replace('/#.*$/', '', $line) ?? '');
        if ($line === '' || !str_contains($line, ':')) {
            continue;
        }
        [$k, $v] = array_map('trim', explode(':', $line, 2));
        $k = strtolower($k);
        if ($k === 'user-agent') {
            if (!$lastWasAgent || $groups === []) {
                $groups[] = ['agents' => [], 'disallow' => []];
            }
            $groups[count($groups) - 1]['agents'][] = strtolower($v);
            $lastWasAgent = true;
            continue;
        }
        $lastWasAgent = false;
        if ($k === 'disallow' && $groups !== []) {
            $groups[count($groups) - 1]['disallow'][] = $v;
        }
    }
    $mine = [];
    $star = [];
    foreach ($groups as $g) {
        $agents = array_unique($g['agents']);
        foreach ($agents as $a) {
            if ($a !== '' && str_contains(strtolower(OUTREACH_UA), $a) && $a !== '*') {
                $mine = array_merge($mine, $g['disallow']);
            } elseif ($a === '*') {
                $star = array_merge($star, $g['disallow']);
            }
        }
    }
    $rules = $mine !== [] ? $mine : $star;

    return array_values(array_unique(array_filter($rules, static fn($r) => $r !== '')));
}

function outreach_robots_allows(array $disallow, string $path): bool
{
    foreach ($disallow as $rule) {
        $rule = rtrim($rule, '*');
        if ($rule === '/' || ($rule !== '' && str_starts_with($path, $rule))) {
            return false;
        }
    }

    return true;
}

/**
 * Витягнути ділові адреси й посилання на форму контактів зі сторінки.
 * @return array{emails:list<string>,forms:list<string>}
 */
function outreach_extract_contacts(string $html, string $pageUrl, string $domain): array
{
    $emails = [];
    $text = html_entity_decode($html, ENT_QUOTES | ENT_HTML5, 'UTF-8');
    if (preg_match_all('~(?:mailto:)?([a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,})~i', $text, $m)) {
        foreach ($m[1] as $e) {
            $e = strtolower(trim($e, '.'));
            $ed = substr($e, strpos($e, '@') + 1);
            if (!outreach_is_business_email($e)) {
                continue;   // особисті (ім'я.прізвище@…) та інші — ігноруються
            }
            if ($domain !== '' && $ed !== $domain && !str_ends_with($ed, '.' . $domain) && !str_ends_with($domain, '.' . $ed)) {
                continue;   // адреса чужого домену (сервіси, агенції) — не компанії
            }
            $emails[$e] = true;
        }
    }
    $forms = [];
    if (preg_match_all('~<a\s[^>]*href=["\']([^"\'#]+)["\'][^>]*>(.*?)</a>~is', $html, $am, PREG_SET_ORDER)) {
        foreach ($am as $a) {
            $href = trim($a[1]);
            $label = strtolower(strip_tags($a[2]));
            if (preg_match('~contact|partner|kontakt|контакт|співпрац~iu', $href . ' ' . $label) === 1 && !str_starts_with($href, 'mailto:')) {
                $abs = outreach_abs_url($pageUrl, $href);
                if (outreach_domain($abs) === $domain) {
                    $forms[$abs] = true;
                }
            }
        }
    }
    if (preg_match('~<form\b~i', $html) === 1 && preg_match('~contact|partner|контакт~iu', $pageUrl) === 1) {
        $forms[$pageUrl] = true;
    }

    return ['emails' => array_keys($emails), 'forms' => array_slice(array_keys($forms), 0, 5)];
}

/**
 * Пошук публічних контактів компанії ліду: головна + /contact, /partners, /about (≤6 сторінок), 1 запит на секунду,
 * повага до robots.txt, SSRF-захист. Зберігає лише ділову адресу й сторінку контактів.
 *
 * @param callable(int):void|null $sleep для тестів
 * @return array{ok:bool,email:?string,contact_url:?string,message:string}
 */
function outreach_find_contacts(PDO $pdo, int $leadId, ?callable $sleep = null): array
{
    $sleep ??= static fn(int $us) => usleep($us);
    $st = $pdo->prepare('SELECT * FROM outreach_leads WHERE id = :id');
    $st->execute([':id' => $leadId]);
    $lead = $st->fetch(PDO::FETCH_ASSOC);
    if ($lead === false) {
        return ['ok' => false, 'email' => null, 'contact_url' => null, 'message' => 'лід не знайдено'];
    }
    $site = (string) ($lead['company_website'] ?? '');
    $domain = outreach_domain($site);
    if ($domain === '') {
        return ['ok' => false, 'email' => null, 'contact_url' => null, 'message' => 'немає сайту компанії'];
    }
    $root = 'https://' . ($site !== '' && str_contains((string) parse_url($site, PHP_URL_HOST), 'www.') ? 'www.' : '') . $domain;
    $robots = outreach_http_get($root . '/robots.txt', [], 131072);
    $disallow = $robots['error'] === null && $robots['status'] === 200 ? outreach_robots_disallow($robots['body']) : [];
    $emails = [];
    $forms = [];
    $source = null;
    $pages = 0;
    foreach (OUTREACH_CONTACT_PATHS as $path) {
        if (!outreach_robots_allows($disallow, $path)) {
            continue;
        }
        $sleep(1000000);
        $r = outreach_http_get($root . $path, [], OUTREACH_PAGE_MAX_BYTES);
        $pages++;
        if ($r['error'] !== null || $r['status'] !== 200 || stripos($r['content_type'], 'html') === false) {
            continue;
        }
        $c = outreach_extract_contacts($r['body'], $r['final_url'], $domain);
        foreach ($c['emails'] as $e) {
            if (!isset($emails[$e])) {
                $emails[$e] = $r['final_url'];
            }
        }
        foreach ($c['forms'] as $f) {
            $forms[$f] = true;
        }
        if ($path !== '/' && str_contains($path, 'contact') && $c['emails'] === [] && !isset($forms[$r['final_url']])) {
            $forms[$r['final_url']] = true;
        }
    }
    // Пріоритет ролей для партнерства.
    $prio = ['partners', 'partnership', 'partnerships', 'partner', 'hello', 'info', 'contact', 'business', 'sales', 'office', 'team', 'careers', 'jobs', 'hr', 'support', 'admin'];
    $best = null;
    foreach ($prio as $p) {
        foreach (array_keys($emails) as $e) {
            if (str_starts_with($e, $p . '@')) {
                $best = $e;
                break 2;
            }
        }
    }
    $best ??= array_key_first($emails);
    $contactUrl = array_key_first($forms);
    $source = $best !== null ? $emails[$best] : $contactUrl;
    $pdo->prepare('UPDATE outreach_leads SET contact_email = COALESCE(:e, contact_email), contact_url = COALESCE(:u, contact_url),
                   contact_source_url = COALESCE(:s, contact_source_url), contacts_checked_at = NOW(), last_action_at = NOW() WHERE id = :id')
        ->execute([':e' => $best, ':u' => $contactUrl, ':s' => $source, ':id' => $leadId]);

    return ['ok' => $best !== null || $contactUrl !== null, 'email' => $best, 'contact_url' => $contactUrl,
        'message' => sprintf('переглянуто сторінок: %d; ділова адреса: %s; сторінка контактів: %s', $pages, $best ?? '—', $contactUrl ?? '—')];
}

// =========================================================================
// Вибірки для адмінки
// =========================================================================

/** @return array{rows:list<array<string,mixed>>,total:int} */
function outreach_leads_search(PDO $pdo, array $f, int $limit = 200): array
{
    $where = ['1=1'];
    $p = [];
    foreach (['lead_type' => 'type', 'source_key' => 'source', 'country' => 'country', 'language' => 'language', 'status' => 'status'] as $col => $k) {
        $v = trim((string) ($f[$k] ?? ''));
        if ($v !== '') {
            $where[] = "$col = :$k";
            $p[":$k"] = $v;
        }
    }
    if ((int) ($f['min_score'] ?? 0) > 0) {
        $where[] = 'relevance_score >= :ms';
        $p[':ms'] = (int) $f['min_score'];
    }
    $q = trim((string) ($f['q'] ?? ''));
    if ($q !== '') {
        $where[] = "(company_name LIKE :q1 OR company_domain LIKE :q2)";
        $p[':q1'] = '%' . addcslashes($q, '%_\\') . '%';
        $p[':q2'] = $p[':q1'];
    }
    $w = implode(' AND ', $where);
    $cnt = $pdo->prepare("SELECT COUNT(*) FROM outreach_leads WHERE $w");
    $cnt->execute($p);
    $st = $pdo->prepare("SELECT * FROM outreach_leads WHERE $w ORDER BY FIELD(status, 'new') DESC, relevance_score DESC, id DESC LIMIT " . max(1, min(2000, $limit)));
    $st->execute($p);

    return ['rows' => $st->fetchAll(PDO::FETCH_ASSOC), 'total' => (int) $cnt->fetchColumn()];
}

/** Безпечна для таблиць клітинка CSV (без формул). */
function outreach_csv_cell(mixed $v): string
{
    $s = (string) $v;

    return preg_match('/^[=+\-@\t\r]/', $s) === 1 ? "'" . $s : $s;
}
