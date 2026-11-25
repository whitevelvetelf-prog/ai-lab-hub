<?php

declare(strict_types=1);

/**
 * Багвіль — сцена «Пошта» (form_scene, Етап B): справжній бланк із полями. Гравець змінює заповнені дані й натискає
 * «Надіслати»; пошта (сервер) або відхиляє бланк із повідомленням біля поля, або приймає й записує в журнал.
 *
 * Правильні правила перевірки полів (bv_form_errors) однакові для всіх місій. Поломка варіанта = категорія помилки,
 * яку поломана пошта «не помічає» (rules.bugs). Якщо всі помилки бланка — непомічені, бланк прийнято, і кожна така
 * категорія — знайдена поломка. Якщо лишилася хоч одна помічена — відмова лише з поміченими (як справжня форма).
 * Категорії й перелік поломок у браузер не потрапляють (bv_form_public).
 * Місії й ідеї — з документа «Багвіль — приклади варіантів Глави 1» (рівень 2); тексти розборів звідти ж.
 */

require_once __DIR__ . '/bv-config.php';
require_once __DIR__ . '/bv-content.php';

const BV_LATIN_NAMES = ['Олег' => 'oleh', 'Марта' => 'marta', 'Ліна' => 'lina', 'Ірина' => 'iryna', 'Тарас' => 'taras', 'Софія' => 'sofiia',
    'Іван' => 'ivan', 'Дана' => 'dana', 'Петро' => 'petro', 'Оксана' => 'oksana', 'Марко' => 'marko', 'Надія' => 'nadiia', 'Роман' => 'roman'];

/** Літери, схожі на цифри (2.3): клас → [символи, цифра, назва для картки]. */
const BV_LOOKALIKES = [
    'phone_o' => [['O', 'o', 'О', 'о'], '0', 'Літера O замість нуля', 'Літера O схожа на нуль, але SMS на такий номер не прийде.'],
    'phone_l' => [['l', 'I', '|'], '1', 'Літера l замість одиниці', 'Мала l схожа на одиницю, але це літера — SMS не прийде.'],
    'phone_z' => [['З', 'з'], '3', 'Літера З замість трійки', 'Літера З схожа на трійку, але номер із літерою не існує.'],
    'phone_s' => [['S', 's'], '5', 'Літера S замість пʼятірки', 'Літера S схожа на пʼятірку, але номер із літерою не існує.'],
    'phone_b' => [['B', 'В'], '8', 'Літера B замість вісімки', 'Літера B схожа на вісімку, але номер із літерою не існує.'],
];

/** Категорії адрес пошти (2.2): назва, «мало бути», розбір. */
const BV_EMAIL_BUGS = [
    'email_no_at' => ['Адреса без @', 'Відхилити: в адресі пошти має бути знак @.', 'У адресі пошти має бути знак @. Тут його немає, але форма її прийняла.'],
    'email_at_word' => ['(at) замість @', 'Відхилити: «(at)» — це не знак @.', '«(at)» — це не знак @. Лист на таку адресу не дійде.'],
    'email_double_at' => ['Два знаки @', 'Відхилити: знак @ в адресі лише один.', 'Два знаки @ — такої адреси не буває, а форма її прийняла.'],
    'email_space' => ['Пробіл в адресі', 'Відхилити: в адресі пошти не буває пробілів.', 'В адресі пошти не буває пробілів, а форма її прийняла.'],
];

function bv_form_generators(): array
{
    return ['form_required' => 'bv_form_gen_required', 'form_email' => 'bv_form_gen_email', 'form_phone' => 'bv_form_gen_phone',
        'form_length' => 'bv_form_gen_length', 'form_duplicate' => 'bv_form_gen_duplicate'];
}

// ---------- Поля й бланки ---------------------------------------------------------------------------------------

function bv_f(string $key, string $label, bool $req, string $kind, string $value, array $extra = []): array
{
    return ['key' => $key, 'label' => $label, 'req' => $req, 'kind' => $kind, 'value' => $value] + $extra;
}

