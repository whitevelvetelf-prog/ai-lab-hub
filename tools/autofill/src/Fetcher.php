<?php
declare(strict_types=1);

/**
 * Стадія discovered → fetched. Завантажує головну (+сторінку цін), витягує метадані/текст,
 * шукає ПІДКАЗКУ про партнерську програму (лише посилання — реєстрація завжди вручну), збирає логотип.
 */
final class Fetcher
{
    public static function pagePath(int $id): string
    {
        return cfg('paths.data') . "/pages/$id.json";
    }

    public static function run(int $limit): void
    {
        $st = Db::pdo()->prepare("SELECT * FROM candidates WHERE stage='discovered' ORDER BY id LIMIT ?");
        $st->bindValue(1, $limit, PDO::PARAM_INT);
        $st->execute();
        $rows = $st->fetchAll();
        out('Fetch: ' . count($rows) . ' сайтів');
        foreach ($rows as $r) {
            try {
                self::one($r);
            } catch (Throwable $e) {
                self::set((int)$r['id'], 'error', 'fetch: ' . $e->getMessage());
            }
            usleep((int)cfg('fetch_delay_ms', 1500) * 1000);
        }
    }

    private static function set(int $id, string $stage, ?string $note = null, array $extra = []): void
    {
        $allowed = ['url', 'partner_hint_url', 'logo_file'];
        $sets = ['stage = ?', 'note = ?', 'updated_at = CURRENT_TIMESTAMP'];
        $vals = [$stage, $note];
        foreach ($extra as $k => $v) {
            if (in_array($k, $allowed, true)) {
                $sets[] = "$k = ?";
                $vals[] = $v;
            }
        }
        $vals[] = $id;
        Db::pdo()->prepare('UPDATE candidates SET ' . implode(', ', $sets) . ' WHERE id = ?')->execute($vals);
    }

    private static function one(array $r): void
    {
        $id = (int)$r['id'];
        if (!Robots::allowed($r['url'])) {
            self::set($id, 'rejected', 'robots');
            return;
        }
        $res = Http::get($r['url']);
        $code = $res['status'];
        if ($code === 0) {
            self::set($id, 'rejected', 'unreachable: ' . $res['error']);
            return;
        }
        if (in_array($code, [401, 403, 429, 503], true)) {
            self::set($id, 'manual', "blocked_$code"); // сайт не пускає ботів — вручну
            return;
        }
        if ($code >= 400) {
            self::set($id, 'rejected', "http_$code");
            return;
        }
        if (stripos($res['ctype'], 'html') === false && !str_contains(substr($res['body'], 0, 500), '<')) {
            self::set($id, 'rejected', 'not_html');
            return;
        }

        $page = self::extract($res['body'], $res['url'], (int)cfg('text_chars_home', 7000));
        if ($page['text_len'] < 600 && preg_match('/domain (is )?for sale|buy this domain|this domain (is|may be) for sale|domain parking/i', $res['body'])) {
            self::set($id, 'rejected', 'parked_domain');
            return;
        }
        if ($page['text_len'] < 250 && $page['meta_description'] === '') {
            self::set($id, 'manual', 'no_content (ймовірно SPA/порожня сторінка)');
            return;
        }
        $page['thin'] = $page['text_len'] < 500;

        $page['pricing_text'] = '';
        if ($page['pricing_url'] !== '' && Robots::allowed($page['pricing_url'])) {
            usleep((int)cfg('fetch_delay_ms', 1500) * 1000);
            $pr = Http::get($page['pricing_url']);
            if ($pr['status'] === 200) {
                $pp = self::extract($pr['body'], $pr['url'], (int)cfg('text_chars_pricing', 5000));
                $page['pricing_text'] = $pp['text'];
            }
        }

        $logo = self::logo($id, $page['icons']);

        $dir = dirname(self::pagePath($id));
        if (!is_dir($dir)) {
            mkdir($dir, 0777, true);
        }
        file_put_contents(self::pagePath($id), json_encode($page, JSON_UNESCAPED_UNICODE));

        $k = Candidates::key($res['url']);
        self::set($id, 'fetched', null, [
            'url' => $k ? $k[1] : $r['url'],
            'partner_hint_url' => $page['partner_url'] !== '' ? $page['partner_url'] : null,
            'logo_file' => $logo,
        ]);
    }

