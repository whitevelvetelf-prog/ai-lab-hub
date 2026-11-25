<?php

declare(strict_types=1);

/**
 * Багвіль — сцена «Бібліотека» (table_scene, Етап C). Таблиця видачі книжок; гравець позначає клітинки, що суперечать
 * правилу чи одна одній, і натискає «Перевірити позначене» — сервер порівнює позначене з відомими помилками варіанта.
 * 3.5 «Історія бібліотекаря» — таблиця з сюжету й короткий звіт «Очікувано / Фактично», який перевіряє сервер.
 *
 * Поломка варіанта: ['id', 'cells' => [[рядок, стовпець], …] — будь-яка з цих клітинок зараховує знахідку, 'card'].
 * Захист від «позначити все»: за одну перевірку не більше bugville_table_max_marks клітинок; після
 * bugville_table_max_wrong хибних позначок таблиця блокується (здати можна, якщо вже знайдено мінімум, інакше — нова спроба).
 * Місії, ідеї й тексти розборів — з документа «Багвіль — приклади варіантів Глави 1» (рівень 3).
 */

require_once __DIR__ . '/bv-config.php';
require_once __DIR__ . '/bv-content.php';

const BV_MONTH_DAYS = [1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31];
const BV_MONTH_GEN = [1 => 'січні', 2 => 'лютому', 3 => 'березні', 4 => 'квітні', 5 => 'травні', 6 => 'червні', 7 => 'липні', 8 => 'серпні',
    9 => 'вересні', 10 => 'жовтні', 11 => 'листопаді', 12 => 'грудні'];

function bv_table_generators(): array
{
    return ['table_date' => 'bv_table_gen_date', 'table_twin' => 'bv_table_gen_twin', 'table_empty' => 'bv_table_gen_empty',
        'table_swap' => 'bv_table_gen_swap', 'table_report' => 'bv_table_gen_report'];
}

function bv_table_max_marks(): int
{
    return bv_scene_cfg_int('bugville_table_max_marks', 3);
}

function bv_table_max_wrong(): int
{
    return bv_scene_cfg_int('bugville_table_max_wrong', 6);
}

/** Дата «дд.мм» року 2026 (не високосний). */
function bv_dm(DateTimeImmutable $d): string
{
    return $d->format('d.m');
}

/** Видача + 14 днів: [видано, повернути] як DateTimeImmutable. */
function bv_table_loan(BvRng $rng, int $month): array
{
    $issue = new DateTimeImmutable(sprintf('2026-%02d-%02d', $month, $rng->int(1, 25)));

    return [$issue, $issue->modify('+14 days')];
}

/** Рядки «книжка · читач · видано · повернути» з різними книжками. */
function bv_table_loans(BvRng $rng, int $n): array
{
    $books = array_slice($rng->shuffle(BV_BOOKS), 0, $n);
    $month = $rng->int(2, 10);
    $rows = [];
    foreach ($books as $b) {
        [$i, $r] = bv_table_loan($rng, $month);
        $rows[] = [$b, $rng->pick(BV_NAMES), bv_dm($i), bv_dm($r)];
    }

    return $rows;
}

function bv_table_rules(BvRng $rng, string $kind, string $caption, array $cols, array $rows, array $bugs, array $hints, string $intro, array $extra = []): array
{
    return ['type' => 'table_scene', 'kind' => $kind, 'caption' => $caption, 'cols' => $cols, 'rows' => $rows,
        'bugs' => array_column($bugs, 'id'), 'bug_defs' => $bugs, 'hints' => $hints, 'intro' => $intro, 'mode' => 'mark'] + $extra;
}

/** Перемішує рядки й переносить координати поломок. */
function bv_table_shuffle(BvRng $rng, array $rows, array $bugs): array
{
    $order = $rng->shuffle(array_keys($rows));
    $pos = array_flip($order);   // старий індекс → новий
    $out = [];
    foreach ($order as $old) {
        $out[] = $rows[$old];
    }
    foreach ($bugs as &$b) {
        $b['cells'] = array_map(static fn($c) => [$pos[$c[0]], $c[1]], $b['cells']);
    }

    return [$out, $bugs];
}

