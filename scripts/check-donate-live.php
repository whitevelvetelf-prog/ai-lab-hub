<?php

declare(strict_types=1);

/**
 * AI LAB HUB — перевірка сторінки донатів «наживо» після релізу (запуск вручну, лише CLI).
 *
 *   php scripts/check-donate-live.php [базова_адреса]
 *   (за замовчуванням https://ailabhub-directory.com)
 *
 * Відкриває /donate.php (UA і EN) та головну й підтверджує:
 *   - є кнопка з посиланням на банку monobank (https, send.monobank.ua / monobank.ua);
 *   - на сторінці немає нічого схожого на номер картки (13–19 цифр);
 *   - у підвалі головної є пункт, що веде на /donate.php.
 * САМЕ ЗНАЧЕННЯ ПОСИЛАННЯ НЕ ДРУКУЄТЬСЯ — лише «є / відсутнє».
 * Код виходу: 0 — усе гаразд, 1 — є проблема.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'https://ailabhub-directory.com', '/');
$fails = 0;

/** GET зі спільним cookie-кошиком (мова зберігається в сесії: ?lang=en ставить її й робить 302). */
function fetch_page(string $url): array
{
    static $jar = null;
    $jar ??= tempnam(sys_get_temp_dir(), 'dnchk');
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_MAXREDIRS => 5,
        CURLOPT_TIMEOUT => 20,
        CURLOPT_COOKIEJAR => $jar,
        CURLOPT_COOKIEFILE => $jar,
        CURLOPT_USERAGENT => 'ailabhub-donate-check/1.0',
    ]);
    $body = curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);

    return [$code, is_string($body) ? $body : ''];
}

function report(bool $ok, string $label): void
{
    global $fails;
    echo ($ok ? '  OK   ' : '  FAIL ') . $label . "\n";
    if (!$ok) {
        $fails++;
    }
}

/** Чи містить HTML посилання-кнопку на банку (значення не повертається). */
function has_jar_link(string $html): bool
{
    return (bool) preg_match('#<a\b[^>]*class="donate-btn"[^>]*href="https://(send\.)?monobank\.ua/[^"\s]+"#i', $html)
        || (bool) preg_match('#<a\b[^>]*href="https://(send\.)?monobank\.ua/[^"\s]+"[^>]*class="donate-btn"#i', $html);
}

/** Чи є в тексті сторінки послідовність, схожа на номер картки. */
function has_card_like(string $html): bool
{
    $text = preg_replace('#<(script|style)\b.*?</\1>#is', ' ', $html) ?? '';
    $text = strip_tags($text);

    return (bool) preg_match('/(?<!\d)(?:\d[ \-\x{00A0}]?){12,18}\d(?!\d)/u', $text);
}

echo "Перевірка донатів: {$base}\n";
foreach (['/donate.php?lang=uk' => 'UA', '/donate.php?lang=en' => 'EN'] as $path => $lang) {
    [$code, $html] = fetch_page($base . $path);
    report($code === 200, "{$lang}: /donate.php відповідає 200 (отримано {$code})");
    report(has_jar_link($html), "{$lang}: посилання на банку monobank — " . (has_jar_link($html) ? 'є' : 'відсутнє'));
    report(!has_card_like($html), "{$lang}: номер картки на сторінці — " . (has_card_like($html) ? 'ЗНАЙДЕНО' : 'не знайдено'));
}
[$code, $home] = fetch_page($base . '/?lang=uk');
report((bool) preg_match('#<a\b[^>]*href="/donate\.php"#', $home), 'головна: пункт «Підтримати проєкт» у підвалі веде на /donate.php');

echo $fails === 0 ? "Усе гаразд.\n" : "Проблем: {$fails}. Відкрийте Кабінет → Донати й перевірте посилання та перемикач.\n";
exit($fails === 0 ? 0 : 1);
