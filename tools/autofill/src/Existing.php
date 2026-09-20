<?php
declare(strict_types=1);

/**
 * Завантаження CSV з уже наявними продуктами сайту (для антидубля та підрахунку "прогалин").
 * Колонки: name, website, subcategories  (subcategories — через "|", у форматі "Категорія › Підкатегорія")
 */
final class Existing
{
    public static function load(string $file): void
    {
        if ($file === '' || !is_file($file)) {
            throw new RuntimeException("Файл не знайдено: $file");
        }
        $h = fopen($file, 'r');
        $head = preg_replace('/^\xEF\xBB\xBF/', '', (string)fgets($h)) ?? '';
        $delim = substr_count($head, ';') > substr_count($head, ',') ? ';' : ',';
        $cols = array_map(fn($c) => strtolower(trim($c, " \t\"'")), str_getcsv(trim($head), $delim, '"', ''));
        $iName = array_search('name', $cols, true);
        $iSite = array_search('website', $cols, true);
        $iSub = array_search('subcategories', $cols, true);
        if ($iName === false || $iSite === false) {
            throw new RuntimeException('Потрібні колонки: name, website[, subcategories]');
        }

        $pdo = Db::pdo();
        $pdo->exec('DELETE FROM existing');
        $pdo->beginTransaction();
        $st = $pdo->prepare('INSERT OR REPLACE INTO existing(domain,name,name_norm,subcats) VALUES(?,?,?,?)');
        $n = 0;
        while (($r = fgetcsv($h, 0, $delim, '"', '')) !== false) {
            $site = trim((string)($r[$iSite] ?? ''));
            if ($site === '') {
                continue;
            }
            $k = Candidates::key($site);
            if (!$k) {
                continue;
            }
            $name = trim((string)($r[$iName] ?? ''));
            $subs = $iSub !== false ? trim((string)($r[$iSub] ?? '')) : '';
            $st->execute([$k[0], $name, norm_name($name), $subs]);
            $n++;
        }
        $pdo->commit();
        fclose($h);
        out("Завантажено існуючих продуктів: $n");
    }
}
