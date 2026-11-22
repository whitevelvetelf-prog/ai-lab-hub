<?php

declare(strict_types=1);

/**
 * AI LAB HUB — соцмережі в підвалі й теги превʼю посилань (Open Graph + Twitter Card).
 *
 * 1. Кнопки соцмереж (social_footer_html, app/footer.php): лише непорожні https-посилання на домен самої мережі з
 *    config/social.php; порожні й заглушки «[…]» приховано. rel="noopener noreferrer", target="_blank",
 *    aria-label мовою інтерфейсу.
 *
 * 2. Превʼю посилань: app/auth.php вмикає буфер виводу (social_meta_begin), а в кінці запиту social_meta_inject()
 *    дописує перед </head> відсутні теги og:type, og:site_name, og:title, og:description, og:url, og:image, og:locale,
 *    og:locale:alternate і twitter:card / twitter:title / twitter:description / twitter:image.
 *    Буфер потрібен, бо <title> і <meta description> сторінки виводяться РАНІШЕ за app/header.php.
 *    • Назва й опис беруться з <title> і <meta name="description"> сторінки. Сторінка може уточнити їх викликом
 *      social_og(['title' => …, 'description' => …, 'image' => …, 'image_large' => bool, 'type' => …]) будь-де до кінця виводу
 *      (product.php, category.php, сторінки оголошень Marketplace).
 *    • Теги, які сторінка вже має (наприклад, blog-post.php), не дублюються.
 *    • og:url — <link rel="canonical"> сторінки, інакше адреса з site_url (config/marketplace*.php) + шлях без службових
 *      параметрів (lang, ref, utm_*, next…). Без site_url тегу og:url немає.
 *    • Опис — не довше 200 символів, без HTML; усі значення екрановано.
 *    • Без тегів: службові й особисті сторінки (кабінет, повідомлення, CRM, вхід, реєстрація, підтвердження пошти, вибране,
 *      форми подачі тощо — SOCIAL_PRIVATE_RE): їм додається meta robots noindex, nofollow, якщо його не було.
 *      Також без тегів будь-яка сторінка з meta robots noindex, результати пошуку (?search=, ?q=), відповідь не 200, не HTML і сторінки Marketplace,
 *      коли розділ не публічний (mp_public_enabled() = false).
 */

const SOCIAL_NETWORKS = [
    'facebook'  => ['Facebook', ['facebook.com', 'www.facebook.com', 'm.facebook.com', 'fb.com']],
    'instagram' => ['Instagram', ['instagram.com', 'www.instagram.com']],
    'telegram'  => ['Telegram', ['t.me']],
    'youtube'   => ['YouTube', ['youtube.com', 'www.youtube.com']],
    'linkedin'  => ['LinkedIn', ['linkedin.com', 'www.linkedin.com']],
    'x'         => ['X', ['x.com', 'twitter.com']],
    'tiktok'    => ['TikTok', ['tiktok.com', 'www.tiktok.com']],
];

/** Сторінки без превʼю (особисті / службові) — за ім'ям скрипта. */
const SOCIAL_PRIVATE_RE = '/^(account|login|login-via-token|logout|register|forgot-password|reset-password|saved|auth-[a-z-]+'
    . '|crm-[a-z-]+|admin-[a-z-]+|apply-[a-z-]+|director-[a-z-]+|asset-account|asset-admin[a-z-]*|asset-post'
    . '|mp-(messages|thread|inbox-admin|message-reports|moderation|legal-admin|list|add-offer|settings|stats|my|favorites|saved'
    . '|notify-settings|seller-settings|verify|verify-email|draft|post|evidence)'
    . '|marketplace-(my|favorites|post)|listing-post|promo-report)\.php$/';

