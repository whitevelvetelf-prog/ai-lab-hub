<?php

declare(strict_types=1);

/**
 * AI LAB HUB — перевірка з'єднання Елі з AI-провайдером з сервера (кнопка в admin-stats.php,
 * обробник public/admin-eli-diag.php; лише admin, CSRF, не частіше разу на 30 с).
 *
 * Один мінімальний тестовий запит до основної моделі, потім до запасної; DNS і TCP 443 до хоста
 * API; параметри PHP/cURL; підсумок eli_api_log за 24 години; висновок словами.
 * Сам ключ, його довжина чи частина ніде не показуються; повідомлення провайдера очищуються
 * від усього схожого на ключ. Кожна спроба пишеться в eli_api_log з source = 'diag'
 * (у показники відповідей не входить).
 */

require_once __DIR__ . '/eli.php';
require_once __DIR__ . '/site-settings.php';

/** Мінімальна пауза між перевірками (секунд) — спільна для всіх адмінів. */
const ELI_DIAG_COOLDOWN = 30;

/** Хост API активного провайдера. */
function eli_diag_host(array $cfg): string
{
    return $cfg['provider'] === 'gemini' ? 'generativelanguage.googleapis.com' : 'api.anthropic.com';
}

/** Прибрати з тексту все, що схоже на ключ чи токен, і обрізати до 200 символів. */
function eli_diag_sanitize(string $text, string $apiKey = ''): string
{
    if ($apiKey !== '') {
        $text = str_replace($apiKey, '[ключ]', $text);
    }
    $text = (string) preg_replace([
        '~AIza[0-9A-Za-z_\-]{10,}~',
        '~sk-ant-[0-9A-Za-z_\-]{6,}~',
        '~(key|token|api[_-]?key|authorization|bearer)\s*[=:]\s*\S+~i',
        '~\b[0-9A-Za-z_\-]{32,}\b~',
    ], '[приховано]', $text);
    $text = trim((string) preg_replace('/\s+/u', ' ', $text));

    return mb_strlen($text) > 200 ? mb_substr($text, 0, 199) . '…' : $text;
}

/**
 * Скільки секунд лишилось до дозволеної наступної перевірки (0 — можна).
 * $claim = true — одразу зайняти слот (запис часу в site_settings).
 */
function eli_diag_cooldown_left(PDO $pdo, bool $claim = false): int
{
    $last = (int) site_setting($pdo, 'eli_diag_last', '0');
    $left = max(0, $last + ELI_DIAG_COOLDOWN - time());
    if ($left === 0 && $claim) {
        try {
            site_settings_save($pdo, ['eli_diag_last' => (string) time()]);
        } catch (Throwable $e) {
            error_log('[eli-diag] cooldown: ' . $e->getMessage());
        }
    }

    return $left;
}

/**
 * Виконати перевірку.
 *
 * @param callable|null $transport для тестів (форма eli_http_post)
 * @return array<string,mixed>
 */
