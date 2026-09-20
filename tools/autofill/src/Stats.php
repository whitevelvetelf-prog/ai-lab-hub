<?php
declare(strict_types=1);

final class Stats
{
    /** @return array<string,int> підкатегорія → кількість (існуючі + готові в пайплайні) */
    public static function counts(): array
    {
        $pdo = Db::pdo();
        $counts = array_fill_keys(Taxonomy::all(), 0);

        foreach ($pdo->query('SELECT subcats FROM existing') as $r) {
            foreach (array_filter(array_map('trim', explode('|', (string)$r['subcats']))) as $s) {
                if (isset($counts[$s])) {
                    $counts[$s]++;
                }
            }
        }
        // Пайплайн: valid/exported, яких ще немає в existing (щоб не рахувати двічі після перезавантаження CSV)
        $q = "SELECT data_json FROM candidates WHERE stage IN ('valid','exported') AND domain NOT IN (SELECT domain FROM existing)";
        foreach ($pdo->query($q) as $r) {
            $d = json_decode((string)$r['data_json'], true);
            foreach (array_unique($d['categories'] ?? []) as $s) {
                if (isset($counts[$s])) {
                    $counts[$s]++;
                }
            }
        }
        return $counts;
    }

    public static function show(): void
    {
        $pdo = Db::pdo();
        out('Стадії пайплайну:');
        foreach ($pdo->query('SELECT stage, COUNT(*) c FROM candidates GROUP BY stage ORDER BY c DESC') as $r) {
            echo "  {$r['stage']}: {$r['c']}\n";
        }
        $t = $pdo->query('SELECT COALESCE(SUM(tokens_in),0) i, COALESCE(SUM(tokens_out),0) o FROM candidates')->fetch();
        $usd = ($t['i'] * (float)cfg('price_in_per_mtok', 1) + $t['o'] * (float)cfg('price_out_per_mtok', 5)) / 1e6;
        printf('Токени enrich: %d in / %d out ≈ $%.2f' . PHP_EOL, $t['i'], $t['o'], $usd);
        self::gaps();
    }

    public static function gaps(): void
    {
        $min = (int)cfg('min_per_subcategory', 10);
        $c = self::counts();
        asort($c);
        $low = 0;
        $lack = 0;
        foreach ($c as $s => $n) {
            if ($n < $min) {
                echo sprintf("  %-55s %d / %d\n", $s, $n, $min);
                $low++;
                $lack += $min - $n;
            }
        }
        out("Підкатегорій нижче $min: $low; бракує приблизно $lack продуктів");
    }
}
