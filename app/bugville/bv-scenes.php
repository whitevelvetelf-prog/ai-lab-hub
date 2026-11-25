<?php

declare(strict_types=1);

/**
 * Багвіль — інтерактивні сцени Розділу 1 (Етап A: тип input_machine, «Автомат»).
 *
 * Гравець діє сам (вводить кількість, вносить гроші, натискає «Купити»), автомат реагує. Оцінювання ЛИШЕ на сервері:
 *   * правила варіанту (ціна, межі, запас, де поломки) будує генератор від seed; seed лежить у bv_attempts і в браузер
 *     не потрапляє; браузер отримує лише вигляд сцени (bv_scene_public) — без переліку поломок;
 *   * браузер надсилає сирі дії (що ввів, що натиснув); сервер сам вирішує, як реагує автомат і чи знайдено поломку
 *     (bv_scene_machine_act — чиста функція, тестується без БД);
 *   * стан спроби (дії, знайдені поломки, гаманець сцени) — у bv_attempts.scene_state_json; XP, зірки й монети гри
 *     нараховує лише сервер під час «Здати роботу» (bv_scene_finish → ті самі правила нагород, що й у кроці 2).
 * Гаманець сцени («100 монет», «+») — іграшкові гроші автомата, не монети гри.
 */

require_once __DIR__ . '/bv-config.php';
require_once __DIR__ . '/bv-content.php';
require_once __DIR__ . '/bv-scene-form.php';
require_once __DIR__ . '/bv-scene-table.php';

const BV_SCENE_TYPES = ['input_machine', 'form_scene', 'table_scene'];
const BV_SCENE_WALLET = 100;
const BV_SCENE_BOTTLE_GOODS = ['лимонад', 'сік', 'вода', 'какао', 'компот', 'кефір'];
const BV_SCENE_NOTES = [10, 20, 50, 100, 200];

/** Генератори сцен: ключ (bv-world.php, поле scene_gen) → функція (BvRng $rng, int $missionId): правила. */
function bv_scene_generators(): array
{
    return ['machine_change' => 'bv_scene_gen_change', 'machine_zero' => 'bv_scene_gen_zero', 'machine_limit' => 'bv_scene_gen_limit',
        'machine_minus' => 'bv_scene_gen_minus', 'machine_boundary' => 'bv_scene_gen_boundary'] + bv_form_generators() + bv_table_generators();
}

function bv_scene_cfg_int(string $key, int $default): int
{
    $v = bv_cfg($key);

    return is_int($v) && $v > 0 ? $v : $default;
}

function bv_scene_max_actions(): int
{
    return bv_scene_cfg_int('bugville_scene_max_actions', 50);
}

function bv_scene_max_input(): int
{
    return bv_scene_cfg_int('bugville_scene_max_input', 30);
}

/** Скільки поломок треба знайти, щоб здати місію (config bugville_scene_min_found: [місія => N, 'default' => N]). */
function bv_scene_min_found(int $missionId, int $total): int
{
    $cfg = (array) (bv_cfg('bugville_scene_min_found') ?? []);
    $n = (int) ($cfg[$missionId] ?? $cfg['default'] ?? 1);

    return max(1, min($n, max(1, $total)));
}

/** Будує правила варіанту від seed. null — невідомий генератор. */
function bv_scene_rules(string $genKey, string $seed, int $missionId): ?array
{
    $fn = bv_scene_generators()[$genKey] ?? null;
    if ($fn === null || $seed === '') {
        return null;
    }
    $rules = $fn(new BvRng('scene|' . $seed), $missionId);
    $rules['min_found'] = bv_scene_min_found($missionId, count($rules['bugs']));

    return $rules;
}

/** «3 пляшки», «5 пляшок», «1 пляшку» — число з відмінюваним словом (українські форми). */
function bv_pl(int $n, string $one, string $few, string $many): string
{
    $a = abs($n) % 100;
    $b = $a % 10;
    $w = ($a >= 11 && $a <= 14) ? $many : ($b === 1 ? $one : (($b >= 2 && $b <= 4) ? $few : $many));

    return $n . ' ' . $w;
}

function bv_coins(int $n): string
{
    return bv_pl($n, 'монету', 'монети', 'монет');
}

// ---------- Генератори правил «Автомата» ----------------------------------------------------------------------