/** @return array{social_links:array<string,string>,og_image:string} */
function social_config(): array
{
    static $cfg = null;
    if ($cfg !== null) {
        return $cfg;
    }
    $file = __DIR__ . '/../config/social.php';
    $raw = is_file($file) ? (static fn(string $f) => require $f)($file) : [];
    $raw = is_array($raw) ? $raw : [];
    $links = is_array($raw['social_links'] ?? null) ? $raw['social_links'] : [];

    return $cfg = ['social_links' => array_map('strval', $links), 'og_image' => (string) ($raw['og_image'] ?? '')];
}

/** Дозволене посилання на мережу $key: https, без логіна/порту, хост мережі. */
function social_link_ok(string $key, string $url): bool
{
    $net = SOCIAL_NETWORKS[$key] ?? null;
    $url = trim($url);
    if ($net === null || $url === '' || strlen($url) > 300 || preg_match('/[\s\x00-\x1F\x7F<>"\']/', $url) === 1) {
        return false;
    }
    $p = parse_url($url);
    if (!is_array($p) || strtolower((string) ($p['scheme'] ?? '')) !== 'https' || isset($p['user']) || isset($p['pass']) || isset($p['port'])) {
        return false;
    }

    return in_array(strtolower((string) ($p['host'] ?? '')), $net[1], true);
}

/** @return array<string,string> [мережа => посилання] лише дозволені, у порядку конфігу */
function social_links(): array
{
    $out = [];
    foreach (social_config()['social_links'] as $key => $url) {
        if (social_link_ok((string) $key, $url)) {
            $out[(string) $key] = trim($url);
        }
    }

    return $out;
}

function social_icon_svg(string $key): string
{
    $paths = [
        'facebook'  => '<path d="M14 8h3V4h-3a4 4 0 0 0-4 4v3H7v4h3v7h4v-7h3l1-4h-4V8.5a.5.5 0 0 1 .5-.5Z"/>',
        'instagram' => '<rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4"/><circle cx="17.5" cy="6.5" r="1"/>',
        'telegram'  => '<path d="M21 4 3 11l6 2 2 6 3-4 5 4 2-15Z"/><path d="m9 13 8-6"/>',
        'youtube'   => '<rect x="2" y="5" width="20" height="14" rx="4"/><path d="m10 9 5 3-5 3V9Z"/>',
        'linkedin'  => '<rect x="3" y="3" width="18" height="18" rx="3"/><path d="M8 10v7M8 7v.01M12 17v-4a2 2 0 0 1 4 0v4M12 10v7"/>',
        'x'         => '<path d="M4 4l16 16M20 4 4 20"/>',
        'tiktok'    => '<path d="M14 3v11a3 3 0 1 1-3-3"/><path d="M14 3a5 5 0 0 0 5 5"/>',
    ];

    return '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false">'
        . ($paths[$key] ?? '') . '</svg>';
}

/** Кнопки соцмереж для підвалу; '' — жодного посилання. */
function social_footer_html(): string
{
    $links = social_links();
    if ($links === []) {
        return '';
    }
    $en = function_exists('current_lang') && current_lang() === 'en';
    $h = '<ul class="site-footer__social" aria-label="' . ($en ? 'AI LAB HUB on social media' : 'AI LAB HUB у соцмережах') . '">';
    foreach ($links as $key => $url) {
        $name = SOCIAL_NETWORKS[$key][0];
        $label = $en ? "AI LAB HUB on {$name} (opens in a new tab)" : "AI LAB HUB у {$name} (відкриється в новій вкладці)";
        $h .= '<li><a class="site-footer__social-link" href="' . htmlspecialchars($url, ENT_QUOTES) . '" target="_blank" rel="noopener noreferrer"'
            . ' aria-label="' . htmlspecialchars($label, ENT_QUOTES) . '" title="' . htmlspecialchars($name, ENT_QUOTES) . '">' . social_icon_svg($key) . '</a></li>';
    }

    return $h . '</ul>';
}

// --- Open Graph / Twitter Card --------------------------------------------------------------------