function bv_form_person(BvRng $rng): array
{
    $name = $rng->pick(array_keys(BV_LATIN_NAMES));

    return [$name, BV_LATIN_NAMES[$name], $rng->pick(BV_SURNAMES)];
}

function bv_form_phone(BvRng $rng): string
{
    return '+380 ' . $rng->pick(['67', '50', '63', '93', '98', '66']) . ' ' . $rng->int(100, 999) . ' ' . $rng->int(10, 99) . ' ' . $rng->int(10, 99);
}

/** Основа правил бланка. */
function bv_form_rules(BvRng $rng, string $kind, string $title, string $done, array $fields, array $bugs, array $hints, string $intro, array $extra = []): array
{
    return ['type' => 'form_scene', 'kind' => $kind, 'title' => $title, 'done' => $done, 'fields' => $fields, 'bugs' => $bugs,
        'hints' => $hints, 'intro' => $intro, 'no_base' => $rng->int(4400, 4900)] + $extra;
}

/** 2.1 «Порожнє поле» (required): одне обовʼязкове поле не перевіряють на порожнечу, інше — на «лише пробіли». */
function bv_form_gen_required(BvRng $rng, int $missionId): array
{
    [$name, $latin, $sur] = bv_form_person($rng);
    $city = $rng->pick(BV_CITIES);
    $forms = [
        ['Посилка', 'Посилку відправлено', [bv_f('to', 'Отримувач', true, 'text', "{$name} {$sur}"), bv_f('phone', 'Телефон', true, 'phone', bv_form_phone($rng)),
            bv_f('city', 'Місто', true, 'text', $city), bv_f('office', 'Відділення', true, 'text', '№ ' . $rng->int(1, 120)),
            bv_f('note', 'Примітка', false, 'text', 'Обережно, скло')]],
        ['Відправник', 'Заявку прийнято', [bv_f('name', 'Імʼя', true, 'text', $name), bv_f('email', 'Email', true, 'email', "{$latin}@poshta.bv"),
            bv_f('addr', 'Адреса', true, 'text', 'вул. Липова, ' . $rng->int(1, 80)), bv_f('city', 'Місто', true, 'text', $city),
            bv_f('note', 'Примітка', false, 'text', 'Дзвонити після 18:00')]],
        ['Підписка на газету', 'Підписку оформлено', [bv_f('sur', 'Прізвище', true, 'text', $sur), bv_f('city', 'Місто', true, 'text', $city),
            bv_f('index', 'Індекс', true, 'index', (string) $rng->int(10000, 99999)), bv_f('months', 'Місяців', true, 'range', (string) $rng->int(1, 12), ['min' => 1, 'max' => 12]),
            bv_f('note', 'Побажання', false, 'text', 'Без реклами')]],
    ];
    [$title, $done, $fields] = $rng->pick($forms);
    $req = array_values(array_map(static fn($f) => $f['key'], array_filter($fields, static fn($f) => $f['req'])));
    $req = $rng->shuffle($req);

    return bv_form_rules($rng, 'required', $title, $done, $fields, ['empty:' . $req[0], 'blank:' . $req[1]],
        ['Лишіть порожнім кожне поле із зірочкою по черзі й подивіться, що скаже пошта.', 'А якщо в обовʼязкове поле вписати лише пробіли?'],
        'Привіт! Я майстер Гайка. Пошта Багвіля має помічати, коли бланк заповнено не до кінця. Поля із зірочкою * — <b>обовʼязкові</b>. '
        . 'Змінюйте бланк, надсилайте й шукайте, де пошта <b>пропускає</b> те, що мала зупинити. Знайдіть <b>поломку</b>.');
}

