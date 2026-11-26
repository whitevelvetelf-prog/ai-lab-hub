<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тест першої сторінки гри (Етап 0): bugville.php за еталоном bugville_prototype_home.html і відкриття місій
 * по черзі. php tests/bugville-home-e2e.php [http://ai-lab-hub.test]
 * Потрібно локально: міграції гри (№ 33–41), сид tools/bugville-seed.php, 'bugville_public' => true.
 *
 * Перевіряє: гість — «Почати: Автомат» → 1.1, Пошта й Бібліотека закриті, 1.2–1.5 як «???», без вимоги віку, «Як грати»,
 * підвал без «Для батьків» (поки є [ПІДТВЕРДИТИ]), резерв під Поломку дня, без зовнішніх ресурсів; закриті місія,
 * будинок і іспит не відкриваються за прямим посиланням (сторінка й API); зареєстрований без прогресу — «Почати»;
 * з прогресом (1.1–1.5) — «Продовжити: 2.1 …», Пошта відкрита, Бібліотека закрита, звання з bv_ranks; псевдонім із
 * HTML екранується; назви місій беруться з bv_world_texts. Тестові записи видаляються. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-player.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-progress.php';
require_once __DIR__ . '/../app/bugville/bv-exam.php';
require_once __DIR__ . '/../app/bugville/bv-parents.php';
bv_load_missions($pdo);

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

/** @return array{code:int, body:string} */
function page(string $jar, string $url, ?array $post = null): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 30,
        CURLOPT_USERAGENT => 'Mozilla/5.0 bugville-home-e2e']);
    if ($post !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
    }
    $body = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    unset($ch);

    return ['code' => $code, 'body' => $body];
}

function api(string $base, string $jar, string $csrf, array $data): array
{
    $ch = curl_init($base . '/bv-api.php');
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($data + ['lang' => 'uk']), CURLOPT_HTTPHEADER => ['Content-Type: application/json', 'X-CSRF-Token: ' . $csrf,
            'Origin: ' . $base]]);
    $body = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    unset($ch);

    return ['code' => $code] + (array) json_decode($body, true);
}

function csrf_of(string $html): string
{
    return preg_match('/name="csrf-token" content="([a-f0-9]{64})"/', $html, $m) === 1 ? $m[1]
        : (preg_match('/name="csrf" value="([a-f0-9]{64})"/', $html, $m2) === 1 ? $m2[1] : '');
}

/** Текст головної кнопки й адреса. */
function go_of(string $html): array
{
    return preg_match('~<a class="bvh-go" href="([^"]+)">([^<]+)</a>~u', $html, $m) === 1 ? [$m[1], html_entity_decode($m[2])] : ['', ''];
}

/** Чи закритий будинок рівня $lv. */
function bld_locked(string $html, int $lv): bool
{
    return preg_match('~<button type="button" class="bvh-bld( is-locked)?" data-level="' . $lv . '"~', $html, $m) === 1 && ($m[1] ?? '') !== '';
}

if (bv_mission(101) === null || bv_cfg('bugville_public') !== true) {
    fwrite(STDERR, "run php tools/bugville-seed.php and set 'bugville_public' => true in config/bugville.local.php\n");
    exit(2);
}

$users = [];
$jars = [];
$pass = 'Home-' . bin2hex(random_bytes(6));
$xssName = '<script>alert(1)</script>"><img src=x onerror=alert(2)>';
$mk = static function (string $name) use ($pdo, $pass, &$users): array {
    $email = 'bv-home-' . bin2hex(random_bytes(4)) . '@example.test';
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role, created_at) VALUES (:n, :e, :h, 'user', NOW())")
        ->execute([':n' => $name, ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT)]);
    $users[] = $id = (int) $pdo->lastInsertId();
    bv_confirm_age($pdo, $id);

    return ['id' => $id, 'email' => $email];
};
$login = static function (array $u) use ($base, $pass, &$jars): string {
    $jar = $jars[] = (string) tempnam(sys_get_temp_dir(), 'bvh');
    $lp = page($jar, $base . '/login.php');
    page($jar, $base . '/login.php', ['csrf' => csrf_of($lp['body']), 'email' => $u['email'], 'password' => $pass]);

    return $jar;
};
$origTitle = null;

