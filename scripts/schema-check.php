<?php

declare(strict_types=1);

/**
 * AI LAB HUB — перевірка схеми бази після пакета міграцій Marketplace (CLI, лише читання information_schema).
 *
 *   php scripts/schema-check.php --db=<схема>
 *        перевіряє, що в схемі є всі очікувані таблиці, стовпці (з типами) й індекси з database/schema-expected.json,
 *        і що база, усі таблиці й текстові стовпці мають колацію utf8mb4_unicode_ci. Код виходу 1 — є FAIL.
 *   php scripts/schema-check.php --write-expected --db=<еталон> --base-db=<основа>
 *        (для розробника) записує database/schema-expected.json: усе, чим <еталон> (основа + пакет) відрізняється від
 *        <основа> (база без пакета) — нові таблиці цілком і нові стовпці/індекси наявних таблиць.
 *
 * Підключення — з config/database.php (той самий користувач, що й у сайту; потрібен доступ до information_schema
 * вказаної схеми). Значень даних скрипт не читає.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

const COLLATION = 'utf8mb4_unicode_ci';
$root = dirname(__DIR__);
$expectedFile = $root . '/database/schema-expected.json';

$opt = ['db' => '', 'base-db' => '', 'write-expected' => false];
foreach (array_slice($argv, 1) as $a) {
    if ($a === '--write-expected') {
        $opt['write-expected'] = true;
    } elseif (preg_match('/^--(db|base-db)=(.+)$/', $a, $m) === 1) {
        $opt[$m[1]] = $m[2];
    }
}
if ($opt['db'] === '' || ($opt['write-expected'] && $opt['base-db'] === '')) {
    fwrite(STDERR, "Використання: php scripts/schema-check.php --db=<схема>\n"
        . "              php scripts/schema-check.php --write-expected --db=<еталон> --base-db=<основа>\n");
    exit(2);
}

/** @var PDO $pdo */
$pdo = require $root . '/config/database.php';

/** @return array{tables: array<string, array{collation:string, columns: array<string, array{type:string, collation:?string}>, indexes: array<string, string>}>} */
function read_schema(PDO $pdo, string $db): array
{
    $out = [];
    $st = $pdo->prepare('SELECT TABLE_NAME, TABLE_COLLATION FROM information_schema.TABLES WHERE TABLE_SCHEMA = ? AND TABLE_TYPE = \'BASE TABLE\'');
    $st->execute([$db]);
    foreach ($st->fetchAll(PDO::FETCH_NUM) as [$t, $c]) {
        $out[$t] = ['collation' => (string) $c, 'columns' => [], 'indexes' => []];
    }
    $st = $pdo->prepare('SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE, COLLATION_NAME FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = ? ORDER BY TABLE_NAME, ORDINAL_POSITION');
    $st->execute([$db]);
    foreach ($st->fetchAll(PDO::FETCH_NUM) as [$t, $col, $type, $coll]) {
        if (isset($out[$t])) {
            $out[$t]['columns'][$col] = ['type' => strtolower((string) $type), 'collation' => $coll];
        }
    }
    $st = $pdo->prepare('SELECT TABLE_NAME, INDEX_NAME, NON_UNIQUE, GROUP_CONCAT(COLUMN_NAME ORDER BY SEQ_IN_INDEX) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = ? GROUP BY TABLE_NAME, INDEX_NAME, NON_UNIQUE');
    $st->execute([$db]);
    foreach ($st->fetchAll(PDO::FETCH_NUM) as [$t, $idx, $nonUnique, $cols]) {
        if (isset($out[$t])) {
            $out[$t]['indexes'][$idx] = ((int) $nonUnique === 0 ? 'UNIQUE ' : '') . '(' . $cols . ')';
        }
    }
    ksort($out);
    return ['tables' => $out];
}

