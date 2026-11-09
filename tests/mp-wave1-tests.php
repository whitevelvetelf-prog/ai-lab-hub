<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести Хвилі 1 Marketplace на ЛОКАЛЬНІЙ базі: фільтри вакансій/курсів/послуг, сортування, чипи,
 * популярні запити, збережені пошуки (ліміт, «Нових», відписка, листи), сторінка продавця, статистика переглядів,
 * сторінка «Як ми використовуємо АІ», noindex/canonical.
 *
 *   php tests/mp-wave1-tests.php [http://ai-lab-hub.test]
 *
 * Створює власні записи («MPW-TEST …»: користувачі, продавці, оголошення, тексти, позначки, пошуки, агрегати
 * запитів, перегляди, логотип) і наприкінці (finally) видаляє ЛИШЕ їх — за id. Тимчасово переписує
 * docs/ai_statement_uk.md (перевірка «без маркерів») і відновлює. Лог листів storage/marketplace-mail.log обрізається
 * до попереднього розміру. Потрібні міграції 2026-11-09 (№ 20, 21) і свіжий курс у fx_rates. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
$_SESSION = [];
$_SERVER['HTTP_USER_AGENT'] = 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) Safari/604.1';   // CLI без UA = бот
$_SERVER['REQUEST_METHOD'] = 'GET';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/mp-search.php';
require_once __DIR__ . '/../app/mp-popular.php';
require_once __DIR__ . '/../app/mp-saved.php';
require_once __DIR__ . '/../app/mp-stats.php';
require_once __DIR__ . '/../app/mp-seller.php';
require_once __DIR__ . '/../app/ai-statement.php';
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
function http(string $url, array $opts = []): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_HEADER => false, CURLOPT_FOLLOWLOCATION => false, CURLOPT_TIMEOUT => 30,
        CURLOPT_USERAGENT => $opts['ua'] ?? 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 Safari/604.1']
        + ($opts['head'] ?? false ? [CURLOPT_NOBODY => true] : [])
        + (isset($opts['cookie']) ? [CURLOPT_COOKIE => $opts['cookie']] : []));
    $body = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    return [$code, $body];
}

if (!mpj_ready($pdo) || !mpq_ready($pdo) || !mpss_ready($pdo) || !mpst_ready($pdo) || !mpsl_ready($pdo)) {
    fwrite(STDERR, "Міграцію 2026-11-09 не застосовано\n");
    exit(1);
}

$ids = ['users' => [], 'sellers' => [], 'listings' => [], 'saved' => [], 'qstats' => [], 'qover' => [], 'verif' => [], 'files' => []];
$mailLog = __DIR__ . '/../storage/marketplace-mail.log';
$mailLogSize = is_file($mailLog) ? filesize($mailLog) : 0;
$aiFile = AIS_FILE;
$aiOrig = (string) file_get_contents($aiFile);
$tree = mpt_tree($pdo, 'uk');
$jobBlock = mpt_block($tree, 'job');
$courseBlock = mpt_block($tree, 'course');
$serviceBlock = mpt_block($tree, 'service');

$mkUser = static function (string $tag, bool $verified) use ($pdo, &$ids): int {
    $email = 'mpw-test-' . $tag . '-' . bin2hex(random_bytes(3)) . '@example.invalid';
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role) VALUES (:n, :e, 'x', 'user')")->execute([':n' => 'MPW-TEST ' . $tag, ':e' => $email]);
    $uid = (int) $pdo->lastInsertId();
    $ids['users'][] = $uid;
    if ($verified) {
        $pdo->prepare("INSERT INTO mp_email_verifications (user_id, email, token_hash, expires_at, verified_at) VALUES (:u, :e, :h, NOW(), NOW() - INTERVAL 2 DAY)")
            ->execute([':u' => $uid, ':e' => $email, ':h' => hash('sha256', random_bytes(16))]);
        $ids['verif'][] = (int) $pdo->lastInsertId();
    }

    return $uid;
};
$mkSeller = static function (int $uid, string $name, int $public = 1, int $verified = 0) use ($pdo, &$ids): int {
    $pdo->prepare('INSERT INTO mp_sellers (user_id, display_name, slug, website_url, is_verified, page_public, bio, created_at) VALUES (:u, :n, :s, :w, :v, :p, :b, :c)')
        ->execute([':u' => $uid, ':n' => $name, ':s' => 'mpw-test-' . bin2hex(random_bytes(4)), ':w' => 'https://example.org', ':v' => $verified,
            ':p' => $public, ':b' => 'Тестовий опис MPW', ':c' => '2026-05-14 10:00:00']);
    $sid = (int) $pdo->lastInsertId();
    $ids['sellers'][] = $sid;

    return $sid;
};
/** Оголошення компанії (вакансія/курс/послуга): деталі JSON, тексти, категорія; публікація; mpj_after_save. */
$mkLst = static function (string $type, string $title, array $details, int $seller, string $wf = '', array $tags = [], string $country = 'UA', string $pubAgo = '1 HOUR') use ($pdo, &$ids, $tree): int {
    $pdo->prepare(
        "INSERT INTO mp_listings (section, post_form, seller_id, status, pricing_model, price_type, delivery_type, delivery_url, source_lang, is_remote,
                                  company_name, country, offer_lang, details, slug, published_at, expires_at, created_at, updated_at)
         VALUES (:t, '', :s, 'published', 'free', 'none', 'link', 'https://example.org/job', 'uk', :r, 'MPW Co', :c, 'uk', :d, 'mpw-test',
                 NOW() - INTERVAL $pubAgo, NOW() + INTERVAL 30 DAY, NOW(), NOW())"
    )->execute([':t' => $type, ':s' => $seller, ':r' => $wf === 'online' ? 1 : 0, ':c' => $country, ':d' => json_encode($details, JSON_UNESCAPED_UNICODE)]);
    $id = (int) $pdo->lastInsertId();
    $ids['listings'][] = $id;
    $pdo->prepare('INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, is_auto) VALUES (:id, :l, :t, :s, 0)')
        ->execute([':id' => $id, ':l' => 'uk', ':t' => $title, ':s' => 'MPW test listing']);
    $block = mpt_block($tree, $type);
    $cat = $block['children'][0]['id'] ?? $block['id'];
    $pdo->prepare('INSERT INTO mp_listing_categories (listing_id, category_id) VALUES (:l, :c)')->execute([':l' => $id, ':c' => $cat]);
    mpj_after_save($pdo, $id, $type, $details, $wf, $tags, $country);

    return $id;
};

