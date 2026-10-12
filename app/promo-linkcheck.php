<?php

declare(strict_types=1);

/**
 * AI LAB HUB — перевірка адрес переходу рекламних креативів (блок G).
 *
 * PromoLinkChecker::check() відкриває адресу так, як її відкриє відвідувач, і
 * повертає статус, кінцеву адресу й прапорці для модератора. Викликається:
 *   * при надсиланні креативу на модерацію й при кожній зміні адреси
 *     (promo_save_campaign → promo_linkcheck_creative);
 *   * cron: активні креативи щодоби, решта — щотижня (promo_linkcheck_due).
 *
 * Захист від SSRF (сервер не повинен ходити у внутрішню мережу на прохання
 * рекламодавця):
 *   * лише http/https і порти 80/443, без логіна/пароля в URL;
 *   * перед з'єднанням хост розв'язується, і ВСІ його адреси мають бути
 *     публічними (відкидаються loopback, приватні, link-local, CGNAT, службові,
 *     multicast, IPv4-mapped IPv6 тощо — PROMO_BLOCKED_CIDRS);
 *   * cURL отримує перевірену адресу через CURLOPT_RESOLVE (без повторного DNS —
 *     захист від DNS rebinding), після з'єднання CURLINFO_PRIMARY_IP перевіряється
 *     ще раз;
 *   * редиректи не виконуються автоматично: кожен Location перевіряється так само,
 *     не більше PROMO_LINK_MAX_REDIRECTS;
 *   * тайм-аути, обмеження розміру відповіді, власний User-Agent.
 *
 * Safe Browsing — змінний провайдер (PromoSafeBrowsingProvider), налаштування в
 * config/promo.php → 'safe_browsing' => ['provider' => 'off'|'safe_browsing'|'web_risk', 'api_key' => ''].
 *   УВАГА: Google Safe Browsing Lookup API (v4) призначений для НЕКОМЕРЦІЙНОГО
 *   використання. Для комерційного використання (а реклама — комерційна) Google
 *   пропонує Web Risk API. Умови й ціни слід перевірити на сайті Google
 *   (cloud.google.com/web-risk) перед вибором провайдера.
 * Без ключа перевірка має статус skipped, а модератор бачить попередження.
 */

require_once __DIR__ . '/promo.php';

const PROMO_LINK_MAX_REDIRECTS = 5;
const PROMO_LINK_TIMEOUT = 6;
const PROMO_LINK_CONNECT_TIMEOUT = 4;
const PROMO_LINK_MAX_BYTES = 262144;
const PROMO_LINK_USER_AGENT = 'AILabHub-LinkCheck/1.0 (+https://ailabhub-directory.com/promo-rules.php)';
/** Скільки перевірок поспіль із помилкою/не-2xx ставлять креатив на повторну модерацію. */
const PROMO_LINK_FAIL_LIMIT = 3;

/** Заборонені діапазони адрес (SSRF). */
const PROMO_BLOCKED_CIDRS = [
    '0.0.0.0/8', '10.0.0.0/8', '100.64.0.0/10', '127.0.0.0/8', '169.254.0.0/16', '172.16.0.0/12',
    '192.0.0.0/24', '192.0.2.0/24', '192.88.99.0/24', '192.168.0.0/16', '198.18.0.0/15', '198.51.100.0/24',
    '203.0.113.0/24', '224.0.0.0/4', '240.0.0.0/4', '255.255.255.255/32',
    '::/128', '::1/128', '::ffff:0:0/96', '64:ff9b::/96', '100::/64', '2001::/23', '2001:db8::/32',
    '2002::/16', 'fc00::/7', 'fe80::/10', 'fec0::/10', 'ff00::/8',
];

/** Відомі бренди для пошуку IDN-підробок (punycode, схожий на бренд). */
const PROMO_LOOKALIKE_BRANDS = [
    'google', 'youtube', 'gmail', 'apple', 'icloud', 'microsoft', 'outlook', 'office', 'paypal', 'facebook',
    'instagram', 'whatsapp', 'telegram', 'amazon', 'netflix', 'binance', 'coinbase', 'privatbank', 'monobank',
    'diia', 'openai', 'chatgpt', 'anthropic', 'claude', 'github', 'linkedin', 'twitter', 'tiktok', 'ailabhub',
];

