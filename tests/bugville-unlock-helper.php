<?php

declare(strict_types=1);

/**
 * Тести Багвіля: місії Глави 1 відкриваються по черзі (Етап 0). Щоб тест міг грати, наприклад, 1.5 чи 3.1, гравець
 * (гість або акаунт — та сама кука $jar) чесно проходить усі попередні місії через bv-api.php, як у браузері:
 * start → scene_act (сирі дії) → scene_finish. Які дії знаходять поломку, помічник бере з правил варіанта
 * (bv_scene_rules за seed спроби з bv_attempts) — сервер нічого не знає про помічника, обходів у коді гри немає.
 *
 * bvt_unlock($base, $jar, $pdo, 105) — пройти 101…104 (усе, що в світі перед 105). Повертає кількість пройдених.
 */

require_once __DIR__ . '/../app/bugville/bv-world.php';
require_once __DIR__ . '/../app/bugville/bv-scene-form.php';

function bvt_http(string $jar, string $url, ?string $json = null, array $headers = []): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 30,
        CURLOPT_USERAGENT => 'Mozilla/5.0 bugville-unlock-helper']);
    if ($json !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $json);
    }
    if ($headers !== []) {
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    }
    $body = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);

    return ['code' => $code, 'body' => $body, 'json' => json_decode($body, true)];
}

function bvt_unlock(string $base, string $jar, PDO $pdo, int $target): int
{
    $page = bvt_http($jar, $base . '/bugville.php');
    $csrf = preg_match('/name="csrf-token" content="([a-f0-9]{64})"/', $page['body'], $m) === 1 ? $m[1] : '';
    $call = static fn(array $d) => bvt_http($jar, $base . '/bv-api.php', json_encode($d + ['lang' => 'uk'], JSON_UNESCAPED_UNICODE),
        ['Content-Type: application/json', 'X-CSRF-Token: ' . $csrf, 'Origin: ' . $base]);
    // Уже пройдені (кнопка «Ще раз» на сторінці міста) не переграємо — менше запитів, без упору в ліміт частоти.
    preg_match_all('~class="bvh-again" href="bugville-mission\.php\?m=(\d+)"~', $page['body'], $dm);
    $done = array_flip(array_map('intval', $dm[1]));
    $played = 0;
    foreach (bv_world_missions() as $id => $ms) {
        if ($id === $target) {
            break;
        }
        if ($ms['scene_gen'] === null || isset($done[$id])) {
            continue;
        }
        $st = $call(['action' => 'start', 'mission' => $id]);
        $tok = (string) ($st['json']['token'] ?? '');
        $GLOBALS['BVT_TOKENS'][] = $tok;
        if ($tok === '') {
            throw new RuntimeException('unlock: start ' . $id . ' → ' . $st['code'] . ' ' . $st['body']);
        }
        $seed = (string) $pdo->query('SELECT seed FROM bv_attempts WHERE token = ' . $pdo->quote($tok))->fetchColumn();
        $r = bv_scene_rules($ms['scene_gen'], $seed, $id);
        $act = static fn(string $op, mixed $in) => $call(['action' => 'scene_act', 'token' => $tok, 'op' => $op, 'input' => $in])['json'] ?? [];
        $ok = false;
        foreach (bvt_moves($r) as [$op, $in]) {
            $x = $act($op, $in);
            if (($x['can_submit'] ?? false) === true) {
                $ok = true;
                break;
            }
        }
        $fin = $call(['action' => 'scene_finish', 'token' => $tok]);
        if (!$ok || ($fin['json']['ok'] ?? false) !== true) {
            throw new RuntimeException('unlock: місію ' . $id . ' не здано: ' . $fin['body']);
        }
        $played++;
    }

    return $played;
}

/** Прибрати спроби, створені помічником (гостьові й акаунтні): bv_attempts за токенами. */
function bvt_cleanup(PDO $pdo): void
{
    $t = array_values(array_filter($GLOBALS['BVT_TOKENS'] ?? []));
    if ($t !== []) {
        $pdo->prepare('DELETE FROM bv_attempts WHERE token IN (' . implode(',', array_fill(0, count($t), '?')) . ')')->execute($t);
    }
    $GLOBALS['BVT_TOKENS'] = [];
}

/** Сирі дії, що знаходять поломки варіанта (як їх зробив би гравець). @return list<array{0:string,1:mixed}> */
function bvt_moves(array $r): array
{
    $mv = [];
    if ($r['type'] === 'input_machine') {
        if (($r['kind'] ?? '') === 'change') {
            foreach ($r['bug_notes'] as $note) {
                $mv[] = ['buy', (string) $note];
                $mv[] = ['claim', (string) ($note - $r['price'])];
            }

            return $mv;
        }
        $mv[] = ['refill', ''];
        foreach (['0', '-2', '-1'] as $v) {
            $mv[] = ['buy', $v];
        }
        if (isset($r['max'])) {
            $mv[] = ['refill', ''];
            $mv[] = ['buy', (string) ($r['max'] + 1)];
        }
        if (($r['stock'] ?? null) !== null) {
            $mv[] = ['refill', ''];
            $mv[] = ['buy', (string) ($r['stock'] + 1)];
        }
        foreach (['a', '1.5', '2,5'] as $v) {
            $mv[] = ['buy', $v];
        }

        return $mv;
    }
    if ($r['type'] === 'form_scene') {
        $vals = array_column($r['fields'], 'value', 'key');
        $kinds = array_column($r['fields'], 'kind', 'key');
        foreach ($r['bugs'] as $b) {
            [$cat, $key] = array_pad(explode(':', $b, 2), 2, '');
            $v = $vals;
            switch ($cat) {
                case 'empty': $v[$key] = ''; break;
                case 'blank': $v[$key] = '   '; break;
                case 'long':
                    $f = array_values(array_filter($r['fields'], static fn($x) => $x['key'] === $key))[0] ?? [];
                    $v[$key] = str_repeat('Б', (int) ($f['maxlen'] ?? 20) + 1);
                    break;
                case 'dup': $mv[] = ['submit', $vals]; break;
                case 'email_space': case 'email_at_word': case 'email_double_at': case 'email_no_at':
                    $ek = array_search('email', $kinds, true);
                    $v[$ek] = ['email_space' => 'iv an@poshta.bv', 'email_at_word' => 'ivan(at)poshta.bv',
                        'email_double_at' => 'ivan@@poshta.bv', 'email_no_at' => 'ivan.poshta.bv'][$cat];
                    break;
                default:
                    if (isset(BV_LOOKALIKES[$b])) {   // phone_o, phone_l …: остання цифра номера → схожа літера
                        $pk = array_search('phone', $kinds, true);
                        $v[$pk] = (string) preg_replace('/\d(?=\D*$)/', BV_LOOKALIKES[$b][0][0], (string) $vals[$pk], 1);
                    }
                    break;
            }
            $mv[] = ['submit', $v];
        }

        return $mv;
    }
    if (($r['mode'] ?? '') === 'report') {
        return [['report', ['expected' => (string) $r['expected'], 'actual' => (string) $r['actual']]]];
    }
    foreach ($r['bug_defs'] as $d) {
        $mv[] = ['check', array_slice($d['cells'], 0, 3)];
    }

    return $mv;
}
