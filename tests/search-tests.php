<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести пошуку (app/search.php). ЛОКАЛЬНА база, лише CLI:  php tests/search-tests.php
 * Потрібні застосована міграція 2026-11-03-search-index.sql і побудований індекс.
 * Створює 3 тестові продукти SQL-вставкою (без PHP-форми), перевіряє самооновлення індексу,
 * наприкінці видаляє ЛИШЕ свої записи за id.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
$_SESSION = [];
require_once __DIR__ . '/../app/search.php';
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$pass = 0;
$fail = 0;
function check(bool $ok, string $msg): void
{
    global $pass, $fail;
    $ok ? $pass++ : $fail++;
    echo ($ok ? '  ok   ' : '  FAIL ') . $msg . "\n";
}
$names = static function (array $ids) use ($pdo): array {
    if ($ids === []) {
        return [];
    }
    $m = $pdo->query('SELECT id, name FROM products WHERE id IN (' . implode(',', array_map('intval', $ids)) . ')')->fetchAll(PDO::FETCH_KEY_PAIR);

    return array_map(static fn($i) => $m[$i] ?? '?', $ids);
};
$all = static fn(string $q): array => search_products($pdo, $q, 1, 100000, false);
$published = (int) $pdo->query("SELECT COUNT(*) FROM products WHERE status = 'published'")->fetchColumn();

echo "== Токенізація\n";
check(search_tokenize("Здоров’я, ЧАТ-бот і AI‑powered") === ['здоровя', 'чат', 'бот', 'чатбот', 'і', 'ai', 'powered', 'aipowered'], 'апострофи, регістр, дефіси (частини + злите слово)');
check(search_query_tokens('чат-бот') === ['чатбот'], 'у запиті слово з дефісом — одне злите');
check(search_token_rule('ai') === ['exact', 'ai'] && search_token_rule('фото') === ['prefix', 'фото'] && search_token_rule('фотографії') === ['prefix', 'фотограф'] && search_token_rule('відео') === ['prefix', 'віде'], 'правила довжини: 1–2 цілком, 3–4 початок, ≥5 max(4, n−2)');

echo "== Midjourney\n";
foreach (['Midjourney', 'midjourney', 'MIDJOURNEY', '  midjourney  '] as $q) {
    $r = $all($q);
    check($r['status'] === 'ok' && $names(array_slice($r['ids'], 0, 1)) === ['Midjourney'], "«{$q}»: Midjourney першим ({$r['total']})");
}

echo "== відео / video\n";
$uk = $all('відео');
$en = $all('video');
check($uk['total'] > 0, '«відео» не порожнє (' . $uk['total'] . ')');
$inter = count(array_intersect($uk['ids'], $en['ids']));
$union = count(array_unique(array_merge($uk['ids'], $en['ids'])));
check($union > 0 && $inter / $union >= 0.8, sprintf('набори «відео» і «video» перетинаються на %.0f%%', 100 * $inter / max(1, $union)));
$vm = (int) $pdo->query("SELECT COUNT(*) FROM search_index WHERE token LIKE 'відеомонтаж%'")->fetchColumn();
$vmIds = array_map('intval', $pdo->query("SELECT DISTINCT si.product_id FROM search_index si JOIN products p ON p.id = si.product_id AND p.status = 'published' WHERE si.token LIKE 'відеомонтаж%' LIMIT 50")->fetchAll(PDO::FETCH_COLUMN));
check($vm > 0 && array_diff($vmIds, $uk['ids']) === [], '«відео» знаходить продукти зі словом «відеомонтаж…»');
$both = $all('відео монтаж');
$ok = $both['total'] > 0 && $both['total'] < $uk['total'];
foreach (array_slice($both['ids'], 0, 30) as $pid) {
    $has = static function (string $like) use ($pdo, $pid): bool {
        $st = $pdo->prepare('SELECT COUNT(*) FROM search_index WHERE product_id = :p AND token LIKE :t');
        $st->execute([':p' => $pid, ':t' => $like]);

        return (int) $st->fetchColumn() > 0;
    };
    $ok = $ok && ($has('віде%') || $has('vide%') || $has('ролик%') || $has('відеор%'))
        && ($has('монта%') || $has('editi%') || $has('редаг%') || $has('edito%') || $has('редакт%'));
}
check($ok, "«відео монтаж»: обидва слова мають збігтися ({$both['total']} < {$uk['total']})");

