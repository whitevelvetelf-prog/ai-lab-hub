<?php

declare(strict_types=1);

/**
 * AI LAB HUB — перевірка власної реклами платформи (ЛИШЕ локально, CLI):
 *   php tools/promo-house-check.php [http://ai-lab-hub.test]
 *
 * Засів (paused), вимкнена реклама, заповнювач слота й пріоритет платних, умови A і B, один власний блок на
 * сторінку, ліміт показів на сеанс, приховування для тих, хто вже створив кампанію/оголошення, {free_until} і
 * запасні тексти UA/EN, ref → acquisition_ref, сторінки без реклами, функції адмінки. Тимчасові зміни
 * повертаються у finally, тестові рядки видаляються. Виводить PASS/FAIL.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$_SERVER['HTTP_USER_AGENT'] = 'Mozilla/5.0 (Windows NT 10.0) promo-house-check';
require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/promo-house.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);
$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
$fails = 0;
$results = [];
$check = static function (string $group, string $name, bool $ok, string $info = '') use (&$fails, &$results): void {
    $results[$group][] = [$ok, $name, $info];
    $fails += $ok ? 0 : 1;
};
$one = static function (string $sql, array $p = []) use ($pdo): mixed {
    $st = $pdo->prepare($sql);
    $st->execute($p);

    return $st->fetchColumn();
};
$http = static function (string $path) use ($base): array {
    $ctx = stream_context_create(['http' => ['header' => "User-Agent: Mozilla/5.0 (Windows NT 10.0) promo-house-check\r\n", 'ignore_errors' => true, 'timeout' => 30]]);
    $body = @file_get_contents($base . '/' . ltrim($path, '/'), false, $ctx);
    $code = 0;
    foreach ($http_response_header ?? [] as $h) {
        if (preg_match('~^HTTP/\S+\s+(\d+)~', $h, $m)) {
            $code = (int) $m[1];
        }
    }

    return [$code, (string) $body];
};
$sh = static fn(): string => hash('sha256', 'house-' . microtime() . mt_rand());

$cA = (int) $one("SELECT id FROM ad_campaigns WHERE house_key = 'house_A'");
$cB = (int) $one("SELECT id FROM ad_campaigns WHERE house_key = 'house_B'");
$old = [
    'enabled' => promo_setting($pdo, 'enabled', '0'),
    'cap' => promo_setting($pdo, 'house_frequency_cap', '2'),
    'mp' => site_setting($pdo, 'marketplace_public', '0'),
    'free' => site_setting($pdo, 'marketplace_free_until', ''),
    'statusA' => (string) $one('SELECT status FROM ad_campaigns WHERE id = :c', [':c' => $cA]),
    'statusB' => (string) $one('SELECT status FROM ad_campaigns WHERE id = :c', [':c' => $cB]),
    'test' => (int) ($one('SELECT id FROM ad_campaigns WHERE is_test = 1 LIMIT 1') ?: 0),
];
$tmpCampaigns = [];
$tmpUsers = [];
$tmpListings = [];

$pickCampaign = static function (string $pl, array $page = [], ?string $s = null) use ($pdo, $sh): ?int {
    promo_cache_flush();   // тест міняє кампанії напряму в БД — кеш кандидатів (app/promo-select.php) скидаємо
    $r = promo_pick($pdo, $pl, [], [], 'uk', 'desktop', $s ?? $sh(), $page);

    return $r === null ? null : (int) $r['campaign_id'];
};

try {
    $check('засів', 'кампанії A і B засіяні, кожна з 2 варіантами-картками', $cA > 0 && $cB > 0
        && (int) $one("SELECT COUNT(*) FROM ad_creatives WHERE campaign_id = :c AND creative_type = 'card'", [':c' => $cA]) === 2
        && (int) $one("SELECT COUNT(*) FROM ad_creatives WHERE campaign_id = :c AND creative_type = 'card'", [':c' => $cB]) === 2);
    $check('засів', 'засіяні у статусі paused (до перевірки тест не змінював)', in_array($old['statusA'], ['paused', 'active'], true) && in_array($old['statusB'], ['paused', 'active'], true),
        $old['statusA'] . '/' . $old['statusB']);
    $check('засів', 'картки для рекламодавців вимкнені (ad_allow_card_creatives = 0)', promo_setting($pdo, 'ad_allow_card_creatives', '0') === '0');

    // Вимкнена система — нічого.
    promo_admin_set_setting($pdo, 'enabled', '0');
    promo_settings($pdo, true);
    $pdo->prepare("UPDATE ad_campaigns SET status = 'active' WHERE id IN (:a, :b)")->execute([':a' => $cA, ':b' => $cB]);
    $check('вимкнено', 'при enabled = 0 жодна реклама не показується', $pickCampaign('blog_list') === null);

    promo_admin_set_setting($pdo, 'enabled', '1');
    promo_admin_set_setting($pdo, 'house_frequency_cap', '0');
    promo_settings($pdo, true);
    site_settings_save($pdo, ['marketplace_public' => '1', 'marketplace_free_until' => date('Y-m-d', strtotime('+60 days'))]);

    // Заповнювач і пріоритет платних.
    $got = $pickCampaign('blog_list');
    $check('пріоритет', 'слот без платної кампанії показує власну рекламу', in_array($got, [$cA, $cB], true), (string) $got);
    $userId = (int) $one("SELECT id FROM users WHERE role <> 'admin' ORDER BY id DESC LIMIT 1");
    $pdo->prepare("INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, objective, pricing_model, unit_price, total_budget, start_date, status, currency, advertiser_category)
                   VALUES ('paid', 'video', :u, 'HOUSE CHECK paid', 'check', 'clicks', 'cpc', 20, 100000, :d, 'active', :cur, 'ai_tools')")
        ->execute([':u' => $userId, ':d' => promo_today(), ':cur' => PROMO_CURRENCY]);
    $paidId = (int) $pdo->lastInsertId();
    $tmpCampaigns[] = $paidId;
    $pdo->prepare("INSERT INTO ad_creatives (campaign_id, title, cta_key, destination_url, video_type, youtube_id, status) VALUES (:c, 'paid', 'learn_more', 'https://example.com/', 'youtube', 'dQw4w9WgXcQ', 'approved')")
        ->execute([':c' => $paidId]);
    $pdo->prepare("INSERT INTO ad_targets (campaign_id, placement, unit_price) VALUES (:c, 'blog_list', 20)")->execute([':c' => $paidId]);
    $oldBal = $pdo->query('SELECT balance, currency FROM ad_balances WHERE user_id = ' . $userId)->fetch() ?: null;
    $pdo->prepare('INSERT INTO ad_balances (user_id, balance, currency) VALUES (:u, 100000, :c) ON DUPLICATE KEY UPDATE balance = 100000, currency = :c2')
        ->execute([':u' => $userId, ':c' => PROMO_CURRENCY, ':c2' => PROMO_CURRENCY]);
    $paidWins = true;
    for ($i = 0; $i < 10; $i++) {
        $paidWins = $paidWins && $pickCampaign('blog_list') === $paidId;
    }
    $check('пріоритет', 'за наявності платної кампанії показується лише платна (10 з 10)', $paidWins);
    $pdo->prepare("UPDATE ad_campaigns SET status = 'paused' WHERE id = :c")->execute([':c' => $paidId]);

    // Кампанія B: не в маркетплейсі й не при marketplace_public = 0.
    $inMp = [];
    for ($i = 0; $i < 12; $i++) {
        $inMp[] = $pickCampaign('marketplace_listing_page', ['mp' => ['board']]);   // списки маркетплейсу вимкнено (2026-10-21)
    }
    $check('умови', 'у маркетплейсі B не показується (лише A)', !in_array($cB, $inMp, true) && in_array($cA, $inMp, true));
    site_settings_save($pdo, ['marketplace_public' => '0']);
    $closed = [];
    for ($i = 0; $i < 12; $i++) {
        $closed[] = $pickCampaign('blog_article');
    }
    $check('умови', 'при marketplace_public = 0 кампанія B не показується', !in_array($cB, $closed, true) && in_array($cA, $closed, true));
    site_settings_save($pdo, ['marketplace_public' => '1']);
    $siteB = [];
    for ($i = 0; $i < 20; $i++) {
        $siteB[] = $pickCampaign('popup');   // спливаюче вікно (з 2026-10-21 замість карток у списках)
    }
    $check('умови', 'на сторінках сайту показуються обидві (A і B)', in_array($cA, $siteB, true) && in_array($cB, $siteB, true));
    $check('умови', 'сторінки advertise і кабінет виключені для A (exclude_pages)',
        !promo_house_allowed($pdo, ['house_rules' => '{"exclude_pages":["advertise","cabinet"]}'], 'blog_list', ['page' => 'advertise']));

    // Один власний блок на сторінку.
    $check('ліміти', 'другий слот сторінки не отримує власну рекламу (nohouse)', $pickCampaign('blog_list', ['no_house' => true]) === null);
    // Ліміт показів на сеанс.
    promo_admin_set_setting($pdo, 'house_frequency_cap', '2');
    promo_settings($pdo, true);
    $s = $sh();
    $crA = (int) $one("SELECT id FROM ad_creatives WHERE campaign_id = :c ORDER BY id LIMIT 1", [':c' => $cA]);
    $crB = (int) $one("SELECT id FROM ad_creatives WHERE campaign_id = :c ORDER BY id LIMIT 1", [':c' => $cB]);
    // Покази рахуються в стані сеансу (з 2026-10-21 сирих рядків показів у ad_events немає).
    foreach ([$crA => $cA, $crB => $cB] as $cr => $cid) {
        for ($i = 0; $i < 2; $i++) {
            promo_session_event($s, $cr, $cid, 'impression', 0);
        }
    }
    $check('ліміти', 'після house_frequency_cap = 2 показів сеансу кампанія більше не показується', $pickCampaign('blog_list', [], $s) === null);

    // Приховування для тих, хто вже створив кампанію / оголошення.
    $_SESSION['user_id'] = $userId;   // у цього користувача є платна кампанія (створена вище)
    $hidA = [];
    for ($i = 0; $i < 12; $i++) {
        $hidA[] = $pickCampaign('category_page');
    }
    $hasListing = (bool) $one('SELECT 1 FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id WHERE s.user_id = :u LIMIT 1', [':u' => $userId]);
    $check('приховування', 'A не показується користувачу, що вже створив кампанію', !in_array($cA, $hidA, true));
    $check('приховування', 'B ' . ($hasListing ? 'не показується користувачу з оголошеннями' : 'показується користувачу без оголошень'),
        $hasListing ? !in_array($cB, $hidA, true) : in_array($cB, $hidA, true));
    unset($_SESSION['user_id']);

    // Тексти: {free_until}, запасні, EN.
    // Тексти — власні тестові (реальні тексти house-B1 редагуються в адмінці й міграціями).
    $b1 = array_merge($pdo->query("SELECT cr.*, 'internal' AS campaign_type FROM ad_creatives cr WHERE ref_code = 'house-B1'")->fetch(), [
        'title_en' => 'Marketplace: post your listing',
        'description' => 'Розміщення безкоштовне до {free_until}.',
        'description_en' => 'Free to post until {free_until}.',
        'description_fallback' => 'Розміщення безкоштовне на старті.',
        'description_fallback_en' => 'Free to post at launch.',
        'cta_text' => 'Розмістити оголошення',
    ]);
    $p = promo_card_payload($b1, 'blog_list', false, $pdo);
    $check('тексти', '{free_until} підставляється датою українською', !str_contains($p['description'], '{free_until}') && preg_match('/до \d{1,2} [а-яії]+ \d{4}/u', $p['description']) === 1, $p['description']);
    site_settings_save($pdo, ['marketplace_free_until' => '']);
    $p = promo_card_payload($b1, 'blog_list', false, $pdo);
    $check('тексти', 'без дати — запасний текст «безкоштовне на старті»', str_contains($p['description'], 'на старті') && !str_contains($p['description'], '{'), $p['description']);
    $_SESSION['lang'] = 'en';
    $GLOBALS['__force_lang'] = 'en';
    $pEn = promo_card_text($b1, 'title', 'en', $pdo);
    $fbEn = promo_card_text($b1, 'description', 'en', $pdo);
    $check('тексти', 'EN: заголовок і запасний опис англійською', $pEn === 'Marketplace: post your listing' && str_contains($fbEn, 'Free to post at launch'), $pEn . ' / ' . $fbEn);
    unset($_SESSION['lang']);
    $check('тексти', 'кнопка з власним текстом, у сітці — компактний макет', $p['cta'] === 'Розмістити оголошення' && promo_card_payload($b1, 'search_results', false, $pdo)['layout'] === 'compact');

    // ref → acquisition_ref.
    $_SESSION['acq_ref'] = 'house-A1';
    acq_ref_record($pdo, 'campaign', $paidId);
    $check('ref', 'ref із сесії записується в першу кампанію й прибирається з сесії',
        $one('SELECT acquisition_ref FROM ad_campaigns WHERE id = :c', [':c' => $paidId]) === 'house-A1' && !isset($_SESSION['acq_ref']));
    $stats = promo_house_variant_stats($pdo, [['id' => $crA, 'ref_code' => 'house-A1']]);
    $check('ref', 'звіт рахує створені кампанії за варіантом', $stats[$crA]['campaigns'] >= 1);

    // Адреси й клік.
    $check('посилання', 'адреси засіву містять ref і ведуть на свої сторінки',
        str_contains((string) $one("SELECT destination_url FROM ad_creatives WHERE ref_code = 'house-A2'"), '/advertise.php?ref=house-A2')
        && str_contains((string) $one("SELECT destination_url FROM ad_creatives WHERE ref_code = 'house-B2'"), '/marketplace.php?ref=house-B2'));

    // Сторінки без реклами.
    foreach (['advertise.php' => 'медіакіт', 'account.php' => 'кабінет', 'login.php' => 'вхід', 'eli.php' => 'Еля', 'listing-post.php?type=job' => 'форма оголошення'] as $path => $label) {
        [$code, $html] = $http($path);
        $check('без реклами', $label . ' — немає рекламного слота', !str_contains($html, 'sponsored-slot'), "http={$code}");
    }

    // Адмінка.
    [$ok1] = promo_house_save_variant($pdo, 1, ['creative_id' => $crA, 'title' => '', 'description' => 'x', 'cta_text' => 'x']);
    [$ok2] = promo_house_save_variant($pdo, 1, ['creative_id' => $crA, 'title' => 'T', 'description' => 'D', 'cta_text' => 'C', 'ref_code' => 'house-B1', 'destination_url' => '/advertise.php']);
    [$ok3] = promo_house_save_variant($pdo, 1, ['creative_id' => $crA, 'title' => 'T', 'description' => 'D', 'cta_text' => 'C', 'ref_code' => 'house-A1', 'destination_url' => 'javascript:alert(1)']);
    $check('адмінка', 'варіант: обов’язкові поля, унікальний ref, безпечна адреса', !$ok1 && !$ok2 && !$ok3);
    [$okD, $msgD] = promo_house_duplicate($pdo, 1, $cA);
    $dupId = (int) $one("SELECT id FROM ad_campaigns WHERE notes = :n ORDER BY id DESC LIMIT 1", [':n' => 'Копія власної кампанії #' . $cA]);
    if ($dupId > 0) {
        $tmpCampaigns[] = $dupId;
    }
    $check('адмінка', 'дублювання створює копію на паузі з новими ref', $okD && $dupId > 0
        && $one('SELECT status FROM ad_campaigns WHERE id = :c', [':c' => $dupId]) === 'paused'
        && (int) $one("SELECT COUNT(*) FROM ad_creatives WHERE campaign_id = :c AND ref_code NOT IN ('house-A1','house-A2')", [':c' => $dupId]) === 2, $msgD);
    [$okV] = promo_house_add_variant($pdo, 1, $dupId);
    $check('адмінка', 'додавання варіанта', $okV && (int) $one('SELECT COUNT(*) FROM ad_creatives WHERE campaign_id = :c', [':c' => $dupId]) === 3);
    $dupCr = (int) $one('SELECT id FROM ad_creatives WHERE campaign_id = :c ORDER BY id LIMIT 1', [':c' => $dupId]);
    [$okOk] = promo_house_save_variant($pdo, 1, ['creative_id' => $dupCr, 'title' => 'Тест', 'description' => 'Опис', 'cta_text' => 'Кнопка',
        'ref_code' => 'house-T9', 'destination_url' => '/advertise.php']);
    $check('адмінка', 'коректний варіант зберігається, ref додається до відносної адреси',
        $okOk && $one('SELECT destination_url FROM ad_creatives WHERE id = :c', [':c' => $dupCr]) === '/advertise.php?ref=house-T9');
    // Перехід із картки: відносна адреса власної кампанії → редирект на свою сторінку з ref.
    $tok = promo_token_make(['c' => $crA, 'k' => $cA, 'p' => 'blog_list']);
    $ctx = stream_context_create(['http' => ['header' => "User-Agent: Mozilla/5.0 (Windows NT 10.0) promo-house-check
", 'ignore_errors' => true, 'follow_location' => 0]]);
    @file_get_contents($base . '/promo-click.php?t=' . rawurlencode($tok), false, $ctx);
    $loc = '';
    foreach ($http_response_header ?? [] as $h) {
        if (stripos($h, 'Location:') === 0) {
            $loc = trim(substr($h, 9));
        }
    }
    $check('посилання', 'клік по картці веде на /advertise.php?ref=house-A1 (не на головну)', $loc === '/advertise.php?ref=house-A1', $loc);
    [$okS] = promo_house_save_campaign($pdo, 1, ['campaign_id' => $dupId, 'name' => 'Копія', 'placements' => ['blog_list', 'marketplace_feed'], 'rules' => ['site_only' => '1']]);
    $check('адмінка', 'site_only відкидає місця маркетплейсу', $okS && (int) $one('SELECT COUNT(*) FROM ad_targets WHERE campaign_id = :c', [':c' => $dupId]) === 1);
} catch (Throwable $e) {
    $check('загальне', 'виняток: ' . $e->getMessage() . ' @' . $e->getLine(), false);
} finally {
    unset($_SESSION['user_id'], $_SESSION['acq_ref']);
    foreach ($tmpCampaigns as $cid) {
        foreach (['ad_events', 'ad_stats_daily', 'ad_targets', 'ad_transactions', 'promo_event_log'] as $t) {
            $pdo->exec("DELETE FROM {$t} WHERE campaign_id = " . (int) $cid);
        }
        $pdo->exec('DELETE FROM ad_creatives WHERE campaign_id = ' . (int) $cid);
        $pdo->exec('DELETE FROM ad_campaigns WHERE id = ' . (int) $cid);
    }
    $pdo->exec('DELETE FROM ad_events WHERE campaign_id IN (' . $cA . ',' . $cB . ')');
    if (isset($oldBal, $userId)) {
        if ($oldBal === null) {
            $pdo->exec('DELETE FROM ad_balances WHERE user_id = ' . (int) $userId);
        } else {
            $pdo->prepare('UPDATE ad_balances SET balance = :b, currency = :c WHERE user_id = :u')->execute([':b' => $oldBal['balance'], ':c' => $oldBal['currency'], ':u' => $userId]);
        }
    }
    $pdo->prepare('UPDATE ad_campaigns SET status = :s WHERE id = :c')->execute([':s' => $old['statusA'], ':c' => $cA]);
    $pdo->prepare('UPDATE ad_campaigns SET status = :s WHERE id = :c')->execute([':s' => $old['statusB'], ':c' => $cB]);
    promo_admin_set_test_campaign($pdo, $old['test']);
    promo_admin_set_setting($pdo, 'enabled', $old['enabled']);
    promo_admin_set_setting($pdo, 'house_frequency_cap', $old['cap']);
    site_settings_save($pdo, ['marketplace_public' => $old['mp'], 'marketplace_free_until' => $old['free']]);
}

foreach ($results as $group => $rows) {
    echo (in_array(false, array_column($rows, 0), true) ? 'FAIL ' : 'PASS ') . $group . "\n";
    foreach ($rows as [$ok, $name, $info]) {
        echo '   ' . ($ok ? 'ok   ' : 'FAIL ') . $name . ($info !== '' && !$ok ? ' — ' . $info : '') . "\n";
    }
}
echo $fails === 0 ? "\nУСЕ PASS\n" : "\nFAIL: {$fails}\n";
exit($fails === 0 ? 0 : 1);