/** Список скорочувачів за замовчуванням (адмін редагує в ad_settings.shortener_domains). */
const PROMO_DEFAULT_SHORTENERS = "bit.ly\ntinyurl.com\nt.co\ngoo.gl\now.ly\nis.gd\nbuff.ly\ncutt.ly\nrebrand.ly\nshorturl.at\nt.ly\ntiny.cc\nrb.gy\nbitly.com\ns.id\nclck.ru\nv.gd\nlnkd.in\nshort.io\nqr.ae";

// --- Адреси -------------------------------------------------------------------

function promo_ip_in_cidr(string $ip, string $cidr): bool
{
    [$net, $bits] = explode('/', $cidr);
    $ipBin = @inet_pton($ip);
    $netBin = @inet_pton($net);
    if ($ipBin === false || $netBin === false || strlen($ipBin) !== strlen($netBin)) {
        return false;
    }
    $bits = (int) $bits;
    $bytes = intdiv($bits, 8);
    if (substr($ipBin, 0, $bytes) !== substr($netBin, 0, $bytes)) {
        return false;
    }
    $rest = $bits % 8;
    if ($rest === 0) {
        return true;
    }
    $mask = (0xFF << (8 - $rest)) & 0xFF;

    return (ord($ipBin[$bytes]) & $mask) === (ord($netBin[$bytes]) & $mask);
}

/** Публічна адреса, до якої дозволено з'єднання. */
function promo_ip_is_public(string $ip): bool
{
    if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
        return false;
    }
    foreach (PROMO_BLOCKED_CIDRS as $cidr) {
        if (promo_ip_in_cidr($ip, $cidr)) {
            return false;
        }
    }

    return true;
}

/**
 * Усі адреси хоста (A і AAAA). IP-літерал повертається як є.
 *
 * @return list<string>
 */
function promo_resolve_host(string $host): array
{
    $host = trim($host, '[]');
    if (filter_var($host, FILTER_VALIDATE_IP) !== false) {
        return [$host];
    }
    $ips = [];
    $v4 = @gethostbynamel($host);
    if (is_array($v4)) {
        $ips = $v4;
    }
    $v6 = @dns_get_record($host, DNS_AAAA);
    if (is_array($v6)) {
        foreach ($v6 as $r) {
            if (!empty($r['ipv6'])) {
                $ips[] = (string) $r['ipv6'];
            }
        }
    }

    return array_values(array_unique($ips));
}

/** Хост без www. і крапки в кінці, у нижньому регістрі. */
function promo_norm_host(string $host): string
{
    $host = rtrim(strtolower(trim($host, '[]')), '.');

    return str_starts_with($host, 'www.') ? substr($host, 4) : $host;
}

/** Домен або будь-який батьківський домен є у списку. */
function promo_host_in_list(string $host, array $list): ?string
{
    $host = promo_norm_host($host);
    foreach ($list as $d) {
        $d = promo_norm_host((string) $d);
        if ($d !== '' && ($host === $d || str_ends_with($host, '.' . $d))) {
            return $d;
        }
    }

    return null;
}

/** IDN (punycode) хост, схожий на відомий бренд → назва бренду. */
function promo_idn_lookalike(string $host): ?string
{
    $host = promo_norm_host($host);
    if (!str_contains($host, 'xn--')) {
        return null;
    }
    $unicode = function_exists('idn_to_utf8') ? (string) @idn_to_utf8($host, IDNA_DEFAULT, INTL_IDNA_VARIANT_UTS46) : $host;
    // Грубий «скелет»: кирилиця/грецька, схожа на латиницю, і діакритика → латиниця.
    $map = ['а' => 'a', 'е' => 'e', 'о' => 'o', 'р' => 'p', 'с' => 'c', 'у' => 'y', 'х' => 'x', 'і' => 'i', 'ї' => 'i', 'ј' => 'j',
        'ԁ' => 'd', 'ѕ' => 's', 'ɡ' => 'g', 'һ' => 'h', 'к' => 'k', 'м' => 'm', 'т' => 't', 'в' => 'b', 'н' => 'h', 'ο' => 'o',
        'α' => 'a', 'ρ' => 'p', 'ν' => 'v', 'τ' => 't', 'ι' => 'i', 'ӏ' => 'l', '0' => 'o', '1' => 'l'];
    $skeleton = strtr(mb_strtolower($unicode), $map);
    if (function_exists('transliterator_transliterate')) {
        $skeleton = (string) transliterator_transliterate('Any-Latin; Latin-ASCII', $skeleton);
    }
    foreach (PROMO_LOOKALIKE_BRANDS as $brand) {
        if (str_contains($skeleton, $brand)) {
            return $brand;
        }
    }

    return null;
}