echo "== ai / ШІ / короткі\n";
$hits = search_group_hits($pdo, search_query_groups($pdo, 'ai')[0]);
$aiVariants = ['ai', 'ші', 'аі', 'штучний', 'інтелект', 'artificial', 'intelligence'];
$emailOnly = $pdo->query("SELECT DISTINCT e.product_id FROM search_index e JOIN products p ON p.id = e.product_id AND p.status = 'published'
    WHERE e.token IN ('email', 'retail', 'training', 'emails', 'mailchimp')
      AND NOT EXISTS (SELECT 1 FROM search_index x WHERE x.product_id = e.product_id
                      AND (x.token IN ('ai', 'ші', 'аі') OR x.token LIKE 'штуч%' OR x.token LIKE 'artifici%'))
    LIMIT 200")->fetchAll(PDO::FETCH_COLUMN);
check($emailOnly !== [] && array_intersect_key($hits, array_flip(array_map('intval', $emailOnly))) === [],
    '«ai» не знаходить продукти лише з email / retail / training (' . count($emailOnly) . ' таких перевірено)');
foreach (['AI', 'ШІ', 'ai', 'АІ'] as $q) {
    $r = $all($q);
    check($r['status'] === 'broad' && $r['total'] <= search_config()['broad_top'], "«{$q}» — режим «надто загальний», {$r['total']} за назвою, не каталог");
}
foreach (['a', 'x', 'ab', 'zz', 'я', 'ії'] as $q) {
    $r = $all($q);
    check($r['total'] < $published * 0.1, "«{$q}» не повертає каталог ({$r['total']})");
}
$r = $all('інструмент для відео');
check($r['status'] === 'ok' && $r['total'] === $uk['total'] && in_array('інструмент', $r['broad_words'], true), '«інструмент для відео»: загальні слова не звужують і не розширюють видачу');

echo "== Синоніми\n";
$set = static fn(string $q): array => (static function (array $a): array { sort($a); return $a; })($all($q)['ids']);
check($set('фото') !== [] && $set('фото') === $set('photo'), 'фото = photo (' . count($set('фото')) . ')');
$tr = $set('переклад');
check($tr !== [] && $tr === $set('translate') && $tr === $set('translation'), 'переклад = translate = translation (' . count($tr) . ')');
$cb = $set('чат-бот');
check($cb !== [] && $cb === $set('chatbot') && $cb === $set('чатбот'), 'чат-бот = chatbot = чатбот (' . count($cb) . ')');
check($all('фотографії')['total'] > 0, '«фотографії» знаходить «фотографія…»');
check($set('штучний інтелект') === $set('ШІ'), 'фраза-синонім «штучний інтелект» = ШІ');

echo "== Нормалізація й безпека\n";
check($set("здоров'я") === $set('здоров’я') && $set('здоров’я') === $set('здоровʼя') && $set("здоров'я") !== [], 'апострофи \' ’ ʼ однакові');
check($set('  Photo    ') === $set('photo') && $set('PHOTO') === $set('photo'), 'зайві пробіли й регістр');
foreach (["' OR 1=1 --", '%', '_', '%%%', "photo'; DROP TABLE products; --", '\\', '<script>alert(1)</script>', '😀😀'] as $q) {
    try {
        $r = $all($q);
        check(in_array($r['status'], ['ok', 'empty', 'invalid', 'broad'], true) && $r['total'] < $published, 'SQL-символи: ' . json_encode($q, JSON_UNESCAPED_UNICODE) . " → {$r['status']} ({$r['total']})");
    } catch (Throwable $e) {
        check(false, 'SQL-символи: ' . $q . ' — виняток ' . $e->getMessage());
    }
}
$long = str_repeat('відео ', 200);
$r = $all($long);
check(mb_strlen($r['query']) <= SEARCH_MAX_QUERY && $r['status'] === 'ok', 'дуже довгий запит обрізано до 100 символів');
check($all('')['status'] === 'invalid' && $all('   ')['status'] === 'invalid' && $all('!!!')['status'] === 'invalid', 'порожній запит — invalid, без видачі');
$lay = search_products($pdo, 'ьшвощгктун', 1, 10, false);
check($lay['layout'] === 'midjourney' && $names(array_slice($lay['ids'], 0, 1)) === ['Midjourney'], 'розкладка: «ьшвощгктун» → midjourney');
check(count(search_matching_sections($pdo, 'відео')) > 0, 'порожня видача: розділи, що відповідають запиту, є');
check(!array_diff(array_slice($uk['ids'], 0, 50), array_map('intval', $pdo->query("SELECT id FROM products WHERE status = 'published'")->fetchAll(PDO::FETCH_COLUMN))), 'лише опубліковані');

echo "== Самооновлення (3 продукти SQL-вставкою)\n";
$ids = [];
try {
    $ins = $pdo->prepare("INSERT INTO products (name, short_description, short_description_en, full_description, main_features, status, created_at, updated_at)
                          VALUES (:n, :s, :se, :f, :mf, 'published', NOW(), NOW())");
    $rows = [
        ['Qzvtest Аквареліст', 'Перетворює фотографії на акварельні картини', 'Turns photos into watercolor paintings', 'Повний опис квазітестового сервісу.', 'акварель, стиль'],
        ['Qzvtest Lingvo', 'Синхронний переклад зустрічей', 'Live meeting translation', 'Квазітестовий перекладач.', 'субтитри'],
        ['Qzvtest Монтажер', 'Автоматичний відеомонтаж кліпів', 'Automatic video editing of clips', 'Квазітестовий монтаж відео.', 'кліпи'],
    ];
    foreach ($rows as [$n, $s, $se, $f, $mf]) {
        $ins->execute([':n' => $n, ':s' => $s, ':se' => $se, ':f' => $f, ':mf' => $mf]);
        $ids[] = (int) $pdo->lastInsertId();
    }
    echo '  створено id ' . implode(', ', $ids) . "\n";
    check($all('qzvtest')['total'] === 0, 'до самооновлення індекс ще не знає нові продукти');
    $sync = search_index_sync($pdo, 100);
    check($sync['written'] >= 3, "search_index_sync дописав {$sync['written']} (перевірено {$sync['checked']})");
    $r = $all('qzvtest');
    check($r['total'] === 3, "«qzvtest» → 3 нові продукти ({$r['total']})");
    check(array_intersect($ids, $all('акварель')['ids']) === [$ids[0]], '«акварель» (функції) → Аквареліст');
    check(in_array($ids[0], $all('photo')['ids'], true), 'англомовний опис (photos) → photo знаходить новий продукт');
    check(in_array($ids[1], $all('переклад')['ids'], true) && in_array($ids[2], $all('відео')['ids'], true), 'переклад → Lingvo, відео → Монтажер (відеомонтаж)');
    // Зміна SQL-оновленням — індекс перепише продукт.
    $pdo->prepare("UPDATE products SET short_description = 'Генерує 3D-моделі меблів', updated_at = NOW() + INTERVAL 1 SECOND WHERE id = :id")->execute([':id' => $ids[0]]);
    $GLOBALS['__search_resync'] = true;
    $sig = search_index_signature($pdo);
    $changed = $pdo->query("SELECT COUNT(*) FROM products p JOIN search_index_state s ON s.product_id = p.id WHERE p.id = {$ids[0]} AND p.updated_at > s.indexed_at")->fetchColumn();
    search_index_products($pdo, [$ids[0]]);
    check((int) $changed === 1 && in_array($ids[0], $all('меблі')['ids'], true) && !in_array($ids[0], $all('картини')['ids'], true) && in_array($ids[0], $all('акварель')['ids'], true), 'зміна опису SQL-оновленням → продукт переписано (старі слова зникли)');
    $pdo->prepare("UPDATE products SET status = 'in_progress' WHERE id = :id")->execute([':id' => $ids[1]]);
    check(!in_array($ids[1], $all('qzvtest')['ids'], true), 'зняття з публікації → зникає з видачі (JOIN зі статусом)');
} finally {
    if ($ids !== []) {
        $in = implode(',', $ids);
        $pdo->exec("DELETE FROM search_index WHERE product_id IN ($in)");
        $pdo->exec("DELETE FROM search_index_state WHERE product_id IN ($in)");
        $del = $pdo->exec("DELETE FROM products WHERE id IN ($in) AND name LIKE 'Qzvtest %'");
        echo "  видалено тестових продуктів: $del (id $in) + їхні рядки індексу\n";
    }
    // Сигнатура після тестів — актуальна (тестові продукти вже прибрано).
    [$a, $b] = search_index_signature($pdo);
    search_setting_set($pdo, 'search_index_sig', $a . ':' . $b);
}

echo "\nРазом: " . ($pass + $fail) . ", помилок: $fail\n";
exit($fail > 0 ? 1 : 0);