/** Спільна основа автомата з кількістю: товар, ціна, межа «від 1 до max» за раз. */
function bv_scene_qty_base(BvRng $rng, int $maxFrom, int $maxTo): array
{
    return ['type' => 'input_machine', 'kind' => 'qty', 'good' => $rng->pick(BV_SCENE_BOTTLE_GOODS), 'price' => $rng->int(2, 9) * ($rng->int(0, 1) ? 1 : 2),
        'min' => 1, 'max' => $rng->int($maxFrom, $maxTo), 'stock' => null, 'wallet' => BV_SCENE_WALLET, 'bugs' => [], 'kinds' => []];
}

/** 1.2 «Нуль» (check): лише поломка на 0 (вид — як у затверджених прикладах: списує гроші / видає безкоштовно / видає й рахує одну). */
function bv_scene_gen_zero(BvRng $rng, int $missionId): array
{
    $r = bv_scene_qty_base($rng, 3, 9);
    $r['bugs'] = ['zero'];
    $r['kinds'] = ['zero' => $rng->pick(['charged', 'free', 'one'])];
    $r['hints'] = ['Подивіться на найменшу кількість.', 'А що, коли попросити зовсім нічого?'];

    return $r;
}

/** 1.3 «Забагато» (limit): або продає на одну більше за межу «за раз», або бере гроші за більше, ніж лишилося. */
function bv_scene_gen_limit(BvRng $rng, int $missionId): array
{
    if ($rng->int(0, 1) === 0) {
        $r = bv_scene_qty_base($rng, 3, 8);
        $r['bugs'] = ['over'];
        $r['hints'] = ["Порівняйте кожну покупку з числом {$r['max']}.", 'Спробуйте найбільше дозволене число, а потім на крок більше.'];

        return $r;
    }
    $r = bv_scene_qty_base($rng, 6, 9);
    $r['stock'] = $rng->int(2, $r['max'] - 2);
    $r['bugs'] = ['stock'];
    $r['hints'] = ['Скільки всього в автоматі? Шукайте покупку, де взяли більше.', 'Порахуйте пляшки у вітрині й попросіть на одну більше.'];

    return $r;
}

/** 1.4 «Мінус» (input): відʼємна кількість. */
function bv_scene_gen_minus(BvRng $rng, int $missionId): array
{
    $r = bv_scene_qty_base($rng, 3, 9);
    $r['bugs'] = ['neg'];
    $r['kinds'] = ['neg' => $rng->pick(['refund', 'negative_total'])];
    $r['hints'] = ['Чи бувають кількості, менші за нуль?', 'На клавіатурі автомата є кнопка «−».'];

    return $r;
}

/** 1.5 «Остання монета» (boundary): усі пʼять поломок прототипу — 0, мінус, межа + 1, літери, дріб; межа 3…9. */
function bv_scene_gen_boundary(BvRng $rng, int $missionId): array
{
    $r = bv_scene_qty_base($rng, 3, 9);
    $r['bugs'] = ['zero', 'neg', 'over', 'nan', 'dec'];
    $r['kinds'] = ['zero' => 'charged', 'neg' => 'refund'];
    $r['hints'] = ['Спробуйте найменше число, яке має сенс, і найбільше. А потім число на крок за ними.',
        'А що, коли ввести те, чого на наліпці зовсім немає: мінус, літери, крапку?'];

    return $r;
}

/**
 * 1.1 «Скільки монет?» (bug): автомат продає один товар за ціну й видає решту. Дві поломки на двох різних купюрах:
 * решта на 10 грн менша / більша і переставлені цифри. Гравець сам рахує решту й, коли автомат схибив, натискає
 * «Решта неправильна» та вписує, скільки мало бути (як у затвердженому прикладі «Ввести: скільки решти мав видати»).
 */