// --- Safe Browsing ------------------------------------------------------------

interface PromoSafeBrowsingProvider
{
    public function name(): string;

    /** @return array{status:string,notes:string} status: ok | flagged | unknown | skipped */
    public function check(string $url): array;
}

/** Перевірку вимкнено (немає ключа або обрано 'off'). */
final class PromoSafeBrowsingDisabled implements PromoSafeBrowsingProvider
{
    public function __construct(private string $why = 'Safe Browsing вимкнено (немає ключа в config/promo.php)')
    {
    }

    public function name(): string
    {
        return 'off';
    }

    public function check(string $url): array
    {
        return ['status' => 'skipped', 'notes' => $this->why];
    }
}

/** Спільний HTTP-клієнт для API Google (фіксовані хости Google, не адреса рекламодавця). */
abstract class PromoGoogleApiProvider implements PromoSafeBrowsingProvider
{
    protected const THREATS = ['MALWARE', 'SOCIAL_ENGINEERING', 'UNWANTED_SOFTWARE'];

    public function __construct(protected string $apiKey)
    {
    }

    /** @return array{0:int,1:?array} HTTP-код і розібраний JSON */
    protected function request(string $url, ?array $jsonBody = null): array
    {
        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_TIMEOUT => 8,
            CURLOPT_CONNECTTIMEOUT => 4,
            CURLOPT_PROTOCOLS => CURLPROTO_HTTPS,
            CURLOPT_USERAGENT => PROMO_LINK_USER_AGENT,
            CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
        ]);
        if ($jsonBody !== null) {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, (string) json_encode($jsonBody));
        }
        $body = curl_exec($ch);
        $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
        curl_close($ch);
        $data = is_string($body) ? json_decode($body, true) : null;

        return [$code, is_array($data) ? $data : null];
    }
}

/**
 * Google Safe Browsing Lookup API v4 (threatMatches:find).
 * Некомерційне використання — див. примітку на початку файлу.
 */
final class PromoGoogleSafeBrowsing extends PromoGoogleApiProvider
{
    public function name(): string
    {
        return 'safe_browsing';
    }

    public function check(string $url): array
    {
        [$code, $data] = $this->request(
            'https://safebrowsing.googleapis.com/v4/threatMatches:find?key=' . rawurlencode($this->apiKey),
            [
                'client' => ['clientId' => 'ailabhub', 'clientVersion' => '1.0'],
                'threatInfo' => [
                    'threatTypes' => self::THREATS,
                    'platformTypes' => ['ANY_PLATFORM'],
                    'threatEntryTypes' => ['URL'],
                    'threatEntries' => [['url' => $url]],
                ],
            ]
        );
        if ($code !== 200 || $data === null) {
            return ['status' => 'unknown', 'notes' => 'Safe Browsing: HTTP ' . $code];
        }
        if (!empty($data['matches'])) {
            $types = array_unique(array_map(static fn($m) => (string) ($m['threatType'] ?? '?'), $data['matches']));

            return ['status' => 'flagged', 'notes' => 'Safe Browsing: ' . implode(', ', $types)];
        }

        return ['status' => 'ok', 'notes' => 'Safe Browsing: загроз не знайдено'];
    }
}

/** Google Web Risk Lookup API (uris:search) — для комерційного використання. */
final class PromoGoogleWebRisk extends PromoGoogleApiProvider
{
    public function name(): string
    {
        return 'web_risk';
    }

    public function check(string $url): array
    {
        $q = 'uri=' . rawurlencode($url) . '&key=' . rawurlencode($this->apiKey);
        foreach (self::THREATS as $t) {
            $q .= '&threatTypes=' . $t;
        }
        [$code, $data] = $this->request('https://webrisk.googleapis.com/v1/uris:search?' . $q);
        if ($code !== 200 || $data === null) {
            return ['status' => 'unknown', 'notes' => 'Web Risk: HTTP ' . $code];
        }
        if (!empty($data['threat']['threatTypes'])) {
            return ['status' => 'flagged', 'notes' => 'Web Risk: ' . implode(', ', (array) $data['threat']['threatTypes'])];
        }

        return ['status' => 'ok', 'notes' => 'Web Risk: загроз не знайдено'];
    }
}

