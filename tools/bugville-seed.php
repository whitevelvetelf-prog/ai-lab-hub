<?php

declare(strict_types=1);

/**
 * AI LAB HUB — сид контенту «Багвіля», Етап 1 (крок 6; MAIN_TASK, розділ 11): сюжети пулів 1.5, 2.5, 3.5 і пули іспитів
 * трьох рівнів; звання й значки за замовчуванням (app/bugville/bv-progress.php, міграція № 36). Ідемпотентно: сюжет
 * додається, лише якщо в місії ще немає варіанта з тим самим payload.key; завдання іспиту — лише якщо для (іспит, місія)
 * ще немає рядка; звання, значок і чарівне слово — лише якщо їхнього ключа ще немає. Наявне (зокрема змінене в CRM) не змінюється й не видаляється.
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
require_once __DIR__ . '/../app/bugville/bv-progress.php';   // звання й значки за замовчуванням
require_once __DIR__ . '/../app/bugville/bv-words.php';      // 15 чарівних слів (міграція № 37)

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
    foreach (bv_ranks_content() as $r) {
        $out[] = ['sql' => "INSERT INTO bv_ranks (rank_key, lang, title, min_xp, status, updated_at)
                SELECT :k, 'uk', :t, :x, 'active', UTC_TIMESTAMP() FROM DUAL
                WHERE NOT EXISTS (SELECT 1 FROM bv_ranks WHERE rank_key = :k2 AND lang = 'uk')",
            'params' => [':k' => $r['key'], ':t' => $r['title'], ':x' => $r['min_xp'], ':k2' => $r['key']]];
    }
    foreach (bv_badges_content() as $i => $b) {
        $out[] = ['sql' => "INSERT INTO bv_badges (badge_key, lang, title, description, param, sort, status, updated_at)
                SELECT :k, 'uk', :t, :d, " . ($b['param'] === null ? 'NULL' : ':p') . ", :s, 'active', UTC_TIMESTAMP() FROM DUAL
                WHERE NOT EXISTS (SELECT 1 FROM bv_badges WHERE badge_key = :k2 AND lang = 'uk')",
            'params' => [':k' => $b['key'], ':t' => $b['title'], ':d' => $b['description'], ':s' => ($i + 1) * 10, ':k2' => $b['key']]
                + ($b['param'] === null ? [] : [':p' => $b['param']])];
    }
    foreach (bv_words_content() as $w) {
        $out[] = ['sql' => "INSERT INTO bv_words (word_key, lang, say, meaning, example_en, example_tr, mission_id, sort, status, updated_at)
                SELECT :k, 'uk', :say, :m, :en, :tr, :mid, :s, 'active', UTC_TIMESTAMP() FROM DUAL
                WHERE NOT EXISTS (SELECT 1 FROM bv_words WHERE word_key = :k2 AND lang = 'uk')",
            'params' => [':k' => $w['key'], ':say' => $w['say'], ':m' => $w['meaning'], ':en' => $w['example_en'], ':tr' => $w['example_tr'],
                ':mid' => $w['mission_id'], ':s' => $w['sort'], ':k2' => $w['key']]];
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
$added = ['variants' => 0, 'exam_items' => 0, 'ranks' => 0, 'badges' => 0, 'words' => 0];
foreach ($stmts as $s) {
    $st = $pdo->prepare($s['sql']);
    $st->execute($s['params']);
    $table = preg_match('/INSERT INTO (bv_\w+)/', $s['sql'], $m) === 1 ? $m[1] : '';
    $added[['bv_exam_items' => 'exam_items', 'bv_ranks' => 'ranks', 'bv_badges' => 'badges', 'bv_words' => 'words'][$table] ?? 'variants'] += $st->rowCount();
}
echo "Додано: варіантів пулу {$added['variants']}, завдань іспитів {$added['exam_items']}, звань {$added['ranks']}, значків {$added['badges']}, слів {$added['words']} (наявне не змінювалося).\n";
