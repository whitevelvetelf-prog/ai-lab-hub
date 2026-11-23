<?php

declare(strict_types=1);

/**
 * Багвіль — варіанти поломок (крок 1 плану).
 *
 * Варіант (і з генератора, і з пулу) має однаковий вигляд:
 *   payload: ['text' => сцена, 'items' => [['id','text'],…] (елементи сцени), 'question', 'options' => [['id','text'],…],
 *             'shuffle_items' => bool, 'keep_order' => bool]
 *   answer:  ['type' => 'single', 'correct' => 'o3'] | ['type' => 'multi', 'correct' => ['o1','o4']]
 *            | ['type' => 'number', 'value' => 12, 'tolerance' => 0]
 *   explain: ['text' => розбір саме цього варіанта]
 * Режими місії (VARCHAR, перевірка в PHP): generator — усе з генератора від seed; pool — рукописний варіант із
 * bv_mission_variants; mixed — варіант із пулу, а {{плейсхолдери}} у ньому заповнює генератор.
 * Генератор детермінований від seed: у БД зберігається лише seed, варіант відновлюється на сервері.
 */

require_once __DIR__ . '/bv-config.php';

// ---------- Місії -----------------------------------------------------------------------------------------------

/**
 * Опис місії: ['id', 'variant_mode', 'generator_key', 'generator_json' => array, 'skill'].
 * Таблиці місій ще немає (з основного завдання) — поки реєстр у пам'яті; потім читатиме bv_missions.
 */
function bv_register_mission(array $mission): void
{
    $GLOBALS['bv_missions_registry'][(int) $mission['id']] = $mission;
}

function bv_mission(int $id): ?array
{
    $m = $GLOBALS['bv_missions_registry'][$id] ?? null;
    if ($m === null || !bv_valid_mode((string) ($m['variant_mode'] ?? ''))) {
        return null;
    }

    return $m;
}

// ---------- Словники (bv_strings) ------------------------------------------------------------------------------

/**
 * Рядки словника мовою $lang (немає — uk; немає й uk — вбудований запасний список генератора).
 * @return array<string,string> str_key => text
 */
function bv_dict(PDO $pdo, string $dict, string $lang, array $fallback = []): array
{
    static $cache = [];
    $lang = bv_lang($lang);
    $ck = $dict . '|' . $lang;
    if (!array_key_exists($ck, $cache)) {
        $out = [];
        try {
            foreach ([$lang, 'uk'] as $l) {
                $st = $pdo->prepare('SELECT str_key, text FROM bv_strings WHERE dict = :d AND lang = :l ORDER BY str_key');
                $st->execute([':d' => $dict, ':l' => $l]);
                $out = $st->fetchAll(PDO::FETCH_KEY_PAIR) ?: [];
                if ($out !== []) {
                    break;
                }
            }
        } catch (Throwable) {
            $out = [];
        }
        $cache[$ck] = $out;
    }

    return $cache[$ck] !== [] ? $cache[$ck] : $fallback;
}

// ---------- Генератори ------------------------------------------------------------------------------------------

/** @return array<string, callable(PDO, BvRng, array, string): array> */
function bv_generators(): array
{
    return [
        'vending_boundary' => 'bv_gen_vending_boundary',
    ];
}

/**
 * ЗРАЗКОВИЙ генератор для перевірки механізму (справжні — з основного завдання).
 * Торговий автомат приймає суму від min до max; у журналі 6 перевірок, одна з них показує помилку на межі.
 * Рівноцінність: завжди 6 рядків, рівно одна помилка, завжди на межі діапазону.
 * generator_json: min_from/min_to, max_from/max_to (крок 5).
 */