try {
    echo "Гість, новий\n";
    $g = $jars[] = (string) tempnam(sys_get_temp_dir(), 'bvh');
    $h = page($g, $base . '/bugville.php');
    [$href, $txt] = go_of($h['body']);
    check($h['code'] === 200 && $txt === 'Почати: Автомат' && $href === 'bugville-mission.php?m=101', 'гість: одна головна кнопка «Почати: Автомат» → 1.1');
    check(!bld_locked($h['body'], 1) && bld_locked($h['body'], 2) && bld_locked($h['body'], 3), 'Автомат відкритий, Пошта й Бібліотека — із замком');
    check(str_contains($h['body'], 'відкриється після: Автомат') && str_contains($h['body'], 'відкриється після: Пошта'), 'на закритих будинках — після чого відкриються');
    check(substr_count($h['body'], '<b>???</b>') === 4 && str_contains($h['body'], 'Відкриється пізніше') && str_contains($h['body'], 'bvh-step is-next'),
        'шлях Автомата: 1.1 підсвічена, 1.2–1.5 — «???», «Відкриється пізніше»');
    check(!str_contains($h['body'], 'Нуль</b>') && !str_contains($h['body'], 'Порожнє поле'), 'назви ще не досягнутих місій не видно');
    check(!preg_match('/підтвердьте вік|Підтвердьте вік|від 16 років/u', $h['body']), 'на першому екрані немає вимоги віку');
    check(str_contains($h['body'], 'Грати можна одразу, без реєстрації'), 'гостю: «Грати можна одразу, без реєстрації»');
    check(str_contains($h['body'], '<h3>Спробуй</h3>') && str_contains($h['body'], '<h3>Знайди поломку</h3>') && str_contains($h['body'], '<h3>Збери слово</h3>'),
        '«Як грати» — три кроки');
    check(str_contains($h['body'], 'Без реклами й без зовнішніх посилань'), 'підвал: «Без реклами й без зовнішніх посилань»');
    check(!str_contains($h['body'], 'bugville-parents.php') && bv_parents_text() === null, '«Для батьків» не показано, поки в PARENTS_uk.md є [ПІДТВЕРДИТИ]');
    check(str_contains($h['body'], 'id="bvh-daily"'), 'є місце над шляхом місій для «Поломки дня»');
    check(str_contains($h['body'], 'Ваше звання') && str_contains($h['body'], 'role="progressbar"') && !str_contains($h['body'], '<dd>'),
        'смужка звання й XP замість старих коробок «XP 0 / Зірки 0»');
    check(str_contains($h['body'], 'aria-live="polite"') && str_contains($h['body'], 'aria-pressed="true"'), 'aria-live у привітанні, будинок обраний через aria-pressed');
    preg_match_all('~(?:src|href)="((?:https?:)?//[^"]+)"~i', $h['body'], $ext);
    check($ext[1] === [] && !preg_match('~fonts\.googleapis|fonts\.gstatic|cdn\.|googletagmanager~i', $h['body']), 'жодних зовнішніх ресурсів і посилань');

    echo "Закриті місії й будинки — за прямим посиланням\n";
    foreach ([102 => '1.2 (наступна після 1.1)', 201 => '2.1 (Пошта)', 305 => '3.5 (Бібліотека)'] as $m => $label) {
        $mp = page($g, $base . '/bugville-mission.php?m=' . $m);
        check($mp['code'] === 200 && str_contains($mp['body'], 'ще закрита') && !str_contains($mp['body'], 'id="bv-game"'), "сторінка $label — закрита, без гри");
        $st = api($base, $g, csrf_of($mp['body']), ['action' => 'start', 'mission' => $m]);
        check($st['code'] === 403 && ($st['error'] ?? '') === 'locked' && !isset($st['token']), "API start $label — 403 locked, без токена");
    }
    $ex = page($g, $base . '/bugville-exam.php?e=2');
    check(str_contains($ex['body'], 'будинок ще закритий') && !str_contains($ex['body'], 'id="bv-exam"'), 'іспит закритої Пошти — закрито');
    $m101 = page($g, $base . '/bugville-mission.php?m=101');
    check(str_contains($m101['body'], 'id="bv-game"'), 'відкрита 1.1 грається');

    echo "Назви з бази (bv_world_texts)\n";
    $origTitle = $pdo->query("SELECT title FROM bv_world_texts WHERE text_kind = 'mission' AND ref_id = 101 AND lang = 'uk'")->fetchColumn();
    check($origTitle === 'Скільки монет?', 'у bv_world_texts є назва 1.1');
    $pdo->exec("UPDATE bv_world_texts SET title = 'Скільки монет? [з бази]' WHERE text_kind = 'mission' AND ref_id = 101 AND lang = 'uk'");
    check(str_contains(page($g, $base . '/bugville.php')['body'], 'Скільки монет? [з бази]'), 'змінена в базі назва місії — на сторінці');
    $pdo->prepare("UPDATE bv_world_texts SET title = :t WHERE text_kind = 'mission' AND ref_id = 101 AND lang = 'uk'")->execute([':t' => $origTitle]);
    $origTitle = null;

    echo "Зареєстрований без прогресу (псевдонім з HTML)\n";
    $u1 = $mk($xssName);
    $j1 = $login($u1);
    $h1 = page($j1, $base . '/bugville.php')['body'];
    [, $t1] = go_of($h1);
    check($t1 === 'Почати: Автомат' && str_contains($h1, 'href="account.php"'), 'акаунт без прогресу: «Почати: Автомат», у шапці «Кабінет»');
    check(!str_contains($h1, '<script>alert(1)') && !str_contains($h1, '<img src=x') && str_contains($h1, '&lt;script&gt;alert(1)&lt;/script&gt;'),
        'псевдонім із HTML у привітанні екранується (без XSS)');
    check(str_contains($h1, '<li><i aria-label="Монети">●</i> 0</li>'), 'акаунту показано монети');

    echo "Зареєстрований з прогресом (1.1–1.5 пройдено)\n";
    $u2 = $mk('Тест Прогрес');
    foreach ([101, 102, 103, 104, 105] as $i => $m) {
        $pdo->prepare("INSERT INTO bv_xp_log (user_id, attempt_id, mission_id, xp, stars, coins, source, created_at)
                       VALUES (:u, :a, :m, 20, :s, 10, 'test', UTC_TIMESTAMP())")
            ->execute([':u' => $u2['id'], ':a' => 900000000 + $u2['id'] * 10 + $i, ':m' => $m, ':s' => $i === 4 ? 2 : 3]);
    }
    $j2 = $login($u2);
    $h2 = page($j2, $base . '/bugville.php')['body'];
    [$href2, $t2] = go_of($h2);
    check($t2 === 'Продовжити: 2.1 Порожнє поле' && $href2 === 'bugville-mission.php?m=201', 'з прогресом: «Продовжити: 2.1 Порожнє поле» → 2.1');
    check(!bld_locked($h2, 1) && !bld_locked($h2, 2) && bld_locked($h2, 3), 'Автомат і Пошта відкриті, Бібліотека — із замком');
    check(preg_match('~data-level="2"\s+aria-controls="bvh-p2" aria-pressed="true"~', $h2) === 1, 'обрано будинок наступної місії (Пошта)');
    check(substr_count($h2, '<i class="on"></i>') === 5, 'на табличці Автомата 5 крапок прогресу');
    check(str_contains($h2, 'Остання монета') && str_contains($h2, 'Зірок: 2 з 3') && str_contains($h2, 'Ще раз'), 'пройдені місії — назви, зірки, «Ще раз»');
    $xp = bv_totals($pdo, $u2['id'])['xp'];
    $rk = bv_rank_for(bv_ranks($pdo), $xp);
    check(str_contains($h2, '<b>' . htmlspecialchars($rk['rank']['title']) . '</b>') && str_contains($h2, '<li><i>XP</i> ' . $xp . '</li>'),
        'звання з bv_ranks і XP акаунта (' . $xp . ' XP — «' . $rk['rank']['title'] . '»)');
    check(str_contains($h2, 'З поверненням, Тест Прогрес!'), 'привітання з поверненням на імʼя');
    check(str_contains(page($j2, $base . '/bugville-mission.php?m=201')['body'], 'id="bv-game"'), 'наступна 2.1 — грається');
    check(str_contains(page($j2, $base . '/bugville-mission.php?m=105')['body'], 'id="bv-game"'), 'пройдена 1.5 — можна повторити');
    $l301 = page($j2, $base . '/bugville-mission.php?m=301');
    check(str_contains($l301['body'], 'ще закрита'), '3.1 (Бібліотека) — ще закрита');
    $s301 = api($base, $j2, csrf_of($l301['body']), ['action' => 'start', 'mission' => 301]);
    check($s301['code'] === 403 && ($s301['error'] ?? '') === 'locked', 'API: start 3.1 для цього акаунта — locked');
    $e3 = api($base, $j2, csrf_of($l301['body']), ['action' => 'exam_start', 'exam' => bv_exam_id(3)]);
    check($e3['code'] === 403 && ($e3['error'] ?? '') === 'locked', 'API: exam_start Бібліотеки — locked');
    check(str_contains(page($j2, $base . '/bugville-exam.php?e=3')['body'], 'будинок ще закритий'), 'сторінка іспиту Бібліотеки — закрито');
} finally {
    if ($origTitle !== null && $origTitle !== false) {
        $pdo->prepare("UPDATE bv_world_texts SET title = :t WHERE text_kind = 'mission' AND ref_id = 101 AND lang = 'uk'")->execute([':t' => $origTitle]);
    }
    foreach ($users as $id) {
        bv_delete_player_data($pdo, $id);
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $id]);
    }
    foreach ($jars as $j) {
        @unlink($j);
    }
    $left = (int) $pdo->query("SELECT COUNT(*) FROM users WHERE email LIKE 'bv-home-%@example.test'")->fetchColumn();
    check($left === 0, 'тестових акаунтів не лишилось');
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
