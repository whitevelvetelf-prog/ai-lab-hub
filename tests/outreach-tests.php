<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести лідів (M2) і аутрічу (M3, tests/outreach-mail-tests.php) на збережених зразках, без живої мережі.
 *   php tests/outreach-tests.php
 * Лише CLI. Записи M2 — у транзакції з відкатом; M3 прибирає свої тестові дані сам (локальна БД не змінюється).
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/auth.php';   // сесія — до будь-якого виводу
require_once __DIR__ . '/../app/outreach.php';

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
$fx = static fn(string $f): string => (string) file_get_contents(__DIR__ . '/fixtures/' . $f);
$json = static fn(string $f): array => json_decode($fx($f), true);

echo "Розбір джерел\n";
$a = outreach_parse_arbeitnow($json('arbeitnow.json'));
check(count($a) === 2 && $a[0]['company_name'] === 'Acme Vision GmbH' && $a[0]['country'] === 'DE', 'Arbeitnow: 2 вакансії, компанія, країна DE');
$r = outreach_parse_remoteok($json('remoteok.json'));
check(count($r) === 2 && $r[0]['company_name'] === 'DataSpark', 'Remote OK: юридичну примітку пропущено, 2 вакансії');
$h = outreach_parse_himalayas($json('himalayas.json'));
check(count($h) === 2 && $h[0]['country'] === 'PL', 'Himalayas: 2 вакансії, країна з єдиного обмеження → PL');
$w = outreach_parse_wwr($fx('wwr.xml'));
check(count($w) === 2 && $w[0]['company_name'] === 'Promptly' && $w[0]['title'] === 'Prompt Engineer', 'WWR RSS: «Компанія: Посада», рядок без двокрапки пропущено');
check(outreach_hn_story_id($json('hn_search.json')) === 49900001, 'HN: id треду «Who is hiring»');
$hn = outreach_parse_hn_item($json('hn_item.json'));
check(count($hn) === 3 && $hn[0]['company_name'] === 'NeuralWorks' && $hn[0]['company_website'] === 'https://neuralworks.example', 'HN: компанія й сайт із першого рядка, коментар без «|» пропущено');
$hnDump = json_encode($hn, JSON_UNESCAPED_UNICODE);
check(!str_contains($hnDump, 'jane_doe') && !str_contains($hnDump, '"author"'), 'HN: ім\'я автора коментаря не потрапляє в лід');
check(outreach_parse_greenhouse(['jobs' => [['absolute_url' => 'https://boards.greenhouse.io/x/jobs/1', 'title' => 'ML Engineer', 'company_name' => 'X']]], 'x')[0]['title'] === 'ML Engineer', 'Greenhouse: розбір');
check(outreach_parse_lever([['hostedUrl' => 'https://jobs.lever.co/y/1', 'text' => 'AI Researcher']], 'y')[0]['company_name'] === 'Y', 'Lever: розбір');

echo "AI-релевантність\n";
check(outreach_ai_keyword_score('Machine Learning Engineer (LLM)') >= 70, 'назва з ML/LLM → висока оцінка');
check(outreach_ai_keyword_score('Buchhalter (m/w/d)', 'Lohnbuchhaltung') < OUTREACH_MIN_SCORE, 'нерелевантна вакансія → нижче порогу');
check(outreach_ai_keyword_score('Sales Manager', 'We sell an AI product. AI is great.') < 50, 'згадка AI лише в описі → не більше «сірої зони»');
check(outreach_ai_keyword_score('HTML Developer', 'Mail templates') === 0, '«HTML», «Mail» не дають хибного збігу');
check(outreach_ai_keyword_score('Інженер зі штучного інтелекту') >= 70, 'українська назва «штучний інтелект»');

echo "Ділові адреси й контакти\n";
check(outreach_is_business_email('info@acme.example') && outreach_is_business_email('Partners@acme.example'), 'info@, partners@ — ділові');
check(!outreach_is_business_email('john.smith@acme.example') && !outreach_is_business_email('j.smith@acme.example') && !outreach_is_business_email('jane@acme.example'), 'ім\'я.прізвище@, ім\'я@ — відкидаються');
$c = outreach_extract_contacts($fx('contact_page.html'), 'https://acme-ai.example/contact', 'acme-ai.example');
sort($c['emails']);
check($c['emails'] === ['info@acme-ai.example', 'partners@acme-ai.example'], 'зі сторінки — лише ділові адреси свого домену: ' . implode(', ', $c['emails']));
check(in_array('https://acme-ai.example/contact-form', $c['forms'], true) && !in_array('https://twitter.com/acme', $c['forms'], true), 'посилання на форму контактів свого домену');
$dis = outreach_robots_disallow($fx('robots.txt'));
check($dis === ['/about'], 'robots.txt: окрема група для нашого UA має пріоритет над «*»: ' . implode(',', $dis));
$star = outreach_robots_disallow("User-agent: *\nDisallow: /partners\n");
check(!outreach_robots_allows($star, '/partners') && outreach_robots_allows($star, '/contact'), 'robots.txt: заборона /partners, /contact дозволено');
check(!outreach_robots_allows(outreach_robots_disallow("User-agent: *\nDisallow: /\n"), '/contact'), 'robots.txt: Disallow: / забороняє все');

