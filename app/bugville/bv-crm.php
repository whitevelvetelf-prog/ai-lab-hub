<?php

declare(strict_types=1);

/**
 * Багвіль — CRM (крок 5 плану; MAIN_TASK, розділ 12): перевірки й дані для public/crm-bugville.php (лише admin).
 * Без видалення: варіанти й завдання іспиту вимикаються статусом 'off'.
 */

require_once __DIR__ . '/bv-exam.php';

const BV_MIN_POOL_VARIANTS = 6;

/**
 * Перевіряє варіант пулу з форми. Повертає [помилки, нормалізовані поля для БД].
 * payload: text, question, options [{id,text}] ≥ 2 з різними id (або input 'number'); answer: single / multi / number,
 * відповідь має посилатися на наявні варіанти; explain.text обовʼязковий (+ необовʼязковий hint).
 * @return array{0: list<string>, 1: array}
 */
function bv_crm_check_variant(array $in): array
{
    $errors = [];
    $payload = json_decode((string) ($in['payload_json'] ?? ''), true);
    $answer = json_decode((string) ($in['answer_json'] ?? ''), true);
    $explain = json_decode((string) ($in['explain_json'] ?? ''), true);
    if (!is_array($payload)) {
        $errors[] = 'Сцена (payload) — некоректний JSON.';
    }
    if (!is_array($answer)) {
        $errors[] = 'Відповідь (answer) — некоректний JSON.';
    }
    if (!is_array($explain)) {
        $errors[] = 'Розбір (explain) — некоректний JSON.';
    }
    $status = (string) ($in['status'] ?? 'draft');
    if (!bv_valid_status($status)) {
        $errors[] = 'Невідомий статус.';
    }
    $skill = trim((string) ($in['skill'] ?? ''));
    if ($skill === '' || mb_strlen($skill) > 64) {
        $errors[] = 'Навичка (skill) — обовʼязкова, до 64 символів.';
    }
    $lang = bv_lang((string) ($in['lang'] ?? 'uk'));
    if ($errors !== []) {
        return [$errors, []];
    }

    if (trim((string) ($payload['text'] ?? '')) === '') {
        $errors[] = 'У сцені немає тексту (text).';
    }
    if (trim((string) ($payload['question'] ?? '')) === '') {
        $errors[] = 'У сцені немає питання (question).';
    }
    $ids = [];
    foreach ((array) ($payload['options'] ?? []) as $o) {
        $id = is_array($o) ? (string) ($o['id'] ?? '') : '';
        if ($id === '' || trim((string) ($o['text'] ?? '')) === '') {
            $errors[] = 'Кожен варіант відповіді має id і text.';
            break;
        }
        $ids[] = $id;
    }
    if (count($ids) !== count(array_unique($ids))) {
        $errors[] = 'id варіантів відповіді повторюються.';
    }
    $type = (string) ($answer['type'] ?? '');
    if ($type === 'single') {
        if (count($ids) < 2 || !in_array((string) ($answer['correct'] ?? ''), $ids, true)) {
            $errors[] = 'single: потрібно ≥ 2 варіанти, а correct — id одного з них.';
        }
    } elseif ($type === 'multi') {
        $c = array_map('strval', (array) ($answer['correct'] ?? []));
        if (count($ids) < 2 || $c === [] || array_diff($c, $ids) !== []) {
            $errors[] = 'multi: потрібно ≥ 2 варіанти, а correct — список їхніх id.';
        }
    } elseif ($type === 'number') {
        if (!is_numeric($answer['value'] ?? null) || ($payload['input'] ?? '') !== 'number') {
            $errors[] = 'number: потрібні answer.value (число) і payload.input = "number".';
        }
    } else {
        $errors[] = 'Тип відповіді: single, multi або number.';
    }
    if (trim((string) ($explain['text'] ?? '')) === '') {
        $errors[] = 'Розбір має текст (explain.text).';
    }
    $flags = JSON_UNESCAPED_UNICODE;

    return [$errors, ['payload_json' => json_encode($payload, $flags), 'answer_json' => json_encode($answer, $flags),
        'explain_json' => json_encode($explain, $flags), 'status' => $status, 'skill' => $skill, 'lang' => $lang]];
}

