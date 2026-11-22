<?php

declare(strict_types=1);

/**
 * AI LAB HUB — наскрізний тест чату «Повідомлення» (міграція № 30, 2026-11-22). Доповнює tests/mp-messages-e2e.php.
 *   php tests/mp-chat-e2e.php [http://ai-lab-hub.test]
 *
 * Перевіряє: розкладку чату (список + розмова, autocomplete="off", multipart, інтервал 5 с, «Назад»), вкладення
 * (PNG/WebP/PDF, реальний тип за вмістом, підроблені й завеликі файли, файл поза public/, доступ лише учасникам і
 * admin при скарзі, nosniff, PDF лише як завантаження, екранування імені файлу), повідомлення лише з файлом,
 * «Прочитано» (read_at, peer_read), лічильник непрочитаних (JSON, частота, гість), скрипт значка в шапці, блокування,
 * скаргу з reported_user_id, лист лише про непрочитане, notify_new_message, блок у кабінеті й перемикач листів,
 * розділ 3.6 Політики, видалення файлів за строком зберігання. Тестові записи й файли видаляються за id. Лише CLI.
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
        CURLOPT_USERAGENT => 'Mozilla/5.0 mp-chat-e2e',
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
$tmpFiles = [];
$mkUser = static function (string $name, string $role) use ($pdo, $tag, $pass, &$users): array {
    $email = "chat-$name-$tag@example.test";
    $pdo->prepare('INSERT INTO users (name, email, password_hash, role, created_at) VALUES (:n, :e, :h, :r, NOW() - INTERVAL 30 DAY)')
        ->execute([':n' => "CHAT $name $tag", ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT), ':r' => $role]);
    $id = (int) $pdo->lastInsertId();
    $pdo->prepare('INSERT INTO mp_email_verifications (user_id, email, token_hash, created_at, expires_at, verified_at)
                   VALUES (:u, :e, :t, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 3 DAY)')
        ->execute([':u' => $id, ':e' => $email, ':t' => hash('sha256', $email)]);
    $users[] = $id;

    return ['id' => $id, 'email' => $email];
};
$jar = static fn(): string => (string) tempnam(sys_get_temp_dir(), 'chat');
$tmp = static function (string $ext, string $content) use (&$tmpFiles): string {
    $f = sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'chat-e2e-' . bin2hex(random_bytes(4)) . '.' . $ext;
    file_put_contents($f, $content);
    $tmpFiles[] = $f;

    return $f;
};
$png = static function (): string {
    $im = imagecreatetruecolor(40, 30);
    imagefill($im, 0, 0, imagecolorallocate($im, 33, 22, 173));
    ob_start();
    imagepng($im);

    return (string) ob_get_clean();
};
$webp = static function (): string {
    $im = imagecreatetruecolor(20, 20);
    ob_start();
    imagewebp($im);

    return (string) ob_get_clean();
};
$pdf = "%PDF-1.4\n1 0 obj<</Type/Catalog/Pages 2 0 R>>endobj 2 0 obj<</Type/Pages/Kids[3 0 R]/Count 1>>endobj "
    . "3 0 obj<</Type/Page/Parent 2 0 R/MediaBox[0 0 200 200]>>endobj\ntrailer<</Root 1 0 R>>\n%%EOF\n";
/** Надсилання в розмову через fetch-подібний POST (multipart). */
$send = static function (string $jarFile, string $page, int $conv, string $body, ?string $file = null, ?string $name = null, ?string $mime = null) use ($base): array {
    $post = ['csrf' => csrf_of($page), 'action' => 'send', 'id' => (string) $conv, 'since' => '0', 'body' => $body];
    if ($file !== null) {
        $post['attachment'] = new CURLFile($file, $mime ?? 'application/octet-stream', $name ?? basename($file));
    }

    return jbody(http($jarFile, "$base/mp-thread.php", $post, ['Accept: application/json'], true));
};

