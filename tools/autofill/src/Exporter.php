<?php
declare(strict_types=1);

/**
 * valid → exported. Генерує ІДЕМПОТЕНТНІ SQL-пакети для вкладки SQL у phpMyAdmin:
 * повторний імпорт того ж файлу нічого не дублює (INSERT ... WHERE NOT EXISTS за website;
 * категорії/тарифи додаються лише для щойно створених продуктів). Живу базу скрипт напряму не чіпає.
 *
 * website порівнюється НОРМАЛІЗОВАНО (без http(s)://, www., кінцевого слеша, регістру): у БД є
 * «https://www.visme.co», а канонічний URL кандидата — «https://visme.co/». Без цього SQL-запобіжник
 * пропускав би дублі. Працює на MySQL 5.7+/MariaDB (лише REPLACE/TRIM, без REGEXP_REPLACE).
 */
final class Exporter
{
    public static function run(): void
    {
        $map = require dirname(__DIR__) . '/schema_map.php';
        $pdo = Db::pdo();
        $rows = $pdo->query("SELECT * FROM candidates WHERE stage='valid' AND batch_no IS NULL ORDER BY id")->fetchAll();
        if (!$rows) {
            out('Немає карток зі статусом valid для експорту');
            return;
        }
        $dir = (string)cfg('paths.export');
        if (!is_dir($dir)) {
            mkdir($dir, 0777, true);
        }
        $batchNo = (int)$pdo->query('SELECT COALESCE(MAX(batch_no),0) FROM candidates')->fetchColumn();
        $size = max(1, (int)cfg('export_batch_size', 100));
        $mark = $pdo->prepare("UPDATE candidates SET stage='exported', batch_no=?, updated_at=CURRENT_TIMESTAMP WHERE id=?");

        foreach (array_chunk($rows, $size) as $chunk) {
            $batchNo++;
            $tag = sprintf('batch_%04d', $batchNo);
            $sql = ['-- AI LAB HUB: пакет ' . $tag . ', продуктів: ' . count($chunk) . ', ' . date('Y-m-d H:i'),
                'SET NAMES utf8mb4;', 'START TRANSACTION;', ''];
            $logos = [];

            foreach ($chunk as $c) {
                $d = json_decode((string)$c['data_json'], true);
                if (!is_array($d)) {
                    continue;
                }
                $slug = trim(preg_replace('/[^a-z0-9]+/', '-', strtolower($c['domain'])) ?? '', '-');
                $logoPath = null;
                if (!empty($c['logo_file'])) {
                    $src = cfg('paths.data') . '/logos/' . $c['logo_file'];
                    if (is_file($src)) {
                        $logoName = $slug . '.' . pathinfo($c['logo_file'], PATHINFO_EXTENSION);
                        $logos[$src] = $logoName;
                        $logoPath = $map['logo_prefix'] . $logoName;
                    }
                }
                foreach (self::productSql($c, $d, $map, $logoPath) as $line) {
                    $sql[] = $line;
                }
                $sql[] = '';
                $mark->execute([$batchNo, $c['id']]);
            }
            $sql[] = 'COMMIT;';
            file_put_contents("$dir/$tag.sql", implode("\n", $sql) . "\n");

            $zipInfo = '';
            if ($logos && class_exists('ZipArchive')) {
                $z = new ZipArchive();
                if ($z->open("$dir/{$tag}_logos.zip", ZipArchive::CREATE | ZipArchive::OVERWRITE) === true) {
                    foreach ($logos as $src => $name) {
                        $z->addFile($src, $name);
                    }
                    $z->close();
                    $zipInfo = ', логотипів: ' . count($logos) . " ({$tag}_logos.zip)";
                }
            }
            out("Експорт: $dir/$tag.sql — " . count($chunk) . " продуктів$zipInfo");
        }
        out('Далі: залий логотипи на хостинг (папка з schema_map.php → logo_prefix), потім виконай .sql у phpMyAdmin.');
    }

