<?php
declare(strict_types=1);

/**
 * Стадія enriched → valid | review | rejected.
 * valid  — пройшла всі перевірки, можна в експорт і публікацію (за вашим правилом автостатусу).
 * review — є сумніви (причини в note): дивитись очима (команда review / approve / reject).
 */
final class Validator
{
    public static function run(): void
    {
        $pdo = Db::pdo();
        $rows = $pdo->query("SELECT * FROM candidates WHERE stage='enriched'")->fetchAll();
        $tax = array_flip(Taxonomy::all());
        $up = $pdo->prepare('UPDATE candidates SET stage=?, note=?, updated_at=CURRENT_TIMESTAMP WHERE id=?');
        $c = ['valid' => 0, 'review' => 0, 'rejected' => 0];
        foreach ($rows as $r) {
            [$stage, $note] = self::check($r, $tax);
            $up->execute([$stage, $note, $r['id']]);
            $c[$stage]++;
        }
        out('Validate: ' . json_encode($c));
    }

    /** @return array{0:string,1:?string} */
    private static function check(array $r, array $tax): array
    {
        $d = json_decode((string)$r['data_json'], true);
        if (!is_array($d)) {
            return ['rejected', 'bad_json'];
        }
        $raw = @file_get_contents(Fetcher::pagePath((int)$r['id']));
        $page = $raw ? (json_decode($raw, true) ?: []) : [];

        $name = trim((string)($d['name'] ?? ''));
        $short = trim((string)($d['short_description'] ?? ''));
        $full = trim((string)($d['full_description'] ?? ''));
        $cats = array_values(array_filter((array)($d['categories'] ?? []), fn($c) => isset($tax[$c])));
        if ($name === '' || $short === '' || !$cats) {
            return ['rejected', 'missing_required'];
        }

        $issues = [];
        $len = mb_strlen($short);
        if ($len < 80 || $len > 500) {
            $issues[] = "short_len_$len";
        }
        if (mb_strlen($full) < 300) {
            $issues[] = 'full_too_short';
        }
        if (cyr_ratio($short . ' ' . $full) < 0.55) {
            $issues[] = 'not_ukrainian';
        }
        if (preg_match('/найкращ|№\s?1|номер один|рейтинг|топ-?\d|революційн/iu', $short . ' ' . $full)) {
            $issues[] = 'superlatives';
        }
        if ((float)($d['confidence'] ?? 0) < (float)cfg('min_confidence', 0.6)) {
            $issues[] = 'low_confidence';
        }
        if (!empty($page['thin'])) {
            $issues[] = 'thin_content';
        }

        // Захист від галюцинованих URL / не того сайту: назва має зустрічатись на сторінці
        $hay = norm_name(($page['title'] ?? '') . ' ' . ($page['og_title'] ?? '') . ' ' . ($page['site_name'] ?? '')
            . ' ' . ($page['text'] ?? '') . ' ' . $r['domain']);
        $need = norm_name($name);
        if (strlen($need) >= 3 && !str_contains($hay, $need)) {
            $issues[] = 'name_not_on_site';
        }

        // Антидубль за назвою (за доменом відсіяно ще при додаванні)
        $st = Db::pdo()->prepare("SELECT 1 FROM existing WHERE name_norm = ? AND name_norm <> ''");
        $st->execute([norm_name($name)]);
        if ($st->fetchColumn()) {
            $issues[] = 'dup_name';
        }

        $plans = (array)($d['pricing_plans'] ?? []);
        if (count($plans) > 8) {
            $issues[] = 'too_many_plans';
        }
        foreach ($plans as $p) {
            if (isset($p['price']) && is_numeric($p['price']) && (float)$p['price'] < 0) {
                $issues[] = 'bad_price';
                break;
            }
        }

        return $issues ? ['review', implode(',', $issues)] : ['valid', null];
    }

    public static function review(int $n): void
    {
        $st = Db::pdo()->prepare("SELECT * FROM candidates WHERE stage='review' ORDER BY id LIMIT ?");
        $st->bindValue(1, $n, PDO::PARAM_INT);
        $st->execute();
        foreach ($st->fetchAll() as $r) {
            $d = json_decode((string)$r['data_json'], true) ?: [];
            echo "#{$r['id']}  {$r['url']}\n  назва: " . ($d['name'] ?? '?') . "\n  причини: {$r['note']}\n  "
                . mb_substr((string)($d['short_description'] ?? ''), 0, 200) . "\n\n";
        }
        out('Далі: approve <id...> або reject <id...>');
    }

    public static function sample(int $n): void
    {
        $st = Db::pdo()->prepare("SELECT * FROM candidates WHERE stage='valid' ORDER BY RANDOM() LIMIT ?");
        $st->bindValue(1, $n, PDO::PARAM_INT);
        $st->execute();
        foreach ($st->fetchAll() as $r) {
            $d = json_decode((string)$r['data_json'], true) ?: [];
            echo "#{$r['id']}  {$r['url']}\n  " . ($d['name'] ?? '?') . ' | ' . implode('; ', (array)($d['categories'] ?? [])) . "\n  "
                . ($d['short_description'] ?? '') . "\n  ціни: " . count((array)($d['pricing_plans'] ?? [])) . " плани\n\n";
        }
    }

    /** approve → valid; reject → rejected */
    public static function mark(string $action, array $ids): void
    {
        $stage = $action === 'approve' ? 'valid' : 'rejected';
        $note = $action === 'approve' ? 'approved_manually' : 'rejected_manually';
        $st = Db::pdo()->prepare('UPDATE candidates SET stage=?, note=?, updated_at=CURRENT_TIMESTAMP WHERE id=?');
        $n = 0;
        foreach ($ids as $id) {
            if (ctype_digit((string)$id)) {
                $st->execute([$stage, $note, (int)$id]);
                $n += $st->rowCount();
            }
        }
        out("$action: $n");
    }
}