function bv_scene_gen_change(BvRng $rng, int $missionId): array
{
    for ($guard = 0; $guard < 60; $guard++) {
        $price = $rng->int(5, 99);
        $notes = array_values(array_filter(BV_SCENE_NOTES, static fn(int $n) => $n > $price));
        $swapNotes = array_values(array_filter($notes, static function (int $n) use ($price): bool {
            $d = $n - $price;

            return $d >= 10 && $d < 100 && $d % 10 !== 0 && intdiv($d, 10) !== $d % 10;
        }));
        if (count($notes) < 2 || $swapNotes === []) {
            continue;
        }
        $swap = $rng->pick($swapNotes);
        $rest = array_values(array_filter($notes, static fn(int $n) => $n !== $swap));
        $tenNote = $rng->pick($rest);
        $tenKind = ($tenNote - $price) >= 10 ? $rng->pick(['less', 'more']) : 'more';

        return ['type' => 'input_machine', 'kind' => 'change', 'good' => $rng->pick(BV_SCENE_BOTTLE_GOODS), 'price' => $price,
            'notes' => $notes, 'max_paid' => 500, 'bugs' => ['change_ten', 'change_swap'],
            'kinds' => ['change_ten' => $tenKind], 'bug_notes' => ['change_ten' => $tenNote, 'change_swap' => $swap],
            'hints' => ['Порахуйте самі: внесено мінус ціна. Збігається з тим, що видав автомат?',
                'Спробуйте різні купюри: ' . implode(', ', $notes) . ' грн. Поломка ховається не на кожній.']];
    }
    // практично недосяжно: фіксований робочий варіант
    return ['type' => 'input_machine', 'kind' => 'change', 'good' => 'сік', 'price' => 17, 'notes' => [20, 50, 100, 200], 'max_paid' => 500,
        'bugs' => ['change_ten', 'change_swap'], 'kinds' => ['change_ten' => 'less'], 'bug_notes' => ['change_ten' => 100, 'change_swap' => 50],
        'hints' => ['Порахуйте самі: внесено мінус ціна.', 'Спробуйте різні купюри.']];
}

// ---------- Що бачить браузер -----------------------------------------------------------------------------------

/** Короткі тексти сцени для місії: вступ майстра Гайки. */
function bv_scene_intro(array $r): string
{
    $need = (int) $r['min_found'];
    $needText = $need === 1 ? '<b>поломку</b>' : "щонайменше <b>{$need} поломки</b>";
    if ($r['kind'] === 'change') {
        return 'Привіт! Я майстер Гайка. Цей автомат видає решту, але інколи помиляється. Купіть щось, порахуйте решту самі, '
            . 'а якщо автомат схибив, натисніть <b>«Решта неправильна»</b> і впишіть, скільки мало бути. Знайдіть ' . $needText . '.';
    }

    return 'Привіт! Я майстер Гайка. Цей автомат у Багвілі поводиться дивно. На наліпці написано, як він <b>має</b> працювати, '
        . 'а ваше завдання — перевірити, де він <b>бреше</b>. Знайдіть ' . $needText . '.';
}

/**
 * Публічний вигляд сцени: лише те, що написано на автоматі, і скільки комірок у колекції. Без переліку поломок,
 * видів поломок, купюр із поломками й seed.
 */
function bv_scene_public(array $r): array
{
    if (($r['type'] ?? '') === 'form_scene') {
        return bv_form_public($r);
    }
    if (($r['type'] ?? '') === 'table_scene') {
        return bv_table_public($r);
    }
    $good = (string) $r['good'];
    $title = mb_strtoupper($good);
    $base = ['type' => 'input_machine', 'kind' => $r['kind'], 'good' => $good, 'total' => count($r['bugs']), 'min_found' => (int) $r['min_found'],
        'intro' => bv_scene_intro($r), 'hints' => count((array) ($r['hints'] ?? [])), 'max_actions' => bv_scene_max_actions(),
        'max_input' => bv_scene_max_input()];
    if ($r['kind'] === 'change') {
        return $base + ['sign' => $title, 'sign_sub' => "{$r['price']} грн за пляшку", 'label' => 'Внесено, грн', 'placeholder' => 'сума',
            'sticker' => ['Ціна ', (string) $r['price'] . ' грн', '. Внесіть суму, автомат видасть пляшку й решту.'],
            'notes' => array_values($r['notes']), 'shelf' => 12, 'buy' => 'Оплатити', 'claim' => true, 'currency' => 'грн'];
    }
    $sticker = ['Наліпка автомата: можна купити ', "від {$r['min']} до {$r['max']}", " шт. за раз. Ціна " . bv_coins((int) $r['price']) . " за штуку."];
    if ($r['stock'] !== null) {
        $sticker[2] .= " У вітрині лишилося {$r['stock']} шт.";
    }

    return $base + ['sign' => $title, 'sign_sub' => bv_coins((int) $r['price']) . " за пляшку", 'label' => 'Кількість', 'placeholder' => '?',
        'sticker' => $sticker, 'keys' => ['7', '8', '9', '4', '5', '6', '1', '2', '3', '-', '0', '.'], 'letters' => true,
        'shelf' => $r['stock'] ?? 12, 'buy' => 'Купити', 'claim' => false, 'wallet' => BV_SCENE_WALLET, 'currency' => 'монет'];
}

