<?php

declare(strict_types=1);

/**
 * Багвіль — світ гри (крок 3): глави, рівні, місії й чарівні слова Етапу 1 (docs/bugville/MAIN_TASK.md, розділи 4–5).
 * Поки таблиць bv_chapters / bv_levels / bv_missions немає, структура — тут; крок «Контент» перенесе її в ідемпотентний
 * сид БД. Місія грається, коли є її генератор (app/bugville/bv-content.php), а для pool / mixed — ще й ≥ 6 активних варіантів пулу
 * (сид tools/bugville-seed.php).
 * Тексти без слова «тестування» (MAIN_TASK, розділ 1); назви — пропозиції, які власниця може змінити.
 */

require_once __DIR__ . '/bv-variants.php';
require_once __DIR__ . '/bv-config.php';
require_once __DIR__ . '/bv-scenes.php';

/** Чарівні слова Етапу 1: слово → [вимова українськими літерами, значення]. */
const BV_WORDS = [
    'bug'       => ['баг', 'поломка, помилка в програмі'],
    'check'     => ['чек', 'перевірка; перевірити'],
    'limit'     => ['лíміт', 'межа: найбільше, що дозволено'],
    'input'     => ['íнпут', 'те, що вводять: число, текст, натискання'],
    'boundary'  => ['бáундері', 'межа, край дозволеного діапазону'],
    'required'  => ['рікуáйерд', 'обовʼязковий'],
    'valid'     => ['вéлід', 'правильний, допустимий'],
    'invalid'   => ['інвéлід', 'недопустимий, неправильний'],
    'length'    => ['ленґс', 'довжина'],
    'duplicate' => ['дʼюплікет', 'копія, дубль'],
    'expected'  => ['ікспéктід', 'очікуваний: як має бути'],
    'actual'    => ['éкчуал', 'фактичний: як є насправді'],
    'missing'   => ['мíсінґ', 'відсутній, пропущений'],
    'mismatch'  => ['мíсметч', 'невідповідність'],
    'report'    => ['ріпóрт', 'звіт; повідомити про щось'],
];

/**
 * Глави: 1 — Етап 1 (відкрита), 2–7 — заглушки «скоро» (MAIN_TASK, розділ 4). access — 'free' / 'paid' (оплати немає).
 * Місія: id, n (номер на карті), title, word, mode (generator / pool / mixed), generator (ключ із bv_generators або null).
 */
function bv_world(): array
{
    static $world = null;
    if ($world !== null) {
        return $world;
    }
    // Генератор місії (app/bugville/bv-content.php): generator — уся поломка; mixed — числа для сюжетів пулу; pool — немає.
    $gen = [101 => 'change_due', 102 => 'zero_qty', 103 => 'over_limit', 104 => 'negative_input', 105 => 'boundary_mix',
        201 => 'required_field', 202 => 'email_valid', 203 => 'phone_digits', 204 => 'name_length',
        301 => 'bad_date', 302 => 'duplicate_row', 303 => 'empty_cell', 304 => 'swapped_columns', 305 => 'report_mix'];
    // Інтерактивні сцени (app/bugville/bv-scenes.php): тип сцени й генератор правил. Генератор вибору ($gen) лишається для іспитів.
    $scene = [101 => 'machine_change', 102 => 'machine_zero', 103 => 'machine_limit', 104 => 'machine_minus', 105 => 'machine_boundary'];
    $m = static fn(int $id, string $n, string $title, string $word, string $mode) =>
        ['id' => $id, 'n' => $n, 'title' => $title, 'word' => $word, 'mode' => $mode, 'generator' => $gen[$id] ?? null, 'generator_json' => [],
            'scene' => isset($scene[$id]) ? 'input_machine' : null, 'scene_gen' => $scene[$id] ?? null];
    $world = [
        ['id' => 1, 'path' => 'Junior', 'title' => 'Перші поломки', 'access' => 'free', 'status' => 'open', 'levels' => [
            ['id' => 1, 'icon' => 'vending', 'title' => 'Автомат', 'intro' => 'Торговий автомат приймає монети, рахує решту й видає смаколики. Іноді він помиляється.',
                'missions' => [
                    $m(101, '1.1', 'Скільки монет?', 'bug', 'generator'),
                    $m(102, '1.2', 'Нуль', 'check', 'generator'),
                    $m(103, '1.3', 'Забагато', 'limit', 'generator'),
                    $m(104, '1.4', 'Мінус', 'input', 'generator'),
                    $m(105, '1.5', 'Остання монета', 'boundary', 'mixed'),
                ]],
            ['id' => 2, 'icon' => 'post', 'title' => 'Пошта', 'intro' => 'На пошті заповнюють бланки: імʼя, адресу, телефон. Бланк має помічати, коли щось не так.',
                'missions' => [
                    $m(201, '2.1', 'Порожнє поле', 'required', 'generator'),
                    $m(202, '2.2', 'Дивна адреса', 'valid', 'generator'),
                    $m(203, '2.3', 'Літери замість цифр', 'invalid', 'generator'),
                    $m(204, '2.4', 'Задовге імʼя', 'length', 'generator'),
                    $m(205, '2.5', 'Двічі натиснули', 'duplicate', 'pool'),
                ]],
            ['id' => 3, 'icon' => 'library', 'title' => 'Бібліотека', 'intro' => 'У бібліотеці все записано в таблиці: книжки, дати, читачі. Знайдіть, де таблиця збилася.',
                'missions' => [
                    $m(301, '3.1', 'Не та дата', 'expected', 'generator'),
                    $m(302, '3.2', 'Двійник', 'actual', 'generator'),
                    $m(303, '3.3', 'Порожня клітинка', 'missing', 'generator'),
                    $m(304, '3.4', 'Переплутані стовпці', 'mismatch', 'generator'),
                    $m(305, '3.5', 'Історія бібліотекаря', 'report', 'mixed'),
                ]],
        ]],
        ['id' => 2, 'path' => 'Junior', 'title' => 'Розповісти про поломку', 'access' => 'free', 'status' => 'soon', 'levels' => []],
        ['id' => 3, 'path' => 'Junior', 'title' => 'Ніби справжня робота', 'access' => 'free', 'status' => 'soon', 'levels' => []],
        ['id' => 4, 'path' => 'Middle', 'title' => 'Планування перевірок', 'access' => 'paid', 'status' => 'soon', 'levels' => []],
        ['id' => 5, 'path' => 'Middle', 'title' => 'Помічники й інструменти', 'access' => 'paid', 'status' => 'soon', 'levels' => []],
        ['id' => 6, 'path' => 'Senior', 'title' => 'Команда й ризики', 'access' => 'paid', 'status' => 'soon', 'levels' => []],
        ['id' => 7, 'path' => 'Senior', 'title' => 'Якість усього продукту', 'access' => 'paid', 'status' => 'soon', 'levels' => []],
    ];
    return $world;
}