/** Провайдер за config/promo.php. */
function promo_safe_browsing_provider(): PromoSafeBrowsingProvider
{
    $file = __DIR__ . '/../config/promo.php';
    $raw = is_file($file) ? require $file : [];
    $sb = is_array($raw) && is_array($raw['safe_browsing'] ?? null) ? $raw['safe_browsing'] : [];
    $provider = (string) ($sb['provider'] ?? 'off');
    $key = trim((string) ($sb['api_key'] ?? ''));
    if ($provider === 'off' || $key === '') {
        return new PromoSafeBrowsingDisabled();
    }

    return match ($provider) {
        'safe_browsing' => new PromoGoogleSafeBrowsing($key),
        'web_risk' => new PromoGoogleWebRisk($key),
        default => new PromoSafeBrowsingDisabled('Невідомий провайдер «' . $provider . '» у config/promo.php'),
    };
}

// --- Перевірка ----------------------------------------------------------------

final class PromoLinkChecker
{
    /** @param list<string> $shorteners @param list<string> $blocklist */
    public function __construct(
        private PromoSafeBrowsingProvider $safeBrowsing,
        private array $shorteners = [],
        private array $blocklist = [],
    ) {
    }

    /**
     * Перевірити адресу. $declaredHost — домен, заявлений рекламодавцем (зазвичай
     * хост самої адреси); $baselineHost — кінцевий домен попередньої успішної
     * перевірки (для виявлення підміни).
     *
     * @return array{url:string,final_url:?string,final_host:?string,http_status:?int,redirect_count:int,
     *               response_ms:int,safe_browsing_status:string,flags:list<string>,notes:list<string>,error:bool,blocked:bool}
     */
    public function check(string $url, ?string $baselineHost = null): array
    {
        $r = [
            'url' => $url, 'final_url' => null, 'final_host' => null, 'http_status' => null, 'redirect_count' => 0,
            'response_ms' => 0, 'safe_browsing_status' => 'skipped', 'flags' => [], 'notes' => [], 'error' => false, 'blocked' => false,
        ];
        $declared = parse_url($url, PHP_URL_HOST);
        $declared = is_string($declared) ? promo_norm_host($declared) : '';
        $started = microtime(true);
        $current = $url;
        $hops = [];

        for ($i = 0; $i <= PROMO_LINK_MAX_REDIRECTS; $i++) {
            $hop = $this->fetch($current);
            $hops[] = $hop;
            if ($hop['error'] !== null) {
                $r['error'] = true;
                $r['blocked'] = $hop['blocked'];
                $r['notes'][] = $hop['error'];
                $r['flags'][] = $hop['blocked'] ? 'ssrf_blocked' : 'fetch_error';
                break;
            }
            $r['http_status'] = $hop['status'];
            $r['final_url'] = $current;
            $r['final_host'] = promo_norm_host((string) parse_url($current, PHP_URL_HOST));
            if ($hop['status'] >= 300 && $hop['status'] < 400 && $hop['location'] !== null) {
                if ($i === PROMO_LINK_MAX_REDIRECTS) {
                    $r['error'] = true;
                    $r['flags'][] = 'too_many_redirects';
                    $r['notes'][] = 'Більше ' . PROMO_LINK_MAX_REDIRECTS . ' переадресацій';
                    break;
                }
                $current = $this->resolveLocation($current, $hop['location']);
                $r['redirect_count']++;
                continue;
            }
            break;
        }
        $r['response_ms'] = (int) round((microtime(true) - $started) * 1000);

        if (!$r['error'] && ($r['http_status'] === null || $r['http_status'] < 200 || $r['http_status'] >= 300)) {
            $r['flags'][] = 'non_2xx';
        }
        if ($r['final_host'] !== null && $declared !== '' && $r['final_host'] !== $declared) {
            $r['flags'][] = 'host_differs';
            $r['notes'][] = 'Кінцевий домен ' . $r['final_host'] . ' ≠ заявлений ' . $declared;
        }
        if ($baselineHost !== null && $baselineHost !== '' && $r['final_host'] !== null && $r['final_host'] !== promo_norm_host($baselineHost)) {
            $r['flags'][] = 'final_host_changed';
            $r['notes'][] = 'Кінцевий домен змінився: був ' . $baselineHost . ', тепер ' . $r['final_host'];
        }
        $hosts = array_filter([$declared, $r['final_host']]);
        foreach ($hops as $h) {
            if ($h['host'] !== '') {
                $hosts[] = $h['host'];
            }
        }
        $hosts = array_values(array_unique($hosts));
        foreach ($hosts as $h) {
            if (($s = promo_host_in_list($h, $this->shorteners)) !== null) {
                $r['flags'][] = 'shortener';
                $r['notes'][] = 'Скорочувач посилань: ' . $s;
            }
            if (($b = promo_host_in_list($h, $this->blocklist)) !== null) {
                $r['flags'][] = 'blocklisted';
                $r['notes'][] = 'Домен у чорному списку: ' . $b;
            }
            if (str_contains($h, 'xn--')) {
                $brand = promo_idn_lookalike($h);
                $r['flags'][] = $brand !== null ? 'idn_lookalike' : 'idn';
                $r['notes'][] = 'IDN/punycode: ' . $h . ($brand !== null ? ' (схоже на «' . $brand . '»)' : '');
            }
        }

        if (!$r['blocked']) {
            $sb = $this->safeBrowsing->check($r['final_url'] ?? $url);
            $r['safe_browsing_status'] = $sb['status'];
            $r['notes'][] = $sb['notes'];
            if ($sb['status'] === 'flagged') {
                $r['flags'][] = 'safe_browsing';
            }
        }
        $r['flags'] = array_values(array_unique($r['flags']));

        return $r;
    }

