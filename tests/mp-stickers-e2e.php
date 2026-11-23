<?php

declare(strict_types=1);

/**
 * AI LAB HUB — наскрізний тест стікерів «Еля» в повідомленнях (2026-11-23, міграція № 32 — EN-підписи).
 *   php tests/mp-stickers-e2e.php [http://ai-lab-hub.test]
 *
 * Перевіряє: 18 PNG 512×512 (200, image/png), список стікерів у data-emoji форми, надсилання стікера (у БД — маркер,
 * у відповіді й на сторінці — картинка, підпис, «Копіювати» / «Поділитися»), підпис мовою сторінки (EN), превʼю в списку
 * розмов («🐱 Дякую!»), невідомий / змішаний / шкідливий маркер — звичайний екранований текст. Тестові записи видаляються. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mp-messages.php';

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

/** @return array{code:int,loc:string,body:string,headers:string} */
function http(string $jar, string $url, ?array $post = null, array $headers = [], bool $multipart = false): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true, CURLOPT_HEADER => true, CURLOPT_FOLLOWLOCATION => false,
        CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 60, CURLOPT_HTTPHEADER => $headers,
        CURLOPT_USERAGENT => 'Mozilla/5.0 mp-stickers-e2e',
    ]);
    if ($post !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $multipart ? $post : http_build_query($post));
    }
    $raw = (string) curl_exec($ch);
    $hs = (int) curl_getinfo($ch, CURLINFO_HEADER_SIZE);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);
    $head = substr($raw, 0, $hs);
    preg_match('/^Location:\s*(\S+)/mi', $head, $m);

    return ['code' => $code, 'loc' => $m[1] ?? '', 'body' => substr($raw, $hs), 'headers' => $head];
}

function csrf_of(string $html): string
{
    return preg_match('/name="csrf" value="([a-f0-9]{64})"/', $html, $m) === 1 ? $m[1] : '';
}

function login(string $jar, string $base, string $email, string $pass): bool
{
    $r = http($jar, "$base/login.php");
    preg_match('/name="csrf" value="([^"]+)"/', $r['body'], $m);

    return http($jar, "$base/login.php", ['email' => $email, 'password' => $pass, 'csrf' => $m[1] ?? ''])['code'] === 302;
}

function jbody(array $r): array
{
    $j = json_decode($r['body'], true);

    return is_array($j) ? $j : ['ok' => false, 'error' => 'nojson:' . $r['code']];
}

function last_row(array $j): string
{
    $msgs = $j['messages'] ?? [];

    return (string) (($msgs[count($msgs) - 1] ?? [])['row_html'] ?? '');
}

if (!msg_enabled($pdo) || !msg_chat_ready($pdo)) {
    fwrite(STDERR, "messaging disabled locally or migration № 30 not applied\n");
    exit(2);
}

$tag = bin2hex(random_bytes(3));
$pass = 'E2e-' . bin2hex(random_bytes(6));
$users = [];
$listings = [];
$sellers = [];
$convIds = [];
$mkUser = static function (string $name) use ($pdo, $tag, $pass, &$users): array {
    $email = "stk-$name-$tag@example.test";
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role, created_at) VALUES (:n, :e, :h, 'user', NOW() - INTERVAL 30 DAY)")
        ->execute([':n' => "STK $name $tag", ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT)]);
    $id = (int) $pdo->lastInsertId();
    $pdo->prepare('INSERT INTO mp_email_verifications (user_id, email, token_hash, created_at, expires_at, verified_at)
                   VALUES (:u, :e, :t, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 3 DAY)')
        ->execute([':u' => $id, ':e' => $email, ':t' => hash('sha256', $email)]);
    $users[] = $id;

    return ['id' => $id, 'email' => $email];
};
$jar = static fn(): string => (string) tempnam(sys_get_temp_dir(), 'stk');
$send = static function (string $jarFile, string $page, int $conv, string $body) use ($base): array {
    return jbody(http($jarFile, "$base/mp-thread.php", ['csrf' => csrf_of($page), 'action' => 'send', 'id' => (string) $conv, 'since' => '0', 'body' => $body],
        ['Accept: application/json'], true));
};

