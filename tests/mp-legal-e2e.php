<?php

declare(strict_types=1);

/**
 * AI LAB HUB — наскрізний тест Правил Marketplace і юридичних механізмів (HTTP до локального сайту + БД).
 *   php tests/mp-legal-e2e.php [http://ai-lab-hub.test]
 *
 * Сценарії (крок 13 завдання):
 *   1. Подача без галочки згоди відхиляється сервером (POST без JS).
 *   2. Нове оголошення звичайного користувача → pending, публічно не видно; rules_version = MP_RULES_VERSION.
 *   3. Скарга «авторські права» без обов'язкових полів не приймається (і нічого не записується).
 *   4. Приховане оголошення не видно ні в списку, ні за прямим посиланням (крім автора й admin).
 *   5. Контактів немає в HTML до кнопки; після MP_CONTACT_VIEWS_PER_DAY переглядів за добу — 429.
 *   6. Оскарження після MP_APPEAL_WINDOW_DAYS днів недоступне (у строк — приймається, admin відновлює).
 *   7. Сторінка Правил UA і EN: строки збігаються з константами config/marketplace.php.
 *   8. Міграція database/marketplace_legal_migration.sql виконується двічі поспіль без помилок.
 * Плюс: скарга правовласника → повідомлення автору без даних заявника → заперечення; санкція → форма подачі закрита.
 * Тестові записи видаляються за id наприкінці. Лише CLI, лише локально.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/marketplace.php';   // константи MP_*

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

/** @return array{code:int,loc:string,body:string} */
function http(string $jar, string $url, ?array $post = null, array $headers = []): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true, CURLOPT_HEADER => true, CURLOPT_FOLLOWLOCATION => false,
        CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 60, CURLOPT_HTTPHEADER => $headers,
        CURLOPT_USERAGENT => 'Mozilla/5.0 mp-legal-e2e',
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

$tag = bin2hex(random_bytes(3));
$pass = 'E2e-' . bin2hex(random_bytes(6));
$users = [];
$listings = [];
$mkUser = static function (string $name, string $role) use ($pdo, $tag, $pass, &$users): array {
    $email = "mpl-$name-$tag@example.test";
    $pdo->prepare('INSERT INTO users (name, email, password_hash, role) VALUES (:n, :e, :h, :r)')
        ->execute([':n' => "MPL $name", ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT), ':r' => $role]);
    $id = (int) $pdo->lastInsertId();
    // Пошту підтверджено «давно» — як у реального користувача.
    $pdo->prepare('INSERT INTO mp_email_verifications (user_id, email, token_hash, created_at, expires_at, verified_at)
                   VALUES (:u, :e, :t, NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 3 DAY)')
        ->execute([':u' => $id, ':e' => $email, ':t' => hash('sha256', $email)]);
    $users[] = $id;

    return ['id' => $id, 'email' => $email];
};
$author = $mkUser('author', 'user');
$viewer = $mkUser('viewer', 'user');
$admin = $mkUser('admin', 'admin');
$jarA = tempnam(sys_get_temp_dir(), 'mpl');
$jarV = tempnam(sys_get_temp_dir(), 'mpl');
$jarAdm = tempnam(sys_get_temp_dir(), 'mpl');
$jarG = tempnam(sys_get_temp_dir(), 'mpl');

$listingStatus = static function (int $id) use ($pdo): string {
    $s = $pdo->prepare('SELECT status FROM mp_listings WHERE id = :id');
    $s->execute([':id' => $id]);

    return (string) $s->fetchColumn();
};

