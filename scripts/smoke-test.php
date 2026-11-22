<?php

declare(strict_types=1);

/**
 * AI LAB HUB — димовий тест сайту (CLI). Лише GET-запити: без входу, без форм, без POST.
 *
 *   php scripts/smoke-test.php <base_url> --stage=closed|view|open [--delay=1] [--simulate=missing-page|php-error]
 *
 *   base_url   — канонічна адреса сайту: http://ai-lab-hub.test (локально) або https://ailabhub-directory.com (прод)
 *   --stage    — очікуваний стан Marketplace:
 *                  closed — розділ прихований: сторінки Marketplace 404 гостю;
 *                  view   — відкритий для перегляду: marketplace.php 200, блоки, оголошення; форма подачі гостю недоступна;
 *                  open   — подача відкрита: є кнопка подачі, гостя з форми відправляє на вхід.
 *   --delay    — пауза між запитами, с (за замовчуванням 1; дробові дозволені, напр. 0.3 — лише локально)
 *   --simulate — сфабрикований збій для перевірки самого тесту: missing-page (сторінка категорії підмінюється
 *                неіснуючою), php-error (у відповідь головної вписується «Fatal error»).
 *
 * Запити йдуть ЛИШЕ на хост base_url і його варіант www/без www (зовнішні адреси не відкриваються, перенаправлення
 * не виконуються автоматично). User-Agent «AILH-smoke/1.0», тайм-аут 15 с. Значення посилань на банку, токенів,
 * cookie тощо не друкуються — лише «є / відсутнє».
 * Звіт: консоль + storage/smoke-report-РРРРММДД-ГГХХ.txt (поза git). Код виходу 1, якщо є хоч один FAIL.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
if (!function_exists('curl_init')) {
    fwrite(STDERR, "Потрібне розширення PHP curl (scripts/smoke-test.ps1 шукає PHP з php.ini у Laragon).\n");
    exit(2);
}

date_default_timezone_set('Europe/Kyiv');

const UA = 'AILH-smoke/1.0';
const TIMEOUT = 15;
const PHP_ERROR_MARKERS = ['Fatal error', 'Warning:', 'Notice:', 'Parse error', 'Stack trace', 'Deprecated:', 'Uncaught '];

// ---------- аргументи ----------
$base = null;
$stage = null;
$delay = 1.0;
$simulate = '';
foreach (array_slice($argv, 1) as $a) {
    if (str_starts_with($a, '--stage=')) {
        $stage = substr($a, 8);
    } elseif (str_starts_with($a, '--delay=')) {
        $delay = max(0.0, (float) substr($a, 8));
    } elseif (str_starts_with($a, '--simulate=')) {
        $simulate = substr($a, 11);
    } elseif ($base === null && preg_match('~^https?://~i', $a)) {
        $base = rtrim($a, '/');
    }
}
if ($base === null || !in_array($stage, ['closed', 'view', 'open'], true)
    || !in_array($simulate, ['', 'missing-page', 'php-error'], true)) {
    fwrite(STDERR, "Використання: php scripts/smoke-test.php <base_url> --stage=closed|view|open [--delay=1] [--simulate=missing-page|php-error]\n");
    exit(2);
}
$bp = parse_url($base);
$scheme = strtolower($bp['scheme']);
$host = strtolower($bp['host']);
$altHost = str_starts_with($host, 'www.') ? substr($host, 4) : 'www.' . $host;
$isHttps = $scheme === 'https';
$root = dirname(__DIR__);

// ---------- HTTP ----------
$cookieJar = tempnam(sys_get_temp_dir(), 'smk');
$opened = [];          // url => true (усі відкриті сторінки — для перевірки слідів помилок)
$lastRequestAt = 0.0;

/** @return array{code:int, headers:array<string,list<string>>, body:string, url:string, error:string} */
function get(string $url, bool $jar = true): array
{
    global $host, $altHost, $delay, $lastRequestAt, $cookieJar;
    $h = strtolower((string) parse_url($url, PHP_URL_HOST));
    if ($h !== $host && $h !== $altHost) {
        return ['code' => 0, 'headers' => [], 'body' => '', 'url' => $url, 'error' => 'зовнішня адреса не відкривається'];
    }
    $wait = $delay - (microtime(true) - $lastRequestAt);
    if ($wait > 0) {
        usleep((int) ($wait * 1e6));
    }
    $headers = [];
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_FOLLOWLOCATION => false,
        CURLOPT_TIMEOUT        => TIMEOUT,
        CURLOPT_CONNECTTIMEOUT => TIMEOUT,
        CURLOPT_USERAGENT      => UA,
        CURLOPT_HTTPGET        => true,
        CURLOPT_ENCODING       => '',
        CURLOPT_HEADERFUNCTION => static function ($ch, string $line) use (&$headers): int {
            $p = strpos($line, ':');
            if ($p !== false) {
                $headers[strtolower(trim(substr($line, 0, $p)))][] = trim(substr($line, $p + 1));
            }
            return strlen($line);
        },
    ]);
    if ($jar) {
        curl_setopt($ch, CURLOPT_COOKIEJAR, $cookieJar);
        curl_setopt($ch, CURLOPT_COOKIEFILE, $cookieJar);
    }
    $body = curl_exec($ch);
    $err = $body === false ? curl_error($ch) : '';
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);
    $lastRequestAt = microtime(true);
    return ['code' => $code, 'headers' => $headers, 'body' => is_string($body) ? $body : '', 'url' => $url, 'error' => $err];
}

