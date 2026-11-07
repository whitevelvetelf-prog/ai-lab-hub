<?php

declare(strict_types=1);

/**
 * AI LAB HUB — наскрізний тест фото й контактів оголошень Marketplace (регрес 2026-11-07: після міграції 18 фільтр
 * section='board' у mp-photo.php і mpb_contacts() відсікав усі оголошення користувачів → 404 фото, порожні контакти).
 *   php tests/mp-photo-e2e.php [http://ai-lab-hub.test]
 *
 * Тимчасово створює: автора й admin, 3 оголошення блока «Обладнання та техніка» (живе з фото; pending з фото;
 * живе з записом фото без файла) і їхні файли у photo_dir. Перевіряє фото на головній, у блоці, у підкатегорії,
 * на сторінці оголошення, у кабінеті автора, у черзі модерації; гість без cookie («інкогніто»), UA iPhone;
 * заглушку на місці відсутнього файла; «Показати контакт»; сторінку mp-photo-check.php.
 * Наприкінці видаляє тестові записи за id і лише ті файли, які створив сам. Лише CLI, лише локально.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/marketplace.php';

$fails = 0;
$total = 0;
function check(bool $cond, string $label): void
{
    global $fails, $total;
    $total++;
    echo ($cond ? '  OK   ' : '  FAIL ') . $label . "\n";
    if (!$cond) {
        $fails++;
    }
}

/** @return array{code:int,loc:string,body:string,head:string} */
function http(string $jar, string $url, ?array $post = null, array $headers = []): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true, CURLOPT_HEADER => true, CURLOPT_FOLLOWLOCATION => false,
        CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 60, CURLOPT_HTTPHEADER => $headers,
        CURLOPT_USERAGENT => 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) e2e-photo-test',
    ]);
    if ($post !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
    }
    $raw = (string) curl_exec($ch);
    $hs = (int) curl_getinfo($ch, CURLINFO_HEADER_SIZE);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);
    $head = substr($raw, 0, $hs);
    preg_match('/^Location:\s*(\S+)/mi', $head, $m);

    return ['code' => $code, 'loc' => $m[1] ?? '', 'body' => substr($raw, $hs), 'head' => $head];
}

function header_of(array $r, string $name): string
{
    return preg_match('/^' . preg_quote($name, '/') . ':\s*(.+?)\s*$/mi', $r['head'], $m) === 1 ? $m[1] : '';
}

function csrf_in_form(string $html, string $action): string
{
    return preg_match('~<form[^>]*action="' . preg_quote($action, '~') . '"[^>]*>\s*<input type="hidden" name="csrf" value="([a-f0-9]{64})"~', $html, $m) === 1 ? $m[1] : '';
}

$photoDir = rtrim((string) mp_config()['photo_dir'], '/\\');
if (!is_dir($photoDir)) {
    mkdir($photoDir, 0775, true);
}
$tmp = sys_get_temp_dir() . '/mpphoto_' . bin2hex(random_bytes(4));
@mkdir($tmp);
$jarGuest = $tmp . '/guest.txt';
$jarAuthor = $tmp . '/author.txt';
$jarAdm = $tmp . '/adm.txt';
$stamp = date('His') . random_int(100, 999);
$pass = 'Test12345!';
$authorEmail = "e2e-photo-author-{$stamp}@example.test";
$admEmail = "e2e-photo-admin-{$stamp}@example.test";
$created = ['users' => [], 'listings' => [], 'files' => []];

/** Справжній JPEG (GD), щоб перевіряти розмір і тип. */
$makeJpeg = static function (string $path, int $w, int $h): void {
    $im = imagecreatetruecolor($w, $h);
    imagefill($im, 0, 0, imagecolorallocate($im, 91, 140, 255));
    imagejpeg($im, $path, 80);
    imagedestroy($im);
};