/** Плоский список місій світу з рівнем і главою: id => місія + ['level' => …, 'chapter' => …]. */
function bv_world_missions(): array
{
    $out = [];
    foreach (bv_world() as $ch) {
        foreach ($ch['levels'] as $lv) {
            foreach ($lv['missions'] as $ms) {
                $out[$ms['id']] = $ms + ['level' => $lv['id'], 'level_title' => $lv['title'], 'chapter' => $ch['id']];
            }
        }
    }

    return $out;
}

/** Скільки активних варіантів пулу треба, щоб місія з пулом (pool / mixed) грались (план, розділ 3). */
const BV_POOL_MIN_ACTIVE = 6;

/**
 * Реєструє місії світу, в які можна грати: generator — є генератор; pool — ≥ 6 активних варіантів; mixed — є генератор
 * і ≥ 6 активних варіантів (без $pdo пули не перевіряються).
 */
function bv_register_world_missions(?PDO $pdo = null): void
{
    $gens = bv_generators();
    $active = [];
    if ($pdo !== null) {
        try {
            $active = array_map('intval', $pdo->query("SELECT mission_id, COUNT(*) FROM bv_mission_variants WHERE status = 'active'
                                                       GROUP BY mission_id")->fetchAll(PDO::FETCH_KEY_PAIR) ?: []);
        } catch (Throwable) {
            $active = [];
        }
    }
    foreach (bv_world_missions() as $ms) {
        $hasGen = $ms['generator'] !== null && isset($gens[$ms['generator']]);
        $hasPool = ($active[$ms['id']] ?? 0) >= BV_POOL_MIN_ACTIVE;
        $mode = $ms['mode'];
        $sceneGen = $ms['scene_gen'] !== null && isset(bv_scene_generators()[$ms['scene_gen']]) ? $ms['scene_gen'] : null;
        if ($sceneGen !== null) {   // місія-сцена грабельна за генератором сцени; режим варіантів лишається для іспитів
            bv_register_mission(['id' => $ms['id'], 'variant_mode' => $mode, 'generator_key' => $hasGen ? $ms['generator'] : null,
                'generator_json' => $ms['generator_json'], 'skill' => $ms['word'], 'scene' => $ms['scene'], 'scene_gen' => $sceneGen]);
            continue;
        }
        if ($mode === 'generator' && !$hasGen) {
            continue;
        }
        if ($mode !== 'generator' && !($mode === 'pool' && $hasPool) && !($mode === 'mixed' && $hasGen && $hasPool)) {
            continue;
        }
        bv_register_mission(['id' => $ms['id'], 'variant_mode' => $mode, 'generator_key' => $hasGen ? $ms['generator'] : null,
            'generator_json' => $ms['generator_json'], 'skill' => $ms['word']]);
    }
}

/** Чи можна вже грати місію (зареєстрована з генератором чи пулом). */
function bv_world_playable(int $missionId): bool
{
    return bv_mission($missionId) !== null;
}

/** Наступна місія світу, в яку можна грати, після $missionId (або null). */
function bv_world_next_playable(int $missionId): ?int
{
    $ids = array_keys(bv_world_missions());
    $pos = array_search($missionId, $ids, true);
    if ($pos === false) {
        return null;
    }
    foreach (array_slice($ids, $pos + 1) as $id) {
        if (bv_world_playable((int) $id)) {
            return (int) $id;
        }
    }

    return null;
}

/** Картка чарівного слова для браузера: ['word', 'say', 'meaning'] або null. */
function bv_word_card(string $word): ?array
{
    $w = BV_WORDS[$word] ?? null;

    return $w === null ? null : ['word' => $word, 'say' => $w[0], 'meaning' => $w[1]];
}

/**
 * Чи показувати сторінки гри цьому відвідувачу: 'bugville_public' => true (на хостингу — після кроку «Контент»)
 * або адміністратор (перевірка на живому сайті до відкриття). $user — рядок users або null.
 */
function bv_pages_visible(?array $user): bool
{
    return bv_cfg('bugville_public') === true || (($user['role'] ?? '') === 'admin');
}
