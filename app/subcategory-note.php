<?php

declare(strict_types=1);

/**
 * AI LAB HUB — примітка-застереження для чутливих підкатегорій каталогу.
 *
 * Показується над списком продуктів підкатегорії (public/catalog.php) і на картці кожного продукту,
 * прив'язаного до неї (public/product.php). Тексти — у системі перекладів інтерфейсу: UA в
 * app/translations.php, EN — у ui_translations (database/increment_latest.sql).
 * Стиль спокійний: світлий текст на темному фоні, без тривожних кольорів.
 *
 *   echo subcategory_note_html(['mental-health-eating-behavior']);   // slug-и підкатегорій
 *   echo product_note_html($pdo, $productId);                        // додаткова примітка продукту (products.note_key)
 */

/** slug підкатегорії => ключ тексту примітки (t()). */
const SUBCATEGORY_NOTES = [
    'mental-health-eating-behavior' => 'subcat_note_mental_health_eating',
    'parenting' => 'subcat_note_parenting',
    'dog-training' => 'subcat_note_dog_training',
    'working-dogs' => 'subcat_note_working_dogs',
    'digital-memory-legacy' => 'subcat_note_digital_memory',
];

/** Дозволені значення products.note_key (ключ тексту t()) — додаткова примітка на картці окремих продуктів. */
const PRODUCT_NOTES = [
    'product_note_simulation',   // розмовні копії й цифрові двійники («Цифрова пам'ять і спадщина»)
];

/** HTML приміток для переданих slug-ів підкатегорій (кожна — один раз); '' — приміток немає. */
function subcategory_note_html(array $slugs): string
{
    $keys = [];
    foreach ($slugs as $slug) {
        $key = SUBCATEGORY_NOTES[(string) $slug] ?? null;
        if ($key !== null) {
            $keys[$key] = true;
        }
    }
    if ($keys === []) {
        return '';
    }

    return subcategory_note_render(array_keys($keys));
}

/** Додаткова примітка продукту за products.note_key; '' — немає (або міграцію 2026-10-23 ще не застосовано). */
function product_note_html(PDO $pdo, int $productId): string
{
    try {
        $st = $pdo->prepare('SELECT note_key FROM products WHERE id = :id');
        $st->execute([':id' => $productId]);
        $key = (string) $st->fetchColumn();
    } catch (Throwable $e) {
        return '';
    }

    return in_array($key, PRODUCT_NOTES, true) ? subcategory_note_render([$key]) : '';
}

/** @param list<string> $keys ключі текстів приміток */
function subcategory_note_render(array $keys): string
{
    static $styled = false;
    $html = '';
    if (!$styled) {
        $styled = true;
        $html .= '<style>.subcat-note{display:flex;gap:12px;align-items:flex-start;margin:0 0 24px;padding:14px 18px;'
            . 'border:1px solid rgba(255,255,255,.18);border-radius:14px;background:rgba(0,3,44,.55);color:rgba(255,255,255,.9);'
            . 'font-size:.95rem;line-height:1.55}.subcat-note svg{flex-shrink:0;width:20px;height:20px;margin-top:2px;color:#bcd0ff}'
            . '.subcat-note p{margin:0}</style>';
    }
    foreach ($keys as $key) {
        $html .= '<aside class="subcat-note" role="note">'
            . '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="10"/><path d="M12 16v-4"/><path d="M12 8h.01"/></svg>'
            . '<p>' . htmlspecialchars(t($key), ENT_QUOTES) . '</p></aside>';
    }

    return $html;
}
