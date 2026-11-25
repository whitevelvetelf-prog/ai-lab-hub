<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тест Майстерні «Багвіля» (app/bugville/bv-workshop.php, bugville-workshop.php, API ws_buy / ws_equip / ws_avatar).
 *   php -S 127.0.0.1:8097 -t public      (з робочої копії)
 *   php tests/bugville-workshop-tests.php [http://127.0.0.1:8097]
 * Потрібно локально: міграції № 33, 36, 39, сид, 'bugville_public' => true. Тестові дані видаляються.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://127.0.0.1:8097', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-workshop.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
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
        CURLOPT_USERAGENT => 'Mozilla/5.0 bugville-workshop-tests']);
    if ($post !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
    }
    $body = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    unset($ch);

    return ['code' => $code, 'body' => $body];
}

/** @return array{code:int, json:array} */
function api(string $base, string $jar, string $csrf, array $data): array
{
    $ch = curl_init($base . '/bv-api.php');
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($data), CURLOPT_HTTPHEADER => ['Content-Type: application/json', 'X-CSRF-Token: ' . $csrf, 'Origin: ' . $base]]);
    $raw = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    unset($ch);

    return ['code' => $code, 'json' => (array) json_decode($raw, true)];
}

function csrf_of(string $html): string
{
    return preg_match('/name="csrf-token" content="([a-f0-9]{64})"/', $html, $m) === 1 ? $m[1]
        : (preg_match('/name="csrf" value="([a-f0-9]{64})"/', $html, $m2) === 1 ? $m2[1] : '');
}

/** Нарахувати монети (як за місію) — запис у журнал нагород. */
function give_coins(PDO $pdo, int $uid, int $coins): void
{
    static $att = 910000000;
    $pdo->prepare("INSERT INTO bv_xp_log (user_id, attempt_id, mission_id, xp, stars, coins, source, created_at) VALUES (:u, :a, 101, 0, 0, :c, 'test', UTC_TIMESTAMP())")
        ->execute([':u' => $uid, ':a' => $att++ + random_int(0, 99999) * 100, ':c' => $coins]);
}

$users = [];
$jars = [];
$tag = bin2hex(random_bytes(3));
$pass = 'E2e-' . bin2hex(random_bytes(6));
$mk = static function (string $n, bool $age = true) use ($pdo, $tag, $pass, &$users): array {
    $email = "bv-ws-$n-$tag@example.test";
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role, created_at) VALUES (:n, :e, :h, 'user', NOW())")
        ->execute([':n' => "BV ws $n", ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT)]);
    $users[] = $id = (int) $pdo->lastInsertId();
    if ($age) {
        bv_confirm_age($pdo, $id);
    }

    return ['id' => $id, 'email' => $email];
};
$offItem = null;