/** 2.2 «Дивна адреса» (valid): дві з чотирьох неправильних адрес пошта приймає. */
function bv_form_gen_email(BvRng $rng, int $missionId, int $n = 2): array
{
    [$name, $latin] = bv_form_person($rng);
    $bugs = array_slice($rng->shuffle(array_keys(BV_EMAIL_BUGS)), 0, max(1, min($n, count(BV_EMAIL_BUGS))));

    return bv_form_rules($rng, 'email', 'Сповіщення про посилку', 'Сповіщення ввімкнено', [bv_f('name', 'Імʼя', true, 'text', $name),
        bv_f('email', 'Email', true, 'email', "{$latin}@poshta.bv"), bv_f('city', 'Місто', true, 'text', $rng->pick(BV_CITIES))], $bugs,
        ['Правильна адреса має вигляд імʼя@poshta.bv. Спробуйте зіпсувати її по-різному.', 'Без знака @, «(at)» замість нього, два @, пробіл — що з цього пошта пропустить?'],
        'Привіт! Я майстер Гайка. На пошту приходять сповіщення, але тільки якщо адреса <b>правильна</b>. Пошта має відхиляти дивні адреси. '
        . 'Пограйтеся з полем Email і знайдіть, яку <b>неправильну</b> адресу вона прийме. Знайдіть <b>поломку</b>.');
}

/** 2.3 «Літери замість цифр» (invalid): дві літери, схожі на цифри, пошта вважає цифрами. */
function bv_form_gen_phone(BvRng $rng, int $missionId, int $n = 2): array
{
    [$name, , $sur] = bv_form_person($rng);
    $bugs = array_slice($rng->shuffle(array_keys(BV_LOOKALIKES)), 0, max(1, min($n, count(BV_LOOKALIKES))));

    return bv_form_rules($rng, 'phone', 'SMS про посилку', 'SMS-сповіщення ввімкнено', [bv_f('to', 'Отримувач', true, 'text', "{$name} {$sur}"),
        bv_f('phone', 'Телефон', true, 'phone', bv_form_phone($rng)), bv_f('office', 'Відділення', true, 'text', '№ ' . $rng->int(1, 120))], $bugs,
        ['У номері телефону лише цифри. Деякі літери дуже схожі на цифри.', 'Спробуйте замінити одну цифру схожою літерою: O, l, З, S, B.'],
        'Привіт! Я майстер Гайка. Пошта надсилає SMS про посилку, тому номер телефону має складатися <b>лише з цифр</b>. '
        . 'Явні літери пошта відхиляє, але чи помітить вона <b>хитрі</b>? Знайдіть <b>поломку</b>.');
}

/** 2.4 «Задовге імʼя» (length): межа L, але пошта насправді перевіряє більшу межу L2. */
function bv_form_gen_length(BvRng $rng, int $missionId): array
{
    [$name, , $sur] = bv_form_person($rng);
    $limit = $rng->int(10, 20);
    $real = $limit + $rng->int(3, 6);
    $field = $rng->int(0, 1) === 0 ? bv_f('name', 'Імʼя', true, 'text', $name, ['maxlen' => $limit]) : bv_f('sur', 'Прізвище', true, 'text', $sur, ['maxlen' => $limit]);

    return bv_form_rules($rng, 'length', 'Бирка на посилці', 'Бирку надруковано', [$field, bv_f('city', 'Місто', true, 'text', $rng->pick(BV_CITIES)),
        bv_f('kg', 'Вага, кг', true, 'range', (string) $rng->int(1, 20), ['min' => 1, 'max' => 30])], ['long:' . $field['key']],
        ["Порахуйте: дозволено {$limit} символів. Впишіть рівно {$limit}, а потім на один більше.", 'Довге імʼя легко скласти з дефісом: Анна-Марія-Христина.'],
        'Привіт! Я майстер Гайка. На бирці посилки мало місця, тому на бланку написано, скільки символів <b>можна</b>. '
        . 'Перевірте, чи пошта справді тримає цю межу. Знайдіть <b>поломку</b>.', ['limit' => $limit, 'real_limit' => $real]);
}