$buyer = $mkUser('buyer', 'user');
$seller = $mkUser('seller', 'user');
$other = $mkUser('other', 'user');
$admin = $mkUser('admin', 'admin');
[$jB, $jS, $jO, $jA, $jG] = [$jar(), $jar(), $jar(), $jar(), $jar()];
$sid = mpb_seller_for_user($pdo, $seller['id'], 'Seller ' . $seller['id']);
$sellers[] = $sid;
$pdo->prepare("INSERT INTO mp_listings (section, post_form, seller_id, status, delivery_type, price_type, source_lang, contact_name, contact_phone,
                   published_at, expires_at, contact_mode) VALUES ('other', 'ad', :s, 'published', 'contact', 'none', 'uk', 'Тест', '+380501112233',
                   NOW(), NOW() + INTERVAL 30 DAY, 'both')")->execute([':s' => $sid]);
$lid = (int) $pdo->lastInsertId();
$listings[] = $lid;
$pdo->prepare("INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc) VALUES (:l, 'uk', :t, 'Опис')")->execute([':l' => $lid, ':t' => "CHAT listing $tag"]);
$attachDir = msg_attach_dir();

try {
    check(login($jB, $base, $buyer['email'], $pass) && login($jS, $base, $seller['email'], $pass) && login($jO, $base, $other['email'], $pass)
        && login($jA, $base, $admin['email'], $pass), 'вхід тестових користувачів');

    echo "1. Розкладка чату\n";
    $f = http($jB, "$base/mp-thread.php?listing=$lid");
    check(str_contains($f['body'], 'enctype="multipart/form-data"') && str_contains($f['body'], 'name="attachment"') && str_contains($f['body'], 'autocomplete="off"'),
        'форма першого повідомлення: вкладення, autocomplete="off"');
    $r = http($jB, "$base/mp-thread.php", ['csrf' => csrf_of($f['body']), 'action' => 'start', 'listing' => $lid, 'body' => "Привіт $tag"]);
    preg_match('/[?&]c=(\d+)/', $r['loc'], $m);
    $conv = (int) ($m[1] ?? 0);
    $convIds[] = $conv;
    check($r['code'] === 303 && $conv > 0 && str_starts_with($r['loc'], 'mp-messages.php?c='), 'перше повідомлення → чат mp-messages.php?c=N');
    $old = http($jB, "$base/mp-thread.php?id=$conv");
    check($old['code'] === 303 || $old['code'] === 302, 'старе посилання mp-thread.php?id=N (з листів) → переадресація в чат');
    $pg = http($jB, "$base/mp-messages.php?c=$conv");
    $b = $pg['body'];
    check($pg['code'] === 200 && str_contains($b, 'msg-chat msg-chat--open') && str_contains($b, 'data-conv="' . $conv . '"') && str_contains($b, 'class="msg-pane"'),
        'дві колонки: список розмов і відкрита розмова');
    check(preg_match('/<textarea[^>]+id="msgBody"[^>]+autocomplete="off"/', $b) === 1 && str_contains($b, 'id="msg-compose"') && str_contains($b, 'autocomplete="off"'),
        'поле вводу autocomplete="off"');
    check(str_contains($b, 'data-interval="5"') && str_contains($b, 'class="msg-pane__back"'), 'опитування 5 с; кнопка «Назад» для телефону');
    check(str_contains($b, 'Shift+Enter') && str_contains($b, '/assets/js/mp-thread.js'), 'підказка Enter / Shift+Enter, скрипт розмови');
    check(str_contains($b, '/assets/js/msg-unread.js') && str_contains($b, 'data-url="/mp-messages-unread.php"') && str_contains($b, 'data-interval="30"'),
        'шапка: скрипт значка непрочитаних (30 с)');
    $list = http($jB, "$base/mp-messages.php");
    check($list['code'] === 200 && str_contains($list['body'], 'msg-chat__placeholder') && !str_contains($list['body'], 'msg-chat--open'), 'без ?c — список і заглушка «Виберіть розмову»');
    check(http($jO, "$base/mp-messages.php?c=$conv")['code'] === 404, 'чужа розмова в чаті → 404');

    echo "2. Вкладення\n";
    $pngFile = $tmp('png', $png());
    $j = $send($jB, $b, $conv, 'Ось фото', $pngFile, '<img src=x onerror=alert(1)>.png', 'image/png');
    $pngMsg = (int) (($j['messages'] ?? [])[count($j['messages'] ?? []) - 1]['id'] ?? 0);
    check(($j['ok'] ?? false) === true && $pngMsg > 0 && ($j['messages'][count($j['messages']) - 1]['attach']['kind'] ?? '') === 'image', 'PNG надіслано (JSON, attach.kind = image)');
    $row = $pdo->prepare('SELECT attachment_path, attachment_mime, attachment_size FROM mp_messages WHERE id = :m');
    $row->execute([':m' => $pngMsg]);
    $att = $row->fetch(PDO::FETCH_ASSOC) ?: [];
    $abs = msg_attach_abs((string) ($att['attachment_path'] ?? ''));
    $publicRoot = realpath(__DIR__ . '/../public');
    check($abs !== null && preg_match(MSG_ATTACH_PATH_RE, (string) $att['attachment_path']) === 1 && !str_starts_with((string) realpath($abs), (string) $publicRoot),
        'файл під випадковим ім\'ям поза public/');
    check(is_file($attachDir . '/.htaccess') && str_contains((string) file_get_contents($attachDir . '/.htaccess'), 'Require all denied'), 'тека вкладень: .htaccess «Require all denied»');
    check(($att['attachment_mime'] ?? '') === 'image/png' && @getimagesize((string) $abs) !== false, 'зображення перекодоване й читається');
    $html = http($jS, "$base/mp-messages.php?c=$conv")['body'];
    check(!str_contains($html, '<img src=x onerror') && str_contains($html, '&lt;img src=x onerror=alert(1)&gt;'), 'ім\'я файлу екрановане');
    $g = http($jB, "$base/mp-attachment.php?m=$pngMsg");
    check($g['code'] === 200 && str_contains($g['headers'], 'Content-Type: image/png') && str_contains($g['headers'], 'nosniff') && str_contains($g['headers'], 'inline'),
        'покупець отримує зображення (image/png, nosniff, inline)');
    check(http($jS, "$base/mp-attachment.php?m=$pngMsg")['code'] === 200, 'автор оголошення отримує файл');
    check(http($jO, "$base/mp-attachment.php?m=$pngMsg")['code'] === 404, 'сторонній користувач → 404');
    check(http($jG, "$base/mp-attachment.php?m=$pngMsg")['code'] === 404, 'гість → 404');
    check(http($jA, "$base/mp-attachment.php?m=$pngMsg")['code'] === 404, 'admin без скарги → 404');

    $pdfFile = $tmp('pdf', $pdf);
    $j = $send($jB, $b, $conv, '', $pdfFile, 'Договір.pdf', 'application/pdf');
    $pdfMsg = (int) (($j['messages'] ?? [])[count($j['messages'] ?? []) - 1]['id'] ?? 0);
    check(($j['ok'] ?? false) === true && $pdfMsg > 0, 'повідомлення лише з PDF (без тексту) приймається');
    $g = http($jS, "$base/mp-attachment.php?m=$pdfMsg");
    check($g['code'] === 200 && str_contains($g['headers'], 'Content-Type: application/pdf') && str_contains($g['headers'], 'Content-Disposition: attachment'),
        'PDF віддається лише як завантаження (attachment)');
    $j = $send($jS, http($jS, "$base/mp-messages.php?c=$conv")['body'], $conv, 'webp', $tmp('webp', $webp()), 'pic.webp', 'image/webp');
    check(($j['ok'] ?? false) === true, 'WebP приймається');
    $before = (int) $pdo->query("SELECT COUNT(*) FROM mp_messages WHERE conversation_id = $conv")->fetchColumn();
    $j = $send($jB, $b, $conv, 'x', $tmp('jpg', "<?php echo 'hi'; ?>"), 'shell.jpg', 'image/jpeg');
    check(($j['error'] ?? '') === 'msg_err_file_type', 'PHP-код під іменем .jpg → відмова (тип за вмістом)');
    $j = $send($jB, $b, $conv, 'x', $tmp('pdf', $png()), 'fake.pdf', 'application/pdf');
    check(($j['error'] ?? '') === 'msg_err_file_type', 'PNG під іменем .pdf → відмова (розширення ≠ тип)');
    $j = $send($jB, $b, $conv, 'x', $tmp('txt', 'hello'), 'note.txt', 'text/plain');
    check(($j['error'] ?? '') === 'msg_err_file_type', 'інший тип (txt) → відмова');
    $j = $send($jB, $b, $conv, 'x', $tmp('png', $png() . str_repeat("\0", 5 * 1024 * 1024)), 'big.png', 'image/png');
    check(($j['error'] ?? '') === 'msg_err_file_size', 'файл > 5 МБ → відмова');
    $after = (int) $pdo->query("SELECT COUNT(*) FROM mp_messages WHERE conversation_id = $conv")->fetchColumn();
    check($after === $before, 'відхилені файли не створили повідомлень');
    $inbox = http($jS, "$base/mp-messages.php")['body'];
    check(str_contains($inbox, 'data-conv="' . $conv . '"'), 'розмова в списку автора');

    echo "3. Прочитано\n";
    $j = $send($jB, $b, $conv, "Перевірка прочитання $tag");
    $mid = (int) (($j['messages'] ?? [])[count($j['messages'] ?? []) - 1]['id'] ?? 0);
    $peerBefore = (int) ($j['peer_read'] ?? -1);
    check($mid > 0 && $peerBefore < $mid, 'до відкриття автором: peer_read < id повідомлення');
    $un = jbody(http($jS, "$base/mp-messages-unread.php?list=1"));
    $cv = array_values(array_filter($un['convs'] ?? [], static fn($c) => (int) $c['id'] === $conv))[0] ?? [];
    check(($un['ok'] ?? false) === true && (int) ($un['total'] ?? 0) >= 1 && (int) ($cv['unread'] ?? 0) >= 1, 'лічильник непрочитаних автора (JSON, list=1)');
    check(http($jS, "$base/mp-messages-unread.php")['code'] === 429, 'лічильник частіше ніж раз на 8 с → 429');
    check(http($jG, "$base/mp-messages-unread.php")['code'] === 401, 'лічильник для гостя → 401');
    http($jS, "$base/mp-messages.php?c=$conv");   // автор відкрив розмову
    $ra = $pdo->prepare('SELECT read_at FROM mp_messages WHERE id = :m');
    $ra->execute([':m' => $mid]);
    check($ra->fetchColumn() !== null, 'read_at заповнено, коли автор відкрив розмову');
    sleep(4);
    $p = jbody(http($jB, "$base/mp-messages-poll.php?c=$conv&since=$mid"));
    check((int) ($p['peer_read'] ?? 0) >= $mid, 'опитування покупця: peer_read ≥ id (позначка «Прочитано»)');
    $page = http($jB, "$base/mp-messages.php?c=$conv")['body'];
    check(preg_match('/data-id="' . $mid . '".*?class="msg-read is-read"/s', $page) === 1, 'на сторінці під своїм повідомленням «Прочитано»');
    sleep(9);
    $un = jbody(http($jS, "$base/mp-messages-unread.php"));
    check(($un['ok'] ?? false) === true && (int) ($un['total'] ?? -1) === 0, 'після прочитання лічильник = 0');

    echo "4. Лист лише про непрочитане; notify_new_message\n";
    check(function_exists('notify_new_message') && in_array('msg_notify_email', MSG_NOTIFY_CHANNELS, true), 'єдина точка notify_new_message() з каналом email');
    msg_set_email_pref($pdo, $seller['id'], true);
    $cnt = static fn(): int => (int) $pdo->query('SELECT COUNT(*) FROM mp_message_emails WHERE user_id = ' . (int) $seller['id'])->fetchColumn();
    $c0 = $cnt();
    msg_notify_email($pdo, $conv, $mid, 'buyer');   // автор уже прочитав $mid
    check($cnt() === $c0, 'прочитане повідомлення — листа немає');

    echo "5. Блокування, скарга, доступ admin до файлу за скаргою\n";
    $sp = http($jS, "$base/mp-messages.php?c=$conv")['body'];
    http($jS, "$base/mp-thread.php", ['csrf' => csrf_of($sp), 'action' => 'report', 'id' => $conv, 'reason' => 'spam', 'note' => 'тест', 'message_id' => $pngMsg]);
    $rep = $pdo->prepare('SELECT reported_user_id FROM mp_message_reports WHERE conversation_id = :c ORDER BY id DESC LIMIT 1');
    $rep->execute([':c' => $conv]);
    check((int) $rep->fetchColumn() === $buyer['id'], 'скарга: reported_user_id = співрозмовник');
    check(http($jA, "$base/mp-attachment.php?m=$pngMsg")['code'] === 200, 'admin бачить вкладення розмови зі скаргою');
    http($jS, "$base/mp-thread.php", ['csrf' => csrf_of($sp), 'action' => 'block', 'id' => $conv]);
    $bp = http($jB, "$base/mp-messages.php?c=$conv")['body'];
    check(!str_contains($bp, 'id="msg-compose"') && str_contains($bp, mp_e(t('msg_err_not_accepting'))), 'заблокований: замість поля вводу «не приймає повідомлень»');
    $j = $send($jB, $b, $conv, 'після блоку');
    check(($j['error'] ?? '') === 'msg_err_not_accepting', 'заблокований не може надіслати');
    $sp2 = http($jS, "$base/mp-messages.php?c=$conv")['body'];
    check(str_contains($sp2, 'value="unblock"'), 'у меню «⋯» — «Розблокувати»');
    http($jS, "$base/mp-thread.php", ['csrf' => csrf_of($sp2), 'action' => 'unblock', 'id' => $conv]);

    echo "6. Кабінет і Політика\n";
    $acc = http($jB, "$base/account.php")['body'];
    check(str_contains($acc, 'id="acc-messages"') && str_contains($acc, 'href="mp-messages.php"') && str_contains($acc, 'name="email_new_message"'),
        'кабінет: блок «Повідомлення» з посиланням і перемикачем листів');
    $accForm = preg_match('~<form method="post" action="mp-notify-settings.php" class="acc-msg-email">.*?</form>~s', $acc, $fm) === 1 ? $fm[0] : '';
    $t = http($jB, "$base/mp-notify-settings.php", ['csrf' => csrf_of($accForm), 'action' => 'email', 'return' => 'account', 'email_new_message' => '1']);
    check($t['code'] === 303 && str_contains($t['loc'], 'account.php#acc-messages') && msg_email_pref($pdo, $buyer['id']), 'перемикач у кабінеті вмикає листи й повертає в кабінет');
    $priv = http($jG, "$base/privacy.php")['body'];
    check(str_contains($priv, 'id="messages"') && str_contains($priv, '3.6.') && str_contains($priv, 'ЧЕРНЕТКА') && str_contains($priv, '365'), 'Політика: розділ 3.6 (чернетка)');
    $en = $pdo->query("SELECT COUNT(*) FROM ui_translations WHERE lang = 'en' AND key_name IN ('legal_privacy_msg_h','legal_privacy_msg_store','legal_privacy_msg_access','legal_privacy_msg_email','legal_privacy_msg_delete','msg_read','msg_attach','msg_err_minute')")->fetchColumn();
    check((int) $en === 8, 'EN-переклади нових написів у ui_translations');

    echo "7. Строк зберігання видаляє файли\n";
    $paths = $pdo->query("SELECT attachment_path FROM mp_messages WHERE conversation_id = $conv AND attachment_path IS NOT NULL")->fetchAll(PDO::FETCH_COLUMN);
    $pdo->prepare("UPDATE mp_message_reports SET status = 'reviewed' WHERE conversation_id = :c")->execute([':c' => $conv]);
    $pdo->prepare('UPDATE mp_conversations SET last_message_at = NOW() - INTERVAL 400 DAY WHERE id = :c')->execute([':c' => $conv]);
    msg_retention_cleanup($pdo, 365);
    $left = 0;
    foreach ($paths as $p) {
        $left += is_file($attachDir . '/' . $p) ? 1 : 0;
    }
    check(count($paths) >= 3 && $left === 0 && msg_conversation($pdo, $conv) === null, 'розмову видалено разом із файлами вкладень');
} finally {
    foreach (array_unique(array_filter($convIds)) as $cid) {
        foreach ($pdo->query('SELECT attachment_path FROM mp_messages WHERE conversation_id = ' . (int) $cid . ' AND attachment_path IS NOT NULL')->fetchAll(PDO::FETCH_COLUMN) as $p) {
            msg_attach_delete((string) $p);
        }
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
    $pdo->prepare('DELETE FROM mail_queue WHERE to_email LIKE :e')->execute([':e' => "chat-%-$tag@example.test"]);
    foreach (array_merge($tmpFiles, [$jB, $jS, $jO, $jA, $jG]) as $f) {
        @unlink($f);
    }
}

echo "\n" . ($total - $fails) . " / $total OK" . ($fails > 0 ? " — FAILED: $fails" : '') . "\n";
exit($fails > 0 ? 1 : 0);
