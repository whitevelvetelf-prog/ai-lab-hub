<?php

declare(strict_types=1);

/**
 * AI LAB HUB — запасний пошук Елі без AI (коли модель не відповіла): осмислений відбір карток.
 *
 * 1. Нормалізація: малі літери, без розділових знаків і апострофів, без стоп-слів
 *    (config/eli-search.php), легке усічення закінчень UA/EN (eli_search_stem; основа ≥ 4 символи).
 * 2. Інтенти (таблиця search_intents): основа слова → категорія / підкатегорія з вагою.
 *    Основи порівнюються за префіксом в обидва боки («істор» ~ «історичн»).
 * 3. Бали продукту за кожну основу запиту (береться найбільший): інтент збігся з категорією чи
 *    підкатегорією продукту — 5 × вага; основа в назві — 3; у короткому описі — 2; у повному — 1.
 *    Географічні основи (Україна, Київ…) — × 0.5 і самі не кваліфікують продукт.
 * 4. Продукт у видачі лише якщо є збіг негеографічної основи чи інтенту й сума ≥ threshold.
 * 5. Чутливі розділи (categories.search_only_on_match = 1, напр. «Релігія»): продукт, усі
 *    категорії якого чутливі, потрапляє у видачу лише коли запит прямо стосується розділу
 *    (інтент цього розділу або слово з назви його категорії / підкатегорії). Так само на рівні
 *    підкатегорії (subcategories.search_only_on_match = 1, напр. «Цифрова пам'ять і спадщина»):
 *    продукт, усі підкатегорії якого чутливі, — лише коли запит зачіпає одну з них. Якщо запит саме
 *    про чутливу підкатегорію (її інтент з вагою ≥ 1, напр. «померл»), у видачі лише її продукти.
 * 6. Нічого впевненого — не випадкові картки, а 4–6 найближчих за інтентами підкатегорій
 *    (або найбільших категорій).
 *
 * Індекс (основи назви / описів, категорії) — файл storage/cache/eli-search-index.json на 6 годин.
 */

require_once __DIR__ . '/translations.php';

const ELI_SEARCH_INDEX_TTL = 21600;
const ELI_SEARCH_INDEX_VERSION = 2;

/** @return array{threshold: float, max_cards: int, stop: array<string,true>, geo: list<string>} */
function eli_search_config(): array
{
    static $cfg = null;
    if ($cfg === null) {
        $path = __DIR__ . '/../config/eli-search.php';
        $raw = is_file($path) ? (array) (require $path) : [];
        $geo = [];
        foreach ((array) ($raw['geo_words'] ?? []) as $w) {
            $geo[eli_search_stem(eli_search_clean((string) $w))] = true;
        }
        $cfg = [
            'threshold' => (float) ($raw['threshold'] ?? 3),
            'max_cards' => max(1, (int) ($raw['max_cards'] ?? 6)),
            'stop' => array_fill_keys(array_map(static fn($w) => eli_search_clean((string) $w), (array) ($raw['stop_words'] ?? [])), true),
            'geo' => array_keys($geo),
        ];
    }

    return $cfg;
}

/** Малі літери, апострофи геть («кав'ярня» → «кавярня»), решта розділових знаків — пробіл. */
function eli_search_clean(string $text): string
{
    $t = mb_strtolower($text);
    $t = str_replace(["'", '’', 'ʼ', '`', '´'], '', $t);
    $t = (string) preg_replace('/[^\p{L}\p{N}]+/u', ' ', $t);

    return trim($t);
}