echo "SSRF (без зовнішньої мережі)\n";
foreach (['http://127.0.0.1/', 'http://localhost/', 'http://169.254.169.254/latest/meta-data/', 'http://10.0.0.5/', 'http://[::1]/', 'ftp://example.com/', 'http://user:pass@example.com/', 'http://example.com:8080/'] as $u) {
    $res = outreach_http_get($u);
    check($res['error'] !== null && $res['body'] === '', 'відхилено: ' . $u . ' (' . $res['error'] . ')');
}

echo "Нормалізація\n";
check(outreach_domain('https://www.Acme-AI.example/jobs?x=1') === 'acme-ai.example' && outreach_domain('acme.example') === 'acme.example', 'домен без www і схеми');
check(outreach_norm_company('Acme AI, Inc.') === outreach_norm_company('ACME AI'), 'назва компанії без юридичної форми');
[$lead, $err] = outreach_validate_manual(['company_name' => 'X', 'website' => 'x.example', 'lead_type' => 'course', 'country' => 'ua', 'language' => 'en']);
check($err === null && $lead['company_website'] === 'https://x.example' && $lead['country'] === 'UA', 'ручний лід: нормалізація сайту й країни');
[, $err] = outreach_validate_manual(['company_name' => 'X', 'website' => 'x.example', 'lead_type' => 'webinar']);
check($err !== null, 'ручний лід: невідомий lead_type відхиляється');

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$pdo->beginTransaction();
try {
    echo "Дедуплікація й виключення (БД, у транзакції)\n";
    $pdo->exec("INSERT INTO site_settings (setting_key, setting_value) VALUES ('outreach_excluded_domains', 'blocked.example'), ('outreach_excluded_countries', 'RU')
                ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)");
    site_settings($pdo, true);
    $leads = [
        ['company_name' => 'NeuralWorks', 'title' => 'ML Engineer', 'source_url' => 'https://a/1', 'company_website' => 'https://neuralworks-test.example', 'text' => '', 'tags' => []],
        ['company_name' => 'NeuralWorks GmbH', 'title' => 'AI Researcher', 'source_url' => 'https://a/2', 'company_website' => 'https://www.neuralworks-test.example/careers', 'text' => '', 'tags' => []],
        ['company_name' => 'Blocked AI', 'title' => 'AI Engineer', 'source_url' => 'https://a/3', 'company_website' => 'https://blocked.example', 'text' => '', 'tags' => []],
        ['company_name' => 'RuAI', 'title' => 'AI Engineer', 'source_url' => 'https://a/4', 'country' => 'RU', 'text' => '', 'tags' => []],
        ['company_name' => 'Bakery', 'title' => 'Baker', 'source_url' => 'https://a/5', 'text' => '', 'tags' => []],
        ['company_name' => 'HireBot', 'title' => 'AI Agent Developer', 'source_url' => 'https://a/6', 'company_website' => 'https://www.linkedin.com/company/hirebot', 'text' => '', 'tags' => []],
    ];
    $st = outreach_store_leads($pdo, 'test', 'Test', 'job', $leads);
    check($st['added'] === 2 && $st['dupes'] === 1 && $st['excluded'] === 2 && $st['irrelevant'] === 1, 'додано 2, дубль за доменом 1, виключено 2, не AI 1: ' . json_encode($st));
    $hb = $pdo->query("SELECT company_website, company_domain FROM outreach_leads WHERE company_name = 'HireBot'")->fetch(PDO::FETCH_ASSOC);
    check($hb !== false && $hb['company_website'] === null && $hb['company_domain'] === null, 'LinkedIn не зберігається як сайт компанії');
    $st2 = outreach_store_leads($pdo, 'test', 'Test', 'job', [['company_name' => 'HireBot Inc.', 'title' => 'ML Ops', 'source_url' => 'https://a/7', 'text' => '', 'tags' => []]]);
    check($st2['dupes'] === 1, 'дубль за нормалізованою назвою (без домену)');
    $csv = "company_name,website,lead_type,country,language,notes\nCourseLab,courselab-test.example,course,UA,uk,\nNeuralWorks,https://neuralworks-test.example,job,,,\nBad,,webinar,,,\n";
    $imp = outreach_import_csv($pdo, $csv);
    check($imp['added'] === 1 && $imp['duplicates'] === 1 && count($imp['errors']) === 1, 'CSV: 1 додано, 1 дубль, 1 помилка формату: ' . json_encode($imp, JSON_UNESCAPED_UNICODE));
    $cols = array_column($pdo->query('SHOW COLUMNS FROM outreach_leads')->fetchAll(PDO::FETCH_ASSOC), 'Field');
    check(array_intersect($cols, ['author', 'person_name', 'first_name', 'last_name', 'recruiter']) === [], 'у схемі лідів немає полів для імен людей');
    $personal = (int) $pdo->query("SELECT COUNT(*) FROM outreach_leads WHERE contact_email REGEXP '^[a-z]+\\\\.[a-z]+@'")->fetchColumn();
    check($personal === 0, 'у лідах немає адрес виду ім\'я.прізвище@');
} finally {
    $pdo->rollBack();
}

// Тести аутрічу (M3): власне прибирання замість транзакції (диспетчер сам відкриває транзакції).
require_once __DIR__ . '/outreach-mail-tests.php';
omail_tests($pdo);

echo "\nУсього: $total, збоїв: $fails\n";
exit($fails > 0 ? 1 : 0);