function u(string $path): string
{
    global $base;
    return $base . '/' . ltrim($path, '/');
}

/** GET сторінки сайту з обліком для перевірки слідів помилок PHP. */
function page(string $path): array
{
    global $opened, $simulate;
    $r = get(u($path));
    if ($simulate === 'php-error' && ($path === '' || $path === '/')) {
        $r['body'] .= "\n<b>Fatal error</b>: smoke simulate";
    }
    $opened[$path] = $r;
    return $r;
}

/** «М'який 404»: сторінка відповідає 200, але заголовок каже «не знайдено». */
function soft404(string $html): bool
{
    return preg_match('~<(?:h1|title)[^>]*>[^<]*(?:не знайдено|not found)~iu', $html) === 1;
}

// ---------- результати ----------
$results = [];   // [status, name, reason]
function check(bool $ok, string $name, string $reason = ''): bool
{
    global $results;
    $results[] = [$ok ? 'PASS' : 'FAIL', $name, $ok ? '' : $reason];
    return $ok;
}
function skip(string $name, string $reason): void
{
    global $results;
    $results[] = ['SKIP', $name, $reason];
}
function why(array $r): string
{
    return $r['error'] !== '' ? 'помилка запиту: ' . $r['error'] : 'HTTP ' . $r['code'];
}
function hdr(array $r, string $name): string
{
    return implode(', ', $r['headers'][strtolower($name)] ?? []);
}
function title_of(string $html): string
{
    return preg_match('~<title[^>]*>(.*?)</title>~is', $html, $m) === 1 ? trim(html_entity_decode(strip_tags($m[1]))) : '';
}
/** @return list<int> id продуктів з карток результатів у порядку показу */
function product_ids(string $html): array
{
    preg_match_all('~href="(?:/)?product\.php\?id=(\d+)~', $html, $m);
    return array_values(array_unique(array_map('intval', $m[1])));
}
function card_names(string $html): array
{
    preg_match_all('~class="product-card__name"[^>]*>\s*([^<]+)~u', $html, $m);
    return array_map(static fn ($s) => trim(html_entity_decode($s)), $m[1]);
}
function found_count(string $html): ?int
{
    return preg_match('~(?:Знайдено|Found):\s*(\d+)~u', $html, $m) === 1 ? (int) $m[1] : null;
}
function local_markers(string $file, string $rx): ?int
{
    global $root;
    $p = $root . '/' . $file;
    return is_file($p) ? preg_match_all($rx, (string) file_get_contents($p)) : null;
}

$started = date('Y-m-d H:i:s');

// ========== 1. Головна ==========
$home = page('/');
check($home['code'] === 200, 'Головна: 200', why($home));
$t = title_of($home['body']);
check($t !== '', 'Головна: є <title>', 'порожній або відсутній <title>');
check(preg_match('~<h1[\s>]~i', $home['body']) === 1 || $t !== '', 'Головна: є заголовок сторінки', 'немає <h1> і <title>');