// ---------- Поломки: міні-звіт «ввели → сталося → мало бути» ----------------------------------------------------

/** Картка знайденої поломки (і реплика майстра) — з чисел саме цього варіанта. */
function bv_scene_bug_card(array $r, string $bug, array $ctx = []): array
{
    if (($r['type'] ?? '') === 'form_scene') {
        return bv_form_bug_card($r, $bug, $ctx);
    }
    if (($r['type'] ?? '') === 'table_scene') {
        return bv_table_bug_card($r, $bug);
    }
    $p = (int) ($r['price'] ?? 0);
    $max = (int) ($r['max'] ?? 0);
    $kind = (string) ($r['kinds'][$bug] ?? '');
    $limitExp = 'Відмовити: кількість має бути від ' . ($r['min'] ?? 1) . " до {$max}.";

    return match ($bug) {
        'zero' => match ($kind) {
            'free' => ['title' => 'Безкоштовна пляшка', 'inp' => '0', 'got' => 'Замовили 0, а автомат видав 1 пляшку безкоштовно.', 'exp' => $limitExp,
                'say' => 'Нуль — це нуль, а автомат видав одну безкоштовно.'],
            'one' => ['title' => 'Нуль став одиницею', 'inp' => '0', 'got' => "Замовили 0, а автомат видав 1 пляшку й списав " . bv_coins($p) . ".", 'exp' => $limitExp,
                'say' => 'Замовили нуль, а автомат видав і порахував одну. Нуль треба перевіряти окремо.'],
            default => ['title' => 'Платиш за ніщо', 'inp' => '0', 'got' => "Куплено 0 пляшок, але списано " . bv_coins($p) . ".", 'exp' => $limitExp,
                'say' => "За нуль пляшок не можна брати " . bv_coins($p) . ". Нуль — особливе число, його варто перевіряти окремо."],
        },
        'over' => ['title' => 'Зайва пляшка на межі', 'inp' => (string) ($max + 1),
            'got' => 'Автомат продав ' . ($max + 1) . " шт., хоча дозволено до {$max}.", 'exp' => "Показати, що максимум {$max} шт. за раз.",
            'say' => "Межа — {$max}. Покупка на " . ($max + 1) . ' мала отримати відмову.'],
        'stock' => ['title' => 'Гроші за порожнечу', 'inp' => (string) ($ctx['n'] ?? ((int) $r['stock'] + 1)),
            'got' => 'Оплачено ' . ($ctx['n'] ?? ((int) $r['stock'] + 1)) . " шт., а видано лише {$r['stock']}.",
            'exp' => "Відмовити до оплати: лишилося {$r['stock']} шт.",
            'say' => "Автомат узяв гроші за більше, ніж мав. Лишилося {$r['stock']} — мав відмовити до оплати."],
        'neg' => ['title' => 'Гроші з нічого', 'inp' => 'мінусове число', 'got' => $kind === 'negative_total'
            ? 'Автомат написав «до сплати» з мінусом і видав монети.' : 'Автомат віддає монети замість того, щоб їх брати.',
            'exp' => 'Відмовити: кількість не може бути відʼємною.',
            'say' => 'Кількість не буває відʼємною. Автомат мав не прийняти мінус, а він ще й видав гроші.'],
        'nan' => ['title' => 'Екран показує NaN', 'inp' => 'літери', 'got' => 'На екрані «NaN шт.» і «NaN монет».',
            'exp' => 'Зрозуміле повідомлення: введіть число.', 'say' => 'Літери замість числа — і автомат розгубився. Він мав чемно попросити ввести число.'],
        'dec' => ['title' => 'Півпляшки', 'inp' => 'число з крапкою', 'got' => 'Автомат погоджується продати дробову кількість.',
            'exp' => 'Приймати лише цілі числа.', 'say' => 'Півпляшки не продаються. Кількість — лише ціле число.'],
        'change_ten' => [
            'title' => $kind === 'less' ? 'Решти забракло' : 'Зайва решта', 'inp' => ($ctx['paid'] ?? $r['bug_notes'][$bug]) . ' грн',
            'got' => 'Решта: ' . ($ctx['shown'] ?? '?') . ' грн.', 'exp' => 'Решта: ' . ($ctx['due'] ?? '?') . ' грн (' . ($ctx['paid'] ?? '?') . " − {$p}).",
            'say' => ($ctx['paid'] ?? '') . " − {$p} = " . ($ctx['due'] ?? '') . '. ' . ($kind === 'less'
                ? 'Автомат видав на 10 грн менше — це поломка.' : 'Автомат видав зайві 10 грн — це теж поломка.')],
        'change_swap' => ['title' => 'Переставлені цифри', 'inp' => ($ctx['paid'] ?? $r['bug_notes'][$bug]) . ' грн',
            'got' => 'Решта: ' . ($ctx['shown'] ?? '?') . ' грн.', 'exp' => 'Решта: ' . ($ctx['due'] ?? '?') . ' грн (' . ($ctx['paid'] ?? '?') . " − {$p}).",
            'say' => ($ctx['paid'] ?? '') . " − {$p} = " . ($ctx['due'] ?? '') . '. Автомат переставив цифри місцями — це поломка.'],
        default => ['title' => 'Поломка', 'inp' => '', 'got' => '', 'exp' => '', 'say' => ''],
    };
}