    /**
     * Один запит без автоматичних редиректів, з перевіркою адрес до й після з'єднання.
     *
     * @return array{status:int,location:?string,host:string,error:?string,blocked:bool}
     */
    private function fetch(string $url): array
    {
        $fail = static fn(string $msg, bool $blocked = false, string $host = ''): array => ['status' => 0, 'location' => null, 'host' => $host, 'error' => $msg, 'blocked' => $blocked];

        $p = parse_url($url);
        $scheme = strtolower((string) ($p['scheme'] ?? ''));
        $host = isset($p['host']) ? strtolower(trim((string) $p['host'], '[]')) : '';
        if (!in_array($scheme, ['http', 'https'], true) || $host === '') {
            return $fail('Недозволена схема або адреса: ' . mb_substr($url, 0, 200), true);
        }
        if (isset($p['user']) || isset($p['pass'])) {
            return $fail('Логін/пароль в адресі заборонені', true, $host);
        }
        $port = isset($p['port']) ? (int) $p['port'] : ($scheme === 'https' ? 443 : 80);
        if (!in_array($port, [80, 443], true)) {
            return $fail('Недозволений порт ' . $port, true, $host);
        }
        if ($host === 'localhost' || preg_match('/\.(localhost|local|internal|lan|home|intranet|corp)$/', $host)) {
            return $fail('Внутрішній домен ' . $host, true, $host);
        }
        $ips = promo_resolve_host($host);
        if ($ips === []) {
            return $fail('Домен ' . $host . ' не розв’язується (DNS)', false, $host);
        }
        foreach ($ips as $ip) {
            if (!promo_ip_is_public($ip)) {
                return $fail('Адреса ' . $host . ' веде в непублічну мережу (' . $ip . ')', true, $host);
            }
        }
        $pin = $ips[0];

        $received = 0;
        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_FOLLOWLOCATION => false,
            CURLOPT_PROTOCOLS => CURLPROTO_HTTP | CURLPROTO_HTTPS,
            CURLOPT_TIMEOUT => PROMO_LINK_TIMEOUT,
            CURLOPT_CONNECTTIMEOUT => PROMO_LINK_CONNECT_TIMEOUT,
            CURLOPT_USERAGENT => PROMO_LINK_USER_AGENT,
            CURLOPT_HTTPHEADER => ['Accept: text/html,application/xhtml+xml,*/*;q=0.8'],
            CURLOPT_HEADER => false,
            CURLOPT_SSL_VERIFYPEER => true,
            CURLOPT_SSL_VERIFYHOST => 2,
            // Фіксуємо перевірену адресу: cURL не робить власного DNS-запиту (DNS rebinding).
            CURLOPT_RESOLVE => [$host . ':' . $port . ':' . (str_contains($pin, ':') ? '[' . $pin . ']' : $pin)],
            CURLOPT_WRITEFUNCTION => static function ($ch, string $chunk) use (&$received): int {
                $received += strlen($chunk);

                return $received > PROMO_LINK_MAX_BYTES ? 0 : strlen($chunk); // 0 → обрив передачі
            },
        ]);
        $headers = [];
        curl_setopt($ch, CURLOPT_HEADERFUNCTION, static function ($ch, string $line) use (&$headers): int {
            $headers[] = $line;

            return strlen($line);
        });
        curl_exec($ch);
        $errno = curl_errno($ch);
        $status = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
        $primary = (string) curl_getinfo($ch, CURLINFO_PRIMARY_IP);
        curl_close($ch);

        if ($primary !== '' && !promo_ip_is_public($primary)) {
            return $fail('З’єднання з непублічною адресою ' . $primary, true, $host);
        }
        // CURLE_WRITE_ERROR (23) — це наш обрив після ліміту розміру, відповідь уже отримано.
        if ($errno !== 0 && $errno !== 23 && $status === 0) {
            return $fail('Помилка з’єднання з ' . $host . ' (cURL ' . $errno . ')', false, $host);
        }
        $location = null;
        foreach ($headers as $line) {
            if (stripos($line, 'Location:') === 0) {
                $location = trim(substr($line, 9));
            }
        }

        return ['status' => $status, 'location' => $location !== '' ? $location : null, 'host' => promo_norm_host($host), 'error' => null, 'blocked' => false];
    }

    /** Відносний Location → абсолютна адреса. */
    private function resolveLocation(string $base, string $location): string
    {
        if (preg_match('~^[a-z][a-z0-9+.-]*:~i', $location)) {
            return $location;
        }
        $b = parse_url($base);
        $origin = $b['scheme'] . '://' . $b['host'] . (isset($b['port']) ? ':' . $b['port'] : '');
        if (str_starts_with($location, '//')) {
            return $b['scheme'] . ':' . $location;
        }
        if (str_starts_with($location, '/')) {
            return $origin . $location;
        }
        $dir = isset($b['path']) ? preg_replace('~/[^/]*$~', '/', $b['path']) : '/';

        return $origin . $dir . $location;
    }
}

