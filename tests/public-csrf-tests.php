<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CSRF у публічних формах і JS-ендпойнтах (app/csrf.php), ЛОКАЛЬНА база.
 *
 *   php tests/public-csrf-tests.php
 *
 * Справжні запити через вбудований сервер (tests/support/pt-router.php; X-Pt-Uid — вхід тестовим користувачем)
 * з cookie jar. Модель Елі не викликається (запити до api-eli-chat — з User-Agent робота). Тестові користувачі,
 * заявки, підписки, обране, токени входу видаляються за id. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
require_once __DIR__ . '/../app/csrf.php';
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$T = 0;
$F = 0;
function ok(bool $cond, string $name): void
{
    global $T, $F;
    $T++;
    if (!$cond) {
        $F++;
    }
    echo ($cond ? '  OK   ' : '  FAIL ') . $name . "\n";
}

$tmp = sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'pc-test-' . bin2hex(random_bytes(3));
@mkdir($tmp, 0700, true);
$jar = $tmp . DIRECTORY_SEPARATOR . 'cookies.txt';
$port = 8798;
$null = PHP_OS_FAMILY === 'Windows' ? 'NUL' : '/dev/null';
$proc = proc_open([PHP_BINARY, '-S', '127.0.0.1:' . $port, __DIR__ . '/support/pt-router.php'],
    [0 => ['pipe', 'r'], 1 => ['file', $null, 'w'], 2 => ['file', $null, 'w']], $pipes, dirname(__DIR__));
for ($i = 0; $i < 50; $i++) {
    $s = @fsockopen('127.0.0.1', $port, $errno, $errstr, 0.2);
    if ($s) {
        fclose($s);
        break;
    }
    usleep(100000);
}
$base = 'http://127.0.0.1:' . $port;
$self = 'http://127.0.0.1:' . $port;
$evil = 'https://evil.example';

/** @return array{0:int,1:string,2:string} */
$http = static function (string $path, ?array $post = null, array $headers = [], int $uid = 0, string $ua = 'Mozilla/5.0 (Windows NT 10.0) Chrome/130.0 Safari/537.36') use ($base, $jar): array {
    $ch = curl_init($base . $path);
    $h = $headers;
    if ($uid > 0) {
        $h[] = 'X-Pt-Uid: ' . $uid;
    }
    $opt = [CURLOPT_RETURNTRANSFER => true, CURLOPT_TIMEOUT => 30, CURLOPT_HTTPHEADER => $h, CURLOPT_USERAGENT => $ua,
        CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_HEADER => true];
    if ($post !== null) {
        $opt[CURLOPT_POST] = true;
        $opt[CURLOPT_POSTFIELDS] = http_build_query($post);
    }
    curl_setopt_array($ch, $opt);
    $raw = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $hs = (int) curl_getinfo($ch, CURLINFO_HEADER_SIZE);
    curl_close($ch);

    return [$code, substr($raw, $hs), preg_match('~^Location:\s*(\S+)~mi', substr($raw, 0, $hs), $m) ? $m[1] : ''];
};
$tok = static fn(string $html): string => preg_match('~name="csrf" value="([0-9a-f]{64})"~', $html, $m) ? $m[1] : '';
$csrfMsg = 'Сторінка застаріла';
$run = bin2hex(random_bytes(3));
$ids = ['users' => [], 'admin_requests' => [], 'pos' => 0, 'news' => []];
$mkUser = static function (string $role, string $password = 'x') use ($pdo, $run, &$ids): array {
    $email = 'pc-test-' . $role . '-' . $run . '-' . count($ids['users']) . '@example.invalid';
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role) VALUES ('PC-TEST', :e, :p, :r)")
        ->execute([':e' => $email, ':p' => password_hash($password, PASSWORD_DEFAULT), ':r' => $role]);
    $id = (int) $pdo->lastInsertId();
    $ids['users'][] = $id;

    return [$id, $email];
};

