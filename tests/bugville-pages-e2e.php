<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тест сторінок гри «Багвіль» (крок 3): bugville.php, bugville-mission.php, bugville-parents.php, register.php.
 *   php tests/bugville-pages-e2e.php [http://127.0.0.1:8097]
 * Потрібно локально: міграції № 33 і 34, сид tools/bugville-seed.php, 'bugville_public' => true у config/bugville.local.php.
 *
 * Перевіряє: коди сторінок (карта, демо-місія, місія «скоро», невідома — 404, «Для батьків» — 404 з маркером);
 * у HTML гри лише власні скрипт і стилі, без реклами, банера згоди, сторонніх доменів і зовнішніх посилань;
 * у HTML місії немає сцени й відповіді; слово «тестування» не видно, доки не пройдено Главу 1; видимість без
 * bugville_public — лише admin; гість грає й бачить зірки на карті; реєстрація з гри — чекбокс віку, повернення в
 * місію, bv_players і зарахування гостьових спроб; звичайна реєстрація — без чекбокса; світ — 15 місій, 15 слів;
 * Markdown «Для батьків» екранується. Тестові записи видаляються. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://127.0.0.1:8097', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-player.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-parents.php';
require_once __DIR__ . '/bugville-unlock-helper.php';
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

/** @return array{code:int, body:string, location:string} */
function http(string $jar, string $url, ?array $post = null, array $headers = []): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 30,
        CURLOPT_USERAGENT => 'Mozilla/5.0 bugville-pages-e2e', CURLOPT_HTTPHEADER => $headers, CURLOPT_HEADER => true]);
    if ($post !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
    }
    $raw = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    $hs = (int) curl_getinfo($ch, CURLINFO_HEADER_SIZE);
    unset($ch);   // PHP 8: кукі записуються лише при знищенні дескриптора
    $head = substr($raw, 0, $hs);

    return ['code' => $code, 'body' => substr($raw, $hs),
        'location' => preg_match('/^Location:\s*(\S+)/mi', $head, $m) === 1 ? $m[1] : ''];
}

$api = static function (string $jar, string $csrf, array $data) use ($base): array {
    $ch = curl_init($base . '/bv-api.php');
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($data), CURLOPT_HTTPHEADER => ['Content-Type: application/json', 'X-CSRF-Token: ' . $csrf,
            'Origin: ' . $base]]);
    $body = (string) curl_exec($ch);
    unset($ch);

    return (array) json_decode($body, true);
};
$csrfOf = static fn(string $html) => preg_match('/name="csrf-token" content="([a-f0-9]{64})"/', $html, $m) === 1 ? $m[1]
    : (preg_match('/name="csrf" value="([a-f0-9]{64})"/', $html, $m2) === 1 ? $m2[1] : '');

if (bv_mission(105) === null || bv_cfg('bugville_public') !== true) {
    fwrite(STDERR, "run php tools/bugville-seed.php and set 'bugville_public' => true in config/bugville.local.php\n");
    exit(2);
}

$jar = (string) tempnam(sys_get_temp_dir(), 'bvp');
$jar2 = (string) tempnam(sys_get_temp_dir(), 'bvp');
$tag = bin2hex(random_bytes(3));
$email = "bv-pages-$tag@example.test";
$userIds = [];

