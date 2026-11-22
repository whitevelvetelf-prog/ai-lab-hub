<?php

declare(strict_types=1);

/**
 * AI LAB HUB — e2e оголошень платформи (scripts/mp-seed-promos.php, app/mp-platform-promo.php).
 *
 *   php tests/mp-promos-e2e.php [http://ai-lab-hub.test]
 *
 * Передумова: php scripts/mp-seed-promos.php --apply (P1, P2 опубліковані, P4 — чернетка).
 * Тимчасові записи (оголошення з недозволеними адресами, прострочене, з HTML у назві; тестові користувачі й рядок
 * ad_house_signups) створюються тут і видаляються за id у finally. Оголошення P1/P2/P4 не змінюються.
 */

$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
$root = dirname(__DIR__);
/** @var PDO $pdo */
$pdo = require $root . '/config/database.php';
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
require_once $root . '/app/acquisition.php';
require_once $root . '/app/mp-platform-promo.php';

$pass = 0;
$fail = 0;
function check(bool $cond, string $label): void
{
    global $pass, $fail;
    $cond ? $pass++ : $fail++;
    echo ($cond ? '  PASS ' : '  FAIL ') . $label . "\n";
}

function http(string $jar, string $url, ?array $post = null): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true, CURLOPT_HEADER => true, CURLOPT_FOLLOWLOCATION => false,
        CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 60,
        CURLOPT_USERAGENT => 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) e2e-test',
    ]);
    if ($post !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
    }
    $raw = (string) curl_exec($ch);
    $hs = (int) curl_getinfo($ch, CURLINFO_HEADER_SIZE);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);
    preg_match('/^Location:\s*(\S+)/mi', substr($raw, 0, $hs), $m);

    return ['code' => $code, 'loc' => $m[1] ?? '', 'body' => substr($raw, $hs)];
}

function csrf_in(string $html): string
{
    return preg_match('/name="csrf" value="([^"]+)"/', $html, $m) === 1 ? $m[1] : '';
}