// --- Збереження й події -------------------------------------------------------

/** Журнал подій реклами (автопауза, перевірки, рішення з підтвердженням). */
function promo_log_event(PDO $pdo, string $event, ?int $creativeId, ?int $campaignId, string $details, ?int $userId = null): void
{
    try {
        $pdo->prepare(
            'INSERT INTO promo_event_log (created_at, event, creative_id, campaign_id, user_id, details)
             VALUES (:t, :e, :cr, :c, :u, :d)'
        )->execute([':t' => promo_utc_now(), ':e' => $event, ':cr' => $creativeId, ':c' => $campaignId, ':u' => $userId, ':d' => mb_substr($details, 0, 2000)]);
    } catch (Throwable $e) {
        error_log('[promo] event log: ' . $e->getMessage());
    }
}

/** Список скорочувачів з ad_settings (рядок на домен). @return list<string> */
function promo_shortener_list(PDO $pdo): array
{
    $raw = promo_setting($pdo, 'shortener_domains', PROMO_DEFAULT_SHORTENERS);

    return array_values(array_filter(array_map(static fn($l) => promo_norm_host(trim($l)), preg_split('/[\r\n,]+/', $raw) ?: [])));
}

/** @return list<string> */
function promo_domain_blocklist(PDO $pdo): array
{
    try {
        return array_map('strval', $pdo->query('SELECT domain FROM ad_domain_blocklist')->fetchAll(PDO::FETCH_COLUMN));
    } catch (Throwable $e) {
        return [];
    }
}

function promo_link_checker(PDO $pdo): PromoLinkChecker
{
    return new PromoLinkChecker(promo_safe_browsing_provider(), promo_shortener_list($pdo), promo_domain_blocklist($pdo));
}