/** 2.5 «Двічі натиснули» (duplicate): сюжет із 6 (як пул прикладів), повторне надсилання тих самих даних — дубль. */
function bv_form_gen_duplicate(BvRng $rng, int $missionId): array
{
    [$name, , $sur] = bv_form_person($rng);
    $person = "{$name} {$sur}";
    $stories = [
        ['Посилка', 'Посилку прийнято', 'Пані Галина надсилала посилку, а екран довго думав.', [bv_f('from', 'Відправник', true, 'text', $person),
            bv_f('city', 'Куди', true, 'text', $rng->pick(BV_CITIES)), bv_f('kg', 'Вага, кг', true, 'range', (string) $rng->int(1, 9), ['min' => 1, 'max' => 30])]],
        ['Замовлення для школи', 'Рахунок виставлено', 'Школа замовляє одну коробку крейди.', [bv_f('school', 'Школа', true, 'text', 'Школа № ' . $rng->int(1, 40)),
            bv_f('item', 'Товар', true, 'text', 'Крейда, 1 коробка'), bv_f('sum', 'Сума, грн', true, 'range', (string) (10 * $rng->int(5, 30)), ['min' => 1, 'max' => 5000])]],
        ['Запис до лікаря', 'Вас записано', 'У поліклініці записуються через пошту Багвіля.', [bv_f('patient', 'Пацієнт', true, 'text', $person),
            bv_f('doctor', 'Лікар', true, 'text', $rng->pick(['Терапевт', 'Окуліст', 'Стоматолог'])), bv_f('time', 'Час', true, 'text', $rng->int(9, 16) . ':' . $rng->pick(['00', '30']))]],
        ['Переказ', 'Переказ відправлено', 'Онук надсилає бабусі гроші на свято.', [bv_f('to', 'Кому', true, 'text', 'Ганна ' . $sur),
            bv_f('city', 'Місто', true, 'text', $rng->pick(BV_CITIES)), bv_f('sum', 'Сума, грн', true, 'range', (string) (50 * $rng->int(2, 20)), ['min' => 1, 'max' => 5000])]],
        ['Заявка на гурток', 'Заявку прийнято', 'Батьки записують дитину на гурток.', [bv_f('child', 'Дитина', true, 'text', $person),
            bv_f('club', 'Гурток', true, 'text', $rng->pick(['Шахи', 'Малювання', 'Робототехніка', 'Танці'])), bv_f('phone', 'Телефон батьків', true, 'phone', bv_form_phone($rng))]],
        ['Підписка на газету', 'Підписку оформлено', 'Дідусь оформлює підписку на газету.', [bv_f('sur', 'Прізвище', true, 'text', $sur),
            bv_f('index', 'Індекс', true, 'index', (string) $rng->int(10000, 99999)), bv_f('months', 'Місяців', true, 'range', (string) $rng->int(1, 12), ['min' => 1, 'max' => 12])]],
    ];
    [$title, $done, $story, $fields] = $rng->pick($stories);

    return bv_form_rules($rng, 'duplicate', $title, $done, $fields, ['dup'],
        ['Що буде, якщо натиснути «Надіслати» ще раз, нічого не змінюючи?', 'Після кожного натискання дивіться в журнал пошти: скільки там записів?'],
        'Привіт! Я майстер Гайка. ' . $story . ' Екран пошти інколи довго думає, і люди натискають кнопку <b>ще раз</b>. '
        . 'Одна заявка має бути записана <b>один раз</b>. Перевірте, чи це так. Знайдіть <b>поломку</b>.');
}

// ---------- Що бачить браузер -----------------------------------------------------------------------------------

function bv_form_public(array $r): array
{
    $fields = [];
    foreach ($r['fields'] as $f) {
        $p = ['key' => $f['key'], 'label' => $f['label'], 'req' => $f['req'], 'value' => $f['value'],
            'input' => match ($f['kind']) { 'email' => 'email', 'phone' => 'tel', 'index', 'range' => 'numeric', default => 'text' }];
        $p['note'] = match ($f['kind']) {
            'phone' => 'Формат: +380 XX XXX XX XX',
            'email' => 'Наприклад: name@poshta.bv',
            'index' => '5 цифр',
            'range' => "Від {$f['min']} до {$f['max']}",
            default => isset($f['maxlen']) ? "Не довше {$f['maxlen']} символів" : '',
        };
        if (isset($f['maxlen'])) {
            $p['max'] = (int) $f['maxlen'];   // лічильник символів біля поля (як «скільки символів» у прикладі 2.4)
        }
        $fields[] = $p;
    }

    return ['type' => 'form_scene', 'kind' => $r['kind'], 'title' => $r['title'], 'fields' => $fields, 'total' => count($r['bugs']),
        'min_found' => (int) $r['min_found'], 'intro' => $r['intro'], 'hints' => count($r['hints']), 'max_actions' => bv_scene_max_actions(),
        'max_input' => bv_scene_max_input(), 'note' => 'Зірочкою * позначені обовʼязкові поля.'];
}