/** 3.1 «Не та дата» (expected): неможлива дата і повернення раніше видачі. */
function bv_table_gen_date(BvRng $rng, int $missionId): array
{
    $rows = bv_table_loans($rng, 6);
    // неможлива дата повернення в рядку 0
    $m = $rng->pick([2, 4, 6, 9, 11]);
    $badDay = $m === 2 ? $rng->pick([29, 30]) : 31;
    $issue = new DateTimeImmutable(sprintf('2026-%02d-%02d', $m, $rng->int(10, 20)));
    $rows[0][2] = bv_dm($issue);
    $rows[0][3] = sprintf('%02d.%02d', $badDay, $m);
    // повернення раніше видачі в рядку 1
    [$i, $r] = bv_table_loan($rng, $rng->int(3, 10));
    $rows[1][2] = bv_dm($r);
    $rows[1][3] = bv_dm($i);
    $bugs = [
        ['id' => 'impossible', 'cells' => [[0, 3]], 'card' => ['title' => 'Неможлива дата', 'inp' => "«{$rows[0][0]}» · повернути {$rows[0][3]}",
            'got' => "У таблиці стоїть {$rows[0][3]}.", 'exp' => 'Справжня дата: у ' . BV_MONTH_GEN[$m] . ' лише ' . BV_MONTH_DAYS[$m] . ' днів.',
            'say' => 'У ' . BV_MONTH_GEN[$m] . ' ' . BV_MONTH_DAYS[$m] . " днів, {$rows[0][3]} не буває. Очікували справжню дату — отримали неможливу."]],
        ['id' => 'order', 'cells' => [[1, 2], [1, 3]], 'card' => ['title' => 'Повернення раніше видачі', 'inp' => "«{$rows[1][0]}» · видано {$rows[1][2]}, повернути {$rows[1][3]}",
            'got' => 'Дата повернення раніша за дату видачі.', 'exp' => 'Дата повернення — після дати видачі.',
            'say' => 'Повернути книжку раніше, ніж її видали, не можна. Очікувано: дата повернення після дати видачі.']],
    ];
    [$rows, $bugs] = bv_table_shuffle($rng, $rows, $bugs);

    return bv_table_rules($rng, 'date', 'Видача книжок. Книжку видають на 14 днів.', ['Книжка', 'Читач', 'Видано', 'Повернути'], $rows, $bugs,
        ['Перевірте кожну дату: чи буває такий день у цьому місяці?', 'Порівняйте «Видано» і «Повернути» в одному рядку: що має бути раніше?'],
        'Привіт! Я майстер Гайка. У бібліотеці всі видачі записують у таблицю. Хтось наплутав із <b>датами</b>. '
        . 'Позначте клітинки, яких не може бути, і натисніть <b>«Перевірити позначене»</b>. Знайдіть <b>поломку</b>.');
}