/**
 * Перевірити адресу креативу й записати результат у ad_link_checks та ad_creatives
 * (link_check_status, link_checked_at, link_fail_streak; link_final_host — базовий
 * кінцевий домен, оновлюється лише під час модерації/зміни адреси, не в cron).
 *
 * @param bool $setBaseline true — нова адреса чи модерація: кінцевий домен стає базовим
 * @return array результат PromoLinkChecker::check + 'status' (ok|flagged) + 'check_id'
 */
function promo_linkcheck_creative(PDO $pdo, int $creativeId, bool $setBaseline): array
{
    $st = $pdo->prepare('SELECT id, destination_url, link_final_host, link_fail_streak FROM ad_creatives WHERE id = :id');
    $st->execute([':id' => $creativeId]);
    $cr = $st->fetch();
    if ($cr === false || trim((string) $cr['destination_url']) === '') {
        return ['status' => 'skipped', 'flags' => [], 'notes' => ['Адреси переходу немає'], 'check_id' => null];
    }

    $r = promo_link_checker($pdo)->check((string) $cr['destination_url'], $setBaseline ? null : ($cr['link_final_host'] ?: null));
    $r['status'] = $r['flags'] === [] ? 'ok' : 'flagged';
    $failed = $r['error'] || in_array('non_2xx', $r['flags'], true);
    $streak = $failed ? (int) $cr['link_fail_streak'] + 1 : 0;

    $pdo->prepare(
        'INSERT INTO ad_link_checks (creative_id, checked_at, url, final_url, final_host, http_status, redirect_count,
             response_ms, safe_browsing_status, flags, notes)
         VALUES (:cr, :t, :url, :fu, :fh, :hs, :rc, :ms, :sb, :fl, :n)'
    )->execute([
        ':cr' => $creativeId, ':t' => promo_utc_now(), ':url' => mb_substr($r['url'], 0, 500),
        ':fu' => $r['final_url'] !== null ? mb_substr($r['final_url'], 0, 1000) : null, ':fh' => $r['final_host'],
        ':hs' => $r['http_status'], ':rc' => $r['redirect_count'], ':ms' => $r['response_ms'],
        ':sb' => $r['safe_browsing_status'], ':fl' => implode(',', $r['flags']), ':n' => mb_substr(implode("\n", $r['notes']), 0, 2000),
    ]);
    $r['check_id'] = (int) $pdo->lastInsertId();

    $pdo->prepare(
        'UPDATE ad_creatives SET link_check_status = :s, link_checked_at = :t, link_fail_streak = :fs'
        . ($setBaseline ? ', link_final_host = :fh' : '') . ' WHERE id = :id'
    )->execute([':s' => $r['status'], ':t' => promo_utc_now(), ':fs' => $streak, ':id' => $creativeId]
        + ($setBaseline ? [':fh' => $r['final_host']] : []));
    $r['fail_streak'] = $streak;

    return $r;
}

/** Остання перевірка креативу або null. */
function promo_last_link_check(PDO $pdo, int $creativeId): ?array
{
    try {
        $st = $pdo->prepare('SELECT * FROM ad_link_checks WHERE creative_id = :c ORDER BY id DESC LIMIT 1');
        $st->execute([':c' => $creativeId]);
        $row = $st->fetch();

        return $row === false ? null : $row;
    } catch (Throwable $e) {
        return null;
    }
}

/** Людські назви прапорців для модератора. */
const PROMO_LINK_FLAG_LABELS = [
    'non_2xx' => 'відповідь не 2xx',
    'fetch_error' => 'сторінка не відкривається',
    'ssrf_blocked' => 'адреса веде у внутрішню мережу / заборонена',
    'too_many_redirects' => 'забагато переадресацій',
    'host_differs' => 'кінцевий домен відрізняється від заявленого',
    'final_host_changed' => 'кінцевий домен змінився після схвалення',
    'shortener' => 'скорочувач посилань',
    'idn' => 'IDN/punycode-домен',
    'idn_lookalike' => 'IDN-домен, схожий на відомий бренд',
    'blocklisted' => 'домен у чорному списку',
    'safe_browsing' => 'Safe Browsing / Web Risk: небезпечна сторінка',
];