// ---------- Реакція автомата на одну дію (чиста функція) --------------------------------------------------------

/** Порожній стан спроби. */
function bv_scene_initial_state(array $r): array
{
    return ['w' => (int) ($r['wallet'] ?? BV_SCENE_WALLET), 'f' => [], 'a' => [], 'u' => 0, 'lt' => null];
}

/**
 * Одна дія гравця → реакція автомата + новий стан. $op: 'buy' (Купити / Оплатити), 'claim' («Решта неправильна» + число),
 * 'refill' (поповнити іграшковий гаманець). $input — сирий рядок (уже обрізаний до max_input).
 * Реакція: ['tone' => 'ok'|'bad'|'info', 'text', 'goods' => шт. у лоток, 'change' => решта, 'wallet', 'result' =>
 *           'bug'|'ok'|'info'|'useless', 'bug' => картка (лише якщо поломку знайдено вперше), 'repeat_bug' => bool].
 * @return array{0: array, 1: array}
 */
function bv_scene_machine_act(array $r, array $state, string $op, string $input): array
{
    $s = trim($input);
    $hit = null;   // [bug, ctx]
    $react = ['tone' => 'ok', 'text' => '', 'goods' => 0, 'change' => null, 'result' => 'ok'];
    $has = static fn(string $b) => in_array($b, $r['bugs'], true);

    if ($op === 'refill') {
        if ($r['kind'] === 'change') {
            return [['tone' => 'info', 'text' => 'Цей автомат приймає гроші, які ви вносите. Гаманець не потрібен.', 'goods' => 0,
                'change' => null, 'result' => 'info', 'wallet' => null], $state];
        }
        $state['w'] = BV_SCENE_WALLET;
        $react = ['tone' => 'info', 'text' => 'Гаманець поповнено до ' . BV_SCENE_WALLET . ' монет.', 'goods' => 0, 'change' => null, 'result' => 'info'];
    } elseif ($r['kind'] === 'change') {
        [$react, $hit, $state] = bv_scene_change_act($r, $state, $op, $s);
    } elseif ($op !== 'buy') {
        $react = ['tone' => 'info', 'text' => 'Цей автомат уміє лише продавати.', 'goods' => 0, 'change' => null, 'result' => 'info'];
    } else {
        $p = (int) $r['price'];
        $max = (int) $r['max'];
        $w = (int) $state['w'];
        $pay = static function (int $sum, int $goods, string $text) use (&$w, &$react): bool {
            if ($sum > $w) {
                $react = ['tone' => 'info', 'text' => 'Не вистачає монет. Поповніть гаманець кнопкою «+» угорі.', 'goods' => 0, 'change' => null, 'result' => 'info'];

                return false;
            }
            $w -= $sum;
            $react['goods'] = $goods;
            $react['text'] = $text;

            return true;
        };
        if ($s === '') {
            $react = ['tone' => 'info', 'text' => 'Спочатку введіть кількість.', 'goods' => 0, 'change' => null, 'result' => 'info'];
        } elseif (preg_match('/^\d+$/', $s) === 1) {
            $n = strlen(ltrim($s, '0')) > 6 ? 9999999 : (int) $s;
            $stock = $r['stock'];
            if ($n === 0) {
                if ($has('zero')) {
                    $k = (string) ($r['kinds']['zero'] ?? 'charged');
                    $ok = match ($k) {
                        'free' => $pay(0, 1, 'Видано 1 пляшку. Оплата 0 монет.'),
                        'one' => $pay($p, 1, "Видано 1 пляшку. Списано " . bv_coins($p) . "."),
                        default => $pay($p, 0, "Ви купили 0 пляшок. Списано " . bv_coins($p) . "."),
                    };
                    $hit = $ok ? ['zero', []] : null;
                } else {
                    $react['text'] = "Кількість має бути від {$r['min']} до {$max}.";
                }
            } elseif ($n <= $max && $stock !== null && $n > $stock) {
                if ($has('stock')) {
                    $hit = $pay($n * $p, (int) $stock, "Оплачено {$n} шт., списано " . bv_coins($n * $p) . ". Видано {$stock}.") ? ['stock', ['n' => $n]] : null;
                } else {
                    $react['text'] = "Лишилося лише {$stock} шт.";
                }
            } elseif ($n <= $max) {
                $pay($n * $p, $n, "Смачного! Видано {$n} шт., списано " . bv_coins($n * $p) . '.');
            } elseif ($n === $max + 1 && $has('over')) {
                $hit = $pay($n * $p, $n, 'Ви купили ' . bv_pl($n, 'пляшку', 'пляшки', 'пляшок') . '. Списано ' . bv_coins($n * $p) . '.') ? ['over', []] : null;
            } else {
                $react['text'] = "Максимум {$max} шт. за раз.";
            }
        } elseif (preg_match('/^[-−]\d+$/u', $s) === 1) {
            $m = min(99, (int) preg_replace('/\D/', '', $s));
            if ($has('neg') && $m > 0) {
                $w += $m * $p;
                $react['text'] = ($r['kinds']['neg'] ?? 'refund') === 'negative_total'
                    ? 'До сплати −' . bv_coins($m * $p) . '. Видано ' . bv_coins($m * $p) . '.' : 'Повертаємо вам ' . bv_coins($m * $p) . '!';
                $hit = ['neg', []];
            } else {
                $react['text'] = $m === 0 ? "Кількість має бути від {$r['min']} до {$max}." : 'Кількість не може бути відʼємною.';
            }
        } elseif (preg_match('/^\d*[.,]\d+$/', $s) === 1) {
            $v = (float) str_replace(',', '.', $s);
            if ($has('dec') && $v > 0 && $v <= $max) {
                $hit = $pay((int) round($v * $p), max(1, (int) ceil($v)), "Ви купили {$s} пляшки.") ? ['dec', []] : null;
            } else {
                $react['text'] = 'Можна купити лише цілу кількість пляшок.';
            }
        } else {
            if ($has('nan')) {
                $react['text'] = 'NaN пляшок. Списано NaN монет.';
                $hit = ['nan', []];
            } else {
                $react['text'] = 'Введіть кількість числом.';
            }
        }
        $state['w'] = max(0, min(99999, $w));
    }

    if ($hit !== null) {
        [$bug, $ctx] = $hit;
        $react['tone'] = 'bad';
        $react['result'] = 'bug';
        if (!in_array($bug, $state['f'], true)) {
            $state['f'][] = $bug;
            $react['bug'] = bv_scene_bug_card($r, $bug, $ctx);
            $react['repeat_bug'] = false;
        } else {
            $react['repeat_bug'] = true;
            $react['bug_title'] = bv_scene_bug_card($r, $bug, $ctx)['title'];
        }
    } elseif ($react['result'] === 'useless') {
        $state['u']++;
    }
    $react['wallet'] = $r['kind'] === 'change' ? null : (int) $state['w'];
    $state['a'][] = ['o' => $op, 'i' => $s, 'r' => $react['result'], 'b' => $hit[0] ?? null];

    return [$react, $state];
}