/** 3.2 «Двійник» (actual): повний дубль рядка й один інвентарний номер у двох різних книжок. */
function bv_table_gen_twin(BvRng $rng, int $missionId): array
{
    $books = array_slice($rng->shuffle(BV_BOOKS), 0, 6);
    $nums = bv_distinct($rng, 101, 299, 6);
    $month = $rng->int(2, 10);
    $rows = [];
    foreach (array_slice($books, 0, 5) as $k => $b) {
        $rows[] = [(string) $nums[$k], $b, $rng->pick(BV_NAMES), bv_dm(bv_table_loan($rng, $month)[0])];
    }
    $rows[] = $rows[0];                                                           // 5: повний двійник рядка 0
    $rows[] = [(string) $nums[1], $books[5], $rng->pick(BV_NAMES), bv_dm(bv_table_loan($rng, $month)[0])];   // 6: номер рядка 1
    $allCells = static fn(int $r) => [[$r, 0], [$r, 1], [$r, 2], [$r, 3]];
    $bugs = [
        ['id' => 'twin', 'cells' => array_merge($allCells(0), $allCells(5)), 'card' => ['title' => 'Двійник рядка',
            'inp' => "«{$rows[0][1]}» · № {$rows[0][0]}", 'got' => 'Той самий запис стоїть у таблиці двічі.',
            'exp' => 'Одна видача — один рядок.', 'say' => 'Фактично книжок на полиці менше, ніж рядків: один рядок — двійник із тим самим номером.']],
        ['id' => 'same_no', 'cells' => [[1, 0], [6, 0]], 'card' => ['title' => 'Один номер — дві книжки', 'inp' => "№ {$rows[1][0]}",
            'got' => "«{$rows[1][1]}» і «{$rows[6][1]}» мають той самий номер.", 'exp' => 'У кожної книжки свій інвентарний номер.',
            'say' => 'Один номер — одна книжка. Дві різні книжки з одним номером — плутанина в каталозі.']],
    ];
    [$rows, $bugs] = bv_table_shuffle($rng, $rows, $bugs);

    return bv_table_rules($rng, 'twin', 'Каталог видачі. На полиці 6 книжок, а в таблиці 7 рядків.', ['№', 'Книжка', 'Читач', 'Видано'], $rows, $bugs,
        ['Порівняйте рядки між собою: чи немає двох однакових?', 'Подивіться на стовпець «№»: у кожної книжки має бути свій номер.'],
        'Привіт! Я майстер Гайка. На полиці менше книжок, ніж рядків у таблиці. Десь ховається <b>двійник</b>. '
        . 'Позначте клітинки, що суперечать одна одній, і натисніть <b>«Перевірити позначене»</b>. Знайдіть <b>поломку</b>.');
}

/** 3.3 «Порожня клітинка» (missing): дві порожні клітинки в різних рядках і стовпцях. */
function bv_table_gen_empty(BvRng $rng, int $missionId, int $n = 2): array
{
    $rows = bv_table_loans($rng, 6);
    $cols = ['Книжка', 'Читач', 'Видано', 'Повернути'];
    $cs = array_slice($rng->shuffle([1, 2, 3]), 0, max(1, min($n, 3)));   // різні стовпці, по одному в рядках 0, 1, 2
    $say = [1 => 'Книжку видали, але не записали кому. Бракує даних — її не знайдуть.', 2 => 'Без дати видачі не порахувати, коли книжку повертати.',
        3 => 'Без дати повернення ніхто не нагадає про книжку.'];
    $bugs = [];
    foreach ($cs as $r => $c) {
        $id = 'empty_' . chr(97 + $r);
        $bugs[] = ['id' => $id, 'cells' => [[$r, $c]], 'card' => ['title' => "Порожня клітинка «{$cols[$c]}»", 'inp' => "«{$rows[$r][0]}» · {$cols[$c]}: (порожньо)",
            'got' => 'Книжку видали без цього запису.', 'exp' => "Заповнити «{$cols[$c]}».", 'say' => $say[$c]]];
        $rows[$r][$c] = '';
    }
    [$rows, $bugs] = bv_table_shuffle($rng, $rows, $bugs);

    return bv_table_rules($rng, 'empty', 'Видача книжок. Кожну клітинку треба заповнити.', $cols, $rows, $bugs,
        ['Пройдіться по кожному рядку: чи все в ньому записано?', 'Порожню клітинку легко пропустити оком — дивіться повільно, стовпець за стовпцем.'],
        'Привіт! Я майстер Гайка. Бібліотекарка поспішала й дещо <b>не записала</b>. Позначте клітинки, де бракує даних, '
        . 'і натисніть <b>«Перевірити позначене»</b>. Знайдіть <b>поломку</b>.');
}

