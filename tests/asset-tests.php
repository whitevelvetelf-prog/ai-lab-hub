<?php

declare(strict_types=1);

/**
 * AI LAB HUB — перевірки «Цифрових матеріалів» (ЛИШЕ локально, CLI):
 *   php tests/asset-tests.php [http://ai-lab-hub.test]
 *
 * Створює тимчасові матеріали від тестового користувача, тимчасово відкриває маркетплейс
 * (marketplace_public = 1) — у finally все повертається, тестові рядки й файли видаляються. PASS/FAIL.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$_SERVER['HTTP_USER_AGENT'] = 'Mozilla/5.0 (Windows NT 10.0) asset-tests';
$_SERVER['REMOTE_ADDR'] = '203.0.113.7';
require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/asset.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
$fails = 0;
$results = [];
$check = static function (string $group, string $name, bool $ok, string $info = '') use (&$fails, &$results): void {
    $results[$group][] = [$ok, $name, $info];
    $fails += $ok ? 0 : 1;
};
$http = static function (string $path, array $headers = []) use ($base): array {
    $h = "User-Agent: Mozilla/5.0 (Windows NT 10.0) asset-tests\r\n" . implode('', array_map(static fn($x) => $x . "\r\n", $headers));
    $ctx = stream_context_create(['http' => ['header' => $h, 'ignore_errors' => true, 'timeout' => 30, 'follow_location' => 0]]);
    $body = @file_get_contents($base . '/' . ltrim($path, '/'), false, $ctx);
    $code = 0;
    $hdrs = [];
    foreach ($http_response_header ?? [] as $line) {
        if (preg_match('~^HTTP/\S+\s+(\d+)~', $line, $m)) {
            $code = (int) $m[1];
        } elseif (str_contains($line, ':')) {
            [$k, $v] = explode(':', $line, 2);
            $hdrs[strtolower(trim($k))] = trim($v);
        }
    }

    return [$code, (string) $body, $hdrs];
};

$tmpDir = sys_get_temp_dir() . '/ast-tests-' . bin2hex(random_bytes(4));
@mkdir($tmpDir);
$mkImage = static function (string $file, int $seed, string $fmt = 'jpg') use ($tmpDir): string {
    $im = imagecreatetruecolor(1600, 1200);
    for ($y = 0; $y < 1200; $y += 4) {
        imagefilledrectangle($im, 0, $y, 1599, $y + 3, imagecolorallocate($im, ($y + $seed * 40) % 256, (int) ($y / 5) % 256, (200 + $seed * 17) % 256));
    }
    imagefilledellipse($im, 500 + $seed * 90, 600, 500, 500, imagecolorallocate($im, 250, 220, (40 * $seed) % 256));
    $path = $tmpDir . '/' . $file;
    $fmt === 'png' ? imagepng($im, $path) : imagejpeg($im, $path, 92);
    imagedestroy($im);

    return $path;
};

$oldPublic = site_setting($pdo, 'marketplace_public', '0');
$created = [];
$claims = [];
$userId = (int) $pdo->query("SELECT id FROM users WHERE role <> 'admin' ORDER BY id DESC LIMIT 1")->fetchColumn();
$admin = (int) $pdo->query("SELECT id FROM users WHERE role = 'admin' ORDER BY id LIMIT 1")->fetchColumn();
$fakeHash = hash('sha256', 'asset-tests-' . microtime());

try {
    site_settings_save($pdo, ['marketplace_public' => '1']);
    $caps = ast_capabilities();
    $check('сервер', 'GD і fileinfo є (інакше публікація вимкнена з поясненням)', $caps['ok'], $caps['message']);
    $sellerId = mpb_seller_for_user($pdo, $userId, 'Asset Tester');
    $s = ast_settings($pdo);

    // --- Файли ---------------------------------------------------------------
    $fake = $tmpDir . '/fake.png';
    file_put_contents($fake, "<?php echo 'x'; ?>\x89PNG");
    $check('файли', 'не-зображення з розширенням .png відхиляється (MIME за вмістом)', ast_inspect_path($fake, 20 << 20) === 'err_file_type');
    $img1 = $mkImage('a.jpg', 1);
    $check('файли', 'завеликий файл відхиляється', ast_inspect_path($img1, 1000) === 'err_file_size');
    $i1 = ast_inspect_path($img1, (int) $s['max_mb'] << 20);
    $check('файли', 'JPG приймається', is_array($i1) && $i1['mime'] === 'image/jpeg' && $i1['w'] === 1600);

    $d = ['title' => 'TEST asset A', 'desc' => 'Тест', 'kind' => 'illustration', 'origin' => 'ai_assisted', 'license' => 'personal_free',
        'license_custom' => '', 'allow_download' => true, 'alt' => 'Тестове зображення з колом', 'tags' => 'тест, коло', 'char_name' => '',
        'char_desc' => '', 'char_terms' => '', 'density' => 'normal', 'noimageindex' => true, 'contact_email' => 'author@example.test', 'contact_telegram' => ''];
    $idA = ast_save($pdo, $d, null, $userId, $sellerId, 'uk', $i1, false);
    $created[] = $idA;
    $a = ast_listing($pdo, $idA, 'uk');
    $check('збереження', 'новий матеріал — на модерації, sha256 і dHash збережено, декларація з датою й користувачем',
        $a !== null && $a['status'] === 'pending' && $a['orig_sha256'] === hash_file('sha256', $img1) && strlen((string) $a['dhash']) === 16
        && (int) $a['ownership_user_id'] === $userId && $a['ownership_declared_at'] !== null);

    // --- Сховище й превʼю --------------------------------------------------------
    $origPath = ast_path('original', (string) $a['orig_name']);
    $real = realpath((string) $origPath);
    $check('сховище', 'оригінал лежить поза public/', $real !== false && !str_starts_with($real, (string) realpath(__DIR__ . '/../public')));
    [$code] = $http('storage/assets/original/' . $a['orig_name']);
    [$code2] = $http('../storage/assets/original/' . $a['orig_name']);
    $check('сховище', 'оригінал не відкривається за прямою адресою', $code !== 200 && $code2 !== 200, "codes={$code}/{$code2}");
    $prevPath = (string) ast_path('preview', (string) $a['preview_name']);
    $pi = @getimagesize($prevPath);
    $check('превʼю', 'превʼю зменшене (довша сторона ≤ assets_preview_px)', $pi !== false && max($pi[0], $pi[1]) <= (int) $s['preview_px'] && max($pi[0], $pi[1]) < 1600);
    $raw = (string) file_get_contents($prevPath);
    $check('превʼю', 'у превʼю немає EXIF/XMP/GPS', !str_contains($raw, 'Exif') && !str_contains($raw, 'XMP ') && !str_contains($raw, 'x:xmpmeta'));
    // Водяний знак: превʼю відрізняється від простого зменшення того самого оригіналу.
    $plain = mpb_gd_flatten(mpb_gd_fit(ast_gd_load($img1, 'image/jpeg'), (int) $s['preview_px']));
    $wm = ast_gd_load($prevPath, str_ends_with($prevPath, '.webp') ? 'image/webp' : 'image/jpeg');
    $diff = 0;
    $n = 0;
    for ($y = 5; $y < imagesy($wm); $y += 7) {
        for ($x = 5; $x < imagesx($wm); $x += 7) {
            $c1 = imagecolorat($plain, $x, $y);
            $c2 = imagecolorat($wm, $x, $y);
            $diff += abs((($c1 >> 16) & 255) - (($c2 >> 16) & 255)) > 25 ? 1 : 0;
            $n++;
        }
    }
    $check('превʼю', 'видимий водяний знак по всьому зображенню (≥3% пікселів змінено)', $n > 0 && $diff / $n > 0.03, round($diff / max(1, $n) * 100, 1) . '%');

    // --- Підписані адреси -------------------------------------------------------
    [$code] = $http('asset-preview.php?id=' . $idA . '&e=' . (time() + 600) . '&s=deadbeef');
    $check('видача превʼю', 'адреса без правильного підпису — 403', $code === 403, "http={$code}");
    $past = time() - 60;
    [$code] = $http('asset-preview.php?id=' . $idA . '&e=' . $past . '&s=' . ast_sign('pv|' . $idA . '|' . $past));
    $check('видача превʼю', 'прострочена адреса — 403', $code === 403, "http={$code}");
    [$code] = $http(ast_preview_url($pdo, $idA));
    $check('видача превʼю', 'неопублікований матеріал публічно не віддається', $code === 404, "http={$code}");
    ast_approve($pdo, $idA, $admin);
    [$code, $body, $h] = $http(ast_preview_url($pdo, $idA));
    $check('видача превʼю', 'підписана адреса — 200, Cache-Control private, X-Robots-Tag noimageindex',
        $code === 200 && str_contains($h['cache-control'] ?? '', 'private') && str_contains($h['x-robots-tag'] ?? '', 'noimageindex') && strlen($body) > 1000,
        "http={$code} cc=" . ($h['cache-control'] ?? '') . ' xr=' . ($h['x-robots-tag'] ?? ''));
    [$code] = $http(ast_preview_url($pdo, $idA), ['Referer: https://evil.example/page', 'Sec-Fetch-Site: cross-site']);
    $hot = (int) $pdo->query("SELECT COUNT(*) FROM asset_suspicious WHERE reason = 'hotlink' AND detail = 'asset #{$idA}'")->fetchColumn();
    $check('видача превʼю', 'вставлення на чужий сайт — лише сигнал у журнал, превʼю віддається', $code === 200 && $hot > 0, "http={$code} signals={$hot}");

    // --- Ліміт запитів ----------------------------------------------------------
    $allowed = 0;
    for ($i = 0; $i < (int) $s['preview_per_min'] + 3; $i++) {
        $allowed += ast_preview_gate($pdo, $fakeHash, $idA, null) ? 1 : 0;
    }
    $check('антискрапінг', 'ліміт запитів за хвилину спрацьовує й ставить тимчасовий блок',
        $allowed <= (int) $s['preview_per_min'] && ast_hash_blocked($pdo, $fakeHash), "allowed={$allowed}");

    // --- Завантаження оригіналу -------------------------------------------------
    $a = ast_listing($pdo, $idA, 'uk');
    $check('завантаження', 'personal_free з дозволом автора — можна; view_only / commercial_paid — ні',
        ast_downloadable($pdo, $a) && !ast_downloadable($pdo, ['license_code' => 'view_only', 'allow_download' => 1])
        && !ast_downloadable($pdo, ['license_code' => 'commercial_paid', 'allow_download' => 1]) && !ast_downloadable($pdo, ['license_code' => 'custom', 'allow_download' => 0]));
    $token = ast_token_create($pdo, $idA, $admin);
    $check('завантаження', 'токен чужого користувача не працює', ast_token_consume($pdo, $token, $userId) === null);
    $got = ast_token_consume($pdo, $token, $admin);
    $check('завантаження', 'токен одноразовий', $got === $idA && ast_token_consume($pdo, $token, $admin) === null);
    $t2 = ast_token_create($pdo, $idA, $admin);
    $pdo->prepare('UPDATE asset_download_tokens SET expires_at = NOW() - INTERVAL 1 MINUTE WHERE token = :t')->execute([':t' => hash('sha256', $t2)]);
    $check('завантаження', 'прострочений токен не працює', ast_token_consume($pdo, $t2, $admin) === null);
    $file = ast_issue_download($pdo, $a, $admin);
    $rec = $file !== null ? $pdo->query("SELECT * FROM asset_downloads WHERE download_id = " . $pdo->quote($file['download_id']))->fetch() : false;
    $check('завантаження', 'виданий файл: XMP з download_id і автором, запис у asset_downloads (sha256 файлу, хеш IP)',
        $file !== null && str_contains($file['bytes'], $file['download_id']) && str_contains($file['bytes'], htmlspecialchars((string) $a['seller_name'], ENT_XML1 | ENT_QUOTES, 'UTF-8')) && @imagecreatefromstring($file['bytes']) !== false
        && $rec !== false && $rec['sha256'] === hash('sha256', $file['bytes']) && strlen((string) $rec['anon_hash']) === 64 && !str_contains((string) $rec['anon_hash'], '203.0.113.7'));
    $check('завантаження', 'денний лічильник рахує видачі', ast_downloads_today($pdo, $admin) >= 1);
    [$code] = $http('asset-download.php?t=' . $token);
    $check('завантаження', 'без входу завантаження недоступне', in_array($code, [401, 302, 303], true), "http={$code}");

    // --- Схожість ----------------------------------------------------------------
    $img2 = $mkImage('b.png', 1, 'png');
    $i2 = ast_inspect_path($img2, (int) $s['max_mb'] << 20);
    $idB = ast_save($pdo, ['title' => 'TEST asset B'] + $d, null, $userId, $sellerId, 'uk', $i2, false);
    $created[] = $idB;
    $sim = json_decode((string) ast_listing($pdo, $idB, 'uk')['similar_json'], true) ?: [];
    $check('схожість', 'схоже зображення позначається для модератора («схоже на #N»)', in_array($idA, array_column($sim, 'id'), true), json_encode($sim));
    $img3 = $mkImage('c.jpg', 6);
    $i3 = ast_inspect_path($img3, (int) $s['max_mb'] << 20);
    $idC = ast_save($pdo, ['title' => 'TEST asset C', 'kind' => 'character', 'char_name' => 'Тестовий'] + $d, null, $userId, $sellerId, 'uk', $i3, false);
    $created[] = $idC;
    $simC = json_decode((string) ast_listing($pdo, $idC, 'uk')['similar_json'], true) ?: [];
    $check('схожість', 'інше зображення не позначається як схоже на A', !in_array($idA, array_column($simC, 'id'), true), json_encode($simC));

    // --- Скарги ------------------------------------------------------------------
    $cid = ast_claim_create($pdo, ['ref' => 'https://example/asset.php?id=' . $idA, 'what' => 'Це моя ілюстрація, опублікована раніше.', 'evidence' => 'https://example.org/orig',
        'name' => 'Claimant Test', 'email' => 'claimant@example.test', 'contact' => '']);
    $claims[] = $cid;
    $c = ast_claim($pdo, $cid);
    $check('скарги', 'скарга ховає матеріал до розгляду (copyright_auto_hide)', $c['status'] === 'content_disabled' && $c['listing_status'] === 'disabled' && (int) $c['auto_hidden'] === 1);
    [$code] = $http('asset.php?id=' . $idA);
    $check('скарги', 'прихований матеріал публічно недоступний', $code === 404, "http={$code}");
    $check('скарги', 'зустрічна заява приймається від власника, повторно — ні',
        !ast_claim_counter($pdo, $cid, $admin, 'чужий') && ast_claim_counter($pdo, $cid, $userId, 'У мене є ескізи й файли процесу.') && !ast_claim_counter($pdo, $cid, $userId, 'ще раз'));
    ast_claim_decide($pdo, $cid, $admin, 'restored', 'Тест');
    $check('скарги', 'відновлення повертає публікацію, strike не рахується', ast_listing($pdo, $idA, 'uk')['status'] === 'published' && ast_strikes($pdo, $userId) === 0);
    $limit = (int) $s['strikes_limit'];
    for ($i = 0; $i < $limit; $i++) {
        $cx = ast_claim_create($pdo, ['ref' => '#' . $idA, 'what' => 'Повторне порушення для тесту лічильника.', 'evidence' => '', 'name' => 'Claimant', 'email' => 'claimant@example.test', 'contact' => '']);
        $claims[] = $cx;
        ast_claim_decide($pdo, $cx, $admin, 'content_disabled', '');
    }
    $check('скарги', 'повторні порушення рахуються; після ліміту публікацію активів заблоковано', ast_strikes($pdo, $userId) === $limit && ast_posting_blocked($pdo, $userId), 'strikes=' . ast_strikes($pdo, $userId));

    // --- Сигнали для ШІ й сторінки ----------------------------------------------
    [, $robots] = $http('robots.txt');
    $check('ШІ-краулери', 'robots.txt забороняє GPTBot, CCBot, ClaudeBot та ін. сторінки активів',
        str_contains($robots, 'User-agent: GPTBot') && str_contains($robots, 'User-agent: CCBot') && str_contains($robots, 'User-agent: ClaudeBot') && str_contains($robots, 'Disallow: /asset.php'));
    $pdo->prepare("UPDATE mp_listings SET status = 'published' WHERE id = :id")->execute([':id' => $idA]);
    [$code, $html] = $http('asset.php?id=' . $idA);
    $check('сторінки', 'сторінка активу: noai/noimageai, alt, ліцензія, походження, кнопка скарги',
        $code === 200 && str_contains($html, 'noai, noimageai') && str_contains($html, 'alt="Тестове зображення з колом"') && str_contains($html, 'id="license"')
        && str_contains($html, 'ast-origin--ai_assisted') && str_contains($html, 'copyright-report.php?listing=' . $idA), "http={$code}");
    [$code, $html] = $http('assets.php');
    $check('сторінки', 'список активів показує опублікований матеріал', $code === 200 && str_contains($html, 'TEST asset A'), "http={$code}");
    foreach (['marketplace.php', 'listings.php?type=job', 'copyright-policy.php', 'copyright-report.php', 'index.php'] as $p) {
        [$code, $html] = $http($p);
        $check('сторінки', $p . ' відкривається без помилок', $code === 200 && stripos($html, 'fatal error') === false, "http={$code}");
    }
} catch (Throwable $e) {
    $check('загальне', 'виняток: ' . $e->getMessage() . ' @' . $e->getLine(), false);
} finally {
    foreach ($created as $id) {
        $r = $pdo->query('SELECT orig_name, preview_name FROM mp_assets WHERE listing_id = ' . (int) $id)->fetch();
        if ($r) {
            ast_delete_files($r['orig_name'], $r['preview_name']);
        }
        foreach (['mp_assets' => 'listing_id', 'mp_listing_translations' => 'listing_id', 'mp_moderation_log' => 'listing_id', 'asset_downloads' => 'asset_id',
                  'asset_download_tokens' => 'asset_id', 'asset_access_log' => 'asset_id', 'mp_listings' => 'id'] as $tbl => $col) {
            try {
                $pdo->exec("DELETE FROM {$tbl} WHERE {$col} = " . (int) $id);
            } catch (Throwable $e) {
            }
        }
        $pdo->exec("DELETE FROM asset_suspicious WHERE detail = 'asset #" . (int) $id . "'");
    }
    foreach ($claims as $cid) {
        $pdo->exec('DELETE FROM copyright_claim_log WHERE claim_id = ' . (int) $cid);
        $pdo->exec('DELETE FROM copyright_strikes WHERE claim_id = ' . (int) $cid);
        $pdo->exec('DELETE FROM copyright_claims WHERE id = ' . (int) $cid);
    }
    $pdo->prepare('DELETE FROM asset_access_log WHERE anon_hash = :h')->execute([':h' => $fakeHash]);
    $pdo->prepare('DELETE FROM asset_suspicious WHERE anon_hash = :h')->execute([':h' => $fakeHash]);
    $pdo->prepare('DELETE FROM asset_blocked_hashes WHERE anon_hash = :h')->execute([':h' => $fakeHash]);
    $pdo->exec("DELETE FROM mail_queue WHERE to_email IN ('claimant@example.test')");
    site_settings_save($pdo, ['marketplace_public' => $oldPublic]);
    array_map('unlink', glob($tmpDir . '/*') ?: []);
    @rmdir($tmpDir);
}

foreach ($results as $group => $rows) {
    echo (in_array(false, array_column($rows, 0), true) ? 'FAIL ' : 'PASS ') . $group . "\n";
    foreach ($rows as [$ok, $name, $info]) {
        echo '   ' . ($ok ? 'ok   ' : 'FAIL ') . $name . ($info !== '' && !$ok ? ' — ' . $info : '') . "\n";
    }
}
echo $fails === 0 ? "\nУСЕ PASS\n" : "\nFAIL: {$fails}\n";
exit($fails === 0 ? 0 : 1);
