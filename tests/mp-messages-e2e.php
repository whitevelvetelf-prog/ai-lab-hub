<?php

declare(strict_types=1);

/**
 * AI LAB HUB — наскрізний тест внутрішніх повідомлень Marketplace (HTTP до локального сайту + БД).
 *   php tests/mp-messages-e2e.php [http://ai-lab-hub.test]
 *
 * Потрібно локально: config/marketplace.local.php → 'messaging_enabled' => true, 'messaging_email_enabled' => true,
 * 'messaging_secret' => '…16+ символів', 'mail_transport' => 'log', public_enabled; міграції № 22–23.
 * Перевіряє: початок розмови, відповідь, лічильники й прочитане, опитування (ETag/304, частота), contact_mode у трьох
 * режимах (і форма подачі), спільну скриньку платформи, ліміти й автопрапор, блокування, скаргу зі знімком, журнал
 * доступу, строк зберігання, екранування HTML (XSS), чужу розмову за id (IDOR), CSRF, гостя, заголовки no-store/noindex,
 * листи без тексту, відсутність тексту повідомлень у журналах/пошуку/кеші перекладів.
 * Екранування перевіряється нешкідливими HTML-маркерами (<b>, атрибут onclick): якщо вони виведені як текст — будь-яка
 * розмітка теж. Тестові записи видаляються за id наприкінці. Лише CLI.
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
function http(string $jar, string $url, ?array $post = null, array $headers = []): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true, CURLOPT_HEADER => true, CURLOPT_FOLLOWLOCATION => false,
        CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 60, CURLOPT_HTTPHEADER => $headers,
        CURLOPT_USERAGENT => 'Mozilla/5.0 mp-messages-e2e',
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
    $r = http($jar, "$base/login.php", ['email' => $email, 'password' => $pass, 'csrf' => $m[1] ?? '']);

    return $r['code'] === 302;
}

/** Код помилки з JSON-відповіді ('ok' — без помилки). */
function jerr(array $r): string
{
    $j = json_decode($r['body'], true);

    return is_array($j) ? (string) ($j['error'] ?? 'ok') : 'nojson:' . $r['code'];
}

if (!msg_enabled($pdo)) {
    fwrite(STDERR, "messaging is disabled locally (config/marketplace.local.php) or migration № 22 not applied\n");
    exit(2);
}

$tag = bin2hex(random_bytes(3));
$pass = 'E2e-' . bin2hex(random_bytes(6));
$users = [];
$listings = [];
$sellers = [];
$mkUser = static function (string $name, string $role, bool $young = false) use ($pdo, $tag, $pass, &$users): array {
    $email = "msg-$name-$tag@example.test";
    $pdo->prepare('INSERT INTO users (name, email, password_hash, role, created_at) VALUES (:n, :e, :h, :r, ' . ($young ? 'NOW()' : 'NOW() - INTERVAL 30 DAY') . ')')
        ->execute([':n' => "MSG $name $tag", ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT), ':r' => $role]);
    $id = (int) $pdo->lastInsertId();
    $pdo->prepare('INSERT INTO mp_email_verifications (user_id, email, token_hash, created_at, expires_at, verified_at)
                   VALUES (:u, :e, :t, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 3 DAY)')
        ->execute([':u' => $id, ':e' => $email, ':t' => hash('sha256', $email)]);
    $users[] = $id;

    return ['id' => $id, 'email' => $email];
};
/** Опубліковане оголошення користувача (post_form='ad') з контактом і режимом звʼязку. */
$mkListing = static function (int $userId, string $mode, string $title) use ($pdo, &$listings, &$sellers): int {
    $sid = mpb_seller_for_user($pdo, $userId, 'Seller ' . $userId);
    $sellers[] = $sid;
    $pdo->prepare("INSERT INTO mp_listings (section, post_form, seller_id, status, delivery_type, price_type, source_lang, contact_name, contact_phone,
                       published_at, expires_at, contact_mode) VALUES ('other', 'ad', :s, 'published', 'contact', 'none', 'uk', 'Тест', '+380501112233',
                       NOW(), NOW() + INTERVAL 30 DAY, :m)")->execute([':s' => $sid, ':m' => $mode]);
    $id = (int) $pdo->lastInsertId();
    $pdo->prepare("INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc) VALUES (:l, 'uk', :t, 'Опис')")->execute([':l' => $id, ':t' => $title]);
    $listings[] = $id;

    return $id;
};
$jar = static fn(): string => (string) tempnam(sys_get_temp_dir(), 'msg');

