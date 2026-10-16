<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тестовий набір запасного пошуку Елі: топ-5 із балами для кожного запиту.
 *   php tools/eli-search-test.php            — увесь набір
 *   php tools/eli-search-test.php "запит"    — один запит
 * Лише CLI, локальна база.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/eli-search.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

const ELI_SEARCH_TEST_QUERIES = [
    'Потрібно вивчити історію України',
    'стиснути відео для інстаграму',
    'перекласти документ',
    'написати код на Python',
    'зробити логотип',
    'потрібна музика для відео',
    'learn history of Ukraine',
    'translate a PDF',
    'voiceover for a video',
    'AI for kids homework',
    'plan a trip',
    'як привчити собаку не гавкати',
    'скласти резюме для роботи',
    'генерація зображень для інстаграму',
    'хочу вивчити англійську мову',
    'підготуватися до співбесіди',
    'зробити презентацію для інвесторів',
    'менеджер паролів для сім\'ї',
    'розшифрувати запис зустрічі',
    'рецепт вечері з того, що є в холодильнику',
    'тренування вдома без інвентарю',
    'аналіз таблиць Excel',
    'create a website without code',
    'write a blog post about travel',
    'remove background from photo',
    'help me with my mental health',
    'церква в Україні',
    'помолитися',
    'qqqzzz wwwvvv',
    'Київ',
];

$index = eli_search_index($pdo, true);
$t0 = microtime(true);
$queries = isset($argv[1]) ? [$argv[1]] : ELI_SEARCH_TEST_QUERIES;
$catName = static fn(int $id): string => $index['cats'][$id]['name'] ?? '?';
$names = $pdo->query("SELECT id, name FROM products WHERE status = 'published'")->fetchAll(PDO::FETCH_KEY_PAIR);

foreach ($queries as $q) {
    $t = microtime(true);
    $r = eli_search($index, $q);
    $ms = (int) round((microtime(true) - $t) * 1000);
    echo "\n### {$q}\n    основи: " . implode(', ', $r['terms']) . ($r['geo'] !== [] ? ' (гео: ' . implode(', ', $r['geo']) . ')' : '') . " · {$ms} мс\n";
    if ($r['results'] === []) {
        echo "    нічого впевненого → розділи: " . implode('; ', array_map(static fn($l) => $l['title'], eli_search_section_links($index, $r['sections'], 'uk'))) . "\n";
        continue;
    }
    foreach (array_slice($r['results'], 0, 5) as $i => $row) {
        $p = $index['products'][$row['id']];
        printf("    %d. %-34s %4.1f  [%s] %s\n", $i + 1, mb_substr((string) ($names[$row['id']] ?? '#' . $row['id']), 0, 34), $row['score'],
            implode(', ', array_map($catName, $p['c'])), implode(' ', $row['why']));
    }
}
printf("\nУсього %d запитів за %.2f с\n", count($queries), microtime(true) - $t0);