/** 3.4 «Переплутані стовпці» (mismatch): у двох рядках значення стоять не у своїх стовпцях. */
function bv_table_gen_swap(BvRng $rng, int $missionId, int $n = 2): array
{
    $books = array_slice($rng->shuffle(BV_BOOKS), 0, 6);
    $rows = [];
    foreach ($books as $b) {
        $rows[] = [$b, $rng->pick(BV_AUTHORS), (string) $rng->int(2005, 2025), $rng->pick(BV_NAMES)];
    }
    $cols = ['Книжка', 'Автор', 'Рік', 'Читач'];
    $pairs = $rng->shuffle([[1, 2], [2, 3], [1, 3]]);
    $bugs = [];
    foreach (array_slice($pairs, 0, max(1, min($n, 3))) as $r => [$a, $b]) {
        $id = 'swap_' . chr(97 + $r);
        [$rows[$r][$a], $rows[$r][$b]] = [$rows[$r][$b], $rows[$r][$a]];
        $bugs[] = ['id' => $id, 'cells' => [[$r, $a], [$r, $b]], 'card' => ['title' => 'Переплутані стовпці',
            'inp' => "«{$rows[$r][0]}»: {$cols[$a]} = {$rows[$r][$a]}", 'got' => "У «{$cols[$a]}» стоїть {$rows[$r][$a]}, а в «{$cols[$b]}» — {$rows[$r][$b]}.",
            'exp' => 'Кожне значення — у своєму стовпці.', 'say' => "Значення не відповідають своїм стовпцям: «{$cols[$a]}» і «{$cols[$b]}» помінялися місцями."]];
    }
    [$rows, $bugs] = bv_table_shuffle($rng, $rows, $bugs);

    return bv_table_rules($rng, 'swap', 'Каталог бібліотеки.', $cols, $rows, $bugs,
        ['Перевірте, чи в кожному стовпці стоїть те, що написано в заголовку.', 'Рік — це число, автор — імʼя й прізвище, читач — імʼя.'],
        'Привіт! Я майстер Гайка. Хтось записував каталог дуже поспіхом і <b>переплутав стовпці</b>. Позначте клітинки, '
        . 'де стоїть не те, і натисніть <b>«Перевірити позначене»</b>. Знайдіть <b>поломку</b>.');
}