function eli_diagnose(PDO $pdo, array $cfg, ?callable $transport = null, ?callable $netCheck = null): array
{
    $transport ??= 'eli_http_post';
    $host = eli_diag_host($cfg);
    $out = [
        'at' => gmdate('Y-m-d H:i:s'),
        'provider' => $cfg['provider'],
        'key_found' => $cfg['api_key'] !== '',
        'host' => $host,
        'dns' => null, 'dns_error' => '',
        'tcp' => null, 'tcp_error' => '', 'tcp_ms' => null,
        'models' => [],
        'env' => eli_diag_env(),
        'log24' => eli_diag_log_summary($pdo),
    ];

    if ($netCheck !== null) {
        [$out['dns'], $out['tcp'], $out['tcp_ms']] = $netCheck($host);
    } else {
        $ips = @gethostbynamel($host);
        $out['dns'] = is_array($ips) && $ips !== [];
        if (!$out['dns']) {
            $out['dns_error'] = 'не вдалося отримати IP-адресу';
        }
        $t = microtime(true);
        $errno = 0;
        $errstr = '';
        $fp = @fsockopen($host, 443, $errno, $errstr, 5);
        $out['tcp_ms'] = (int) round((microtime(true) - $t) * 1000);
        $out['tcp'] = $fp !== false;
        if ($fp !== false) {
            fclose($fp);
        } else {
            $out['tcp_error'] = eli_diag_sanitize($errno . ' ' . $errstr);
        }
    }

    $models = ['основна' => $cfg['model']];
    if ($cfg['fallback_model'] !== '') {
        $models['запасна'] = $cfg['fallback_model'];
    }
    foreach ($models as $role => $model) {
        $row = ['role' => $role, 'model' => $model, 'status' => null, 'error_type' => 'other', 'latency_ms' => 0, 'message' => ''];
        if (!$out['key_found']) {
            $row['error_type'] = 'no_key';
            $row['message'] = 'Ключ не налаштовано — запит не надсилався.';
        } else {
            $t = microtime(true);
            $r = eli_provider_call($cfg, $model, 'Reply with the JSON object {"ok": true} only.', 'ping', 15, $transport);
            $row['latency_ms'] = (int) round((microtime(true) - $t) * 1000);
            $row['status'] = $r['status'];
            $row['error_type'] = $r['ok'] ? 'none' : $r['error_type'];
            $row['message'] = $r['ok'] ? '' : eli_diag_sanitize($r['detail'], $cfg['api_key']);
            $row['retry_after'] = $r['retry_after'];
        }
        $out['models'][] = $row;
        eli_log($pdo, ['provider' => $cfg['provider'], 'model' => $model, 'http_status' => $row['status'], 'error_type' => $row['error_type'],
                       'source' => 'diag', 'latency_ms' => $row['latency_ms'], 'attempts' => $out['key_found'] ? 1 : 0,
                       'used_fallback_model' => $role !== 'основна', 'lang' => '', 'session_hash' => '']);
    }
    $out['verdict'] = eli_diag_verdict($out);

    return $out;
}

/** @return array<string,string> */
function eli_diag_env(): array
{
    $cv = function_exists('curl_version') ? curl_version() : null;
    $tls = '—';
    if (is_array($cv)) {
        $tls = (($cv['features'] & CURL_VERSION_SSL) ? 'так' : 'ні') . ' (' . ($cv['ssl_version'] ?? '?') . ')';
    }

    return [
        'PHP' => PHP_VERSION,
        'cURL' => is_array($cv) ? (string) $cv['version'] : 'немає розширення cURL',
        'TLS у cURL' => $tls,
        'max_execution_time' => (string) ini_get('max_execution_time') . ' с',
        'memory_limit' => (string) ini_get('memory_limit'),
        'allow_url_fopen' => ini_get('allow_url_fopen') ? 'так' : 'ні',
    ];
}