function bv_gen_vending_boundary(PDO $pdo, BvRng $rng, array $p, string $lang): array
{
    $min = $rng->int((int) ($p['min_from'] ?? 1), (int) ($p['min_to'] ?? 10));
    $max = 5 * $rng->int(intdiv((int) ($p['max_from'] ?? 20), 5), intdiv((int) ($p['max_to'] ?? 100), 5));
    if ($max <= $min + 5) {
        $max = $min + 10;
    }
    $item = $rng->pick(bv_dict($pdo, 'items', $lang, ['сік', 'вафлі', 'горішки', 'чай', 'печиво', 'шоколад', 'вода', 'яблуко']));
    $place = $rng->pick(bv_dict($pdo, 'places', $lang, ['у бібліотеці', 'на вокзалі', 'у школі', 'в лікарні', 'у парку', 'в офісі']));
    $bug = $rng->pick(['accepts_above_max', 'rejects_max', 'rejects_min', 'accepts_below_min']);

    // 5 правильних перевірок + 1 помилкова; усередині діапазону — різні значення.
    $mid = $rng->int($min + 1, $max - 1);
    $rows = [
        ['v' => $min, 'ok' => true],
        ['v' => $max, 'ok' => true],
        ['v' => $min - 1, 'ok' => false],
        ['v' => $max + 1, 'ok' => false],
        ['v' => $mid, 'ok' => true],
    ];
    $bugRow = match ($bug) {
        'accepts_above_max' => ['v' => $max + 1, 'ok' => true],
        'rejects_max' => ['v' => $max, 'ok' => false],
        'rejects_min' => ['v' => $min, 'ok' => false],
        default => ['v' => max(0, $min - 1), 'ok' => true],
    };
    // Помилковий рядок замінює правильний з тим самим значенням; шостий — ще одне значення всередині діапазону.
    foreach ($rows as $i => $r) {
        if ($r['v'] === $bugRow['v']) {
            unset($rows[$i]);
        }
    }
    $mid2 = $mid === $min + 1 ? $max - 1 : $min + 1;
    $rows[] = ['v' => $mid2, 'ok' => true];
    $rows = array_values($rows);
    $rows[] = $bugRow + ['bug' => true];

    $options = [];
    $correct = '';
    $badText = '';
    foreach ($rng->shuffle($rows) as $i => $r) {
        $id = 'o' . ($i + 1);
        $text = 'Внесено ' . $r['v'] . ' грн → ' . ($r['ok'] ? 'прийнято' : 'відхилено');
        $options[] = ['id' => $id, 'text' => $text];
        if (!empty($r['bug'])) {
            $correct = $id;
            $badText = $text;
        }
    }

    return [
        'params' => ['min' => $min, 'max' => $max, 'item' => $item, 'place' => $place, 'bug' => $bug],
        'payload' => [
            'text' => "Автомат {$place} продає «{$item}» і має приймати від {$min} до {$max} грн включно. Ось журнал перевірок.",
            'question' => 'Який рядок журналу показує поломку?',
            'options' => $options,
        ],
        'answer' => ['type' => 'single', 'correct' => $correct],
        'explain' => ['text' => "Правило: від {$min} до {$max} грн включно. «{$badText}» порушує правило на межі діапазону — "
            . 'саме на межах такі поломки трапляються найчастіше.'],
        'hint' => ['text' => "Перевірте рядки з {$min} і {$max} грн та сусідні з ними значення."],
    ];
}

// ---------- Побудова варіанта ----------------------------------------------------------------------------------

/** Заповнює {{name}} у всіх рядках масиву значеннями з $params. */
function bv_fill(mixed $value, array $params): mixed
{
    if (is_string($value)) {
        return preg_replace_callback('/\{\{([a-z0-9_]+)\}\}/i', static fn($m) => array_key_exists($m[1], $params) ? (string) $params[$m[1]] : $m[0], $value);
    }
    if (is_array($value)) {
        return array_map(static fn($v) => bv_fill($v, $params), $value);
    }

    return $value;
}

/** Відбиток параметрів / варіанта — ключ «бачених» для генератора. */
function bv_fingerprint(array $data): string
{
    return substr(hash('sha256', json_encode($data, JSON_UNESCAPED_UNICODE)), 0, 16);
}