/** Українські закінчення від довших до коротших (усікається одне, найдовше, що підходить). */
const ELI_UK_ENDINGS = [
    'ування', 'ювання', 'уватися', 'юватися', 'увати', 'ювати', 'ання', 'ення', 'яння', 'іння',
    'атися', 'итися', 'ітися', 'ятися', 'ується', 'ються', 'ається',
    'ами', 'ями', 'ові', 'еві', 'ого', 'ому', 'ими', 'іми', 'ати', 'яти', 'ити', 'іти', 'ути', 'нути',
    'ися', 'ась', 'ось', 'ись', 'ий', 'ій', 'ої', 'ою', 'ею', 'єю', 'ям', 'ам', 'ах', 'ях', 'ів', 'їв', 'ом', 'ем', 'єм',
    'ень', 'ія', 'ію', 'ії', 'ья', 'ає', 'ує', 'ть', 'ся', 'ла', 'ли', 'ло',
    'а', 'я', 'у', 'ю', 'і', 'ї', 'е', 'є', 'о', 'и', 'й', 'ь',
];

/** Англійські закінчення. */
const ELI_EN_ENDINGS = ['ations', 'ation', 'ings', 'ing', 'ies', 'ied', 'ers', 'ed', 'es', 'er', 'ly', 'y', 's', 'e'];

/**
 * Основа слова: відкидається одне найдовше відоме закінчення, якщо лишається ≥ 4 символи.
 * «історію/історії/історія» → «істор»; «України/Україна/Україні» → «україн»; «learning» → «learn».
 */
function eli_search_stem(string $word): string
{
    $len = mb_strlen($word);
    if ($len <= 4) {
        return $word;
    }
    $latin = preg_match('/^[a-z0-9]+$/', $word) === 1;
    foreach ($latin ? ELI_EN_ENDINGS : ELI_UK_ENDINGS as $end) {
        $el = mb_strlen($end);
        if ($len - $el >= 4 && mb_substr($word, -$el) === $end) {
            return mb_substr($word, 0, $len - $el);
        }
    }

    return $word;
}

/** @return list<string> основи значущих слів (без стоп-слів, без повторів) */
function eli_search_terms(string $text, ?array $cfg = null): array
{
    $cfg ??= eli_search_config();
    $out = [];
    foreach (explode(' ', eli_search_clean($text)) as $w) {
        if ($w === '' || isset($cfg['stop'][$w]) || (mb_strlen($w) < 3 && !preg_match('/^[a-z0-9]{2}$/', $w)) || mb_strlen($w) > 40) {
            continue;
        }
        $out[eli_search_stem($w)] = true;
        if (count($out) >= 12) {
            break;
        }
    }

    return array_keys($out);
}

/**
 * Сила збігу двох основ: 1 — однакові; 0.6 — коротша (≥ 4 символи) є префіксом довшої
 * («віде» ~ «відеомонтаж»); 0 — інакше. Основи з 3 символів (код, бот, seo, car) — лише точний збіг.
 */
function eli_search_stem_match(string $a, string $b): float
{
    if ($a === $b) {
        return 1.0;
    }
    if (mb_strlen($a) > mb_strlen($b)) {
        [$a, $b] = [$b, $a];
    }

    return mb_strlen($a) >= 4 && str_starts_with($b, $a) ? 0.6 : 0.0;
}

/** Рядок основ тексту « осн1 осн2 … » для пошуку за префіксом через str_contains(' ' . основа). */
function eli_search_haystack(string $text): string
{
    $stems = [];
    foreach (explode(' ', eli_search_clean($text)) as $w) {
        if (mb_strlen($w) >= 2) {
            $stems[eli_search_stem($w)] = true;
        }
    }

    return ' ' . implode(' ', array_keys($stems)) . ' ';
}