// ========== 2. Пошук ==========
$s = page('catalog.php?search=' . rawurlencode('Midjourney'));
$names = card_names($s['body']);
check($s['code'] === 200 && ($names[0] ?? '') !== '' && mb_strtolower($names[0]) === 'midjourney',
    'Пошук «Midjourney»: Midjourney першим', $s['code'] !== 200 ? why($s) : 'перший результат: ' . ($names[0] ?? '(немає)'));

$sv = page('catalog.php?search=' . rawurlencode('відео'));
$se = page('catalog.php?search=' . rawurlencode('video'));
$idsUa = product_ids($sv['body']);
$idsEn = product_ids($se['body']);
check($sv['code'] === 200 && $idsUa !== [], 'Пошук «відео»: непорожньо', $sv['code'] !== 200 ? why($sv) : 'немає результатів');
check($se['code'] === 200 && $idsEn !== [], 'Пошук «video»: непорожньо', $se['code'] !== 200 ? why($se) : 'немає результатів');
if ($idsUa !== [] && $idsEn !== []) {
    $common = count(array_intersect($idsUa, $idsEn));
    $share = $common / min(count($idsUa), count($idsEn));
    check($share >= 0.3, sprintf('Пошук «відео» і «video»: значна частина збігається (%d з %d, %.0f%%)', $common, min(count($idsUa), count($idsEn)), $share * 100),
        sprintf('спільних лише %d з %d на першій сторінці (< 30%%)', $common, min(count($idsUa), count($idsEn))));
}

$sai = page('catalog.php?search=' . rawurlencode('ШІ'));
$nAi = found_count($sai['body']);
$catLinks = preg_match_all('~href="(?:/)?(?:category\.php\?id=|catalog\.php\?(?:sub)?category=)\d+~', $sai['body']);
$idsAi = product_ids($sai['body']);
check($sai['code'] === 200 && $idsAi !== [], 'Пошук «ШІ»: є релевантні продукти', $sai['code'] !== 200 ? why($sai) : 'немає продуктів');
check($catLinks > 0, 'Пошук «ШІ»: є посилання на категорії', 'на сторінці немає посилань на категорії');
// «Не весь каталог»: лічильник знайденого менший за верхню межу видачі пошуку (500 — стеля SEARCH, див. app/search.php).
check($nAi === null || $nAi < 500, 'Пошук «ШІ»: не весь каталог' . ($nAi !== null ? " (знайдено {$nAi})" : ''),
    "знайдено {$nAi} — схоже на весь каталог");

// ========== 3. Категорія → підкатегорія → продукт ==========
preg_match('~href="(?:/)?(category\.php\?id=\d+)"~', $home['body'], $m);
$catPath = $m[1] ?? '';
if ($simulate === 'missing-page') {
    $catPath = 'category.php?id=987654321';   // сфабрикована відсутня сторінка
}
if ($catPath === '') {
    check(false, 'Сторінка категорії', 'на головній немає посилання category.php?id=');
} else {
    $cat = page($catPath);
    check($cat['code'] === 200 && preg_match('~<h1[\s>]~i', $cat['body']) === 1 && !soft404($cat['body']), "Сторінка категорії ({$catPath}): 200 і заголовок",
        soft404($cat['body']) ? 'HTTP ' . $cat['code'] . ', але сторінка «не знайдено» (мʼякий 404)' : why($cat));
    preg_match('~href="(?:/)?(catalog\.php\?subcategory=\d+)~', $cat['body'], $m);
    $subPath = $m[1] ?? '';
    if ($subPath === '') {
        check(false, 'Сторінка підкатегорії', 'на сторінці категорії немає посилання catalog.php?subcategory=');
    } else {
        $sub = page($subPath);
        check($sub['code'] === 200 && product_ids($sub['body']) !== [], "Сторінка підкатегорії ({$subPath}): 200 і продукти", $sub['code'] !== 200 ? why($sub) : 'немає продуктів');
        $pid = product_ids($sub['body'])[0] ?? 0;
        if ($pid > 0) {
            $prod = page("product.php?id={$pid}");
            check($prod['code'] === 200 && preg_match('~<h1[\s>]~i', $prod['body']) === 1 && !soft404($prod['body']), "Сторінка продукту (product.php?id={$pid}): 200 і заголовок", why($prod));
        } else {
            check(false, 'Сторінка продукту', 'у підкатегорії немає посилань product.php?id=');
        }
    }
}