    private static function extract(string $html, string $base, int $limit): array
    {
        $enc = mb_detect_encoding($html, ['UTF-8', 'Windows-1251', 'ISO-8859-1'], true) ?: 'UTF-8';
        if ($enc !== 'UTF-8') {
            $html = mb_convert_encoding($html, 'UTF-8', $enc);
        }
        // пробіл перед блочними тегами, щоб мінімізований HTML не склеював слова
        $html = preg_replace('/<(\/?)(p|div|h[1-6]|li|br|section|article|tr|td|th|button|a)\b/i', ' <$1$2', $html) ?? $html;

        libxml_use_internal_errors(true);
        $dom = new DOMDocument();
        $dom->loadHTML('<?xml encoding="utf-8" ?>' . $html, LIBXML_NOWARNING | LIBXML_NOERROR);
        libxml_clear_errors();
        $xp = new DOMXPath($dom);

        $attr = function (string $q, string $a = 'content') use ($xp): string {
            $n = $xp->query($q)->item(0);
            return $n instanceof DOMElement ? trim($n->getAttribute($a)) : '';
        };
        $titleNode = $xp->query('//title')->item(0);
        $page = [
            'title'            => $titleNode ? trim(preg_replace('/\s+/u', ' ', $titleNode->textContent) ?? '') : '',
            'meta_description' => $attr('//meta[@name="description"]') ?: $attr('//meta[@property="og:description"]'),
            'og_title'         => $attr('//meta[@property="og:title"]'),
            'site_name'        => $attr('//meta[@property="og:site_name"]'),
            'lang'             => $attr('//html', 'lang'),
        ];

        // Посилання збираємо ДО видалення nav/footer (там зазвичай і ціни, і партнерка)
        $links = [];
        foreach ($xp->query('//a[@href]') as $a) {
            $t = trim(preg_replace('/\s+/u', ' ', $a->textContent) ?? '');
            $links[] = [mb_substr($t, 0, 80), (string)$a->getAttribute('href')];
        }

        $icons = [];
        foreach ($xp->query('//link[@rel][@href]') as $l) {
            $rel = strtolower($l->getAttribute('rel'));
            if (!str_contains($rel, 'icon')) {
                continue;
            }
            $href = abs_url($base, $l->getAttribute('href'));
            if (!$href || preg_match('/\.svg(\?|$)/i', $href) || str_contains(strtolower($l->getAttribute('type')), 'svg')) {
                continue;
            }
            $sz = preg_match('/(\d+)x\d+/', $l->getAttribute('sizes'), $m) ? (int)$m[1] : 0;
            $icons[] = ['url' => $href, 'apple' => str_contains($rel, 'apple') ? 1 : 0, 'size' => $sz];
        }
        usort($icons, fn($a, $b) => [$b['apple'], $b['size']] <=> [$a['apple'], $a['size']]);
        $iconUrls = array_column($icons, 'url');
        $bp = parse_url($base);
        if ($bp && !empty($bp['host'])) {
            $iconUrls[] = ($bp['scheme'] ?? 'https') . '://' . $bp['host'] . '/favicon.ico';
        }
        $page['icons'] = array_values(array_unique($iconUrls));

        // Аналіз посилань: ціни, партнерка, платформи
        $pricing = '';
        $partner = '';
        $mobile = false;
        $desktop = false;
        $baseHost = host_of($base);
        foreach ($links as [$t, $h]) {
            $abs = abs_url($base, $h);
            if (!$abs) {
                continue;
            }
            $path = (string)parse_url($abs, PHP_URL_PATH);
            if (preg_match('#apps\.apple\.com|play\.google\.com/store#i', $abs)) {
                $mobile = true;
            }
            if (preg_match('/\.(dmg|exe|msi|pkg|appimage)(\?|$)/i', $abs)
                || (preg_match('#/download#i', $path) && preg_match('/download|завантаж/iu', $t))) {
                $desktop = true;
            }
            if (host_of($abs) === $baseHost
                && (preg_match('/pricing|plans|tarif|prices?\b/i', $path)
                    || preg_match('/^(pricing|plans?( (&|and) pricing)?|prices?|тариф\w*|ціни|вартість)$/iu', $t))) {
                if ($pricing === '' || strlen($path) < strlen((string)parse_url($pricing, PHP_URL_PATH))) {
                    $pricing = $abs;
                }
            }
            if ($partner === ''
                && (preg_match('/affiliate|referral|refer-a|partner-?program|ambassador|partnerstack|shareasale|rewardful/i', $abs)
                    || preg_match('/affiliate|referral|partner program|refer a friend|earn commission|ambassador/i', $t))) {
                $partner = $abs;
            }
        }
        $page['pricing_url'] = $pricing;
        $page['partner_url'] = $partner;
        $page['mobile'] = $mobile;
        $page['desktop'] = $desktop;

        foreach ($xp->query('//script|//style|//noscript|//svg|//iframe|//nav|//footer|//template') as $n) {
            if ($n->parentNode) {
                $n->parentNode->removeChild($n);
            }
        }
        $root = $xp->query('//body')->item(0) ?? $dom->documentElement;
        $text = trim(preg_replace('/\s+/u', ' ', $root ? $root->textContent : '') ?? '');
        $page['text_len'] = mb_strlen($text);
        $page['text'] = mb_substr($text, 0, $limit);
        return $page;
    }

