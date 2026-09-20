<?php
declare(strict_types=1);

/** Закритий список "Категорія › Підкатегорія" з taxonomy.csv (колонки: category,subcategory). */
final class Taxonomy
{
    private static ?array $rows = null;

    /** @return array<int,array{0:string,1:string}> */
    public static function rows(): array
    {
        if (self::$rows === null) {
            $f = dirname(__DIR__) . '/taxonomy.csv';
            if (!is_file($f)) {
                throw new RuntimeException('Немає taxonomy.csv');
            }
            $rows = [];
            $h = fopen($f, 'r');
            $first = true;
            while (($r = fgetcsv($h, 0, ',', '"', '')) !== false) {
                if ($first) {
                    $first = false;
                    $r[0] = preg_replace('/^\xEF\xBB\xBF/', '', (string)($r[0] ?? '')) ?? '';
                    if (strtolower(trim($r[0])) === 'category') {
                        continue;
                    }
                }
                if (count($r) < 2 || trim((string)$r[0]) === '') {
                    continue;
                }
                $rows[] = [trim($r[0]), trim($r[1])];
            }
            fclose($h);
            self::$rows = $rows;
        }
        return self::$rows;
    }

    /** @return string[] */
    public static function all(): array
    {
        return array_map(fn($r) => $r[0] . ' › ' . $r[1], self::rows());
    }

    /** "Кат › Підкат" → [Кат, Підкат] */
    public static function split(string $label): array
    {
        $p = explode(' › ', $label, 2);
        return [trim($p[0]), trim($p[1] ?? '')];
    }
}
