<?php

declare(strict_types=1);

/**
 * AI LAB HUB — наскрізний тест (HTTP до локального сайту) підтвердження пошти, подачі, черги модерації й блоків-категорій.
 *   php tests/mp-flow-e2e.php [http://ai-lab-hub.test]
 *
 * Сценарій від імені звичайного користувача з непідтвердженою поштою:
 *   «Подати» → вхід (next) → екран «Підтвердьте пошту» ДО форми → лист → повторний лист не надсилається →
 *   підтвердження в ІНШОМУ «браузері» без сесії → «Я підтвердив(ла)» → повернення до форми → чернетка зберігається
 *   й відновлюється → подача → «на модерації» → запис видно admin у «Модерація» (лічильник) і «Усі оголошення» →
 *   схвалення → з'являється в блоці своєї категорії, лічильник блока +1; порожні категорії приховані.
 * Плюс: оголошення дошки (pending) теж у «Модерації»; канонічний редірект (www/http) — модульно.
 * Тестові записи (користувачі, оголошення, токени, чернетки) видаляються за id наприкінці. Лише CLI, лише локально.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/canonical.php';

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

/** HTTP-запит без автоматичних редіректів. @return array{code:int,loc:string,body:string} */
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
    $head = substr($raw, 0, $hs);
    preg_match('/^Location:\s*(\S+)/mi', $head, $m);

    return ['code' => $code, 'loc' => $m[1] ?? '', 'body' => substr($raw, $hs), 'head' => $head];
}

/** CSRF маркетплейсу: з форми з action $action (на сторінці можуть бути інші csrf, напр. перемикач сайту). */
function csrf_in_form(string $html, string $action): string
{
    return preg_match('~<form[^>]*action="' . preg_quote($action, '~') . '"[^>]*>\s*<input type="hidden" name="csrf" value="([a-f0-9]{64})"~', $html, $m) === 1 ? $m[1] : '';
}

/** Вміст панелі вкладки data-pc-panel="$name". */
function panel_of(string $html, string $name): string
{
    $a = strpos($html, 'data-pc-panel="' . $name . '"');
    if ($a === false) {
        return '';
    }
    $b = strpos($html, '</section>', $a);

    return substr($html, $a, $b === false ? null : $b - $a);
}

function csrf_of(string $html): string
{
    return preg_match('/name="csrf" value="([a-f0-9]{64})"/', $html, $m) === 1 ? $m[1] : '';
}

$tmp = sys_get_temp_dir() . '/mpflow_' . bin2hex(random_bytes(4));
@mkdir($tmp);
$jarA = $tmp . '/a.txt';      // «застосунок на екрані Додому», де користувач увійшов
$jarB = $tmp . '/b.txt';      // «Safari / поштовий застосунок» без сесії
$jarAdm = $tmp . '/adm.txt';
$stamp = date('His') . random_int(100, 999);
$email = "e2e-user-{$stamp}@example.test";
$admEmail = "e2e-admin-{$stamp}@example.test";
$pass = 'Test12345!';
$created = ['users' => [], 'listings' => []];

$ins = $pdo->prepare('INSERT INTO users (name, email, password_hash, role) VALUES (:n, :e, :h, :r)');
$ins->execute([':n' => 'E2E User', ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT), ':r' => 'user']);
$uid = (int) $pdo->lastInsertId();
$ins->execute([':n' => 'E2E Admin', ':e' => $admEmail, ':h' => password_hash($pass, PASSWORD_DEFAULT), ':r' => 'admin']);
$aid = (int) $pdo->lastInsertId();
$created['users'] = [$uid, $aid];
$mailLog = __DIR__ . '/../storage/marketplace-mail.log';
$logSize0 = is_file($mailLog) ? filesize($mailLog) : 0;
clearstatcache();