// ---------- Правильні правила перевірки -------------------------------------------------------------------------

/** Категорія неправильної адреси пошти або null (правильна). */
function bv_form_email_cat(string $v): ?string
{
    if (preg_match('/^[^\s@()]+@[^\s@()]+\.[^\s@().]+$/u', $v) === 1) {
        return null;
    }
    if (preg_match('/\(at\)|\[at\]|\sat\s/i', $v) === 1) {
        return 'email_at_word';
    }
    if (preg_match('/\s/u', $v) === 1) {
        return 'email_space';
    }
    if (substr_count($v, '@') >= 2) {
        return 'email_double_at';
    }
    if (!str_contains($v, '@')) {
        return 'email_no_at';
    }

    return 'email_other';
}

/** Категорії неправильного телефону: [] — правильний. Схожі на цифри літери — окремі класи (phone_o …). */
function bv_form_phone_cats(string $v): array
{
    $s = (string) preg_replace('/[\s\-()]/u', '', $v);
    $ok = static fn(string $x) => preg_match('/^(\+380\d{9}|0\d{9})$/', $x) === 1;
    if ($ok($s)) {
        return [];
    }
    $classes = [];
    $fixed = $s;
    foreach (BV_LOOKALIKES as $cls => [$chars, $digit]) {
        foreach ($chars as $ch) {
            if (str_contains($fixed, $ch)) {
                $classes[$cls] = true;
                $fixed = str_replace($ch, $digit, $fixed);
            }
        }
    }
    if ($classes !== [] && $ok($fixed)) {
        return array_keys($classes);
    }

    return [preg_match('/\p{L}/u', $s) === 1 ? 'phone_letters' : 'phone_format'];
}

/**
 * Помилки бланка за ПРАВИЛЬНИМИ правилами: list of [категорія, ключ поля, повідомлення].
 * Порожнє необовʼязкове поле — не помилка.
 */
function bv_form_errors(array $r, array $values): array
{
    $errs = [];
    foreach ($r['fields'] as $f) {
        $k = $f['key'];
        $v = (string) ($values[$k] ?? '');
        $t = trim($v);
        $fill = "Заповніть поле «{$f['label']}».";
        if ($t === '') {
            if ($f['req']) {
                $errs[] = [$v === '' ? 'empty:' . $k : 'blank:' . $k, $k, $fill];
            }
            continue;
        }
        if (isset($f['maxlen']) && mb_strlen($t) > (int) $f['maxlen']) {
            $long = isset($r['real_limit']) && mb_strlen($t) <= (int) $r['real_limit'] ? 'long:' : 'toolong:';
            $errs[] = [$long . $k, $k, "«{$f['label']}» — не довше {$f['maxlen']} символів (зараз " . mb_strlen($t) . ').'];
        }
        if ($f['kind'] === 'email' && ($c = bv_form_email_cat($t)) !== null) {
            $errs[] = [$c, $k, 'Адреса пошти має вигляд імʼя@poshta.bv.'];
        }
        if ($f['kind'] === 'phone') {
            foreach (bv_form_phone_cats($t) as $c) {
                $errs[] = [$c, $k, 'Телефон — лише цифри у форматі +380 XX XXX XX XX.'];
            }
        }
        if ($f['kind'] === 'index' && preg_match('/^\d{5}$/', $t) !== 1) {
            $errs[] = ['index:' . $k, $k, 'Індекс — рівно 5 цифр.'];
        }
        if ($f['kind'] === 'range' && (preg_match('/^\d{1,6}$/', $t) !== 1 || (int) $t < (int) $f['min'] || (int) $t > (int) $f['max'])) {
            $errs[] = ['range:' . $k, $k, "«{$f['label']}» — ціле число від {$f['min']} до {$f['max']}."];
        }
    }

    return $errs;
}