try {
    echo "== csrf_same_origin() (без сервера)\n";
    $cases = [
        ['Origin same', ['HTTP_HOST' => 'ailabhub-directory.com', 'HTTP_ORIGIN' => 'https://ailabhub-directory.com'], true],
        ['Origin www ↔ без www', ['HTTP_HOST' => 'ailabhub-directory.com', 'HTTP_ORIGIN' => 'https://www.ailabhub-directory.com'], true],
        ['Origin чужий', ['HTTP_HOST' => 'ailabhub-directory.com', 'HTTP_ORIGIN' => 'https://evil.example'], false],
        ['Origin схожий суфікс', ['HTTP_HOST' => 'ailabhub-directory.com', 'HTTP_ORIGIN' => 'https://ailabhub-directory.com.evil.example'], false],
        ['Origin null', ['HTTP_HOST' => 'ailabhub-directory.com', 'HTTP_ORIGIN' => 'null'], false],
        ['Sec-Fetch-Site cross-site', ['HTTP_HOST' => 'ailabhub-directory.com', 'HTTP_SEC_FETCH_SITE' => 'cross-site'], false],
        ['Sec-Fetch-Site same-origin', ['HTTP_HOST' => 'ailabhub-directory.com', 'HTTP_SEC_FETCH_SITE' => 'same-origin'], true],
        ['без заголовків (curl)', ['HTTP_HOST' => 'ailabhub-directory.com'], true],
    ];
    $saved = $_SERVER;
    foreach ($cases as [$label, $srv, $want]) {
        $_SERVER = $srv;
        ok(csrf_same_origin() === $want, "$label → " . ($want ? 'дозволено' : 'відмова'));
    }
    $_SERVER = $saved;

    echo "== Вхід\n";
    [$uidLogin, $emailLogin] = $mkUser('user', 'pc-pass-123');
    [, $page] = $http('/login.php');
    $t = $tok($page);
    ok($t !== '', 'форма входу містить токен');
    [$code, $body, $loc] = $http('/login.php', ['email' => $emailLogin, 'password' => 'pc-pass-123']);
    ok($code === 200 && str_contains($body, $csrfMsg) && $loc === '', 'вхід без токена з правильним паролем: не виконано, помилка');
    [$code, , $loc] = $http('/login.php', ['email' => $emailLogin, 'password' => 'pc-pass-123', 'csrf' => $t]);
    ok($code === 302 && $loc !== '', 'вхід з токеном: виконано (302)');
    @unlink($jar);

    echo "== Реєстрація\n";
    $regEmail = 'pc-test-reg-' . $run . '@example.invalid';
    $regCount = static fn(): int => (int) $pdo->query('SELECT COUNT(*) FROM users WHERE email = ' . $pdo->quote($regEmail))->fetchColumn();
    [, $page] = $http('/register.php');
    $t = $tok($page);
    $reg = ['name' => 'PC-TEST', 'email' => $regEmail, 'password' => 'pc-pass-123', 'password_confirm' => 'pc-pass-123', 'password2' => 'pc-pass-123', 'agree' => '1', 'terms' => '1'];
    [$code, $body] = $http('/register.php', $reg + ['csrf' => str_repeat('a', 64)]);
    ok($code === 200 && str_contains($body, $csrfMsg) && $regCount() === 0, 'реєстрація з чужим токеном: акаунт не створено, помилка');
    [$code, $body] = $http('/register.php', $reg + ['csrf' => $t]);
    $rid = (int) $pdo->query('SELECT COALESCE(MAX(id), 0) FROM users WHERE email = ' . $pdo->quote($regEmail))->fetchColumn();
    if ($rid > 0) {
        $ids['users'][] = $rid;
    }
    ok(!str_contains($body, $csrfMsg) && $rid > 0, 'реєстрація з токеном: акаунт створено' . ($rid > 0 ? '' : ' (перевірте поля форми: ' . mb_substr(strip_tags($body), 0, 0) . ')'));
    @unlink($jar);

    echo "== Відновлення пароля\n";
    $tokCount = static fn(): int => (int) $pdo->query('SELECT COUNT(*) FROM login_tokens WHERE user_id = ' . $uidLogin)->fetchColumn();
    [, $page] = $http('/forgot-password.php');
    $t = $tok($page);
    [$code, $body] = $http('/forgot-password.php', ['email' => $emailLogin]);
    ok($code === 200 && str_contains($body, $csrfMsg) && $tokCount() === 0, 'без токена: лист не надіслано (немає login_tokens), помилка');
    [$code, $body] = $http('/forgot-password.php', ['email' => $emailLogin, 'csrf' => $t]);
    ok(!str_contains($body, $csrfMsg) && $tokCount() === 1, 'з токеном: посилання для входу створено');
    @unlink($jar);

    echo "== Заявка адміністратора / директора\n";
    [$uidApp] = $mkUser('user');
    $arCount = static fn(): int => (int) $pdo->query('SELECT COUNT(*) FROM admin_requests WHERE user_id = ' . $uidApp)->fetchColumn();
    [, $page] = $http('/apply-admin.php', null, [], $uidApp);
    $t = $tok($page);
    [$code, $body] = $http('/apply-admin.php', ['action' => 'submit_admin_request'], [], $uidApp);
    ok($code === 200 && str_contains($body, $csrfMsg) && $arCount() === 0, 'apply-admin без токена: заявку не подано, помилка');
    [$code] = $http('/apply-admin.php', ['action' => 'submit_admin_request', 'csrf' => $t], [], $uidApp);
    ok($code === 302 && $arCount() === 1, 'apply-admin з токеном: заявку подано');
    $pdo->exec('DELETE FROM admin_requests WHERE user_id = ' . $uidApp);
    $dir = ['action' => 'submit_director_request', 'first_name' => 'PC', 'last_name' => 'TEST', 'phone' => '+380000000000'];
    [, $page] = $http('/apply-ceo.php', null, [], $uidApp);
    $dir['email'] = preg_match('~name="email"[^>]*value="([^"]*)"~', $page, $m) ? html_entity_decode($m[1]) : '';
    [$code, $body] = $http('/apply-ceo.php', $dir, [], $uidApp);
    ok($code === 200 && str_contains($body, $csrfMsg) && $arCount() === 0, 'apply-ceo без токена: заявку не подано, помилка');
    ok($tok($page) !== '', 'apply-ceo: форма містить токен');
    @unlink($jar);

    echo "== Заявка на позицію (посилання з токеном)\n";
    $posToken = bin2hex(random_bytes(32));
    $pdo->prepare("INSERT INTO position_applications (position_title, token, status, created_by) VALUES ('PC-TEST', :t, 'pending', :u)")
        ->execute([':t' => $posToken, ':u' => $uidLogin]);
    $ids['pos'] = (int) $pdo->lastInsertId();
    $posStatus = static fn(): string => (string) $pdo->query('SELECT status FROM position_applications WHERE id = ' . $ids['pos'])->fetchColumn();
    [, $page] = $http('/apply-position.php?token=' . $posToken);
    $t = $tok($page);
    $pf = ['token' => $posToken, 'last_name' => 'TEST', 'first_name' => 'PC', 'email' => 'pc-test-pos-' . $run . '@example.invalid', 'phone' => '+380000000000'];
    [$code, $body] = $http('/apply-position.php?token=' . $posToken, $pf);
    ok($t !== '' && str_contains($body, $csrfMsg) && $posStatus() === 'pending', 'apply-position без токена: заявку не відправлено, помилка');
    @unlink($jar);

    echo "== JS-ендпойнти: чужий Origin\n";
    $bot = 'curl/8.0';
    [$code] = $http('/api-eli-chat.php', ['message' => 'pc test відео'], ['Origin: ' . $evil], 0, $bot);
    ok($code === 403, 'api-eli-chat з Origin іншого сайту — 403');
    [$code, $body] = $http('/api-eli-chat.php', ['message' => 'pc test відео'], ['Origin: ' . $self], 0, $bot);
    ok($code === 200 && str_contains($body, '"mode":"fallback"'), 'api-eli-chat з власним Origin — працює (робот → запасний режим, без моделі)');
    [$code] = $http('/api-eli-chat.php', ['message' => 'pc test'], ['Sec-Fetch-Site: cross-site'], 0, $bot);
    ok($code === 403, 'api-eli-chat з Sec-Fetch-Site: cross-site — 403');

    $nEmail = 'pc-test-news-' . $run . '@example.invalid';
    $nCount = static fn(): int => (int) $pdo->query('SELECT COUNT(*) FROM newsletter_subscribers WHERE email = ' . $pdo->quote($nEmail))->fetchColumn();
    [$code, $body] = $http('/api-newsletter-subscribe.php', ['email' => $nEmail], ['Origin: ' . $evil]);
    ok($code === 403 && $nCount() === 0, 'підписка з чужого сайту — 403, адресу не додано');
    [$code] = $http('/api-newsletter-subscribe.php', ['email' => $nEmail], ['Origin: ' . $self]);
    ok($nCount() === 1, 'підписка з нашого сайту — адресу додано');

    $pid = (int) $pdo->query("SELECT MIN(id) FROM products WHERE status = 'published'")->fetchColumn();
    $sCount = static fn(): int => (int) $pdo->query("SELECT COUNT(*) FROM saved_products WHERE user_id = $uidApp AND product_id = $pid")->fetchColumn();
    [$code] = $http('/api-saved-products.php', ['product_id' => $pid], ['Origin: ' . $evil], $uidApp);
    ok($code === 403 && $sCount() === 0, '«Моя добірка» з чужого сайту — 403, нічого не збережено');
    [$code] = $http('/api-saved-products.php', ['product_id' => $pid], ['Origin: ' . $self], $uidApp);
    ok($code === 200 && $sCount() === 1, '«Моя добірка» з нашого сайту — збережено');

    [$code, $body] = $http('/promo-report.php', ['t' => 'x', 'reason' => 'scam'], ['Origin: ' . $evil]);
    ok(str_contains($body, '"ok":false'), 'скарга на рекламу з чужого сайту — не прийнято');
    [$code] = $http('/promo-event.php', ['e' => 'x'], ['Origin: ' . $evil]);
    ok($code === 204, 'події реклами з чужого сайту — 204 без запису');
} finally {
    if (is_resource($proc)) {
        $st = proc_get_status($proc);
        if (PHP_OS_FAMILY === 'Windows') {
            exec('taskkill /F /T /PID ' . (int) $st['pid'] . ' >NUL 2>&1');
        } else {
            proc_terminate($proc);
        }
        proc_close($proc);
    }
    echo "== Прибирання (лише свої записи)\n";
    if ($ids['users'] !== []) {
        $in = implode(',', array_map('intval', $ids['users']));
        foreach (['saved_products', 'login_tokens', 'admin_requests'] as $tbl) {
            $pdo->exec("DELETE FROM $tbl WHERE user_id IN ($in)");
        }
        $pdo->exec("DELETE FROM users WHERE id IN ($in)");
    }
    if ($ids['pos'] > 0) {
        $pdo->exec('DELETE FROM position_applications WHERE id = ' . (int) $ids['pos']);
    }
    $pdo->exec("DELETE FROM newsletter_subscribers WHERE email LIKE " . $pdo->quote('pc-test-news-' . $run . '%'));
    @unlink($jar);
    @rmdir($tmp);
    $left = (int) $pdo->query("SELECT (SELECT COUNT(*) FROM users WHERE email LIKE 'pc-test-%') + (SELECT COUNT(*) FROM newsletter_subscribers WHERE email LIKE 'pc-test-%')
                                 + (SELECT COUNT(*) FROM position_applications WHERE position_title = 'PC-TEST')")->fetchColumn();
    ok($left === 0, 'тестових записів не лишилося');
}
echo "\nРазом: $T, помилок: $F\n";
exit($F > 0 ? 1 : 0);