$buyer = $mkUser('buyer');
$seller = $mkUser('seller');
[$jB, $jS] = [$jar(), $jar()];
$sid = mpb_seller_for_user($pdo, $seller['id'], 'Seller ' . $seller['id']);
$sellers[] = $sid;
$pdo->prepare("INSERT INTO mp_listings (section, post_form, seller_id, status, delivery_type, price_type, source_lang, contact_name, contact_phone,
                   published_at, expires_at, contact_mode) VALUES ('other', 'ad', :s, 'published', 'contact', 'none', 'uk', 'Тест', '+380501112233',
                   NOW(), NOW() + INTERVAL 30 DAY, 'both')")->execute([':s' => $sid]);
$lid = (int) $pdo->lastInsertId();
$listings[] = $lid;
$pdo->prepare("INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc) VALUES (:l, 'uk', :t, 'Опис')")->execute([':l' => $lid, ':t' => "STK listing $tag"]);

try {
    echo "1. Файли стікерів\n";
    $okFiles = 0;
    foreach (MSG_STICKERS as $id) {
        $abs = __DIR__ . '/../public' . MSG_STICKER_DIR . $id . '.png';
        $size = is_file($abs) ? @getimagesize($abs) : false;
        $r = http($jB, $base . MSG_STICKER_DIR . $id . '.png');
        $okFiles += ($size !== false && $size[0] === 512 && $size[1] === 512 && $r['code'] === 200 && stripos($r['headers'], 'Content-Type: image/png') !== false) ? 1 : 0;
    }
    check($okFiles === 18 && count(MSG_STICKERS) === 18, '18 PNG 512×512, віддаються як image/png');
    $en = $pdo->query("SELECT COUNT(*) FROM ui_translations WHERE lang = 'en' AND key_name LIKE 'msg\\_sticker%'")->fetchColumn();
    check((int) $en === 25, 'EN-підписи в ui_translations (25)');

    check(login($jB, $base, $buyer['email'], $pass) && login($jS, $base, $seller['email'], $pass), 'вхід тестових користувачів');

    echo "2. Надсилання стікера\n";
    $f = http($jB, "$base/mp-thread.php?listing=$lid");
    check(str_contains($f['body'], 'stickerList') && substr_count(html_entity_decode($f['body']), '{"id":"') === 18, 'форма першого повідомлення: 18 стікерів у data-emoji');
    $r = http($jB, "$base/mp-thread.php", ['csrf' => csrf_of($f['body']), 'action' => 'start', 'listing' => $lid, 'body' => msg_sticker_body('hello')]);
    preg_match('/[?&]c=(\d+)/', $r['loc'], $m);
    $conv = (int) ($m[1] ?? 0);
    $convIds[] = $conv;
    check($r['code'] === 303 && $conv > 0, 'стікер може бути першим повідомленням розмови');
    $pg = http($jB, "$base/mp-messages.php?c=$conv")['body'];
    $j = $send($jB, $pg, $conv, msg_sticker_body('thanks'));
    $row = last_row($j);
    check(($j['ok'] ?? false) === true && str_contains($row, 'msg-row--sticker') && str_contains($row, MSG_STICKER_DIR . 'thanks.png'), 'відповідь JSON: рядок зі стікером');
    check(str_contains($row, 'data-sticker-copy') && str_contains($row, 'data-sticker-share') && str_contains($row, 'Дякую!') && !str_contains($row, '[[sticker'),
        'кнопки «Копіювати» й «Поділитися», підпис, без сирого маркера');
    $st = $pdo->prepare('SELECT body FROM mp_messages WHERE conversation_id = :c ORDER BY id DESC LIMIT 1');
    $st->execute([':c' => $conv]);
    check($st->fetchColumn() === '[[sticker:elya/thanks]]', 'у БД — маркер [[sticker:elya/thanks]]');

    echo "3. Показ у співрозмовника\n";
    $sp = http($jS, "$base/mp-messages.php?c=$conv")['body'];
    check(substr_count($sp, 'class="msg-sticker"') === 2 && str_contains($sp, 'alt="Стікер Елі: Привіт!"'), 'автор бачить обидва стікери з alt');
    check(str_contains($sp, '🐱 Дякую!'), 'превʼю в списку розмов: «🐱 Дякую!»');
    $r = http($jS, "$base/mp-messages.php?c=$conv&lang=en");
    $spEn = in_array($r['code'], [301, 302, 303], true) ? http($jS, "$base/mp-messages.php?c=$conv")['body'] : $r['body'];
    check(str_contains($spEn, '>Thank you!<') && str_contains($spEn, '> Copy<'), 'англійська сторінка: підпис «Thank you!», кнопка «Copy»');
    http($jS, "$base/mp-messages.php?lang=uk");

    echo "4. Не стікер — звичайний текст\n";
    foreach (['[[sticker:elya/nope]]' => 'невідомий id', '[[sticker:elya/hello]] ок' => 'маркер + текст', '[[sticker:elya/<b>x</b>]]' => 'шкідливий маркер'] as $body => $label) {
        $row = last_row($j = $send($jB, $pg, $conv, $body));
        check(($j['ok'] ?? false) === true && !str_contains($row, 'msg-sticker') && str_contains($row, htmlspecialchars($body, ENT_QUOTES)), $label . ' → екранований текст');
    }
} finally {
    foreach (array_unique(array_filter($convIds)) as $cid) {
        foreach (['mp_messages', 'mp_conversation_state', 'mp_message_reports', 'mp_message_emails', 'mp_admin_access_log'] as $tbl) {
            $pdo->prepare("DELETE FROM $tbl WHERE conversation_id = :c")->execute([':c' => $cid]);
        }
        $pdo->prepare('DELETE FROM mp_conversations WHERE id = :c')->execute([':c' => $cid]);
    }
    foreach ($listings as $id) {
        foreach (['mp_listing_translations', 'mp_listing_categories', 'mp_listing_photos', 'mp_moderation_log', 'mp_contact_reveals', 'mp_notifications',
                     'mp_listing_places', 'mp_listing_stats_daily', 'mp_listing_views_daily'] as $tbl) {
            try {
                $pdo->prepare("DELETE FROM $tbl WHERE listing_id = :id")->execute([':id' => $id]);
            } catch (Throwable) {
            }
        }
        $pdo->prepare('DELETE FROM mp_listings WHERE id = :id')->execute([':id' => $id]);
    }
    foreach (array_unique($sellers) as $id) {
        $pdo->prepare('DELETE FROM mp_sellers WHERE id = :id')->execute([':id' => $id]);
    }
    foreach ($users as $id) {
        foreach (['mp_email_verifications', 'mp_notify_prefs', 'mp_user_flags', 'mp_user_sanctions', 'mp_notifications', 'mp_form_drafts'] as $tbl) {
            try {
                $pdo->prepare("DELETE FROM $tbl WHERE user_id = :u")->execute([':u' => $id]);
            } catch (Throwable) {
            }
        }
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $id]);
    }
    $pdo->prepare('DELETE FROM mail_queue WHERE to_email LIKE :e')->execute([':e' => "stk-%-$tag@example.test"]);
    foreach ([$jB, $jS] as $file) {
        @unlink($file);
    }
}

echo "\n" . ($total - $fails) . " / $total OK" . ($fails > 0 ? " — FAILED: $fails" : '') . "\n";
exit($fails > 0 ? 1 : 0);