try {
    echo "Світ\n";
    $all = bv_world_missions();
    check(count($all) === 15 && count(array_unique(array_column($all, 'word'))) === 15, '15 місій Глави 1, 15 різних чарівних слів');
    check(array_diff(array_column($all, 'word'), array_keys(BV_WORDS)) === [], 'кожне слово має вимову й значення');
    check(count(array_filter(array_keys($all), static fn($id) => bv_world_playable($id))) === 15, 'після сиду грабельні всі 15 місій');
    check(bv_world_next_playable(101) === 102 && bv_world_next_playable(105) === 201 && bv_world_next_playable(305) === null,
        'наступна місія: 1.1 → 1.2, 1.5 → 2.1, після 3.5 — немає');
    $GLOBALS['bv_cfg_override'] = ['bugville_public' => false];
    check(!bv_pages_visible(null) && !bv_pages_visible(['role' => 'user']) && bv_pages_visible(['role' => 'admin']),
        'без bugville_public сторінки бачить лише admin');
    $GLOBALS['bv_cfg_override'] = [];
    $html = bv_parents_html("# Заголовок\n\n- <script>x</script>\n\nТекст **жирний**");
    check(str_contains($html, '&lt;script&gt;') && str_contains($html, '<strong>жирний</strong>') && str_contains($html, '<ul>'),
        'Markdown «Для батьків» екранується');
    $cyr = bv_parents_html("Хлопчик ходить пішки до школи");   // «х» = D1 85: без /u \R рвав би рядок
    check($cyr === '<p>Хлопчик ходить пішки до школи</p>', 'кириличний рядок із «х» не розривається');

    echo "Сторінки\n";
    $map = http($jar, $base . '/bugville.php');
    // Етап 0: місії відкриваються по черзі; новий гість бачить лише 1.1, назви ще не досягнутих — «???».
    check($map['code'] === 200 && str_contains($map['body'], 'Скільки монет?') && !str_contains($map['body'], 'Остання монета'),
        'карта 200: є 1.1, назва закритої 1.5 прихована');
    check(substr_count($map['body'], '>скоро<') === 6, '«скоро» — лише глави 2–7');
    preg_match_all('~href="bugville-mission\.php\?m=(\d+)"~', $map['body'], $mm);
    check(array_values(array_unique($mm[1])) === ['101'], 'новому гостю — посилання лише на 1.1');
    $ms = http($jar, $base . '/bugville-mission.php?m=105');
    check($ms['code'] === 200 && !str_contains($ms['body'], 'id="bv-game"') && str_contains($ms['body'], 'ще закрита'),
        'закрита 1.5 за прямим посиланням — без гри, «ще закрита»');
    $lockedApi = $api($jar, $csrfOf($ms['body']), ['action' => 'start', 'mission' => 105]);
    check(($lockedApi['error'] ?? '') === 'locked', 'API: start закритої 1.5 — locked');
    bvt_unlock($base, $jar, $pdo, 105);   // гість чесно проходить 1.1–1.4
    $ms = http($jar, $base . '/bugville-mission.php?m=105');
    check($ms['code'] === 200 && str_contains($ms['body'], 'data-mission="105"') && str_contains($ms['body'], 'data-next="bugville-mission.php?m=201"'),
        'після 1.1–1.4 місія 1.5 відкрита, оболонка гри, наступна — 2.1');
    $m101 = http($jar, $base . '/bugville-mission.php?m=101');
    check($m101['code'] === 200 && str_contains($m101['body'], 'id="bv-game"') && !str_contains($m101['body'], 'ще готується'), 'пройдена 1.1 грається повторно');
    check(http($jar, $base . '/bugville-mission.php?m=999')['code'] === 404, 'невідома місія — 404');
    check(http($jar, $base . '/bugville-mission.php?m=abc')['code'] === 404, 'місія не числом — 404');
    check(http($jar, $base . '/bugville-parents.php')['code'] === 404, '«Для батьків» — 404, поки є [ПІДТВЕРДИТИ]');

    echo "Чистота сторінок (без реклами, трекерів, сторонніх доменів)\n";
    $siteHost = (string) parse_url($base, PHP_URL_HOST);
    foreach (['карта' => $map['body'], 'місія' => $ms['body']] as $name => $body) {
        preg_match_all('/<script\b[^>]*\bsrc="([^"]+)"/i', $body, $sc);
        check($sc[1] !== [] && array_filter($sc[1], static fn($s) => !str_starts_with($s, '/assets/js/bugville.js')) === [],
            "$name: лише власний скрипт bugville.js");
        preg_match_all('/<link\b[^>]*\bhref="([^"]+)"/i', $body, $ln);
        check(array_filter($ln[1], static fn($s) => !str_starts_with($s, '/')) === [], "$name: стилі й іконка лише з власного сайту");
        preg_match_all('/<a\b[^>]*\bhref="([^"]+)"/i', $body, $an);
        check(array_filter($an[1], static fn($h) => preg_match('~^(https?:)?//~i', $h) === 1) === [], "$name: жодного зовнішнього посилання");
        check(!preg_match('/ad-popup|cookie-consent|cc-banner|alh_consent|googletagmanager|gtag\(|facebook\.com|t\.me\//i', $body),
            "$name: без реклами, банера згоди й соцмереж");
        preg_match_all('~https?://([a-z0-9.-]+)~i', $body, $hosts);
        $foreign = array_unique(array_filter($hosts[1], static fn($h) => $h !== $siteHost && !str_contains($h, 'ai-lab-hub')
            && !str_contains($h, 'ailabhub-directory.com') && $h !== 'www.w3.org'));
        check($foreign === [], "$name: немає сторонніх доменів" . ($foreign ? ' (' . implode(', ', $foreign) . ')' : ''));
        check(!str_contains(mb_strtolower($body), 'тестуванн'), "$name: слово «тестування» не видно до кінця Глави 1");
    }
    check(!preg_match('/answer|correct|"bug"\s*:/i', $ms['body']), 'HTML місії без відповіді й параметрів поломки');

    echo "Реєстрація\n";
    $plain = http($jar2, $base . '/register.php');
    check($plain['code'] === 200 && !str_contains($plain['body'], 'name="bv_age"'), 'звичайна реєстрація — без чекбокса віку');

    echo "Гість грає, потім реєструється з гри\n";
    $csrf = $csrfOf($ms['body']);
    $st = $api($jar, $csrf, ['action' => 'start', 'mission' => 105]);
    // 1.5 — інтерактивна сцена «Автомат» (bv-scenes.php): гість діє сам, знайдене рахує сервер.
    check(($st['ok'] ?? false) && ($st['scene']['type'] ?? '') === 'input_machine', 'гість: start дає сцену');
    foreach (['0', '-1', 'abc'] as $in) {
        $api($jar, $csrf, ['action' => 'scene_act', 'token' => $st['token'], 'op' => 'buy', 'input' => $in]);
    }
    $ck = $api($jar, $csrf, ['action' => 'scene_finish', 'token' => $st['token']]);
    check(($ck['correct'] ?? false) === true && ($ck['stars'] ?? 0) === 3 && ($ck['would_earn']['xp'] ?? 0) === 20, 'гість: правильно, 3 зірки, would_earn 20 XP');
    $map2 = http($jar, $base . '/bugville.php');
    $guestXp = preg_match('~<li><i>XP</i> (\d+)</li>~', $map2['body'], $gx) === 1 ? (int) $gx[1] : -1;
    check($guestXp >= 20 && str_contains($map2['body'], 'Зірок: 3 з 3') && str_contains($map2['body'], 'Зареєструйтесь, щоб зберегти'),
        'карта гостя: XP сеансу, 3 зірки в місії, «Зареєструйтесь, щоб зберегти»');

    $reg = http($jar, $base . '/register.php?next=' . rawurlencode('bugville-mission.php?m=105'));
    check($reg['code'] === 200 && str_contains($reg['body'], 'name="bv_age"') && str_contains($reg['body'], 'Мені виповнилося 16'),
        'реєстрація з гри — чекбокс «Мені виповнилося 16 років»');
    $pass = 'E2e-' . bin2hex(random_bytes(6));
    $done = http($jar, $base . '/register.php', ['csrf' => $csrfOf($reg['body']), 'name' => 'BV pages', 'email' => $email,
        'password' => $pass, 'password_confirm' => $pass, 'bv_age' => '1']);
    $uid = (int) $pdo->query('SELECT id FROM users WHERE email = ' . $pdo->quote($email))->fetchColumn();
    if ($uid > 0) {
        $userIds[] = $uid;
    }
    check($done['code'] === 302 && $done['location'] === 'bugville-mission.php?m=105', 'після реєстрації — назад у ту саму місію');
    check($uid > 0 && bv_age_confirmed($pdo, $uid), 'вік підтверджено при реєстрації (bv_players)');
    $map3 = http($jar, $base . '/bugville.php');
    check(bv_totals($pdo, $uid)['xp'] === $guestXp && str_contains($map3['body'], '<li><i>XP</i> ' . $guestXp . '</li>') && str_contains($map3['body'], 'Монети'),
        'гостьові спроби зараховано: XP сеансу на сторінці акаунта, є монети');
    check(str_contains($map3['body'], 'href="account.php"'), 'у шапці — «Кабінет» замість «Увійти»');
} finally {
    foreach ($userIds as $u) {
        bv_delete_player_data($pdo, $u);
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $u]);
    }
    bvt_cleanup($pdo);
    @unlink($jar);
    @unlink($jar2);
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