    private static function logo(int $id, array $icons): ?string
    {
        if (!function_exists('imagecreatefromstring')) {
            return null; // немає GD — логотипи додасте вручну через CRM-форму
        }
        $dir = cfg('paths.data') . '/logos';
        if (!is_dir($dir)) {
            mkdir($dir, 0777, true);
        }
        foreach (array_slice($icons, 0, 3) as $u) {
            $r = Http::get($u, 10, ['accept: image/*,*/*;q=0.5'], 1500000);
            if ($r['status'] !== 200 || $r['body'] === '') {
                continue;
            }
            $ext = self::saveLogo($r['body'], "$dir/$id");
            if ($ext) {
                return "$id.$ext";
            }
        }
        return null;
    }

    private static function saveLogo(string $bin, string $destNoExt): ?string
    {
        $im = @imagecreatefromstring($bin);
        if (!$im) {
            return null;
        }
        $w = imagesx($im);
        $h = imagesy($im);
        if (min($w, $h) < 48) {
            imagedestroy($im);
            return null; // занадто дрібна іконка (favicon 16×16) — краще без лого, ніж розмите
        }
        $s = min(1.0, 256 / max($w, $h));
        $nw = max(1, (int)round($w * $s));
        $nh = max(1, (int)round($h * $s));
        $dst = imagecreatetruecolor($nw, $nh);
        imagealphablending($dst, false);
        imagesavealpha($dst, true);
        imagefill($dst, 0, 0, imagecolorallocatealpha($dst, 0, 0, 0, 127));
        imagecopyresampled($dst, $im, 0, 0, 0, 0, $nw, $nh, $w, $h);

        $ok = false;
        $ext = 'png';
        if (function_exists('imagewebp')) {
            $ok = imagewebp($dst, "$destNoExt.webp", 85);
            $ext = 'webp';
        }
        if (!$ok) {
            $ok = imagepng($dst, "$destNoExt.png");
            $ext = 'png';
        }
        imagedestroy($im);
        imagedestroy($dst);
        return $ok ? $ext : null;
    }
}
