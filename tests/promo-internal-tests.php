<?php

declare(strict_types=1);

/**
 * AI LAB HUB — внутрішні адреси реклами, аудиторія кампаній, реклама реєстрації (app/promo-internal.php,
 * app/promo-linkcheck.php, app/acquisition.php, public/register.php). ЛОКАЛЬНА база, лише CLI:
 *
 *   php tests/promo-internal-tests.php
 *
 * Потрібні міграції 2026-11-12-ad-audience*.sql. Створює тестові кампанії/креативи/користувачів SQL-вставкою
 * й видаляє ЛИШЕ їх за id (разом із ad_link_checks, promo_event_log, ad_campaign_audience, ad_house_signups).
 * Відбір реклами перевіряється в транзакції з тимчасово ввімкненим ad_settings.enabled (ROLLBACK).
 * HTTP — вбудований сервер (tests/support/pt-router.php, X-Pt-Uid — вхід тестовим користувачем).
 * Зовнішнє посилання перевіряється справжнім запитом до https://example.com/ (потрібна мережа).
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
$_SERVER['HTTP_HOST'] = 'ai-lab-hub.test';
$_SERVER['REQUEST_METHOD'] = 'GET';
$_SERVER['REQUEST_URI'] = '/';
require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/promo-linkcheck.php';
require_once __DIR__ . '/../app/promo-admin.php';
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

$run = strtoupper(bin2hex(random_bytes(2)));
$ids = ['campaigns' => [], 'creatives' => [], 'users' => []];
$mkCampaign = static function (string $type, string $url, string $ref = '', int $streak = 0) use ($pdo, &$ids, $run): array {
    $pdo->prepare("INSERT INTO ad_campaigns (campaign_type, format, name, advertiser_name, status, start_date, currency, unit_price, pricing_model)
                   VALUES (:t, 'video', :n, 'PI-TEST', 'active', CURDATE(), 'USD', :up, :pm)")
        ->execute([':t' => $type, ':n' => 'PI-TEST ' . $run, ':up' => $type === 'paid' ? 100 : null, ':pm' => $type === 'paid' ? 'cpc' : null]);
    $cid = (int) $pdo->lastInsertId();
    $ids['campaigns'][] = $cid;
    $pdo->prepare("INSERT INTO ad_creatives (campaign_id, title, destination_url, status, creative_type, ref_code, link_fail_streak, cta_text)
                   VALUES (:c, 'PI-TEST', :u, 'approved', 'card', :r, :s, 'Go')")
        ->execute([':c' => $cid, ':u' => $url, ':r' => $ref !== '' ? $ref : null, ':s' => $streak]);
    $crid = (int) $pdo->lastInsertId();
    $ids['creatives'][] = $crid;
    $pdo->prepare("INSERT INTO ad_targets (campaign_id, placement) VALUES (:c, 'popup')")->execute([':c' => $cid]);

    return [$cid, $crid];
};
$creative = static function (int $id) use ($pdo): array {
    $st = $pdo->prepare('SELECT cr.*, c.status AS campaign_status FROM ad_creatives cr JOIN ad_campaigns c ON c.id = cr.campaign_id WHERE cr.id = :id');
    $st->execute([':id' => $id]);

    return $st->fetch(PDO::FETCH_ASSOC) ?: [];
};

// --- вбудований сервер ---
$tmp = sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'pi-test-' . bin2hex(random_bytes(3));
@mkdir($tmp, 0700, true);
$port = 8797;
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
/** @return array{0:int,1:string,2:string} */
$http = static function (string $jar, string $path, ?array $post = null, int $uid = 0) use ($port): array {
    $ch = curl_init('http://127.0.0.1:' . $port . $path);
    $opt = [CURLOPT_RETURNTRANSFER => true, CURLOPT_TIMEOUT => 30, CURLOPT_HEADER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar,
        CURLOPT_USERAGENT => 'Mozilla/5.0 (Windows NT 10.0) Chrome/130.0 Safari/537.36', CURLOPT_HTTPHEADER => $uid > 0 ? ['X-Pt-Uid: ' . $uid] : []];
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

try {
    echo "== Внутрішня адреса: перевірка без HTTP-запиту\n";
    $good = ['/register.php?ref=house-R2', '/register.php', '/catalog.php?search=video&ref=house-X_1', '/donate.php#top',
             'https://ailabhub-directory.com/register.php?ref=house-R2', 'https://www.ailabhub-directory.com/marketplace.php'];
    foreach ($good as $u) {
        ok(promo_internal_url_check($u)['ok'], "дозволено: {$u}");
    }
    $bad = ['//evil.com', '//evil.com/register.php', '/\\evil', '/register.php\\..\\x', 'javascript:alert(1)', 'file:///etc/passwd',
            'register.php', '/register.php@evil.com', '/@evil.com', "/register.php\n", "/register.php?ref=a\tb", '/admin-stats.php',
            '/register.php?ref=house-R2"', '/register.php?ref=' . str_repeat('a', 41), '/register.php?ref=bad$ref', '/../config/promo.php',
            '/register.php:8080', 'https://evil.com/register.php', 'http://ailabhub-directory.com/register.php',
            'https://ailabhub-directory.com:8443/register.php', 'https://user@ailabhub-directory.com/register.php', '/catalog.php?x=<script>'];
    foreach ($bad as $u) {
        $r = promo_internal_url_check($u);
        ok(!$r['ok'] && $r['error'] !== null, 'відхилено: ' . json_encode($u) . ' — ' . ($r['error'] ?? ''));
    }
    ok(promo_is_internal_target('internal', '/register.php?ref=house-R2') && promo_is_internal_target('internal', '//evil.com')
        && promo_is_internal_target('internal', 'javascript:alert(1)'), 'internal-кампанія: адреса без https — через внутрішню перевірку');
    ok(!promo_is_internal_target('paid', '/register.php') && !promo_is_internal_target('internal', 'http://127.0.0.1/')
        && !promo_is_internal_target('paid', 'https://example.com/'), 'платна з відносною адресою, http://127.0.0.1 і чужий домен — через HTTP-перевірку');
    ok(promo_is_internal_target('paid', 'https://ailabhub-directory.com/donate.php'), 'посилання на наш домен у платній кампанії — внутрішнє');

    echo "== Зовнішні адреси: захист без змін\n";
    $chk = new PromoLinkChecker(new PromoSafeBrowsingDisabled());
    foreach (['http://127.0.0.1/' => 'ssrf_blocked', 'http://169.254.169.254/latest/meta-data/' => 'ssrf_blocked', 'javascript:alert(1)' => 'ssrf_blocked',
              'file:///etc/passwd' => 'ssrf_blocked', 'https://user:pw@example.com/' => 'ssrf_blocked', 'http://localhost/' => 'ssrf_blocked',
              'http://10.0.0.1/' => 'ssrf_blocked', 'https://example.com:8443/' => 'ssrf_blocked', '/register.php?ref=house-R2' => 'relative_url'] as $u => $flag) {
        $r = $chk->check($u);
        ok($r['error'] && $r['blocked'] && in_array($flag, $r['flags'], true) && $r['http_status'] === null, "відхилено без з’єднання: {$u} ({$flag})");
    }
    $rel = $chk->check('/register.php');
    ok(str_contains(implode(' ', $rel['notes']), 'вкажіть повну адресу https://'), 'відносна адреса зовнішньої кампанії: «вкажіть повну адресу https://…»');
    ok(promo_url_error('/register.php') === 'err_url_https' && str_contains(promo_tr('err_url_https'), 'повну адресу https://'), 'майстер рекламодавця: відносна адреса → err_url_https');
    $ext = $chk->check('https://example.com/');
    ok(!$ext['error'] && $ext['http_status'] === 200 && $ext['final_host'] === 'example.com', 'зовнішнє валідне посилання https://example.com/ проходить (HTTP ' . ($ext['http_status'] ?? '—') . ')');
    ok(promo_url_error('https://example.com/') === null, 'майстер рекламодавця: https://example.com/ приймається');

    echo "== Лічильник «3 перевірки поспіль» і статус\n";
    [$cInt, $crInt] = $mkCampaign('internal', '/register.php?ref=house-PI' . $run, 'house-PI' . $run, 2);
    for ($i = 0; $i < 4; $i++) {
        $r = promo_linkcheck_creative($pdo, $crInt, false);
    }
    $row = $creative($crInt);
    ok($r['status'] === 'internal' && $r['flags'] === [] && (int) $row['link_fail_streak'] === 0 && $row['link_check_status'] === 'internal',
        'внутрішня сторінка: статус internal, без прапорців, лічильник скинуто (було 2 → 0)');
    $last = promo_last_link_check($pdo, $crInt);
    ok($last !== null && $last['http_status'] === null && $last['flags'] === '' && str_contains((string) $last['notes'], 'без HTTP-запиту'), 'у журналі ad_link_checks: без HTTP-запиту, без прапорців');
    // Повторна перевірка cron лише для наших креативів: ті самі умови автопаузи, що в promo_linkcheck_due, без чужих рядків.
    $paused = 0;
    for ($i = 0; $i < 3; $i++) {
        $r = promo_linkcheck_creative($pdo, $crInt, false);
        if (($r['fail_streak'] ?? 0) >= PROMO_LINK_FAIL_LIMIT || $r['safe_browsing_status'] === 'flagged' || in_array('final_host_changed', $r['flags'], true)) {
            $paused++;
        }
    }
    ok($paused === 0 && $creative($crInt)['campaign_status'] === 'active', 'хибного спрацювання немає: 3 перевірки поспіль не ставлять кампанію на модерацію');

    [, $crBadPath] = $mkCampaign('internal', '/admin-stats.php', '', 1);
    $r = promo_linkcheck_creative($pdo, $crBadPath, true);
    ok($r['status'] === 'flagged' && $r['flags'] === ['internal_path'] && (int) $creative($crBadPath)['link_fail_streak'] === 0, 'шлях поза переліком: прапорець internal_path, але не в лічильнику');

    [, $crRel] = $mkCampaign('paid', '/register.php', '', 0);
    for ($i = 0; $i < 3; $i++) {
        $r = promo_linkcheck_creative($pdo, $crRel, false);
    }
    ok($r['status'] === 'flagged' && in_array('relative_url', $r['flags'], true) && (int) $creative($crRel)['link_fail_streak'] === 3,
        'зовнішня (платна) кампанія з відносною адресою: як і раніше — помилка, лічильник 3');

    [, $crEvil] = $mkCampaign('internal', '//evil.com/x', '', 0);
    $r = promo_linkcheck_creative($pdo, $crEvil, true);
    ok($r['status'] === 'flagged' && $r['flags'] === ['internal_path'] && $r['http_status'] === null, 'internal-кампанія з //evil.com: відхилено без HTTP-запиту');

    echo "== Модерація: статус internal схвалюється без підтвердження\n";
    $pdo->prepare("UPDATE ad_campaigns SET status = 'pending_review' WHERE id = :id")->execute([':id' => $cInt]);
    $pdo->prepare("UPDATE ad_creatives SET status = 'pending' WHERE id = :id")->execute([':id' => $crInt]);
    $adminId = (int) $pdo->query("SELECT id FROM users WHERE role = 'admin' ORDER BY id LIMIT 1")->fetchColumn();
    [$mok, $mmsg] = promo_admin_moderate($pdo, $adminId, $crInt, true, '');
    ok($mok && $creative($crInt)['campaign_status'] === 'active', 'кнопка «Схвалити» після «Перевірити ще раз» повертає кампанію в показ (' . $mmsg . ')');

    echo "== Аудиторія\n";
    ok(promo_campaign_audience($pdo, $cInt) === 'all', 'за замовчуванням — all');
    ok(promo_viewer_allowed($pdo, $cInt, $crInt, false) && !promo_viewer_allowed($pdo, $cInt, $crInt, true),
        'реклама реєстрації без налаштованої аудиторії: гостю так, тому, хто увійшов, — ні');
    ok(promo_audience_set($pdo, $cInt, 'guests') && promo_campaign_audience($pdo, $cInt) === 'guests', 'аудиторія guests зберігається (ad_campaign_audience)');
    [$cMp, $crMp] = $mkCampaign('internal', '/marketplace.php?ref=house-PM' . $run, 'house-PM' . $run);
    promo_audience_set($pdo, $cMp, 'logged_in');
    ok(!promo_viewer_allowed($pdo, $cMp, $crMp, false) && promo_viewer_allowed($pdo, $cMp, $crMp, true), 'logged_in: лише тим, хто увійшов');
    ok(!promo_audience_set($pdo, $cMp, 'bogus'), 'невідома аудиторія не зберігається');

    echo "== Відбір реклами (promo_pick_set, у транзакції з увімкненою рекламою)\n";
    $pdo->beginTransaction();
    try {
        $pdo->exec("INSERT INTO ad_settings (setting_key, setting_value) VALUES ('enabled', '1') ON DUPLICATE KEY UPDATE setting_value = '1'");
        // Лише наші тестові кампанії: решту активних власних тимчасово ставимо на паузу (ROLLBACK поверне).
        $pdo->exec("UPDATE ad_campaigns SET status = 'paused' WHERE status = 'active' AND format = 'video' AND id NOT IN (" . implode(',', $ids['campaigns']) . ')');
        $pdo->exec("UPDATE ad_campaigns SET status = 'paused' WHERE id NOT IN ({$cInt}, {$cMp})");
        $pdo->exec("UPDATE ad_campaigns SET status = 'active' WHERE id IN ({$cInt}, {$cMp})");
        promo_settings($pdo, true);
        promo_cache_flush();
        promo_cache_generation(true);
        if (!promo_video_ready($pdo) || !promo_placement_available($pdo, 'popup')) {
            echo "  --   відеореклама не готова локально (secret у config/promo.php чи місце popup) — пропущено\n";
        } else {
            $pick = static function (bool $logged) use ($pdo): array {
                $_SESSION = $logged ? ['user_id' => (int) $pdo->query("SELECT id FROM users WHERE role = 'user' ORDER BY id LIMIT 1")->fetchColumn(), 'role' => 'user'] : [];
                $seen = [];
                for ($i = 0; $i < 8; $i++) {
                    $_SESSION['promo'] = [];
                    foreach (promo_pick_set($pdo, 'popup', [], [], 'uk', 'desktop', 'pi-test-' . $i, ['page' => 'catalog'], [], 3) as $r) {
                        $seen[(int) $r['id']] = true;
                    }
                }

                return $seen;
            };
            $guest = $pick(false);
            $logged = $pick(true);
            ok(isset($guest[$crInt]) && !isset($guest[$crMp]), 'гість: бачить рекламу реєстрації, не бачить кампанію logged_in');
            ok(!isset($logged[$crInt]) && isset($logged[$crMp]), 'увійшов: реклами реєстрації немає, замість неї — інша власна (Marketplace)');
            promo_audience_set($pdo, $cMp, 'guests');
            $logged2 = $pick(true);
            ok($logged2 === [], 'увійшов, іншої реклами для нього немає → нічого не показується');
            $_SESSION = [];
        }
    } finally {
        $pdo->rollBack();
        promo_settings($pdo, true);
        promo_cache_flush();
        promo_audience_map($pdo, true);
    }
    promo_audience_set($pdo, $cMp, 'logged_in');

    echo "== Реєстрація за посиланням /register.php?ref=…\n";
    $ref = 'house-PI' . $run;
    $jar = $tmp . DIRECTORY_SEPARATOR . 'guest.txt';
    [$code, $html] = $http($jar, '/register.php?ref=' . $ref);
    ok($code === 200 && str_contains($html, 'name="password_confirm"'), 'гість бачить форму реєстрації (200)');
    $csrf = preg_match('~name="csrf" value="([0-9a-f]{64})"~', $html, $m) ? $m[1] : '';
    $email = 'pi-test-' . strtolower($run) . '@example.invalid';
    [$code, , $loc] = $http($jar, '/register.php', ['csrf' => $csrf, 'name' => 'PI-TEST', 'email' => $email, 'password' => 'pi-pass-12345', 'password_confirm' => 'pi-pass-12345']);
    $st = $pdo->prepare('SELECT id FROM users WHERE email = :e');
    $st->execute([':e' => $email]);
    $newUid = (int) $st->fetchColumn();
    if ($newUid > 0) {
        $ids['users'][] = $newUid;
    }
    ok($code === 302 && $newUid > 0, 'реєстрація пройшла (302 → ' . $loc . ')');
    $st = $pdo->prepare('SELECT ref_code, creative_id, campaign_id FROM ad_house_signups WHERE user_id = :u');
    $st->execute([':u' => $newUid]);
    $sg = $st->fetch(PDO::FETCH_ASSOC) ?: [];
    ok(($sg['ref_code'] ?? '') === $ref && (int) ($sg['creative_id'] ?? 0) === $crInt && (int) ($sg['campaign_id'] ?? 0) === $cInt,
        'ref зберігся в сесії, реєстрацію зараховано кампанії й варіанту (ad_house_signups)');
    ok(acq_signups_count($pdo, $ref) === 1, 'лічильник «Реєстрацій» варіанту = 1');

    echo "== Увійшов і відкрив /register.php\n";
    $jar2 = $tmp . DIRECTORY_SEPARATOR . 'logged.txt';
    [$code, , $loc] = $http($jar2, '/register.php?ref=' . $ref, null, $newUid);
    ok($code === 302 && str_starts_with($loc, 'account.php'), 'перенаправлення в кабінет (302 → ' . $loc . ')');
    [$code, $acc] = $http($jar2, '/account.php', null, $newUid);
    ok($code === 200 && str_contains($acc, 'Ви вже ввійшли в акаунт'), 'у кабінеті — повідомлення «Ви вже ввійшли в акаунт»');
    [, $acc2] = $http($jar2, '/account.php', null, $newUid);
    ok(!str_contains($acc2, 'Ви вже ввійшли в акаунт'), 'повідомлення одноразове');
    $st->execute([':u' => $newUid]);
    ok(acq_signups_count($pdo, $ref) === 1, 'повторний візит на реєстрацію нічого не дописує');
} finally {
    if (is_resource($proc)) {
        proc_terminate($proc);
    }
    foreach (glob($tmp . DIRECTORY_SEPARATOR . '*') ?: [] as $f) {
        @unlink($f);
    }
    @rmdir($tmp);
    $in = static fn(array $list): string => implode(',', array_map('intval', $list ?: [0]));
    $pdo->exec('DELETE FROM ad_house_signups WHERE user_id IN (' . $in($ids['users']) . ')');
    $pdo->exec('DELETE FROM users WHERE id IN (' . $in($ids['users']) . ')');
    $pdo->exec('DELETE FROM ad_link_checks WHERE creative_id IN (' . $in($ids['creatives']) . ')');
    $pdo->exec('DELETE FROM promo_event_log WHERE creative_id IN (' . $in($ids['creatives']) . ') OR campaign_id IN (' . $in($ids['campaigns']) . ')');
    $pdo->exec('DELETE FROM ad_campaign_audience WHERE campaign_id IN (' . $in($ids['campaigns']) . ')');
    $pdo->exec('DELETE FROM ad_targets WHERE campaign_id IN (' . $in($ids['campaigns']) . ')');
    $pdo->exec('DELETE FROM ad_creatives WHERE id IN (' . $in($ids['creatives']) . ')');
    $pdo->exec('DELETE FROM ad_campaigns WHERE id IN (' . $in($ids['campaigns']) . ')');
}

echo "\n" . ($F === 0 ? "УСЕ PASS ({$T})" : "FAIL: {$F} з {$T}") . "\n";
exit($F === 0 ? 0 : 1);
