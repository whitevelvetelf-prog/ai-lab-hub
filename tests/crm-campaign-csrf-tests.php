<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CSRF у CRM-сторінках кампаній (crm-add-campaign.php, crm-edit-campaign.php), ЛОКАЛЬНА база.
 *
 *   php tests/crm-campaign-csrf-tests.php
 *
 * Справжні POST через вбудований сервер (tests/support/pt-router.php: вхід тестовим admin за заголовком X-Pt-Uid)
 * в одній сесії (cookie jar). Тестові admin, кампанія й банер видаляються за id. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
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

$tmp = sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'cc-test-' . bin2hex(random_bytes(3));
@mkdir($tmp, 0700, true);
$jar = $tmp . DIRECTORY_SEPARATOR . 'cookies.txt';
$port = 8796;
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
$uid = 0;

/** @return array{0:int,1:string,2:string} код, тіло, Location */
$http = static function (string $path, ?array $post = null) use ($base, $jar, &$uid): array {
    $ch = curl_init($base . $path);
    $opt = [CURLOPT_RETURNTRANSFER => true, CURLOPT_TIMEOUT => 30, CURLOPT_HTTPHEADER => ['X-Pt-Uid: ' . $uid],
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
    $loc = preg_match('~^Location:\s*(\S+)~mi', substr($raw, 0, $hs), $m) ? $m[1] : '';

    return [$code, substr($raw, $hs), $loc];
};
$token = static fn(string $html): string => preg_match('~name="csrf" value="([0-9a-f]{64})"~', $html, $m) ? $m[1] : '';
$err = 'Сесія застаріла';
$name = 'CC-TEST ' . bin2hex(random_bytes(3));
$campaignId = 0;
$adId = 0;

try {
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role) VALUES ('CC-TEST admin', :e, 'x', 'admin')")
        ->execute([':e' => 'cc-test-' . bin2hex(random_bytes(3)) . '@example.invalid']);
    $uid = (int) $pdo->lastInsertId();
    $count = static fn(): int => (int) $pdo->query('SELECT COUNT(*) FROM ad_campaigns WHERE advertiser_name = ' . $pdo->quote($name))->fetchColumn();
    $form = static fn(?string $t, string $adv): array => array_filter([
        'csrf' => $t, 'campaign_type' => 'internal', 'advertiser_name' => $adv, 'start_date' => date('Y-m-d'), 'status' => 'paused',
    ], static fn($v): bool => $v !== null);

    echo "== crm-add-campaign.php\n";
    [$code, $body] = $http('/crm-add-campaign.php');
    $csrf = $token($body);
    ok($code === 200 && $csrf !== '', 'форма створення містить CSRF-токен');
    foreach (['без токена' => null, 'з чужим токеном' => str_repeat('c', 64)] as $label => $bad) {
        [$code, $body] = $http('/crm-add-campaign.php', $form($bad, $name));
        ok($code === 200 && str_contains($body, $err) && $count() === 0, "створення $label: кампанію не створено, показано помилку");
    }
    ok(str_contains($body, 'value="' . $name . '"'), 'після відмови введені значення лишаються у формі');
    [$code, , $loc] = $http('/crm-add-campaign.php', $form($csrf, $name));
    $campaignId = (int) $pdo->query('SELECT COALESCE(MAX(id), 0) FROM ad_campaigns WHERE advertiser_name = ' . $pdo->quote($name))->fetchColumn();
    ok($code === 302 && $campaignId > 0 && str_contains($loc, 'crm-edit-campaign.php?id=' . $campaignId), "створення з токеном: кампанію створено (id $campaignId)");

    echo "== crm-edit-campaign.php\n";
    $zone = (int) $pdo->query('SELECT MIN(id) FROM ad_zones')->fetchColumn();
    $pdo->prepare("INSERT INTO ads (campaign_id, zone_id, image_url, target_url, status, created_at) VALUES (:c, :z, 'https://cc-test.example.invalid/x.png', 'https://cc-test.example.invalid/', 'active', NOW())")
        ->execute([':c' => $campaignId, ':z' => $zone]);
    $adId = (int) $pdo->lastInsertId();
    $edit = '/crm-edit-campaign.php?id=' . $campaignId;
    [$code, $body] = $http($edit);
    ok($code === 200 && substr_count($body, 'name="csrf" value="' . $csrf . '"') === 3, 'усі 3 форми сторінки (кампанія, вимкнення банера, новий банер) містять токен');

    $adv = static fn(): string => (string) $pdo->query('SELECT advertiser_name FROM ad_campaigns WHERE id = ' . $campaignId)->fetchColumn();
    $adStatus = static fn(): string => (string) $pdo->query('SELECT status FROM ads WHERE id = ' . $adId)->fetchColumn();
    $adsCount = static fn(): int => (int) $pdo->query('SELECT COUNT(*) FROM ads WHERE campaign_id = ' . $campaignId)->fetchColumn();
    $save = static fn(?string $t, string $a): array => ['action' => 'save_campaign'] + $form($t, $a);

    [$code, $body] = $http($edit, $save(null, $name . ' змінено'));
    ok($code === 200 && str_contains($body, $err) && $adv() === $name, 'збереження кампанії без токена: не змінено, показано помилку');
    [$code, $body] = $http($edit, ['action' => 'toggle_ad', 'ad_id' => $adId, 'csrf' => str_repeat('d', 64)]);
    ok($code === 200 && str_contains($body, $err) && $adStatus() === 'active', 'вимкнення банера з чужим токеном: статус не змінено, показано помилку');
    [$code, $body] = $http($edit, ['action' => 'add_ad', 'zone_id' => $zone, 'target_url' => 'https://cc-test.example.invalid/2',
                                    'image_url' => 'https://cc-test.example.invalid/2.png', 'scope' => '']);
    ok($code === 200 && str_contains($body, $err) && $adsCount() === 1, 'новий банер без токена: не додано, показано помилку');

    [$code] = $http($edit, $save($csrf, $name . ' змінено'));
    ok($code === 302 && $adv() === $name . ' змінено', 'збереження кампанії з токеном: збережено');
    [$code] = $http($edit, ['action' => 'toggle_ad', 'ad_id' => $adId, 'csrf' => $csrf]);
    ok($code === 302 && $adStatus() !== 'active', 'вимкнення банера з токеном: статус змінено (' . $adStatus() . ')');
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
    echo "== Прибирання (лише свої записи, за id)\n";
    if ($campaignId > 0) {
        $pdo->exec('DELETE FROM ads WHERE campaign_id = ' . $campaignId);
        $pdo->exec('DELETE FROM ad_campaigns WHERE id = ' . $campaignId);
    }
    if ($uid > 0) {
        $pdo->exec('DELETE FROM users WHERE id = ' . $uid);
    }
    @unlink($jar);
    @rmdir($tmp);
    $left = (int) $pdo->query("SELECT (SELECT COUNT(*) FROM ad_campaigns WHERE advertiser_name LIKE 'CC-TEST %') + (SELECT COUNT(*) FROM users WHERE name = 'CC-TEST admin')
                                 + (SELECT COUNT(*) FROM ads WHERE target_url LIKE 'https://cc-test.example.invalid/%')")->fetchColumn();
    ok($left === 0, 'тестових записів не лишилося');
}
echo "\nРазом: $T, помилок: $F\n";
exit($F > 0 ? 1 : 0);