try {
    echo "Канонічна адреса (модульно)\n";
    $saved = $_SERVER;
    $_SERVER = ['REQUEST_METHOD' => 'GET', 'HTTP_HOST' => 'www.ai-lab-hub.test', 'REQUEST_URI' => '/mp-verify.php?token=abc'];
    check(app_canonical_redirect_target() === 'http://ai-lab-hub.test/mp-verify.php?token=abc', 'www → канонічний хост, шлях і параметри збережено');
    $_SERVER = ['REQUEST_METHOD' => 'POST', 'HTTP_HOST' => 'www.ai-lab-hub.test', 'REQUEST_URI' => '/login.php'];
    check(app_canonical_redirect_target() === null, 'POST не перенаправляється');
    $_SERVER = ['REQUEST_METHOD' => 'GET', 'HTTP_HOST' => 'ai-lab-hub.test', 'REQUEST_URI' => '/'];
    check(app_canonical_redirect_target() === null, 'канонічний хост — без редіректу');
    $_SERVER = ['REQUEST_METHOD' => 'GET', 'HTTP_HOST' => 'evil.example', 'REQUEST_URI' => '/'];
    check(app_canonical_redirect_target() === null, 'сторонній хост — не чіпаємо');
    $_SERVER = $saved;

    echo "Гість → вхід із поверненням\n";
    $r = http($jarA, "$base/listing-post.php?type=job");
    check($r['code'] === 401 && str_contains($r['body'], 'login.php?next=listing-post.php%3Ftype%3Djob'), 'форма для гостя: 401 і посилання входу з next');
    $r = http($jarA, "$base/login.php?next=" . rawurlencode('listing-post.php?type=job'));
    $r = http($jarA, "$base/login.php", ['email' => "  $email", 'password' => $pass]);
    check($r['code'] === 302 && $r['loc'] === 'listing-post.php?type=job', 'після входу — повернення на форму (' . $r['loc'] . ')');
    check(str_contains($r['head'], 'SameSite=Lax') && preg_match('/expires=/i', $r['head']) === 1, 'кукі сесії: SameSite=Lax, постійна (expires)');
    $r = http($jarA, "$base/http-open-redirect-test");   // шум
    $r = http($jarA, "$base/login.php?next=" . rawurlencode('https://evil.example/'));
    check($r['code'] === 302 && $r['loc'] === 'account.php', 'next на чужий сайт ігнорується');

    echo "Підтвердження пошти — ДО показу форми\n";
    $r = http($jarA, "$base/listing-post.php?type=job");
    check($r['code'] === 303 && str_starts_with($r['loc'], 'mp-verify-email.php?next='), 'непідтверджена пошта → екран «Підтвердьте пошту» з next');
    $r = http($jarA, "$base/" . $r['loc']);
    $csrfA = csrf_of($r['body']);
    check($r['code'] === 200 && $csrfA !== '' && str_contains($r['body'], 'name="send"'), 'екран підтвердження: кнопка «Надіслати лист»');
    $r = http($jarA, "$base/mp-verify-email.php", ['csrf' => $csrfA, 'send' => '1', 'next' => 'listing-post.php?type=job']);
    check($r['code'] === 303, 'лист надіслано (303)');
    $cnt = $pdo->prepare('SELECT COUNT(*) FROM mp_email_verifications WHERE user_id = :u');
    $cnt->execute([':u' => $uid]);
    check((int) $cnt->fetchColumn() === 1, 'у БД 1 токен');
    $r = http($jarA, "$base/mp-verify-email.php", ['csrf' => $csrfA, 'send' => '1', 'next' => 'listing-post.php?type=job']);
    $cnt->execute([':u' => $uid]);
    check((int) $cnt->fetchColumn() === 1, 'повторне «Надіслати лист» при дійсному токені — нового листа немає');
    $r = http($jarA, "$base/mp-verify-email.php?next=" . rawurlencode('listing-post.php?type=job'));
    check(str_contains($r['body'], 'name="resend"') && str_contains($r['body'], 'check=1'), 'екран очікування: «Я підтвердив(ла)» і «Надіслати ще раз»');
    $r = http($jarA, "$base/mp-verify-email.php", ['csrf' => $csrfA, 'resend' => '1']);
    $cnt->execute([':u' => $uid]);
    check((int) $cnt->fetchColumn() === 1, '«Надіслати ще раз» одразу — обмеження частоти (1 лист на N хв)');
    $r = http($jarA, "$base/mp-verify-email.php?check=1&next=" . rawurlencode('listing-post.php?type=job'));
    check($r['code'] === 303 && str_contains($r['loc'], 'mp-verify-email.php'), '«Я підтвердив(ла)» до підтвердження — лишаємося на екрані');

    clearstatcache();
    $log = (string) file_get_contents($mailLog, false, null, $logSize0);
    preg_match_all('/mp-verify\.php\?token=([a-f0-9]{64})/', $log, $mm);
    $token = end($mm[1]) ?: '';
    check($token !== '', 'посилання з токеном є в листі');

    echo "Посилання відкрито в іншому браузері без сесії\n";
    $r = http($jarB, "$base/mp-verify.php?token=$token");
    check($r['code'] === 200 && str_contains($r['body'], 'name="token"') && !str_contains($r['body'], 'name="csrf"'), 'сторінка з кнопкою, без вимоги входу');
    $ver = $pdo->prepare('SELECT COUNT(*) FROM mp_email_verifications WHERE user_id = :u AND verified_at IS NOT NULL');
    $ver->execute([':u' => $uid]);
    check((int) $ver->fetchColumn() === 0, 'GET не витрачає токен');
    $r = http($jarB, "$base/mp-verify.php", ['token' => $token]);
    check($r['code'] === 200 && str_contains($r['body'], 'login.php?next=listing-post.php%3Ftype%3Djob'), 'POST без сесії: «Пошту підтверджено» + «Увійти й продовжити» з next');
    $ver->execute([':u' => $uid]);
    check((int) $ver->fetchColumn() === 1, 'у БД записано verified_at');
    $r = http($jarB, "$base/mp-verify.php?token=$token");
    check($r['code'] === 200 && !str_contains($r['body'], 'name="token"'), 'повторне відкриття використаного посилання — «Пошту підтверджено», не помилка');

    echo "Повернення до форми в першому браузері\n";
    $r = http($jarA, "$base/mp-verify-email.php?check=1&next=" . rawurlencode('listing-post.php?type=job'));
    check($r['code'] === 303 && $r['loc'] === 'listing-post.php?type=job', '«Я підтвердив(ла)» → одразу до форми');
    $r = http($jarA, "$base/listing-post.php?type=job");
    check($r['code'] === 200 && str_contains($r['body'], 'data-draft-key="listing:job"'), 'форма відкрилась без повторних запитів');
    check(str_contains($r['head'], 'no-store'), 'форма віддається з Cache-Control: no-store');
    $r2 = http($jarA, "$base/account.php");
    check(str_contains($r2['body'], 'account-verify__ok'), 'кабінет: «Пошту підтверджено ✓»');

    echo "Чернетка\n";
    $csrfF = csrf_of($r['body']);
    $focus = (int) $pdo->query("SELECT id FROM mp_categories WHERE section = 'focus' AND is_active = 1 ORDER BY sort_order, id LIMIT 1")->fetchColumn();
    // Підкатегорія блока «Вакансії» (дерево app/mp-tree.php) — обов'язкова; focus — додатковий фільтр.
    $jobBlock = (int) $pdo->query("SELECT id FROM mp_categories WHERE section = 'job' AND parent_id IS NULL LIMIT 1")->fetchColumn();
    $sub = (int) $pdo->query("SELECT id FROM mp_categories WHERE section = 'job' AND parent_id = $jobBlock AND is_active = 1 AND slug <> 'other' ORDER BY sort_order, id LIMIT 1")->fetchColumn();
    $title = "E2E Вакансія {$stamp}";
    $data = ['title' => $title, 'company_name' => 'E2E Company', 'short_desc' => 'Короткий опис тестової вакансії для перевірки.', 'cats[]' => [(string) $sub], 'focus[]' => [(string) $focus]];
    $r = http($jarA, "$base/mp-draft.php", ['csrf' => $csrfF, 'form_key' => 'listing:job', 'action' => 'save', 'data' => json_encode($data, JSON_UNESCAPED_UNICODE)]);
    check($r['code'] === 200 && str_contains($r['body'], '"ok":true'), 'автозбереження чернетки (mp-draft.php)');
    $r = http($jarA, "$base/listing-post.php?type=job");
    check(str_contains($r['body'], 'data-draft-json') && str_contains($r['body'], 'E2E Company'), 'чернетка відновлюється у формі після повернення');
    $r2 = http($jarA, "$base/account.php");
    check(str_contains($r2['body'], 'lst-drafts') && str_contains($r2['body'], htmlspecialchars($title, ENT_QUOTES)), 'чернетка видна в «Мої оголошення»');

    echo "Подача\n";
    preg_match('/name="ft" value="([^"]+)"/', $r['body'], $ft);
    sleep(6);   // мінімальний час заповнення форми (LST_MIN_FILL_SEC)
    $post = [
        'csrf' => csrf_of($r['body']), 'ft' => $ft[1] ?? '', 'type' => 'job', 'website' => '',
        'title' => $title, 'company_name' => 'E2E Company', 'short_desc' => 'Короткий опис тестової вакансії для перевірки.',
        'full_desc' => str_repeat('Повний опис тестової вакансії з обов’язками й вимогами. ', 3),
        'url' => 'https://example.com/', 'country' => 'UA', 'offer_lang' => 'uk', 'wf' => 'online', 'cats' => [$sub], 'focus' => [$focus], 'rules' => '1',
        'd' => ['employment' => 'full_time', 'schedule' => 'full_day', 'level' => 'junior'], 'fit' => ['students'],   // Хвиля 1: формат роботи, графік, «Підходить»
    ];
    $r = http($jarA, "$base/listing-post.php?type=job", $post);
    check($r['code'] === 303 && str_starts_with($r['loc'], 'listing-post.php?sent='), 'подача → екран «на модерації» (' . ($r['loc'] ?: 'код ' . $r['code']) . ')');
    $lid = (int) substr($r['loc'], strlen('listing-post.php?sent='));
    if ($lid > 0) {
        $created['listings'][] = $lid;
    }
    $r = http($jarA, "$base/" . $r['loc']);
    check(str_contains($r['body'], 'account.php#acc-listings') && preg_match('/\d+ год/u', $r['body']) === 1, '«Оголошення на модерації, відповімо протягом N год» + «Мої оголошення»');
    $st = $pdo->prepare('SELECT status, section FROM mp_listings WHERE id = :id');
    $st->execute([':id' => $lid]);
    $row = $st->fetch(PDO::FETCH_ASSOC) ?: [];
    check(($row['status'] ?? '') === 'pending' && ($row['section'] ?? '') === 'job', 'у БД: mp_listings, section job, status pending');
    $d = $pdo->prepare("SELECT COUNT(*) FROM mp_form_drafts WHERE user_id = :u");
    $d->execute([':u' => $uid]);
    check((int) $d->fetchColumn() === 0, 'чернетку видалено після подачі');
    $r2 = http($jarA, "$base/account.php");
    check(str_contains($r2['body'], htmlspecialchars($title, ENT_QUOTES)) && str_contains($r2['body'], 'pc-badge--pending'), 'автор у кабінеті бачить «На модерації»');

    // Оголошення дошки від того ж користувача (pending) — має бути в тій самій черзі.
    $sellerId = (int) $pdo->query('SELECT seller_id FROM mp_listings WHERE id = ' . $lid)->fetchColumn();
    $pdo->prepare("INSERT INTO mp_listings (seller_id, section, post_form, status, delivery_type, source_lang, created_by, price_type, is_remote) VALUES (:s, 'other', 'ad', 'pending', 'contact', 'uk', :u, 'none', 1)")
        ->execute([':s' => $sellerId, ':u' => $uid]);
    $bid = (int) $pdo->lastInsertId();
    $pdo->prepare("INSERT INTO mp_listing_categories (listing_id, category_id) SELECT :id, id FROM mp_categories WHERE section = 'other' AND parent_id IS NULL LIMIT 1")->execute([':id' => $bid]);
    $created['listings'][] = $bid;
    $pdo->prepare("INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, is_auto) VALUES (:id, 'uk', :t, 'Тестове оголошення дошки', 0)")
        ->execute([':id' => $bid, ':t' => "E2E Дошка {$stamp}"]);

    echo "Admin: черга модерації\n";
    $r = http($jarAdm, "$base/login.php", ['email' => $admEmail, 'password' => $pass]);
    $r = http($jarAdm, "$base/account.php?ladm_tab=mod");
    $b = $r['body'];
    check(str_contains($b, '#' . $lid . ' · Вакансія') && str_contains($b, htmlspecialchars($title, ENT_QUOTES)), '«Модерація»: вакансію видно');
    check(str_contains($b, '#' . $bid . ' · Інше · оголошення користувача') && str_contains($b, "E2E Дошка {$stamp}"), '«Модерація»: оголошення користувача (блок «Інше») теж видно');
    check(str_contains($b, '<strong>Блок:</strong> Вакансії') && str_contains($b, '<strong>Підкатегорії:</strong>'), '«Модерація»: показано блок і підкатегорії');
    check(preg_match('/data-pc-tab="mod"[^>]*>Модерація \((\d+)\)/u', $b, $mc) === 1 && (int) $mc[1] >= 2, 'лічильник «Модерація (N)» на вкладці (N=' . ($mc[1] ?? '?') . ')');
    check(preg_match('/Модерація оголошень \((\d+)\)/u', $b) === 1, 'лічильник у меню CRM');
    $r = http($jarAdm, "$base/account.php?ladm_tab=all&ladm_q=" . rawurlencode($email));
    check(str_contains($r['body'], htmlspecialchars($title, ENT_QUOTES)) && str_contains($r['body'], "E2E Дошка {$stamp}"), '«Усі оголошення»: пошук за email автора знаходить обидва');
    $r = http($jarAdm, "$base/account.php?ladm_tab=all&ladm_status=pending&ladm_type=other");
    $allPanel = panel_of($r['body'], 'all');
    check(str_contains($allPanel, "E2E Дошка {$stamp}") && !str_contains($allPanel, htmlspecialchars($title, ENT_QUOTES)), '«Усі оголошення»: фільтр за статусом і блоком');
    check(str_contains($allPanel, '<th>Блок</th><th>Підкатегорії</th>'), '«Усі оголошення»: колонки «Блок» і «Підкатегорії»');

    echo "Схвалення → блок категорії\n";
    $before = (int) (function () use ($pdo, $sub): int {
        $q = $pdo->prepare("SELECT COUNT(DISTINCT l.id) FROM mp_listings l JOIN mp_listing_categories lc ON lc.listing_id = l.id WHERE l.section = 'job' AND l.status = 'published' AND l.expires_at > NOW() AND lc.category_id = :c");
        $q->execute([':c' => $sub]);

        return (int) $q->fetchColumn();
    })();
    $hub0 = '';
    $csrfAdm = csrf_in_form(http($jarAdm, "$base/account.php?ladm_tab=mod")['body'], 'listing-admin-action.php');
    check($csrfAdm !== '', 'CSRF адмінки оголошень знайдено');
    $r = http($jarAdm, "$base/listing-admin-action.php", ['csrf' => $csrfAdm, 'action' => 'approve', 'id' => $lid, 'return_tab' => 'mod']);
    $st->execute([':id' => $lid]);
    check(($st->fetch(PDO::FETCH_ASSOC)['status'] ?? '') === 'published', 'схвалено: status published');
    $r = http($jarAdm, "$base/mp-moderation.php", ['csrf' => $csrfAdm, 'action' => 'approve', 'id' => $bid, 'return' => 'account']);
    check($r['code'] === 303 && $r['loc'] === 'account.php?ladm_tab=mod', 'дошку схвалено з єдиної черги, повернення в кабінет');
    $hub = http($jarB, "$base/marketplace-category.php?id=$jobBlock")['body'];
    $tile = '/marketplace-category\.php\?id=' . $sub . '".*?direction-card__count">(\d+)/su';
    preg_match($tile, $hub, $t1);
    check((int) ($t1[1] ?? -1) === $before + 1, "плитка підкатегорії: лічильник {$before} → " . ($t1[1] ?? '?'));
    check(str_contains($hub, htmlspecialchars($title, ENT_QUOTES)), 'вакансія у «Свіжих оголошеннях» блока');
    $cat = http($jarB, "$base/marketplace-category.php?id=$sub")['body'];
    check(str_contains($cat, htmlspecialchars($title, ENT_QUOTES)) && str_contains($cat, 'name="wf"') && str_contains($cat, 'name="city"') && str_contains($cat, 'name="sal"') && str_contains($cat, 'name="emp[]"'), 'сторінка підкатегорії: оголошення є, фільтри вакансій (формат, місто, зарплата, тип зайнятості)');
    $empty = $pdo->query("SELECT c.id FROM mp_categories c WHERE c.section = 'job' AND c.parent_id = $jobBlock AND c.is_active = 1 AND NOT EXISTS (SELECT 1 FROM mp_listing_categories lc JOIN mp_listings l ON l.id = lc.listing_id WHERE lc.category_id = c.id AND l.section = 'job' AND l.status = 'published' AND l.expires_at > NOW()) LIMIT 1")->fetchColumn();
    check($empty === false || !str_contains($hub, 'marketplace-category.php?id=' . (int) $empty . '"'), 'порожні підкатегорії приховані');
    unset($hub0);
} finally {
    echo "Прибирання тестових записів\n";
    foreach ($created['listings'] as $id) {
        foreach (['mp_listing_categories', 'mp_listing_translations', 'mp_listing_stats_daily', 'mp_moderation_log', 'mp_listing_places', 'mp_listing_tags', 'mp_listing_views_daily'] as $tbl) {
            try {
                $pdo->prepare("DELETE FROM $tbl WHERE listing_id = :id")->execute([':id' => $id]);
            } catch (Throwable $e) {
            }
        }
        $pdo->prepare('DELETE FROM mp_listings WHERE id = :id')->execute([':id' => $id]);
    }
    foreach ($created['users'] as $id) {
        $pdo->prepare('DELETE FROM mp_email_verifications WHERE user_id = :u')->execute([':u' => $id]);
        $pdo->prepare('DELETE FROM mp_form_drafts WHERE user_id = :u')->execute([':u' => $id]);
        $pdo->prepare('DELETE FROM mp_sellers WHERE user_id = :u')->execute([':u' => $id]);
        try {
            $pdo->prepare('DELETE FROM mail_queue WHERE to_email IN (:e1, :e2)')->execute([':e1' => $email, ':e2' => $admEmail]);
        } catch (Throwable $e) {
        }
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $id]);
    }
    echo '  видалено: users ' . implode(',', $created['users']) . '; listings ' . implode(',', $created['listings']) . "\n";
    array_map('unlink', glob($tmp . '/*') ?: []);
    @rmdir($tmp);
}

echo "\nРазом: " . ($total - $fails) . " / $total" . ($fails > 0 ? " — FAIL: $fails" : ' — усе гаразд') . "\n";
exit($fails > 0 ? 1 : 0);
