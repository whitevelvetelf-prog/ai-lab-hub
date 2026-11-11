<?php

declare(strict_types=1);

/**
 * AI LAB HUB — актуальність перекладів тексту продукту після редагування.
 *
 * Причина старих EN-текстів: cached_translation() (app/translation-cache.php) повертає наявний рядок
 * product_translations, якщо він є, і не знає, чи змінився оригінал; crm-edit-product.php переклади
 * не скидав. Застарілими лишалися і рядки source='manual' (їх пишуть пакети SQL; у формі редагування
 * EN-полів немає, тож виправити їх у CRM було неможливо), і колонки products.*_en (запасне джерело
 * для карток у списках, app/translations.php: localized_short_descriptions()).
 *
 * Тепер у crm-edit-product.php:
 *   1. product_text_changes() — які з PRODUCT_TRANSLATABLE_FIELDS змінились (порівняння до/після);
 *   2. product_translations_invalidate() — у тій самій транзакції для ЛИШЕ цих полів очищує переклади
 *      всіма мовами, крім мови оригіналу (і auto, і manual): translated_text = '', source = 'auto',
 *      updated_at без змін (рядок не видаляється — його час лишається міткою для ліміту); порожній рядок
 *      усі читачі вважають відсутнім перекладом. Також очищує products.<поле>_<мова>;
 *   3. product_retranslate() — після коміту перекладає змінені поля наявною логікою (Google Translation,
 *      один пакетний запит на мову, запис source='auto'), якщо дозволяє ліміт;
 *   4. сторінка продукту (product.php) перекладає відсутнє через product_localized_field() з тим самим лімітом.
 *
 * Ліміт: не частіше ніж раз на PRODUCT_RETRANSLATE_COOLDOWN секунд на продукт — ознака «нещодавно
 * перекладали» = рядок product_translations цього продукту з source='auto' і updated_at у межах вікна
 * (рішення про дозвіл ухвалюється до очищення, щоб очищення в тому ж запиті його не змінило).
 * Поки ліміт діє, змінене поле показується мовою оригіналу (картки — з lang="uk"), без звернення до API.
 * Усі поля одного продукту в межах одного запиту перекладаються разом (дозвіл запам'ятовується на запит).
 */

require_once __DIR__ . '/translation-cache.php';

/** Текстові поля продукту, що перекладаються (як на product.php). */
const PRODUCT_TRANSLATABLE_FIELDS = ['short_description', 'full_description', 'main_features', 'target_audience'];

/** Не частіше одного перекладу продукту за стільки секунд. */
const PRODUCT_RETRANSLATE_COOLDOWN = 300;

/**
 * Які перекладні поля змінились. Порожнє й NULL — однаково; пробіли на краях не враховуються.
 *
 * @param array<string,mixed> $before рядок products до збереження
 * @param array<string,mixed> $after  нові значення
 * @return list<string>
 */
function product_text_changes(array $before, array $after): array
{
    $changed = [];
    foreach (PRODUCT_TRANSLATABLE_FIELDS as $f) {
        if (trim((string) ($before[$f] ?? '')) !== trim((string) ($after[$f] ?? ''))) {
            $changed[] = $f;
        }
    }

    return $changed;
}

/**
 * Скидає переклади змінених полів: очищує рядки product_translations усіма мовами, крім оригіналу
 * (без видалення, updated_at зберігається), і колонки products.<поле>_<мова> (якщо такі є).
 * Повертає кількість очищених рядків перекладу.
 *
 * @param list<string> $fields
 */
function product_translations_invalidate(PDO $pdo, int $productId, array $fields): int
{
    $fields = array_values(array_intersect($fields, PRODUCT_TRANSLATABLE_FIELDS));
    if ($fields === []) {
        return 0;
    }
    product_retranslate_gate($pdo, $productId);   // дозвіл на переклад — за станом ДО очищення
    $src = translation_source_lang();
    $in = implode(',', array_fill(0, count($fields), '?'));
    $st = $pdo->prepare(
        "UPDATE product_translations SET translated_text = '', source = 'auto', updated_at = updated_at
          WHERE product_id = ? AND lang <> ? AND field_name IN ($in) AND (translated_text <> '' OR source <> 'auto')"
    );
    $st->execute(array_merge([$productId, $src], $fields));
    $cleared = $st->rowCount();

    $existing = array_flip(array_map(static fn(array $c): string => (string) $c['Field'], $pdo->query('SHOW COLUMNS FROM products')->fetchAll(PDO::FETCH_ASSOC)));
    $set = [];
    foreach (active_lang_codes() as $lang) {
        if ($lang === $src) {
            continue;
        }
        foreach ($fields as $f) {
            $col = $f . '_' . preg_replace('/[^a-z]/', '', $lang);
            if (isset($existing[$col])) {
                $set[] = "`$col` = NULL";
            }
        }
    }
    if ($set !== []) {
        // updated_at не чіпаємо: його щойно виставив UPDATE форми.
        $pdo->prepare('UPDATE products SET ' . implode(', ', $set) . ', updated_at = updated_at WHERE id = :id')->execute([':id' => $productId]);
    }

    return $cleared;
}