try {
    // =====================================================================
    echo "== Підготовка\n";
    $uOwner = $mkUser('owner', true);
    $uSaver = $mkUser('saver', true);
    $uSaver2 = $mkUser('saver2', true);
    $uUnverified = $mkUser('unverified', false);
    $sCo = $mkSeller($uOwner, 'MPW-TEST Company', 1, 1);
    $sPriv = $mkSeller($uSaver2, 'MPW-TEST Private', 1, 0);

    $J1 = $mkLst('job', 'MPW-TEST J1 Аналітик', ['employment' => 'full_time', 'schedule' => 'full_day', 'level' => 'junior', 'salary_min' => 30000, 'salary_max' => 40000,
        'salary_currency' => 'UAH', 'salary_period' => 'MONTH', 'city' => 'Київ'], $sCo, 'offline', ['students', 'no_experience'], 'UA', '3 HOUR');
    $J2 = $mkLst('job', 'MPW-TEST J2 ML-інженер', ['employment' => 'part_time', 'schedule' => 'shift', 'level' => 'middle', 'salary_min' => 1500, 'salary_max' => 2000,
        'salary_currency' => 'USD', 'salary_period' => 'MONTH'], $sCo, 'online', [], 'UA', '2 HOUR');
    $J3 = $mkLst('job', 'MPW-TEST J3 Стажер', ['employment' => 'internship', 'schedule' => 'flexible', 'level' => 'no_experience'], $sCo, 'hybrid', ['career_switch'], 'UA', '4 HOUR');
    $J4 = $mkLst('job', 'MPW-TEST J4 Консультант', ['employment' => 'side_job', 'schedule' => 'part_day', 'level' => 'senior', 'salary_min' => 20,
        'salary_currency' => 'EUR', 'salary_period' => 'HOUR'], $sCo, 'online', [], 'PL', '5 HOUR');
    $J5 = $mkLst('job', 'MPW-TEST J5 Розмітка', ['employment' => 'temporary', 'schedule' => 'rotation', 'level' => 'junior', 'salary_min' => 500,
        'salary_currency' => 'USD', 'salary_period' => 'PROJECT', 'city' => 'Львів'], $sCo, 'offline', [], 'UA', '6 HOUR');
    $C1 = $mkLst('course', 'MPW-TEST C1 Безкоштовний курс', ['format' => 'online', 'is_free' => '1'], $sCo);
    $C2 = $mkLst('course', 'MPW-TEST C2 Платний курс', ['format' => 'offline', 'price' => 300, 'currency' => 'USD'], $sCo);
    $S1 = $mkLst('service', 'MPW-TEST S1 Консалтинг', ['service_type' => 'consulting', 'price_from' => 1000, 'currency' => 'USD'], $sCo);
    $S2 = $mkLst('service', 'MPW-TEST S2 Розробка', ['service_type' => 'development', 'price_from' => 5000, 'currency' => 'UAH'], $sCo);
    // Оголошення користувача з контактами (перевірка «без контактів» на сторінці продавця й у листі)
    $pdo->prepare("INSERT INTO mp_listings (section, post_form, seller_id, status, pricing_model, price_type, delivery_type, source_lang, is_remote,
                   contact_phone, contact_email, published_at, expires_at, created_at, updated_at)
                   VALUES ('other', 'ad', :s, 'published', 'free', 'none', 'contact', 'uk', 1, '+380501112233', 'mpw-contact@example.invalid',
                   NOW() - INTERVAL 1 HOUR, NOW() + INTERVAL 30 DAY, NOW(), NOW())")->execute([':s' => $sCo]);
    $A1 = (int) $pdo->lastInsertId();
    $ids['listings'][] = $A1;
    $pdo->prepare('INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, is_auto) VALUES (:id, \'uk\', :t, \'MPW test ad\', 0)')
        ->execute([':id' => $A1, ':t' => 'MPW-TEST A1 Оголошення']);
    mpt_cache_reset();
    ok(true, 'тестові оголошення створено: ' . implode(',', $ids['listings']));

    $J = static function (array $get) use ($pdo, $jobBlock): array {
        $bf = mpj_block_filters($pdo, $jobBlock, null, $get + ['q' => 'MPW-TEST']);

        return array_map(static fn($x) => (int) $x['id'], mpt_search($pdo, 'uk', $bf['f'], 1, 50)['rows']);
    };
    $set = static function (array $a): array {
        sort($a);

        return $a;
    };

    // =====================================================================
    echo "== Зарплата в USD при збереженні\n";
    $row = $pdo->query("SELECT salary_min_usd, salary_max_usd, primary_place_id, work_format FROM mp_listings WHERE id = $J1")->fetch(PDO::FETCH_ASSOC);
    ok($row['salary_min_usd'] !== null && (float) $row['salary_min_usd'] > 0 && (float) $row['salary_max_usd'] > (float) $row['salary_min_usd'], 'J1: salary_min_usd/max_usd обчислено (' . $row['salary_min_usd'] . '–' . $row['salary_max_usd'] . ')');
    ok($row['work_format'] === 'offline', 'J1: work_format = offline');
    ok($row['primary_place_id'] !== null, 'J1: місто «Київ» зв’язано з геодовідником');
    $row3 = $pdo->query("SELECT salary_min_usd, salary_max_usd FROM mp_listings WHERE id = $J3")->fetch(PDO::FETCH_ASSOC);
    ok($row3['salary_min_usd'] === null && $row3['salary_max_usd'] === null, 'J3 без зарплати: *_usd = NULL');

    // =====================================================================
    echo "== Фільтри вакансій\n";
    ok($set($J([])) === $set([$J1, $J2, $J3, $J4, $J5]), 'без фільтрів — усі 5 вакансій');
    ok($J(['emp' => 'full_time']) === [$J1], 'тип зайнятості: повна');
    ok($set($J(['emp' => 'full_time,part_time'])) === $set([$J1, $J2]), 'тип зайнятості: мультивибір (через кому)');
    ok($set($J(['emp' => ['full_time', 'part_time']])) === $set([$J1, $J2]), 'тип зайнятості: мультивибір (emp[])');
    ok($J(['emp' => 'side_job']) === [$J4], 'тип зайнятості: підробіток');
    ok($J(['emp' => 'temporary']) === [$J5], 'тип зайнятості: сезонна/тимчасова');
    ok($J(['sched' => 'shift']) === [$J2], 'графік: змінний');
    ok($set($J(['sched' => 'rotation,flexible'])) === $set([$J3, $J5]), 'графік: мультивибір');
    ok($J(['exp' => 'no_experience']) === [$J3], 'досвід: без досвіду');
    ok($set($J(['exp' => 'junior'])) === $set([$J1, $J5]), 'досвід: junior');
    ok($set($J(['wf' => 'online'])) === $set([$J2, $J4]), 'формат: онлайн');
    ok($J(['wf' => 'hybrid']) === [$J3], 'формат: змішано');
    ok($set($J(['wf' => 'offline'])) === $set([$J1, $J5]), 'формат: офіс');
    ok($set($J(['sal' => '20000', 'scur' => 'UAH', 'sper' => 'MONTH'])) === $set([$J1, $J2]), 'зарплата від 20 000 грн/міс — J1 (грн) і J2 (USD), без J3 (без зарплати)');
    ok($J(['sal' => '1800', 'scur' => 'USD']) === [$J2], 'зарплата від 1800 USD/міс (період за замовчуванням — місяць)');
    ok($J(['sal' => '10', 'scur' => 'EUR', 'sper' => 'HOUR']) === [$J4], 'зарплата від 10 EUR/год — лише погодинні');
    ok($J(['sal' => '400', 'scur' => 'USD', 'sper' => 'PROJECT']) === [$J5], 'зарплата від 400 USD за проєкт — лише проєктні');
    ok($J(['sal' => '1', 'scur' => 'USD', 'sper' => 'HOUR']) === [$J4], 'періоди не змішуються: від 1 USD/год не включає місячні');
    ok($J(['emp' => 'part_time', 'wf' => 'online', 'sal' => '1000', 'scur' => 'USD']) === [$J2], 'комбінація: часткова + онлайн + від 1000 USD');
    ok($J(['emp' => 'full_time', 'wf' => 'online']) === [], 'комбінація без збігів → порожньо');
    ok($J(['fit' => 'students']) === [$J1], 'позначка «Підходить: студентам»');
    ok($J(['fit' => 'career_switch']) === [$J3], 'позначка «для зміни професії»');
    ok(count($J(['fit' => 'age_18_25'])) === 5, 'вікове значення у фільтрі ігнорується (білий список)');
    ok(count($J(['emp' => "full_time' OR 1=1 --"])) === 5, 'зловмисне значення ігнорується');
    $reg = (int) $pdo->query("SELECT p.parent_id FROM mp_listings l JOIN geo_places p ON p.id = l.primary_place_id WHERE l.id = $J1")->fetchColumn();
    ok($reg > 0 && in_array($J1, $J(['region' => (string) $reg]), true) && !in_array($J5, $J(['region' => (string) $reg]), true), 'область: Київ так, Львів ні');
    $regions = mpj_region_counts($pdo, 'job', 'uk');
    ok(array_filter($regions, static fn($r) => $r['id'] === $reg && $r['count'] >= 1) !== [], '«Вакансії за областями»: ненульова область з лічильником');

    echo "== Сортування\n";
    $d = $J(['sort' => 'salary_desc']);
    ok($d[0] === $J2 && $d[1] === $J1 && end($d) === $J3, 'зарплата ↓: J2 ($2000), J1 (≈$960) … J3 (без зарплати) в кінці');
    $a = $J(['sort' => 'salary_asc']);
    ok($a[0] === $J1 && $a[1] === $J2 && end($a) === $J3, 'зарплата ↑: J1, J2 … J3 в кінці');
    $h = $J(['sort' => 'salary_desc', 'sper' => 'HOUR']);
    ok($h[0] === $J4, 'зарплата ↓ з періодом «година»: погодинна J4 першою');
    $n = $J(['sort' => 'new']);
    ok($n[0] === $J2, 'найновіші: J2 (опубліковано 2 год тому) першою');

    echo "== Картка й факти\n";
    $rows = mpt_rows($pdo, 'uk', [$J1, $J3]);
    $line1 = mpj_card_line($rows[0]);
    $line3 = mpj_card_line($rows[1]);
    ok(str_contains($line1, '30') && str_contains($line1, 'Повна зайнятість') && str_contains($line1, 'Повний день') && str_contains($line1, 'Junior'), 'рядок картки J1: «зарплата · тип · графік · досвід»: ' . $line1);
    ok(str_starts_with($line3, 'за домовленістю'), 'рядок картки J3 без зарплати: «за домовленістю»');
    $facts = array_column(lst_facts($rows[0]), 1, 0);
    ok(($facts['Графік'] ?? '') === 'Повний день' && str_contains($facts['Підходить'] ?? '', 'студентам'), 'факти (і модерація): графік і «Підходить»');

    echo "== Позначки «Підходить»: лише білий список\n";
    mpj_save_tags($pdo, $J3, ['career_switch', 'age_18_25', 'older_45', '30plus', 'students']);
    $tg = mpj_tags($pdo, [$J3])[$J3] ?? [];
    sort($tg);
    ok($tg === ['career_switch', 'students'], 'збережено лише дозволені: ' . implode(',', $tg));
    mpj_save_tags($pdo, $J3, ['career_switch']);
    ok((mpj_tags($pdo, [$J3])[$J3] ?? []) === ['career_switch'], 'зняту позначку деактивовано (рядок не видалено)');
    ok(mpj_is_age_like('age_18_25') && mpj_is_age_like('older') && mpj_is_age_like('until_35') && !mpj_is_age_like('students') && !mpj_is_age_like('career_switch'), 'вікові значення розпізнаються й відхиляються');

    echo "== Курси й послуги\n";
    $C = static function (array $get) use ($pdo, $courseBlock): array {
        $bf = mpj_block_filters($pdo, $courseBlock, null, $get + ['q' => 'MPW-TEST']);

        return array_map(static fn($x) => (int) $x['id'], mpt_search($pdo, 'uk', $bf['f'], 1, 50)['rows']);
    };
    $S = static function (array $get) use ($pdo, $serviceBlock): array {
        $bf = mpj_block_filters($pdo, $serviceBlock, null, $get + ['q' => 'MPW-TEST']);

        return array_map(static fn($x) => (int) $x['id'], mpt_search($pdo, 'uk', $bf['f'], 1, 50)['rows']);
    };
    ok($C(['cf' => 'online']) === [$C1], 'курси: формат онлайн');
    ok($C(['ptype' => 'paid']) === [$C2], 'курси: платні');
    ok($C(['ptype' => 'free']) === [$C1], 'курси: безкоштовні');
    ok($C(['price_max' => '100']) === [$C1], 'курси: ціна до $100');
    ok($S(['stype' => 'consulting']) === [$S1], 'послуги: тип «консалтинг»');
    ok($S(['price_min' => '500']) === [$S1], 'послуги: ціна від $500 (5000 грн < $500)');

    echo "== Загальний пошук marketplace.php (той самий шар)\n";
    $G = static function (array $get) use ($pdo): array {
        $f = mpb_search_filters($pdo, $get + ['q' => 'MPW-TEST', 'country' => ''], 'uk', ['saved' => false, 'units' => 'km']);

        return array_map(static fn($x) => (int) $x['id'], mpb_search($pdo, 'uk', $f, 1)['rows']);
    };
    ok($set($G(['section' => 'job', 'emp' => 'full_time,part_time'])) === $set([$J1, $J2]), 'section=job&emp=… працює і в загальному пошуку');
    ok($G(['section' => 'job', 'sort' => 'salary_desc'])[0] === $J2, 'сортування за зарплатою в загальному пошуку');
    ok(count($G(['emp' => 'full_time'])) >= 10, 'без блока фільтри вакансій не застосовуються');

    echo "== Чипи\n";
    $jf = mpj_parse(['emp' => 'full_time,part_time', 'sal' => '20000', 'scur' => 'UAH', 'fit' => 'students'], 'job');
    $chips = mpj_chips($jf, mpj_url_params($jf));
    $labels = array_column($chips, 0);
    ok(in_array('Повна зайнятість', $labels, true) && in_array('Часткова зайнятість', $labels, true), 'чип на кожне значення мультивибору');
    $c0 = $chips[0][1];
    ok(($c0['emp'] ?? '') === 'part_time' && isset($c0['sal']), '✕ на чипі прибирає лише своє значення');
    ok(array_filter($labels, static fn($l) => str_contains($l, '20') && str_contains($l, 'грн')) !== [], 'чип зарплати з валютою');

    // =====================================================================
    echo "== HTTP: сторінка блока, noindex/canonical, шарінг, лічильник\n";
    $jobUrl = $base . '/marketplace-category.php?id=' . $jobBlock['id'];
    [$c, $b] = http($jobUrl);
    ok($c === 200 && !str_contains($b, 'noindex'), 'блок без фільтрів: 200, індексується');
    ok(str_contains($b, 'rel="canonical" href="http://ai-lab-hub.test/marketplace-category.php?id=' . $jobBlock['id'] . '"'), 'канонічна — сторінка блока');
    ok(str_contains($b, 'mpj-regions'), 'на сторінці блока є «Вакансії за областями»');
    [$c, $b] = http($jobUrl . '&q=MPW-TEST&emp=full_time,part_time&sal=20000&scur=UAH');
    ok($c === 200 && str_contains($b, '<meta name="robots" content="noindex, follow">'), 'з фільтрами: noindex,follow');
    ok(str_contains($b, 'rel="canonical" href="http://ai-lab-hub.test/marketplace-category.php?id=' . $jobBlock['id'] . '"'), 'з фільтрами: канонічна — без фільтрів');
    ok(substr_count($b, 'MPW-TEST J') === 2 && str_contains($b, 'J1 Аналітик') && str_contains($b, 'J2 ML-інженер'), 'шарінг посилання: той самий результат (J1, J2)');
    ok(str_contains($b, 'class="mpf-chip"') && str_contains($b, 'Скинути все'), 'чипи з ✕ і «Скинути все»');
    ok(str_contains($b, 'Показати результати: 2'), 'кнопка «Показати результати: 2»');
    ok(str_contains($b, 'mpss-save'), 'кнопка «Зберегти пошук» при фільтрах');
    [$c, $b] = http($jobUrl . '&sort=salary_desc');
    ok(str_contains($b, 'noindex, follow'), 'сортування (параметр) → noindex');
    [$c, $b] = http($jobUrl . '&page=2');
    ok(str_contains($b, 'noindex, follow'), 'сторінка пагінації 2 → noindex');
    [$c, $j] = http($base . '/mp-count.php?p=cat&id=' . $jobBlock['id'] . '&q=MPW-TEST&wf=online');
    ok($c === 200 && (json_decode($j, true)['total'] ?? -1) === 2, 'mp-count.php: онлайн-вакансій 2');
    [$c, $j] = http($base . '/mp-count.php?p=search&q=MPW-TEST&section=job&exp=no_experience&country=');
    ok($c === 200 && (json_decode($j, true)['total'] ?? -1) === 1, 'mp-count.php (загальний пошук): без досвіду — 1');
    [$c] = http($base . '/mp-count.php?p=evil');
    ok($c === 400, 'mp-count.php: невідомий p → 400');

    // =====================================================================
    echo "== Популярні запити\n";
    ok(mpq_normalize('  ChatGPT   Plus ') === 'chatgpt plus', 'нормалізація: регістр і пробіли');
    ok(mb_strlen(mpq_normalize(str_repeat('а', 80))) === 60, 'нормалізація: до 60 символів');
    ok(mpq_normalize('me@mail.com') === '' && mpq_normalize('067 123 45 67') === '' && mpq_normalize('0671234567') === '', 'не записуються: «@», 6+ цифр (і з пробілами)');
    ok(mpq_normalize('https://x.ua') === '' && mpq_normalize('www.site') === '' && mpq_normalize('mysite.com') === '', 'не записуються: посилання');
    ok(mpq_normalize('python 3') === 'python 3', 'звичайний запит з цифрою дозволено');
    $qA = 'mpw-test запит а ' . bin2hex(random_bytes(2));
    $qB = 'mpw-test запит б ' . bin2hex(random_bytes(2));
    $_SESSION = [];
    mpq_record($pdo, 'marketplace', $qA, 3);
    mpq_record($pdo, 'marketplace', mb_strtoupper($qA), 3);   // той самий запит у тій самій сесії
    mpq_record($pdo, 'marketplace', $qB, 0);                  // без результатів
    $hits = static fn(string $q): int => (int) $pdo->query("SELECT COALESCE(SUM(hits),0) FROM search_query_stats WHERE scope='marketplace' AND query_norm = " . $pdo->quote(mpq_normalize($q)))->fetchColumn();
    ok($hits($qA) === 1, 'один запис за сесію на запит на день');
    ok($hits($qB) === 0, 'запит без результатів не записується');
    $_SESSION = [];
    mpq_record($pdo, 'marketplace', $qA, 3);
    ok($hits($qA) === 2, 'нова сесія — +1');
    $ua = $_SERVER['HTTP_USER_AGENT'];
    $_SESSION = [];
    $_SERVER['HTTP_USER_AGENT'] = 'Googlebot/2.1';
    mpq_record($pdo, 'marketplace', $qA, 3);
    $_SERVER['HTTP_USER_AGENT'] = $ua;
    ok($hits($qA) === 2, 'бот не рахується');
    $cols = $pdo->query('SHOW COLUMNS FROM search_query_stats')->fetchAll(PDO::FETCH_COLUMN);
    ok(array_values($cols) === ['id', 'scope', 'query_norm', 'stat_date', 'hits'], 'у таблиці лише scope, запит, дата, лічильник (без IP і користувача)');
    $pdo->prepare('UPDATE search_query_stats SET hits = 12 WHERE scope = \'marketplace\' AND query_norm = :q')->execute([':q' => mpq_normalize($qA)]);
    foreach ($pdo->query("SELECT id FROM search_query_stats WHERE query_norm LIKE 'mpw-test%'")->fetchAll(PDO::FETCH_COLUMN) as $qid) {
        $ids['qstats'][] = (int) $qid;
    }
    $chipQ = static fn(array $chips): array => array_column($chips, 'query');
    ok(in_array(mpq_normalize($qA), $chipQ(mpq_chips($pdo, 'marketplace', 'uk', 10, 50)), true), 'поріг 10: запит з 12 пошуками є в чипах');
    ok(!in_array(mpq_normalize($qA), $chipQ(mpq_chips($pdo, 'marketplace', 'uk', 13, 50)), true), 'поріг 13: запиту немає');
    $pinQ = 'mpw-test закріплений ' . bin2hex(random_bytes(2));
    mpq_admin_save($pdo, 'marketplace', $pinQ, 'pin', -999, 'Закріплений UA', 'Pinned EN');
    $chipsUk = mpq_chips($pdo, 'marketplace', 'uk', 10, 50);
    ok(($chipsUk[0]['query'] ?? '') === mpq_normalize($pinQ) && $chipsUk[0]['label'] === 'Закріплений UA', 'закріплений — першим (порядок), мітка uk');
    ok((mpq_chips($pdo, 'marketplace', 'en', 10, 50)[0]['label'] ?? '') === 'Pinned EN', 'мітка en мовою інтерфейсу');
    ok(count(mpq_chips($pdo, 'marketplace', 'uk')) <= 8, 'не більше 8 чипів');
    mpq_admin_save($pdo, 'marketplace', $qA, 'hide', 0, '', '');
    ok(!in_array(mpq_normalize($qA), $chipQ(mpq_chips($pdo, 'marketplace', 'uk', 1, 50)), true), 'прихований не показується');
    mpq_admin_save($pdo, 'marketplace', $qA, '', 0, '', '');
    ok(in_array(mpq_normalize($qA), $chipQ(mpq_chips($pdo, 'marketplace', 'uk', 10, 50)), true), '«зняти рішення» повертає запит');
    ok(mpq_admin_save($pdo, 'marketplace', 'me@x.com', 'pin', 0, '', '') === false, 'адмінка не приймає запит із персональними даними');
    foreach ($pdo->query("SELECT id FROM search_query_overrides WHERE query_norm LIKE 'mpw-test%'")->fetchAll(PDO::FETCH_COLUMN) as $oid) {
        $ids['qover'][] = (int) $oid;
    }
    $pdo->prepare("INSERT INTO search_query_stats (scope, query_norm, stat_date, hits) VALUES ('marketplace', :q, CURDATE() - INTERVAL 100 DAY, 5), ('marketplace', :q2, CURDATE() - INTERVAL 10 DAY, 5)")
        ->execute([':q' => 'mpw-test старий', ':q2' => 'mpw-test свіжий']);
    $deleted = mpq_cleanup($pdo);
    $left = $pdo->query("SELECT query_norm FROM search_query_stats WHERE query_norm IN ('mpw-test старий', 'mpw-test свіжий')")->fetchAll(PDO::FETCH_COLUMN);
    ok($deleted >= 1 && $left === ['mpw-test свіжий'], 'очищення > 90 днів');
    foreach ($pdo->query("SELECT id FROM search_query_stats WHERE query_norm LIKE 'mpw-test%'")->fetchAll(PDO::FETCH_COLUMN) as $qid) {
        $ids['qstats'][] = (int) $qid;
    }
    [$c, $b] = http($base . '/marketplace.php');
    ok(str_contains($b, 'mpq-chips') && str_contains($b, 'Закріплений UA'), 'чипи під пошуком на marketplace.php');
    [$c, $b] = http($jobUrl);
    ok(str_contains($b, 'mpq-chips'), 'чипи під пошуком на сторінці блока');

    // =====================================================================
    echo "== Збережені пошуки\n";
    $catUrl = 'marketplace-category.php?id=' . $jobBlock['id'] . '&q=MPW-TEST&sal=30000&scur=UAH';
    $r = mpss_create($pdo, $uSaver, $catUrl, 'uk');
    ok($r['status'] === 'saved', 'створено');
    $ids['saved'][] = $r['id'];
    $sv = mpss_own($pdo, $uSaver, $r['id']);
    ok(str_contains((string) $sv['title'], 'Вакансії') && str_contains((string) $sv['title'], 'від 30') && str_contains((string) $sv['title'], 'грн'), 'автоназва: ' . $sv['title']);
    ok(mpss_create($pdo, $uSaver, 'marketplace-category.php?id=' . $jobBlock['id'] . '&sal=30000&q=MPW-TEST&scur=UAH&page=3', 'uk')['status'] === 'exists', 'той самий пошук (інший порядок, page) — «уже збережено»');
    ok(mpss_create($pdo, $uSaver, 'marketplace-category.php?id=' . $jobBlock['id'], 'uk')['status'] === 'invalid', 'без запиту/фільтрів — не зберігається');
    $evil = mpss_create($pdo, $uSaver, 'marketplace.php?q=MPW-TEST&evil=<script>&section=job', 'uk');
    $ids['saved'][] = $evil['id'];
    $ev = mpss_own($pdo, $uSaver, $evil['id']);
    ok($ev !== null && !str_contains((string) $ev['params'], 'evil') && !str_contains((string) $ev['params'], 'script'), 'параметри лише з білого списку');
    ok(mpss_create($pdo, $uUnverified, $catUrl, 'uk')['status'] === 'unverified', 'без підтвердженої пошти — не можна');
    for ($i = 0; $i < 12; $i++) {
        $x = mpss_create($pdo, $uSaver, 'marketplace.php?q=MPW-TEST-' . $i, 'uk');
        if ($x['id'] > 0) {
            $ids['saved'][] = $x['id'];
        }
    }
    ok(mpss_active_count($pdo, $uSaver) === 10, 'ліміт 10 активних');
    ok(mpss_create($pdo, $uSaver, 'marketplace.php?q=MPW-TEST-extra', 'uk')['status'] === 'limit', '11-й — «ліміт»');
    ok(mpss_remove($pdo, $uSaver, $evil['id']) && mpss_own($pdo, $uSaver, $evil['id']) === null, 'видалення (is_active = 0)');
    ok((int) $pdo->query('SELECT COUNT(*) FROM mp_saved_searches WHERE id = ' . (int) $evil['id'])->fetchColumn() === 1, 'рядок не видалено з бази');
    ok(mpss_active_count($pdo, $uSaver) === 9, 'після видалення — 9');
    ok(mpss_remove($pdo, $uSaver2, $r['id']) === false, 'чужий пошук видалити не можна');
    $pdo->prepare('UPDATE mp_saved_searches SET last_seen_at = NOW() - INTERVAL 1 DAY WHERE id = :id')->execute([':id' => $r['id']]);
    $sv = mpss_own($pdo, $uSaver, $r['id']);
    ok(mpss_new_count($pdo, $sv, 'uk') === 2, '«Нових: 2» (J1, J2 з зарплатою від 30 000 грн, опубліковані після last_seen_at)');
    $openUrl = mpss_open($pdo, $uSaver, $r['id']);
    ok($openUrl !== null && str_contains($openUrl, 'sal=30000') && preg_match('~^[A-Za-z0-9_\-]+\.php(?:\?[A-Za-z0-9_=&%\-\.]*)?$~', $openUrl) === 1, 'відкрити: адреса пошуку (проходить mpb_redirect): ' . $openUrl);
    ok(mpss_new_count($pdo, mpss_own($pdo, $uSaver, $r['id']), 'uk') === 0, 'після відкриття «Нових: 0»');
    ok(mpss_rename($pdo, $uSaver, $r['id'], '  Моя <b>назва</b> ') && mpss_own($pdo, $uSaver, $r['id'])['title'] === 'Моя назва', 'перейменування (теги прибрано)');
    $tok = mpss_unsub_token($r['id'], $uSaver);
    mpss_set_notify($pdo, $uSaver, $r['id'], true);
    ok((int) mpss_own($pdo, $uSaver, $r['id'])['notify_email'] === 1, 'сповіщення ввімкнено (явна згода)');
    $bad = substr($tok, 0, -2) . (substr($tok, -2) === 'AA' ? 'BB' : 'AA');
    ok(mpss_unsubscribe($pdo, $bad) === false && (int) mpss_own($pdo, $uSaver, $r['id'])['notify_email'] === 1, 'підроблений токен відхилено');
    $forged = rtrim(strtr(base64_encode($r['id'] . '.' . $uSaver2 . '.' . str_repeat('a', 64)), '+/', '-_'), '=');
    ok(mpss_unsubscribe($pdo, $forged) === false, 'вигаданий підпис відхилено');
    [$c, $b] = http($base . '/mp-saved.php?unsub=' . rawurlencode($bad));
    ok($c === 400 && !str_contains($b, 'mpw-test-saver'), 'HTTP: підроблений токен → 400, без даних акаунта');
    [$c, $b] = http($base . '/mp-saved.php?unsub=' . rawurlencode($tok));
    ok($c === 200 && (int) mpss_own($pdo, $uSaver, $r['id'])['notify_email'] === 0 && !str_contains($b, 'mpw-test-saver'), 'HTTP: відписка без входу → 200, notify_email = 0');
    [$c] = http($base . '/mp-saved.php');
    ok($c === 401, 'сторінка збережених пошуків — лише для залогінених');

    echo "== Листи сповіщень\n";
    $off = mpss_notify_run($pdo, 10, 'uk');
    ok($off['disabled'] === true || !empty(mp_config()['saved_search_email_enabled']), 'saved_search_email_enabled=false → нічого не надсилається');
    $r2 = mpss_create($pdo, $uSaver2, 'marketplace.php?q=MPW-TEST', 'uk');
    $ids['saved'][] = $r2['id'];
    mpss_set_notify($pdo, $uSaver, $r['id'], true);
    mpss_set_notify($pdo, $uSaver2, $r2['id'], true);
    $pdo->exec('UPDATE mp_saved_searches SET last_notified_at = NOW() - INTERVAL 2 DAY WHERE id IN (' . (int) $r['id'] . ',' . (int) $r2['id'] . ')');
    $res = mpss_notify_run($pdo, 1, 'uk', true);
    ok($res['sent'] === 1, 'ліміт листів за запуск: 1 із 2');
    $res = mpss_notify_run($pdo, 10, 'uk', true);
    ok($res['sent'] === 1, 'наступний запуск — другий користувач');
    $res = mpss_notify_run($pdo, 10, 'uk', true);
    ok($res['sent'] === 0, 'не частіше 1 листа на добу на користувача');
    clearstatcache();
    $log = (string) file_get_contents($mailLog, false, null, $mailLogSize);
    ok(str_contains($log, 'MPW-TEST J1') && str_contains($log, 'Нових: '), 'лист: назви й лічильник');
    ok(str_contains($log, 'mp-saved.php?unsub=') && str_contains($log, 'marketplace'), 'лист: посилання на пошук і на відписку');
    ok(!str_contains($log, '+380501112233') && !str_contains($log, 'mpw-contact@example.invalid'), 'лист без контактів авторів');
    preg_match_all('~mp-saved\.php\?unsub=([A-Za-z0-9_-]+)~', $log, $mm);
    ok(($mm[1] ?? []) !== [] && mpss_unsub_verify($mm[1][0]) !== null, 'токен із листа — дійсний');

    // =====================================================================
    echo "== Сторінка продавця\n";
    [$c, $b] = http($base . '/mp-seller.php?id=' . $sCo);
    ok($c === 200 && str_contains($b, 'MPW-TEST Company') && str_contains($b, 'Перевірений продавець'), 'page_public=1: 200, назва, «перевірений»');
    ok(str_contains($b, 'на платформі з травня 2026'), '«на платформі з травня 2026»');
    ok(str_contains($b, 'MPW-TEST J1') && str_contains($b, 'MPW-TEST A1') && str_contains($b, 'MPW-TEST C1'), 'усі оголошення, згруповані за блоками');
    ok(!str_contains($b, '+380501112233') && !str_contains($b, 'mpw-contact@example.invalid') && !str_contains($b, 'mpw-test-owner'), 'жодних контактів');
    ok(str_contains($b, '<title>MPW-TEST Company — оголошення продавця') && str_contains($b, 'name="description" content="Тестовий опис MPW"'), 'унікальні title і description');
    ok(!preg_match('/рейтинг|оцінк|★/u', $b), 'без рейтингів і оцінок');
    [$c, $b] = http($base . '/marketplace-offer.php?id=' . $A1);
    ok(preg_match('~Усі оголошення продавця \((\d+)\)~u', $b, $m) === 1 && (int) $m[1] === mpsl_live_count($pdo, $sCo), 'у картці оголошення — «Усі оголошення продавця (N)»');
    [$c, $b] = http($base . '/' . lst_url(['id' => $J1, 'slug' => 'mpw-test', 'section' => 'job']));
    ok(str_contains($b, 'mp-seller.php?id=' . $sCo), 'і на сторінці вакансії');
    $pdo->exec('UPDATE mp_sellers SET page_public = 0 WHERE id = ' . $sCo);
    [$c] = http($base . '/mp-seller.php?id=' . $sCo);
    ok($c === 404, 'page_public=0: 404');
    [$c, $b] = http($base . '/marketplace-offer.php?id=' . $A1);
    ok($c === 200 && !str_contains($b, 'mp-seller.php?id='), 'page_public=0: посилання немає, оголошення відкривається');
    $pdo->exec('UPDATE mp_sellers SET page_public = 1 WHERE id = ' . $sCo);
    [$c, $b] = http($base . '/mp-seller.php?id=' . $sPriv);
    ok($c === 200 && !str_contains($b, 'example.org') && !str_contains($b, 'Перевірений продавець'), 'приватна особа: лише ім’я, без сайту');
    ok(mpsl_has_contacts('пишіть на me@x.com') && mpsl_has_contacts('+38 050 111 22 33') && mpsl_has_contacts('t.me/abc') && mpsl_has_contacts('see https://a.b')
        && !mpsl_has_contacts('Навчаємо АІ з 2019 року'), 'опис: контакти розпізнаються');
    $sv1 = mpsl_save($pdo, mpsl_get($pdo, $sPriv), ['bio' => 'Дзвоніть +380501112233', 'website_url' => '', 'page_public' => true], null);
    ok(in_array('mpsl_err_bio_contacts', $sv1, true), 'опис із телефоном відхилено');
    $tmp = tempnam(sys_get_temp_dir(), 'mpw');
    $im = imagecreatetruecolor(300, 200);
    imagefill($im, 0, 0, imagecolorallocate($im, 33, 22, 173));
    imagepng($im, $tmp);
    $p = mpb_process_photo($tmp, 'image/png');
    @unlink($tmp);
    mpb_delete_photo_files($p['file_name']);
    $ids['files'][] = $p['thumb_name'];
    $pdo->prepare('UPDATE mp_sellers SET logo = :l WHERE id = :id')->execute([':l' => $p['thumb_name'], ':id' => $sCo]);
    ok(mpb_photo_path($p['file_name']) === null && mpb_photo_path($p['thumb_name']) !== null, 'логотип: зберігається один файл');
    [$c] = http($base . '/mp-photo.php?f=' . $p['thumb_name']);
    ok($c === 200, 'логотип відкритої сторінки віддається');
    $pdo->exec('UPDATE mp_sellers SET page_public = 0 WHERE id = ' . $sCo);
    [$c] = http($base . '/mp-photo.php?f=' . $p['thumb_name']);
    ok($c === 404, 'логотип прихованої сторінки гостю — 404');
    $pdo->exec('UPDATE mp_sellers SET page_public = 1 WHERE id = ' . $sCo);

    // =====================================================================
    echo "== Статистика\n";
    $views = static fn(int $id): int => (int) $pdo->query("SELECT COALESCE(SUM(views),0) FROM mp_listing_views_daily WHERE listing_id = $id")->fetchColumn();
    $v0 = $views($A1);
    http($base . '/marketplace-offer.php?id=' . $A1);
    ok($views($A1) === $v0 + 1, 'гість (нова сесія без cookie): +1');
    http($base . '/marketplace-offer.php?id=' . $A1, ['ua' => 'Mozilla/5.0 (compatible; Googlebot/2.1)']);
    ok($views($A1) === $v0 + 1, 'бот за User-Agent не рахується');
    http($base . '/marketplace-offer.php?id=' . $A1, ['head' => true]);
    ok($views($A1) === $v0 + 1, 'HEAD не рахується');
    $_SESSION = ['user_id' => $uOwner];
    mpst_count_view($pdo, $A1, $uOwner);
    ok($views($A1) === $v0 + 1, 'перегляд власника не рахується');
    $_SESSION = ['user_id' => $uSaver];
    mpst_count_view($pdo, $A1, $uOwner);
    mpst_count_view($pdo, $A1, $uOwner);
    ok($views($A1) === $v0 + 2, 'інший користувач: +1 раз на сесію на день');
    $_SESSION = [];
    $pdo->prepare('INSERT INTO mp_favorites (user_id, listing_id, created_at) VALUES (:u, :l, NOW() - INTERVAL 10 DAY)')->execute([':u' => $uSaver, ':l' => $A1]);
    $pdo->prepare('INSERT INTO mp_contact_reveals (listing_id, user_id, created_at) VALUES (:l, :u, NOW() - INTERVAL 40 DAY)')->execute([':l' => $A1, ':u' => $uSaver]);
    $pdo->prepare('INSERT INTO mp_listing_views_daily (listing_id, stat_date, views) VALUES (:l, CURDATE() - INTERVAL 20 DAY, 7), (:l2, CURDATE() - INTERVAL 100 DAY, 9)')->execute([':l' => $A1, ':l2' => $A1]);
    $per = mpst_periods($pdo, $A1);
    ok($per[7]['favorites'] === 0 && $per[30]['favorites'] === 1 && $per[60]['favorites'] === 1, 'обране за датою: 7/30/60');
    ok($per[30]['reveals'] === 0 && $per[60]['reveals'] === 1, 'відкриття контакту: 30/60');
    ok($per[30]['views'] === $per[7]['views'] + 7 && $per[60]['views'] === $per[30]['views'], 'перегляди: 7/30/60');
    $svg = mpst_chart_svg(mpst_series($pdo, $A1), 'Перегляди');
    ok(str_contains($svg, '<svg viewBox="0 0 360 170"') && substr_count($svg, '<rect') >= 2, 'SVG-графік за 60 днів');
    $del = mpst_cleanup($pdo);
    ok($del >= 1 && (int) $pdo->query("SELECT COUNT(*) FROM mp_listing_views_daily WHERE listing_id = $A1 AND stat_date < CURDATE() - INTERVAL 90 DAY")->fetchColumn() === 0, 'очищення переглядів > 90 днів');
    [$c] = http($base . '/mp-stats.php?id=' . $A1);
    ok($c === 401, 'статистика гостю недоступна (вхід)');

    // =====================================================================
    echo "== «Як ми використовуємо АІ»\n";
    ok(ais_marker_count() > 0, 'у docs/ai_statement_uk.md є маркери [ПІДТВЕРДИТИ]');
    [$c] = http($base . '/ai-statement.php');
    ok($c === 404, 'з маркерами — 404 публічно');
    [$c, $b] = http($base . '/about.php');
    ok(!str_contains($b, 'ai-statement.php'), 'з маркерами — посилання в підвалі немає');
    [$c] = http($base . '/docs/ai_statement_uk.md');
    ok($c === 404 || $c === 403, 'docs/ напряму не віддається (' . $c . ')');
    file_put_contents($aiFile, (string) preg_replace('/\[ПІДТВЕРДИТИ[^\]]*\]/u', 'підтверджено', $aiOrig));
    [$c, $b] = http($base . '/ai-statement.php');
    ok($c === 200 && str_contains($b, 'Як ми використовуємо АІ'), 'без маркерів — 200');
    [$c, $b] = http($base . '/about.php');
    ok(str_contains($b, 'href="ai-statement.php"'), 'без маркерів — посилання в підвалі є');
    file_put_contents($aiFile, $aiOrig);
} catch (Throwable $e) {
    ok(false, 'виняток: ' . $e->getMessage() . ' @ ' . basename($e->getFile()) . ':' . $e->getLine());
} finally {
    echo "== Прибирання (лише свої записи, за id)\n";
    file_put_contents($aiFile, $aiOrig);
    $in = static fn(array $a): string => $a === [] ? '0' : implode(',', array_map('intval', array_unique($a)));
    $L = $in($ids['listings']);
    foreach ([
        "DELETE FROM mp_listing_tags WHERE listing_id IN ($L)",
        "DELETE FROM mp_listing_categories WHERE listing_id IN ($L)",
        "DELETE FROM mp_listing_translations WHERE listing_id IN ($L)",
        "DELETE FROM mp_listing_views_daily WHERE listing_id IN ($L)",
        "DELETE FROM mp_listing_stats_daily WHERE listing_id IN ($L)",
        "DELETE FROM mp_favorites WHERE listing_id IN ($L)",
        "DELETE FROM mp_contact_reveals WHERE listing_id IN ($L)",
        "DELETE FROM mp_moderation_log WHERE listing_id IN ($L)",
        "DELETE FROM page_views WHERE page_type = 'marketplace_listing' AND page_id IN ($L)",
        "DELETE FROM mp_listings WHERE id IN ($L)",
        'DELETE FROM mp_saved_searches WHERE user_id IN (' . $in($ids['users']) . ')',
        'DELETE FROM mp_email_verifications WHERE id IN (' . $in($ids['verif']) . ')',
        'DELETE FROM mp_sellers WHERE id IN (' . $in($ids['sellers']) . ')',
        'DELETE FROM users WHERE id IN (' . $in($ids['users']) . ')',
        'DELETE FROM search_query_stats WHERE id IN (' . $in($ids['qstats']) . ')',
        'DELETE FROM search_query_overrides WHERE id IN (' . $in($ids['qover']) . ')',
    ] as $sql) {
        try {
            $pdo->exec($sql);
        } catch (Throwable $e) {
            echo '  cleanup: ' . $e->getMessage() . "\n";
        }
    }
    foreach ($ids['files'] as $fn) {
        mpb_delete_photo_files($fn);
    }
    clearstatcache();
    if (is_file($mailLog) && filesize($mailLog) > $mailLogSize) {
        $h = fopen($mailLog, 'r+');
        ftruncate($h, $mailLogSize);
        fclose($h);
    }
    mpt_cache_reset();
    $left = (int) $pdo->query("SELECT COUNT(*) FROM mp_listing_translations WHERE title LIKE 'MPW-TEST%'")->fetchColumn()
        + (int) $pdo->query("SELECT COUNT(*) FROM users WHERE email LIKE 'mpw-test-%'")->fetchColumn();
    echo $left === 0 ? "  OK   тестових записів не лишилося\n" : "  FAIL лишилося тестових записів: $left\n";
}

echo "\nРезультат: " . ($T - $F) . " / $T" . ($F > 0 ? " — FAIL: $F" : ' — усе гаразд') . "\n";
exit($F > 0 ? 1 : 0);