    /** Список для ручної роботи (сайти, що блокують ботів, порожні SPA, помилки) — у вашому звичному ручному процесі. */
    public static function manual(): void
    {
        $dir = (string)cfg('paths.export');
        if (!is_dir($dir)) {
            mkdir($dir, 0777, true);
        }
        $rows = Db::pdo()->query("SELECT id, url, name_hint, stage, note FROM candidates WHERE stage IN ('manual','error') ORDER BY id")->fetchAll();
        $f = fopen("$dir/manual.csv", 'w');
        fwrite($f, "\xEF\xBB\xBF");
        fputcsv($f, ['id', 'url', 'name_hint', 'stage', 'note'], ',', '"', '');
        foreach ($rows as $r) {
            fputcsv($f, [$r['id'], $r['url'], $r['name_hint'], $r['stage'], $r['note']], ',', '"', '');
        }
        fclose($f);
        out("Записано $dir/manual.csv: " . count($rows) . ' рядків');
    }

    /** Нормалізація URL у PHP — та сама, що normSql() у SQL. */
    private static function normUrl(string $url): string
    {
        $u = strtolower(trim($url));
        foreach (['https://www.', 'http://www.', 'https://', 'http://'] as $prefix) {
            $u = str_replace($prefix, '', $u);
        }
        return rtrim($u, '/');
    }

    /** SQL-вираз нормалізації колонки з URL (див. normUrl). */
    private static function normSql(string $col): string
    {
        return "LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`$col`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', '')))";
    }

    private static function q($v): string
    {
        if ($v === null) {
            return 'NULL';
        }
        if (is_array($v) && isset($v['raw'])) {
            return (string)$v['raw'];
        }
        if (is_int($v) || is_float($v)) {
            return (string)$v;
        }
        return "'" . strtr((string)$v, [
            '\\' => '\\\\', "'" => "\\'", '"' => '\\"', "\0" => '\\0', "\n" => '\\n', "\r" => '\\r', "\x1a" => '\\Z',
        ]) . "'";
    }

