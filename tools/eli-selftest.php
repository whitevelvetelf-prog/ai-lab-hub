<?php

declare(strict_types=1);

/**
 * AI LAB HUB — самоперевірка Елі з імітацією відповідей провайдера (mock).
 * Лише CLI, локальна база:  php tools/eli-selftest.php
 *
 * Сценарії: успіх, 429, 500, тайм-аут, недійсний JSON, пуста відповідь,
 * блокування безпеки, помилка мережі, відсутність ключа, 401, кеш, ліміт.
 * У кожному відвідувач має отримати відповідь AI або запасну добірку, а не
 * технічну помилку; у eli_api_log і eli_cache не має бути тексту запиту.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/eli.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$marker = 'selftest' . bin2hex(random_bytes(4));
$fails = 0;
$check = static function (string $name, bool $ok, string $info = '') use (&$fails): void {
    echo ($ok ? '  OK   ' : '  FAIL ') . $name . ($info !== '' ? ' — ' . $info : '') . "\n";
    if (!$ok) {
        $fails++;
    }
};

$geminiOk = static function (array $ids): array {
    $answer = json_encode(['reply_text' => 'Ось добірка.', 'steps' => [['step_title' => 'Рекомендую', 'product_ids' => $ids]]]);

    return ['status' => 200, 'errno' => 0, 'error' => '', 'retry_after' => null,
            'body' => json_encode(['candidates' => [['finishReason' => 'STOP', 'content' => ['parts' => [['text' => $answer]]]]]])];
};
$http = static fn(int $status, string $body = '{}', ?int $retry = null): array => ['status' => $status, 'body' => $body, 'errno' => 0, 'error' => '', 'retry_after' => $retry];

/**
 * Транспорт-імітація: $script(int $callNo, string $model, string $payload) → відповідь.
 * Повертає [transport, &calls].
 */
$mock = static function (callable $script): array {
    $state = new ArrayObject(['calls' => [], 'prompt_chars' => 0]);
    $fn = static function (string $url, array $headers, string $payload, int $timeout) use ($script, $state): array {
        preg_match('~models/([^:]+):~', $url, $m);
        $model = $m[1] ?? 'claude';
        $calls = $state['calls'];
        $calls[] = $model . '/t' . $timeout;
        $state['calls'] = $calls;
        $state['prompt_chars'] = max($state['prompt_chars'], mb_strlen($payload));

        return $script(count($calls), $model, $payload);
    };

    return [$fn, $state];
};

$base = eli_settings(['provider' => 'gemini', 'gemini_api_key' => 'test-key', 'gemini_model' => 'gemini-3.5-flash-lite',
                      'fallback_model' => 'gemini-3.5-flash', 'cache_ttl_hours' => 24, 'rate_limit_per_minute' => 100]);
$noSleep = static function (float $s): void {};

$index = eli_index($pdo, true);
$someIds = array_slice(array_keys($index['products']), 0, 3);

$run = static function (string $title, array $cfg, callable $script, string $msg) use ($pdo, $mock, $noSleep, $marker): array {
    [$transport, $state] = $mock($script);
    $session = [];
    $t = microtime(true);
    $r = eli_answer($pdo, $msg . ' ' . $marker . bin2hex(random_bytes(2)), 'uk', $cfg, $session, hash('sha256', 'selftest'), null, $transport, $noSleep);
    eli_log($pdo, $r['log']);
    $r['calls'] = $state['calls'];
    $r['prompt_chars'] = $state['prompt_chars'];
    $r['ms'] = (int) round((microtime(true) - $t) * 1000);
    echo "\n[{$title}] mode={$r['response']['mode']} source={$r['log']['source']} err={$r['log']['error_type']} attempts={$r['log']['attempts']}"
        . " fallback_model=" . ($r['log']['used_fallback_model'] ? 1 : 0) . " cards=" . count($r['response']['products'])
        . " calls=" . implode(',', $r['calls']) . " {$r['ms']}ms\n";

    return $r;
};

$noTech = static fn(array $r): bool => $r['response']['ok'] === true && $r['response']['reply_text'] !== t('eli_tech_error');
$validIdsFromPayload = static function (string $payload): array {
    preg_match_all('/\[(\d+)\]/', $payload, $m);

    return array_map('intval', array_slice($m[1], 0, 3));
};