try {
    echo "1. Каталог і малюнки\n";
    $content = bv_ws_items_content();
    $kinds = array_count_values(array_column($content, 'kind'));
    check(count($content) === 12 && $kinds === ['frame' => 4, 'sticker' => 4, 'background' => 4], '12 предметів: 4 рамки, 4 наклейки, 4 фони (MAIN_TASK §7)');
    $cat = bv_ws_catalog($pdo);
    $db = (int) $pdo->query("SELECT COUNT(*) FROM bv_workshop_items WHERE lang = 'uk' AND status = 'active'")->fetchColumn();
    check($db === 12 && count($cat) === 12, 'сид записав 12 предметів; каталог читає їх із БД, у кожного є малюнок');
    check(min(array_column($cat, 'price')) >= 20 && array_sum(array_column($cat, 'price')) > 240,
        'ціни від 20 монет; разом більше, ніж дає Глава 1 (~240) — доводиться обирати');
    $svgs = [];
    foreach (array_keys(BV_WS_AVATARS) as $a) {
        $svgs[] = bv_ws_look_svg(['avatar' => $a]);
    }
    foreach ($cat as $it) {
        $svgs[] = bv_ws_item_svg($it);
    }
    $clean = true;
    foreach ($svgs as $s) {
        $clean = $clean && !preg_match('~https?://|<script|\son\w+=|href=|<image|<foreignObject~i', $s) && str_starts_with($s, '<svg');
    }
    check($clean && count(array_unique(array_slice($svgs, 0, 6))) === 6, 'усі малюнки — власний SVG без посилань, скриптів і зображень; 6 різних аватарів');

    echo "2. Баланс і купівля\n";
    $u = $mk('a');
    $id = $u['id'];
    check(bv_ws_balance($pdo, $id)['coins'] === 0 && bv_ws_buy($pdo, $id, 'sticker_glass')['error'] === 'not_enough', 'без монет купити не можна');
    give_coins($pdo, $id, 50);
    $b1 = bv_ws_buy($pdo, $id, 'frame_gear');
    check($b1['ok'] && $b1['balance']['coins'] === 20 && $b1['balance']['spent'] === 30, 'рамка за 30 — лишилось 20 з 50');
    check(bv_ws_buy($pdo, $id, 'frame_gear')['error'] === 'owned', 'той самий предмет удруге — owned');
    $b2 = bv_ws_buy($pdo, $id, 'sticker_nut');
    check(!$b2['ok'] && $b2['error'] === 'not_enough' && bv_ws_balance($pdo, $id)['coins'] === 20, 'наклейка за 30 при 20 — not_enough, монети не списано');
    check(bv_ws_buy($pdo, $id, 'sticker_glass')['ok'] && bv_ws_balance($pdo, $id)['coins'] === 0, 'наклейка за 20 — баланс 0');
    check(bv_ws_buy($pdo, $id, 'gold_crown')['error'] === 'not_found', 'невідомий предмет — not_found');
    $noAge = $mk('noage', false);
    give_coins($pdo, $noAge['id'], 100);
    check(bv_ws_buy($pdo, $noAge['id'], 'sticker_star')['error'] === 'auth_required', 'акаунт без підтвердженого віку — auth_required');

    echo "3. Паралельні купівлі не витрачають ті самі монети\n";
    $v = $mk('lock');
    give_coins($pdo, $v['id'], 60);
    $pdoB = require __DIR__ . '/../config/database.php';
    $pdo->beginTransaction();
    $pdo->prepare('SELECT user_id FROM bv_players WHERE user_id = :u FOR UPDATE')->execute([':u' => $v['id']]);
    $waited = false;
    try {
        $pdoB->exec('SET SESSION innodb_lock_wait_timeout = 1');
        bv_ws_buy($pdoB, $v['id'], 'bg_city');
    } catch (PDOException $e) {
        $waited = str_contains($e->getMessage(), 'Lock wait timeout') || (string) $e->getCode() === 'HY000';
    }
    $pdo->rollBack();
    check($waited && bv_ws_owned($pdo, $v['id']) === [], 'друга купівля чекає на блокування рядка гравця (не читає старий баланс)');
    check(bv_ws_buy($pdo, $v['id'], 'bg_city')['ok'] && bv_ws_buy($pdo, $v['id'], 'bg_night')['error'] === 'not_enough', 'після звільнення: 60 за «Вогні» — і на «Зоряну ніч» уже не вистачає');

    echo "4. Вдягнути, зняти, аватар\n";
    check(bv_ws_equip($pdo, $id, 'frame', 'frame_neon')['error'] === 'not_owned', 'вдягнути некуплене — not_owned');
    check(bv_ws_equip($pdo, $id, 'sticker', 'frame_gear')['error'] === 'not_found', 'рамку як наклейку — відмова');
    check(bv_ws_equip($pdo, $id, 'hat', 'frame_gear')['error'] === 'bad_request', 'невідомий вид — bad_request');
    bv_ws_equip($pdo, $id, 'frame', 'frame_gear');
    bv_ws_equip($pdo, $id, 'sticker', 'sticker_glass');
    $look = bv_ws_look($pdo, $id);
    check($look['frame'] === 'frame_gear' && $look['sticker'] === 'sticker_glass' && $look['avatar'] === 'robot', 'вдягнуто рамку й наклейку, аватар — за замовчуванням');
    check(bv_ws_set_avatar($pdo, $id, 'owl')['ok'] && bv_ws_look($pdo, $id)['avatar'] === 'owl' && bv_ws_set_avatar($pdo, $id, 'photo')['error'] === 'not_found',
        'аватар лише з набору: сова — так, будь-що інше — ні');
    bv_ws_equip($pdo, $id, 'sticker', '');
    check(bv_ws_look($pdo, $id)['sticker'] === null && bv_ws_look($pdo, $id)['frame'] === 'frame_gear', 'наклейку знято, рамка лишилась');
    $pdo->exec("UPDATE bv_workshop_items SET status = 'off' WHERE item_key = 'frame_gear' AND lang = 'uk'");
    $offItem = 'frame_gear';
    check(bv_ws_look($pdo, $id)['frame'] === null && !isset(bv_ws_catalog($pdo)['frame_gear']), 'вимкнений у каталозі предмет не показується й не продається');
    $pdo->exec("UPDATE bv_workshop_items SET status = 'active' WHERE item_key = 'frame_gear' AND lang = 'uk'");
    $offItem = null;

    echo "5. HTTP: сторінка, API, карта\n";
    $g = $jars[] = (string) tempnam(sys_get_temp_dir(), 'bvs');
    $gp = page($g, $base . '/bugville-workshop.php');
    check($gp['code'] === 200 && str_contains($gp['body'], 'Майстерня — для акаунтів') && !str_contains($gp['body'], 'data-action="ws_buy"')
        && preg_match_all('/class="bvw-item(?: is-[a-z]+)*"/', $gp['body']) === 12, 'гість: каталог із 12 предметів без кнопок купівлі');
    preg_match_all('~(?:src|href)="(https?:)?//~i', $gp['body'], $ext);
    check($ext[0] === [] && !str_contains($gp['body'], '₴') && !preg_match('/грн|оплат/u', $gp['body']), 'без зовнішніх ресурсів і без реальних грошей на сторінці');
    $gb = api($base, $g, csrf_of($gp['body']), ['action' => 'ws_buy', 'item' => 'sticker_star']);
    check($gb['code'] === 403 && ($gb['json']['error'] ?? '') === 'auth_required', 'гість: ws_buy — 403');
    check(str_contains(page($g, $base . '/bugville.php')['body'], 'href="bugville-workshop.php"'), 'на карті є посилання на Майстерню');

    $h = $mk('http');
    give_coins($pdo, $h['id'], 45);
    $jar = $jars[] = (string) tempnam(sys_get_temp_dir(), 'bvs');
    $lp = page($jar, $base . '/login.php?next=bugville-workshop.php');
    page($jar, $base . '/login.php', ['csrf' => csrf_of($lp['body']), 'email' => $h['email'], 'password' => $pass, 'next' => 'bugville-workshop.php']);
    $ap = page($jar, $base . '/bugville-workshop.php');
    check(str_contains($ap['body'], 'Монети: <strong>45</strong>') && substr_count($ap['body'], 'data-action="ws_avatar"') === 6
        && str_contains($ap['body'], 'Потрібно 50 монет'), 'акаунт: 45 монет, 6 аватарів, дорожче за баланс — неактивна кнопка');
    $csrf = csrf_of($ap['body']);
    check(api($base, $jar, $csrf, ['action' => 'ws_buy', 'item' => '../x'])['code'] === 400, 'дивний ключ предмета — 400');
    $buy = api($base, $jar, $csrf, ['action' => 'ws_buy', 'item' => 'bg_sunset']);
    check($buy['code'] === 200 && ($buy['json']['balance']['coins'] ?? -1) === 5, 'купівля через API: 45 − 40 = 5');
    $over = api($base, $jar, $csrf, ['action' => 'ws_buy', 'item' => 'sticker_star']);
    check($over['code'] === 409 && ($over['json']['error'] ?? '') === 'not_enough', 'не вистачає — 409');
    $eq = api($base, $jar, $csrf, ['action' => 'ws_equip', 'kind' => 'background', 'item' => 'bg_sunset']);
    $av = api($base, $jar, $csrf, ['action' => 'ws_avatar', 'avatar' => 'fox']);
    check(($eq['json']['look']['background'] ?? '') === 'bg_sunset' && ($av['json']['look']['avatar'] ?? '') === 'fox', 'фон вдягнуто, аватар — лисичка');
    $map = page($jar, $base . '/bugville.php')['body'];
    check(str_contains($map, 'bvw-bg--bg_sunset') && str_contains($map, 'Монети: 5'), 'карта показує вигляд гравця й монети');
    check(str_contains(page($jar, $base . '/bugville-workshop.php')['body'], 'Вдягнуто'), 'на сторінці фон позначено «Вдягнуто»');

    echo "6. Видалення даних гравця\n";
    $dry = bv_delete_player_data($pdo, $id, true);
    check(($dry['bv_user_items'] ?? 0) === 2 && ($dry['bv_user_look'] ?? 0) === 1, 'видалення охоплює куплене (2) і вигляд (1)');
} finally {
    if ($offItem !== null) {
        $pdo->exec("UPDATE bv_workshop_items SET status = 'active' WHERE item_key = " . $pdo->quote($offItem) . " AND lang = 'uk'");
    }
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    foreach ($users as $uid) {
        bv_delete_player_data($pdo, $uid);
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $uid]);
    }
    foreach ($jars as $f) {
        @unlink($f);
    }
    $left = 0;
    foreach ($users as $uid) {
        foreach (['bv_user_items', 'bv_user_look', 'bv_xp_log', 'bv_players'] as $t) {
            $left += (int) $pdo->query("SELECT COUNT(*) FROM $t WHERE user_id = " . $uid)->fetchColumn();
        }
    }
    check($left === 0 && (int) $pdo->query("SELECT COUNT(*) FROM bv_workshop_items WHERE status = 'active'")->fetchColumn() === 12, 'тестові дані прибрано, каталог цілий');
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