// Нешкідливі HTML-маркери для перевірки екранування.
$markup = '<b class="probe">bold</b> <i onclick="noop()">it</i> https://evil.example/a"onmouseover="x';
$rawMarkup = '<b class="probe">';
$rawAttr = '<i onclick=';
$escMarkup = '&lt;b class=&quot;probe&quot;&gt;bold&lt;/b&gt;';

$buyer = $mkUser('buyer', 'user');
$seller = $mkUser('seller', 'user');
$other = $mkUser('other', 'user');
$admin = $mkUser('admin', 'admin');
$employee = $mkUser('employee', 'employee');
$young = $mkUser('young', 'user', true);
$jB = $jar();
$jS = $jar();
$jO = $jar();
$jA = $jar();
$jE = $jar();
$jY = $jar();
$jG = $jar();
$lBoth = $mkListing($seller['id'], 'both', "MSG both $tag");
$lMsg = $mkListing($seller['id'], 'messages_only', "MSG messages_only $tag");
$lCon = $mkListing($seller['id'], 'contacts_only', "MSG contacts_only $tag");
$platformListing = (int) $pdo->query("SELECT l.id FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id WHERE s.user_id IS NULL AND l.section = 'solution' AND l.status = 'published' ORDER BY l.id LIMIT 1")->fetchColumn();
$convIds = [];
$secret = "SECRET-BODY-$tag";
$mailLog = __DIR__ . '/../storage/marketplace-mail.log';