/** 3.5 «Історія бібліотекаря» (report): 6 сюжетів, гравець пише «Очікувано / Фактично». */
function bv_table_gen_report(BvRng $rng, int $missionId): array
{
    $name = $rng->pick(['Ніна', 'Ольга', 'Тамара', 'Галина', 'Віра']);
    $story = $rng->int(0, 5);
    $cols = [];
    $rows = [];
    switch ($story) {
        case 0:   // полиця
            $n = $rng->int(8, 12);
            $cols = ['№', 'Книжка'];
            foreach (array_slice($rng->shuffle(BV_BOOKS), 0, $n - 1) as $k => $b) {
                $rows[] = [(string) ($k + 1), $b];
            }
            [$caption, $exp, $act, $unit] = ["Бібліотекарка {$name}: «За списком на полиці має бути " . bv_pl($n, 'книжка', 'книжки', 'книжок') . '». Ось що стоїть на полиці:', $n, $n - 1, 'книжок'];
            break;
        case 1:   // розклад
            $open = $rng->pick(['8:00', '9:00', '10:00']);
            $late = str_replace(':00', ':30', $open);
            $cols = ['День', 'Замок відчинив'];
            $bad = $rng->int(0, 4);
            foreach (['Понеділок', 'Вівторок', 'Середа', 'Четвер', 'Пʼятниця'] as $k => $d) {
                $rows[] = [$d, $k === $bad ? $late : $open];
            }
            [$caption, $exp, $act, $unit] = ["За розкладом читальна зала відкривається о {$open}. Журнал електронного замка:", $open, $late, 'час'];
            break;
        case 2:   // черга
            $n = $rng->int(4, 7);
            $cols = ['Місце', 'Читач'];
            foreach (array_slice($rng->shuffle(BV_NAMES), 0, $n - 1) as $k => $p) {
                $rows[] = [(string) ($k + 1), $p];
            }
            [$caption, $exp, $act, $unit] = ['На «Острів годинників» записалися ' . bv_pl($n, 'читач', 'читачі', 'читачів') . '. Черга в таблиці:', $n, $n - 1, 'читачів'];
            break;
        case 3:   // штраф
            $per = $rng->int(2, 4);
            $cols = ['Читач', 'Днів запізнення', 'Штраф, грн'];
            $bad = $rng->int(0, 3);
            $expV = $actV = 0;
            foreach (array_slice($rng->shuffle(BV_NAMES), 0, 4) as $k => $p) {
                $days = $rng->int(1, 6);
                $fine = $days * $per;
                if ($k === $bad) {
                    $expV = $fine;
                    $actV = $fine + $rng->pick([-1, 1]) * $rng->int(1, 2);
                    $fine = $actV;
                }
                $rows[] = [$p, (string) $days, (string) $fine];
            }
            [$caption, $exp, $act, $unit] = ["Штраф — {$per} грн за кожен день запізнення. Журнал штрафів:", $expV, $actV, 'грн'];
            break;
        case 4:   // температура
            $norm = $rng->int(16, 20);
            $cols = ['Час', 'Температура, °C'];
            $bad = $rng->int(0, 4);
            $hot = $norm + $rng->int(4, 8);
            foreach (['8:00', '10:00', '12:00', '14:00', '16:00'] as $k => $t) {
                $rows[] = [$t, (string) ($k === $bad ? $hot : $norm)];
            }
            [$caption, $exp, $act, $unit] = ["В архіві рідкісних книжок має бути рівно {$norm} °C. Журнал датчика:", $norm, $hot, '°C'];
            break;
        default:  // стільці
            $need = $rng->int(16, 24);
            $cols = ['Ряд', 'Стільців'];
            $counts = [intdiv($need, 4), intdiv($need, 4), intdiv($need, 4), $need - 3 * intdiv($need, 4)];
            $short = $rng->int(1, 2);
            $counts[$rng->int(0, 3)] -= $short;
            foreach ($counts as $k => $c) {
                $rows[] = [(string) ($k + 1), (string) $c];
            }
            [$caption, $exp, $act, $unit] = ['У читальній залі має бути ' . bv_pl($need, 'стілець', 'стільці', 'стільців') . '. Лічильник по рядах:', $need, $need - $short, 'стільців'];
    }

    return ['type' => 'table_scene', 'kind' => 'report', 'mode' => 'report', 'caption' => $caption, 'cols' => $cols, 'rows' => $rows,
        'bugs' => ['report'], 'expected' => (string) $exp, 'actual' => (string) $act,
        'bug_defs' => [['id' => 'report', 'cells' => [], 'card' => ['title' => 'Звіт для майстра', 'inp' => "Очікувано: {$exp}. Фактично: {$act}.",
            'got' => "Фактично: {$act}" . ($unit === 'час' ? '' : " ({$unit})") . '.', 'exp' => "Очікувано: {$exp}.",
            'say' => 'Хороший запис поломки каже, чого чекали і що побачили, без догадок. Це й є короткий звіт — report.']]],
        'hints' => ['Очікувано — те, що мало бути за правилом. Фактично — те, що ви бачите в таблиці.', 'Порахуйте рядки або знайдіть рядок, що відрізняється від правила.'],
        'intro' => 'Привіт! Я майстер Гайка. Бібліотекарка помітила, що щось не так. Прочитайте таблицю й запишіть <b>короткий звіт</b>: '
            . 'що мало бути (<b>очікувано</b>) і що є насправді (<b>фактично</b>). Знайдіть <b>поломку</b>.'];
}