/** Автомат із рештою: оплата (buy) і «Решта неправильна» (claim). @return array{0: array, 1: ?array, 2: array} */
function bv_scene_change_act(array $r, array $state, string $op, string $s): array
{
    $p = (int) $r['price'];
    $info = static fn(string $t) => ['tone' => 'info', 'text' => $t, 'goods' => 0, 'change' => null, 'result' => 'info'];
    if ($op === 'claim') {
        $lt = $state['lt'];
        if ($lt === null) {
            return [$info('Спершу щось купіть: майстрові потрібна покупка, яку можна перерахувати.'), null, $state];
        }
        if (preg_match('/^\d{1,4}$/', $s) !== 1) {
            return [$info('Впишіть у поле, скільки решти мав видати автомат, і натисніть «Решта неправильна» ще раз.'), null, $state];
        }
        $claimed = (int) $s;
        if ($lt['bug'] === null) {
            return [['tone' => 'ok', 'text' => "Майстер перерахував: {$lt['paid']} − {$p} = {$lt['due']}. Автомат видав правильно.", 'goods' => 0,
                'change' => null, 'result' => 'useless'], null, $state];
        }
        if ($claimed !== (int) $lt['due']) {
            return [['tone' => 'ok', 'text' => "Решта справді дивна, але {$claimed} — теж не те число. Порахуйте ще раз: внесено мінус ціна.",
                'goods' => 0, 'change' => null, 'result' => 'useless'], null, $state];
        }
        $state['lt'] = null;   // одна покупка — одна знахідка

        return [['tone' => 'bad', 'text' => "Так! Мало бути {$lt['due']} грн, а видано {$lt['shown']} грн.", 'goods' => 0, 'change' => null, 'result' => 'bug'],
            [$lt['bug'], ['paid' => $lt['paid'], 'due' => $lt['due'], 'shown' => $lt['shown']]], $state];
    }
    if ($op !== 'buy') {
        return [$info('Невідома дія.'), null, $state];
    }
    if ($s === '') {
        return [$info('Спочатку внесіть суму: впишіть число або натисніть купюру.'), null, $state];
    }
    if (preg_match('/^\d+$/', $s) !== 1) {
        $state['lt'] = null;

        return [['tone' => 'ok', 'text' => 'Внесіть суму цілим числом гривень.', 'goods' => 0, 'change' => null, 'result' => 'ok'], null, $state];
    }
    $paid = strlen(ltrim($s, '0')) > 6 ? 9999999 : (int) $s;
    if ($paid < $p) {
        $state['lt'] = null;

        return [['tone' => 'ok', 'text' => "Недостатньо: пляшка коштує {$p} грн. Гроші повернуто.", 'goods' => 0, 'change' => null, 'result' => 'ok'], null, $state];
    }
    if ($paid > (int) $r['max_paid']) {
        $state['lt'] = null;

        return [['tone' => 'ok', 'text' => "Автомат приймає до {$r['max_paid']} грн за раз. Гроші повернуто.", 'goods' => 0, 'change' => null, 'result' => 'ok'],
            null, $state];
    }
    $due = $paid - $p;
    $shown = $due;
    $bug = null;
    if ($paid === (int) $r['bug_notes']['change_ten']) {
        $shown = ($r['kinds']['change_ten'] ?? 'more') === 'less' ? $due - 10 : $due + 10;
        $bug = 'change_ten';
    } elseif ($paid === (int) $r['bug_notes']['change_swap']) {
        $shown = (int) (($due % 10) . intdiv($due, 10));
        $bug = 'change_swap';
    }
    $state['lt'] = ['paid' => $paid, 'due' => $due, 'shown' => $shown, 'bug' => $bug];

    // Відповідь та сама для правильної й поломаної решти: що це поломка, гравець має помітити сам.
    return [['tone' => 'ok', 'text' => "Видано 1 пляшку. Решта: {$shown} грн.", 'goods' => 1, 'change' => $shown, 'result' => 'ok'], null, $state];
}

/** Підсумок спроби для «Здати роботу»: знайдено / усього / марні дії / картки знайденого. */
function bv_scene_summary(array $r, array $state): array
{
    $found = array_values(array_intersect((array) $state['f'], $r['bugs']));
    $acts = array_values(array_filter((array) $state['a'], static fn($a) => ($a['r'] ?? '') !== 'info'));

    return ['found' => count($found), 'total' => count($r['bugs']), 'min_found' => (int) $r['min_found'],
        'useless' => (int) $state['u'], 'tries' => count($acts),
        'missing' => count($r['bugs']) - count($found)];
}
