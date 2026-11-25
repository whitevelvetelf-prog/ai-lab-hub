<?php

declare(strict_types=1);

/**
 * Багвіль — Книга чарівних слів (MAIN_TASK, розділи 3 і 6; міграція № 37). Лише для акаунтів із підтвердженим віком.
 *
 * Слово відкривається, коли пройдено його місію (є зірки). Вправа: «Що означає …?» — 4 варіанти значення; одноразові
 * id варіантів і правильний — лише в сесії ($_SESSION['bv_word_quiz']), браузер правильного не бачить. Правильна
 * відповідь → «вивчено» (bv_user_words, один раз) і перевірка значків «Слова-початківець», «Усі слова рівня».
 * Тексти — bv_words (CRM / сид), запасні — bv_words_content().
 */

require_once __DIR__ . '/bv-progress.php';

/** Приклади речень до слів Етапу 1 (англійською + переклад). Вимова й значення — BV_WORDS. */
const BV_WORD_EXAMPLES = [
    'bug'       => ['We found a bug in the vending machine.', 'Ми знайшли поломку в торговому автоматі.'],
    'check'     => ['Please check the change.', 'Будь ласка, перевір решту.'],
    'limit'     => ['The limit is five chocolates.', 'Межа — пʼять шоколадок.'],
    'input'     => ['The input must be a number.', 'Введене має бути числом.'],
    'boundary'  => ['Bugs like to hide at the boundary.', 'Поломки люблять ховатися на межі.'],
    'required'  => ['This field is required.', 'Це поле обовʼязкове.'],
    'valid'     => ['Is this email address valid?', 'Ця адреса пошти правильна?'],
    'invalid'   => ['The phone number is invalid.', 'Номер телефону неправильний.'],
    'length'    => ['The length of the name is 28.', 'Довжина імені — 28.'],
    'duplicate' => ['This row is a duplicate.', 'Цей рядок — дубль.'],
    'expected'  => ['Expected: twelve books.', 'Очікувано: дванадцять книжок.'],
    'actual'    => ['Actual: eleven books.', 'Фактично: одинадцять книжок.'],
    'missing'   => ["The reader's name is missing.", 'Імені читача бракує.'],
    'mismatch'  => ['There is a mismatch in the columns.', 'У стовпцях невідповідність.'],
    'report'    => ['Write a short bug report.', 'Напиши короткий звіт про поломку.'],
];

/** Слова Етапу 1 для сиду й запасного показу. @return list<array> */
function bv_words_content(): array
{
    $out = [];
    $i = 0;
    foreach (bv_world_missions() as $ms) {
        $w = $ms['word'];
        $out[] = ['key' => $w, 'say' => BV_WORDS[$w][0], 'meaning' => BV_WORDS[$w][1], 'example_en' => BV_WORD_EXAMPLES[$w][0],
            'example_tr' => BV_WORD_EXAMPLES[$w][1], 'mission_id' => (int) $ms['id'], 'sort' => ++$i * 10];
    }

    return $out;
}