/** Відбиток бланка для «чи вже приймали такий самий» (пробіли по краях і регістр не важать). */
function bv_form_sig(array $r, array $values): string
{
    $parts = [];
    foreach ($r['fields'] as $f) {
        $parts[] = mb_strtolower(trim((string) ($values[$f['key']] ?? '')));
    }

    return substr(hash('sha256', implode("\x1f", $parts)), 0, 16);
}

/** Короткий запис у журнал пошти: перші два непорожні поля. */
function bv_form_record_text(array $r, array $values): string
{
    $out = [];
    foreach ($r['fields'] as $f) {
        $v = trim((string) ($values[$f['key']] ?? ''));
        if ($v !== '' && count($out) < 3) {
            $out[] = $v;
        }
    }

    return $out === [] ? '(порожній бланк)' : implode(' · ', $out);
}

/** Очищення бланка з браузера: лише відомі поля, рядки ≤ max_input. null — підробка або задовге. */
function bv_form_clean(array $r, mixed $input): ?array
{
    if (!is_array($input) || count($input) > 12) {
        return null;
    }
    $keys = array_column($r['fields'], 'key');
    $out = [];
    foreach ($input as $k => $v) {
        if (!is_string($k) || !in_array($k, $keys, true)) {
            return null;
        }
        $c = bv_scene_clean_input($v);
        if ($c === null) {
            return null;
        }
        $out[$k] = $c;
    }
    foreach ($keys as $k) {
        $out[$k] ??= '';
    }

    return $out;
}

// ---------- Картки поломок ----------------------------------------------------------------------------------------

function bv_form_label(array $r, string $key): string
{
    foreach ($r['fields'] as $f) {
        if ($f['key'] === $key) {
            return $f['label'];
        }
    }

    return $key;
}

/** Картка «ввели → сталося → мало бути» для категорії поломки. $ctx: values, no. */
function bv_form_bug_card(array $r, string $bug, array $ctx = []): array
{
    [$cat, $key] = array_pad(explode(':', $bug, 2), 2, '');
    $vals = (array) ($ctx['values'] ?? []);
    $got = $r['done'] . (isset($ctx['no']) ? ', № ' . $ctx['no'] : '') . '.';
    if (str_starts_with($bug, 'email_')) {
        [$t, $exp, $say] = BV_EMAIL_BUGS[$bug];

        return ['title' => $t, 'inp' => 'Email: ' . ($vals['email'] ?? '…'), 'got' => 'Пошта прийняла адресу: «' . $got . '»', 'exp' => $exp, 'say' => $say];
    }
    if (str_starts_with($bug, 'phone_')) {
        [, , $t, $say] = BV_LOOKALIKES[$bug];
        $pk = 'phone';

        return ['title' => $t, 'inp' => 'Телефон: ' . ($vals[$pk] ?? '…'), 'got' => 'Номер прийнято: «' . $got . '»',
            'exp' => 'Відхилити: у номері телефону лише цифри.', 'say' => $say];
    }
    $label = bv_form_label($r, $key);

    return match ($cat) {
        'empty' => ['title' => "Порожнє поле «{$label}»", 'inp' => "{$label}*: (порожньо)", 'got' => 'Пошта написала: «' . $got . '»',
            'exp' => "Попросити заповнити обовʼязкове поле «{$label}*».", 'say' => "Обовʼязкове поле «{$label}» порожнє — форма мала попросити його заповнити."],
        'blank' => ['title' => 'Пробіли замість даних', 'inp' => "{$label}*: лише пробіли", 'got' => 'Пошта написала: «' . $got . '»',
            'exp' => "Пробіли — це теж порожньо: попросити заповнити «{$label}*».", 'say' => 'Пробіли не видно, але й даних немає. Обовʼязкове поле лишилося порожнім.'],
        'long' => (static function () use ($r, $vals, $key, $label, $got): array {
            $len = mb_strlen(trim((string) ($vals[$key] ?? '')));

            return ['title' => "Задовге «{$label}»", 'inp' => trim((string) ($vals[$key] ?? '')) . " ({$len})", 'got' => 'Бланк прийнято: «' . $got . '»',
                'exp' => "Відхилити: не довше {$r['limit']} символів.", 'say' => "{$len} більше за {$r['limit']} — на бирці не вміститься, а форма прийняла."];
        })(),
        'dup' => ['title' => 'Двічі прийнято', 'inp' => '«Надіслати» ще раз з тими самими даними', 'got' => 'Друга заявка' . (isset($ctx['no']) ? ' № ' . $ctx['no'] : '') . ' з тими самими даними.',
            'exp' => 'Відповісти «Цю заявку вже прийнято» і не створювати дубль.', 'say' => 'Записи однакові — одна заявка записана двічі. Форма мала не приймати друге натискання.'],
        default => ['title' => 'Поломка', 'inp' => '', 'got' => '', 'exp' => '', 'say' => ''],
    };
}