    /** @return string[] */
    private static function productSql(array $c, array $d, array $map, ?string $logoPath): array
    {
        $P = $map['products'];
        $v = $map['values'];
        $pt = $P['table'];
        $idCol = $P['id'] ?? 'id';
        $siteCol = $P['cols']['website'];
        // Кореневий URL у БД зберігається без кінцевого слеша («https://www.visme.co»).
        $siteUrl = (string)preg_replace('#^(https?://[^/]+)/$#i', '$1', (string)$c['url']);
        $siteQ = self::q(self::normUrl($siteUrl));
        $siteMatch = self::normSql($siteCol) . " = $siteQ";

        $row = [
            'name'         => $d['name'] ?? null,
            'logo'         => $logoPath,
            'website'      => $siteUrl,
            'short'        => $d['short_description'] ?? null,
            'full'         => $d['full_description'] ?? null,
            'monetization' => $v['monetization'][$d['monetization_model'] ?? ''] ?? ($d['monetization_model'] ?? null),
            'features'     => implode((string)$v['features_sep'], array_map('strval', (array)($d['features'] ?? []))) ?: null,
            'audience'     => $d['target_audience'] ?? null,
            'platform'     => implode((string)$v['platform_sep'], (array)($d['platforms'] ?? [])) ?: null, // NULL, а не '' — як у CRM
            'skill'        => $v['skill'][$d['skill_level'] ?? ''] ?? null,
            'status'       => $v['status'],
            'partnership'  => $v['partnership'],
            'internal_reg' => $c['partner_hint_url'] ?: null,
            'created_at'   => ['raw' => 'NOW()'],
        ];
        $cols = [];
        $vals = [];
        foreach ($P['cols'] as $k => $col) {
            if ($col === null || !array_key_exists($k, $row)) {
                continue;
            }
            $cols[] = "`$col`";
            $vals[] = self::q($row[$k]);
        }

        $label = mb_substr(preg_replace('/\s+/', ' ', (string)($d['name'] ?? $c['domain'])) ?? '', 0, 80);
        $sql = ['-- ' . $label];
        $sql[] = "INSERT INTO `$pt` (" . implode(', ', $cols) . ') SELECT ' . implode(', ', $vals)
            . " FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `$pt` WHERE $siteMatch);";
        $sql[] = 'SET @new = ROW_COUNT();'; // 1 — продукт щойно створено; 0 — вже був (тоді зв'язки не чіпаємо)
        $sql[] = "SET @pid = (SELECT `$idCol` FROM `$pt` WHERE $siteMatch ORDER BY `$idCol` LIMIT 1);";

        $L = $map['links'];
        $S = $map['subcats'];
        $C = $map['cats'];
        $catNames = [];
        foreach ((array)($d['categories'] ?? []) as $labelCat) {
            [$cat, $sub] = Taxonomy::split((string)$labelCat);
            $catNames[$cat] = true;
            $sql[] = "INSERT INTO `{$L['table']}` (`{$L['product']}`, `{$L['subcat']}`) "
                . "SELECT @pid, s.`{$S['id']}` FROM `{$S['table']}` s JOIN `{$C['table']}` c ON c.`{$C['id']}` = s.`{$S['cat_id']}` "
                . "WHERE @new = 1 AND c.`{$C['name']}` = " . self::q($cat) . " AND s.`{$S['name']}` = " . self::q($sub) . ';';
        }
        // Зв'язок продукт ↔ категорія (як CRM: пише і product_categories, і product_subcategories).
        if (!empty($map['cat_links'])) {
            $CL = $map['cat_links'];
            foreach (array_keys($catNames) as $cat) {
                $sql[] = "INSERT IGNORE INTO `{$CL['table']}` (`{$CL['product']}`, `{$CL['cat']}`) "
                    . "SELECT @pid, c.`{$C['id']}` FROM `{$C['table']}` c WHERE @new = 1 AND c.`{$C['name']}` = " . self::q($cat) . ';';
            }
        }

        $PL = $map['plans'];
        foreach ((array)($d['pricing_plans'] ?? []) as $p) {
            $name = trim((string)($p['name'] ?? ''));
            if ($name === '') {
                continue;
            }
            $period = $v['period'][$p['period'] ?? ''] ?? ($p['period'] ?? null);
            if ($period === null) {
                continue; // період без відповідника в БД (ENUM) — план пропускаємо, а не ламаємо весь пакет
            }
            $hasPrice = isset($p['price']) && is_numeric($p['price']);
            $cur = trim((string)($p['currency'] ?? ''));
            $desc = trim((string)($p['description'] ?? ''));
            if ($PL['price_text']) {
                $price = $hasPrice ? rtrim(rtrim(number_format((float)$p['price'], 2, '.', ''), '0'), '.') . ($cur !== '' ? " $cur" : '')
                                   : (($p['period'] ?? '') === 'free' ? '0' : null);
            } else {
                // Безкоштовний план у БД = 0.00 (не NULL); NULL — «ціна за запитом».
                $price = $hasPrice ? (float)$p['price'] : ($period === 'free' ? 0 : null);
                if ($hasPrice && $cur !== '' && !in_array(strtoupper($cur), ['USD', '$'], true)) {
                    $desc = trim("Ціна в $cur. $desc");
                }
            }
            $sql[] = "INSERT INTO `{$PL['table']}` (`{$PL['product']}`, `{$PL['name']}`, `{$PL['price']}`, `{$PL['period']}`, `{$PL['description']}`) "
                . 'SELECT @pid, ' . implode(', ', [self::q($name), self::q($price), self::q($period), self::q($desc !== '' ? $desc : null)])
                . ' FROM DUAL WHERE @new = 1;';
        }
        return $sql;
    }
}