/** Рядок пулу (активний) або null. */
function bv_pool_row(PDO $pdo, int $variantId): ?array
{
    $st = $pdo->prepare('SELECT * FROM bv_mission_variants WHERE id = :id');
    $st->execute([':id' => $variantId]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r ?: null;
}

/**
 * Відновлює варіант на сервері: з seed (generator), з рядка пулу (pool) або обидва (mixed).
 * @return array{payload:array, answer:array, explain:array, key:string}|null
 */
function bv_build_variant(PDO $pdo, array $mission, ?int $variantId, ?string $seed, string $lang): ?array
{
    $mode = (string) $mission['variant_mode'];
    $gen = null;
    if ($mode === 'generator' || $mode === 'mixed') {
        $fn = bv_generators()[(string) ($mission['generator_key'] ?? '')] ?? null;
        if ($fn === null || $seed === null || $seed === '') {
            return null;
        }
        $gen = $fn($pdo, new BvRng($seed), (array) ($mission['generator_json'] ?? []), $lang);
    }
    if ($mode === 'generator') {
        return ['payload' => $gen['payload'], 'answer' => $gen['answer'], 'explain' => $gen['explain'], 'hint' => (array) ($gen['hint'] ?? []),
            'key' => 'g:' . bv_fingerprint($gen['params'] ?? $gen['payload'])];
    }
    $row = $variantId !== null ? bv_pool_row($pdo, $variantId) : null;
    if ($row === null || (int) $row['mission_id'] !== (int) $mission['id']) {
        return null;
    }
    $v = [
        'payload' => (array) json_decode((string) $row['payload_json'], true),
        'answer' => (array) json_decode((string) $row['answer_json'], true),
        'explain' => (array) json_decode((string) ($row['explain_json'] ?? '[]'), true),
        'key' => 'v:' . (int) $row['id'],
    ];
    $v['hint'] = ['text' => (string) ($v['explain']['hint'] ?? '')];   // підказка пулу — у explain_json.hint
    unset($v['explain']['hint']);
    if ($mode === 'mixed') {
        $params = (array) ($gen['params'] ?? []);
        foreach (['payload', 'answer', 'explain', 'hint'] as $k) {
            $v[$k] = bv_fill($v[$k], $params);
        }
    }

    return $v;
}

// ---------- Вибір варіанта: небачені першими -------------------------------------------------------------------

/** @return array<string,string> variant_key => seen_at (UTC) */
function bv_seen(PDO $pdo, int $missionId, ?int $userId): array
{
    if ($userId === null) {
        return (array) ($_SESSION['bv_guest']['seen'][$missionId] ?? []);
    }
    $st = $pdo->prepare('SELECT variant_key, seen_at FROM bv_seen_variants WHERE user_id = :u AND mission_id = :m');
    $st->execute([':u' => $userId, ':m' => $missionId]);

    return $st->fetchAll(PDO::FETCH_KEY_PAIR) ?: [];
}

/**
 * Наскільки недавно бачено кожен варіант (більше — пізніше). Точніше за seen_at (секунди): у гравця — номер його
 * останньої спроби з цим варіантом, у гостя — порядок у сесії.
 * @return array<string,int>
 */
function bv_seen_rank(PDO $pdo, int $missionId, ?int $userId): array
{
    if ($userId === null) {
        return array_flip(array_keys((array) ($_SESSION['bv_guest']['seen'][$missionId] ?? [])));
    }
    $st = $pdo->prepare('SELECT variant_key, MAX(id) FROM bv_attempts WHERE user_id = :u AND mission_id = :m GROUP BY variant_key');
    $st->execute([':u' => $userId, ':m' => $missionId]);

    return array_map('intval', $st->fetchAll(PDO::FETCH_KEY_PAIR) ?: []);
}

function bv_mark_seen(PDO $pdo, int $missionId, ?int $userId, string $key): void
{
    if ($userId === null) {
        unset($_SESSION['bv_guest']['seen'][$missionId][$key]);   // порядок у масиві = порядок перегляду
        $_SESSION['bv_guest']['seen'][$missionId][$key] = bv_now();
        $_SESSION['bv_guest']['last'][$missionId] = $key;

        return;
    }
    $pdo->prepare('INSERT INTO bv_seen_variants (user_id, mission_id, variant_key, seen_at) VALUES (:u, :m, :k, :t)
                   ON DUPLICATE KEY UPDATE seen_at = VALUES(seen_at)')
        ->execute([':u' => $userId, ':m' => $missionId, ':k' => $key, ':t' => bv_now()]);
}

/** Ключ варіанта попередньої спроби цієї місії (повтор — завжди інший). */
function bv_last_key(PDO $pdo, int $missionId, ?int $userId): ?string
{
    if ($userId === null) {
        return $_SESSION['bv_guest']['last'][$missionId] ?? null;
    }
    $st = $pdo->prepare('SELECT variant_key FROM bv_attempts WHERE user_id = :u AND mission_id = :m ORDER BY id DESC LIMIT 1');
    $st->execute([':u' => $userId, ':m' => $missionId]);
    $k = $st->fetchColumn();

    return $k === false ? null : (string) $k;
}

/**
 * Обирає варіант для нової спроби: ['variant_id' => ?int, 'seed' => ?string, 'variant' => array].
 * Пул: небачені першими (серед них — найрідше видавані іншим гравцям за добу, щоб сусіди отримували різне);
 * усе бачено — найдавніше бачений, але не той, що був у попередній спробі. Генератор: новий seed, доки відбиток
 * не відрізнятиметься від бачених (до 12 спроб) і точно від попереднього.
 */
function bv_pick_variant(PDO $pdo, array $mission, ?int $userId, string $lang): ?array
{
    $mid = (int) $mission['id'];
    $mode = (string) $mission['variant_mode'];
    $seen = bv_seen($pdo, $mid, $userId);
    $last = bv_last_key($pdo, $mid, $userId);

    $variantId = null;
    if ($mode === 'pool' || $mode === 'mixed') {
        $ids = [];
        foreach ([bv_lang($lang), 'uk'] as $l) {
            $st = $pdo->prepare("SELECT id FROM bv_mission_variants WHERE mission_id = :m AND lang = :l AND status = 'active'");
            $st->execute([':m' => $mid, ':l' => $l]);
            $ids = array_map('intval', $st->fetchAll(PDO::FETCH_COLUMN));
            if ($ids !== []) {
                break;
            }
        }
        if ($ids === []) {
            return null;
        }
        $unseen = array_values(array_filter($ids, static fn(int $id) => !isset($seen['v:' . $id])));
        if ($unseen !== []) {
            $in = implode(',', $unseen);
            $use = $pdo->prepare("SELECT variant_id, COUNT(*) FROM bv_attempts WHERE variant_id IN ($in) AND started_at > :t GROUP BY variant_id");
            $use->execute([':t' => bv_now(-86400)]);
            $counts = $use->fetchAll(PDO::FETCH_KEY_PAIR) ?: [];
            shuffle($unseen);
            usort($unseen, static fn(int $a, int $b) => ((int) ($counts[$a] ?? 0)) <=> ((int) ($counts[$b] ?? 0)));
            $variantId = $unseen[0];
        } else {
            $rank = bv_seen_rank($pdo, $mid, $userId);
            $order = $ids;
            usort($order, static fn(int $a, int $b) => ($rank['v:' . $a] ?? 0) <=> ($rank['v:' . $b] ?? 0));
            foreach ($order as $id) {
                if ('v:' . $id !== $last || count($order) === 1) {
                    $variantId = $id;
                    break;
                }
            }
        }
    }

    $seed = null;
    $variant = null;
    $tries = ($mode === 'pool') ? 1 : 12;
    for ($i = 0; $i < $tries; $i++) {
        $seed = $mode === 'pool' ? null : bin2hex(random_bytes(8));
        $variant = bv_build_variant($pdo, $mission, $variantId, $seed, $lang);
        if ($variant === null) {
            return null;
        }
        if ($mode !== 'generator' || (!isset($seen[$variant['key']]) && $variant['key'] !== $last)) {
            break;
        }
    }
    if ($mode === 'generator' && $variant['key'] === $last) {
        return null;   // практично неможливо; краще помилка, ніж той самий варіант двічі поспіль
    }

    return ['variant_id' => $variantId, 'seed' => $seed, 'variant' => $variant];
}

// ---------- Сцена для браузера --------------------------------------------------------------------------------

/**
 * Публічна сцена спроби: без answer / explain, варіанти відповідей під одноразовими випадковими id і в перемішаному
 * порядку. Повертає [сцена, карта public_id => internal_id] (карта лишається в bv_attempts.opt_map_json).
 * @return array{0: array, 1: array<string,string>}
 */
function bv_public_scene(array $payload, BvRng $rng): array
{
    $map = [];
    $options = [];
    foreach ((array) ($payload['options'] ?? []) as $o) {
        do {
            $pub = 'k' . bin2hex(random_bytes(3));   // з літерою: чисто цифровий ключ PHP перетворив би на int
        } while (isset($map[$pub]));
        $map[$pub] = (string) $o['id'];
        $options[] = ['id' => $pub, 'text' => (string) ($o['text'] ?? '')];
    }
    if (empty($payload['keep_order'])) {
        $options = $rng->shuffle($options);
    }
    $items = array_map(static fn($it) => ['text' => (string) ($it['text'] ?? '')], (array) ($payload['items'] ?? []));
    if (!empty($payload['shuffle_items'])) {
        $items = $rng->shuffle($items);
    }
    $scene = ['text' => (string) ($payload['text'] ?? ''), 'question' => (string) ($payload['question'] ?? '')];
    if ($items !== []) {
        $scene['items'] = $items;
    }
    if ($options !== []) {
        $scene['options'] = $options;
    }
    if (isset($payload['input'])) {
        $scene['input'] = (string) $payload['input'];   // 'number' — поле для числа
    }

    return [$scene, $map];
}