echo "Індекс: " . count($index['products']) . " продуктів, " . count($index['subcats']) . " підкатегорій\n";

// 1. Успіх
$lastPayload = '';
$r = $run('успіх', $base, static function (int $n, string $model, string $payload) use ($geminiOk, $validIdsFromPayload) {
    return $geminiOk($validIdsFromPayload($payload));
}, 'змонтувати відео для YouTube');
$check('успіх: відповідь AI з картками', $r['response']['mode'] === 'ai' && count($r['response']['products']) > 0);
$check('промпт компактний (< 30 000 символів)', $r['prompt_chars'] < 30000, $r['prompt_chars'] . ' символів');

// 2. 429 на всіх моделях → запасний режим
$r = $run('429', $base, static fn() => $http(429, '{"error":{"message":"quota"}}'), 'монтаж відео');
$check('429: запасна добірка, без тех. помилки', $noTech($r) && $r['response']['mode'] === 'fallback' && count($r['response']['products']) > 0);
$check('429: були повтори й запасна модель', $r['log']['attempts'] >= 3 && $r['log']['used_fallback_model']);

// 2b. 429 з довгим Retry-After → одразу запасна модель (успіх)
$r = $run('429 Retry-After 60 → fallback ok', $base, static function (int $n, string $model, string $payload) use ($http, $geminiOk, $validIdsFromPayload) {
    return $model === 'gemini-3.5-flash-lite' ? $http(429, '{}', 60) : $geminiOk($validIdsFromPayload($payload));
}, 'переклад тексту');
$check('Retry-After більший за ліміт часу → запасна модель відповіла', $r['response']['mode'] === 'ai' && $r['log']['used_fallback_model'] && $r['log']['attempts'] === 2);

// 3. 500, потім успіх (повтор)
$r = $run('500 → повтор ok', $base, static function (int $n, string $m, string $payload) use ($http, $geminiOk, $validIdsFromPayload) {
    return $n === 1 ? $http(500) : $geminiOk($validIdsFromPayload($payload));
}, 'написати резюме');
$check('500: повтор дав відповідь AI', $r['response']['mode'] === 'ai' && $r['log']['attempts'] === 2 && $r['log']['error_type'] === 'server_error');

// 4. Тайм-аут
$r = $run('тайм-аут', $base, static fn() => ['status' => 0, 'body' => '', 'errno' => 28, 'error' => 'Operation timed out', 'retry_after' => null], 'генерація музики');
$check('тайм-аут: запасна добірка', $noTech($r) && $r['response']['mode'] === 'fallback' && $r['log']['error_type'] === 'timeout');

// 5. Недійсний JSON → одна спроба з простішою інструкцією → запасний режим
$r = $run('недійсний JSON', $base, static fn() => ['status' => 200, 'errno' => 0, 'error' => '', 'retry_after' => null,
    'body' => json_encode(['candidates' => [['finishReason' => 'STOP', 'content' => ['parts' => [['text' => '{"reply_text": "обірва']]]]]])], 'дизайн логотипу');
$check('недійсний JSON: 2 спроби, далі запасна добірка', $noTech($r) && $r['response']['mode'] === 'fallback' && $r['log']['attempts'] === 2);

// 5b. Недійсний JSON, потім простіша інструкція спрацювала
$r = $run('недійсний JSON → проста інструкція ok', $base, static function (int $n, string $m, string $payload) use ($geminiOk, $validIdsFromPayload) {
    return $n === 1 ? ['status' => 200, 'errno' => 0, 'error' => '', 'retry_after' => null, 'body' => json_encode(['candidates' => [['content' => ['parts' => [['text' => 'просто текст']]]]]])]
        : $geminiOk($validIdsFromPayload($payload));
}, 'дизайн логотипу');
$check('проста інструкція дала відповідь AI', $r['response']['mode'] === 'ai');

// 6. Пуста відповідь
$r = $run('пуста відповідь', $base, static fn() => ['status' => 200, 'errno' => 0, 'error' => '', 'retry_after' => null, 'body' => '{"candidates":[{"content":{"parts":[]}}]}'], 'створення презентації');
$check('пуста відповідь: запасна добірка', $noTech($r) && $r['response']['mode'] === 'fallback' && $r['log']['error_type'] === 'empty_response');