/** Підсумок eli_api_log за 24 години (без перевірок 'diag'). @return array<string,mixed> */
function eli_diag_log_summary(PDO $pdo): array
{
    $out = ['total' => 0, 'by_source' => [], 'by_error' => [], 'last_ai' => null, 'last_diag_ok' => null];
    try {
        foreach ($pdo->query("SELECT source, error_type, COUNT(*) AS n FROM eli_api_log
                               WHERE created_at >= NOW() - INTERVAL 1 DAY AND source <> 'diag' GROUP BY source, error_type")->fetchAll() as $r) {
            $n = (int) $r['n'];
            $out['total'] += $n;
            $out['by_source'][$r['source']] = ($out['by_source'][$r['source']] ?? 0) + $n;
            $out['by_error'][$r['error_type']] = ($out['by_error'][$r['error_type']] ?? 0) + $n;
        }
        arsort($out['by_error']);
        // created_at — у часовому поясі MySQL (на проді UTC+3), а показуємо UTC, як і «Перевірено».
        $out['last_ai'] = $pdo->query("SELECT MAX(created_at) - INTERVAL TIMESTAMPDIFF(SECOND, UTC_TIMESTAMP(), NOW()) SECOND
                                       FROM eli_api_log WHERE source = 'ai'")->fetchColumn() ?: null;
    } catch (Throwable $e) {
        $out['error'] = 'журнал недоступний (міграцію застосовано?)';
    }

    return $out;
}

/** Висновок словами: що найімовірніше не так і що зробити. @return list<string> */
function eli_diag_verdict(array $d): array
{
    if (!$d['key_found']) {
        return ['Ключ API відсутній у config/ai-assistant.php на сервері (або там шаблон YOUR_…). Додайте ключ активного провайдера («' . $d['provider'] . '»).'];
    }
    if ($d['dns'] === false) {
        return ['Сервер хостингу не може знайти адресу ' . $d['host'] . ' (DNS). Зверніться в підтримку хостингу.'];
    }
    if ($d['tcp'] === false) {
        return ['Немає з\'єднання з ' . $d['host'] . ':443. Імовірно, хостинг блокує вихідні з\'єднання — перевірте в adm.tools розділ «Вихідні з\'єднання» / Firewall.'];
    }
    $byType = [];
    foreach ($d['models'] as $m) {
        $byType[$m['model']] = $m['error_type'];
    }
    $ok = array_keys(array_filter($byType, static fn($t) => $t === 'none'));
    $lines = [];
    $advice = [
        'rate_limit' => 'перевищено ліміт запитів або квоту (429) — найімовірніше, ліміт безкоштовного рівня ключа. Зачекайте, увімкніть оплату в Google AI Studio / консолі провайдера або оберіть легшу модель з окремою квотою',
        'auth' => 'ключ недійсний, відкликаний або без доступу до цієї моделі (401/403) — перевірте ключ у консолі провайдера',
        'not_found' => 'модель не знайдено або вона вже недоступна (404) — змініть назву моделі в config/ai-assistant.php',
        'bad_request' => 'провайдер відхилив запит (400) — перевірте назву моделі й налаштування',
        'timeout' => 'тайм-аут — модель відповідає надто повільно; оберіть легшу модель (напр. gemini-3.5-flash-lite)',
        'server_error' => 'перевантаження або збій на боці провайдера (5xx) — зазвичай тимчасово; допомагає запасна модель',
        'network' => 'мережева помилка з\'єднання з API — перевірте вихідні з\'єднання хостингу',
        'invalid_json' => 'провайдер повернув не-JSON — можливо, проксі або сторінка помилки',
        'empty_response' => 'порожня відповідь моделі',
        'safety_block' => 'запит заблоковано фільтром безпеки (для тестового запиту це незвично)',
        'other' => 'невідома помилка — див. повідомлення провайдера в таблиці',
    ];
    foreach ($byType as $model => $type) {
        if ($type !== 'none') {
            $lines[] = 'Модель ' . $model . ': ' . ($advice[$type] ?? $type) . '.';
        }
    }
    if ($ok !== [] && count($ok) === count($byType)) {
        array_unshift($lines, 'З\'єднання з AI працює: усі моделі відповіли.');
        $log = $d['log24'];
        if (($log['by_source']['fallback'] ?? 0) > 0) {
            $lines[] = 'Проте за 24 години був запасний режим ' . $log['by_source']['fallback'] . ' раз(и) — збої епізодичні (ліміти чи перевантаження в пікові моменти). Див. типи помилок нижче.';
        }
    } elseif ($ok !== []) {
        array_unshift($lines, 'Працює лише ' . implode(', ', $ok) . ' — Еля відповідатиме через неї, але повільніше. Варто зробити її основною.');
    } else {
        array_unshift($lines, 'Жодна модель не відповіла — відвідувачі бачитимуть запасну добірку з бази.');
    }

    return $lines;
}

/** HTML: форма перевірки + результат (адмінка, українською). */
function eli_diag_html(PDO $pdo, ?array $result, string $csrf, ?string $flash): string
{
    $h = static fn($v): string => htmlspecialchars((string) $v, ENT_QUOTES);
    $yes = static fn(?bool $v): string => $v === null ? '—' : ($v ? 'так' : 'ні');
    $left = eli_diag_cooldown_left($pdo);
    $html = '<div class="eli-diag" id="eli-diag"><form method="post" action="admin-eli-diag.php" class="eli-diag__form">'
        . '<input type="hidden" name="csrf" value="' . $h($csrf) . '">'
        . '<button type="submit" class="eli-diag__btn"' . ($left > 0 ? ' title="Можна через ' . $left . ' с"' : '') . '>Перевірити з\'єднання з AI</button>'
        . '<span class="eli-stats__note">Один тестовий запит до основної й запасної моделі з сервера. Не частіше разу на ' . ELI_DIAG_COOLDOWN . ' с.</span></form>';
    if ($flash !== null) {
        $html .= '<p class="eli-stats__alarm">' . $h($flash) . '</p>';
    }
    if ($result === null) {
        return $html . '</div>';
    }
    $html .= '<div class="eli-diag__verdict">';
    foreach ($result['verdict'] as $i => $line) {
        $html .= $i === 0 ? '<p><strong>' . $h($line) . '</strong></p>' : '<p>' . $h($line) . '</p>';
    }
    $html .= '</div><div class="eli-stats__wrap"><table class="eli-stats__table"><tbody>'
        . '<tr><td data-label="Параметр">Перевірено</td><td data-label="Значення">' . $h($result['at']) . ' UTC</td></tr>'
        . '<tr><td data-label="Параметр">Провайдер</td><td data-label="Значення">' . $h($result['provider']) . '</td></tr>'
        . '<tr><td data-label="Параметр">Ключ знайдено в конфігу</td><td data-label="Значення">' . $yes($result['key_found']) . '</td></tr>'
        . '<tr><td data-label="Параметр">DNS ' . $h($result['host']) . '</td><td data-label="Значення">' . ($result['dns'] === null ? '—' : ($result['dns'] ? 'ок' : 'помилка: ' . $h($result['dns_error']))) . '</td></tr>'
        . '<tr><td data-label="Параметр">TCP 443</td><td data-label="Значення">' . ($result['tcp'] === null ? '—' : ($result['tcp'] ? 'ок (' . (int) $result['tcp_ms'] . ' мс)' : 'помилка: ' . $h($result['tcp_error']))) . '</td></tr>';
    foreach ($result['env'] as $k => $v) {
        $html .= '<tr><td data-label="Параметр">' . $h($k) . '</td><td data-label="Значення">' . $h($v) . '</td></tr>';
    }
    $html .= '</tbody></table></div>';

    $html .= '<div class="eli-stats__wrap"><table class="eli-stats__table"><thead><tr><th>Модель</th><th>HTTP</th><th>Тип помилки</th><th>Затримка, мс</th><th>Повідомлення провайдера</th></tr></thead><tbody>';
    foreach ($result['models'] as $m) {
        $html .= '<tr><td data-label="Модель">' . $h($m['model']) . ' <small>(' . $h($m['role']) . ')</small></td>'
            . '<td data-label="HTTP">' . ($m['status'] === null ? '—' : (int) $m['status']) . '</td>'
            . '<td data-label="Тип помилки">' . $h($m['error_type']) . (isset($m['retry_after']) && $m['retry_after'] !== null ? ' <small>(повтор через ' . (int) $m['retry_after'] . ' с)</small>' : '') . '</td>'
            . '<td data-label="Затримка">' . (int) $m['latency_ms'] . '</td>'
            . '<td data-label="Повідомлення">' . ($m['message'] !== '' ? $h($m['message']) : '—') . '</td></tr>';
    }
    $html .= '</tbody></table></div>';

    $log = $result['log24'];
    $parts = [];
    foreach ($log['by_error'] as $t => $n) {
        $parts[] = $t . ': ' . $n;
    }
    $src = [];
    foreach ($log['by_source'] as $t => $n) {
        $src[] = $t . ': ' . $n;
    }
    $html .= '<p class="eli-stats__note">Журнал за 24 години: ' . (int) $log['total'] . ' запитів'
        . ($src !== [] ? ' (' . $h(implode(', ', $src)) . ')' : '')
        . ($parts !== [] ? '; типи помилок — ' . $h(implode(', ', $parts)) : '')
        . '. Остання успішна відповідь AI: ' . ($log['last_ai'] ? $h($log['last_ai']) . ' UTC' : 'немає') . '.'
        . (isset($log['error']) ? ' ' . $h($log['error']) : '') . '</p>';

    return $html . '</div>';
}
