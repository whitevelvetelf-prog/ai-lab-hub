<?php
declare(strict_types=1);

/**
 * Джерела кандидатів. Кожне лише додає рядки в чергу (stage=discovered) — нічого не публікує.
 * Дублі відсікаються за доменом (і проти вже наявних на сайті через load-existing).
 */
final class Discover
{
    private static function counter(): array
    {
        return ['added' => 0, 'queued' => 0, 'exists' => 0, 'bad_url' => 0];
    }

    /** Файл: по рядку "https://site.com" або "Назва | https://site.com"; # — коментар. */
    public static function urls(string $file, ?string $subcat): void
    {
        if ($file === '' || !is_file($file)) {
            throw new RuntimeException("Файл не знайдено: $file");
        }
        $c = self::counter();
        foreach (file($file, FILE_IGNORE_NEW_LINES) ?: [] as $line) {
            $line = trim($line);
            if ($line === '' || $line[0] === '#') {
                continue;
            }
            $name = null;
            $url = $line;
            if (str_contains($line, '|')) {
                [$name, $url] = array_map('trim', explode('|', $line, 2));
            }
            $c[Candidates::add($url, $name, 'urls', $subcat)]++;
        }
        out('urls: ' . json_encode($c));
    }

    /** Product Hunt GraphQL API v2 (потрібен developer token; ПЕРЕВІР умови використання API для комерційного проєкту). */
    public static function producthunt(int $pages, string $topic): void
    {
        $token = (string)cfg('producthunt_token');
        if ($token === '') {
            throw new RuntimeException('Немає producthunt_token у config.php');
        }
        $q = 'query($after:String,$topic:String){posts(first:20,after:$after,order:VOTES,topic:$topic){'
           . 'pageInfo{hasNextPage endCursor} edges{node{name website}}}}';
        $after = null;
        $c = self::counter();
        for ($p = 0; $p < $pages; $p++) {
            $r = Http::postJson(
                'https://api.producthunt.com/v2/api/graphql',
                ['query' => $q, 'variables' => ['after' => $after, 'topic' => $topic]],
                ['authorization: Bearer ' . $token],
                40
            );
            $j = json_decode($r['body'], true);
            if ($r['status'] !== 200 || !isset($j['data']['posts']['edges'])) {
                out('PH помилка: HTTP ' . $r['status'] . ' ' . substr($r['body'], 0, 200));
                break;
            }
            foreach ($j['data']['posts']['edges'] as $e) {
                $n = $e['node'] ?? [];
                $u = Http::resolve((string)($n['website'] ?? ''));
                if ($u) {
                    $c[Candidates::add($u, $n['name'] ?? null, 'producthunt')]++;
                }
            }
            $pi = $j['data']['posts']['pageInfo'] ?? [];
            if (empty($pi['hasNextPage'])) {
                break;
            }
            $after = $pi['endCursor'];
            sleep(1);
        }
        out('producthunt: ' . json_encode($c));
    }

    /** GitHub Search API: репозиторії за topic із заповненим homepage (без homepage — не продукт). */
    public static function github(string $topic, int $minStars, int $pages): void
    {
        $h = ['accept: application/vnd.github+json'];
        if ($t = cfg('github_token')) {
            $h[] = 'authorization: Bearer ' . $t;
        }
        $c = self::counter();
        for ($p = 1; $p <= $pages; $p++) {
            $url = 'https://api.github.com/search/repositories?q=' . rawurlencode("topic:$topic stars:>$minStars")
                 . '&sort=stars&order=desc&per_page=100&page=' . $p;
            $r = Http::get($url, 30, $h);
            $j = json_decode($r['body'], true);
            if ($r['status'] !== 200 || !isset($j['items'])) {
                out('GitHub помилка: HTTP ' . $r['status']);
                break;
            }
            foreach ($j['items'] as $it) {
                $home = trim((string)($it['homepage'] ?? ''));
                if ($home === '' || !empty($it['archived']) || !empty($it['fork'])) {
                    continue;
                }
                $c[Candidates::add($home, (string)($it['name'] ?? ''), 'github')]++;
            }
            sleep(3);
        }
        out('github: ' . json_encode($c));
    }

    /**
     * Claude пропонує популярні продукти для підкатегорії. Довіри його URL немає:
     * кожен кандидат далі ПЕРЕВІРЯЄТЬСЯ живим запитом до сайту (Fetcher) і перевіркою "назва є на сайті" (Validator).
     */
    public static function llm(?string $subcat, int $n, bool $gaps): void
    {
        $min = (int)cfg('min_per_subcategory', 10);
        $targets = [];
        if ($gaps) {
            foreach (Stats::counts() as $s => $cnt) {
                if ($cnt < $min) {
                    $targets[$s] = max(15, ($min - $cnt) * 3); // із запасом на відсів
                }
            }
        } elseif ($subcat) {
            $targets[$subcat] = $n;
        } else {
            throw new RuntimeException('Вкажи --subcat "Категорія › Підкатегорія" або --gaps');
        }

        $tool = [
            'name' => 'list_products',
            'description' => 'Повернути перелік продуктів',
            'input_schema' => [
                'type' => 'object',
                'properties' => ['products' => [
                    'type' => 'array',
                    'items' => [
                        'type' => 'object',
                        'properties' => ['name' => ['type' => 'string'], 'url' => ['type' => 'string']],
                        'required' => ['name', 'url'],
                    ],
                ]],
                'required' => ['products'],
            ],
        ];
        $system = 'Ти допомагаєш наповнювати каталог цифрових продуктів, сервісів і інструментів. '
            . 'Називай лише реальні продукти, для яких ти впевнений в офіційній адресі сайту. Нічого не вигадуй: '
            . 'краще менше, але точно. Обирай різноманітно: і відомі, і нішеві; і платні, і безкоштовні/open-source; '
            . 'не лише з США. Не повторюй продукти зі списку "вже є".';

        $all = Taxonomy::all();
        foreach ($targets as $s => $need) {
            if (!in_array($s, $all, true)) {
                out("Невідома підкатегорія: $s");
                continue;
            }
            $st = Db::pdo()->prepare('SELECT name FROM existing WHERE subcats LIKE ? LIMIT 80');
            $st->execute(['%' . $s . '%']);
            $have = implode(', ', array_column($st->fetchAll(), 'name'));

            $resp = Http::claude([
                'model' => (string)cfg('model_discover'),
                'max_tokens' => 4000,
                'system' => $system,
                'tools' => [$tool],
                'tool_choice' => ['type' => 'tool', 'name' => 'list_products'],
                'messages' => [['role' => 'user', 'content' =>
                    "Підкатегорія каталогу: $s\nНазви до $need продуктів (назва + офіційний сайт).\nВже є: " . ($have ?: '—')]],
            ]);
            $c = self::counter();
            foreach (($resp['content'] ?? []) as $b) {
                if (($b['type'] ?? '') === 'tool_use') {
                    foreach (($b['input']['products'] ?? []) as $p) {
                        $c[Candidates::add((string)($p['url'] ?? ''), (string)($p['name'] ?? ''), 'llm', $s)]++;
                    }
                }
            }
            out("llm [$s]: " . json_encode($c, JSON_UNESCAPED_UNICODE));
        }
    }
}