// 7. Блокування безпеки
$r = $run('блокування безпеки', $base, static fn() => ['status' => 200, 'errno' => 0, 'error' => '', 'retry_after' => null, 'body' => '{"promptFeedback":{"blockReason":"SAFETY"}}'], 'чат-бот для сайту');
$check('блокування: запасна добірка', $noTech($r) && $r['response']['mode'] === 'fallback' && $r['log']['error_type'] === 'safety_block');

// 8. Мережа
$r = $run('мережа', $base, static fn() => ['status' => 0, 'body' => '', 'errno' => 6, 'error' => 'Could not resolve host', 'retry_after' => null], 'озвучка тексту');
$check('мережа: запасна добірка', $noTech($r) && $r['response']['mode'] === 'fallback' && $r['log']['error_type'] === 'network');

// 9. Немає ключа — провайдер не викликається
$cfgNoKey = $base;
$cfgNoKey['api_key'] = '';
$r = $run('немає ключа', $cfgNoKey, static fn() => $http(500), 'аналіз даних');
$check('немає ключа: запасна добірка, 0 викликів', $noTech($r) && $r['response']['mode'] === 'fallback' && $r['calls'] === []);

// 10. 401 — без повторів
$r = $run('401', $base, static fn() => $http(401), 'аналіз даних');
$check('401: одна спроба, запасна добірка', $noTech($r) && $r['log']['attempts'] === 1 && $r['response']['mode'] === 'fallback');

// 11. Немає збігів → посилання на підкатегорії
$r = $run('без збігів', $base, static fn() => $http(503), 'qqqzzzxxx wwwvvvyyy');
$check('без збігів: посилання на популярні підкатегорії', $noTech($r) && count($r['response']['links'] ?? []) > 0 && $r['response']['products'] === []);

// 12. Кеш: однаковий запит — другий раз без виклику API
$cachedMsg = 'кешований запит ' . $marker;
[$tr, $st] = $mock(static fn(int $n, string $m, string $payload) => $geminiOk($validIdsFromPayload($payload)));
$s = [];
$a1 = eli_answer($pdo, $cachedMsg, 'uk', $base, $s, 'x', null, $tr, $noSleep);
$a2 = eli_answer($pdo, '  Кешований   запит ' . $marker . '!', 'uk', $base, $s, 'x', null, $tr, $noSleep);
$check('кеш: другий запит із кешу, API викликано 1 раз', $a2['log']['source'] === 'cache' && count($st['calls']) === 1);
$a3 = eli_answer($pdo, 'мій email test@example.com ' . $marker, 'uk', $base, $s, 'x', null, $tr, $noSleep);
$a4 = eli_answer($pdo, 'мій email test@example.com ' . $marker, 'uk', $base, $s, 'x', null, $tr, $noSleep);
$check('особисті дані (e-mail) не кешуються', $a4['log']['source'] === 'ai');

// 13. Ліміт частоти
$lim = $base;
$lim['rate_limit_per_minute'] = 3;
$s = [];
$modes = [];
for ($i = 0; $i < 4; $i++) {
    $modes[] = eli_answer($pdo, 'ліміт ' . $i . $marker, 'uk', $lim, $s, 'x', null, $tr, $noSleep)['response']['mode'];
}
$check('ліміт: 4-й запит за хвилину → спокійна підказка', $modes[3] === 'limited' && !in_array('limited', array_slice($modes, 0, 3), true));

// 13a. Важка модель: thinkingLevel=minimal; якщо 400 — повтор без нього
$heavy = $base;
$heavy['model'] = 'gemini-3.6-flash';
$sentThinking = [];
$r = $run('thinking 400 → без thinking', $heavy, static function (int $n, string $model, string $payload) use ($http, $geminiOk, $validIdsFromPayload) {
    return str_contains($payload, 'thinkingConfig') ? $http(400, '{"error":{"message":"Request contains an invalid argument."}}') : $geminiOk($validIdsFromPayload($payload));
}, 'монтаж відео');
$check('важка модель: 400 на thinkingConfig → повтор без нього дав відповідь AI', $r['response']['mode'] === 'ai' && count($r['calls']) === 2);