// ---------- Що бачить браузер -----------------------------------------------------------------------------------

function bv_table_public(array $r): array
{
    return ['type' => 'table_scene', 'kind' => $r['kind'], 'mode' => $r['mode'], 'caption' => $r['caption'], 'cols' => $r['cols'],
        'rows' => $r['rows'], 'total' => count($r['bugs']), 'min_found' => (int) $r['min_found'], 'intro' => $r['intro'],
        'hints' => count($r['hints']), 'max_actions' => bv_scene_max_actions(), 'max_input' => bv_scene_max_input(),
        'max_marks' => bv_table_max_marks(), 'max_wrong' => bv_table_max_wrong()];
}

function bv_table_bug_card(array $r, string $bug): array
{
    foreach ($r['bug_defs'] as $b) {
        if ($b['id'] === $bug) {
            return $b['card'];
        }
    }

    return ['title' => 'Поломка', 'inp' => '', 'got' => '', 'exp' => '', 'say' => ''];
}

/** Очищення вводу: check → список [рядок, стовпець] (унікальні, у межах таблиці, ≤ max_marks); report → {expected, actual}. */
function bv_table_clean(array $r, string $op, mixed $input): ?array
{
    if (!is_array($input)) {
        return null;
    }
    if ($op === 'report') {
        if (array_diff(array_keys($input), ['expected', 'actual']) !== []) {
            return null;
        }
        $e = bv_scene_clean_input($input['expected'] ?? '');
        $a = bv_scene_clean_input($input['actual'] ?? '');

        return $e === null || $a === null ? null : ['expected' => $e, 'actual' => $a];
    }
    if (count($input) > bv_table_max_marks() || !array_is_list($input)) {
        return null;
    }
    $out = [];
    foreach ($input as $c) {
        if (!is_array($c) || count($c) !== 2 || !is_int($c[0] ?? null) || !is_int($c[1] ?? null)
            || $c[0] < 0 || $c[0] >= count($r['rows']) || $c[1] < 0 || $c[1] >= count($r['cols'])) {
            return null;
        }
        $out[$c[0] . ':' . $c[1]] = [$c[0], $c[1]];
    }

    return array_values($out);
}

/** «9:30», «09.30», «9 30» → хвилини; число → ціле; інакше — рядок без пробілів у нижньому регістрі. */
function bv_table_norm(string $v): string
{
    $v = trim(mb_strtolower($v));
    if (preg_match('/^(\d{1,2})[:.\s](\d{2})$/', $v, $m) === 1) {
        return 't' . ((int) $m[1] * 60 + (int) $m[2]);
    }
    if (preg_match('/^-?\d+/', $v, $m) === 1) {
        return 'n' . (int) $m[0];
    }

    return 's' . preg_replace('/\s+/u', '', $v);
}

/**
 * Дія в таблиці: check (позначені клітинки) або report (звіт). Реакція: tone, text, result (bug|ok|info|useless),
 * marks [{r, c, res: bug|repeat|wrong}], bug/bugs, wrong_left, locked.
 * @return array{0: array, 1: array}
 */