/** Сторінка в окремому процесі PHP з мовою $lang у сесії; повертає [html, кількість звернень до API перекладу]. */
function render_cli(string $root, string $page, array $get, string $lang): array
{
    $tmp = tempnam(sys_get_temp_dir(), 'mpp');
    $wrap = $tmp . '.php';
    $cnt = $tmp . '.cnt';
    file_put_contents($wrap, '<?php
$_SERVER["REQUEST_METHOD"] = "GET"; $_SERVER["HTTP_HOST"] = "ai-lab-hub.test"; $_SERVER["REQUEST_URI"] = "/' . $page . '";
$_SERVER["HTTP_USER_AGENT"] = "Mozilla/5.0 e2e-cli";
$_GET = ' . var_export($get, true) . ';
session_start(); $_SESSION["lang"] = ' . var_export($lang, true) . ';
register_shutdown_function(static function () { file_put_contents(' . var_export($cnt, true) . ', (string) (int) ($GLOBALS["translation_api_calls"] ?? 0)); });
chdir(' . var_export($root . '/public', true) . ');
require ' . var_export($root . '/public/' . $page, true) . ';
');
    $html = (string) shell_exec(escapeshellarg(PHP_BINARY) . ' ' . escapeshellarg($wrap) . ' 2>&1');
    $calls = is_file($cnt) ? (int) file_get_contents($cnt) : -1;
    @unlink($wrap);
    @unlink($cnt);
    @unlink($tmp);

    return [$html, $calls];
}

function tile_count(string $html, string $name): ?int
{
    return preg_match('~direction-card__name">' . preg_quote($name, '~') . '</span><span class="direction-card__count">(\d+)~u', $html, $m) === 1 ? (int) $m[1] : null;
}

$ids = [];
foreach ($pdo->query("SELECT slug, id, status FROM mp_listings WHERE slug LIKE 'platform-%'")->fetchAll(PDO::FETCH_ASSOC) as $r) {
    $ids[$r['slug']] = (int) $r['id'];
}
if (!isset($ids['platform-free-materials'], $ids['platform-account-benefits'], $ids['platform-post-free'])) {
    fwrite(STDERR, "Спершу: php scripts/mp-seed-promos.php --apply\n");
    exit(2);
}
[$p1, $p2, $p4] = [$ids['platform-free-materials'], $ids['platform-account-benefits'], $ids['platform-post-free']];

$tmpDir = sys_get_temp_dir() . '/mpp_' . bin2hex(random_bytes(4));
@mkdir($tmpDir);
$jarG = $tmpDir . '/g.txt';
$jarU = $tmpDir . '/u.txt';
$jarR = $tmpDir . '/r.txt';
$stamp = date('His') . random_int(100, 999);
$created = ['listings' => [], 'users' => []];
$cache = $root . '/storage/cache/mp-tree-counts.json';

/** Тимчасове оголошення платформи в «Іншому» з заданими адресою, назвою й строком. */
$tempListing = static function (string $url, string $title, string $expiresSql = 'NOW() + INTERVAL 1 DAY') use ($pdo, &$created): int {
    $pdo->exec("INSERT INTO mp_listings (section, post_form, seller_id, status, pricing_model, price_type, delivery_type, delivery_url, source_lang,
                  work_format, service_scope, published_at, expires_at) VALUES ('other', 'ad', 1, 'published', 'free', 'free', 'link', "
        . $pdo->quote($url) . ", 'uk', 'online', 'worldwide', NOW(), $expiresSql)");
    $id = (int) $pdo->lastInsertId();
    $created['listings'][] = $id;
    $pdo->prepare("INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, is_auto) VALUES (:id, 'uk', :t, 'тест', 0)")
        ->execute([':id' => $id, ':t' => $title]);
    $pdo->prepare('INSERT INTO mp_listing_categories (listing_id, category_id) VALUES (:id, 16)')->execute([':id' => $id]);

    return $id;
};

try {
    echo "Модульно: адреса кнопки й ref\n";
    check(mpp_cta_href('/register.php?ref=mp-free-materials') === '/register.php?ref=mp-free-materials', 'відносна /register.php?ref=… приймається');
    check(mpp_cta_href('https://ailabhub-directory.com/register.php?ref=mp-post') === '/register.php?ref=mp-post', 'абсолютна адреса живого сайту → відносна');
    foreach (['https://evil.com/register.php', 'http://ailabhub-directory.com/register.php', '//evil.com/register.php', 'javascript:alert(1)',
                 '/account.php', '/register.php?ref=<x>', 'register.php', '/register.php/../admin.php', 'https://ailabhub-directory.com@evil.com/register.php'] as $bad) {
        check(mpp_cta_href($bad) === null, 'відхилено: ' . $bad);
    }
    check(preg_match(ACQ_REF_PATTERN, 'mp-free-materials') === 1 && preg_match(ACQ_REF_PATTERN, 'mp-account-benefits') === 1
        && preg_match(ACQ_REF_PATTERN, 'house-A1') === 1, 'ref mp-… і house-… проходять валідацію');
    check(preg_match(ACQ_REF_PATTERN, 'mp-' . str_repeat('x', 18)) === 0 && preg_match(ACQ_REF_PATTERN, 'evil') === 0
        && preg_match(ACQ_REF_PATTERN, 'mp-x y') === 0, 'задовгий / чужий / з пробілом ref відхиляється');

    echo "Головна Marketplace (гість, uk)\n";
    @unlink($cache);
    $live = static function (string $section) use ($pdo): int {
        return (int) $pdo->query("SELECT COUNT(*) FROM mp_listings l WHERE l.section = " . $pdo->quote($section) . " AND l.status = 'published'
            AND (l.expires_at > NOW() OR (l.section = 'solution' AND l.post_form = '' AND l.expires_at IS NULL)) AND COALESCE(l.slug, '') NOT LIKE 'platform-%'")->fetchColumn();
    };
    $r = http($jarG, "$base/marketplace.php");
    check($r['code'] === 200, 'marketplace.php 200');
    check(tile_count($r['body'], 'Інше') === 2, 'блок «Інше» показано, лічильник 2 (P1 + P2, чернетку P4 не враховано)');
    check(tile_count($r['body'], 'Вакансії') === $live('job'), 'лічильник «Вакансії» без змін (' . $live('job') . ')');
    check(tile_count($r['body'], 'Курси та навчання') === $live('course'), 'лічильник «Курси» без змін (' . $live('course') . ')');
    check(tile_count($r['body'], 'Готові рішення') === $live('solution'), 'лічильник «Готові рішення» без змін (' . $live('solution') . ')');

    echo "Сторінка P1 (гість, uk)\n";
    $r = http($jarG, "$base/marketplace-offer.php?id=$p1");
    $b = $r['body'];
    check($r['code'] === 200, 'P1 200');
    check(str_contains($b, '<h1 class="mp-title">Безкоштовні шаблони, чеклісти й скрипти: потрібен лише акаунт</h1>'), 'український заголовок');
    check(str_contains($b, '<meta name="robots" content="noindex, follow">'), 'meta robots noindex, follow');
    check(str_contains($b, 'mp-card__tag--platform">Від AI LAB HUB'), 'позначка «Від AI LAB HUB»');
    check(preg_match('~<a class="mp-btn mp-btn--primary mp-btn--lg" href="/register.php\?ref=mp-free-materials">Створити акаунт</a>~u', $b) === 1, 'кнопка «Створити акаунт» → /register.php?ref=mp-free-materials');
    check(!str_contains($b, 'mpContactBtn') && !str_contains($b, 'mp-note--disclaimer'), 'без «Показати контакт» і без застереження про угоду між сторонами');
    check(str_contains($b, 'Ліцензію вказано біля кожного матеріалу') && str_contains($b, '«Шаблон баг-репорту з прикладами»'), 'функції й реальні приклади матеріалів');
    check(substr_count($b, 'register.php?ref=') === 1, 'одне посилання-кнопка на реєстрацію');

    echo "Сторінка P2 і чернетка P4\n";
    $r = http($jarG, "$base/marketplace-offer.php?id=$p2");
    check($r['code'] === 200 && str_contains($r['body'], 'href="/register.php?ref=mp-account-benefits">Створити акаунт'), 'P2: кнопка з ref=mp-account-benefits');
    $r = http($jarG, "$base/marketplace-offer.php?id=$p4");
    check($r['code'] === 404 && !str_contains($r['body'], 'Розмістіть оголошення безкоштовно'), 'P4 (draft) для гостя — 404, тексту немає');
    $r = http($jarG, "$base/marketplace.php?q=" . rawurlencode('Розмістіть оголошення'));
    check(!str_contains($r['body'], 'marketplace-offer.php?id=' . $p4 . '"'), 'P4 не потрапляє в пошук');

    echo "EN без звернень до API перекладу\n";
    [$html, $calls] = render_cli($root, 'marketplace-offer.php', ['id' => (string) $p1], 'en');
    check(str_contains($html, '<h1 class="mp-title">Free templates, checklists and scripts: just create an account</h1>'), 'англійський заголовок P1');
    check(str_contains($html, '>Create an account</a>') && str_contains($html, 'By AI LAB HUB'), 'EN: «Create an account», «By AI LAB HUB»');
    check(str_contains($html, '&quot;Bug report template with examples&quot;'), 'EN: приклади англійською');
    check($calls === 0, "звернень до API перекладу: $calls");
    [$html, $calls] = render_cli($root, 'marketplace-offer.php', ['id' => (string) $p1], 'uk');
    check($calls === 0 && str_contains($html, 'Створити акаунт'), "UA у CLI: звернень до API $calls");

    echo "Недозволені адреси, HTML, завершення строку\n";
    $evil = $tempListing('https://evil.com/register.php', 'Тест сторонньої адреси');
    $rel = $tempListing('//evil.com/register.php', 'Тест «//»');
    $acc = $tempListing('/account.php', 'Тест шляху не з переліку');
    $xss = $tempListing('/register.php?ref=mp-test', 'Тест <script>alert("x")</script> & "лапки"');
    $old = $tempListing('/register.php?ref=mp-test', 'Тест простроченого', 'NOW() - INTERVAL 1 MINUTE');
    @unlink($cache);
    foreach ([$evil => 'https://evil.com', $rel => '//evil.com', $acc => '/account.php'] as $id => $what) {
        $r = http($jarG, "$base/marketplace-offer.php?id=$id");
        check($r['code'] === 200 && !str_contains($r['body'], 'Створити акаунт') && !str_contains($r['body'], 'evil.com') && !str_contains($r['body'], 'mpContactBtn'),
            "адреса $what: кнопки немає, адреса не виводиться");
    }
    $r = http($jarG, "$base/marketplace-offer.php?id=$xss");
    check(!str_contains($r['body'], '<script>alert("x")') && str_contains($r['body'], '&lt;script&gt;alert(&quot;x&quot;)&lt;/script&gt; &amp; &quot;лапки&quot;'), 'HTML у назві екранується');
    $r = http($jarG, "$base/marketplace-offer.php?id=$old");
    check($r['code'] === 404, 'прострочене оголошення платформи для гостя — 404');
    $r = http($jarG, "$base/marketplace.php");
    check(tile_count($r['body'], 'Інше') === 6, 'прострочене не рахується в «Іншому» (2 + 4 тимчасові живі)');

    echo "Реєстрація з ref зараховується\n";
    $jarR = $tmpDir . '/r.txt';
    $r = http($jarR, "$base/register.php?ref=mp-free-materials");
    $email = "e2e-promo-{$stamp}@example.test";
    $r = http($jarR, "$base/register.php", ['name' => 'E2E Promo', 'email' => $email, 'password' => 'Test12345!', 'password_confirm' => 'Test12345!', 'csrf' => csrf_in($r['body'])]);
    $uid = $pdo->query('SELECT id FROM users WHERE email = ' . $pdo->quote($email))->fetchColumn();
    if ($uid !== false) {
        $created['users'][] = (int) $uid;
    }
    check($r['code'] === 302 && $uid !== false, 'реєстрація пройшла (302)');
    $ref = $uid !== false ? $pdo->query('SELECT ref_code FROM ad_house_signups WHERE user_id = ' . (int) $uid)->fetchColumn() : false;
    check($ref === 'mp-free-materials', 'ad_house_signups.ref_code = mp-free-materials');
    require_once $root . '/app/promo-house.php';
    check(str_contains(promo_platform_listing_refs_html($pdo), '<strong>mp-free-materials</strong>'), 'CRM «Звіти» власної реклами: рядок mp-free-materials');

    echo "Той, хто увійшов\n";
    $r = http($jarR, "$base/marketplace-offer.php?id=$p1");
    check(preg_match('~href="/account.php">Відкрити кабінет</a>~u', $r['body']) === 1 && !str_contains($r['body'], 'register.php?ref='), 'залогінений: «Відкрити кабінет» → /account.php, без посилання на реєстрацію');
    $r = http($jarR, "$base/register.php?ref=mp-free-materials");
    check($r['code'] === 302 && !str_contains($r['loc'], 'register.php'), '/register.php для залогіненого — редирект у кабінет (' . $r['loc'] . ')');
} finally {
    foreach ($created['listings'] as $id) {
        foreach (['mp_listing_categories', 'mp_listing_translations', 'mp_listing_views_daily', 'mp_listing_stats_daily'] as $t) {
            try {
                $pdo->exec("DELETE FROM $t WHERE listing_id = " . (int) $id);
            } catch (Throwable $e) {
            }
        }
        $pdo->exec('DELETE FROM mp_listings WHERE id = ' . (int) $id);
    }
    foreach ($created['users'] as $id) {
        $pdo->exec('DELETE FROM ad_house_signups WHERE user_id = ' . (int) $id);
        $pdo->exec('DELETE FROM users WHERE id = ' . (int) $id);
    }
    @unlink($cache);
    array_map('unlink', glob($tmpDir . '/*') ?: []);
    @rmdir($tmpDir);
    echo 'Видалено тимчасові записи: оголошення [' . implode(', ', $created['listings']) . '], користувачі [' . implode(', ', $created['users']) . "]\n";
}

echo "\nPASS $pass / FAIL $fail\n";
exit($fail > 0 ? 1 : 0);
