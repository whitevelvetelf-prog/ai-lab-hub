<?php
declare(strict_types=1);

final class Candidates
{
    /** Хости, де продукт визначається шляхом (github.com/owner/repo), а не доменом. */
    private const PATH_HOSTS = ['github.com', 'gitlab.com', 'huggingface.co'];

    /** Хости, які ніколи не є "офіційним сайтом продукту". */
    private const BLOCK_HOSTS = [
        'apps.apple.com', 'play.google.com', 'producthunt.com', 'twitter.com', 'x.com',
        'linkedin.com', 'facebook.com', 'instagram.com', 'youtube.com', 'youtu.be',
        'medium.com', 'reddit.com', 't.me', 'discord.gg', 'chromewebstore.google.com',
    ];

    /** @return array{0:string,1:string}|null  [ключ дедуплікації, канонічний URL] */
    public static function key(string $url): ?array
    {
        $url = trim($url);
        $p = parse_url($url);
        if (!$p || empty($p['host'])) {
            $p = parse_url('https://' . $url);
        }
        if (!$p || empty($p['host'])) {
            return null;
        }
        $host = preg_replace('/^www\./', '', strtolower($p['host'])) ?? '';
        if ($host === '' || !str_contains($host, '.')) {
            return null;
        }
        foreach (self::BLOCK_HOSTS as $b) {
            if ($host === $b || str_ends_with($host, '.' . $b)) {
                return null;
            }
        }
        $key = $host;
        $canon = 'https://' . $host . '/';
        if (in_array($host, self::PATH_HOSTS, true)) {
            $segs = array_values(array_filter(explode('/', (string)($p['path'] ?? ''))));
            if ($segs) {
                $n = ($host === 'huggingface.co' && in_array($segs[0], ['spaces', 'datasets'], true)) ? 3 : 2;
                $segs = array_slice($segs, 0, $n);
                $key = $host . '/' . implode('/', $segs);
                $canon = 'https://' . $key;
            }
        }
        return [$key, $canon];
    }

    /** @return string added|queued|exists|bad_url */
    public static function add(string $url, ?string $name, string $source, ?string $subcat = null): string
    {
        $k = self::key($url);
        if (!$k) {
            return 'bad_url';
        }
        $pdo = Db::pdo();
        $e = $pdo->prepare('SELECT 1 FROM existing WHERE domain = ?');
        $e->execute([$k[0]]);
        if ($e->fetchColumn()) {
            return 'exists';
        }
        $st = $pdo->prepare('INSERT OR IGNORE INTO candidates(domain,url,name_hint,source,target_subcat) VALUES(?,?,?,?,?)');
        $st->execute([$k[0], $k[1], $name, $source, $subcat]);
        return $st->rowCount() > 0 ? 'added' : 'queued';
    }
}