// ---------- Реакція пошти на одне надсилання ------------------------------------------------------------------------

/**
 * $op 'submit', $values — очищений бланк (bv_form_clean). Реакція: tone, text, result (bug|ok|info), field_errors
 * {ключ: повідомлення}, record {no, text} (якщо прийнято), bug / bugs (нові знахідки), repeat_bug.
 * @return array{0: array, 1: array}
 */
function bv_scene_form_act(array $r, array $state, string $op, array $values): array
{
    $state['rec'] = (array) ($state['rec'] ?? []);
    if ($op !== 'submit') {
        return [['tone' => 'info', 'text' => 'Бланк можна лише надіслати.', 'result' => 'info', 'wallet' => null], $state];
    }
    $errs = bv_form_errors($r, $values);
    $missed = [];
    $shown = [];
    foreach ($errs as [$cat, $key, $msg]) {
        if (in_array($cat, $r['bugs'], true)) {
            $missed[$cat] = true;
        } else {
            $shown[$key] ??= $msg;
        }
    }
    $sig = bv_form_sig($r, $values);
    $prev = null;
    foreach ($state['rec'] as $rec) {
        if ($rec['s'] === $sig) {
            $prev = $rec['n'];
        }
    }
    $react = ['tone' => 'ok', 'text' => '', 'result' => 'ok', 'field_errors' => (object) [], 'record' => null, 'wallet' => null];
    $hits = [];
    if ($shown !== []) {
        $react['text'] = 'Бланк не пішов: ' . reset($shown);
        $react['field_errors'] = $shown;
        $react['accepted'] = false;
    } elseif ($prev !== null && !in_array('dup', $r['bugs'], true)) {
        $react['text'] = "Цю заявку вже прийнято (№ {$prev}). Друга не потрібна.";
        $react['accepted'] = false;
    } else {
        if ($prev !== null) {
            $hits[] = 'dup';
        }
        $hits = array_merge($hits, array_keys($missed));
        $no = (int) $r['no_base'] + count($state['rec']);
        $state['rec'][] = ['n' => $no, 's' => $sig];
        if (count($state['rec']) > 60) {
            array_shift($state['rec']);
        }
        $react['text'] = $r['done'] . ". № {$no}.";
        $react['record'] = ['no' => $no, 'text' => bv_form_record_text($r, $values)];
        $react['accepted'] = true;
        $react['no'] = $no;
    }
    $new = [];
    foreach ($hits as $b) {
        if (!in_array($b, $state['f'], true)) {
            $state['f'][] = $b;
            $new[] = bv_form_bug_card($r, $b, ['values' => $values, 'no' => $react['no'] ?? null]);
        }
    }
    if ($hits !== []) {
        $react['tone'] = 'bad';
        $react['result'] = 'bug';
        $react['repeat_bug'] = $new === [];
        if ($new !== []) {
            $react['bug'] = $new[0];
            $react['bugs'] = $new;
        } else {
            $react['bug_title'] = bv_form_bug_card($r, $hits[0], ['values' => $values])['title'];
        }
    }
    $state['a'][] = ['o' => $op, 'i' => mb_substr(json_encode($values, JSON_UNESCAPED_UNICODE), 0, 400), 'r' => $react['result'], 'b' => $hits[0] ?? null];

    return [$react, $state];
}