/** Активні слова (з БД; без таблиці чи рядків — запасні). @return array<string, array> word_key => слово */
function bv_words_all(PDO $pdo, string $lang = 'uk'): array
{
    $rows = [];
    try {
        $st = $pdo->prepare("SELECT word_key AS `key`, say, meaning, example_en, example_tr, mission_id, sort FROM bv_words
                             WHERE lang = :l AND status = 'active' ORDER BY sort, word_key");
        $st->execute([':l' => bv_lang($lang)]);
        $rows = $st->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable) {
        $rows = [];
    }
    $rows = $rows !== [] ? $rows : bv_words_content();
    $out = [];
    foreach ($rows as $r) {
        $out[(string) $r['key']] = ['key' => (string) $r['key'], 'say' => (string) $r['say'], 'meaning' => (string) $r['meaning'],
            'example_en' => (string) $r['example_en'], 'example_tr' => (string) $r['example_tr'], 'mission_id' => (int) $r['mission_id']];
    }

    return $out;
}

/** Вивчені слова акаунта. @return array<string,string> word_key => learned_at */
function bv_words_learned(PDO $pdo, int $userId): array
{
    $st = $pdo->prepare('SELECT word_key, learned_at FROM bv_user_words WHERE user_id = :u');
    $st->execute([':u' => $userId]);

    return $st->fetchAll(PDO::FETCH_KEY_PAIR) ?: [];
}

/** Книга для акаунта: слова зі станом locked / open / learned. @return list<array> */
function bv_words_book(PDO $pdo, int $userId): array
{
    $stars = bv_stars_by_mission($pdo, $userId);
    $learned = bv_words_learned($pdo, $userId);
    $missions = bv_world_missions();
    $out = [];
    foreach (bv_words_all($pdo) as $w) {
        $state = isset($learned[$w['key']]) ? 'learned' : (($stars[$w['mission_id']] ?? 0) > 0 ? 'open' : 'locked');
        $ms = $missions[$w['mission_id']] ?? null;
        $out[] = $w + ['state' => $state, 'mission_n' => $ms['n'] ?? '', 'mission_title' => $ms['title'] ?? ''];
    }

    return $out;
}

/**
 * Книга для гостя (або акаунта без підтвердженого віку): відкриті слова — з місій, пройдених у цьому сеансі
 * ($_SESSION['bv_guest']['best']); лише перегляд, без вправ і «вивчено» (MAIN_TASK, розділ 6: прогрес — для акаунтів).
 * @return list<array>
 */
function bv_words_book_guest(PDO $pdo): array
{
    $best = (array) ($_SESSION['bv_guest']['best'] ?? []);
    $missions = bv_world_missions();
    $out = [];
    foreach (bv_words_all($pdo) as $w) {
        $ms = $missions[$w['mission_id']] ?? null;
        $out[] = $w + ['state' => ((int) ($best[$w['mission_id']] ?? 0)) > 0 ? 'open' : 'locked', 'mission_n' => $ms['n'] ?? '',
            'mission_title' => $ms['title'] ?? ''];
    }

    return $out;
}

/**
 * Вправа до відкритого слова: 4 варіанти значення з одноразовими id; правильний — у сесії.
 * @return array{ok:bool, error?:string, word?:string, question?:string, options?:list<array{id:string,text:string}>}
 */
function bv_word_quiz(PDO $pdo, int $userId, string $word): array
{
    $book = array_column(bv_words_book($pdo, $userId), null, 'key');
    $w = $book[$word] ?? null;
    if ($w === null) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    if ($w['state'] === 'locked') {
        return ['ok' => false, 'error' => 'locked'];
    }
    $others = array_values(array_filter(array_column($book, 'meaning'), static fn($m) => $m !== $w['meaning']));
    shuffle($others);
    $texts = array_merge([$w['meaning']], array_slice($others, 0, 3));
    shuffle($texts);
    $options = [];
    $correct = '';
    foreach ($texts as $t) {
        $id = 'w' . bin2hex(random_bytes(3));
        $options[] = ['id' => $id, 'text' => $t];
        if ($t === $w['meaning']) {
            $correct = $id;
        }
    }
    $_SESSION['bv_word_quiz'][$word] = ['correct' => $correct, 'ids' => array_column($options, 'id')];

    return ['ok' => true, 'word' => $word, 'question' => 'Що означає «' . $word . '»?', 'options' => $options];
}

/**
 * Відповідь на вправу (одноразова: після перевірки треба нову вправу). Правильна → «вивчено» + значки.
 * @return array{ok:bool, error?:string, correct?:bool, meaning?:string, learned?:bool, new_badges?:list<array>, learned_count?:int}
 */
function bv_word_check(PDO $pdo, int $userId, string $word, string $option): array
{
    $quiz = $_SESSION['bv_word_quiz'][$word] ?? null;
    if (!is_array($quiz) || !in_array($option, (array) $quiz['ids'], true)) {
        return ['ok' => false, 'error' => 'no_quiz'];
    }
    unset($_SESSION['bv_word_quiz'][$word]);
    $w = bv_words_all($pdo)[$word] ?? null;
    if ($w === null) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    $ok = hash_equals((string) $quiz['correct'], $option);
    $new = [];
    if ($ok) {
        $pdo->prepare('INSERT IGNORE INTO bv_user_words (user_id, word_key, learned_at) VALUES (:u, :w, :t)')
            ->execute([':u' => $userId, ':w' => $word, ':t' => bv_now()]);
        $new = bv_badges_check($pdo, $userId);
    }

    return ['ok' => true, 'correct' => $ok, 'meaning' => $w['meaning'], 'learned' => $ok, 'new_badges' => $new,
        'learned_count' => count(bv_words_learned($pdo, $userId))];
}
