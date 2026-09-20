<?php
declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    exit("Тільки з командного рядка (php autofill.php help)\n");
}
require __DIR__ . '/src/bootstrap.php';

$args = parse_args($argv);
$cmd = (string)($args['_'][0] ?? 'help');
$opt = fn(string $k, $d = null) => (isset($args[$k]) && is_string($args[$k])) ? $args[$k] : $d;

try {
    switch ($cmd) {
        // --- Підготовка ---
        case 'load-existing':
            Existing::load((string)($args['_'][1] ?? ''));
            break;

        // --- Пошук кандидатів ---
        case 'discover:urls':
            Discover::urls((string)($args['_'][1] ?? ''), $opt('subcat'));
            break;
        case 'discover:ph':
            Discover::producthunt((int)$opt('pages', 5), (string)$opt('topic', 'artificial-intelligence'));
            break;
        case 'discover:gh':
            Discover::github((string)$opt('topic', 'ai-tools'), (int)$opt('min-stars', 500), (int)$opt('pages', 3));
            break;
        case 'discover:llm':
            Discover::llm($opt('subcat'), (int)$opt('n', 30), isset($args['gaps']));
            break;

        // --- Обробка ---
        case 'fetch':
            Fetcher::run((int)$opt('limit', 50));
            break;
        case 'enrich':
            Enricher::run((int)$opt('limit', 50));
            break;
        // Гібридний режим без API-ключа (див. src/Pack.php і README)
        case 'enrich:export':
            Pack::export((int)$opt('limit', 0), isset($args['redo']));
            break;
        case 'enrich:import':
            Pack::import((string)($args['_'][1] ?? ''));
            break;
        case 'validate':
            Validator::run();
            break;
        case 'run': // fetch → enrich → validate одним викликом
            $n = (int)$opt('limit', 50);
            Fetcher::run($n);
            Enricher::run($n);
            Validator::run();
            break;

        // --- Контроль якості ---
        case 'review':
            Validator::review((int)$opt('n', 20));
            break;
        case 'approve':
        case 'reject':
            Validator::mark($cmd, array_slice($args['_'], 1));
            break;
        case 'sample':
            Validator::sample((int)$opt('n', 10));
            break;
        case 'retry-errors':
            $n = Db::pdo()->exec("UPDATE candidates SET stage = CASE WHEN note LIKE 'fetch:%' THEN 'discovered' ELSE 'fetched' END, note = NULL WHERE stage = 'error'");
            out("Повернуто в чергу: $n");
            break;

        // --- Вихід ---
        case 'export':
            Exporter::run();
            break;
        case 'export-manual':
            Exporter::manual();
            break;

        // --- Огляд ---
        case 'stats':
            Stats::show();
            break;
        case 'gaps':
            Stats::gaps();
            break;

        default:
            echo <<<TXT
AI LAB HUB — автонаповнення каталогу

  load-existing <file.csv>        завантажити наявні продукти сайту (name,website,subcategories) для антидубля й "прогалин"
  gaps                            які підкатегорії ще нижче мінімуму

  discover:urls <file.txt> [--subcat "Кат › Підкат"]
  discover:llm --subcat "Кат › Підкат" [--n 30]   |   discover:llm --gaps
  discover:ph  [--pages 5] [--topic artificial-intelligence]
  discover:gh  [--topic ai-tools] [--min-stars 500] [--pages 3]

  fetch|enrich [--limit 50]       окремі кроки; validate — перевірка якості
  enrich:export [--limit 10] [--redo]   без API-ключа: пакет сторінок → export/enrich/pack_NNNN.json
  enrich:import <pack_NNNN.result.json> без API-ключа: прийняти картки, які написав Claude Code
  run [--limit 50]                fetch → enrich → validate
  review [--n 20]                 картки з сумнівами;  approve <id...> | reject <id...>
  sample [--n 10]                 вибірково перевірити валідні
  export                          SQL-пакети + zip логотипів у export/
  export-manual                   список для ручної обробки (заблоковані сайти, помилки)
  retry-errors | stats

TXT;
    }
} catch (Throwable $e) {
    fwrite(STDERR, 'ПОМИЛКА: ' . $e->getMessage() . PHP_EOL);
    exit(1);
}
