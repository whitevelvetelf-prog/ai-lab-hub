<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести чутливих підкатегорій Елі (subcategories.search_only_on_match):
 * продукт, усі підкатегорії якого чутливі, не потрапляє ні в AI-кандидати (eli_ungated_products),
 * ні в запасний пошук (eli_search), якщо запит не зачіпає інтентів цієї підкатегорії.
 *   php tests/eli-sensitive-tests.php
 * Лише CLI, без БД (синтетичний індекс).
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/eli.php';
require_once __DIR__ . '/../app/eli-search.php';

$fails = 0;
$total = 0;
function check(bool $cond, string $label): void
{
    global $fails, $total;
    $total++;
    echo ($cond ? '  OK   ' : '  FAIL ') . $label . "\n";
    if (!$cond) {
        $fails++;
    }
}

// Підкатегорії: 1 — «Фотографія» (звичайна), 2 — «Цифрова пам'ять і спадщина» (чутлива). Категорії 1, 2 — звичайні.
$stems = static fn(string $words): array => array_map(static fn($w) => eli_search_stem(eli_search_clean($w)), explode(',', $words));
$trig = $stems("помер,померлих,меморіал,оживити,deceased,memorial,griefbot");

// --- AI-кандидати (eli_ungated_products)
$aiIndex = [
    'subcats' => [
        1 => ['name' => 'Фотографія', 'name_en' => 'Photography', 'cat' => 1, 'cnt' => 2, 'k' => ' фотограф photograph ', 'sens' => false, 'trig' => []],
        2 => ['name' => "Цифрова пам'ять і спадщина", 'name_en' => 'Digital memory and legacy', 'cat' => 2, 'cnt' => 2, 'k' => ' цифров памят спадщин digital memory legacy ', 'sens' => true, 'trig' => $trig],
    ],
    'products' => [
        10 => ['n' => 'Remini', 's' => [1, 2], 'c' => [1, 2], 'p' => 5, 'kn' => ' remini ', 'kd' => ' фото photo '],
        11 => ['n' => 'Project December', 's' => [2], 'c' => [2], 'p' => 0, 'kn' => ' project december ', 'kd' => ' чат chat '],
        12 => ['n' => 'Canva', 's' => [], 'c' => [1], 'p' => 9, 'kn' => ' canva ', 'kd' => ' дизайн design '],
    ],
];
$ids = static fn(string $q): array => array_keys(eli_ungated_products($aiIndex, eli_sensitive_open($aiIndex, $q)));
check(!in_array(11, $ids('чат-бот для бізнесу'), true), 'AI: «чат-бот для бізнесу» — чутливий продукт прихований');
check(!in_array(11, $ids('digital marketing tools'), true), 'AI: «digital» з назви підкатегорії не відкриває її');
check(!in_array(11, $ids('legacy code refactoring'), true), 'AI: «legacy code» не відкриває підкатегорію');
check(in_array(10, $ids('чат-бот для бізнесу'), true), 'AI: продукт і з нечутливою підкатегорією лишається');
check(in_array(12, $ids('чат-бот для бізнесу'), true), 'AI: продукт без підкатегорій лишається');
check(in_array(11, $ids('чат із померлим батьком'), true), 'AI: «померлим» відкриває підкатегорію');
check(in_array(11, $ids('griefbot app'), true), 'AI: «griefbot» відкриває підкатегорію');
check(in_array(11, eli_candidates($aiIndex, 'поговорити з померлим батьком', 3)['ids'], true), 'AI: на прямий запит продукт підкатегорії серед кандидатів');
check(!in_array(11, eli_candidates($aiIndex, 'чат для розмов', 3)['ids'], true), 'AI: на загальний запит — ні (і не як доповнення популярними)');
$aiIndex['subcats'][2]['sens'] = false;
$ids = static fn(string $q): array => array_keys(eli_ungated_products($aiIndex, eli_sensitive_open($aiIndex, $q)));   // стрілкова функція захоплює індекс за значенням
check(in_array(11, $ids('чат-бот для бізнесу'), true), 'AI: без прапорця нічого не приховується');

// --- Запасний пошук (eli_search)
$h = static fn(string $t): string => eli_search_haystack($t);
$sIndex = [
    'v' => ELI_SEARCH_INDEX_VERSION,
    'cats' => [
        1 => ['name' => 'Мультимедіа', 'name_en' => 'Multimedia', 'sensitive' => false, 'h' => $h('Мультимедіа Multimedia'), 'cnt' => 2],
        2 => ['name' => 'Мій дім', 'name_en' => 'My home', 'sensitive' => false, 'h' => $h('Мій дім My home'), 'cnt' => 2],
    ],
    'subs' => [
        1 => ['cat' => 1, 'name' => 'Фотографія', 'name_en' => 'Photography', 'sensitive' => false, 'h' => $h('Фотографія Photography'), 'cnt' => 1],
        2 => ['cat' => 2, 'name' => "Цифрова пам'ять і спадщина", 'name_en' => 'Digital memory and legacy', 'sensitive' => true,
              'h' => $h("Цифрова пам'ять і спадщина Digital memory and legacy"), 'cnt' => 2],
    ],
    'intents' => array_map(static fn($t) => ['t' => $t, 'c' => 2, 's' => 2, 'w' => 1.0], $trig),
    'products' => [
        20 => ['n' => $h('Deep Nostalgia'), 'd' => $h('анімація фото облич animate photo faces'), 'f' => $h('відео з фото'), 'c' => [2], 's' => [2], 'p' => 0],
        21 => ['n' => $h('Remini'), 'd' => $h('поліпшення фото photo enhancer'), 'f' => '', 'c' => [1, 2], 's' => [1, 2], 'p' => 3],
    ],
];
$found = static fn(string $q): array => array_column(eli_search($sIndex, $q, ['threshold' => 3.0, 'max_cards' => 6, 'stop' => [], 'geo' => []])['results'], 'id');
check(!in_array(20, $found('анімація фото для реклами'), true), 'Пошук: «анімація фото для реклами» — чутливий продукт прихований');
check(in_array(21, $found('поліпшення фото'), true), 'Пошук: Remini (є нечутлива підкатегорія) знаходиться');
check(!in_array(20, $found('digital фото'), true), 'Пошук: «digital» не відкриває чутливу підкатегорію');
check(in_array(20, $found('оживити фото померлої бабусі'), true), 'Пошук: «оживити фото померлої» знаходить чутливий продукт');
$sec = eli_search($sIndex, 'digital legacy', ['threshold' => 3.0, 'max_cards' => 6, 'stop' => [], 'geo' => []])['sections'];
check(!in_array(['type' => 'sub', 'id' => 2], $sec, true), 'Пошук: чутлива підкатегорія не пропонується як розділ на «digital legacy»');

echo "\n" . ($fails === 0 ? "УСЕ PASS ({$total})" : "FAIL: {$fails} з {$total}") . "\n";
exit($fails === 0 ? 0 : 1);