/** Зберігає варіант (новий — id 0). @return int id */
function bv_crm_save_variant(PDO $pdo, int $id, int $missionId, array $v): int
{
    if ($id > 0) {
        $pdo->prepare('UPDATE bv_mission_variants SET payload_json = :p, answer_json = :a, explain_json = :e, status = :s, skill = :k,
                       lang = :l, updated_at = :t WHERE id = :id AND mission_id = :m')
            ->execute([':p' => $v['payload_json'], ':a' => $v['answer_json'], ':e' => $v['explain_json'], ':s' => $v['status'],
                ':k' => $v['skill'], ':l' => $v['lang'], ':t' => bv_now(), ':id' => $id, ':m' => $missionId]);

        return $id;
    }
    $pdo->prepare('INSERT INTO bv_mission_variants (mission_id, lang, skill, payload_json, answer_json, explain_json, status, created_at)
                   VALUES (:m, :l, :k, :p, :a, :e, :s, :t)')
        ->execute([':m' => $missionId, ':l' => $v['lang'], ':k' => $v['skill'], ':p' => $v['payload_json'], ':a' => $v['answer_json'],
            ':e' => $v['explain_json'], ':s' => $v['status'], ':t' => bv_now()]);

    return (int) $pdo->lastInsertId();
}

/**
 * Огляд місій для CRM: режим, генератор, активні варіанти, навички, попередження.
 * @return list<array{mission: array, generator: ?string, has_generator: bool, active: int, total: int, skills: list<string>,
 *                    warnings: list<string>, playable: bool}>
 */
function bv_crm_missions(PDO $pdo): array
{
    $counts = [];
    $skills = [];
    try {
        foreach ($pdo->query('SELECT mission_id, status, skill FROM bv_mission_variants')->fetchAll(PDO::FETCH_ASSOC) as $r) {
            $m = (int) $r['mission_id'];
            $counts[$m]['total'] = ($counts[$m]['total'] ?? 0) + 1;
            if ($r['status'] === 'active') {
                $counts[$m]['active'] = ($counts[$m]['active'] ?? 0) + 1;
                $skills[$m][(string) $r['skill']] = true;
            }
        }
    } catch (Throwable) {
        $counts = [];
    }
    $gens = bv_generators();
    $out = [];
    foreach (bv_world_missions() as $ms) {
        $id = (int) $ms['id'];
        $hasGen = $ms['generator'] !== null && isset($gens[$ms['generator']]);
        $active = (int) ($counts[$id]['active'] ?? 0);
        $sk = array_keys($skills[$id] ?? []);
        $w = [];
        if ($ms['mode'] === 'generator' && !$hasGen) {
            $w[] = 'немає генератора';
        }
        if (in_array($ms['mode'], ['pool', 'mixed'], true) && $active < BV_MIN_POOL_VARIANTS) {
            $w[] = 'менше ' . BV_MIN_POOL_VARIANTS . ' активних варіантів (' . $active . ')';
        }
        if ($ms['mode'] === 'mixed' && !$hasGen) {
            $w[] = 'немає генератора для чисел';
        }
        if (count($sk) > 1) {
            $w[] = 'варіанти перевіряють різне: ' . implode(', ', $sk);
        }
        $out[] = ['mission' => $ms, 'generator' => $ms['generator'], 'has_generator' => $hasGen, 'active' => $active,
            'total' => (int) ($counts[$id]['total'] ?? 0), 'skills' => $sk, 'warnings' => $w, 'playable' => bv_mission($id) !== null];
    }

    return $out;
}

/** Варіант очима гравця + відповідь і розбір для адміна. Для генератора — за seed. @return array|null */
function bv_crm_preview(PDO $pdo, array $missionDef, ?int $variantId, ?string $seed): ?array
{
    // Режим, з яким місія справді грається (bv_register_world_missions: напр. демо робить 1.5 генератором), інакше — зі світу.
    $reg = bv_mission((int) $missionDef['id']);
    $mode = $reg !== null ? (string) $reg['variant_mode'] : $missionDef['mode'];
    $missionDef['generator'] = $reg !== null ? ($reg['generator_key'] ?? null) : $missionDef['generator'];
    $mission = ['id' => (int) $missionDef['id'], 'variant_mode' => $mode, 'generator_key' => $missionDef['generator'],
        'generator_json' => $missionDef['generator_json']];
    if ($mode !== 'pool' && ($seed === null || $seed === '')) {
        $seed = bin2hex(random_bytes(8));
    }
    if ($mode === 'generator' && ($missionDef['generator'] === null || !isset(bv_generators()[$missionDef['generator']]))) {
        return null;
    }
    if ($mode === 'mixed' && ($missionDef['generator'] === null || !isset(bv_generators()[$missionDef['generator']]))) {
        $mission['variant_mode'] = 'pool';   // без генератора — показуємо як пул, {{плейсхолдери}} лишаються видимими
    }
    $v = bv_build_variant($pdo, $mission, $variantId, $mode === 'pool' ? null : $seed, 'uk');
    if ($v === null) {
        return null;
    }
    $textOf = [];
    foreach ((array) ($v['payload']['options'] ?? []) as $o) {
        $textOf[(string) $o['id']] = (string) $o['text'];
    }
    $correct = array_map('strval', (array) ($v['answer']['correct'] ?? []));

    return ['seed' => $mode === 'pool' ? null : $seed, 'key' => $v['key'], 'payload' => $v['payload'], 'answer' => $v['answer'],
        'correct_text' => array_values(array_intersect_key($textOf, array_flip($correct))), 'explain' => (string) ($v['explain']['text'] ?? ''),
        'hint' => (string) ($v['hint']['text'] ?? '')];
}

/** Пул іспиту для CRM: усі завдання (з вимкненими) + підсумок як у bv_exam_pool. */
function bv_crm_exam_items(PDO $pdo, int $examId): array
{
    $rows = [];
    try {
        $st = $pdo->prepare('SELECT * FROM bv_exam_items WHERE exam_id = :e ORDER BY id');
        $st->execute([':e' => $examId]);
        $rows = $st->fetchAll(PDO::FETCH_ASSOC);
    } catch (Throwable) {
        $rows = [];
    }

    return ['rows' => $rows, 'pool' => bv_exam_pool($pdo, $examId)];
}

/** Перевіряє й зберігає завдання іспиту (без видалення). @return list<string> помилки */
function bv_crm_save_exam_item(PDO $pdo, int $id, array $in): array
{
    $examId = (int) ($in['exam_id'] ?? 0);
    $missionId = (int) ($in['mission_id'] ?? 0);
    $weight = (int) ($in['weight'] ?? 0);
    $status = (string) ($in['status'] ?? 'active');
    $errors = [];
    if (bv_exam_level($examId) === null) {
        $errors[] = 'Невідомий іспит.';
    }
    if (!isset(bv_world_missions()[$missionId])) {
        $errors[] = 'Невідома місія.';
    }
    if ($weight < 1 || $weight > 50) {
        $errors[] = 'Вага — від 1 до 50.';
    }
    if (!in_array($status, ['active', 'off'], true)) {
        $errors[] = 'Статус — active або off.';
    }
    if ($errors !== []) {
        return $errors;
    }
    if ($id > 0) {
        $pdo->prepare('UPDATE bv_exam_items SET mission_id = :m, weight = :w, status = :s WHERE id = :id AND exam_id = :e')
            ->execute([':m' => $missionId, ':w' => $weight, ':s' => $status, ':id' => $id, ':e' => $examId]);
    } else {
        $pdo->prepare("INSERT INTO bv_exam_items (exam_id, mission_id, lang, weight, status, created_at) VALUES (:e, :m, 'uk', :w, :s, :t)")
            ->execute([':e' => $examId, ':m' => $missionId, ':w' => $weight, ':s' => $status, ':t' => bv_now()]);
    }

    return [];
}