/** Уточнення превʼю сторінкою (title, description, image — шлях від public/ або https-адреса нашого сайту, type). */
function social_og(array $data): void
{
    $GLOBALS['social_og_override'] = array_merge((array) ($GLOBALS['social_og_override'] ?? []), $data);
}

/** Вимкнути превʼю для поточної сторінки (напр. приховане чи непубліковане оголошення). */
function social_og_off(): void
{
    $GLOBALS['social_og_off'] = true;
}

function social_meta_begin(): void
{
    static $started = false;
    if ($started || PHP_SAPI === 'cli') {
        return;
    }
    $started = true;
    ob_start('social_meta_inject');
}

/** Базова адреса сайту з site_url (https://host) або null. */
function social_site_base(): ?string
{
    $b = function_exists('app_canonical_base') ? app_canonical_base() : null;

    return $b !== null ? $b['scheme'] . '://' . $b['host'] . $b['port'] : null;
}

/** Ім'я поточного скрипта (index.php тощо). */
function social_script(): string
{
    return basename((string) ($_SERVER['SCRIPT_NAME'] ?? $_SERVER['PHP_SELF'] ?? ''));
}

/** Текст з HTML-атрибута/вмісту → звичайний рядок в один рядок. */
function social_plain(string $s): string
{
    $s = html_entity_decode(strip_tags($s), ENT_QUOTES | ENT_HTML5, 'UTF-8');

    return trim((string) preg_replace('/\s+/u', ' ', $s));
}

function social_cut(string $s, int $max): string
{
    if (mb_strlen($s) <= $max) {
        return $s;
    }
    $cut = mb_substr($s, 0, $max - 1);
    $sp = mb_strrpos($cut, ' ');

    return rtrim($sp !== false && $sp > $max * 0.6 ? mb_substr($cut, 0, $sp) : $cut, " ,.;:—-") . '…';
}

/** Абсолютна адреса зображення (лише наш сайт) або null. */
function social_abs_image(string $img, string $base): ?string
{
    $img = trim($img);
    if ($img === '') {
        return null;
    }
    if (preg_match('#^https://#i', $img) === 1) {
        return str_starts_with($img, $base . '/') ? $img : null;
    }

    return preg_match('#^/(?!/)[A-Za-z0-9._/?=&%-]+$#', $img) === 1 ? $base . $img : null;
}