/** Чи є в рядку основ слово, що збігається з основою $stem за префіксом. */
function eli_search_in(string $hay, string $stem): bool
{
    if (mb_strlen($stem) <= 3) {
        return str_contains($hay, ' ' . $stem . ' '); // короткі основи — лише ціле слово
    }
    // основа запиту — префікс слова тексту (« істор» у « історичн »)…
    if (str_contains($hay, ' ' . $stem)) {
        return true;
    }
    // …або слово тексту — префікс довшої основи запиту («translat» для «translation»): лише якщо воно
    // ≥ 5 символів і покриває ≥ 60% основи — інакше довге слово збігалося б з будь-яким коротким («self»)
    $min = max(5, (int) ceil(mb_strlen($stem) * 0.6));
    for ($l = mb_strlen($stem) - 1; $l >= $min; $l--) {
        if (str_contains($hay, ' ' . mb_substr($stem, 0, $l) . ' ')) {
            return true;
        }
    }

    return false;
}

/**
 * Індекс для запасного пошуку.
 *
 * @return array{products: array<int,array>, cats: array<int,array>, subs: array<int,array>, intents: list<array>}
 */
function eli_search_index(PDO $pdo, bool $refresh = false): array
{
    static $mem = null;
    if ($mem !== null && !$refresh) {
        return $mem;
    }
    $file = __DIR__ . '/../storage/cache/eli-search-index.json';
    if (!$refresh && is_file($file) && (time() - (int) @filemtime($file)) < ELI_SEARCH_INDEX_TTL) {
        $data = json_decode((string) @file_get_contents($file), true);
        if (is_array($data) && ($data['v'] ?? 0) === ELI_SEARCH_INDEX_VERSION) {
            return $mem = $data;
        }
    }

    $hasFlag = true;
    try {
        $catRows = $pdo->query('SELECT id, name, name_en, search_only_on_match FROM categories')->fetchAll();
    } catch (Throwable $e) {
        $hasFlag = false; // міграцію 2026-10-17 ще не застосовано
        $catRows = $pdo->query('SELECT id, name, name_en, slug FROM categories')->fetchAll();
    }
    $cats = [];
    foreach ($catRows as $r) {
        $cats[(int) $r['id']] = [
            'name' => (string) $r['name'], 'name_en' => (string) ($r['name_en'] ?? ''),
            'sensitive' => $hasFlag ? (int) $r['search_only_on_match'] === 1 : (($r['slug'] ?? '') === 'religion'),
            'h' => eli_search_haystack($r['name'] . ' ' . ($r['name_en'] ?? '')), 'cnt' => 0,
        ];
    }
    try {
        $subRows = $pdo->query('SELECT id, category_id, name, name_en, search_only_on_match FROM subcategories')->fetchAll();
    } catch (Throwable $e) {
        $subRows = $pdo->query('SELECT id, category_id, name, name_en FROM subcategories')->fetchAll(); // міграцію 2026-10-23 ще не застосовано
    }
    $subs = [];
    foreach ($subRows as $r) {
        $subs[(int) $r['id']] = [
            'cat' => (int) $r['category_id'], 'name' => (string) $r['name'], 'name_en' => (string) ($r['name_en'] ?? ''),
            'sensitive' => (int) ($r['search_only_on_match'] ?? 0) === 1,
            'h' => eli_search_haystack($r['name'] . ' ' . ($r['name_en'] ?? '')), 'cnt' => 0,
        ];
    }

    $intents = [];
    try {
        foreach ($pdo->query('SELECT term_stem, category_id, subcategory_id, weight FROM search_intents')->fetchAll() as $r) {
            $intents[] = ['t' => mb_strtolower(trim((string) $r['term_stem'])), 'c' => $r['category_id'] !== null ? (int) $r['category_id'] : null,
                          's' => $r['subcategory_id'] !== null ? (int) $r['subcategory_id'] : null, 'w' => (float) $r['weight']];
        }
    } catch (Throwable $e) {
        // таблиці інтентів ще немає — пошук лише за текстом
    }

    $en = [];
    try {
        foreach ($pdo->query("SELECT product_id, field_name, translated_text FROM product_translations
                               WHERE lang = 'en' AND field_name IN ('short_description', 'full_description')")->fetchAll(PDO::FETCH_NUM) as [$pid, $f, $txt]) {
            $en[(int) $pid][$f] = (string) $txt;
        }
    } catch (Throwable $e) {
        // без перекладів — лише українські тексти
    }
    $pop = [];
    try {
        foreach ($pdo->query("SELECT page_id, COUNT(*) FROM page_views WHERE page_type = 'product' AND viewed_at >= NOW() - INTERVAL 90 DAY
                               AND page_id IS NOT NULL GROUP BY page_id")->fetchAll(PDO::FETCH_NUM) as [$pid, $n]) {
            $pop[(int) $pid] = (int) $n;
        }
    } catch (Throwable $e) {
    }

    $products = [];
    $rows = $pdo->query(
        "SELECT p.id, p.name, p.short_description, p.short_description_en, p.full_description, p.full_description_en,
                (SELECT GROUP_CONCAT(pc.category_id) FROM product_categories pc WHERE pc.product_id = p.id) AS cats,
                (SELECT GROUP_CONCAT(ps.subcategory_id) FROM product_subcategories ps WHERE ps.product_id = p.id) AS subs
           FROM products p WHERE p.status = 'published'"
    );
    while ($r = $rows->fetch()) {
        $pid = (int) $r['id'];
        $pc = array_values(array_filter(array_map('intval', explode(',', (string) $r['cats']))));
        $ps = array_values(array_filter(array_map('intval', explode(',', (string) $r['subs']))));
        foreach ($pc as $c) {
            if (isset($cats[$c])) {
                $cats[$c]['cnt']++;
            }
        }
        foreach ($ps as $s) {
            if (isset($subs[$s])) {
                $subs[$s]['cnt']++;
            }
        }
        $short = $r['short_description'] . ' ' . ($en[$pid]['short_description'] ?? $r['short_description_en'] ?? '');
        $full = $r['full_description'] . ' ' . ($en[$pid]['full_description'] ?? $r['full_description_en'] ?? '');
        $products[$pid] = [
            'n' => eli_search_haystack((string) $r['name']),
            'd' => eli_search_haystack($short),
            'f' => eli_search_haystack(mb_substr($full, 0, 4000)),
            'c' => $pc,
            's' => $ps,
            'p' => $pop[$pid] ?? 0,
        ];
    }

    $mem = ['v' => ELI_SEARCH_INDEX_VERSION, 'products' => $products, 'cats' => $cats, 'subs' => $subs, 'intents' => $intents];
    $dir = dirname($file);
    if (is_dir($dir) || @mkdir($dir, 0775, true)) {
        @file_put_contents($file . '.tmp', json_encode($mem, JSON_UNESCAPED_UNICODE), LOCK_EX);
        @rename($file . '.tmp', $file);
    }

    return $mem;
}

/**
 * Пошук: картки з балами або (якщо нічого впевненого) найближчі розділи.
 *
 * @return array{terms: list<string>, geo: list<string>, results: list<array{id:int, score:float, why:list<string>}>,
 *               sections: list<array{type:string, id:int}>}
 */
function eli_search(array $index, string $query, ?array $cfg = null): array
{
    $cfg ??= eli_search_config();
    $terms = eli_search_terms($query, $cfg);
    $isGeo = [];
    foreach ($terms as $t) {
        $isGeo[$t] = false;
        foreach ($cfg['geo'] as $g) {
            if (eli_search_stem_match($t, $g) > 0) {
                $isGeo[$t] = true;
                break;
            }
        }
    }

    // Інтенти для кожної основи запиту: subcat id => вага, cat id => вага.
    $termSubs = [];
    $termCats = [];
    $triggeredCats = [];
    $triggeredSubs = [];
    $focusSubs = []; // чутливі підкатегорії, про які запит саме (сильний інтент, вага ≥ 1)
    $sectionScore = [];
    foreach ($terms as $t) {
        foreach ($index['intents'] as $in) {
            $m = $in['t'] === '' ? 0.0 : eli_search_stem_match($t, $in['t']);
            if ($m <= 0) {
                continue;
            }
            if ($in['s'] !== null && $in['w'] >= 1 && ($index['subs'][$in['s']]['sensitive'] ?? false)) {
                $focusSubs[$in['s']] = true;
            }
            $in['w'] *= $m; // префіксний збіг слабший за точний («тренд» ≠ «трен»)
            if ($in['s'] !== null && isset($index['subs'][$in['s']])) {
                $termSubs[$t][$in['s']] = max($termSubs[$t][$in['s']] ?? 0, $in['w']);
                $triggeredCats[$index['subs'][$in['s']]['cat']] = true;
                $triggeredSubs[$in['s']] = true;
                $sectionScore['s' . $in['s']] = ($sectionScore['s' . $in['s']] ?? 0) + $in['w'];
            } elseif ($in['c'] !== null && isset($index['cats'][$in['c']])) {
                $termCats[$t][$in['c']] = max($termCats[$t][$in['c']] ?? 0, $in['w']);
                $triggeredCats[$in['c']] = true;
                $sectionScore['c' . $in['c']] = ($sectionScore['c' . $in['c']] ?? 0) + $in['w'] * 0.9;
            }
        }
        if ($isGeo[$t]) {
            continue;
        }
        // Слово з назви розділу теж «відкриває» чутливий розділ і підказує найближчі підкатегорії.
        foreach ($index['subs'] as $sid => $s) {
            // чутливу підкатегорію відкривають лише її інтенти: у назві є загальні слова («цифрова», «digital»)
            if (mb_strlen($t) >= 4 && !$s['sensitive'] && eli_search_in($s['h'], $t)) {
                $triggeredCats[$s['cat']] = true;
                $triggeredSubs[$sid] = true;
                $sectionScore['s' . $sid] = ($sectionScore['s' . $sid] ?? 0) + 0.8;
            }
        }
        foreach ($index['cats'] as $cid => $c) {
            if (mb_strlen($t) >= 4 && eli_search_in($c['h'], $t)) {
                $triggeredCats[$cid] = true;
            }
        }
    }

    $results = [];
    if ($terms !== []) {
        foreach ($index['products'] as $pid => $p) {
            // Чутливий розділ: усі категорії продукту чутливі й жодну не зачеплено запитом — пропускаємо.
            if ($p['c'] !== []) {
                $gated = true;
                foreach ($p['c'] as $cid) {
                    if (!($index['cats'][$cid]['sensitive'] ?? false) || isset($triggeredCats[$cid])) {
                        $gated = false;
                        break;
                    }
                }
                if ($gated) {
                    continue;
                }
            }
            // Запит прямо про чутливу тему (про померлих) — лише продукти її підкатегорії.
            if ($focusSubs !== [] && array_intersect_key(array_flip($p['s']), $focusSubs) === []) {
                continue;
            }
            // Те саме для підкатегорій: усі підкатегорії продукту чутливі й жодну не зачеплено.
            if ($p['s'] !== []) {
                $gated = true;
                foreach ($p['s'] as $sid) {
                    if (!($index['subs'][$sid]['sensitive'] ?? false) || isset($triggeredSubs[$sid])) {
                        $gated = false;
                        break;
                    }
                }
                if ($gated) {
                    continue;
                }
            }
            $score = 0.0;
            $qualified = false;
            $why = [];
            foreach ($terms as $t) {
                // Бал основи = найкращий інтент (5 × вага) + найкращий текстовий збіг (назва 3 / короткий опис 2 / повний 1).
                $intent = 0.0;
                $labels = [];
                foreach ($p['s'] as $sid) {
                    if (isset($termSubs[$t][$sid]) && 5 * $termSubs[$t][$sid] > $intent) {
                        $intent = 5 * $termSubs[$t][$sid];
                        $labels = ['інтент→підкатегорія'];
                    }
                }
                foreach ($p['c'] as $cid) {
                    if (isset($termCats[$t][$cid]) && 5 * $termCats[$t][$cid] > $intent) {
                        $intent = 5 * $termCats[$t][$cid];
                        $labels = ['інтент→категорія'];
                    }
                }
                $text = 0.0;
                if (eli_search_in($p['n'], $t)) {
                    $text = 3;
                    $labels[] = 'назва';
                } elseif (eli_search_in($p['d'], $t)) {
                    $text = 2;
                    $labels[] = 'короткий опис';
                } elseif (eli_search_in($p['f'], $t)) {
                    $text = 1;
                    $labels[] = 'повний опис';
                }
                $best = $intent + $text;
                if ($best <= 0) {
                    continue;
                }
                $label = implode('+', $labels);
                if ($isGeo[$t]) {
                    $best *= 0.5;
                    $label .= ', гео';
                } else {
                    $qualified = true;
                }
                $score += $best;
                $why[] = $t . ':' . $label . '+' . rtrim(rtrim(number_format($best, 1, '.', ''), '0'), '.');
            }
            if ($qualified && $score >= $cfg['threshold']) {
                $results[] = ['id' => (int) $pid, 'score' => $score, 'n' => count($why), 'pop' => $p['p'], 'why' => $why];
            }
        }
    }
    usort($results, static fn($a, $b) => [$b['score'], $b['n'], $b['pop'], $a['id']] <=> [$a['score'], $a['n'], $a['pop'], $b['id']]);
    $results = array_map(static fn($r) => ['id' => $r['id'], 'score' => $r['score'], 'why' => $r['why']], array_slice($results, 0, $cfg['max_cards']));

    // Найближчі розділи — лише для випадку «нічого впевненого».
    $sections = [];
    if ($results === []) {
        // чутливі розділи пропонуємо, лише якщо запит прямо про них (sectionScore тоді вже містить їх)
        arsort($sectionScore);
        foreach (array_keys($sectionScore) as $key) {
            $type = $key[0] === 's' ? 'sub' : 'cat';
            $id = (int) substr($key, 1);
            $row = $type === 'sub' ? ($index['subs'][$id] ?? null) : ($index['cats'][$id] ?? null);
            if ($row === null || $row['cnt'] === 0) {
                continue;
            }
            $sections[] = ['type' => $type, 'id' => $id];
            if (count($sections) >= 6) {
                break;
            }
        }
        if (count($sections) < 4) {
            $catsBySize = array_filter($index['cats'], static fn($c) => !$c['sensitive'] && $c['cnt'] > 0);
            uasort($catsBySize, static fn($a, $b) => $b['cnt'] <=> $a['cnt']);
            foreach (array_keys($catsBySize) as $cid) {
                if (count($sections) >= 6) {
                    break;
                }
                if (!in_array(['type' => 'cat', 'id' => (int) $cid], $sections, true)) {
                    $sections[] = ['type' => 'cat', 'id' => (int) $cid];
                }
            }
        }
    }

    return ['terms' => $terms, 'geo' => array_keys(array_filter($isGeo)), 'results' => $results, 'sections' => $sections];
}

/** Посилання на розділи для відповіді (назва поточною мовою). @return list<array{title:string, href:string}> */
function eli_search_section_links(array $index, array $sections, string $lang): array
{
    $out = [];
    foreach ($sections as $sec) {
        if ($sec['type'] === 'sub') {
            $s = $index['subs'][$sec['id']];
            $out[] = ['title' => ($lang === 'en' && $s['name_en'] !== '') ? $s['name_en'] : $s['name'], 'href' => 'catalog.php?subcategory=' . $sec['id']];
        } else {
            $c = $index['cats'][$sec['id']];
            $out[] = ['title' => ($lang === 'en' && $c['name_en'] !== '') ? $c['name_en'] : $c['name'], 'href' => 'category.php?id=' . $sec['id']];
        }
    }

    return $out;
}