try {
    check(login($jB, $base, $buyer['email'], $pass) && login($jS, $base, $seller['email'], $pass) && login($jO, $base, $other['email'], $pass)
        && login($jA, $base, $admin['email'], $pass) && login($jE, $base, $employee['email'], $pass) && login($jY, $base, $young['email'], $pass), 'вхід тестових користувачів');

    echo "1. Гість\n";
    $g = http($jG, "$base/marketplace-offer.php?id=$lBoth");
    check($g['code'] === 200 && str_contains($g['body'], 'login.php?next=mp-thread.php%3Flisting%3D' . $lBoth), 'гість: на оголошенні «Увійдіть, щоб написати» з поверненням');
    check(http($jG, "$base/mp-thread.php?listing=$lBoth")['code'] === 401, 'гість: mp-thread.php → 401 (вхід)');
    check(http($jG, "$base/mp-messages.php")['code'] === 401, 'гість: mp-messages.php → 401');
    check(http($jG, "$base/mp-messages-poll.php?c=1&since=0")['code'] === 401, 'гість: опитування → 401');

    echo "2. Початок розмови, відповідь, лічильники, прочитане\n";
    $o = http($jB, "$base/marketplace-offer.php?id=$lBoth");
    check(str_contains($o['body'], 'href="mp-thread.php?listing=' . $lBoth . '"') && str_contains($o['body'], 'id="mpContactForm"'), 'режим both: є «Написати автору» і «Показати контакт»');
    $f = http($jB, "$base/mp-thread.php?listing=$lBoth");
    check($f['code'] === 200 && str_contains($f['body'], 'name="action" value="start"'), 'форма першого повідомлення');
    check(str_contains($f['headers'], 'no-store') && str_contains($f['headers'], 'X-Robots-Tag: noindex') && str_contains($f['body'], 'noindex, nofollow'), 'заголовки no-store і noindex');
    check(str_contains($f['body'], 'data-promo-suppress'), 'без реклами (тиша promo на приватній сторінці)');
    $r = http($jB, "$base/mp-thread.php", ['csrf' => csrf_of($f['body']), 'action' => 'start', 'listing' => $lBoth, 'body' => "Добрий день! $secret"]);
    preg_match('/id=(\d+)/', $r['loc'], $m);
    $conv = (int) ($m[1] ?? 0);
    $convIds[] = $conv;
    check($r['code'] === 303 && $conv > 0, 'перше повідомлення → розмова створена');
    $again = http($jB, "$base/mp-thread.php?listing=$lBoth");
    check($again['code'] === 303 && str_contains($again['loc'], "id=$conv"), 'повторне «Написати» веде в ту саму розмову');
    $hs = http($jS, "$base/marketplace.php");
    check(preg_match('/class="msg-badge"[^>]*>1</', $hs['body']) === 1, 'автор: значок непрочитаних у шапці = 1');
    check(str_contains($hs['body'], 'Повідомлення (1)'), 'автор: «Повідомлення (1)» у меню Marketplace');
    $inbox = http($jS, "$base/mp-messages.php?tab=unread");
    check(str_contains($inbox['body'], "mp-thread.php?id=$conv") && str_contains($inbox['body'], "MSG both $tag"), 'автор: розмова у «Непрочитані» з назвою оголошення');
    $th = http($jS, "$base/mp-thread.php?id=$conv");
    check($th['code'] === 200 && str_contains($th['body'], $secret), 'автор відкрив розмову й бачить повідомлення');
    $hs = http($jS, "$base/marketplace.php");
    check(!str_contains($hs['body'], 'class="msg-badge"'), 'після прочитання значка немає (кеш скинуто)');
    $rep = http($jS, "$base/mp-thread.php", ['csrf' => csrf_of($th['body']), 'action' => 'send', 'id' => $conv, 'since' => 0, 'body' => 'Так, усе актуально.'], ['Accept: application/json']);
    $j = json_decode($rep['body'], true);
    check($rep['code'] === 200 && ($j['ok'] ?? false) === true && count($j['messages'] ?? []) >= 2, 'відповідь через fetch (JSON) — ok, повертає нові повідомлення');

    echo "3. Опитування\n";
    $p = http($jB, "$base/mp-messages-poll.php?c=$conv&since=0");
    $pj = json_decode($p['body'], true);
    check($p['code'] === 200 && count($pj['messages'] ?? []) === 2 && ($pj['messages'][1]['mine'] ?? true) === false, 'покупець отримує відповідь опитуванням');
    check(str_contains($p['headers'], 'no-store'), 'опитування: no-store');
    check(http($jB, "$base/mp-messages-poll.php?c=$conv&since=0")['code'] === 429, 'частіше ніж раз на 4 с → 429');
    sleep(5);
    $last = (int) ($pj['last_id'] ?? 0);
    $p2 = http($jB, "$base/mp-messages-poll.php?c=$conv&since=$last");
    preg_match('/^ETag:\s*(\S+)/mi', $p2['headers'], $em2);
    sleep(5);
    $p3 = http($jB, "$base/mp-messages-poll.php?c=$conv&since=$last", null, ['If-None-Match: ' . ($em2[1] ?? '')]);
    check($p3['code'] === 304 && $p3['body'] === '', 'ETag збігся → 304 без тіла');

    echo "4. IDOR, CSRF\n";
    check(http($jO, "$base/mp-thread.php?id=$conv")['code'] === 404, 'чужа розмова за прямим id → 404');
    check(http($jO, "$base/mp-messages-poll.php?c=$conv&since=0")['code'] === 404, 'чуже опитування → 404');
    $of = http($jO, "$base/mp-notify-settings.php");   // сторінка з формою — дійсний CSRF цього користувача
    $x = http($jO, "$base/mp-thread.php", ['csrf' => csrf_of($of['body']), 'action' => 'send', 'id' => $conv, 'body' => 'хак'], ['Accept: application/json']);
    check($x['code'] === 404, 'надсилання в чужу розмову → 404');
    check(!str_contains(http($jO, "$base/mp-messages.php")['body'], "id=$conv\""), 'у списку чужої розмови немає');
    $x = http($jB, "$base/mp-thread.php", ['action' => 'send', 'id' => $conv, 'body' => 'без csrf'], ['Accept: application/json']);
    check($x['code'] === 403, 'POST без CSRF → 403');
    check(http($jE, "$base/mp-thread.php?id=$conv")['code'] === 404, 'співробітник не бачить розмову користувачів без процедури перегляду');

    echo "5. Екранування HTML і посилання\n";
    $th = http($jB, "$base/mp-thread.php?id=$conv");
    http($jB, "$base/mp-thread.php", ['csrf' => csrf_of($th['body']), 'action' => 'send', 'id' => $conv, 'body' => $markup]);
    $page = http($jS, "$base/mp-thread.php?id=$conv")['body'];
    check(!str_contains($page, $rawMarkup) && !str_contains($page, $rawAttr) && str_contains($page, $escMarkup), 'HTML у тексті виводиться як текст');
    check(preg_match('~<a class="msg-link" href="https://evil\.example/a[^"<>]*" target="_blank" rel="noopener noreferrer nofollow ugc">~', $page) === 1, 'посилання з rel="noopener noreferrer nofollow ugc"');
    check(str_contains($page, 'class="msg-ext"'), 'позначка зовнішнього посилання');

    echo "6. contact_mode\n";
    $o = http($jB, "$base/marketplace-offer.php?id=$lMsg")['body'];
    check(!str_contains($o, 'id="mpContactForm"') && str_contains($o, "mp-thread.php?listing=$lMsg"), 'messages_only: немає «Показати контакт», є «Написати»');
    $c = http($jB, "$base/mp-contact.php", ['csrf' => csrf_of($o), 'id' => $lMsg], ['Accept: application/json']);
    check($c['code'] === 404, 'messages_only: mp-contact.php контактів не видає (404)');
    $o = http($jB, "$base/marketplace-offer.php?id=$lCon")['body'];
    check(str_contains($o, 'id="mpContactForm"') && !str_contains($o, "mp-thread.php?listing=$lCon"), 'contacts_only: є контакти, немає «Написати»');
    check(http($jB, "$base/mp-thread.php?listing=$lCon")['code'] === 403, 'contacts_only: розмову почати не можна (403)');
    $form = http($jS, "$base/marketplace-post.php?block=other");
    check(str_contains($form['body'], 'name="contact_mode" value="messages_only"'), 'форма подачі: вибір режиму звʼязку');
    preg_match('/name="cats\[\]" value="(\d+)"/', $form['body'], $cm);
    $fp = http($jS, "$base/marketplace-post.php?block=other", [
        'csrf' => csrf_of($form['body']), 'website' => '', 'block' => 'other', 'title' => "MSG form $tag", 'short_desc' => 'Опис тестового оголошення',
        'full_desc' => '', 'cats' => [$cm[1] ?? 0], 'price_type' => 'none', 'work_format' => 'online', 'online_scope' => 'worldwide',
        'contact_name' => '', 'contact_phone' => '', 'contact_email' => '', 'contact_telegram' => '', 'rules' => '1', 'contact_mode' => 'messages_only',
    ]);
    preg_match('/sent=(\d+)/', $fp['loc'], $sm);
    $formId = (int) ($sm[1] ?? 0);
    if ($formId > 0) {
        $listings[] = $formId;
    }
    check($fp['code'] === 303 && $formId > 0 && msg_contact_mode($pdo, $formId) === 'messages_only', 'messages_only без контактів приймається, режим збережено');
    check(str_contains(http($jA, "$base/mp-moderation.php?id=$formId")['body'], 'Лише повідомлення на сайті'), 'модерація бачить режим звʼязку');

    echo "7. Спільна скринька платформи\n";
    if ($platformListing > 0) {
        $f = http($jB, "$base/mp-thread.php?listing=$platformListing");
        $r = http($jB, "$base/mp-thread.php", ['csrf' => csrf_of($f['body']), 'action' => 'start', 'listing' => $platformListing, 'body' => "Питання до платформи $tag"]);
        preg_match('/id=(\d+)/', $r['loc'], $m);
        $pconv = (int) ($m[1] ?? 0);
        $convIds[] = $pconv;
        $pc = msg_conversation($pdo, $pconv);
        check($pconv > 0 && $pc !== null && $pc['seller_user_id'] === null, 'розмова з оголошенням платформи → seller_user_id NULL');
        $in = http($jE, "$base/mp-inbox-admin.php");
        check($in['code'] === 200 && str_contains($in['body'], "mp-thread.php?id=$pconv"), 'employee бачить її в скриньці платформи');
        check(http($jO, "$base/mp-inbox-admin.php")['code'] === 302, 'звичайний користувач до скриньки платформи не має доступу');
        $acc = http($jA, "$base/account.php");
        check(str_contains($acc['body'], 'mp-inbox-admin.php') && str_contains($acc['body'], 'mp-message-reports.php'), 'CRM-меню: скринька й скарги з лічильниками');
        $t = http($jE, "$base/mp-thread.php?id=$pconv");
        http($jE, "$base/mp-thread.php", ['csrf' => csrf_of($t['body']), 'action' => 'send', 'id' => $pconv, 'body' => 'Відповідь команди']);
        $row = $pdo->prepare('SELECT sender_id, sender_label FROM mp_messages WHERE conversation_id = :c ORDER BY id DESC LIMIT 1');
        $row->execute([':c' => $pconv]);
        $row = $row->fetch(PDO::FETCH_ASSOC);
        check($row !== false && $row['sender_id'] === null && $row['sender_label'] === 'AI LAB HUB', 'відповідь платформи: sender_id NULL, підпис «AI LAB HUB»');
        check(str_contains(http($jB, "$base/mp-thread.php?id=$pconv")['body'], 'AI LAB HUB'), 'покупець бачить підпис «AI LAB HUB»');
        $lg = $pdo->prepare("SELECT COUNT(*) FROM mp_admin_access_log WHERE conversation_id = :c AND action = 'platform_reply' AND admin_id = :a");
        $lg->execute([':c' => $pconv, ':a' => $employee['id']]);
        check((int) $lg->fetchColumn() === 1, 'хто відповів — у журналі доступу');
    } else {
        check(false, 'немає опублікованого оголошення платформи для тесту');
    }

    echo "8. Ліміти\n";
    $yl = $mkListing($other['id'], 'both', "MSG young $tag");
    $cy = csrf_of(http($jY, "$base/mp-thread.php?listing=$yl")['body']);
    $post = static fn(array $data): string => jerr(http($jY, "$base/mp-thread.php", ['csrf' => $cy] + $data, ['Accept: application/json']));
    check($post(['action' => 'start', 'listing' => $yl, 'body' => 'a https://a.example b https://b.example c https://c.example']) === 'msg_err_links', 'молодий акаунт: >2 посилань → відмова');
    check($post(['action' => 'start', 'listing' => $yl, 'body' => str_repeat('я', (int) msg_cfg('msg_max_len') + 1)]) === 'msg_err_long', 'довжина > msg_max_len → відмова');
    check($post(['action' => 'start', 'listing' => $yl, 'body' => '   ']) === 'msg_err_empty', 'порожнє → відмова');
    $post(['action' => 'start', 'listing' => $yl, 'body' => 'однаково']);
    $yconv = (int) msg_find_conversation($pdo, $yl, $young['id']);
    $convIds[] = $yconv;
    $post(['action' => 'send', 'id' => $yconv, 'body' => 'однаково']);
    $post(['action' => 'send', 'id' => $yconv, 'body' => 'однаково']);
    check($post(['action' => 'send', 'id' => $yconv, 'body' => 'однаково']) === 'msg_err_repeat', 'той самий текст 4-й раз поспіль → відмова');
    $res = [];
    foreach ([$mkListing($other['id'], 'both', "MSG y2 $tag"), $mkListing($other['id'], 'both', "MSG y3 $tag"), $mkListing($other['id'], 'both', "MSG y4 $tag")] as $i => $lid) {
        $res[] = $post(['action' => 'start', 'listing' => $lid, 'body' => "Привіт $i"]);
        $cid = msg_find_conversation($pdo, $lid, $young['id']);
        if ($cid !== null) {
            $convIds[] = $cid;
        }
    }
    check($res === ['ok', 'ok', 'msg_err_newconv_day'], 'молодий акаунт: ≤3 нових розмов на добу (' . implode(',', $res) . ')');
    $ins = $pdo->prepare('INSERT INTO mp_messages (conversation_id, sender_id, body) VALUES (:c, :u, :b)');
    for ($i = 0; $i < 30; $i++) {
        $ins->execute([':c' => $conv, ':u' => $buyer['id'], ':b' => "flood $i"]);
    }
    $th = http($jB, "$base/mp-thread.php?id=$conv");
    check(jerr(http($jB, "$base/mp-thread.php", ['csrf' => csrf_of($th['body']), 'action' => 'send', 'id' => $conv, 'body' => 'ще одне'], ['Accept: application/json'])) === 'msg_err_hour', '> msg_per_hour за годину → відмова');
    $pdo->prepare("DELETE FROM mp_messages WHERE conversation_id = :c AND body LIKE 'flood %'")->execute([':c' => $conv]);

    echo "9. Автопрапор «Підозріла активність»\n";
    $sus = $mkUser('sus', 'user', true);
    $authors = [];
    for ($i = 0; $i < 5; $i++) {
        $a = $mkUser("auth$i", 'user');
        $authors[] = $a['id'];
        $lid = $mkListing($a['id'], 'both', "MSG sus $i $tag");
        $pdo->prepare('INSERT INTO mp_conversations (listing_id, buyer_id, seller_user_id) VALUES (:l, :b, :s)')->execute([':l' => $lid, ':b' => $sus['id'], ':s' => $a['id']]);
        $cid = (int) $pdo->lastInsertId();
        $convIds[] = $cid;
        msg_insert($pdo, $cid, $sus['id'], null, "Пишіть у телеграм https://t.me/x$i або +380 50 111 22 3$i", false);
    }
    msg_check_suspicious($pdo, $sus['id']);
    check(msg_flag($pdo, $sus['id'], MSG_FLAG_NEWCONV) !== null, 'автопрапор встановлено (нові розмови обмежено)');
    $blockedAt = $pdo->prepare('SELECT blocked_at FROM users WHERE id = :u');
    $blockedAt->execute([':u' => $sus['id']]);
    check($blockedAt->fetchColumn() === null, 'акаунт автоматично не заблоковано');
    $sl = $mkListing($authors[0], 'both', "MSG sus extra $tag");
    check(msg_start($pdo, $sus['id'], msg_listing($pdo, $sl), 'привіт')['status'] === 'msg_err_newconv_limited', 'нову розмову почати не можна');
    check(str_contains(http($jA, "$base/mp-message-reports.php?tab=suspicious")['body'], '#' . $sus['id']), 'видно у вкладці «Підозріла активність»');

    echo "10. Блокування\n";
    $th = http($jS, "$base/mp-thread.php?id=$conv");
    http($jS, "$base/mp-thread.php", ['csrf' => csrf_of($th['body']), 'action' => 'block', 'id' => $conv]);
    $tb = http($jB, "$base/mp-thread.php?id=$conv");
    $r = http($jB, "$base/mp-thread.php", ['csrf' => csrf_of($tb['body']), 'action' => 'send', 'id' => $conv, 'body' => 'після блокування'], ['Accept: application/json']);
    $rj = json_decode($r['body'], true);
    check(($rj['error'] ?? '') === 'msg_err_not_accepting' && str_contains($rj['message'] ?? '', 'не приймає повідомлень'), 'заблокований: «Цей користувач не приймає повідомлень»');
    check(str_contains(http($jS, "$base/mp-notify-settings.php")['body'], "MSG buyer $tag"), 'блокувальник бачить список блоків');
    $st = http($jS, "$base/mp-notify-settings.php");
    http($jS, "$base/mp-notify-settings.php", ['csrf' => csrf_of($st['body']), 'action' => 'unblock', 'user_id' => $buyer['id']]);
    check(!msg_is_blocked_by($pdo, $seller['id'], $buyer['id']), 'блок знято');

    echo "11. Скарга, знімок, журнал доступу\n";
    $th = http($jS, "$base/mp-thread.php?id=$conv");
    http($jS, "$base/mp-thread.php", ['csrf' => csrf_of($th['body']), 'action' => 'report', 'id' => $conv, 'reason' => 'harassment', 'note' => 'тест', 'message_id' => 0]);
    $rp = $pdo->prepare('SELECT id, snapshot FROM mp_message_reports WHERE conversation_id = :c AND reporter_id = :u');
    $rp->execute([':c' => $conv, ':u' => $seller['id']]);
    $rp = $rp->fetch(PDO::FETCH_ASSOC) ?: ['id' => 0, 'snapshot' => ''];
    $snap = json_decode((string) $rp['snapshot'], true);
    check(is_array($snap) && count($snap['messages'] ?? []) >= 3 && count($snap['messages']) <= 30, 'скарга зі знімком останніх повідомлень (≤30)');
    $page = http($jE, "$base/mp-message-reports.php");
    check(str_contains($page['body'], '#' . (int) $rp['id']) && !str_contains($page['body'], $rawMarkup) && str_contains($page['body'], $escMarkup), 'employee бачить скаргу; знімок екранований');
    check(!str_contains($page['body'], 'tab=log'), 'employee не бачить журналу доступу');
    check(http($jE, "$base/mp-message-reports.php?view=$conv")['code'] === 303, 'повний перегляд без причини → відмова');
    http($jE, "$base/mp-message-reports.php", ['csrf' => csrf_of($page['body']), 'action' => 'view', 'conversation_id' => $conv, 'reason' => 'x']);
    check(http($jE, "$base/mp-message-reports.php?view=$conv")['code'] === 303, 'причина коротша за 5 символів → відмова');
    http($jE, "$base/mp-message-reports.php", ['csrf' => csrf_of($page['body']), 'action' => 'view', 'conversation_id' => $conv, 'reason' => 'Перевірка скарги на образи']);
    $v = http($jE, "$base/mp-message-reports.php?view=$conv");
    check($v['code'] === 200 && str_contains($v['body'], $secret), 'з причиною — повний перегляд');
    $lg = $pdo->prepare("SELECT COUNT(*) FROM mp_admin_access_log WHERE conversation_id = :c AND action = 'view_full' AND admin_id = :a");
    $lg->execute([':c' => $conv, ':a' => $employee['id']]);
    check((int) $lg->fetchColumn() === 1, 'перегляд записано в журнал');
    check(str_contains(http($jA, "$base/mp-message-reports.php?tab=log")['body'], 'Перевірка скарги на образи'), 'admin бачить журнал доступу');
    http($jE, "$base/mp-message-reports.php", ['csrf' => csrf_of($page['body']), 'report_id' => (int) $rp['id'], 'action' => 'restrict', 'days' => 1, 'note' => 'тест']);
    check(msg_flag($pdo, $buyer['id'], MSG_FLAG_RESTRICT) !== null, '«Обмежити надсилання» → прапор msg_restricted');
    $tb = http($jB, "$base/mp-thread.php?id=$conv");
    check(jerr(http($jB, "$base/mp-thread.php", ['csrf' => csrf_of($tb['body']), 'action' => 'send', 'id' => $conv, 'body' => 'обмежено?'], ['Accept: application/json'])) === 'msg_err_restricted', 'обмежений користувач не може писати');
    $pdo->prepare('UPDATE mp_user_flags SET is_active = 0 WHERE user_id = :u')->execute([':u' => $buyer['id']]);

    echo "12. Листи (лише посилання, без тексту)\n";
    msg_set_email_pref($pdo, $seller['id'], true);
    $tb = http($jB, "$base/mp-thread.php?id=$conv");
    clearstatcache();
    $before = is_file($mailLog) ? (int) filesize($mailLog) : 0;
    http($jB, "$base/mp-thread.php", ['csrf' => csrf_of($tb['body']), 'action' => 'send', 'id' => $conv, 'body' => "Лист? $secret-2"]);
    clearstatcache();
    $logText = is_file($mailLog) ? (string) file_get_contents($mailLog, false, null, $before) : '';
    check(str_contains($logText, 'Нове повідомлення щодо оголошення') && str_contains($logText, "mp-thread.php?id=$conv") && str_contains($logText, 'unsub='), 'лист: назва оголошення, посилання, відписка');
    check(!str_contains($logText, $secret) && !str_contains($logText, "MSG buyer $tag"), 'лист без тексту повідомлення й імені відправника');
    $before = (int) filesize($mailLog);
    http($jB, "$base/mp-thread.php", ['csrf' => csrf_of($tb['body']), 'action' => 'send', 'id' => $conv, 'body' => 'другий лист?']);
    clearstatcache();
    check((int) filesize($mailLog) === $before, 'не частіше одного листа на розмову за 30 хв');
    preg_match('/unsub=([0-9]+\.[a-f0-9]{32})/', $logText, $um);
    $u = http($jG, "$base/mp-notify-settings.php?unsub=" . ($um[1] ?? ''));
    check($u['code'] === 200 && !msg_email_pref($pdo, $seller['id']), 'відписка за підписаним посиланням без входу');
    check(http($jG, "$base/mp-notify-settings.php?unsub=" . $seller['id'] . '.' . str_repeat('0', 32))['code'] === 400, 'підроблений токен відписки → 400');

    echo "13. Лише читання, строк зберігання\n";
    $pdo->prepare("UPDATE mp_listings SET status = 'archived', status_changed_at = NOW() - INTERVAL 10 DAY WHERE id = :id")->execute([':id' => $lBoth]);
    check(!msg_is_readonly(msg_conversation($pdo, $conv), msg_listing($pdo, $lBoth)), 'закрито 10 днів тому — ще можна відповідати');
    $pdo->prepare('UPDATE mp_listings SET status_changed_at = NOW() - INTERVAL 20 DAY WHERE id = :id')->execute([':id' => $lBoth]);
    $tb = http($jB, "$base/mp-thread.php?id=$conv");
    check(str_contains($tb['body'], 'лише для читання') && !str_contains($tb['body'], 'name="action" value="send"'), 'закрито > 14 днів → лише читання');
    check(http($jO, "$base/mp-thread.php?listing=$lBoth")['code'] === 403, 'з закритого оголошення нову розмову не почати');
    $pdo->prepare('UPDATE mp_conversations SET last_message_at = NOW() - INTERVAL 400 DAY, created_at = NOW() - INTERVAL 400 DAY WHERE id = :c')->execute([':c' => $conv]);
    // Відкрита скарга (нова) — розмова має дочекатися розгляду.
    $pdo->prepare("INSERT INTO mp_message_reports (conversation_id, reporter_id, reason, snapshot, status) VALUES (:c, :u, 'spam', '{}', 'new')")->execute([':c' => $conv, ':u' => $buyer['id']]);
    msg_retention_cleanup($pdo, 365);
    check(msg_conversation($pdo, $conv) !== null, 'відкрита скарга: розмова чекає розгляду');
    $pdo->prepare("UPDATE mp_message_reports SET status = 'reviewed' WHERE conversation_id = :c")->execute([':c' => $conv]);
    $res = msg_retention_cleanup($pdo, 365);
    $left = $pdo->prepare('SELECT (SELECT COUNT(*) FROM mp_messages WHERE conversation_id = :c1) + (SELECT COUNT(*) FROM mp_conversation_state WHERE conversation_id = :c2)');
    $left->execute([':c1' => $conv, ':c2' => $conv]);
    $snapLeft = $pdo->prepare('SELECT COUNT(*) FROM mp_message_reports WHERE conversation_id = :c AND snapshot IS NOT NULL');
    $snapLeft->execute([':c' => $conv]);
    check(msg_conversation($pdo, $conv) === null && (int) $left->fetchColumn() === 0 && $res['conversations'] >= 1, 'розмову, повідомлення й стани видалено за строком');
    check((int) $snapLeft->fetchColumn() === 0, 'знімок закритої скарги очищено');

    echo "14. Текст повідомлень нікуди не потрапляє\n";
    $leak = 0;
    foreach (['search_queries' => 'query_text', 'search_log' => 'query', 'translation_cache' => 'source_text', 'ui_translations' => 'translated_text', 'mail_queue' => 'body_text'] as $tbl => $col) {
        try {
            $q = $pdo->prepare("SELECT COUNT(*) FROM $tbl WHERE $col LIKE :s");
            $q->execute([':s' => "%$secret%"]);
            $leak += (int) $q->fetchColumn();
        } catch (Throwable) {
            // таблиці/колонки немає — нічого не потрапило
        }
    }
    check($leak === 0, 'тексту немає в пошукових журналах, кеші перекладів і черзі листів');
} finally {
    foreach (array_unique(array_filter($convIds)) as $cid) {
        foreach (['mp_messages', 'mp_conversation_state', 'mp_message_reports', 'mp_message_emails', 'mp_admin_access_log'] as $tbl) {
            $pdo->prepare("DELETE FROM $tbl WHERE conversation_id = :c")->execute([':c' => $cid]);
        }
        $pdo->prepare('DELETE FROM mp_conversations WHERE id = :c')->execute([':c' => $cid]);
    }
    foreach ($listings as $id) {
        foreach (['mp_listing_translations', 'mp_listing_categories', 'mp_listing_photos', 'mp_moderation_log', 'mp_contact_reveals', 'mp_notifications', 'mp_listing_places', 'mp_listing_stats_daily', 'mp_listing_views_daily'] as $tbl) {
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
        $pdo->prepare('DELETE FROM mp_user_blocks WHERE blocker_id = :a OR blocked_id = :b')->execute([':a' => $id, ':b' => $id]);
        $pdo->prepare('DELETE FROM mp_admin_access_log WHERE admin_id = :a')->execute([':a' => $id]);
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $id]);
    }
    $pdo->prepare('DELETE FROM mail_queue WHERE to_email LIKE :e')->execute([':e' => "msg-%-$tag@example.test"]);
    foreach ([$jB, $jS, $jO, $jA, $jE, $jY, $jG] as $f) {
        @unlink($f);
    }
}

echo "\n" . ($total - $fails) . " / $total OK" . ($fails > 0 ? " — FAILED: $fails" : '') . "\n";
exit($fails > 0 ? 1 : 0);
