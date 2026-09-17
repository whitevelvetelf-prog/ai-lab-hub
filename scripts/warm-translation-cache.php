<?php

declare(strict_types=1);

/**
 * AI LAB HUB — одноразове прогрівання кешу перекладу.
 *
 * Проходить по всіх products / pricing_plans і для кожної активної мови,
 * відмінної від мови оригіналу (config/languages.php), перекладає й
 * кешує поля, яких ще нема в product_translations / pricing_plan_translations
 * (і які не позначені source='manual' — такі не чіпає ніколи).
 *
 * За замовчуванням — ЛИШЕ підрахунок (кількість полів і символів, які
 * будуть перекладені) БЕЗ жодного звернення до Google Translation API.
 * Реальний переклад запускається тільки з явним --confirm.
 *
 * Використання:
 *   php scripts/warm-translation-cache.php            — підрахунок (сухий прогін)
 *   php scripts/warm-translation-cache.php --confirm  — реальний батч-переклад
 *
 * Мовонезалежний: список цільових мов береться з config/languages.php,
 * жодного хардкоду 'en' у логіці нижче.
 */

require_once __DIR__ . '/../app/translation-cache.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$confirm = in_array('--confirm', $argv, true);

$sourceLang = translation_source_lang();
$targetLangs = array_values(array_diff(active_lang_codes(), [$sourceLang]));

if ($targetLangs === []) {
    echo "Немає активних мов, крім мови оригіналу ({$sourceLang}) — нічого прогрівати.\n";
    exit(0);
}

$productFields = ['short_description', 'full_description', 'main_features', 'target_audience'];
$planFields = ['plan_name', 'description'];

/**
 * @return array{fields: int, chars: int, rows: array<int, array{table: string, id_column: string, id: int, field: string, lang: string, text: string}>}
 */
function scan_pending(
    PDO $pdo,
    string $table,
    string $idColumn,
    string $sourceTable,
    array $fields,
    array $targetLangs
): array {
    $fields = $fields;
    $columns = implode(', ', array_merge(['id'], $fields));
    $rows = $pdo->query("SELECT {$columns} FROM {$sourceTable}")->fetchAll(PDO::FETCH_ASSOC);

    $pending = ['fields' => 0, 'chars' => 0, 'rows' => []];

    foreach ($rows as $row) {
        $id = (int) $row['id'];
        foreach ($fields as $field) {
            $text = trim((string) ($row[$field] ?? ''));
            if ($text === '') {
                continue;
            }
            foreach ($targetLangs as $lang) {
                $cached = translation_lookup($pdo, $table, [$idColumn => $id, 'field_name' => $field], $lang);
                if ($cached !== null && trim($cached['translated_text']) !== '') {
                    continue; // вже перекладено (auto чи manual) — не рахуємо й не чіпаємо
                }
                $pending['fields']++;
                $pending['chars'] += mb_strlen($text, 'UTF-8');
                $pending['rows'][] = [
                    'table' => $table,
                    'id_column' => $idColumn,
                    'id' => $id,
                    'field' => $field,
                    'lang' => $lang,
                    'text' => $text,
                ];
            }
        }
    }

    return $pending;
}

$productPending = scan_pending($pdo, 'product_translations', 'product_id', 'products', $productFields, $targetLangs);
$planPending = scan_pending($pdo, 'pricing_plan_translations', 'plan_id', 'pricing_plans', $planFields, $targetLangs);

$totalFields = $productPending['fields'] + $planPending['fields'];
$totalChars = $productPending['chars'] + $planPending['chars'];

printf("Мова оригіналу: %s | Цільові мови: %s\n", $sourceLang, implode(', ', $targetLangs));
printf("Продукти: %d полів очікують перекладу, %d символів\n", $productPending['fields'], $productPending['chars']);
printf("Тарифні плани: %d полів очікують перекладу, %d символів\n", $planPending['fields'], $planPending['chars']);
printf("РАЗОМ: %d полів, %d символів\n", $totalFields, $totalChars);

if (!$confirm) {
    echo "\nСухий прогін — жодного звернення до Google Translation API, нічого не кешовано.\n";
    echo "Запустіть з --confirm, щоб виконати реальний переклад і кешування.\n";
    exit(0);
}

echo "\n--confirm passed — запускаю реальний переклад (батчами, щоб не робити тисячі окремих запитів)...\n";

// Батчимо по цільовій мові (усі рядки в одному батчі мають однакову lang —
// вимога Google Translate API v2 для масиву 'q'), з обмеженням і на кількість
// текстів, і на суму символів у батчі — щоб не перевищити розмір запиту.
const BATCH_MAX_ITEMS = 40;
const BATCH_MAX_CHARS = 8000;

$allRows = array_merge($productPending['rows'], $planPending['rows']);
$byLang = [];
foreach ($allRows as $item) {
    $byLang[$item['lang']][] = $item;
}

$done = 0;
$failed = 0;

foreach ($byLang as $lang => $items) {
    $batch = [];
    $batchChars = 0;
    $langDone = 0;
    $langFailed = 0;

    $flush = function () use (&$batch, &$batchChars, &$langDone, &$langFailed, $pdo, $lang, $sourceLang): void {
        if ($batch === []) {
            return;
        }
        $texts = array_column($batch, 'text');
        $translations = google_translate_batch($texts, $lang, $sourceLang);
        if ($translations === null) {
            $langFailed += count($batch);
        } else {
            foreach ($batch as $i => $item) {
                translation_store(
                    $pdo,
                    $item['table'],
                    [$item['id_column'] => $item['id'], 'field_name' => $item['field']],
                    $item['lang'],
                    $translations[$i],
                    'auto'
                );
                $langDone++;
            }
        }
        $batch = [];
        $batchChars = 0;
    };

    foreach ($items as $item) {
        $len = mb_strlen($item['text'], 'UTF-8');
        if ($batch !== [] && (count($batch) >= BATCH_MAX_ITEMS || $batchChars + $len > BATCH_MAX_CHARS)) {
            $flush();
        }
        $batch[] = $item;
        $batchChars += $len;
    }
    $flush();

    printf("  мова %s: опрацьовано %d / %d полів цієї мови (помилок: %d)\n", $lang, $langDone, count($items), $langFailed);
    $done += $langDone;
    $failed += $langFailed;
}

printf("Готово: перекладено й закешовано %d полів, помилок — %d.\n", $done, $failed);