// 13b. Журнал запасного режиму: used_fallback=1, причина в error_type, fallback_empty для порожньої добірки
$r = $run('журнал запасного режиму', $base, static fn() => $http(429), 'qqqzzzxxx wwwvvvyyy');
$check('запасний режим: used_fallback=1, error_type=rate_limit, fallback_empty=1',
    $r['log']['used_fallback'] && $r['log']['error_type'] === 'rate_limit' && $r['log']['fallback_empty']);

// 13c. Діагностика з'єднання: ключ і схожі на ключ рядки не потрапляють у результат
require_once __DIR__ . '/../app/eli-diagnostics.php';
$secret = 'AIzaSyTESTSECRET0123456789abcdefghijk';
$dcfg = $base;
$dcfg['api_key'] = $secret;
[$dtr] = $mock(static function (int $n, string $model) use ($http, $secret) {
    return $model === 'gemini-3.5-flash-lite'
        ? $http(429, json_encode(['error' => ['message' => 'Quota exceeded for key ' . $secret . ' token=abc123 on project 1234567890abcdefghijklmnopqrstuvwxyz']]), 40)
        : ['status' => 200, 'errno' => 0, 'error' => '', 'retry_after' => null, 'body' => '{"candidates":[{"content":{"parts":[{"text":"{\"ok\":true}"}]}}]}'];
});
$diag = eli_diagnose($pdo, $dcfg, $dtr, static fn(string $h) => [true, true, 12]);
$dump = json_encode($diag, JSON_UNESCAPED_UNICODE);
$check('діагностика: основна rate_limit, запасна none', $diag['models'][0]['error_type'] === 'rate_limit' && $diag['models'][1]['error_type'] === 'none');
$check('діагностика: ключ і довгі токени не потрапили в результат', !str_contains($dump, $secret) && !str_contains($dump, 'abc123') && !str_contains($dump, '1234567890abcdefghij'));
$check('діагностика: висновок про ліміт', str_contains(implode(' ', $diag['verdict']), 'ліміт'));
$noKey = $dcfg;
$noKey['api_key'] = '';
$diag2 = eli_diagnose($pdo, $noKey, $dtr, static fn(string $h) => [true, true, 12]);
$check('діагностика без ключа: висновок «ключ відсутній»', str_contains($diag2['verdict'][0], 'Ключ API відсутній'));
$diag3 = eli_diagnose($pdo, $dcfg, $dtr, static fn(string $h) => [true, false, 5000]);
$check('діагностика без TCP 443: висновок про вихідні з’єднання', str_contains($diag3['verdict'][0], '443'));
$pdo->exec("DELETE FROM eli_api_log WHERE source = 'diag' AND created_at >= NOW() - INTERVAL 10 MINUTE");

// 14. У журналі й кеші немає тексту запитів
$leakCache = (int) $pdo->query("SELECT COUNT(*) FROM eli_cache WHERE response_json LIKE '%{$marker}%' OR response_json LIKE '%кешований%' OR response_json LIKE '%example.com%'")->fetchColumn();
$cols = $pdo->query('SHOW COLUMNS FROM eli_api_log')->fetchAll(PDO::FETCH_COLUMN);
$leakLog = 0;
foreach ($cols as $c) {
    $leakLog += (int) $pdo->query("SELECT COUNT(*) FROM eli_api_log WHERE CAST(`{$c}` AS CHAR) LIKE '%{$marker}%'")->fetchColumn();
}
$check('eli_cache не містить тексту запитів', $leakCache === 0);
$check('eli_api_log не містить тексту запитів', $leakLog === 0, 'колонки: ' . implode(', ', $cols));

// Прибрати тестові рядки журналу (session_hash тестів) і кеш тестових запитів.
$pdo->exec("DELETE FROM eli_api_log WHERE session_hash IN ('x', '" . hash('sha256', 'selftest') . "')");
$pdo->exec('DELETE FROM eli_cache WHERE created_at >= NOW() - INTERVAL 10 MINUTE');

echo "\n" . ($fails === 0 ? 'УСІ ПЕРЕВІРКИ ПРОЙДЕНО' : "ПРОВАЛЕНО: {$fails}") . "\n";
exit($fails === 0 ? 0 : 1);