/**
 * Функція перекладу за замовчуванням: google_translate_batch. Лише тести можуть підставити іншу, визначивши
 * константу PRODUCT_TRANSLATE_FN до виклику (як AIS_FILE в app/ai-statement.php); на сайті її ніхто не визначає.
 */
function product_translate_fn(): callable
{
    return defined('PRODUCT_TRANSLATE_FN') ? constant('PRODUCT_TRANSLATE_FN') : 'google_translate_batch';
}

/** Чи можна зараз звертатися до API перекладу для продукту (ліміт PRODUCT_RETRANSLATE_COOLDOWN). */
function product_retranslate_allowed(PDO $pdo, int $productId): bool
{
    $st = $pdo->prepare(
        "SELECT 1 FROM product_translations
          WHERE product_id = :p AND source = 'auto' AND updated_at >= NOW() - INTERVAL " . PRODUCT_RETRANSLATE_COOLDOWN . ' SECOND LIMIT 1'
    );
    $st->execute([':p' => $productId]);

    return $st->fetchColumn() === false;
}

/**
 * Дозвіл на переклад продукту в межах поточного запиту: перевіряється один раз, далі запам'ятовується,
 * щоб усі поля сторінки переклались разом (інакше перше ж записане поле заблокувало б наступні).
 */
function product_retranslate_gate(PDO $pdo, int $productId, ?bool $set = null): bool
{
    static $memo = [];
    if ($set !== null) {
        return $memo[$productId] = $set;
    }

    return $memo[$productId] ??= product_retranslate_allowed($pdo, $productId);
}

/**
 * Перекладає вказані поля продукту всіма активними мовами, крім оригіналу (один пакетний запит на мову),
 * і записує source='auto'. Нічого не робить, якщо діє ліміт. Повертає кількість записаних перекладів.
 *
 * @param list<string> $fields
 * @param callable|null $translate форма google_translate_batch(texts, target, source): ?list<string> (тести)
 */
function product_retranslate(PDO $pdo, int $productId, array $fields, ?callable $translate = null): int
{
    $fields = array_values(array_intersect($fields, PRODUCT_TRANSLATABLE_FIELDS));
    if ($fields === [] || !product_retranslate_gate($pdo, $productId)) {
        return 0;
    }
    $st = $pdo->prepare('SELECT ' . implode(', ', $fields) . ' FROM products WHERE id = :id');
    $st->execute([':id' => $productId]);
    $row = $st->fetch(PDO::FETCH_ASSOC);
    if ($row === false) {
        return 0;
    }
    $send = [];
    foreach ($fields as $f) {
        if (trim((string) ($row[$f] ?? '')) !== '') {
            $send[$f] = (string) $row[$f];
        }
    }
    if ($send === []) {
        return 0;
    }
    $translate ??= product_translate_fn();
    $src = translation_source_lang();
    $n = 0;
    foreach (active_lang_codes() as $lang) {
        if ($lang === $src) {
            continue;
        }
        $out = $translate(array_values($send), $lang, $src);
        if (!is_array($out) || count($out) !== count($send)) {
            continue; // мережа / ключ — сторінка продукту спробує пізніше
        }
        foreach (array_keys($send) as $i => $f) {
            $text = (string) $out[$i];
            if (trim($text) === '') {
                continue;
            }
            translation_store($pdo, 'product_translations', ['product_id' => $productId, 'field_name' => $f], $lang, $text, 'auto');
            $n++;
        }
    }

    return $n;
}

/**
 * Поле продукту поточною мовою для product.php: готовий переклад → інакше (якщо дозволяє ліміт)
 * автопереклад і кешування → інакше оригінал.
 *
 * @param array<string,mixed> $product рядок products з 'id'
 * @param callable|null $translate форма google_translate_batch (тести)
 */
function product_localized_field(PDO $pdo, array $product, string $field, ?string $lang = null, ?callable $translate = null): string
{
    $source = (string) ($product[$field] ?? '');
    $lang ??= current_lang();
    $src = translation_source_lang();
    if ($lang === $src || trim($source) === '') {
        return $source;
    }
    $pid = (int) $product['id'];
    $cached = translation_lookup($pdo, 'product_translations', ['product_id' => $pid, 'field_name' => $field], $lang);
    if ($cached !== null && trim($cached['translated_text']) !== '') {
        return $cached['translated_text'];
    }
    if (!product_retranslate_gate($pdo, $pid)) {
        return $source;
    }
    $translate ??= product_translate_fn();
    $out = $translate([$source], $lang, $src);
    $text = is_array($out) ? (string) ($out[0] ?? '') : '';
    if (trim($text) === '') {
        return $source;
    }
    translation_store($pdo, 'product_translations', ['product_id' => $pid, 'field_name' => $field], $lang, $text, 'auto');

    return $text;
}
