<?php

declare(strict_types=1);

/**
 * AI LAB HUB — спільна логіка пошуку продуктів за назвою.
 *
 * Використовують:
 *   - public/api-search.php   — живі підказки під полем у шапці;
 *   - public/catalog.php      — повна видача за Enter (?search=).
 *
 * Підключати після config/database.php не потрібно — файл лише оголошує
 * функції/константу, підключення БД передається викликачем:
 *   require_once __DIR__ . '/../app/search.php';
 */

/**
 * Розкладка ЙЦУКЕН (укр., стандартна) <-> QWERTY за фізичним положенням
 * клавіш. Бренднейми продуктів — завжди латиницею; якщо в користувача
 * активна українська розкладка, такий запит набирається кирилицею
 * («Notion» -> «Тщешщт»). search_products_by_name() перемаповує символи
 * в обидва боки, якщо прямий запит нічого не знайшов.
 */
const LAYOUT_UA_TO_LATIN = [
    'й' => 'q', 'ц' => 'w', 'у' => 'e', 'к' => 'r', 'е' => 't', 'н' => 'y',
    'г' => 'u', 'ш' => 'i', 'щ' => 'o', 'з' => 'p', 'х' => '[', 'ї' => ']',
    'ф' => 'a', 'і' => 's', 'в' => 'd', 'а' => 'f', 'п' => 'g', 'р' => 'h',
    'о' => 'j', 'л' => 'k', 'д' => 'l', 'ж' => ';', 'є' => "'",
    'я' => 'z', 'ч' => 'x', 'с' => 'c', 'м' => 'v', 'и' => 'b', 'т' => 'n',
    'ь' => 'm', 'б' => ',', 'ю' => '.',
];

/** Перемапити рядок символ-за-символом за таблицею розкладки (нижній регістр). */
function remap_layout(string $text, array $map): string
{
    $chars = mb_str_split(mb_strtolower($text));
    $out = '';
    foreach ($chars as $ch) {
        $out .= $map[$ch] ?? $ch;
    }

    return $out;
}

/** Екранувати спецсимволи LIKE (% і _), щоб вони не діяли як вайлдкарди. */
function like_escape(string $value): string
{
    return addcslashes($value, '%_\\');
}

/**
 * Пошук опублікованих продуктів за підрядком назви (найкращі збіги —
 * ті, що починаються з запиту — першими). Якщо прямий запит нічого не
 * знайшов, пробує розкладку УКР<->ЛАТ в обидва боки.
 *
 * @param string   $columns SQL-список колонок SELECT — лише статичний
 *                          рядок із коду виклику, не з користувацького вводу.
 * @param int|null $limit   LIMIT результату або null без обмеження.
 */
function search_products_by_name(PDO $pdo, string $query, string $columns, ?int $limit = null): array
{
    $run = static function (string $needle) use ($pdo, $columns, $limit): array {
        $sql = "SELECT {$columns}
                FROM products
                WHERE status = 'published' AND name LIKE :contains
                ORDER BY CASE WHEN name LIKE :prefix THEN 0 ELSE 1 END, name";
        if ($limit !== null) {
            $sql .= ' LIMIT ' . $limit;
        }

        $stmt = $pdo->prepare($sql);
        $escaped = like_escape($needle);
        $stmt->execute([
            ':contains' => '%' . $escaped . '%',
            ':prefix' => $escaped . '%',
        ]);

        return $stmt->fetchAll();
    };

    $results = $run($query);
    if ($results !== []) {
        return $results;
    }

    $layoutLatinToUa = array_flip(LAYOUT_UA_TO_LATIN);
    foreach ([remap_layout($query, LAYOUT_UA_TO_LATIN), remap_layout($query, $layoutLatinToUa)] as $alt) {
        if ($alt !== '' && $alt !== mb_strtolower($query)) {
            $results = $run($alt);
            if ($results !== []) {
                return $results;
            }
        }
    }

    return [];
}