try {
    $ins = $pdo->prepare('INSERT INTO users (name, email, password_hash, role) VALUES (:n, :e, :h, :r)');
    $ins->execute([':n' => 'E2E Photo Author', ':e' => $authorEmail, ':h' => password_hash($pass, PASSWORD_DEFAULT), ':r' => 'user']);
    $uid = (int) $pdo->lastInsertId();
    $ins->execute([':n' => 'E2E Photo Admin', ':e' => $admEmail, ':h' => password_hash($pass, PASSWORD_DEFAULT), ':r' => 'admin']);
    $aid = (int) $pdo->lastInsertId();
    $created['users'] = [$uid, $aid];
    $pdo->prepare("INSERT INTO mp_sellers (user_id, display_name, slug, is_platform, is_verified, status) VALUES (:u, 'E2E Photo Seller', :s, 0, 0, 'active')")
        ->execute([':u' => $uid, ':s' => 'u' . $uid]);
    $sellerId = (int) $pdo->lastInsertId();

    $block = (int) $pdo->query("SELECT id FROM mp_categories WHERE section = 'goods' AND parent_id IS NULL LIMIT 1")->fetchColumn();
    $sub = (int) $pdo->query("SELECT id FROM mp_categories WHERE section = 'goods' AND parent_id = $block AND is_active = 1 ORDER BY sort_order, id LIMIT 1")->fetchColumn();
    check($block > 0 && $sub > 0, "блок goods #$block і підкатегорія #$sub є");

    // [key => [status, files_exist]]
    $plan = ['live' => ['published', true], 'pending' => ['pending', true], 'lost' => ['published', false]];
    $L = [];
    foreach ($plan as $key => [$status, $withFiles]) {
        $pdo->prepare(
            "INSERT INTO mp_listings (seller_id, section, post_form, status, delivery_type, source_lang, created_by, price_type, is_remote,
                                      contact_phone, published_at, expires_at)
             VALUES (:s, 'goods', 'ad', :st, 'contact', 'uk', :u, 'none', 1, '+380000000000',
                     IF(:st2 = 'published', NOW(), NULL), IF(:st3 = 'published', NOW() + INTERVAL 30 DAY, NULL))"
        )->execute([':s' => $sellerId, ':st' => $status, ':st2' => $status, ':st3' => $status, ':u' => $uid]);
        $id = (int) $pdo->lastInsertId();
        $created['listings'][] = $id;
        $pdo->prepare('INSERT INTO mp_listing_categories (listing_id, category_id) VALUES (:l, :c)')->execute([':l' => $id, ':c' => $sub]);
        $pdo->prepare("INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, is_auto) VALUES (:id, 'uk', :t, 'Тест фото', 0)")
            ->execute([':id' => $id, ':t' => "E2E Фото {$key} {$stamp}"]);
        $hex = bin2hex(random_bytes(16));
        $file = $hex . '.jpg';
        $thumb = $hex . '_t.jpg';
        $pdo->prepare('INSERT INTO mp_listing_photos (listing_id, file_name, thumb_name, sort_order) VALUES (:l, :f, :t, 1)')
            ->execute([':l' => $id, ':f' => $file, ':t' => $thumb]);
        if ($withFiles) {
            $makeJpeg($photoDir . '/' . $file, 800, 450);
            $makeJpeg($photoDir . '/' . $thumb, 400, 225);
            $created['files'][] = $photoDir . '/' . $file;
            $created['files'][] = $photoDir . '/' . $thumb;
        }
        $L[$key] = ['id' => $id, 'file' => $file, 'thumb' => $thumb];
    }
    @unlink(__DIR__ . '/../storage/cache/mp-tree-counts.json');   // лічильники блоків — одразу з новими оголошеннями
    $src = static fn(string $name): string => 'src="/mp-photo.php?f=' . $name . '"';

    echo "Гість («інкогніто»: без cookie), UA iPhone — списки\n";
    $r = http($jarGuest, "$base/marketplace.php");
    check($r['code'] === 200 && str_contains($r['body'], $src($L['live']['thumb'])), 'головна Marketplace: мініатюра живого оголошення');
    check(!str_contains($r['body'], $L['pending']['thumb']), 'головна: pending не показано');
    $r = http($jarGuest, "$base/marketplace-category.php?id=$block");
    check($r['code'] === 200 && str_contains($r['body'], $src($L['live']['thumb'])), 'сторінка блока (спільний шаблон картки): мініатюра з mp_listing_photos');
    $r = http($jarGuest, "$base/marketplace-category.php?id=$sub");
    check($r['code'] === 200 && str_contains($r['body'], $src($L['live']['thumb'])), 'сторінка підкатегорії: мініатюра');
    check(!str_contains($r['body'], 'assets/images/logos/'), 'підкатегорія: у картках немає логотипів продуктів');
    $r = http($jarGuest, "$base/marketplace-offer.php?id={$L['live']['id']}");
    check($r['code'] === 200 && str_contains($r['body'], $src($L['live']['file'])), 'сторінка оголошення: головне фото (мініатюри галереї — лише від 2 фото)');
    $galOk = static fn(string $b, string $file): bool => str_contains($b, 'data-mp-gallery') && str_contains($b, '/assets/js/mp-gallery.js')
        && preg_match('~<a href="/mp-photo\.php\?f=' . preg_quote($file, '~') . '"[^>]*data-mp-(?:photo|gallery-main)~', $b) === 1
        && preg_match('~<a[^>]*mp-photo\.php[^>]*target="_blank"~', $b) === 0;
    check($galOk($r['body'], $L['live']['file']), 'сторінка оголошення: фото відкривається оверлеєм mp-gallery.js, без target=_blank');

    echo "Гість — видача файлів\n";
    $r = http($jarGuest, "$base/mp-photo.php?f={$L['live']['thumb']}");
    check($r['code'] === 200 && header_of($r, 'Content-Type') === 'image/jpeg' && (int) header_of($r, 'Content-Length') === filesize($photoDir . '/' . $L['live']['thumb']),
        'мініатюра: 200 image/jpeg, розмір = файлу (' . header_of($r, 'Content-Length') . ' Б)');
    check(@imagecreatefromstring($r['body']) !== false, 'тіло — справжнє зображення');
    $r = http($jarGuest, "$base/mp-photo.php?f={$L['live']['file']}");
    check($r['code'] === 200 && header_of($r, 'Content-Type') === 'image/jpeg', 'повне фото: 200 image/jpeg');
    $r = http($jarGuest, "$base/mp-photo.php?f={$L['pending']['thumb']}");
    check($r['code'] === 404, 'фото pending для гостя: 404 (права не змінились)');
    $r = http($jarGuest, "$base/mp-photo.php?f=0123456789abcdef0123456789abcdef.jpg");
    check($r['code'] === 404, 'чуже ім\'я (немає в БД): 404');
    $r = http($jarGuest, "$base/mp-photo.php?f=" . rawurlencode('../config/database.php'));
    check($r['code'] === 404, 'шлях з ../: 404');

    echo "Відсутній файл → заглушка\n";
    $r = http($jarGuest, "$base/marketplace-offer.php?id={$L['lost']['id']}");
    check($r['code'] === 200 && str_contains($r['body'], $src($L['lost']['file'])), 'сторінка оголошення з утраченим файлом відкривається');
    $r = http($jarGuest, "$base/mp-photo.php?f={$L['lost']['thumb']}");
    check($r['code'] === 200 && str_starts_with(header_of($r, 'Content-Type'), 'image/svg+xml') && header_of($r, 'X-MP-Photo-Missing') === '1',
        'утрачений файл: 200 image/svg+xml, X-MP-Photo-Missing: 1');
    check(str_contains($r['body'], '<svg') && str_contains($r['body'], '#5b8cff') && str_contains($r['body'], '#2116ad'), 'заглушка в бренд-кольорах з іконкою');
    check(str_contains(header_of($r, 'Cache-Control'), 'no-store'), 'заглушка не кешується');
    check(!is_file($photoDir . '/' . $L['lost']['thumb']), 'тест нічого не «відновлював»: файла як не було, так і немає');
    $r = http($jarGuest, "$base/mp-photo.php?f=0123456789abcdef0123456789abcdee.jpg");
    check($r['code'] === 404 && !str_contains($r['body'], '<svg'), 'немає ні файла, ні запису: 404, не заглушка');

    echo "Автор — кабінет\n";
    http($jarAuthor, "$base/login.php", ['email' => $authorEmail, 'password' => $pass]);
    $r = http($jarAuthor, "$base/marketplace-my.php?tab=active");
    check($r['code'] === 200 && str_contains($r['body'], $src($L['live']['thumb'])), '«Мої оголошення» → «Активні»: мініатюра');
    check($galOk($r['body'], $L['live']['file']), '«Мої оголошення»: мініатюра відкриває перегляд фото (оверлей)');
    $r = http($jarAuthor, "$base/marketplace-my.php?tab=pending");
    check($r['code'] === 200 && str_contains($r['body'], $src($L['pending']['thumb'])), '«Мої оголошення» → «На модерації»: мініатюра');
    $r = http($jarAuthor, "$base/mp-photo.php?f={$L['pending']['thumb']}");
    check($r['code'] === 200 && header_of($r, 'Content-Type') === 'image/jpeg', 'автор бачить фото свого pending: 200');

    echo "Admin — черга модерації, контакти, перевірка зображень\n";
    http($jarAdm, "$base/login.php", ['email' => $admEmail, 'password' => $pass]);
    $r = http($jarAdm, "$base/mp-moderation.php?id={$L['pending']['id']}");
    check($r['code'] === 200 && str_contains($r['body'], $src($L['pending']['thumb'])), 'mp-moderation.php: мініатюра pending');
    check($galOk($r['body'], $L['pending']['file']), 'mp-moderation.php: фото відкривається оверлеєм, без target=_blank');
    $r = http($jarAdm, "$base/mp-photo.php?f={$L['pending']['file']}");
    check($r['code'] === 200, 'admin бачить фото pending: 200');
    $offer = http($jarAdm, "$base/marketplace-offer.php?id={$L['live']['id']}");
    $csrf = csrf_in_form($offer['body'], 'mp-contact.php');
    check($csrf !== '', 'форма «Показати контакт» з CSRF є');
    $r = http($jarAdm, "$base/mp-contact.php", ['csrf' => $csrf, 'id' => $L['live']['id']], ['Accept: application/json']);
    $j = json_decode($r['body'], true);
    check($r['code'] === 200 && ($j['ok'] ?? false) === true && str_contains($r['body'], '380000000000'), '«Показати контакт»: телефон повернуто (раніше — порожньо)');
    $r = http($jarAdm, "$base/mp-photo-check.php");
    check($r['code'] === 200 && str_contains($r['body'], 'Перевірка зображень Marketplace'), 'mp-photo-check.php відкривається для admin');
    check(str_contains($r['body'], 'mp-moderation.php?id=' . $L['lost']['id']) && str_contains($r['body'], $L['lost']['thumb']), 'у переліку є оголошення з утраченим файлом');
    check(!str_contains($r['body'], 'mp-moderation.php?id=' . $L['live']['id'] . '"'), 'оголошення з файлами в переліку немає');
    check(preg_match('/відсутніх файлів: <strong>(\d+)<\/strong>/u', $r['body'], $mc) === 1 && (int) $mc[1] >= 2, 'лічильник відсутніх файлів (' . ($mc[1] ?? '?') . ')');
    $r = http($jarGuest, "$base/mp-photo-check.php");
    check($r['code'] === 404, 'mp-photo-check.php для гостя: 404');
    $r = http($jarAuthor, "$base/mp-photo-check.php");
    check($r['code'] === 404, 'mp-photo-check.php для звичайного користувача: 404');
} finally {
    echo "Прибирання тестових записів\n";
    foreach ($created['listings'] as $id) {
        foreach (['mp_listing_photos', 'mp_listing_categories', 'mp_listing_translations', 'mp_listing_stats_daily', 'mp_moderation_log', 'mp_listing_places', 'mp_contact_reveals'] as $tbl) {
            try {
                $pdo->prepare("DELETE FROM $tbl WHERE listing_id = :id")->execute([':id' => $id]);
            } catch (Throwable $e) {
            }
        }
        $pdo->prepare('DELETE FROM mp_listings WHERE id = :id')->execute([':id' => $id]);
    }
    foreach ($created['users'] as $id) {
        foreach (['mp_contact_reveals', 'mp_email_verifications', 'mp_form_drafts', 'mp_sellers'] as $tbl) {
            try {
                $pdo->prepare("DELETE FROM $tbl WHERE user_id = :u")->execute([':u' => $id]);
            } catch (Throwable $e) {
            }
        }
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $id]);
    }
    foreach ($created['files'] as $f) {
        @unlink($f);   // лише файли, створені цим тестом
    }
    @unlink(__DIR__ . '/../storage/cache/mp-tree-counts.json');
    echo '  видалено: users ' . implode(',', $created['users']) . '; listings ' . implode(',', $created['listings']) . '; файлів ' . count($created['files']) . "\n";
    array_map('unlink', glob($tmp . '/*') ?: []);
    @rmdir($tmp);
}

echo "\nРазом: " . ($total - $fails) . " / $total" . ($fails > 0 ? " — FAIL: $fails" : ' — усе гаразд') . "\n";
exit($fails > 0 ? 1 : 0);