/** Обробник буфера: дописує теги превʼю перед </head>. Будь-яка помилка — вивід без змін. */
function social_meta_inject(string $buffer, int $phase = 0): string
{
    static $done = false;
    if ($done) {
        return $buffer;
    }
    try {
        $pos = stripos($buffer, '</head>');
        if ($pos === false) {
            return $buffer;
        }
        $done = true;
        foreach (headers_list() as $h) {
            if (stripos($h, 'content-type:') === 0 && stripos($h, 'text/html') === false) {
                return $buffer;
            }
        }
        $head = substr($buffer, 0, $pos);
        $script = social_script();
        $hasNoindex = preg_match('/<meta\s+name=["\']robots["\']\s+content=["\'][^"\']*noindex/i', $head) === 1;
        if (preg_match(SOCIAL_PRIVATE_RE, $script) === 1) {
            return $hasNoindex ? $buffer : substr($buffer, 0, $pos) . "<meta name=\"robots\" content=\"noindex, nofollow\">\n" . substr($buffer, $pos);
        }
        $mpPage = preg_match('/^(marketplace|mp-|listing|listings|get)/', $script) === 1;
        // Результати пошуку (?search=, ?q=) — не те, чим діляться: без превʼю (і без чужого тексту в og:title).
        if (isset($_GET['search']) || isset($_GET['q'])) {
            return $buffer;
        }
        if ($hasNoindex || !empty($GLOBALS['social_og_off']) || http_response_code() !== 200
            || ($mpPage && !(function_exists('mp_public_enabled') && mp_public_enabled()))) {
            return $buffer;
        }
        $base = social_site_base();
        if ($base === null) {
            return $buffer;
        }
        $o = (array) ($GLOBALS['social_og_override'] ?? []);
        $en = function_exists('current_lang') && current_lang() === 'en';

        // Назва й опис
        $title = isset($o['title']) ? social_plain((string) $o['title'])
            : (preg_match('#<title[^>]*>(.*?)</title>#is', $head, $m) === 1 ? social_plain($m[1]) : '');
        if ($title === '') {
            $title = 'AI LAB HUB';
        }
        $desc = isset($o['description']) ? social_plain((string) $o['description'])
            : (preg_match('/<meta\s+name=["\']description["\']\s+content=["\']([^"\']*)["\']/i', $head, $m) === 1 ? social_plain($m[1]) : '');
        if ($desc === '') {
            $desc = $en ? 'AI LAB HUB — a catalog of apps and AI tools with descriptions, pricing and links, plus articles and a Marketplace.'
                : 'AI LAB HUB — каталог додатків і сервісів АІ з описами, цінами й посиланнями, статті та Marketplace.';
        }
        $title = social_cut($title, 120);
        $desc = social_cut($desc, 200);

        // Адреса
        $url = null;
        if (preg_match('/<link\s+rel=["\']canonical["\']\s+href=["\'](https?:\/\/[^"\']+)["\']/i', $head, $m) === 1) {
            $url = html_entity_decode($m[1], ENT_QUOTES);
        } else {
            $path = (string) parse_url((string) ($_SERVER['REQUEST_URI'] ?? '/'), PHP_URL_PATH);
            parse_str((string) parse_url((string) ($_SERVER['REQUEST_URI'] ?? ''), PHP_URL_QUERY), $q);
            $q = array_filter($q, static fn($v, $k) => is_string($v) && preg_match('/^(lang|ref|next|olang|fbclid|gclid|utm_[a-z]+|_[a-z]*)$/i', (string) $k) !== 1,
                ARRAY_FILTER_USE_BOTH);
            ksort($q);
            $url = $base . ($path !== '' ? $path : '/') . ($q !== [] ? '?' . http_build_query($q) : '');
        }

        // Зображення
        $cfgImg = social_config()['og_image'];
        $large = false;
        $img = isset($o['image']) ? social_abs_image((string) $o['image'], $base) : null;
        if ($img !== null) {
            $large = !empty($o['image_large']);   // логотип продукту — малий (summary), фото оголошення — велике
        } elseif ($cfgImg !== '' && is_file(dirname(__DIR__) . '/public/' . ltrim($cfgImg, '/'))) {
            $img = social_abs_image('/' . ltrim($cfgImg, '/'), $base);
            $large = true;
        }
        $img ??= $base . '/logo.png';

        $tags = [
            ['property', 'og:type', (string) ($o['type'] ?? 'website')],
            ['property', 'og:site_name', 'AI LAB HUB'],
            ['property', 'og:title', $title],
            ['property', 'og:description', $desc],
            ['property', 'og:url', $url],
            ['property', 'og:image', $img],
            ['property', 'og:locale', $en ? 'en_US' : 'uk_UA'],
            ['property', 'og:locale:alternate', $en ? 'uk_UA' : 'en_US'],
            ['name', 'twitter:card', $large ? 'summary_large_image' : 'summary'],
            ['name', 'twitter:title', $title],
            ['name', 'twitter:description', $desc],
            ['name', 'twitter:image', $img],
        ];
        $add = '';
        foreach ($tags as [$attr, $key, $val]) {
            if (preg_match('/<meta\s+' . $attr . '=["\']' . preg_quote($key, '/') . '["\']/i', $head) === 1) {
                continue;   // сторінка вже має цей тег
            }
            $add .= '<meta ' . $attr . '="' . $key . '" content="' . htmlspecialchars($val, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8') . "\">\n";
        }

        return $add === '' ? $buffer : substr($buffer, 0, $pos) . $add . substr($buffer, $pos);
    } catch (Throwable $e) {
        return $buffer;
    }
}