try {
    check(login($jarA, $base, $author['email'], $pass) && login($jarV, $base, $viewer['email'], $pass) && login($jarAdm, $base, $admin['email'], $pass), 'вхід трьох тестових користувачів');

    // ------------------------------------------------------------------
    echo "1. Згода з Правилами обов'язкова (сервер, без JS)\n";
    $form = http($jarA, "$base/marketplace-post.php?block=solution");
    $csrf = csrf_of($form['body']);
    preg_match('/name="cats\[\]" value="(\d+)"/', $form['body'], $cm);
    check($form['code'] === 200 && $csrf !== '' && isset($cm[1]), 'форма подачі відкривається');
    check(preg_match('/<input type="checkbox" name="rules" value="1" required>/', $form['body']) === 1, 'галочка згоди не відмічена за замовчуванням');
    check(str_contains($form['body'], 'name="ai_media"') && str_contains($form['body'], 'name="usage_terms"'), 'нові поля: AI-медіа й умови використання');
    $title = "MPL test listing $tag";
    $fields = [
        'csrf' => $csrf, 'website' => '', 'block' => 'solution', 'title' => $title, 'short_desc' => 'Короткий опис тестового оголошення',
        'full_desc' => '', 'cats' => [$cm[1] ?? 0], 'price_type' => 'none', 'work_format' => 'online', 'online_scope' => 'worldwide',
        'contact_name' => 'Tester', 'contact_phone' => '+380501112233', 'contact_email' => '', 'contact_telegram' => '',
        'ai_media' => '1', 'usage_terms' => 'commercial',
    ];
    $before = (int) $pdo->query("SELECT COUNT(*) FROM mp_listing_translations WHERE title = " . $pdo->quote($title))->fetchColumn();
    $r = http($jarA, "$base/marketplace-post.php?block=solution", $fields);   // без 'rules'
    $after = (int) $pdo->query("SELECT COUNT(*) FROM mp_listing_translations WHERE title = " . $pdo->quote($title))->fetchColumn();
    check($r['code'] === 200 && str_contains($r['body'], 'прийміть Правила Marketplace') && $after === $before, 'без галочки: помилка біля галочки, оголошення не створено');

    // ------------------------------------------------------------------
    echo "2. Нове оголошення користувача → pending, публічно не видно\n";
    $r = http($jarA, "$base/marketplace-post.php?block=solution", ['rules' => '1', 'csrf' => csrf_of($r['body'])] + $fields);
    preg_match('/sent=(\d+)/', $r['loc'], $sm);
    $lid = (int) ($sm[1] ?? 0);
    if ($lid > 0) {
        $listings[] = $lid;
    }
    $row = $pdo->prepare('SELECT status, rules_version, rules_accepted_at, ai_generated_media, usage_terms FROM mp_listings WHERE id = :id');
    $row->execute([':id' => $lid]);
    $row = $row->fetch(PDO::FETCH_ASSOC) ?: [];
    check($r['code'] === 303 && $lid > 0 && ($row['status'] ?? '') === 'pending', 'подано → status=pending');
    check(($row['rules_version'] ?? '') === MP_RULES_VERSION && !empty($row['rules_accepted_at']), 'збережено rules_version = ' . MP_RULES_VERSION . ' і rules_accepted_at');
    check((int) ($row['ai_generated_media'] ?? 0) === 1 && ($row['usage_terms'] ?? '') === 'commercial', 'збережено ai_generated_media і usage_terms');
    check(http($jarG, "$base/marketplace-offer.php?id=$lid")['code'] === 404, 'гість: сторінка pending-оголошення — 404');
    check(!str_contains(http($jarG, "$base/marketplace.php?q=" . rawurlencode($title))['body'], "marketplace-offer.php?id=$lid\""), 'гість: у списку Marketplace немає');
    check(http($jarA, "$base/marketplace-offer.php?id=$lid")['code'] === 200, 'автор бачить свій попередній перегляд');

    // Модерація: «на доопрацювання» без пункту Правил — відмова; з пунктом — статус і причина в кабінеті.
    $mod = http($jarAdm, "$base/mp-moderation.php?id=$lid");
    $mc = csrf_of($mod['body']);
    check($mod['code'] === 200 && str_contains($mod['body'], $title) && str_contains($mod['body'], 'name="code"'), 'admin бачить оголошення в черзі, є вибір пункту Правил');
    http($jarAdm, "$base/mp-moderation.php?id=$lid", ['csrf' => $mc, 'id' => $lid, 'action' => 'decision', 'decision' => 'needs_changes', 'code' => '', 'reason' => 'x']);
    check($listingStatus($lid) === 'pending', 'рішення без пункту Правил не застосовується');
    http($jarAdm, "$base/mp-moderation.php?id=$lid", ['csrf' => $mc, 'id' => $lid, 'action' => 'decision', 'decision' => 'needs_changes', 'code' => '4', 'reason' => 'Уточніть ціну']);
    check($listingStatus($lid) === 'needs_changes', 'на доопрацювання → needs_changes');
    $my = http($jarA, "$base/marketplace-my.php?tab=attention");
    check(str_contains($my['body'], 'Уточніть ціну') && str_contains($my['body'], 'Розділ 4'), 'автор бачить статус і причину (пункт + пояснення)');
    check(str_contains($my['body'], 'повернуто на доопрацювання'), 'автор отримав повідомлення в кабінеті');
    // Автор виправляє → знову pending → admin публікує
    $ed = http($jarA, "$base/marketplace-post.php?id=$lid");
    http($jarA, "$base/marketplace-post.php?id=$lid&block=solution", ['rules' => '1', 'csrf' => csrf_of($ed['body'])] + $fields);
    check($listingStatus($lid) === 'pending', 'після редагування → pending');
    http($jarAdm, "$base/mp-moderation.php?id=$lid", ['csrf' => $mc, 'id' => $lid, 'action' => 'approve']);
    check($listingStatus($lid) === 'published', 'admin опублікував');
    $exp = $pdo->prepare('SELECT DATEDIFF(expires_at, NOW()) FROM mp_listings WHERE id = :id');
    $exp->execute([':id' => $lid]);
    check(abs((int) $exp->fetchColumn() - MP_LISTING_LIFETIME_DAYS) <= 1, 'строк публікації = MP_LISTING_LIFETIME_DAYS (' . MP_LISTING_LIFETIME_DAYS . ')');
    check(str_contains(http($jarG, "$base/marketplace.php?q=" . rawurlencode($title))['body'], "marketplace-offer.php?id=$lid\""), 'контроль: опубліковане оголошення є у списку');
    $page = http($jarG, "$base/marketplace-offer.php?id=$lid");
    check($page['code'] === 200 && str_contains($page['body'], 'Створено з AI') && str_contains($page['body'], 'Можна комерційно'), 'сторінка: мітка «Створено з AI» і умови використання');

    // ------------------------------------------------------------------
    echo "5. Контакти: немає в HTML до кнопки; ліміт MP_CONTACT_VIEWS_PER_DAY\n";
    check(!str_contains($page['body'], '501112233'), 'гість: телефону немає в HTML сторінки');
    $vp = http($jarV, "$base/marketplace-offer.php?id=$lid");
    check(!str_contains($vp['body'], '501112233') && str_contains($vp['body'], 'mp-contact.php'), 'залогінений: телефону немає в HTML до натискання');
    $cr = http($jarV, "$base/mp-contact.php", ['csrf' => csrf_of($vp['body']), 'id' => $lid], ['Accept: application/json']);
    $cj = json_decode($cr['body'], true);
    check($cr['code'] === 200 && ($cj['ok'] ?? false) === true && str_contains($cr['body'], '501112233'), 'після «Показати контакти» — телефон у відповіді');
    $ipc = $pdo->prepare('SELECT ip_hash FROM mp_contact_reveals WHERE listing_id = :l AND user_id = :u');
    $ipc->execute([':l' => $lid, ':u' => $viewer['id']]);
    check(strlen((string) $ipc->fetchColumn()) === 64, 'перегляд записано (user, listing, час, хеш IP)');
    $fill = $pdo->prepare('INSERT INTO mp_contact_reveals (listing_id, user_id) VALUES (:l, :u)');
    for ($i = 1; $i < MP_CONTACT_VIEWS_PER_DAY; $i++) {
        $fill->execute([':l' => 990000000 + $i, ':u' => $viewer['id']]);
    }
    // Перегляд цього оголошення сьогодні вже був (він не з'їдає ліміт повторно) — прибираємо його й добиваємо ліміт до 50.
    $pdo->prepare("DELETE FROM mp_contact_reveals WHERE listing_id = :l AND user_id = :u")->execute([':l' => $lid, ':u' => $viewer['id']]);
    $fill->execute([':l' => 990000000, ':u' => $viewer['id']]);
    $cr = http($jarV, "$base/mp-contact.php", ['csrf' => csrf_of($vp['body']), 'id' => $lid], ['Accept: application/json']);
    check($cr['code'] === 429 && !str_contains($cr['body'], '501112233') && str_contains($cr['body'], (string) MP_CONTACT_VIEWS_PER_DAY), 'після ліміту: 429, контакти не віддаються');

    // ------------------------------------------------------------------
    echo "3. Скарга про авторські права: обов'язкові поля\n";
    $cBefore = (int) $pdo->query("SELECT COUNT(*) FROM mp_complaints WHERE listing_id = $lid")->fetchColumn();
    $cpage = http($jarG, "$base/marketplace-offer.php?id=$lid");
    check(str_contains($cpage['body'], 'action="mp-complaint.php"') && str_contains($cpage['body'], 'name="email"'), 'гість бачить форму скарги з полем email');
    $r = http($jarG, "$base/mp-complaint.php", ['csrf' => csrf_of($cpage['body']), 'id' => $lid, 'reason' => 'copyright', 'email' => "guest-$tag@example.test", 'note' => 'Це моє фото']);
    $cAfter = (int) $pdo->query("SELECT COUNT(*) FROM mp_complaints WHERE listing_id = $lid")->fetchColumn();
    check($r['code'] === 422 && str_contains($r['body'], 'Вкажіть ім') && str_contains($r['body'], 'добросовісно') && $cAfter === $cBefore, 'без полів п. 10.1 — 422, скаргу не записано');
    $r = http($jarG, "$base/mp-complaint.php", ['csrf' => csrf_of($cpage['body']), 'id' => $lid, 'reason' => 'fraud', 'note' => 'Підозріло']);
    check($r['code'] === 422 && str_contains($r['body'], 'коректний email'), 'гість без email — 422');
    $full = ['csrf' => csrf_of($cpage['body']), 'id' => $lid, 'reason' => 'copyright', 'email' => "guest-$tag@example.test", 'note' => 'Фото взято з мого портфоліо',
        'claimant_name' => "Секретний Заявник $tag", 'claimant_contact' => 'claimant@example.test', 'infringed_work' => 'Фото «Захід сонця», 2024',
        'evidence_url' => 'https://example.test/portfolio', 'good_faith' => '1'];
    $r = http($jarG, "$base/mp-complaint.php", $full);
    check($r['code'] === 303 && (int) $pdo->query("SELECT COUNT(*) FROM mp_complaints WHERE listing_id = $lid AND status = 'new'")->fetchColumn() === 1, 'повна заява правовласника прийнята (status=new)');
    $my = http($jarA, "$base/marketplace-my.php");
    check(str_contains($my['body'], 'Захід сонця') && !str_contains($my['body'], "Секретний Заявник $tag") && !str_contains($my['body'], 'claimant@example.test'), 'автор бачить суть претензії, але не дані заявника');
    check(str_contains($my['body'], 'name="action" value="counter"'), 'автор може подати заперечення');
    $cid = (int) $pdo->query("SELECT id FROM mp_complaints WHERE listing_id = $lid ORDER BY id DESC LIMIT 1")->fetchColumn();
    http($jarA, "$base/mp-legal-action.php", ['csrf' => csrf_of($my['body']), 'action' => 'counter', 'complaint_id' => $cid, 'text' => 'Фото моє, ось RAW-файл', 'url' => 'https://example.test/raw']);
    check((int) $pdo->query("SELECT counter_at IS NOT NULL FROM mp_complaints WHERE id = $cid")->fetchColumn() === 1, 'заперечення збережено');

    // ------------------------------------------------------------------
    echo "4. Приховане оголошення (скарга на розгляді)\n";
    $la = http($jarAdm, "$base/mp-legal-admin.php?tab=complaints");
    check(str_contains($la['body'], "Секретний Заявник $tag") && str_contains($la['body'], 'Фото моє'), 'admin бачить заявника і заперечення');
    http($jarAdm, "$base/mp-legal-admin.php?tab=complaints", ['csrf' => csrf_of($la['body']), 'complaint_id' => $cid, 'action' => 'hide', 'note' => 'Розглядаємо']);
    check($listingStatus($lid) === 'hidden', '«Приховати на час розгляду» → hidden');
    check(http($jarG, "$base/marketplace-offer.php?id=$lid")['code'] === 404, 'гість: за прямим посиланням — 404');
    check(http($jarV, "$base/marketplace-offer.php?id=$lid")['code'] === 404, 'інший користувач: 404');
    check(!str_contains(http($jarG, "$base/marketplace.php?q=" . rawurlencode($title))['body'], "marketplace-offer.php?id=$lid\""), 'у списку Marketplace немає');
    $own = http($jarA, "$base/marketplace-offer.php?id=$lid");
    check($own['code'] === 200 && str_contains($own['body'], 'приховано'), 'автор бачить (з позначкою статусу)');
    check(http($jarAdm, "$base/marketplace-offer.php?id=$lid")['code'] === 200, 'admin бачить');
    check(http($jarG, "$base/mp-photo.php?f=" . str_repeat('0', 32) . '.jpg')['code'] === 404, 'фото без запису в БД — 404');
    $ed = http($jarA, "$base/marketplace-post.php?id=$lid");
    check($ed['code'] === 403, 'приховане оголошення не редагується');

    // ------------------------------------------------------------------
    echo "6. Оскарження (п. 7.5)\n";
    $my = http($jarA, "$base/marketplace-my.php");
    check(str_contains($my['body'], 'name="action" value="appeal"') && str_contains($my['body'], 'name="listing_id" value="' . $lid . '"'), 'у строк: кнопка оскарження є');
    // Строк минув: рішення 15 днів тому
    $pdo->prepare('UPDATE mp_listings SET status_changed_at = NOW() - INTERVAL ' . (MP_APPEAL_WINDOW_DAYS + 1) . ' DAY WHERE id = :id')->execute([':id' => $lid]);
    $my = http($jarA, "$base/marketplace-my.php");
    check(!str_contains($my['body'], 'name="listing_id" value="' . $lid . '"'), 'після ' . MP_APPEAL_WINDOW_DAYS . ' днів кнопки немає');
    http($jarA, "$base/mp-legal-action.php", ['csrf' => csrf_of($my['body']), 'action' => 'appeal', 'listing_id' => $lid, 'text' => 'Прошу переглянути рішення']);
    check((int) $pdo->query("SELECT COUNT(*) FROM mp_appeals WHERE listing_id = $lid")->fetchColumn() === 0, 'прямий POST після строку — оскарження не створено');
    $pdo->prepare('UPDATE mp_listings SET status_changed_at = NOW() - INTERVAL 1 DAY WHERE id = :id')->execute([':id' => $lid]);
    http($jarA, "$base/mp-legal-action.php", ['csrf' => csrf_of($my['body']), 'action' => 'appeal', 'listing_id' => $lid, 'text' => 'Прошу переглянути рішення']);
    $aid = (int) $pdo->query("SELECT id FROM mp_appeals WHERE listing_id = $lid AND status = 'open'")->fetchColumn();
    check($aid > 0, 'у строк — оскарження прийнято');
    $ap = http($jarAdm, "$base/mp-legal-admin.php?tab=appeals");
    http($jarAdm, "$base/mp-legal-admin.php?tab=appeals", ['csrf' => csrf_of($ap['body']), 'appeal_id' => $aid, 'action' => 'appeal_uphold', 'note' => '']);
    check($listingStatus($lid) === 'hidden', '«Залишити рішення» без коментаря — не виконується');
    http($jarAdm, "$base/mp-legal-admin.php?tab=appeals", ['csrf' => csrf_of($ap['body']), 'appeal_id' => $aid, 'action' => 'appeal_restore', 'note' => 'Права підтверджено']);
    check($listingStatus($lid) === 'published' && http($jarG, "$base/marketplace-offer.php?id=$lid")['code'] === 200, '«Відновити оголошення» → знову опубліковано');
    check(str_contains(http($jarA, "$base/marketplace-my.php")['body'], 'Оскарження щодо'), 'автор отримав повідомлення про рішення');

    // ------------------------------------------------------------------
    echo "Санкції (п. 7.3–7.4)\n";
    $uc = http($jarAdm, "$base/mp-legal-admin.php?tab=users&q=" . $author['id']);
    http($jarAdm, "$base/mp-legal-admin.php?tab=users&q=" . $author['id'], ['csrf' => csrf_of($uc['body']), 'user_id' => $author['id'], 'action' => 'ban', 'days' => '7', 'note' => 'Повторні порушення']);
    $pf = http($jarA, "$base/marketplace-post.php?block=solution");
    check($pf['code'] === 403 && str_contains($pf['body'], 'section-7') && str_contains($pf['body'], 'обмежила'), 'заборона подачі: зрозуміле повідомлення з посиланням на п. 7.5');
    http($jarAdm, "$base/mp-legal-admin.php?tab=users&q=" . $author['id'], ['csrf' => csrf_of($uc['body']), 'user_id' => $author['id'], 'action' => 'unblock', 'note' => '']);
    check(http($jarA, "$base/marketplace-post.php?block=solution")['code'] === 200, 'зняття обмежень — форма знову доступна');

    // ------------------------------------------------------------------
    echo "7. Сторінка Правил UA і EN — строки з config/marketplace.php\n";
    http($jarG, "$base/marketplace-rules.php?lang=uk");
    $uk = http($jarG, "$base/marketplace-rules.php");
    $v = date('d.m.Y', (int) strtotime(MP_RULES_VERSION));
    check($uk['code'] === 200 && str_contains($uk['body'], "Редакція від $v"), "UA: редакція від $v");
    foreach ([
        'до ' . MP_MODERATION_DAYS . ' робочих днів', 'протягом ' . MP_APPEAL_WINDOW_DAYS . ' днів у своєму кабінеті',
        'протягом ' . MP_APPEAL_ANSWER_DAYS . ' робочих днів', 'протягом ' . MP_IP_REVIEW_DAYS . ' робочих днів',
        'протягом ' . MP_COUNTER_NOTICE_DAYS . ' робочих днів надати', 'через ' . MP_LISTING_LIFETIME_DAYS . ' днів',
        'за ' . MP_RULES_CHANGE_NOTICE_DAYS . ' днів до', 'mailto:' . MP_ABUSE_EMAIL,
    ] as $needle) {
        check(str_contains($uk['body'], $needle), "UA: «{$needle}»");
    }
    check(str_contains($uk['body'], 'id="section-7"') && str_contains($uk['body'], 'id="section-7-5"') && !str_contains($uk['body'], 'mp-ph"'), 'UA: якорі розділів і пунктів, без невідомих маркерів');
    check(str_contains($uk['body'], 'href="terms.php"') && str_contains($uk['body'], 'href="privacy.php"'), 'UA: посилання на Умови й Політику');
    http($jarG, "$base/marketplace-rules.php?lang=en");
    $en = http($jarG, "$base/marketplace-rules.php");
    check($en['code'] === 200 && str_contains($en['body'], 'Version of ' . MP_RULES_VERSION), 'EN: version of ' . MP_RULES_VERSION);
    foreach ([
        'up to ' . MP_MODERATION_DAYS . ' business days', 'within ' . MP_APPEAL_WINDOW_DAYS . ' days in their account',
        'within ' . MP_APPEAL_ANSWER_DAYS . ' business days', 'within ' . MP_IP_REVIEW_DAYS . ' business days',
        'within ' . MP_COUNTER_NOTICE_DAYS . ' business days', 'after ' . MP_LISTING_LIFETIME_DAYS . ' days',
        MP_RULES_CHANGE_NOTICE_DAYS . ' days before', 'mailto:' . MP_ABUSE_EMAIL,
    ] as $needle) {
        check(str_contains($en['body'], $needle), "EN: «{$needle}»");
    }
    http($jarG, "$base/marketplace-rules.php?lang=uk");
    check(str_contains(http($jarG, "$base/index.php")['body'], 'href="marketplace-rules.php"'), 'посилання на Правила в підвалі');

    // ------------------------------------------------------------------
    echo "8. Міграція двічі поспіль\n";
    $mysql = glob('C:/laragon/bin/mysql/*/bin/mysql.exe')[0] ?? 'mysql';
    $cfg = (static fn(): array => ['db' => $pdo->query('SELECT DATABASE()')->fetchColumn()])();
    $sql = realpath(__DIR__ . '/../database/marketplace_legal_migration.sql');
    $ok = true;
    for ($i = 1; $i <= 2; $i++) {
        $out = [];
        exec('"' . $mysql . '" -uroot ' . escapeshellarg((string) $cfg['db']) . ' < "' . $sql . '" 2>&1', $out, $code);
        $ok = $ok && $code === 0;
        check($code === 0, "запуск $i: код $code" . ($out !== [] ? ' — ' . implode(' ', $out) : ''));
    }
} catch (Throwable $e) {
    check(false, 'виняток: ' . $e->getMessage() . ' @ ' . basename($e->getFile()) . ':' . $e->getLine());
} finally {
    foreach ($listings as $id) {
        foreach (['mp_listing_translations', 'mp_listing_categories', 'mp_listing_photos', 'mp_listing_places', 'mp_listing_tags', 'mp_listing_stats_daily',
            'mp_listing_views_daily', 'mp_moderation_log', 'mp_reports', 'mp_complaints', 'mp_appeals', 'mp_contact_reveals', 'mp_favorites'] as $tbl) {
            try {
                $pdo->prepare("DELETE FROM $tbl WHERE listing_id = :id")->execute([':id' => $id]);
            } catch (Throwable) {
            }
        }
        $pdo->prepare('DELETE FROM mp_listings WHERE id = :id')->execute([':id' => $id]);
    }
    foreach ($users as $id) {
        foreach (['mp_email_verifications', 'mp_form_drafts', 'mp_sellers', 'mp_notifications', 'mp_user_sanctions', 'mp_contact_reveals'] as $tbl) {
            try {
                $pdo->prepare("DELETE FROM $tbl WHERE user_id = :u")->execute([':u' => $id]);
            } catch (Throwable) {
            }
        }
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $id]);
    }
    $pdo->prepare("DELETE FROM mp_complaints WHERE reporter_email = :e")->execute([':e' => "guest-$tag@example.test"]);
    $pdo->prepare("DELETE FROM mail_queue WHERE to_email LIKE :e")->execute([':e' => "mpl-%-$tag@example.test"]);
    foreach ([$jarA, $jarV, $jarAdm, $jarG] as $j) {
        @unlink($j);
    }
    echo "\nРазом: $total, помилок: $fails\n";
    exit($fails > 0 ? 1 : 0);
}
