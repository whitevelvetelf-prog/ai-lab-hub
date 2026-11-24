<?php

declare(strict_types=1);

/**
 * AI LAB HUB — сид контенту «Багвіля», Етап 1 (крок 6; MAIN_TASK, розділ 11): сюжети пулів 1.5, 2.5, 3.5 і пули іспитів
 * трьох рівнів. Ідемпотентно: сюжет додається, лише якщо в місії ще немає варіанта з тим самим payload.key; завдання
 * іспиту — лише якщо для (іспит, місія) ще немає рядка. Наявне не змінюється й не видаляється.
 *   php tools/bugville-seed.php          — записати в локальну БД (config/database.php)
 *   php tools/bugville-seed.php --sql    — лише надрукувати SQL для phpMyAdmin (INSERT … SELECT … WHERE NOT EXISTS),
 *                                          по одному запиту на рядок — для імпорту на живу базу після «так» власниці
 * Тексти сюжетів — app/bugville/bv-content.php (bv_pool_content, bv_exam_pool_content).
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/bugville/bv-content.php';
require_once __DIR__ . '/../app/bugville/bv-config.php';

$sqlOnly = in_array('--sql', array_slice($argv, 1), true);
$flags = JSON_UNESCAPED_UNICODE;

/** @return list<array{sql:string, params:array}> */
function bv_seed_statements(): array
{
    $flags = JSON_UNESCAPED_UNICODE;
    $out = [];
    foreach (bv_pool_content() as $missionId => $variants) {
        foreach ($variants as $v) {
            $out[] = ['sql' => "INSERT INTO bv_mission_variants (mission_id, lang, skill, payload_json, answer_json, explain_json, status, created_at)
                SELECT :m, 'uk', :skill, :p, :a, :e, 'active', UTC_TIMESTAMP() FROM DUAL
                WHERE NOT EXISTS (SELECT 1 FROM bv_mission_variants WHERE mission_id = :m2 AND payload_json LIKE :k)",
                'params' => [':m' => $missionId, ':skill' => $v['skill'], ':p' => json_encode($v['payload'], $flags),
                    ':a' => json_encode($v['answer'], $flags), ':e' => json_encode($v['explain'], $flags), ':m2' => $missionId,
                    ':k' => '%"key":"' . $v['key'] . '"%']];
        }
    }
    foreach (bv_exam_pool_content() as $examId => $items) {
        foreach ($items as $it) {
            $out[] = ['sql' => "INSERT INTO bv_exam_items (exam_id, mission_id, lang, weight, status, created_at)
                SELECT :e, :m, 'uk', :w, 'active', UTC_TIMESTAMP() FROM DUAL
                WHERE NOT EXISTS (SELECT 1 FROM bv_exam_items WHERE exam_id = :e2 AND mission_id = :m2)",
                'params' => [':e' => $examId, ':m' => $it['mission'], ':w' => $it['weight'], ':e2' => $examId, ':m2' => $it['mission']]];
        }
    }

    return $out;
}

/** Підставляє параметри для друку SQL (рядки — у лапках з екрануванням, числа — як є). */
function bv_seed_inline(string $sql, array $params): string
{
    uksort($params, static fn($a, $b) => strlen($b) <=> strlen($a));   // :m2 раніше за :m
    foreach ($params as $k => $v) {
        $lit = is_int($v) ? (string) $v : "'" . str_replace(["\\", "'"], ["\\\\", "\\'"], (string) $v) . "'";
        $sql = str_replace($k, $lit, $sql);
    }

    return preg_replace('/\s+/', ' ', trim($sql)) . ';';
}

$stmts = bv_seed_statements();
if ($sqlOnly) {
    echo "-- AI LAB HUB — Багвіль, контент Етапу 1 (сид, " . gmdate('Y-m-d') . "): " . count($stmts) . " запитів, ідемпотентно.\n";
    echo "-- Згенеровано tools/bugville-seed.php --sql. Потрібні таблиці міграцій № 33 і 34. Без DELETE / UPDATE / DROP.\nSET NAMES utf8mb4;\n";
    foreach ($stmts as $s) {
        echo bv_seed_inline($s['sql'], $s['params']), "\n";
    }
    exit(0);
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$added = ['variants' => 0, 'exam_items' => 0];
foreach ($stmts as $s) {
    $st = $pdo->prepare($s['sql']);
    $st->execute($s['params']);
    $added[str_contains($s['sql'], 'bv_exam_items') ? 'exam_items' : 'variants'] += $st->rowCount();
}
echo "Додано: варіантів пулу {$added['variants']}, завдань іспитів {$added['exam_items']} (наявне не змінювалося).\n";