// ========== 4. Донати, Еля, англійська ==========
$don = page('donate.php');
$hasJar = preg_match('~href="https://(?:send\.)?monobank\.ua/jar/[A-Za-z0-9]+~', $don['body']) === 1;
check($don['code'] === 200 && $hasJar, 'Донати: є посилання на банку (значення не друкується)', $don['code'] !== 200 ? why($don) : 'посилання на банку відсутнє');

$eli = page('eli.php');
check($eli['code'] === 200, 'Сторінка Елі: 200', why($eli));

$en = page('?lang=en');
if (in_array($en['code'], [301, 302, 303], true) && hdr($en, 'location') !== '') {
    // мова зберігається в сесії, адреса очищується перенаправленням — один перехід у межах сайту
    $loc = hdr($en, 'location');
    $en = page(preg_match('~^https?://~i', $loc) === 1 ? substr($loc, strlen($base) + 1) : ltrim($loc, '/'));
}
$enOk = preg_match('~<html[^>]+lang="en"~i', $en['body']) === 1;
$enWords = preg_match('~\b(Search|Categories|Catalog|Marketplace|Support the project)\b~', $en['body']) === 1;
check($en['code'] === 200 && $enOk && $enWords, 'Англійський інтерфейс (?lang=en): lang="en" і англійські рядки',
    $en['code'] !== 200 ? why($en) : ($enOk ? 'немає англійських рядків меню' : 'html lang не en'));
page('?lang=uk');   // повертаємо мову сесії тесту

// ========== 5. Канонічна адреса ==========
$canon = $base . '/';
if ($isHttps) {
    foreach (['http://' . $host . '/', 'http://' . $altHost . '/', 'https://' . $altHost . '/'] as $variant) {
        $r = get($variant, false);
        $loc = hdr($r, 'location');
        $oneHop = in_array($r['code'], [301, 308], true) && rtrim($loc, '/') . '/' === $canon;
        $final = $oneHop ? get($loc, false) : null;
        check($oneHop && $final !== null && $final['code'] === 200, "Перенаправлення {$variant} → {$canon} за один крок",
            $r['code'] === 0 ? why($r) : "HTTP {$r['code']}" . ($loc !== '' ? ' → ' . $loc : '') . ($final !== null ? ", далі HTTP {$final['code']}" : ''));
    }
} else {
    skip('Перенаправлення http→https і www/без www', 'base_url без https (локальний сайт)');
}

// ========== 6. Marketplace за режимом ==========
$aiMarkers = local_markers('docs/ai_statement_uk.md', '~\[ПІДТВЕРДИТИ~u');
$rulesMarkers = local_markers('docs/marketplace_rules_uk.md', '~\[(?!MP_[A-Z_]+\])[^\]\r\n]*\](?!\()|ЧЕРНЕТКА~u');

