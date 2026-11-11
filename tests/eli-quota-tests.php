<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести добових лімітів Елі (app/eli.php: eli_quota_check, eli_answer з $quota), ЛОКАЛЬНА база.
 *
 *   php tests/eli-quota-tests.php [http://ai-lab-hub.test]
 *
 * Модель не викликається: у eli_answer() підставляється фейковий транспорт, що рахує звернення. Наскрізна перевірка
 * api-eli-chat.php через Apache — лише в сценаріях, де звернення до моделі НЕ буде (робот; вичерпаний ліміт IP).
 * Тестові лічильники mp_rate_limits мають власні ключі й видаляються за id; кеш відповідей і рядки журналів,
 * створені тестом, — теж. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
$apache = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
session_start();
require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/eli.php';
require_once __DIR__ . '/../app/marketplace-board.php';
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

$calls = 0;
$transport = static function (string $url, array $headers, string $payload, int $timeout) use (&$calls): array {
    $calls++;
    $text = json_encode(['reply_text' => 'ok', 'steps' => []], JSON_UNESCAPED_UNICODE);

    return ['status' => 200, 'errno' => 0, 'error' => '', 'retry_after' => null,
            'body' => json_encode(['candidates' => [['content' => ['parts' => [['text' => $text]]], 'finishReason' => 'STOP']]])];
};

$run = bin2hex(random_bytes(4));
$keys = ['ip' => hash('sha256', 'eli-test-ip:' . $run), 'global' => hash('sha256', 'eli-test-global:' . $run)];
$userId = 900000000 + random_int(1, 99999999);
$base = eli_settings(['provider' => 'gemini', 'gemini_api_key' => 'test-key-not-real']);
$messages = [];

/** Один запит до Елі з лімітами; повертає [mode, error_type, reply_text]. */
$ask = static function (array $cfg, array $who, ?string $msg = null) use ($pdo, $transport, $keys, $run, &$messages): array {
    $msg ??= 'zzquota ' . $run . ' ' . bin2hex(random_bytes(3)) . ' монтаж відео';
    $messages[] = $msg;
    $session = [];
    $who += ['bot' => false, 'staff' => false, 'user_id' => null, 'ip_key' => static fn(): string => $keys['ip'], 'global_key' => $keys['global']];
    $r = eli_answer($pdo, $msg, 'uk', $cfg, $session, 'test', $who['user_id'], $transport, static function (): void {},
        static fn(): ?string => eli_quota_check($pdo, $cfg, $who));

    return [$r['response']['mode'], $r['log']['error_type'], (string) $r['response']['reply_text']];
};
$hits = static function (string $key, string $action) use ($pdo): ?int {
    $st = $pdo->prepare('SELECT hits FROM mp_rate_limits WHERE key_hash = :k AND action = :a AND window_start = CURDATE()');
    $st->execute([':k' => $key, ':a' => $action]);
    $v = $st->fetchColumn();

    return $v === false ? null : (int) $v;
};

$maxLog = (int) $pdo->query('SELECT COALESCE(MAX(id), 0) FROM eli_api_log')->fetchColumn();
$maxQ = (int) $pdo->query('SELECT COALESCE(MAX(id), 0) FROM search_queries')->fetchColumn();
$restoreIp = null;

try {
    echo "== Налаштування за замовчуванням\n";
    ok($base['daily_limit_ip'] === 30 && $base['daily_limit_user'] === 100 && $base['daily_limit_global'] === 1500, 'без ключів у конфігу: IP 30, користувач 100, сайт 1500');

    echo "== Гість: ліміт з IP\n";
    $cfg = array_merge($base, ['daily_limit_ip' => 2, 'daily_limit_global' => 100]);
    $calls = 0;
    $r1 = $ask($cfg, []);
    $r2 = $ask($cfg, []);
    $r3 = $ask($cfg, []);
    ok($r1[0] === 'ai' && $r2[0] === 'ai', 'перші 2 запити — до моделі');
    ok($r3[0] === 'fallback' && $r3[1] === 'quota_ip', 'третій — запасний режим, у журналі quota_ip');
    ok($calls === 2, "звернень до моделі рівно 2 (є $calls)");
    ok($r3[2] === t('eli_daily_limit') || str_contains($r3[2], 'Не знайшлося'), 'текст про вичерпаний денний ліміт: «' . mb_substr($r3[2], 0, 50) . '…»');

    echo "== Кеш не рахується\n";
    $calls = 0;
    $before = $hits($keys['ip'], 'eli_ip');
    $cached = $messages[0];
    $rc = $ask($cfg, [], $cached);
    ok($rc[0] === 'ai' && $calls === 0 && $hits($keys['ip'], 'eli_ip') === $before, 'повтор запиту з кешу: відповідь є, звернень 0, лічильник IP не змінився');

    echo "== Залогінений користувач\n";
    $cfg = array_merge($base, ['daily_limit_ip' => 1, 'daily_limit_user' => 3, 'daily_limit_global' => 100]);
    $calls = 0;
    $modes = [];
    for ($i = 0; $i < 4; $i++) {
        $modes[] = $ask($cfg, ['user_id' => $userId]);
    }
    ok($modes[0][0] === 'ai' && $modes[2][0] === 'ai' && $calls === 3, 'користувач: 3 запити до моделі (ліміт IP=1 на нього не діє)');
    ok($modes[3][0] === 'fallback' && $modes[3][1] === 'quota_user', 'четвертий — quota_user');

    echo "== Співробітник\n";
    $calls = 0;
    $okStaff = true;
    for ($i = 0; $i < 4; $i++) {
        $okStaff = $okStaff && $ask($cfg, ['staff' => true, 'user_id' => $userId])[0] === 'ai';
    }
    ok($okStaff && $calls === 4, 'admin/employee: без особистого ліміту (4 запити понад ліміт користувача)');

    echo "== Загальний ліміт сайту\n";
    $g = $hits($keys['global'], 'eli_global');
    $cfg = array_merge($base, ['daily_limit_ip' => 0, 'daily_limit_user' => 0, 'daily_limit_global' => $g + 1]);
    $calls = 0;
    $a = $ask($cfg, ['staff' => true]);
    $b = $ask($cfg, ['user_id' => $userId]);
    ok($a[0] === 'ai' && $b[0] === 'fallback' && $b[1] === 'quota_global' && $calls === 1, "сайт: після {$cfg['daily_limit_global']} звернень — quota_global для всіх, зокрема staff");

    echo "== Ліміт 0 = без ліміту\n";
    $cfg = array_merge($base, ['daily_limit_ip' => 0, 'daily_limit_user' => 0, 'daily_limit_global' => 0]);
    $calls = 0;
    for ($i = 0; $i < 3; $i++) {
        $ask($cfg, []);
    }
    ok($calls === 3, 'усі ліміти 0 — три звернення без обмежень');

    echo "== Роботи\n";
    $cfg = array_merge($base, ['daily_limit_ip' => 5, 'daily_limit_global' => 100]);
    $calls = 0;
    $gBefore = $hits($keys['global'], 'eli_global');
    $ipBefore = $hits($keys['ip'], 'eli_ip');
    $rb = $ask($cfg, ['bot' => true]);
    ok($rb[0] === 'fallback' && $rb[1] === 'bot' && $calls === 0, 'робот: запасний режим без звернення до моделі');
    ok($hits($keys['global'], 'eli_global') === $gBefore && $hits($keys['ip'], 'eli_ip') === $ipBefore, 'робот не змінює лічильники');

    echo "== api-eli-chat.php (Apache, без звернень до моделі)\n";
    $post = static function (string $ua) use ($apache, $run): array {
        $ch = curl_init($apache . '/api-eli-chat.php');
        curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_POST => true, CURLOPT_TIMEOUT => 60, CURLOPT_USERAGENT => $ua,
            CURLOPT_POSTFIELDS => http_build_query(['message' => 'zzquota ' . $run . ' ' . bin2hex(random_bytes(3)) . ' монтаж відео'])]);
        $body = (string) curl_exec($ch);
        curl_close($ch);

        return json_decode($body, true) ?: [];
    };
    $lastLog = static fn(): array => $pdo->query('SELECT source, error_type FROM eli_api_log ORDER BY id DESC LIMIT 1')->fetch(PDO::FETCH_ASSOC) ?: [];
    $j = $post('curl/8.0');
    ok(($j['mode'] ?? '') === 'fallback' && ($lastLog()['error_type'] ?? '') === 'bot', 'робот (curl): fallback, журнал error_type=bot');

    // Вичерпаний ліміт IP для 127.0.0.1 / ::1 → гість-браузер отримує запасний режим, модель не викликається.
    $live = eli_settings((array) (require __DIR__ . '/../config/ai-assistant.php'));
    $restoreIp = [];
    foreach (['127.0.0.1', '::1'] as $ip) {
        $k = mpb_ip_key($ip);
        $restoreIp[$k] = $hits($k, 'eli_ip');
        $pdo->prepare('INSERT INTO mp_rate_limits (key_hash, action, window_start, hits) VALUES (:k, \'eli_ip\', CURDATE(), :h)
                       ON DUPLICATE KEY UPDATE hits = VALUES(hits)')->execute([':k' => $k, ':h' => $live['daily_limit_ip']]);
    }
    $j = $post('Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 Safari/604.1');
    $ll = $lastLog();
    ok(($j['mode'] ?? '') === 'fallback' && ($ll['error_type'] ?? '') === 'quota_ip', 'гість понад ліміт IP: fallback, журнал quota_ip (є ' . ($ll['error_type'] ?? '—') . ')');
    ok(in_array($j['reply_text'] ?? '', [t('eli_daily_limit')], true) || ($j['steps'] ?? []) === [], 'відповідь гостю — текст про денний ліміт');
} finally {
    echo "== Прибирання (лише свої записи)\n";
    $in = static fn(array $v): string => implode(',', array_map(static fn($x) => $pdo->quote((string) $x), $v));
    $pdo->exec('DELETE FROM mp_rate_limits WHERE key_hash IN (' . $in([$keys['ip'], $keys['global'], hash('sha256', 'eli-user:' . $userId)]) . ')');
    foreach ((array) $restoreIp as $k => $h) {
        if ($h === null) {
            $pdo->exec("DELETE FROM mp_rate_limits WHERE key_hash = " . $pdo->quote($k) . " AND action = 'eli_ip' AND window_start = CURDATE()");
        } else {
            $pdo->prepare("UPDATE mp_rate_limits SET hits = :h WHERE key_hash = :k AND action = 'eli_ip' AND window_start = CURDATE()")->execute([':h' => $h, ':k' => $k]);
        }
    }
    $cacheKeys = array_map(static fn(string $m): string => eli_cache_key($m, 'uk', $base), $messages);
    if ($cacheKeys !== []) {
        $pdo->exec('DELETE FROM eli_cache WHERE key_hash IN (' . $in($cacheKeys) . ')');
    }
    $pdo->exec("DELETE FROM eli_api_log WHERE id > $maxLog AND session_hash <> 'test' AND created_at >= NOW() - INTERVAL 10 MINUTE AND error_type IN ('bot', 'quota_ip')");
    $pdo->exec("DELETE FROM search_queries WHERE id > $maxQ AND query_text LIKE " . $pdo->quote('zzquota ' . $run . '%'));
    $left = (int) $pdo->query('SELECT COUNT(*) FROM mp_rate_limits WHERE key_hash IN (' . $in([$keys['ip'], $keys['global'], hash('sha256', 'eli-user:' . $userId)]) . ')')->fetchColumn()
          + (int) $pdo->query('SELECT COUNT(*) FROM search_queries WHERE query_text LIKE ' . $pdo->quote('zzquota ' . $run . '%'))->fetchColumn();
    ok($left === 0, 'тестових лічильників і запитів не лишилося');
}
echo "\nРазом: $T, помилок: $F\n";
exit($F > 0 ? 1 : 0);