function bv_scene_table_act(array $r, array $state, string $op, array $in): array
{
    $react = ['tone' => 'ok', 'text' => '', 'result' => 'ok', 'marks' => [], 'wallet' => null];
    $hits = [];
    $wrongMax = bv_table_max_wrong();
    if ($r['mode'] === 'report') {
        if ($op !== 'report') {
            return [['tone' => 'info', 'text' => 'Тут потрібно записати звіт: очікувано й фактично.', 'result' => 'info', 'wallet' => null], $state];
        }
        $e = bv_table_norm($in['expected'] ?? '');
        $a = bv_table_norm($in['actual'] ?? '');
        $we = bv_table_norm($r['expected']);
        $wa = bv_table_norm($r['actual']);
        if (trim((string) ($in['expected'] ?? '')) === '' || trim((string) ($in['actual'] ?? '')) === '') {
            $react = ['tone' => 'info', 'text' => 'Заповніть обидва поля звіту: очікувано і фактично.', 'result' => 'info'];
        } elseif ($e === $we && $a === $wa) {
            $react['text'] = 'Майстер прочитав звіт: усе зрозуміло, поломку записано.';
            $hits[] = 'report';
        } elseif ($e === $wa && $a === $we) {
            $react = ['tone' => 'ok', 'text' => 'Навпаки! Очікувано — те, що мало бути за правилом, фактично — те, що є насправді.', 'result' => 'useless'];
        } else {
            $react = ['tone' => 'ok', 'text' => 'Майстер не зрозумів звіт: числа не збігаються з тим, що в таблиці. Перевірте ще раз.', 'result' => 'useless'];
        }
    } elseif ($op !== 'check') {
        return [['tone' => 'info', 'text' => 'Позначте клітинки й натисніть «Перевірити позначене».', 'result' => 'info', 'wallet' => null], $state];
    } elseif ((int) ($state['wr'] ?? 0) >= $wrongMax) {
        $react = ['tone' => 'info', 'text' => 'Забагато хибних позначок. Майстер просить почати з новою таблицею.', 'result' => 'info', 'locked' => true];
    } elseif ($in === []) {
        $react = ['tone' => 'info', 'text' => 'Спочатку позначте клітинку, яка здається неправильною.', 'result' => 'info'];
    } else {
        $wrong = 0;
        foreach ($in as [$row, $col]) {
            $res = 'wrong';
            foreach ($r['bug_defs'] as $b) {
                if (in_array([$row, $col], $b['cells'], true)) {
                    $res = in_array($b['id'], $state['f'], true) || in_array($b['id'], $hits, true) ? 'repeat' : 'bug';
                    if ($res === 'bug') {
                        $hits[] = $b['id'];
                    }
                    break;
                }
            }
            if ($res === 'wrong') {
                $wrong++;
            }
            $react['marks'][] = ['r' => $row, 'c' => $col, 'res' => $res];
        }
        $state['wr'] = (int) ($state['wr'] ?? 0) + $wrong;
        $state['u'] = (int) $state['u'] + $wrong;
        $parts = [];
        if ($hits !== []) {
            $parts[] = 'Так, тут справді помилка!';
        }
        if ($wrong > 0) {
            $parts[] = "Хибних позначок: {$wrong} — там усе гаразд.";
        }
        if ($hits === [] && $wrong === 0) {
            $parts[] = 'Цю помилку ви вже знайшли.';
        }
        $react['text'] = implode(' ', $parts);
        $react['result'] = $hits !== [] ? 'bug' : ($wrong > 0 ? 'useless' : 'ok');
        $react['wrong_left'] = max(0, $wrongMax - (int) $state['wr']);
        $react['locked'] = (int) $state['wr'] >= $wrongMax;
    }
    $new = [];
    foreach ($hits as $b) {
        if (!in_array($b, $state['f'], true)) {
            $state['f'][] = $b;
            $new[] = bv_table_bug_card($r, $b);
        }
    }
    if ($new !== []) {
        $react['tone'] = 'bad';
        $react['result'] = 'bug';
        $react['bug'] = $new[0];
        $react['bugs'] = $new;
        $react['repeat_bug'] = false;
    }
    if ($r['mode'] === 'report' && $react['result'] === 'useless') {
        $state['u'] = (int) $state['u'] + 1;
    }
    $react['wallet'] = null;
    $state['a'][] = ['o' => $op, 'i' => mb_substr(json_encode($in, JSON_UNESCAPED_UNICODE), 0, 200), 'r' => $react['result'], 'b' => $hits[0] ?? null];

    return [$react, $state];
}
