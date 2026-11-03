<?php

declare(strict_types=1);

/**
 * AI LAB HUB — навантаження пошуку: N згенерованих опублікованих продуктів («Qzvload …») зі словами справжнього
 * каталогу, індексація, час запитів і EXPLAIN. ЛОКАЛЬНА база, лише CLI:  php tests/search-explain.php [N=5000]
 * Наприкінці видаляє ЛИШЕ створені продукти й їхні рядки індексу за id.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
$_SESSION = [];
require_once __DIR__ . '/../app/search.php';
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$n = max(100, (int) ($argv[1] ?? 5000));

// Словник зі справжніх описів — розподіл слів схожий на живий каталог.
$vocab = [];
foreach ($pdo->query("SELECT short_description, short_description_en, full_description FROM products WHERE status = 'published' ORDER BY RAND() LIMIT 600") as $r) {
    foreach (search_tokenize(implode(' ', $r)) as $t) {
        $vocab[] = $t;
    }
}
$vc = count($vocab);
mt_srand(7);
$words = static function (int $k) use ($vocab, $vc): string {
    $o = [];
    for ($i = 0; $i < $k; $i++) {
        $o[] = $vocab[mt_rand(0, $vc - 1)];
    }

    return implode(' ', $o);
};
$ids = [];
try {
    $pdo->beginTransaction();
    $ins = $pdo->prepare("INSERT INTO products (name, short_description, short_description_en, full_description, full_description_en, main_features, status, created_at, updated_at)
                          VALUES (:n, :s, :se, :f, :fe, :mf, 'published', NOW(), NOW())");
    for ($i = 0; $i < $n; $i++) {
        $ins->execute([':n' => 'Qzvload ' . ucfirst($words(2)) . ' ' . $i, ':s' => $words(14), ':se' => $words(14), ':f' => $words(80), ':fe' => $words(80), ':mf' => $words(10)]);
        $ids[] = (int) $pdo->lastInsertId();
    }
    $pdo->commit();
    $subs = array_map('intval', $pdo->query('SELECT id FROM subcategories ORDER BY id')->fetchAll(PDO::FETCH_COLUMN));
    $ps = $pdo->prepare('INSERT INTO product_subcategories (product_id, subcategory_id) VALUES (:p, :s)');
    foreach ($ids as $id) {
        $ps->execute([':p' => $id, ':s' => $subs[mt_rand(0, count($subs) - 1)]]);
    }
    echo 'Створено ' . count($ids) . ' продуктів (id ' . min($ids) . '–' . max($ids) . ")\n";
    $t = microtime(true);
    foreach (array_chunk($ids, 200) as $chunk) {
        search_index_products($pdo, $chunk, true);
    }
    printf("Індексація %d продуктів: %.1f с\n", count($ids), microtime(true) - $t);
    $pdo->query('ANALYZE TABLE search_index, search_index_state, products')->fetchAll();
    $total = (int) $pdo->query("SELECT COUNT(*) FROM products WHERE status = 'published'")->fetchColumn();
    $rows = (int) $pdo->query("SELECT COUNT(*) FROM search_index WHERE token <> ''")->fetchColumn();
    echo "Опубліковано всього: $total, рядків індексу: $rows\n\n";

    foreach (['midjourney', 'відео', 'video', 'AI', 'фото', 'переклад', 'чат-бот', 'відео монтаж', 'генерація зображень', 'a', 'zzzqqq'] as $q) {
        $times = [];
        for ($k = 0; $k < 3; $k++) {
            $memo = &search_hits_memo();
            $memo = [];
            $t = microtime(true);
            $r = search_products($pdo, $q, 1, 24, false);
            $times[] = (microtime(true) - $t) * 1000;
        }
        sort($times);
        printf("%-22s %-7s %5d  медіана %6.1f мс\n", $q, $r['status'], $r['total'], $times[1]);
    }

    echo "\nEXPLAIN token = 'ai':\n";
    foreach ($pdo->query("EXPLAIN SELECT si.product_id, si.field_type, MAX(si.weight) FROM search_index si
                          JOIN products p ON p.id = si.product_id AND p.status = 'published'
                          WHERE si.token = 'ai' GROUP BY si.product_id, si.field_type")->fetchAll() as $e) {
        printf("  %-6s %-8s key=%-20s rows=%-7s %s\n", $e['table'], $e['type'], (string) $e['key'], (string) $e['rows'], (string) $e['Extra']);
    }
    echo "EXPLAIN token LIKE 'віде%':\n";
    foreach ($pdo->query("EXPLAIN SELECT si.product_id, si.field_type, MAX(si.weight) FROM search_index si
                          JOIN products p ON p.id = si.product_id AND p.status = 'published'
                          WHERE si.token LIKE 'віде%' GROUP BY si.product_id, si.field_type")->fetchAll() as $e) {
        printf("  %-6s %-8s key=%-20s rows=%-7s %s\n", $e['table'], $e['type'], (string) $e['key'], (string) $e['rows'], (string) $e['Extra']);
    }
    $t = microtime(true);
    [$a, $b] = search_index_signature($pdo);
    printf("\nПеревірка сигнатури (кожен пошук): %.1f мс\n", (microtime(true) - $t) * 1000);
} finally {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    if ($ids !== []) {
        $del = 0;
        foreach (array_chunk($ids, 1000) as $chunk) {
            $in = implode(',', $chunk);
            $pdo->exec("DELETE FROM search_index WHERE product_id IN ($in)");
            $pdo->exec("DELETE FROM search_index_state WHERE product_id IN ($in)");
            $pdo->exec("DELETE FROM product_subcategories WHERE product_id IN ($in)");
            $del += $pdo->exec("DELETE FROM products WHERE id IN ($in) AND name LIKE 'Qzvload %'");
        }
        echo "Видалено тестових продуктів: $del + їхні рядки індексу й підкатегорій\n";
        [$a, $b] = search_index_signature($pdo);
        search_setting_set($pdo, 'search_index_sig', $a . ':' . $b);
    }
}