if ($stage === 'closed') {
    // Прихований розділ має дві форми: не розгорнуто (config public_enabled = false) — 404;
    // розгорнуто, але вимкнено перемикачем у кабінеті (site_settings.marketplace_public = 0) — сторінка «Скоро»
    // (200, noindex, без оголошень і форм). Старі адреси (301 на marketplace.php) проходяться один раз у межах сайту.
    foreach (['marketplace.php', 'marketplace-solutions.php', 'listings.php', 'marketplace-post.php', 'mp-rules.php'] as $p) {
        $r = page($p);
        $via = '';
        if (in_array($r['code'], [301, 302, 307, 308], true)) {
            $loc = hdr($r, 'location');
            $lh = strtolower((string) parse_url($loc, PHP_URL_HOST));
            if ($loc !== '' && ($lh === '' || $lh === $host || $lh === $altHost)) {
                $via = ' → ' . $loc;
                $r = page(preg_match('~^https?://~i', $loc) === 1 ? (string) preg_replace('~^https?://[^/]+/?~i', '', $loc) : ltrim($loc, '/'));
            }
        }
        $soon = $r['code'] === 200
            && preg_match('~<meta\s+name="robots"\s+content="[^"]*noindex~i', $r['body']) === 1
            && preg_match('~href="(?:/)?(?:marketplace-offer|listing)\.php\?id=\d+~', $r['body']) === 0
            && preg_match('~<textarea|name="(?:title|description|price[a-z_]*)"~i', $r['body']) === 0;   // без полів форми подачі
        $form = $r['code'] === 404 ? '404' : ($soon ? '«Скоро» (вимкнено перемикачем)' : '');
        check($form !== '', "closed: {$p}{$via} — прихований для гостя" . ($form !== '' ? " ({$form})" : ''),
            why($r) . ($r['code'] === 200 ? ' — сторінка з вмістом Marketplace' : ''));
    }
} else {
    $mp = page('marketplace.php');
    check($mp['code'] === 200, "{$stage}: marketplace.php — 200", why($mp));
    $blocks = preg_match_all('~href="(?:/)?marketplace-category\.php\?id=\d+~', $mp['body']);
    check($blocks > 0, "{$stage}: блоки категорій на marketplace.php ({$blocks})", 'немає посилань marketplace-category.php?id=');
    preg_match('~href="(?:/)?((?:marketplace-offer|listing)\.php\?id=\d+)~', $mp['body'], $m);
    if (($m[1] ?? '') !== '') {
        $lp = page($m[1]);
        check($lp['code'] === 200, "{$stage}: сторінка оголошення ({$m[1]}) — 200", why($lp));
    } else {
        check(false, "{$stage}: сторінка оголошення", 'на marketplace.php немає посилань на оголошення');
    }
    foreach (['marketplace-post.php', 'listing-post.php?type=job'] as $p) {
        $r = page($p);
        $loc = hdr($r, 'location');
        $toLogin = (in_array($r['code'], [301, 302, 303, 307], true) && str_contains($loc, 'login.php'))
            || ($r['code'] === 401 && str_contains($r['body'], 'login.php'));
        if ($stage === 'open') {
            check($toLogin, "open: {$p} — гостя відправляє на вхід", "HTTP {$r['code']}" . ($loc !== '' ? ' → ' . $loc : ''));
        } else {
            check($r['code'] !== 200 || $toLogin, "view: {$p} — форма подачі гостю недоступна", "HTTP {$r['code']} — форма відкрита гостю");
        }
    }
    if ($stage === 'open') {
        $btn = preg_match('~href="(?:/)?(?:marketplace-post|listing-post)\.php~', $mp['body']) === 1;
        check($btn, 'open: на marketplace.php є кнопка подачі', 'немає посилання marketplace-post.php / listing-post.php');
    }
    // Сторінки з маркерами (за локальними файлами docs/): поки є маркери — 404, без маркерів — 200.
    foreach ([['mp-rules.php', $rulesMarkers, 'docs/marketplace_rules_uk.md'], ['ai-statement.php', $aiMarkers, 'docs/ai_statement_uk.md']] as [$p, $n, $f]) {
        $r = page($p);
        if ($n === null) {
            skip("{$stage}: {$p}", "немає локального {$f}, очікування невідоме");
        } elseif ($n > 0) {
            check($r['code'] === 404, "{$stage}: {$p} — 404, поки в {$f} є маркери ({$n})", why($r));
        } else {
            $ok = $r['code'] === 200 || (in_array($r['code'], [301, 302], true) && hdr($r, 'location') !== '');
            check($ok, "{$stage}: {$p} — відкрита (маркерів у {$f} немає)", why($r));
        }
    }
    // noindex на сторінках пошуку з фільтрами
    if ($blocks > 0 && preg_match('~href="(?:/)?(marketplace-category\.php\?id=\d+)~', $mp['body'], $m) === 1) {
        $fp = $m[1] . '&q=smoke';
        $r = page($fp);
        $noindex = preg_match('~<meta\s+name="robots"\s+content="[^"]*noindex~i', $r['body']) === 1 || str_contains(strtolower(hdr($r, 'x-robots-tag')), 'noindex');
        check($r['code'] === 200 && $noindex, "{$stage}: пошук із фільтрами ({$fp}) — meta robots noindex", $r['code'] !== 200 ? why($r) : 'немає noindex');
    }
}