// ---------- запис еталона ----------
if ($opt['write-expected']) {
    $ref = read_schema($pdo, $opt['db'])['tables'];
    $base = read_schema($pdo, $opt['base-db'])['tables'];
    $exp = [];
    foreach ($ref as $t => $def) {
        if (!isset($base[$t])) {
            $exp[$t] = ['new' => true, 'columns' => array_map(static fn ($c) => $c['type'], $def['columns']), 'indexes' => $def['indexes']];
            continue;
        }
        $cols = array_diff_key($def['columns'], $base[$t]['columns']);
        $idx = array_diff_key($def['indexes'], $base[$t]['indexes']);
        if ($cols !== [] || $idx !== []) {
            $exp[$t] = ['new' => false, 'columns' => array_map(static fn ($c) => $c['type'], $cols), 'indexes' => $idx];
        }
    }
    $doc = [
        'comment' => 'Очікувана схема після hosting-upload/marketplace-ALL-04-28 (scripts/build-release-sql.php). Згенеровано scripts/schema-check.php --write-expected.',
        'generated' => date('Y-m-d H:i'),
        'collation' => COLLATION,
        'tables' => $exp,
    ];
    file_put_contents($expectedFile, json_encode($doc, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n");
    $nt = count(array_filter($exp, static fn ($e) => $e['new']));
    fwrite(STDOUT, sprintf("OK %s: нових таблиць %d, доповнених таблиць %d\n", 'database/schema-expected.json', $nt, count($exp) - $nt));
    exit(0);
}

// ---------- перевірка ----------
if (!is_file($expectedFile)) {
    fwrite(STDERR, "Немає database/schema-expected.json\n");
    exit(2);
}
$exp = json_decode((string) file_get_contents($expectedFile), true, 512, JSON_THROW_ON_ERROR);
$db = $opt['db'];
$have = read_schema($pdo, $db)['tables'];
$fails = [];
$warns = [];
$checked = ['tables' => 0, 'columns' => 0, 'indexes' => 0];

$st = $pdo->prepare('SELECT DEFAULT_COLLATION_NAME FROM information_schema.SCHEMATA WHERE SCHEMA_NAME = ?');
$st->execute([$db]);
$dbColl = $st->fetchColumn();
if ($dbColl === false) {
    fwrite(STDERR, "Схему {$db} не знайдено (або немає доступу до information_schema).\n");
    exit(2);
}
if ($dbColl !== COLLATION) {
    $warns[] = "колація бази за замовчуванням {$dbColl} (очікується " . COLLATION . '; нові таблиці пакета задають її явно)';
}

foreach ($exp['tables'] as $t => $def) {
    $checked['tables']++;
    if (!isset($have[$t])) {
        $fails[] = "немає таблиці {$t}";
        continue;
    }
    foreach ($def['columns'] as $col => $type) {
        $checked['columns']++;
        if (!isset($have[$t]['columns'][$col])) {
            $fails[] = "немає стовпця {$t}.{$col} ({$type})";
        } elseif ($have[$t]['columns'][$col]['type'] !== $type) {
            // int(10) unsigned (MySQL 5.7 / MariaDB) і int unsigned (MySQL 8) — те саме
            $norm = static fn (string $s): string => (string) preg_replace('/\b(tinyint|smallint|mediumint|int|bigint)\(\d+\)/', '$1', $s);
            if ($norm($have[$t]['columns'][$col]['type']) !== $norm($type)) {
                $fails[] = "{$t}.{$col}: тип {$have[$t]['columns'][$col]['type']}, очікується {$type}";
            }
        }
    }
    foreach ($def['indexes'] as $idx => $cols) {
        $checked['indexes']++;
        if (!isset($have[$t]['indexes'][$idx])) {
            $fails[] = "немає індексу {$t}.{$idx} {$cols}";
        } elseif ($have[$t]['indexes'][$idx] !== $cols) {
            $fails[] = "індекс {$t}.{$idx}: {$have[$t]['indexes'][$idx]}, очікується {$cols}";
        }
    }
}

// Колація: усі таблиці й текстові стовпці схеми (не лише пакета) — однакова utf8mb4_unicode_ci (інакше JOIN/порівняння
// рядків між таблицями дають «Illegal mix of collations»).
$badColl = [];
foreach ($have as $t => $def) {
    if ($def['collation'] !== COLLATION) {
        $badColl[] = "таблиця {$t}: {$def['collation']}";
    }
    foreach ($def['columns'] as $col => $c) {
        if ($c['collation'] !== null && $c['collation'] !== COLLATION) {
            $badColl[] = "{$t}.{$col}: {$c['collation']}";
        }
    }
}
foreach ($badColl as $b) {
    $fails[] = 'колація ' . $b;
}

fwrite(STDOUT, "schema-check {$db}: таблиць {$checked['tables']}, стовпців {$checked['columns']}, індексів {$checked['indexes']} з еталона; "
    . 'перевірено колацію ' . count($have) . " таблиць\n");
foreach ($warns as $w) {
    fwrite(STDOUT, "WARN {$w}\n");
}
foreach ($fails as $f) {
    fwrite(STDOUT, "FAIL {$f}\n");
}
fwrite(STDOUT, $fails === [] ? "PASS схема відповідає очікуваній, колація " . COLLATION . "\n" : 'Разом FAIL: ' . count($fails) . "\n");
exit($fails === [] ? 0 : 1);