/**
 * Повторні перевірки (cron): активні креативи раз на добу, решта схвалених —
 * раз на тиждень ($scope = 'active' | 'other'). Автопауза кампанії зі статусом
 * «потребує повторної модерації» (кампанія pending_review, креатив pending,
 * stop_reason='link_check'), якщо: кінцевий домен змінився; Safe Browsing/Web
 * Risk повернув flagged; PROMO_LINK_FAIL_LIMIT перевірок поспіль — помилка чи
 * не-2xx. Події — у promo_event_log і листи (promo_notify, блок I).
 *
 * @return array{checked:int,paused:int}
 */
function promo_linkcheck_due(PDO $pdo, string $scope, int $limit = 200): array
{
    $sql = $scope === 'active'
        ? "SELECT cr.id, cr.campaign_id FROM ad_creatives cr JOIN ad_campaigns c ON c.id = cr.campaign_id
           WHERE c.format = 'video' AND cr.status = 'approved' AND c.status = 'active' AND cr.destination_url <> ''
             AND (cr.link_checked_at IS NULL OR cr.link_checked_at < :before)
           ORDER BY cr.link_checked_at LIMIT " . $limit
        : "SELECT cr.id, cr.campaign_id FROM ad_creatives cr JOIN ad_campaigns c ON c.id = cr.campaign_id
           WHERE c.format = 'video' AND cr.status IN ('approved', 'pending', 'suspended') AND c.status NOT IN ('active', 'completed', 'expired')
             AND cr.destination_url <> '' AND (cr.link_checked_at IS NULL OR cr.link_checked_at < :before)
           ORDER BY cr.link_checked_at LIMIT " . $limit;
    $before = gmdate('Y-m-d H:i:s', time() - ($scope === 'active' ? 20 * 3600 : 6 * 86400));
    $st = $pdo->prepare($sql);
    $st->execute([':before' => $before]);
    $rows = $st->fetchAll();

    $checked = 0;
    $paused = 0;
    foreach ($rows as $row) {
        $cid = (int) $row['id'];
        $campaignId = (int) $row['campaign_id'];
        $r = promo_linkcheck_creative($pdo, $cid, false);
        $checked++;
        promo_log_event($pdo, 'link_recheck', $cid, $campaignId, $r['status'] . ': ' . implode(', ', $r['flags']));

        $reasons = [];
        if (in_array('final_host_changed', $r['flags'], true)) {
            $reasons[] = 'кінцевий домен змінився';
        }
        if ($r['safe_browsing_status'] === 'flagged') {
            $reasons[] = 'Safe Browsing / Web Risk позначив сторінку як небезпечну';
        }
        if (in_array('blocklisted', $r['flags'], true)) {
            $reasons[] = 'домен у чорному списку';
        }
        if (($r['fail_streak'] ?? 0) >= PROMO_LINK_FAIL_LIMIT) {
            $reasons[] = PROMO_LINK_FAIL_LIMIT . ' перевірки поспіль — помилка або не-2xx';
        }
        if ($reasons !== [] && promo_link_autopause($pdo, $cid, $campaignId, implode('; ', $reasons))) {
            $paused++;
        }
    }

    return ['checked' => $checked, 'paused' => $paused];
}

/** Автопауза через перевірку посилання → повторна модерація. true — статус змінено. */
function promo_link_autopause(PDO $pdo, int $creativeId, int $campaignId, string $reason): bool
{
    $pdo->beginTransaction();
    try {
        $c = $pdo->prepare("UPDATE ad_campaigns SET status = 'pending_review', stop_reason = 'link_check', submitted_at = :t
                            WHERE id = :id AND format = 'video' AND status IN ('active', 'paused')");
        $c->execute([':t' => promo_utc_now(), ':id' => $campaignId]);
        $pdo->prepare("UPDATE ad_creatives SET status = 'pending', recheck_reason = :r WHERE id = :id AND status IN ('approved', 'suspended', 'pending')")
            ->execute([':r' => mb_substr($reason, 0, 255), ':id' => $creativeId]);
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        error_log('[promo] autopause: ' . $e->getMessage());

        return false;
    }
    if ($c->rowCount() === 0) {
        return false;
    }
    promo_log_event($pdo, 'link_autopause', $creativeId, $campaignId, $reason);
    promo_event_notify($pdo, 'link_autopause', ['campaign_id' => $campaignId, 'creative_id' => $creativeId, 'reason' => $reason]);

    return true;
}