// ========== 7. Закриті шляхи ==========
foreach (['config/database.php', 'config/', 'docs/', 'database/', 'hosting-upload/', 'marketplace-seed/', 'scripts/',
    'storage/', 'backups/', '.git/config', '_check-env.php', '_session-check.php', 'uploads/marketplace/', 'config/marketplace.local.php'] as $p) {
    $r = get(u($p), false);
    check(in_array($r['code'], [403, 404], true), "Закрито: /{$p} — 403/404", why($r));
}

// ========== 8. Заголовки ==========
foreach (['login.php' => 'вхід', 'mp-verify-email.php' => 'підтвердження пошти', 'account.php' => 'кабінет'] as $p => $label) {
    $r = page($p);
    $cc = strtolower(hdr($r, 'cache-control'));
    check(str_contains($cc, 'no-store'), "Cache-Control no-store: {$p} ({$label})", $cc === '' ? 'заголовка немає' : 'є, але без no-store');
}
$lr = get(u('login.php'), false);
$sess = '';
foreach ($lr['headers']['set-cookie'] ?? [] as $c) {
    if (preg_match('~^(PHPSESSID|[A-Za-z_]*sess[A-Za-z_]*)=~i', $c) === 1) {
        $sess = $c;
        break;
    }
}
if ($sess === '') {
    check(false, 'Cookie сесії на login.php', 'Set-Cookie сесії відсутній');
} else {
    $flags = strtolower($sess);
    check(str_contains($flags, 'httponly'), 'Cookie сесії: HttpOnly', 'немає HttpOnly');
    check(str_contains($flags, 'samesite=lax'), 'Cookie сесії: SameSite=Lax', 'немає SameSite=Lax');
    if ($isHttps) {
        check(str_contains($flags, 'secure'), 'Cookie сесії: Secure (HTTPS)', 'немає Secure');
    } else {
        skip('Cookie сесії: Secure', 'base_url без https');
    }
}

// ========== 9. Сліди помилок PHP на всіх відкритих сторінках ==========
$bad = [];
foreach ($opened as $p => $r) {
    foreach (PHP_ERROR_MARKERS as $mk) {
        if (str_contains($r['body'], $mk)) {
            $bad[] = ($p === '/' ? '/' : $p) . ' («' . $mk . '»)';
            break;
        }
    }
}
check($bad === [], 'Немає слідів помилок PHP на ' . count($opened) . ' відкритих сторінках', 'знайдено: ' . implode('; ', $bad));

@unlink($cookieJar);

// ---------- звіт ----------
$counts = ['PASS' => 0, 'FAIL' => 0, 'SKIP' => 0];
$lines = [];
$lines[] = "AILH smoke-test {$started} — {$base} — stage={$stage}" . ($simulate !== '' ? " — SIMULATE={$simulate}" : '');
$lines[] = str_repeat('-', 78);
foreach ($results as [$st, $name, $reason]) {
    $counts[$st]++;
    $lines[] = sprintf('%-4s %s%s', $st, $name, $reason !== '' ? ' — ' . $reason : '');
}
$lines[] = str_repeat('-', 78);
$lines[] = sprintf('Разом: PASS %d, FAIL %d, SKIP %d', $counts['PASS'], $counts['FAIL'], $counts['SKIP']);
$text = implode("\n", $lines) . "\n";
fwrite(STDOUT, $text);

$dir = $root . '/storage';
if (is_dir($dir) || @mkdir($dir, 0750, true)) {
    $file = $dir . '/smoke-report-' . date('Ymd-Hi') . '.txt';
    if (@file_put_contents($file, $text, FILE_APPEND) !== false) {
        fwrite(STDOUT, 'Звіт: storage/' . basename($file) . "\n");
    }
}
exit($counts['FAIL'] > 0 ? 1 : 0);
